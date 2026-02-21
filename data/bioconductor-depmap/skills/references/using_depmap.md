# Using the depmap data

Theo Killian and Laurent Gatto1

1Computational Biology, UCLouvain

#### 2025-11-18

This vignette illustrates use cases and visualizations of the data
found in the [depmap](https://bioconductor.org/packages/devel/data/experiment/html/depmap.html)
package. See the *depmap* vignette for details about the datasets.

# 1 Introduction

The [depmap](https://bioconductor.org/packages/devel/data/experiment/html/depmap.html)
package aims to provide a reproducible research framework to cancer dependency
data described by [Tsherniak, Aviad, et al. “Defining a cancer dependency map.”
Cell 170.3 (2017): 564-576.](https://www.ncbi.nlm.nih.gov/pubmed/28753430). The
data found in the [depmap](https://bioconductor.org/packages/devel/data/experiment/html/depmap.html)
package has been formatted to facilitate the use of common R packages such as
`dplyr` and `ggplot2`. We hope that this package will allow researchers to more
easily mine, explore and visually illustrate dependency data taken from the
Depmap cancer genomic dependency study.

# 2 Use cases

Perhaps the most interesting datasets found within the
[depmap](https://bioconductor.org/packages/devel/data/experiment/html/depmap.html)
package are those that relate to the cancer gene dependency score, such as
`rnai` and `crispr`. These datasets contain a score expressing how vital a
particular gene is in terms of how lethal the knockout/knockdown of that gene is
on a target cell line. For example, a highly negative dependency score implies
that a cell line is highly dependent on that gene.

Load necessary libaries.

```
library("dplyr")
library("ggplot2")
library("viridis")
library("tibble")
library("gridExtra")
library("stringr")
library("depmap")
library("ExperimentHub")
```

Load the `rnai`, `crispr` and `copyNumber` datasets for visualization. Note: the
datasets listed below are from the 19Q3 release. Newer datasets, such as those
from the 20Q1 release are available.

```
## create ExperimentHub query object
eh <- ExperimentHub()
query(eh, "depmap")
```

```
## ExperimentHub with 82 records
## # snapshotDate(): 2025-10-07
## # $dataprovider: Broad Institute
## # $species: Homo sapiens
## # $rdataclass: tibble
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH2260"]]'
##
##            title
##   EH2260 | rnai_19Q1
##   EH2261 | crispr_19Q1
##   EH2262 | copyNumber_19Q1
##   EH2263 | RPPA_19Q1
##   EH2264 | TPM_19Q1
##   ...      ...
##   EH7555 | copyNumber_22Q2
##   EH7556 | TPM_22Q2
##   EH7557 | mutationCalls_22Q2
##   EH7558 | metadata_22Q2
##   EH7559 | achilles_22Q2
```

```
rnai <- eh[["EH3080"]]
mutationCalls <- eh[["EH3085"]]
```

```
metadata <- eh[["EH3086"]]
```

```
TPM <- eh[["EH3084"]]
```

```
copyNumber <- eh[["EH3082"]]
```

```
# crispr <- eh[["EH3081"]]
# drug_sensitivity <- eh[["EH3087"]]
```

By importing the `depmap` data into the R environment, the data can be mined
more effectively. For example, if one interested researching soft tissue
sarcomas and wanted to search all such cancer cell lines for the gene with the
greatest dependency, it is possible to accomplish this task by using data
manipulation and visualization tools `dplyr` and `ggplot2`. Below, the `rnai`
dataset is selected for cell lines with *“SOFT\_TISSUE”* in the CCLE name, and
displaying a list of the highest dependency scores.

```
## list of dependency scores
rnai |>
    dplyr::select(cell_line, gene_name, dependency) |>
    dplyr::filter(stringr::str_detect(cell_line, "SOFT_TISSUE")) |>
    dplyr::arrange(dependency) |>
    head(10)
```

```
## # A tibble: 10 × 3
##    cell_line          gene_name dependency
##    <chr>              <chr>          <dbl>
##  1 FUJI_SOFT_TISSUE   RPL14          -3.60
##  2 SJRH30_SOFT_TISSUE RAN            -3.41
##  3 SJRH30_SOFT_TISSUE RPL14          -3.36
##  4 SJRH30_SOFT_TISSUE RBX1           -3.31
##  5 HS729_SOFT_TISSUE  PSMA3          -3.22
##  6 SJRH30_SOFT_TISSUE RUVBL2         -3.13
##  7 KYM1_SOFT_TISSUE   RPL14          -3.03
##  8 RH41_SOFT_TISSUE   RBX1           -3.01
##  9 HS729_SOFT_TISSUE  NUTF2          -2.90
## 10 SJRH30_SOFT_TISSUE NUTF2          -2.85
```

As the gene `RPL14` appears several times in the top dependencies scores, it may
make an interesting candidate target. Below, a plot of the `rnai` data is
displayed as a histogram showing the distribution of dependency scores for gene
`RPL14`.

```
## Basic histogram
rnai |>
    dplyr::select(gene, gene_name, dependency) |>
    dplyr::filter(gene_name == "RPL14") |>
    ggplot(aes(x = dependency)) +
    geom_histogram() +
    geom_vline(xintercept = mean(rnai$dependency, na.rm = TRUE),
               linetype = "dotted", color = "red") +
    ggtitle("Histogram of dependency scores for gene RPL14")
```

![](data:image/png;base64...)

A more complex plot of the `rnai` data, as shown below involves plotting the
distribution of dependency scores for gene `RPL14` for each major type of
cancer, while highlighting the nature of mutations of this gene in such cancer
cell lines (e.g. if such are COSMIC hotspots, damaging, etc.). Notice that the
plot above reflects the same overall distribution in two dimensions.

```
meta_rnai <- metadata |>
    dplyr::select(depmap_id, lineage) |>
    dplyr::full_join(rnai, by = "depmap_id") |>
    dplyr::filter(gene_name == "RPL14") |>
    dplyr::full_join((mutationCalls |>
                      dplyr::select(depmap_id, entrez_id,
                                    is_cosmic_hotspot, var_annotation)),
                     by = c("depmap_id", "entrez_id"))

p1 <- meta_rnai |>
      ggplot(aes(x = dependency, y = lineage)) +
      geom_point(alpha = 0.4, size = 0.5) +
      geom_point(data = subset(
         meta_rnai, var_annotation == "damaging"), color = "red") +
      geom_point(data = subset(
         meta_rnai, var_annotation == "other non-conserving"), color = "blue") +
      geom_point(data = subset(
         meta_rnai, var_annotation == "other conserving"), color = "cyan") +
      geom_point(data = subset(
         meta_rnai, is_cosmic_hotspot == TRUE), color = "orange") +
      geom_vline(xintercept=mean(meta_rnai$dependency, na.rm = TRUE),
                 linetype = "dotted", color = "red") +
      ggtitle("Scatterplot of dependency scores for gene RPL14 by lineage")

p1
```

![](data:image/png;base64...)

Below is a boxplot displaying expression values for gene `RPL14` by lineage:

```
metadata |>
    dplyr::select(depmap_id, lineage) |>
    dplyr::full_join(TPM, by = "depmap_id") |>
    dplyr::filter(gene_name == "RPL14") |>
    ggplot(aes(x = lineage, y = expression, fill = lineage)) +
    geom_boxplot(outlier.alpha = 0.1) +
    ggtitle("Boxplot of expression values for gene RPL14 by lineage") +
    theme(axis.text.x = element_text(angle = 45, hjust=1)) +
    theme(legend.position = "none")
```

![](data:image/png;base64...)

High dependency, high expression genes are more likely to interesting research
targets. Below is a plot of expression vs rnai gene dependency for
Rhabdomyosarcoma Sarcoma:

```
## expression vs rnai gene dependency for Rhabdomyosarcoma Sarcoma
sarcoma <- metadata |>
    dplyr::select(depmap_id, cell_line,
                  primary_disease, subtype_disease) |>
    dplyr::filter(primary_disease == "Sarcoma",
                  subtype_disease == "Rhabdomyosarcoma")

rnai_sub <- rnai |>
    dplyr::select(depmap_id, gene, gene_name, dependency)
tpm_sub <- TPM |>
    dplyr::select(depmap_id, gene, gene_name, expression)

sarcoma_dep <- sarcoma |>
    dplyr::left_join(rnai_sub, by = "depmap_id") |>
    dplyr::select(-cell_line, -primary_disease,
                  -subtype_disease, -gene_name)

sarcoma_exp <- sarcoma |>
    dplyr::left_join(tpm_sub, by = "depmap_id")

sarcoma_dat_exp <- dplyr::full_join(sarcoma_dep, sarcoma_exp,
                                    by = c("depmap_id", "gene")) |>
    dplyr::filter(!is.na(expression))

p2 <- ggplot(data = sarcoma_dat_exp, aes(x = dependency, y = expression)) +
    geom_point(alpha = 0.4, size = 0.5) +
    geom_vline(xintercept=mean(sarcoma_dat_exp$dependency, na.rm = TRUE),
               linetype = "dotted", color = "red") +
    geom_hline(yintercept=mean(sarcoma_dat_exp$expression, na.rm = TRUE),
               linetype = "dotted", color = "red") +
    ggtitle("Scatterplot of rnai dependency vs expression values for gene")

p2 + theme(axis.text.x = element_text(angle = 45))
```

![](data:image/png;base64...)

A selection of the genes shown above with the lowest depenency scores, also
displaying gene expression in TPM in the last column.

```
sarcoma_dat_exp |>
    dplyr::select(cell_line, gene_name, dependency, expression) |>
    dplyr::arrange(dependency) |>
    head(10)
```

```
## # A tibble: 10 × 4
##    cell_line        gene_name dependency expression
##    <chr>            <chr>          <dbl>      <dbl>
##  1 A204_SOFT_TISSUE RPS27A         -2.62      10.6
##  2 A204_SOFT_TISSUE RPL14          -2.34      10.0
##  3 A204_SOFT_TISSUE RPL7           -2.23      11.5
##  4 A204_SOFT_TISSUE RPS16          -2.08      11.2
##  5 A204_SOFT_TISSUE RPS15A         -1.92      11.6
##  6 A204_SOFT_TISSUE RBX1           -1.91       6.51
##  7 A204_SOFT_TISSUE SF3B2          -1.80       7.47
##  8 A204_SOFT_TISSUE RPL5           -1.79      10.7
##  9 A204_SOFT_TISSUE RPS3A          -1.77      11.4
## 10 A204_SOFT_TISSUE RPL13          -1.68      11.6
```

Below is a boxplot displaying log genomic copy number for gene `RPL14` by
lineage:

```
metadata |>
    dplyr::select(depmap_id, lineage) |>
    dplyr::full_join(copyNumber, by = "depmap_id") |>
    dplyr::filter(gene_name == "RPL14") |>
    ggplot(aes(x = lineage, y = log_copy_number, fill = lineage)) +
    geom_boxplot(outlier.alpha = 0.1) +
    ggtitle("Boxplot of log copy number for gene RPL14 by lineage") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(legend.position = "none")
```

![](data:image/png;base64...)

# 3 Session information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] gridExtra_2.3       viridis_0.6.5       viridisLite_0.4.2
##  [4] ExperimentHub_3.0.0 AnnotationHub_4.0.0 BiocFileCache_3.0.0
##  [7] dbplyr_2.5.1        BiocGenerics_0.56.0 generics_0.1.4
## [10] depmap_1.24.0       lubridate_1.9.4     forcats_1.0.1
## [13] stringr_1.6.0       dplyr_1.1.4         purrr_1.2.0
## [16] readr_2.1.6         tidyr_1.3.1         tibble_3.3.0
## [19] ggplot2_4.0.1       tidyverse_2.0.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1     farver_2.1.2         blob_1.2.4
##  [4] filelock_1.0.3       Biostrings_2.78.0    S7_0.2.1
##  [7] fastmap_1.2.0        digest_0.6.38        timechange_0.3.0
## [10] lifecycle_1.0.4      KEGGREST_1.50.0      RSQLite_2.4.4
## [13] magrittr_2.0.4       compiler_4.5.2       rlang_1.1.6
## [16] sass_0.4.10          tools_4.5.2          utf8_1.2.6
## [19] yaml_2.3.10          knitr_1.50           labeling_0.4.3
## [22] bit_4.6.0            curl_7.0.0           RColorBrewer_1.1-3
## [25] withr_3.0.2          grid_4.5.2           stats4_4.5.2
## [28] scales_1.4.0         dichromat_2.0-0.1    tinytex_0.57
## [31] cli_3.6.5            rmarkdown_2.30       crayon_1.5.3
## [34] httr_1.4.7           tzdb_0.5.0           DBI_1.2.3
## [37] cachem_1.1.0         parallel_4.5.2       AnnotationDbi_1.72.0
## [40] BiocManager_1.30.27  XVector_0.50.0       vctrs_0.6.5
## [43] jsonlite_2.0.0       bookdown_0.45        IRanges_2.44.0
## [46] hms_1.1.4            S4Vectors_0.48.0     bit64_4.6.0-1
## [49] archive_1.1.12       magick_2.9.0         jquerylib_0.1.4
## [52] glue_1.8.0           stringi_1.8.7        gtable_0.3.6
## [55] BiocVersion_3.22.0   pillar_1.11.1        rappdirs_0.3.3
## [58] htmltools_0.5.8.1    Seqinfo_1.0.0        R6_2.6.1
## [61] httr2_1.2.1          vroom_1.6.6          evaluate_1.0.5
## [64] Biobase_2.70.0       png_0.1-8            memoise_2.0.1
## [67] bslib_0.9.0          Rcpp_1.1.0           xfun_0.54
## [70] pkgconfig_2.0.3
```