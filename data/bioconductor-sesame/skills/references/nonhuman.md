[[![](data:image/png;base64...)](http://bioconductor.org/packages/release/bioc/html/sesame.html)](index.html)

* [Basics](sesame.html)
* [QC](QC.html)
* [Non-human Array](nonhuman.html)
* [Modeling](modeling.html)
* [Inference](inferences.html)
* [KnowYourCG](https://bioconductor.org/packages/release/bioc/html/knowYourCG.html)
* [Supplemental](https://zhou-lab.github.io/sesame/dev/supplemental.html)

# Working with Non-human Array

#### 25 November 2025

SeSAMe provides extensive native support for the Illumina Mouse Methylation BeadChip array (referred to as the MM285 or MMB array) and the Horvath Mammal40 array (refered to as the Mammal40 array). The MM285 array contains ~285,000 probes covering over 20 design categories including gene promoters, enhancers, CpGs in synteny to human EPIC array as well as other biology. In SeSAMe, MM285 is used as the product abbreviation to distinguish future platforms including MM320. This documents describe the procedure to process the MM285 and the Mammal40 array.

We first load required library and perform sesame data caching (only needed at new SeSAMe installation).

```
library(sesame)
sesameDataCache()
```

# Species Inference

SeSAMe supports automatic inference of the profiled organism. This is achieved by the `inferSpecies` function. Usually, users need not call this function explicitly and only need to specify the code `S` as part of the 2nd argument of the `openSesame` function. See [the Basics Usage vignette](sesame.html#prep) for more detail.

The following example downloads an example Mammal40 array IDAT pair and call `openSesame` function with species inference (note the `S` in the `prep=` argument).

Download test IDATs `GSM4411982_Grn.idat.gz` and `GSM4411982_Red.idat.gz` from <https://github.com/zhou-lab/InfiniumAnnotationV1/tree/main/Test>

```
betas = openSesame(sprintf("~/Downloads/GSM4411982", tmp), prep="SHCDPM")
```

The above code is equivalent to

```
## equivalent to the above openSesame call
betas = getBetas(matchDesign(pOOBAH(dyeBiasNL(inferInfiniumIChannel(
    prefixMaskButC(inferSpecies(readIDATpair(
        "~/Downloads/GSM4411982"))))))))
```

As can be seen, `inferSpecies` takes a SigDF as input and outputs an updated SigDF which contains a species-specific masking and color channel designation. This information is key to proper preprocessing since knowledge of the color channel designation and probe hybridization success is the foundational assumption of many preprocessing algorithms. One may instruct the function to return the inferred species information by using the `return.species = TRUE` argument. The following example shows this usage:

```
sdf = sesameDataGet("Mammal40.1.SigDF") # an example SigDF
inferSpecies(sdf, return.species = TRUE)
```

```
## $scientificName
## [1] "xenopus_tropicalis"
##
## $taxonID
## [1] 8364
##
## $commonName
## [1] "Xenopus tropicalis"
##
## $assembly
## [1] "Xenopus_tropicalis_v9.1"
```

Internally, we used a nonparametric scoring method to infer the most likely species from a pool of 310 candidate species from Ensembl (v101). The `return.auc = TRUE` argument allows one to peek into the AUC (Area Under the Curve) score generated in this inference. The higher the score, the more likely the data is from the corresponding species. Knowing the scores can help diagnose misclassifications such as when several candidate species are closely related and hard to discriminate from data.

```
## showing the candidate species with top scores
head(sort(inferSpecies(sdf, return.auc = TRUE), decreasing=TRUE))
```

```
##        xenopus_tropicalis leptobrachium_leishanense       latimeria_chalumnae
##                 0.9643305                 0.9165120                 0.8332575
##       pseudonaja_textilis         notechis_scutatus         salvator_merianae
##                 0.8292410                 0.8268660                 0.8255875
```

If the user believes that automatic inference gives wrong (most often still close-related) species, one can force species inference to a target species by using the `updateSigDF` function. For example, the following code forces the `SigDF` to be treated as a `mus_musculus` sample. Note this doesn’t alter signal intensity but only change the probe masking and color channel spec (the view of the data, not the data reading itself).

```
sdf_mouse <- updateSigDF(sdf, species="mus_musculus")
```

**CRITICAL:** Since `updateSigDF` function resets the whole mask and col column of SigDF. One should use this function (and `inferSpecies`) before other preprocessing functions that sets mask and col.

# Mouse Strain Inference

Like species inference, strain-specific masking and preprocessing is important for mouse array samples. This is achieved by the `inferStrain` function. The function is represented by the `T` code in `openSesame`/`prepSesame`. The following example shows how to use `inferStrain` in `openSesame`. Note the use of `T` in the prep code.

Download test IDATs `204637490002_R05C01_Grn.idat` and `204637490002_R05C01_Red.idat` from <https://github.com/zhou-lab/InfiniumAnnotationV1/tree/main/Test>

```
betas = openSesame("~/Downloads/204637490002_R05C01", prep="TQCDPB")
```

Like `inferSpecies`, one need to call the `inferStrain` function before calling the standard `noob`, `dyeBiasNL`, etc (by having `T` before `QCDPB` when calling `openSesame`). Also like `inferSpecies()`, `inferStrain()` will return a new `SigDF` with col and mask updated to reflect the change of strain. Optionally, one can also specify `return.strain=TRUE`, `return.pval=TRUE` or `return.probability=TRUE` to return the inferred strain, the p-value or the probabilities of all 37 strain candidates. Internally, the function converts the beta values to variant allele frequencies. It should be noted that since variant allele frequency is not always measured by the M-allele of the probe. SeSAMe flips the *β* values for some probes to calculate variant allele frequency. The following example shows what `inferStrain` does to a `SigDF`:

```
sdf = sesameDataGet("MM285.1.SigDF") # an example dataset
inferStrain(sdf, return.strain = TRUE) # return strain as a string
```

```
## [1] "NOD_ShiLtJ"
```

```
sdf_after = inferStrain(sdf)   # update mask and col by strain inference
sum(sdf$mask) # before strain inference
```

```
## [1] 0
```

```
sum(sdf_after$mask) # after strain inference
```

```
## [1] 14599
```

Let’s visualize the probabilities of all candidate strains using the `return.probabilities` option:

```
library(ggplot2)
p = inferStrain(sdf, return.probability = TRUE)
df = data.frame(strain=names(p), probs=p)
ggplot(data = df,  aes(x = strain, y = probs)) +
            geom_bar(stat = "identity", color="gray") +
            ggtitle("Strain Probabilities") +
            ylab("Probability") + xlab("") +
            scale_x_discrete(position = "top") +
            theme(axis.text.x = element_text(angle = 90, vjust=0.5, hjust=0),
            legend.position = "none")
```

![](data:image/png;base64...)

See also [The Supplemental Vignette](https://zhou-lab.github.io/sesame/v1.16/supplemental.html#SNP) for heatmap validation of strain inference.

# Quality Masking

In the MM285 array, we designed multimapping probes to allow querying transposable elements and other biology. We also exposed probes with potentially design flaws. These suboptimally designed probes take a new probe ID prefix (“uk”) in addition to the “cg”/“ch”/“rs” typically seen. By default the repeat and suboptimally designed probes are masked by `NA`. These masking is done by the `qualityMask` function (or `Q` in prep codes). To override masking these probes, one can use the `resetMask` function (the `0` code in `openSesame`) to remove the default masking. We recommend using it after the preprocessing function that depends on reliable/uniquely-mapped probes, but before detection p-value based masking (e.g. pOOBAH). This way, probes that fail detection can still be flagged (they should be).

```
sdf = sesameDataGet('MM285.1.SigDF')
sum(is.na(openSesame(sdf, prep="TQCDPB")))
```

```
## [1] 20548
```

```
sum(is.na(openSesame(sdf, prep="TQCD0PB")))
```

```
## [1] 7735
```

# Human-mouse Mixture

UNDER CONSTRUCTION

There are other inferences one can do on the nonhuman arrays, e.g., sex, age (epigenetic clocks), tissue, copy number alteration etc. These will be elaborated in [The Inference Vignette](inferences.html).

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