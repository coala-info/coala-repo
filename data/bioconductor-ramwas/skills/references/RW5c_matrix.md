# Analyzing Data from Other Methylation Platforms or Data Types

#### 2025-10-30

# Contents

* [1 Using RaMWAS with other methylation platforms or data types](#using-ramwas-with-other-methylation-platforms-or-data-types)
  + [1.1 Import data from other sources](#import-data-from-other-sources)
  + [1.2 Principal Component Analysis (PCA)](#principal-component-analysis-pca)
  + [1.3 PCA with batch regressed out](#pca-with-batch-regressed-out)
  + [1.4 Association testing](#association-testing)
  + [1.5 Further steps of RaMWAS pipeline](#further-steps-of-ramwas-pipeline)
  + [1.6 Cleanup](#cleanup)
* [2 Version information](#version-information)

# 1 Using RaMWAS with other methylation platforms or data types

[RaMWAS](https://bioconductor.org/packages/ramwas/)
is primarily designed for studies of methylation measurements
from enrichment platforms.

However, RaMWAS can also be useful for the analysis of
methylation measurements from other platforms
(e.g. Illumina HumanMethylation450K array) or
other data types such as gene expression levels or genotype information.
RaMWAS can perform several analysis steps on such data including:
principal component analysis (PCA),
association testing (MWAS, TWAS, GWAS),
and multimarker analysis with cross validation using the elastic net.

## 1.1 Import data from other sources

Without external data source at hand,
we show how to create and fill data matrices
with artificial data.
Importing real data can be done in a similar way,
with random data generation replaced with reading data from
existing sources.

We create data files in the same format as produced by
[Step 3](RW1_intro.html#step3) of RaMWAS.

These files include

* `CpG_locations.*` – filematrix with the location of
  the CpGs / SNPs / gene trascription start sites.
  It must have two columns with integer values –
  chromosome number and location
  (`chr` and `position`).
* `CpG_chromosome_names.txt` – file with chromosome names (factor levels)
  for the integer column `chr` in the location filematrix.
* `Coverage.*` – filematrix with the data for all samples and all locations.
  Each row has data for a single sample.
  Row names must be sample names.
  Each column has data for a single location
  (CpG / SNP / gene trascription start site).
  Columns must match rows of the location filematrix.

First, we load the package and set up a working directory.
The project directory `dr` can be set to
a more convenient location when running the code.

```
library(ramwas)

# work in a temporary directory
dr = paste0(tempdir(), "/simulated_matrix_data")
dir.create(dr, showWarnings = FALSE)
cat(dr,"\n")
```

```
## /tmp/RtmpK8kZfn/simulated_matrix_data
```

Let the sample data matrix have 200 samples and 100,000 variables.

```
nsamples = 200
nvariables = 100000
```

For these 200 samples we generate a data frame with
age and sex phenotypes and a batch effect covariate.

```
covariates = data.frame(
    sample = paste0("Sample_",seq_len(nsamples)),
    sex = seq_len(nsamples) %% 2,
    age = runif(nsamples, min = 20, max = 80),
    batch = paste0("batch",(seq_len(nsamples) %% 3))
)
pander(head(covariates))
```

| sample | sex | age | batch |
| --- | --- | --- | --- |
| Sample\_1 | 1 | 71.5 | batch1 |
| Sample\_2 | 0 | 35.8 | batch2 |
| Sample\_3 | 1 | 60.4 | batch0 |
| Sample\_4 | 0 | 64.5 | batch1 |
| Sample\_5 | 1 | 28.4 | batch2 |
| Sample\_6 | 0 | 26.3 | batch0 |

Next, we create the genomic locations for 100,000 variables.

```
temp = cumsum(sample(20e7 / nvariables, nvariables, replace = TRUE) + 0)
chr      = as.integer(temp %/% 1e7) + 1L
position = as.integer(temp %% 1e7)

locmat = cbind(chr = chr, position = position)
chrnames = paste0("chr", 1:10)
pander(head(locmat))
```

| chr | position |
| --- | --- |
| 1 | 958 |
| 1 | 1850 |
| 1 | 2916 |
| 1 | 4390 |
| 1 | 5386 |
| 1 | 6104 |

Now we save locations in a filematrix
and create a text file with chromosome names.

```
fmloc = fm.create.from.matrix(
            filenamebase = paste0(dr,"/CpG_locations"),
            mat = locmat)
close(fmloc)
writeLines(
        con = paste0(dr,"/CpG_chromosome_names.txt"),
        text = chrnames)
```

Finally, we create data matrix.
We include sex effect in 225 variables and
age effect in 16 variables out of each 2000.
Each variable is also affected by noise and batch effects.

```
fm = fm.create(paste0(dr,"/Coverage"), nrow = nsamples, ncol = nvariables)

# Row names of the matrix are set to sample names
rownames(fm) = as.character(covariates$sample)

# The matrix is filled, 2000 variables at a time
byrows = 2000
for( i in seq_len(nvariables/byrows) ){ # i=1
    slice = matrix(runif(nsamples*byrows), nrow = nsamples, ncol = byrows)
    slice[,  1:225] = slice[,  1:225] + covariates$sex / 30 / sd(covariates$sex)
    slice[,101:116] = slice[,101:116] + covariates$age / 10 / sd(covariates$age)
    slice = slice + ((as.integer(factor(covariates$batch))+i) %% 3) / 40
    fm[,(1:byrows) + byrows*(i-1)] = slice
}
close(fm)
```

## 1.2 Principal Component Analysis (PCA)

To run PCA with RaMWAS we specify three parameters:

* `dircoveragenorm` – directory with the data matrix
* `covariates` – data frame with covariates
* `modelcovariates` – names of covariates to regress out

```
param = ramwasParameters(
    dircoveragenorm = dr,
    covariates = covariates,
    modelcovariates = NULL
)
```

Now we run PCA.

```
ramwas4PCA(param)
```

The top several PCs are marginally distinct from the rest.

```
pfull = parameterPreprocess(param)
eigenvalues = fm.load(paste0(pfull$dirpca, "/eigenvalues"))
eigenvectors = fm.open(
                filenamebase = paste0(pfull$dirpca, "/eigenvectors"),
                readonly = TRUE)
plotPCvalues(eigenvalues)
```

![](data:image/png;base64...)

```
plotPCvectors(eigenvectors[,1], 1)
```

![](data:image/png;base64...)

```
plotPCvectors(eigenvectors[,2], 2)
```

![](data:image/png;base64...)

```
plotPCvectors(eigenvectors[,3], 3)
```

![](data:image/png;base64...)

```
plotPCvectors(eigenvectors[,4], 4)
```

![](data:image/png;base64...)

```
close(eigenvectors)
```

There are strong correlations between top PCs with
sex, age, and batch covariates.
Note, for the categorical covariate (batch)
the table shows R2 instead of correlations.

```
# Get the directory with PCA results
pfull = parameterPreprocess(param)
tblcr = read.table(
            file = paste0(pfull$dirpca, "/PC_vs_covs_corr.txt"),
            header = TRUE,
            sep = "\t")
pander(head(tblcr, 5))
```

| name | sex | age | batch\_R2 |
| --- | --- | --- | --- |
| PC1 | -0.0278 | -0.0991 | 0.984 |
| PC2 | 0.0326 | 0.0372 | 0.986 |
| PC3 | -0.938 | -0.163 | 0.00167 |
| PC4 | 0.286 | -0.942 | 0.000988 |
| PC5 | -0.0126 | 0.0021 | 8.94e-05 |

The p-values for these correlations and R2
show that the top two PCs are correlated with
sex and age while a number of other PCs are affected by sample batch effects.

```
pfull = parameterPreprocess(param)
tblpv = read.table(
            file = paste0(pfull$dirpca, "/PC_vs_covs_pvalue.txt"),
            header = TRUE,
            sep = "\t")
pander(head(tblpv, 5))
```

| name | sex | age | batch\_R2 |
| --- | --- | --- | --- |
| PC1 | 0.696 | 0.163 | 1.11e-178 |
| PC2 | 0.647 | 0.601 | 1.6e-183 |
| PC3 | 2.55e-93 | 0.0211 | 0.848 |
| PC4 | 4.06e-05 | 6.37e-96 | 0.907 |
| PC5 | 0.86 | 0.976 | 0.991 |

## 1.3 PCA with batch regressed out

It is common to regress out batch and lab-technical effects
from the data in the analysis.

Let’s regress out batch in our example
by changing `modelcovariates` parameter.

```
param$modelcovariates = "batch"

ramwas4PCA(param)
```

The p-values for association between PCs and covariates changed slightly:

```
# Get the directory with PCA results
pfull = parameterPreprocess(param)
tblpv = read.table(
            file = paste0(pfull$dirpca, "/PC_vs_covs_pvalue.txt"),
            header = TRUE,
            sep = "\t")
pander(head(tblpv, 5))
```

| name | sex | age | batch\_R2 |
| --- | --- | --- | --- |
| PC1 | 4.54e-93 | 0.0185 | NA |
| PC2 | 4.41e-05 | 1.25e-98 | NA |
| PC3 | 0.86 | 0.997 | NA |
| PC4 | 0.852 | 0.584 | NA |
| PC5 | 0.883 | 0.692 | NA |

Note that the PCs are now orthogonal to the batch effects and thus
the corresponding p-values all equal to 1.

## 1.4 Association testing

Let us test for association between
variables in the data matrix and the sex covariate
(`modeloutcome` parameter)
correcting for batch effects (`modelcovariates` parameter).
Save top 20 results (`toppvthreshold` parameter) in a text file.

```
param$modelcovariates = "batch"
param$modeloutcome = "sex"
param$toppvthreshold = 20

ramwas5MWAS(param)
```

The QQ-plot shows mild enrichment among a large number of variables,
which is consistent with how the data was generated –
22% of variables are affected by sex.

```
mwas = getMWAS(param)
qqPlotFast(mwas$`p-value`)
title(pfull$qqplottitle)
```

![](data:image/png;base64...)

The top finding saved in the text file are:

```
# Get the directory with testing results
pfull = parameterPreprocess(param)
toptbl = read.table(
            file = paste0(pfull$dirmwas,"/Top_tests.txt"),
            header = TRUE,
            sep = "\t")
pander(head(toptbl, 5))
```

| chr | start | end | cor | t.test | p.value | q.value | beta |
| --- | --- | --- | --- | --- | --- | --- | --- |
| chr9 | 3943528 | 3943529 | 0.373 | 5.63 | 6.12e-08 | 0.00612 | 0.631 |
| chr2 | 7934644 | 7934645 | 0.347 | 5.18 | 5.46e-07 | 0.0162 | 0.582 |
| chr9 | 5974532 | 5974533 | 0.345 | 5.15 | 6.45e-07 | 0.0162 | 0.607 |
| chr1 | 207416 | 207417 | 0.345 | 5.15 | 6.47e-07 | 0.0162 | 0.629 |
| chr2 | 5946217 | 5946218 | 0.342 | 5.09 | 8.34e-07 | 0.0163 | 0.589 |

## 1.5 Further steps of RaMWAS pipeline

Steps 6 and 7 of RaMWAS pipeline can also be applied
to the data matrix exactly as described in the
[overview vignette](RW1_intro.html#annotation-of-top-results).

## 1.6 Cleanup

Here we remove all the files created by the code above.

```
unlink(paste0(dr,"/*"), recursive=TRUE)
```

# 2 Version information

```
sessionInfo()
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] BSgenome.Ecoli.NCBI.20080805_1.3.1000 BSgenome_1.78.0
##  [3] rtracklayer_1.70.0                    BiocIO_1.20.0
##  [5] Biostrings_2.78.0                     XVector_0.50.0
##  [7] GenomicRanges_1.62.0                  Seqinfo_1.0.0
##  [9] IRanges_2.44.0                        S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0                   generics_0.1.4
## [13] ramwas_1.34.0                         filematrix_1.3
## [15] pander_0.6.6                          knitr_1.50
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] blob_1.2.4                  filelock_1.0.3
##  [5] bitops_1.0-9                RCurl_1.98-1.17
##  [7] fastmap_1.2.0               BiocFileCache_3.0.0
##  [9] GenomicAlignments_1.46.0    XML_3.99-0.19
## [11] digest_0.6.37               lifecycle_1.0.4
## [13] KEGGREST_1.50.0             survival_3.8-3
## [15] RSQLite_2.4.3               magrittr_2.0.4
## [17] compiler_4.5.1              rlang_1.1.6
## [19] sass_0.4.10                 progress_1.2.3
## [21] tools_4.5.1                 yaml_2.3.10
## [23] prettyunits_1.2.0           S4Arrays_1.10.0
## [25] bit_4.6.0                   curl_7.0.0
## [27] DelayedArray_0.36.0         abind_1.4-8
## [29] BiocParallel_1.44.0         KernSmooth_2.23-26
## [31] grid_4.5.1                  iterators_1.0.14
## [33] tinytex_0.57                biomaRt_2.66.0
## [35] SummarizedExperiment_1.40.0 cli_3.6.5
## [37] rmarkdown_2.30              crayon_1.5.3
## [39] rjson_0.2.23                httr_1.4.7
## [41] DBI_1.2.3                   cachem_1.1.0
## [43] stringr_1.5.2               splines_4.5.1
## [45] parallel_4.5.1              AnnotationDbi_1.72.0
## [47] restfulr_0.0.16             BiocManager_1.30.26
## [49] matrixStats_1.5.0           vctrs_0.6.5
## [51] glmnet_4.1-10               Matrix_1.7-4
## [53] jsonlite_2.0.0              bookdown_0.45
## [55] hms_1.1.4                   bit64_4.6.0-1
## [57] magick_2.9.0                foreach_1.5.2
## [59] jquerylib_0.1.4             glue_1.8.0
## [61] codetools_0.2-20            stringi_1.8.7
## [63] shape_1.4.6.1               tibble_3.3.0
## [65] pillar_1.11.1               rappdirs_0.3.3
## [67] htmltools_0.5.8.1           R6_2.6.1
## [69] dbplyr_2.5.1                httr2_1.2.1
## [71] evaluate_1.0.5              lattice_0.22-7
## [73] Biobase_2.70.0              png_0.1-8
## [75] Rsamtools_2.26.0            cigarillo_1.0.0
## [77] memoise_2.0.1               bslib_0.9.0
## [79] Rcpp_1.1.0                  SparseArray_1.10.0
## [81] xfun_0.53                   MatrixGenerics_1.22.0
## [83] pkgconfig_2.0.3
```