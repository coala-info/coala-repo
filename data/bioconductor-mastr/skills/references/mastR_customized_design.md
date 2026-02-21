# mastR: Simplified Customized Design For Differential Expression Analysis

Jinjin Chen1,2\*, Ahmed Mohamed1\*\* and Chin Wee Tan1\*\*\*

1Bioinformatics Division, Walter and Eliza Hall Institute of Medical Research, Parkville, VIC 3052, Australia
2Department of Medical Biology, University of Melbourne, Parkville, VIC 3010, Australia

\*chen.j@wehi.edu.au
\*\*mohamed.a@wehi.edu.au
\*\*\*cwtan@wehi.edu.au

#### 26 Jan 2026

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Example](#example)
  + [3.1 1. Customized contrast matrix](#customized-contrast-matrix)
  + [3.2 2. Process data](#process-data)
  + [3.3 3. Results](#results)
  + [3.4 Visualization](#visualization)
* [4 Session Info](#session-info)

# 1 Introduction

---

**Simplified Customized Design For Differential Expression Analysis**

`mastR` provides a simplified customized contrast design for differential expression analysis, which can help users handle the complex experimental design and data structure in one simple function call.

The function `process_data()` in `mastR` allows users to pass a customized contrast matrix to the function, which can give users more flexibility.

# 2 Installation

---

`mastR` R package can be installed from Bioconductor or [GitHub](https://github.com/DavisLaboratory/mastR).

The most updated version of `mastR` is hosted on GitHub and can be installed using `devtools::install_github()` function provided by [devtools](https://cran.r-project.org/package%3Ddevtools).

```
# if (!requireNamespace("devtools", quietly = TRUE)) {
#   install.packages("devtools")
# }
# if (!requireNamespace("mastR", quietly = TRUE)) {
#   devtools::install_github("DavisLaboratory/mastR")
# }

if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
if (!requireNamespace("mastR", quietly = TRUE)) {
  BiocManager::install("mastR")
}
packages <- c(
  "BiocStyle",
  "clusterProfiler",
  "ComplexHeatmap",
  "depmap",
  "enrichplot",
  "ggrepel",
  "Glimma",
  "gridExtra",
  "jsonlite",
  "knitr",
  "rmarkdown",
  "RobustRankAggreg",
  "rvest",
  "singscore",
  "UpSetR"
)
for (i in packages) {
  if (!requireNamespace(i, quietly = TRUE)) {
    install.packages(i)
  }
  if (!requireNamespace(i, quietly = TRUE)) {
    BiocManager::install(i)
  }
}
```

```
library(mastR)
library(edgeR)
library(ggplot2)
library(GSEABase)
```

# 3 Example

---

Here we use the example data `im_data_6` from [GSE60424](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE60424) (Download using `GEOquery::getGEO()`), consisting of immune cells from healthy individuals.

`im_data_6` is a `eSet` object, containing RNA-seq TMM normalized counts data of 6 sorted immune cell types each with 4 samples. More details in `?mastR::im_data_6`.

```
data("im_data_6")
im_data_6
#> ExpressionSet (storageMode: lockedEnvironment)
#> assayData: 50045 features, 24 samples
#>   element names: exprs
#> protocolData: none
#> phenoData
#>   sampleNames: GSM1479438 GSM1479439 ... GSM1479525 (24 total)
#>   varLabels: title geo_accession ... years since diagnosis:ch1 (66
#>     total)
#>   varMetadata: labelDescription
#> featureData: none
#> experimentData: use 'experimentData(object)'
#>   pubMedIds: 25314013
#> Annotation: GPL15456
```

## 3.1 1. Customized contrast matrix

The customized contrast matrix can be created using `makeContrasts()` function from *[limma](https://bioconductor.org/packages/3.22/limma)* package.

Users can create the customized contrast matrix manually by specifying the contrast names and the levels of the groups.

```
## DE of NK vs B and B vs T
con_mat <- makeContrasts(
  'NK-CD4' = 'NK - CD4',
  'NK-T' = 'NK - (CD4 + CD8)/2',
  levels = levels(factor(make.names(im_data_6$`celltype:ch1`)))
)
con_mat
#>              Contrasts
#> Levels        NK-CD4 NK-T
#>   B.cells          0  0.0
#>   CD4             -1 -0.5
#>   CD8              0 -0.5
#>   Monocytes        0  0.0
#>   NK               1  1.0
#>   Neutrophils      0  0.0
```

However, it is important to note that the levels of the groups should be consistent with the levels of the groups in the expression matrix. Otherwise, the contrast matrix will not be correct and the analysis will stop with an error.

So it is recommended and safer to create the customized contrast matrix from the design matrix generated from `process_data()` function.

What we need to do is to first process the data using `process_data()` function with random target group, then extract the design matrix from the `proc_data` object.

Next, we can create the customized contrast matrix from the design matrix.

```
proc_data <- mastR::process_data(
  im_data_6,
  group_col = 'celltype:ch1',
  target_group = 'NK',
  summary = FALSE,
  gene_id = "ENSEMBL" ## rownames of im_data_6 is ENSEMBL ID
)
con_mat2 <- makeContrasts(
  'NK-CD4' = 'NK - CD4',
  'NK-T' = 'NK - (CD4 + CD8)/2',
  levels = proc_data$vfit$design
)
con_mat2
#>              Contrasts
#> Levels        NK-CD4 NK-T
#>   B.cells          0  0.0
#>   CD4             -1 -0.5
#>   CD8              0 -0.5
#>   Monocytes        0  0.0
#>   NK               1  1.0
#>   Neutrophils      0  0.0

identical(con_mat, con_mat2)
#> [1] TRUE
```

## 3.2 2. Process data

Then, we can use the `process_data()` function to obtain the DE results with the customized contrast design.

At this point, the DE analysis is performed based on the customized contrast design, regardless of the target group.

```
proc_data <- mastR::process_data(
  im_data_6,
  group_col = 'celltype:ch1',
  target_group = 'NK',
  contrast_mat = con_mat, ## specify contrast of NK vs B and B vs T
  summary = TRUE,
  gene_id = "ENSEMBL" ## rownames of im_data_6 is ENSEMBL ID
)
#>        NK-CD4 NK-T
#> Down     2697 2673
#> NotSig   4980 4941
#> Up       2734 2797

## plot mean-var
mastR::plot_mean_var(proc_data)
```

![](data:image/png;base64...)

## 3.3 3. Results

The DE results are stored in the `proc_data` object and can be easily accessed via `proc_data$tfit`.

```
## contrast names
colnames(proc_data$tfit)
#> [1] "NK-CD4" "NK-T"

## DE results for 'NK-B' contrast
na.omit(limma::topTreat(
  proc_data$tfit,
  coef = 1, # or 'NK-B' for the first contrast
  number = Inf # get all DE results
)) |> head()
#>                     logFC  AveExpr         t      P.Value    adj.P.Val
#> ENSG00000137078 -5.862090 1.745241 -27.64230 1.490757e-18 8.621116e-15
#> ENSG00000229164 -5.277424 3.816770 -27.04422 2.378348e-18 8.621116e-15
#> ENSG00000167286 -5.686564 2.309187 -26.82976 2.818723e-18 8.621116e-15
#> ENSG00000172673 -6.208731 1.783905 -26.59978 3.386801e-18 8.621116e-15
#> ENSG00000160185 -6.267757 1.707258 -26.35026 4.140388e-18 8.621116e-15
#> ENSG00000135083  5.970905 1.559721  25.52403 8.158444e-18 1.187977e-14
```

Of course, users can also use the `get_de_table()` function to easily get all DE result tables for all contrasts on a single call.

```
## DE results for all contrasts
DE_table <- mastR::get_de_table(
  im_data_6,
  group_col = 'celltype:ch1',
  target_group = 'NK',
  contrast_mat = con_mat, ## specify contrast of NK vs B and B vs T
  summary = TRUE,
  gene_id = "ENSEMBL" ## rownames of im_data_6 is ENSEMBL ID
)
#>        NK-CD4 NK-T
#> Down     2697 2673
#> NotSig   4980 4941
#> Up       2734 2797
names(DE_table)
#> [1] "NK-CD4" "NK-T"

head(DE_table[[1]])
#>                     logFC  AveExpr         t      P.Value    adj.P.Val
#> ENSG00000137078 -5.862090 1.745241 -27.64230 1.490757e-18 8.621116e-15
#> ENSG00000229164 -5.277424 3.816770 -27.04422 2.378348e-18 8.621116e-15
#> ENSG00000167286 -5.686564 2.309187 -26.82976 2.818723e-18 8.621116e-15
#> ENSG00000172673 -6.208731 1.783905 -26.59978 3.386801e-18 8.621116e-15
#> ENSG00000160185 -6.267757 1.707258 -26.35026 4.140388e-18 8.621116e-15
#> ENSG00000135083  5.970905 1.559721  25.52403 8.158444e-18 1.187977e-14
```

## 3.4 Visualization

Users can use the `glimmaMDS()`, `glimmaMA()`, and `glimmaVolcano()` functions from *[Glimma](https://bioconductor.org/packages/3.22/Glimma)* package to visualize the data and DE results interactively.

```
## MDS plot
Glimma::glimmaMDS(proc_data)

## MA plot
Glimma::glimmaMA(proc_data$tfit, dge = proc_data)

## volcano plot
Glimma::glimmaVolcano(proc_data$tfit, dge = proc_data)
```

# 4 Session Info

---

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] singscore_1.30.0            tidyr_1.3.2
#>  [3] dplyr_1.1.4                 splatter_1.34.0
#>  [5] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [7] GenomicRanges_1.62.1        Seqinfo_1.0.0
#>  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [11] GSEABase_1.72.0             graph_1.88.1
#> [13] annotate_1.88.0             XML_3.99-0.20
#> [15] AnnotationDbi_1.72.0        IRanges_2.44.0
#> [17] S4Vectors_0.48.0            Biobase_2.70.0
#> [19] BiocGenerics_0.56.0         generics_0.1.4
#> [21] ggplot2_4.0.1               edgeR_4.8.2
#> [23] limma_3.66.0                mastR_1.10.2
#> [25] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.2           ggplotify_0.1.3         tibble_3.3.1
#>   [4] R.oo_1.27.1             polyclip_1.10-7         lifecycle_1.0.5
#>   [7] rstatix_0.7.3           doParallel_1.0.17       MASS_7.3-65
#>  [10] globals_0.18.0          lattice_0.22-7          backports_1.5.0
#>  [13] magrittr_2.0.4          sass_0.4.10             rmarkdown_2.30
#>  [16] jquerylib_0.1.4         yaml_2.3.12             otel_0.2.0
#>  [19] ggtangle_0.1.1          spam_2.11-3             sp_2.2-0
#>  [22] ggvenn_0.1.19           cowplot_1.2.0           DBI_1.2.3
#>  [25] RColorBrewer_1.1-3      abind_1.4-8             purrr_1.2.1
#>  [28] R.utils_2.13.0          yulab.utils_0.2.3       tweenr_2.0.3
#>  [31] rappdirs_0.3.4          gdtools_0.4.4           circlize_0.4.17
#>  [34] enrichplot_1.30.4       ggrepel_0.9.6           listenv_0.10.0
#>  [37] tidytree_0.4.7          parallelly_1.46.1       codetools_0.2-20
#>  [40] DelayedArray_0.36.0     scuttle_1.20.0          ggforce_0.5.0
#>  [43] DOSE_4.4.0              tidyselect_1.2.1        shape_1.4.6.1
#>  [46] aplot_0.2.9             farver_2.1.2            jsonlite_2.0.0
#>  [49] GetoptLong_1.1.0        progressr_0.18.0        Formula_1.2-5
#>  [52] RobustRankAggreg_1.2.1  iterators_1.0.14        systemfonts_1.3.1
#>  [55] foreach_1.5.2           tools_4.5.2             ggnewscale_0.5.2
#>  [58] treeio_1.34.0           Rcpp_1.1.1              glue_1.8.0
#>  [61] gridExtra_2.3           SparseArray_1.10.8      xfun_0.56
#>  [64] qvalue_2.42.0           withr_3.0.2             BiocManager_1.30.27
#>  [67] fastmap_1.2.0           digest_0.6.39           R6_2.6.1
#>  [70] gridGraphics_0.5-1      colorspace_2.1-2        GO.db_3.22.0
#>  [73] Cairo_1.7-0             dichromat_2.0-0.1       RSQLite_2.4.5
#>  [76] R.methodsS3_1.8.2       UpSetR_1.4.0            utf8_1.2.6
#>  [79] fontLiberation_0.1.0    data.table_1.18.0       htmlwidgets_1.6.4
#>  [82] msigdb_1.18.0           httr_1.4.7              S4Arrays_1.10.1
#>  [85] scatterpie_0.2.6        pkgconfig_2.0.3         gtable_0.3.6
#>  [88] blob_1.3.0              ComplexHeatmap_2.26.0   S7_0.2.1
#>  [91] XVector_0.50.0          clusterProfiler_4.18.4  htmltools_0.5.9
#>  [94] fontBitstreamVera_0.1.1 carData_3.0-5           dotCall64_1.2
#>  [97] bookdown_0.46           fgsea_1.36.2            clue_0.3-66
#> [100] SeuratObject_5.3.0      scales_1.4.0            png_0.1-8
#> [103] ggfun_0.2.0             knitr_1.51              reshape2_1.4.5
#> [106] rjson_0.2.23            checkmate_2.3.3         nlme_3.1-168
#> [109] org.Hs.eg.db_3.22.0     cachem_1.1.0            GlobalOptions_0.1.3
#> [112] stringr_1.6.0           parallel_4.5.2          pillar_1.11.1
#> [115] grid_4.5.2              vctrs_0.7.1             ggpubr_0.6.2
#> [118] tidydr_0.0.6            car_3.1-3               beachmat_2.26.0
#> [121] xtable_1.8-4            cluster_2.1.8.1         evaluate_1.0.5
#> [124] tinytex_0.58            magick_2.9.0            cli_3.6.5
#> [127] locfit_1.5-9.12         compiler_4.5.2          rlang_1.1.7
#> [130] crayon_1.5.3            future.apply_1.20.1     ggsignif_0.6.4
#> [133] labeling_0.4.3          plyr_1.8.9              fs_1.6.6
#> [136] ggiraph_0.9.3           stringi_1.8.7           BiocParallel_1.44.0
#> [139] Biostrings_2.78.0       lazyeval_0.2.2          fontquiver_0.2.1
#> [142] GOSemSim_2.36.0         Matrix_1.7-4            patchwork_1.3.2
#> [145] bit64_4.6.0-1           future_1.69.0           KEGGREST_1.50.0
#> [148] statmod_1.5.1           igraph_2.2.1            broom_1.0.11
#> [151] memoise_2.0.1           bslib_0.10.0            ggtree_4.0.4
#> [154] fastmatch_1.1-8         bit_4.6.0               gson_0.1.0
#> [157] ape_5.8-1
```