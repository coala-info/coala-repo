# Enrichment

Y-h. Taguchi1\*

1Department of Physics, Chuo University, Tokyo 112-8551, Japan

\*tag@granular.com

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Enrichr](#enrichr)
* [3 STRING](#string)
* [4 enrichplot](#enrichplot)

```
library(TDbasedUFE)
library(TDbasedUFEadv)
#>
library(DOSE)
#> DOSE v4.4.0 Learn more at https://yulab-smu.top/contribution-knowledge-mining/
#>
#> Please cite:
#>
#> Guangchuang Yu, Li-Gen Wang, Guang-Rong Yan, Qing-Yu He. DOSE: an
#> R/Bioconductor package for Disease Ontology Semantic and Enrichment
#> analysis. Bioinformatics. 2015, 31(4):608-609
library(enrichplot)
#> enrichplot v1.30.0 Learn more at https://yulab-smu.top/contribution-knowledge-mining/
#>
#> Please cite:
#>
#> Guangchuang Yu. Gene Ontology Semantic Similarity Analysis Using
#> GOSemSim. In: Kidder B. (eds) Stem Cell Transcriptional Networks.
#> Methods in Molecular Biology. 2020, 2117:207-215. Humana, New York, NY.
library(RTCGA.rnaseq)
#> Loading required package: RTCGA
#> Welcome to the RTCGA (version: 1.40.0). Read more about the project under https://rtcga.github.io/RTCGA/
library(RTCGA.clinical)
library(enrichR)
#> Welcome to enrichR
#> Checking connections ...
#> Enrichr ... Connection is Live!
#> FlyEnrichr ... Connection is Live!
#> WormEnrichr ... Connection is Live!
#> YeastEnrichr ... Connection is Live!
#> FishEnrichr ... Connection is Live!
#> OxEnrichr ... Connection is Live!
library(STRINGdb)
```

# 1 Introduction

It might be helpful to demonstrate how to evaluate selected genes by enrichment analysis. Here, we show some of useful tools applied to the output from TDbasedUFEadv
In order foe this, we reproduce one example in “How to use TDbasedUFEadv” as follows.

```
Multi <- list(
  BLCA.rnaseq[seq_len(100), 1 + seq_len(1000)],
  BRCA.rnaseq[seq_len(100), 1 + seq_len(1000)],
  CESC.rnaseq[seq_len(100), 1 + seq_len(1000)],
  COAD.rnaseq[seq_len(100), 1 + seq_len(1000)]
)
Z <- prepareTensorfromList(Multi, 10L)
Z <- aperm(Z, c(2, 1, 3))
Clinical <- list(BLCA.clinical, BRCA.clinical, CESC.clinical, COAD.clinical)
Multi_sample <- list(
  BLCA.rnaseq[seq_len(100), 1, drop = FALSE],
  BRCA.rnaseq[seq_len(100), 1, drop = FALSE],
  CESC.rnaseq[seq_len(100), 1, drop = FALSE],
  COAD.rnaseq[seq_len(100), 1, drop = FALSE]
)
# patient.stage_event.tnm_categories.pathologic_categories.pathologic_m
ID_column_of_Multi_sample <- c(770, 1482, 773, 791)
# patient.bcr_patient_barcode
ID_column_of_Clinical <- c(20, 20, 12, 14)
Z <- PrepareSummarizedExperimentTensor(
  feature = colnames(ACC.rnaseq)[1 + seq_len(1000)],
  sample = array("", 1), value = Z,
  sampleData = prepareCondTCGA(
    Multi_sample, Clinical,
    ID_column_of_Multi_sample, ID_column_of_Clinical
  )
)
HOSVD <- computeHosvd(Z)
#>
  |
  |                                                                      |   0%
  |
  |=======================                                               |  33%
  |
  |===============================================                       |  67%
  |
  |======================================================================| 100%
cond <- attr(Z, "sampleData")
index <- selectFeatureProj(HOSVD, Multi, cond, de = 1e-3, input_all = 3) # Batch mode
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
head(tableFeatures(Z, index))
#>       Feature       p value adjusted p value
#> 10    ACTB|60  0.000000e+00     0.000000e+00
#> 11   ACTG1|71  0.000000e+00     0.000000e+00
#> 37  ALDOA|226  0.000000e+00     0.000000e+00
#> 19 ADAM6|8755 5.698305e-299    1.424576e-296
#> 22  AEBP1|165 1.057392e-218    2.114785e-216
#> 9    ACTA2|59 7.862975e-198    1.310496e-195
genes <- unlist(lapply(strsplit(tableFeatures(Z, index)[, 1], "|",
  fixed = TRUE
), "[", 1))
entrez <- unlist(lapply(strsplit(tableFeatures(Z, index)[, 1], "|",
  fixed = TRUE
), "[", 2))
```

# 2 Enrichr

Enrichr(Kuleshov et al. [2016](#ref-Enrichr)) is one of tools that often provides us significant results
toward genes selected by TDbasedUFE and TDbasedUFEadv.

```
setEnrichrSite("Enrichr")
#> Connection changed to https://maayanlab.cloud/Enrichr/
#> Connection is Live!
websiteLive <- TRUE
dbs <- c(
  "GO_Molecular_Function_2021", "GO_Cellular_Component_2021",
  "GO_Biological_Process_2021"
)
enriched <- enrichr(genes, dbs)
#> Uploading data to Enrichr... Done.
#>   Querying GO_Molecular_Function_2021... Done.
#>   Querying GO_Cellular_Component_2021... Done.
#>   Querying GO_Biological_Process_2021... Done.
#> Parsing results... Done.
if (websiteLive) {
  plotEnrich(enriched$GO_Biological_Process_2021,
    showTerms = 20, numChar = 40, y = "Count",
    orderBy = "P.value"
  )
}
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the enrichR package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

Enrichr can provide you huge number of enrichment analyses,
many of which have good compatibility with the genes selected by
TDbasedUFE as well as TDbasedUFEadv by the experience.
Please check Enrichr’s web site to see what kinds of enrichment
analyses can be done.

# 3 STRING

STRING(Szklarczyk et al. [2018](#ref-STRING)) is enrichment analyses based upon protein-protein interaction,
which is known to provide often significant results toward genes selected by
TDbasedUFE as well as TDbasedUFEadv.

```
options(timeout = 200)
string_db <- STRINGdb$new(
  version = "11.5",
  species = 9606, score_threshold = 200,
  network_type = "full", input_directory = ""
)
example1_mapped <- string_db$map(data.frame(genes = genes),
  "genes",
  removeUnmappedRows = TRUE
)
#> Warning:  we couldn't map to STRING 1% of your identifiers
hits <- example1_mapped$STRING_id
string_db$plot_network(hits)
```

![](data:image/png;base64...)

# 4 enrichplot

Although these above can provide us enough number of information to evaluate
the genes selected by TDbasedUFE as well as TDbasedUFEadv, one might need
all one package for which one does not how to decide which category must
be evaluated in enrichment analysis.

In this case, we would recommend Metascape(Zhou et al. [2019](#ref-Metascape)) that unfortunately
does not have the ways approached from R. Thus, we recommend RITAN as
an alternative. It can list significant ones among multiple categories.

```
edo <- enrichDGN(entrez)
dotplot(edo, showCategory=30) + ggtitle("dotplot for ORA")
```

![](data:image/png;base64...)

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#>  [1] STRINGdb_2.22.0              enrichR_3.4
#>  [3] RTCGA.clinical_20151101.39.0 RTCGA.rnaseq_20151101.39.0
#>  [5] RTCGA_1.40.0                 enrichplot_1.30.0
#>  [7] DOSE_4.4.0                   TDbasedUFEadv_1.10.0
#>  [9] TDbasedUFE_1.10.0            BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] rTensor_1.4.9           splines_4.5.1           later_1.4.4
#>   [4] bitops_1.0-9            ggplotify_0.1.3         tibble_3.3.0
#>   [7] R.oo_1.27.1             XML_3.99-0.19           lifecycle_1.0.4
#>  [10] rstatix_0.7.3           processx_3.8.6          lattice_0.22-7
#>  [13] backports_1.5.0         magrittr_2.0.4          sass_0.4.10
#>  [16] rmarkdown_2.30          jquerylib_0.1.4         yaml_2.3.10
#>  [19] plotrix_3.8-4           httpuv_1.6.16           otel_0.2.0
#>  [22] ggtangle_0.0.7          cowplot_1.2.0           chromote_0.5.1
#>  [25] DBI_1.2.3               RColorBrewer_1.1-3      abind_1.4-8
#>  [28] MOFAdata_1.25.0         rvest_1.0.5             GenomicRanges_1.62.0
#>  [31] purrr_1.1.0             R.utils_2.13.0          BiocGenerics_0.56.0
#>  [34] RCurl_1.98-1.17         hash_2.2.6.3            yulab.utils_0.2.1
#>  [37] WriteXLS_6.8.0          rappdirs_0.3.3          gdtools_0.4.4
#>  [40] IRanges_2.44.0          KMsurv_0.1-6            S4Vectors_0.48.0
#>  [43] ggrepel_0.9.6           tidytree_0.4.6          proto_1.0.0
#>  [46] codetools_0.2-20        xml2_1.4.1              tximportData_1.37.5
#>  [49] tidyselect_1.2.1        aplot_0.2.9             farver_2.1.2
#>  [52] viridis_0.6.5           stats4_4.5.1            Seqinfo_1.0.0
#>  [55] jsonlite_2.0.0          Formula_1.2-5           survival_3.8-3
#>  [58] systemfonts_1.3.1       tools_4.5.1             chron_2.3-62
#>  [61] treeio_1.34.0           Rcpp_1.1.0              glue_1.8.0
#>  [64] gridExtra_2.3           xfun_0.53               qvalue_2.42.0
#>  [67] ggthemes_5.1.0          websocket_1.4.4         dplyr_1.1.4
#>  [70] withr_3.0.2             BiocManager_1.30.26     fastmap_1.2.0
#>  [73] caTools_1.18.3          digest_0.6.37           R6_2.6.1
#>  [76] mime_0.13               gridGraphics_0.5-1      GO.db_3.22.0
#>  [79] gtools_3.9.5            dichromat_2.0-0.1       RSQLite_2.4.3
#>  [82] R.methodsS3_1.8.2       tidyr_1.3.1             generics_0.1.4
#>  [85] fontLiberation_0.1.0    data.table_1.17.8       htmlwidgets_1.6.4
#>  [88] httr_1.4.7              sqldf_0.4-11            pkgconfig_2.0.3
#>  [91] gtable_0.3.6            blob_1.2.4              S7_0.2.0
#>  [94] XVector_0.50.0          survMisc_0.5.6          htmltools_0.5.8.1
#>  [97] fontBitstreamVera_0.1.1 carData_3.0-5           bookdown_0.45
#> [100] fgsea_1.36.0            scales_1.4.0            Biobase_2.70.0
#> [103] png_0.1-8               ggfun_0.2.0             knitr_1.50
#> [106] km.ci_0.5-6             tzdb_0.5.0              reshape2_1.4.4
#> [109] rjson_0.2.23            nlme_3.1-168            curl_7.0.0
#> [112] cachem_1.1.0            zoo_1.8-14              stringr_1.5.2
#> [115] KernSmooth_2.23-26      parallel_4.5.1          AnnotationDbi_1.72.0
#> [118] pillar_1.11.1           grid_4.5.1              vctrs_0.6.5
#> [121] gplots_3.2.0            promises_1.4.0          ggpubr_0.6.2
#> [124] car_3.1-3               xtable_1.8-4            tximport_1.38.0
#> [127] evaluate_1.0.5          readr_2.1.5             gsubfn_0.7
#> [130] cli_3.6.5               compiler_4.5.1          rlang_1.1.6
#> [133] crayon_1.5.3            ggsignif_0.6.4          labeling_0.4.3
#> [136] survminer_0.5.1         ps_1.9.1                plyr_1.8.9
#> [139] fs_1.6.6                ggiraph_0.9.2           stringi_1.8.7
#> [142] viridisLite_0.4.2       BiocParallel_1.44.0     assertthat_0.2.1
#> [145] Biostrings_2.78.0       lazyeval_0.2.2          fontquiver_0.2.1
#> [148] GOSemSim_2.36.0         Matrix_1.7-4            hms_1.1.4
#> [151] patchwork_1.3.2         bit64_4.6.0-1           ggplot2_4.0.0
#> [154] KEGGREST_1.50.0         shiny_1.11.1            igraph_2.2.1
#> [157] broom_1.0.10            memoise_2.0.1           bslib_0.9.0
#> [160] ggtree_4.0.0            fastmatch_1.1-6         bit_4.6.0
#> [163] ape_5.8-1
```

Kuleshov, Maxim V., Matthew R. Jones, Andrew D. Rouillard, Nicolas F. Fernandez, Qiaonan Duan, Zichen Wang, Simon Koplev, et al. 2016. “Enrichr: a comprehensive gene set enrichment analysis web server 2016 update.” *Nucleic Acids Research* 44 (W1): W90–W97. <https://doi.org/10.1093/nar/gkw377>.

Szklarczyk, Damian, Annika L Gable, David Lyon, Alexander Junge, Stefan Wyder, Jaime Huerta-Cepas, Milan Simonovic, et al. 2018. “STRING v11: protein窶菟rotein association networks with increased coverage, supporting functional discovery in genome-wide experimental datasets.” *Nucleic Acids Research* 47 (D1): D607–D613. <https://doi.org/10.1093/nar/gky1131>.

Zhou, Yingyao, Bin Zhou, Lars Pache, Max Chang, Alireza Hadj Khodabakhshi, Olga Tanaseichuk, Christopher Benner, and Sumit K Chanda. 2019. “Metascape provides a biologist-oriented resource for the analysis of systems-level datasets.” *Nature Communications* 10 (1): 1523. <https://doi.org/10.1038/s41467-019-09234-6>.