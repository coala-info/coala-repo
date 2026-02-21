[[![](data:image/png;base64...)](http://bioconductor.org/packages/release/bioc/html/sesame.html)](index.html)

* [Basics](sesame.html)
* [QC](QC.html)
* [Non-human Array](nonhuman.html)
* [Modeling](modeling.html)
* [Inference](inferences.html)
* [KnowYourCG](https://bioconductor.org/packages/release/bioc/html/knowYourCG.html)
* [Supplemental](https://zhou-lab.github.io/sesame/dev/supplemental.html)

# Basic Usage & Preprocessing

#### 25 November 2025

# Preparation

```
library(sesame)
```

```
## As sesame and sesameData are under active development, this documentation is
## specific to the following version of R, sesame, sesameData and ExperimentHub:
sesame_checkVersion()
```

```
## SeSAMe requires matched versions of R, sesame, sesameData and ExperimentHub.
## Here is the current versions installed:
## R: 4.5.2
## Bioconductor: 3.22
## sesame: 1.28.1
## sesameData: 1.28.0
## ExperimentHub: 3.0.0
```

We recommend updating your R, ExperimentHub, sesameData and sesame to use this documentation consistently. If you have installed directly from github, please make sure the compatible ExperimentHub is installed.

If you use a previous version, please checkout the vignette that corresponds to the right version here <https://zhou-lab.github.io/sesame/dev/supplemental.html#Versions>

**CRITICAL:** After a new installation, one must cache the associated annotation data using the following command. This needs to be done only once per SeSAMe installation/update. Caching data to local guarantees proper data retrieval and saves internet traffic.

```
sesameDataCache()
```

This function caches the needed SeSAMe annotations. SeSAMe annotation data is managed by the [sesameData](https://tinyurl.com/58ny3rrt) package which uses the [ExperimentHub](https://tinyurl.com/2p873tez) infrastructure. You can find the location of the cached annotation data on your local computer using:

```
tools::R_user_dir("ExperimentHub", which="cache")
```

```
## [1] "/home/biocbuild/.cache/R/ExperimentHub"
```

# The openSesame Pipeline

The `openSesame` function provides end-to-end processing that converts IDATs to DNA methylation level (aka *β* value) matrices in R. The function input `path_to_idats` can be one of the following input:

* A path to a directory where the IDAT files will be recursively search
* Specific path(s) of IDAT file prefix, one for each IDAT pair
* One or a list of SigDF objects

The following code uses a directory that contains built-in two HM27 IDAT pairs to demonstrates the use of `openSesame`:

```
betas = openSesame("path_to_idats", BPPARAM = BiocParallel::MulticoreParam(2))
```

The `BPPARAM=` option is from the `BiocParallel` package and controls parallel processing (in this case, we are using two cores). Under the hood, the function performs a series of tasks including: searching IDAT files from the directory (the `searchIDATprefixes` function), reading IDAT data in as `SigDF` objects (the `readIDATpair` function), preprocessing the signals (the `prepSesame` function), and finally converting them to DNA methylation levels (*β* values, the `getBetas` function). Alternatively, one can run the following command to get the same results, while gaining more refined control:

```
##  The above openSesame call is equivalent to:
betas = do.call(cbind, BiocParallel::bplapply(
    searchIDATprefixes(idat_dir), function(pfx) {
        getBetas(prepSesame(readIDATpair(pfx), "QCDPB"))
}, BPPARAM = BiocParallel::MulticoreParam(2)))

## or even more explicitly (if one needs to control argument passed
## to a specific preprocessing function)
betas = do.call(cbind, BiocParallel::bplapply(
    searchIDATprefixes(idat_dir), function(pfx) {
        getBetas(noob(pOOBAH(dyeBiasNL(inferInfiniumIChannel(qualityMask(
            readIDATpair(pfx)))))))
}, BPPARAM = BiocParallel::MulticoreParam(2)))
```

The `openSesame` function is highly customizable. The `prep=` argument is the same argument one gives to the `prepSesame` function (see [Data Preprocessing](#dataprep) for detail) which `openSesame` calls internally. The argument uniquely specifies a preprocessing procedure. The `func=` option specifies the signal extraction function. It can be either be `getBetas` (DNA methylation) or `getAFs` (allele frequencies of SNP probes) or NULL (returns `SigDF`). The `manifest=` option allows one to provide an array manifest when handling data from platform not supported natively. Finally, the `BPPARAM=` argument is the same argument taken by `BiocParallel::bplapply` to allow parallel processing. See [Supplemental Vignette](https://zhou-lab.github.io/sesame/v1.16/supplemental.html#openSesame) for details of these component functions of openSesame.

The output of `openSesame` can also be customized. It can either be beta values, which are the end DNA methylation readings, as shown above. It can also be a list of `SigDF`s which stores the signal intensities and can be further put back to openSesame for more processing. The `openSesame(func=)` argument specifies whether the output is a SigDF list or beta values. The following shows some usage:

```
betas = openSesame(idat_dir, func = getBetas) # getBetas is the default
sdfs = openSesame(idat_dir, func = NULL) # return SigDF list
allele_freqs = openSesame(idat_dir, func = getAFs) # SNP allele frequencies
sdfs = openSesame(sdfs, prep = "Q", func = NULL)   # take and return SigDFs
```

One can also generate the detection p-values (e.g., for GEO upload) by feeding openSesame with `func = pOOBAH` (or other detection p-value calculators).

```
pvals = openSesame(idat_dir, func = pOOBAH, return.pval=TRUE)
```

# Data Preprocessing

The `prep=` argument instructs the `openSesame` function to call the `prepSesame` function to preprocess signal intensity under the hood. This can be skipped by using `prep=""`. The `prepSesame` function takes a single `SigDF` as input and returns a processed `SigDF`. When `prep=` is non-empty, it selects the preprocessing functions (see [Preprocessing Function Code](#prep)) and specifies the order of their execution. For example,

```
sdf = sesameDataGet('EPIC.1.SigDF')
sdf_preped = openSesame(sdf, prep="DB", func=NULL)
```

performs dye bias correction (`D`) followed by background subtraction (`B`). In other words, `prepSesame(sdf, "DB")` is equivalent to `noob(dyeBiasNL(sdf))`. All the preprocessing functions take a `SigDF` as input and return an updated `SigDF`. Therefore, these functions can be chained together. The choice of preprocessing functions and the order of their chaining is important (see [Supplemental Vignette](https://zhou-lab.github.io/sesame/v1.16/supplemental.html#prepfuns)) for detailed discussions of these functions). The following table lists the best preprocessing strategy based on our experience.

Recommended Preprocessing

| Platform | Sample Organism | Prep Code |
| --- | --- | --- |
| EPICv2/EPIC/HM450 | human | QCDPB |
| EPICv2/EPIC/HM450 | non-human organism | SQCDPB |
| MM285 | mouse | TQCDPB |
| MM285 | non-mouse organism | SQCDPB |
| Mammal40 | human | HCDPB |
| Mammal40 | non-human organism | SHCDPB |

The optimal strategy of preprocessing depends on:

1. **The array platform**. For example, certain array platforms (e.g., the Mammal40) do not have enough Infinium-I probes for background estimation and dye bias correction, therefore background subtraction (where the out-of-band signals are from) might not work most optimally;
2. **The expected sample property**. For example, some samples have the signature bimodal distribution of methylation of most mammalian cells. Others may undergo global loss of methylation (germ cells, tumors etc). Other important factors include high-input vs low-input, tumor vs normal, somatic vs germ cells, human vs model organisms, mouse strains etc. Some platforms (e.g., Mammal40 and MM285) are designed for multiple species and strains. Therefore `S` and `T` would be important when those arrays are used on non-reference organisms (see [Working with Nonhuman Arrays](nonhuman.html)).

# Preprocessing Function Code

The `prepSesameList` function lists all the available codes and the associated preprocessing functions.

```
prepSesameList()
```

Here are some consideration when determining the preprocessing order. Species `(S)` and strain `(T)` inference resets the mask and color channels based on probe alignment and presence of genetic variants. Therefore when they are used, they need to be called first. `Q` masks non-uniquely mapped probes which may inflate the out-of-band signal for background estimation. Therefore `Q` should be used before detection p-value calculation (`P`) and background subtraction (`B`) when necessary. Channel inference (`C`) and dye bias correction (`D`) should take place early since dye bias effect is global. `C` should be placed before `D` because dye bias correction uses in-band signal the identification of which relies on correct channel designation. Detection p-value (`P`) should happen before background subtraction (`B`) since background subtraction modifies signal and may affect out-of-band signal assumption used in `P`. Lastly, functions that explicitly normalizes *β* value distribution (`M`) should happen last if they even need to be used.

See [Supplemental Vignette](https://zhou-lab.github.io/sesame/v1.16/supplemental.html#prepfuns) for details of preprocessing functions.

# Lift over across platforms

To allow data integration across platforms, one can harmonize beta values, probe ID list and even signal intensities, to a different platform using the `mLiftOver` (methylation Lift Over) utility. The following examples illustrates these corresponding usages.

## Project probe IDs

```
cg_msa = names(sesameData_getManifestGRanges("MSA"))
## only mappable probes, return mapping from MSA to HM450
head(mLiftOver(cg_msa, "HM450"))
```

```
## cg13869341_BC11 cg12045430_BC11 cg18231760_BC21 cg17866181_BC21 cg08477687_BC21
##    "cg13869341"    "cg12045430"    "cg18231760"    "cg17866181"    "cg08477687"
## cg23917638_TC21
##    "cg23917638"
```

```
cg_hm450 = names(sesameData_getManifestGRanges("HM450"))
cg_hm450 = grep("cg", cg_hm450, value=TRUE)
## only mappable probes, return mapping from HM450 to EPICv2
head(mLiftOver(cg_hm450, "EPICv2"))
```

```
##        cg00381604        cg21870274        cg06402284        cg23803172
## "cg00381604_BC11" "cg21870274_BC21" "cg06402284_TC21" "cg23803172_BC11"
##        cg20788133        cg08258224
## "cg20788133_BC21" "cg08258224_TC21"
```

## Project beta values

```
betas = openSesame(sesameDataGet("EPICv2.8.SigDF")[[1]])
betas_epic = mLiftOver(betas, "EPIC", impute=FALSE)
length(betas_epic)     # EPIC platform dimension
```

```
## [1] 866553
```

```
sum(is.na(betas_epic)) # NA values are present
```

```
## [1] 152102
```

```
betas_epic = imputeBetas(betas_epic)
length(betas_epic)     # EPIC platform dimension
```

```
## [1] 866553
```

```
sum(is.na(betas_epic)) # expect 0 NA after imputation
```

```
## [1] 0
```

```
## use empirical evidence in mLiftOver
mapping = sesameDataGet("liftOver.EPICv2ToEPIC")
betas_matrix = openSesame(sesameDataGet("EPICv2.8.SigDF")[1:2])
dim(mLiftOver(betas_matrix, "EPIC", mapping = mapping))
```

```
## [1] 539513      2
```

```
## compare to without using empirical evidence
dim(mLiftOver(betas_matrix, "EPIC"))
```

```
## [1] 866553      2
```

## Project signal SigDFs

```
sdf = sesameDataGet("EPICv2.8.SigDF")[["GM12878_206909630042_R08C01"]]
dim(mLiftOver(sdf, "EPICv2")) # EPICv2 platform dimension
```

```
## [1] 937690      7
```

```
dim(mLiftOver(sdf, "EPIC"))   # EPIC platform dimension
```

```
## [1] 866553      7
```

```
dim(mLiftOver(sdf, "HM450"))  # HM450 platform dimension
```

```
## [1] 486427      7
```

# Collapse to cg prefixes

The more recent Infinium arrays (the mouse, EPICv2, and MSA arrays) have suffixes to uniquely identify the probe design. If one prefers to collapse methylation readings to the cg prefix so they are comparable to the previous array generations, this can be done with `getBetas(..., collapseToPfx = TRUE)`. The same argument can be passed to `openSesame(..., func=getBetas, collapseToPfx=TRUE)`

```
betas = getBetas(sdf_from_EPICv2, collapseToPfx = TRUE)
## or
betas = openSesame("path_to_idats", collapseToPfx = TRUE)
## by default the method for collapsing is to make means
betas = openSesame("path_to_idats", collapseToPfx = TRUE, collapseMethod = "mean")
## one can also switch to min detection p-value
betas = openSesame("path_to_idats", collapseToPfx = TRUE, collapseMethod = "minPval")
```

One may also use the `betasCollapseToPfx` function to generate the traditional cg number readings.

```
betas = betasCollapseToPfx(betas, BPPARAM=BiocParallel::MulticoreParam(2))
```

Please find more info at the Supplemental documentation at the following [link] (<https://zhou-lab.github.io/sesame/dev/supplemental.html#Replicate_Probes>)

# Session Info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] wheatmap_0.2.0              ggplot2_4.0.1
##  [3] tidyr_1.3.1                 dplyr_1.1.4
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] knitr_1.50                  sesame_1.28.1
## [15] sesameData_1.28.0           ExperimentHub_3.0.0
## [17] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [19] dbplyr_2.5.1                BiocGenerics_0.56.0
## [21] generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1      farver_2.1.2          blob_1.2.4
##  [4] filelock_1.0.3        Biostrings_2.78.0     S7_0.2.1
##  [7] fastmap_1.2.0         digest_0.6.39         lifecycle_1.0.4
## [10] KEGGREST_1.50.0       RSQLite_2.4.4         magrittr_2.0.4
## [13] compiler_4.5.2        rlang_1.1.6           sass_0.4.10
## [16] tools_4.5.2           yaml_2.3.10           labeling_0.4.3
## [19] S4Arrays_1.10.0       bit_4.6.0             curl_7.0.0
## [22] DelayedArray_0.36.0   plyr_1.8.9            RColorBrewer_1.1-3
## [25] abind_1.4-8           BiocParallel_1.44.0   withr_3.0.2
## [28] purrr_1.2.0           grid_4.5.2            preprocessCore_1.72.0
## [31] colorspace_2.1-2      MASS_7.3-65           scales_1.4.0
## [34] dichromat_2.0-0.1     cli_3.6.5             rmarkdown_2.30
## [37] crayon_1.5.3          reshape2_1.4.5        httr_1.4.7
## [40] tzdb_0.5.0            DBI_1.2.3             cachem_1.1.0
## [43] stringr_1.6.0         splines_4.5.2         parallel_4.5.2
## [46] AnnotationDbi_1.72.0  BiocManager_1.30.27   XVector_0.50.0
## [49] vctrs_0.6.5           Matrix_1.7-4          jsonlite_2.0.0
## [52] hms_1.1.4             bit64_4.6.0-1         fontawesome_0.5.3
## [55] jquerylib_0.1.4       glue_1.8.0            codetools_0.2-20
## [58] stringi_1.8.7         gtable_0.3.6          BiocVersion_3.22.0
## [61] tibble_3.3.0          pillar_1.11.1         rappdirs_0.3.3
## [64] htmltools_0.5.8.1     R6_2.6.1              httr2_1.2.1
## [67] evaluate_1.0.5        lattice_0.22-7        readr_2.1.6
## [70] png_0.1-8             memoise_2.0.1         BiocStyle_2.38.0
## [73] bslib_0.9.0           Rcpp_1.1.0            nlme_3.1-168
## [76] SparseArray_1.10.3    mgcv_1.9-4            xfun_0.54
## [79] pkgconfig_2.0.3
```