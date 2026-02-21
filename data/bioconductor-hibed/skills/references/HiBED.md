# HiBED

#### Ze Zhang

#### 2025-11-04

The HiBED package contains reference libraries derived from Illumina HumanMethylation450K and Illumina HumanMethylationEPIC DNA methylation microarrays (Zhang Z, Salas LA et al. 2023), consisting of 6 astrocyte, 12 endothelial, 5 GABAergic neuron, 5 glutamatergic neuron, 18 microglial, 20 oligodendrocyte, and 5 stromal samples from public resources.

The reference libraries were used to estimate proportions of 7 major brain cell types in 450K and EPIC bulk brain samples using a modified version of the algorithm constrained projection/quadratic programming described in Houseman et al. 2012.

**Loading package:**

```
library(HiBED)
```

**Objects included:**
1. *HiBED\_Libraries* contains 4 libraries for deconvolution

```
data("HiBED_Libraries")
```

2. *HiBED\_deconvolution function for brain cell deconvolution:*

We offer the function HiBED\_deconvolution to estimate proportions for 7 major brain cell types, including GABAergic neurons, glutamatergic neurons, astrocytes, microglial cells, oligodendrocytes, endothelial cells, and stromal cells. The estimates are calculated using modified CP/QP method described in Houseman et al. 2012.
*see ?HiBED\_deconvolution for details*

