# Determine population ancestry from DNAm arrays

#### Sean K. Maden

#### 30 October, 2025

* [Obtain the `GLINT` software](#obtain-the-glint-software)
* [Virtual environment setup](#virtual-environment-setup)
* [Process example DNAm array data](#process-example-dnam-array-data)
* [Further reading](#further-reading)
* [Session Info](#session-info)
* [Works Cited](#works-cited)

This notebook describes how to obtain the `GLINT` software suite for DNAm analysis, and how to run `GLINT` with the `EPISTRUCTURE` method for inferring population genetic ancestry/descent from HM450K DNAm array probes. These command line tools are called using a conda virtual environment managed from an R session with the `basilisk` Bioconductor package. Code in this notebook should work for Mac and Linux-like environments. Consult Rahmani et al. (2017) for more details about the `EPISTRUCTURE` method.

# Obtain the `GLINT` software

First, obtain the latest version of `GLINT` online by downloading the [source](https://github.com/cozygene/glint/releases) from GitHub.

Also ensure the `basilisk` Bioconductor/R package is installed. We’ll use this to conveniently manage conda virtual environments to run `GLINT` from an R session.

```
BiocManager::install("basilisk")
library(basilisk)
```

# Virtual environment setup

Next, set up a virtual environment using conda. This step is crucial for reproducible research, as it enables control over which software versions to use in a session. This enables running software that is older or no longer maintained, a fairly common task in computational sciences.

Using `basilisk`, set up a Python 2 environment with seven dependencies (`numpy`, `pandas`, `scipy`, `scikit-learn`, `matplotlib`, `statsmodels`, and `cvxopt`) for which we specify the version using the form “packagename==version” (e.g. “numpy==1.15”).

```
env.name <- "glint_env"          # name the new virtual environment
pkg.name <- "recountmethylation" # set env properties
pkgv <- c("python==2.7",         # python version (v2.7)
          "numpy==1.15",         # numpy version (v1.15)
          "pandas==0.22",        # pandas version (v0.22)
          "scipy==1.2",          # scipy version (v1.2)
          "scikit-learn==0.19",  # scikit-learn (v0.19)
          "matplotlib==2.2",     # matplotlib (v2.2)
          "statsmodels==0.9",    # statsmodels (v0.9)
          "cvxopt==1.2")         # cvxopt (v1.2)
glint_env <- BasiliskEnvironment(envname = env.name, pkgname = pkg.name,
                                 packages = pkgv)
proc <- basiliskStart(glint_env) # define run process
on.exit(basiliskStop(proc))      # define exit process
```

This makes a `BasiliskEnvironment` object, `glint_env`, with a starting process called `proc` and a session end process specified with `on.exit()`.

# Process example DNAm array data

This section shows how to run `GLINT` on an example dataset, with the `EPISTRUCTURE` method enabled. It includes info about the required data formats and shows how to adjust for covariates.

To run `GLINT` on DNAm array stored as a `SummarizedExperiment` object, first access the test HM450K `MethylSet` from the `minfiData` package.

```
library(minfiData)
ms <- get(data("MsetEx")) # load example MethylSet
```

Now load the explanatory CpG probe vector for `EPISTRUCTURE`. This small subset of 4,913 HM450K array probes was found by Rahmani et al. (2017) to be strongly correlated with SNPs informing population ancestry and genetic structure. Access them from `recountmethylation` as follows.

```
dpath <- system.file("extdata", "glint_files",
                     package = "recountmethylation") # get the dir path
cgv.fpath <- file.path(dpath, "glint_epistructure_explanatory-cpgs.rda")
glint.cgv <- get(load(cgv.fpath)) # load explanatory probes
```

Subset `ms`, a `MethylSet`, to include just the 4,913 explanatory probes. This will save considerable disk space and memory for processing very large datasets.

```
mf <- ms[rownames(ms) %in% glint.cgv,] # filter ms on explanatory probes
dim(mf)                                # mf dimensions: [1] 4913    6
```

Next, identify desired model covariates from sample metadata, then convert to numeric/float format (required by `GLINT`). Specify the variables “age” and “sex” corresponding to columns in the file `covariates_minfidata.txt`.

```
# get covar -- all vars should be numeric/float
covar <- as.data.frame(colData(mf)[,c("age", "sex")]) # get sample metadata
covar[,"sex"] <- ifelse(covar[,"sex"] == "M", 1, 0)   # relabel sex for glint
# write covariates matrix
covar.fpath <- file.path("covariates_minfidata.txt")  # specify covariate table path
# write table colnames, values
write.table(covar, file = covar.fpath, sep = "\t", row.names = T,
            col.names = T, append = F, quote = F)     # write covariates table
```

Now calculate the DNAm fractoins or “Beta-values”. Impute any missing values with row medians, and write the final file to `bval_minfidata.txt`.

```
bval.fpath <- file.path("bval_minfidata.txt")     # specify dnam fractions table name
mbval <- t(apply(as.matrix(getBeta(mf)),1,function(ri){
  ri[is.na(ri)] <- median(ri,na.rm=T)             # impute na's with row medians
  return(round(ri, 4))
})); rownames(mbval) <- rownames(mf)              # assign probe ids to row names
write.table(mbval, file = bval.fpath, sep = sepsym,
            row.names = T, col.names = T, append = F,
            quote = F)                            # write dnam fractions table
```

Next, set the system commands to make command line calls from R. Define these manually as strings to be passed to the `system()` function, specifying the paths to the new `minfiData` example files.

```
glint.dpath <- "glint-1.0.4"                         # path to the main glint app dir
glint.pypath <- file.path(glint.dpath, "glint.py")   # path to the glint .py script
data.fpath <- file.path("bval_minfidata.txt")        # path to the DNAm data table
covar.fpath <- file.path("covariates_minfidata.txt") # path to the metadata table
out.fstr <- file.path("glint_results_minfidata")     # base string for ouput results files
covarv <- c("age", "sex")                            # vector of valid covariates
covar.str <- paste0(covarv, collapse = " ")          # format the covariates vector
cmd.str <- paste0(c("python", glint.pypath,
                    "--datafile", data.fpath,
                    "--covarfile", covar.fpath,
                    "--covar", covar.str,
                    "--epi", "--out", out.fstr),
                  collapse = " ")                    # get the final command line call
```

The commands stored as `cmd.str` include the path to the latest `GLINT` version, `glint.path`, the paths to the `datafile.txt` and `covariates.txt` tutorial files, the variable names `age` and `gender` which are our covariates of interest and correspond to column names in `covariates.txt`. We also used the `--epi` flag to ensure the `EPISTRUCTURE` method is run.

Now run `GLINT` with `basiliskRun()`. This should relay system outputs back to our console, which are included as comments in the below code chunk.

```
basiliskRun(proc, function(cmd.str){system(cmd.str)}, cmd.str = cmd.str) # run glint
# this returns:
# INFO      >>> python glint-1.0.4/glint.py --datafile bval_minfidata.txt --covarfile covariates_minfidata.txt --covar age sex --epi --out glint_results_minfidata
# INFO      Starting GLINT...
# INFO      Validating arguments...
# INFO      Loading file bval_minfidata.txt...
# INFO      Checking for missing values in the data file...
# INFO      Validating covariates file...
# INFO      Loading file covariates_minfidata.txt...
# INFO      New covariates were found: age, sex.
# INFO      Running EPISTRUCTURE...
# INFO      Removing non-informative sites...
# INFO      Including sites...
# INFO      Include sites: 4913 CpGs from the reference list of 4913 CpGs will be included...
# WARNING   Found no sites to exclude.
# INFO      Using covariates age, sex.
# INFO      Regressing out covariates...
# INFO      Running PCA...
# INFO      The first 1 PCs were saved to glint_results_minfidata.epistructure.pcs.txt.
# INFO      Added covariates epi1.
# Validating all dependencies are installed...
# All dependencies are installed
# [1] 0
```

Since we declared `--out glint_results_minfidata`, results files are saved with the beginning string “glint\_results\_minfidata” appended. Logs were saved to the file with the `*.glint.log` extension, while data were saved to the file with the `*.epistructure.pcs.txt` extension.

Now inspect the output results data file `glint_results_minfidata.epistructure.pcs.txt`.

```
out.fpath <- paste0(out.fpath, ".epistructure.pcs.txt")
res2 <- read.table(out.fpath, sep = "\t")
```

```
colnames(res2) <- c("sample", "epistructure.pc")
dim(res2)
```

```
## [1] 6 2
```

```
res2
```

The first results column reflects sample IDs from the columns in `bval_minfidata.txt`. Remaining columns show the `EPISTRUCTURE` population components. While just one population component calculated in this example, experiment datasets may generate outputs with more than one population component and thus several component columns.

# Further reading

For more details about `GLINT`, see the software [documentation](https://glint-epigenetics.readthedocs.io/en/latest/) and GitHub [repo](https://github.com/cozygene/glint). Additional [tutorial files](https://github.com/cozygene/glint/releases) are also available.

Consult Rahmani et al. (2017) for more details about the `EPISTRUCTURE` method, including the discovery of explanatory CpG probes associated with population structure SNPs.

For more details about setting up virtual environments from R, consult the `basilisk` package [documentation](https://www.bioconductor.org/packages/release/bioc/html/basilisk.html).

# Session Info

```
utils::sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] limma_3.66.0
##  [2] gridExtra_2.3
##  [3] knitr_1.50
##  [4] recountmethylation_1.20.0
##  [5] HDF5Array_1.38.0
##  [6] h5mread_1.2.0
##  [7] rhdf5_2.54.0
##  [8] DelayedArray_0.36.0
##  [9] SparseArray_1.10.0
## [10] S4Arrays_1.10.0
## [11] abind_1.4-8
## [12] Matrix_1.7-4
## [13] ggplot2_4.0.0
## [14] minfiDataEPIC_1.35.0
## [15] IlluminaHumanMethylationEPICanno.ilm10b2.hg19_0.6.0
## [16] IlluminaHumanMethylationEPICmanifest_0.3.0
## [17] minfiData_0.55.0
## [18] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
## [19] IlluminaHumanMethylation450kmanifest_0.4.0
## [20] minfi_1.56.0
## [21] bumphunter_1.52.0
## [22] locfit_1.5-9.12
## [23] iterators_1.0.14
## [24] foreach_1.5.2
## [25] Biostrings_2.78.0
## [26] XVector_0.50.0
## [27] SummarizedExperiment_1.40.0
## [28] Biobase_2.70.0
## [29] MatrixGenerics_1.22.0
## [30] matrixStats_1.5.0
## [31] GenomicRanges_1.62.0
## [32] Seqinfo_1.0.0
## [33] IRanges_2.44.0
## [34] S4Vectors_0.48.0
## [35] BiocGenerics_0.56.0
## [36] generics_0.1.4
## [37] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
##   [3] magrittr_2.0.4            magick_2.9.0
##   [5] GenomicFeatures_1.62.0    farver_2.1.2
##   [7] rmarkdown_2.30            BiocIO_1.20.0
##   [9] vctrs_0.6.5               multtest_2.66.0
##  [11] memoise_2.0.1             Rsamtools_2.26.0
##  [13] DelayedMatrixStats_1.32.0 RCurl_1.98-1.17
##  [15] askpass_1.2.1             tinytex_0.57
##  [17] htmltools_0.5.8.1         curl_7.0.0
##  [19] Rhdf5lib_1.32.0           sass_0.4.10
##  [21] nor1mix_1.3-3             bslib_0.9.0
##  [23] plyr_1.8.9                cachem_1.1.0
##  [25] GenomicAlignments_1.46.0  lifecycle_1.0.4
##  [27] pkgconfig_2.0.3           R6_2.6.1
##  [29] fastmap_1.2.0             digest_0.6.37
##  [31] siggenes_1.84.0           reshape_0.8.10
##  [33] AnnotationDbi_1.72.0      RSQLite_2.4.3
##  [35] base64_2.0.2              labeling_0.4.3
##  [37] httr_1.4.7                compiler_4.5.1
##  [39] beanplot_1.3.1            rngtools_1.5.2
##  [41] withr_3.0.2               bit64_4.6.0-1
##  [43] S7_0.2.0                  BiocParallel_1.44.0
##  [45] DBI_1.2.3                 MASS_7.3-65
##  [47] openssl_2.3.4             rjson_0.2.23
##  [49] tools_4.5.1               rentrez_1.2.4
##  [51] glue_1.8.0                quadprog_1.5-8
##  [53] restfulr_0.0.16           nlme_3.1-168
##  [55] rhdf5filters_1.22.0       grid_4.5.1
##  [57] gtable_0.3.6              tzdb_0.5.0
##  [59] preprocessCore_1.72.0     tidyr_1.3.1
##  [61] data.table_1.17.8         hms_1.1.4
##  [63] xml2_1.4.1                pillar_1.11.1
##  [65] genefilter_1.92.0         splines_4.5.1
##  [67] dplyr_1.1.4               lattice_0.22-7
##  [69] survival_3.8-3            rtracklayer_1.70.0
##  [71] bit_4.6.0                 GEOquery_2.78.0
##  [73] annotate_1.88.0           tidyselect_1.2.1
##  [75] bookdown_0.45             xfun_0.53
##  [77] scrime_1.3.5              statmod_1.5.1
##  [79] yaml_2.3.10               evaluate_1.0.5
##  [81] codetools_0.2-20          cigarillo_1.0.0
##  [83] tibble_3.3.0              BiocManager_1.30.26
##  [85] cli_3.6.5                 xtable_1.8-4
##  [87] jquerylib_0.1.4           dichromat_2.0-0.1
##  [89] Rcpp_1.1.0                png_0.1-8
##  [91] XML_3.99-0.19             readr_2.1.5
##  [93] blob_1.2.4                mclust_6.1.1
##  [95] doRNG_1.8.6.2             sparseMatrixStats_1.22.0
##  [97] bitops_1.0-9              scales_1.4.0
##  [99] illuminaio_0.52.0         purrr_1.1.0
## [101] crayon_1.5.3              rlang_1.1.6
## [103] KEGGREST_1.50.0
```

# Works Cited

Rahmani, Elior, Liat Shenhav, Regev Schweiger, Paul Yousefi, Karen Huen, Brenda Eskenazi, Celeste Eng, et al. 2017. “Genome-Wide Methylation Data Mirror Ancestry Information.” *Epigenetics & Chromatin* 10 (1): 1. <https://doi.org/10.1186/s13072-016-0108-y>.