```
# Step 1 load and process example
library(FlowSorted.Blood.EPIC)
library(FlowSorted.DLPFC.450k)
library(minfi)
Mset<-preprocessRaw(FlowSorted.DLPFC.450k)

Examples_Betas<-getBeta(Mset)

# Step 2: use the HiBED_deconvolution function in combinatation with the
# reference libraries for brain cell deconvolution.

 HiBED_result<-HiBED_deconvolution(Examples_Betas, h=2)

 head(HiBED_result)
#>        Endothelial   Stromal Astrocyte Microglial Oligodendrocyte      GABA
#> 813_N          NaN       NaN 0.8548534  0.7915309        5.643616 14.867764
#> 1740_N         NaN       NaN 0.8524800  1.1596800        3.747840 17.805161
#> 1740_G   4.2758290 2.0241710 6.3462006 19.9935161       60.030283  3.336364
#> 1228_G   2.6479470 2.1120530 4.2803944  7.2064838       78.253122  2.508475
#> 813_G    2.5763484 1.9536516 5.4130230 14.4480688       69.668908  2.738889
#> 1228_N   0.5389908 0.7110092 1.5104187  1.6272037        7.832378 14.880146
#>              GLU
#> 813_N  70.812236
#> 1740_N 70.134839
#> 1740_G  4.003636
#> 1228_G  2.991525
#> 813_G   3.211111
#> 1228_N 69.869854
```

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] parallel  stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] IlluminaHumanMethylation450kmanifest_0.4.0
#>  [2] FlowSorted.DLPFC.450k_1.46.0
#>  [3] FlowSorted.Blood.EPIC_2.14.0
#>  [4] ExperimentHub_3.0.0
#>  [5] AnnotationHub_4.0.0
#>  [6] BiocFileCache_3.0.0
#>  [7] dbplyr_2.5.1
#>  [8] minfi_1.56.0
#>  [9] bumphunter_1.52.0
#> [10] locfit_1.5-9.12
#> [11] iterators_1.0.14
#> [12] foreach_1.5.2
#> [13] Biostrings_2.78.0
#> [14] XVector_0.50.0
#> [15] SummarizedExperiment_1.40.0
#> [16] Biobase_2.70.0
#> [17] MatrixGenerics_1.22.0
#> [18] matrixStats_1.5.0
#> [19] GenomicRanges_1.62.0
#> [20] Seqinfo_1.0.0
#> [21] IRanges_2.44.0
#> [22] S4Vectors_0.48.0
#> [23] BiocGenerics_0.56.0
#> [24] generics_0.1.4
#> [25] HiBED_1.8.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
#>   [3] magrittr_2.0.4            GenomicFeatures_1.62.0
#>   [5] rmarkdown_2.30            BiocIO_1.20.0
#>   [7] vctrs_0.6.5               multtest_2.66.0
#>   [9] memoise_2.0.1             Rsamtools_2.26.0
#>  [11] DelayedMatrixStats_1.32.0 RCurl_1.98-1.17
#>  [13] askpass_1.2.1             htmltools_0.5.8.1
#>  [15] S4Arrays_1.10.0           curl_7.0.0
#>  [17] Rhdf5lib_1.32.0           SparseArray_1.10.1
#>  [19] rhdf5_2.54.0              sass_0.4.10
#>  [21] nor1mix_1.3-3             bslib_0.9.0
#>  [23] plyr_1.8.9                httr2_1.2.1
#>  [25] cachem_1.1.0              GenomicAlignments_1.46.0
#>  [27] lifecycle_1.0.4           pkgconfig_2.0.3
#>  [29] Matrix_1.7-4              R6_2.6.1
#>  [31] fastmap_1.2.0             digest_0.6.37
#>  [33] siggenes_1.84.0           reshape_0.8.10
#>  [35] AnnotationDbi_1.72.0      RSQLite_2.4.3
#>  [37] base64_2.0.2              filelock_1.0.3
#>  [39] httr_1.4.7                abind_1.4-8
#>  [41] compiler_4.5.1            beanplot_1.3.1
#>  [43] rngtools_1.5.2            bit64_4.6.0-1
#>  [45] BiocParallel_1.44.0       DBI_1.2.3
#>  [47] HDF5Array_1.38.0          MASS_7.3-65
#>  [49] openssl_2.3.4             rappdirs_0.3.3
#>  [51] DelayedArray_0.36.0       rjson_0.2.23
#>  [53] tools_4.5.1               rentrez_1.2.4
#>  [55] glue_1.8.0                quadprog_1.5-8
#>  [57] h5mread_1.2.0             restfulr_0.0.16
#>  [59] nlme_3.1-168              rhdf5filters_1.22.0
#>  [61] grid_4.5.1                tzdb_0.5.0
#>  [63] preprocessCore_1.72.0     tidyr_1.3.1
#>  [65] data.table_1.17.8         hms_1.1.4
#>  [67] xml2_1.4.1                BiocVersion_3.22.0
#>  [69] pillar_1.11.1             limma_3.66.0
#>  [71] genefilter_1.92.0         splines_4.5.1
#>  [73] dplyr_1.1.4               lattice_0.22-7
#>  [75] survival_3.8-3            rtracklayer_1.70.0
#>  [77] bit_4.6.0                 GEOquery_2.78.0
#>  [79] annotate_1.88.0           tidyselect_1.2.1
#>  [81] knitr_1.50                xfun_0.54
#>  [83] scrime_1.3.5              statmod_1.5.1
#>  [85] yaml_2.3.10               evaluate_1.0.5
#>  [87] codetools_0.2-20          cigarillo_1.0.0
#>  [89] tibble_3.3.0              BiocManager_1.30.26
#>  [91] cli_3.6.5                 xtable_1.8-4
#>  [93] jquerylib_0.1.4           Rcpp_1.1.0
#>  [95] png_0.1-8                 XML_3.99-0.19
#>  [97] readr_2.1.5               blob_1.2.4
#>  [99] mclust_6.1.2              doRNG_1.8.6.2
#> [101] sparseMatrixStats_1.22.0  bitops_1.0-9
#> [103] illuminaio_0.52.0         purrr_1.1.0
#> [105] crayon_1.5.3              rlang_1.1.6
#> [107] KEGGREST_1.50.0
```

**References**

Z Zhang, LA Salas et al. (2023) SHierarchical deconvolution for extensive cell type resolution in the human brain using DNA methylation. Under Review

J. Guintivano, et al. (2013). A cell epigenotype specific model for the correction of brain cellular heterogeneity bias and its application to age, brain region and major depression. Epigenetics, 8(3):290–302, 2013. doi: [10.4161/epi.23924] (<https://dx.doi.org/10.4161/epi.23924>).

Weightman Potter PG, et al. (2021) Attenuated Induction of the Unfolded Protein Response in Adult Human Primary Astrocytes in Response to Recurrent Low Glucose. Front Endocrinol (Lausanne) 2021;12:671724. doi: [10.3389/fendo.2021.671724] (<https://dx.doi.org/10.3389/fendo.2021.671724>).

Kozlenkov, et al. (2018) A unique role for DNA (hydroxy)methylation in epigenetic regulation of human inhibitory neurons. Sci. Adv. 2018;4:eaau6190. doi: [10.1126/sciadv.aau6190] (<https://dx.doi.org/10.1126/sciadv.aau6190>).

de Whitte, et al. (2022) Contribution of Age, Brain Region, Mood Disorder Pathology, and Interindividual Factors on the Methylome of Human Microglia. Biological Psychiatry March 15, 2022; 91:572–581. doi: [10.1016/j.biopsych.2021.10.020] (<https://doi.org/10.1016/j.biopsych.2021.10.020>).

X Lin, et al. (2018) Cell type-specific DNA methylation in neonatal cord tissue and cord blood: A 850K-reference panel and comparison of cell-types. Epigenetics. 13:941–58. doi: [10.1080/15592294.2018.1522929] (<https://dx.doi.org/10.1080/15592294.2018.1522929>).

LA Salas et al. (2022). Enhanced cell deconvolution of peripheral blood using DNA methylation for high-resolution immune profiling. Nature Communications 13(1):761. doi:[10.1038/s41467-021-27864-7](<https://dx.doi.org/10.1038/s41467-021-27864-7>).

EA Houseman et al. (2012) DNA methylation arrays as surrogate measures of cell mixture distribution. BMC Bioinformatics 13, 86. doi: [10.1186/1471-2105-13-86](https://dx.doi.org/10.1186/1471-2105-13-86).

[minfi](http://bioconductor.org/packages/release/bioc/html/minfi.html) Tools to analyze & visualize Illumina Infinium methylation arrays.