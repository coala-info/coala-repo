# Get Started

Pol Castellano-Escuder, Ph.D.1\*

1Duke University

\*polcaes@gmail.com

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Load POMA](#load-poma)
* [3 The POMA Workflow](#the-poma-workflow)
  + [3.1 Data Preparation](#data-preparation)
  + [3.2 Pre Processing](#pre-processing)
    - [3.2.1 Missing Value Imputation](#missing-value-imputation)
    - [3.2.2 Normalization](#normalization)
    - [3.2.3 Outlier Detection](#outlier-detection)
* [4 Session Information](#session-information)
* [References](#references)

**Compiled date**: 2025-10-30

**Last edited**: 2024-01-21

**License**: GPL-3

# 1 Installation

To install the Bioconductor version of the POMA package, run the following code:

```
# install.packages("BiocManager")
BiocManager::install("POMA")
```

# 2 Load POMA

```
library(POMA)
library(ggtext)
library(magrittr)
```

# 3 The POMA Workflow

The `POMA` package functions are organized into three sequential, distinct blocks: Data Preparation, Pre-processing, and Statistical Analysis.

## 3.1 Data Preparation

The `SummarizedExperiment` package from Bioconductor offers well-defined computational data structures for representing various types of omics experiment data (Morgan et al. [2020](#ref-SummarizedExperiment)). Utilizing these data structures can significantly improve data analysis. `POMA` leverages `SummarizedExperiment` objects, enhancing the reusability of existing methods for this class and contributing to more robust and reproducible workflows.

The workflow begins with either loading or creating a `SummarizedExperiment` object. Typically, your data might be stored in separate matrices and/or data frames. The `PomaCreateObject` function simplifies this step by quickly building a SummarizedExperiment object for you.

```
# create an SummarizedExperiment object from two separated data frames
target <- readr::read_csv("your_target.csv")
features <- readr::read_csv("your_features.csv")

data <- PomaCreateObject(metadata = target, features = features)
```

Alternatively, if your data is already in a `SummarizedExperiment` object, you can proceed directly to the pre-processing step. This vignette uses example data provided in `POMA`.

```
# load example data
data("st000336")
```

```
st000336
> class: SummarizedExperiment
> dim: 31 57
> metadata(0):
> assays(1): ''
> rownames(31): x1_methylhistidine x3_methylhistidine ... pyruvate
>   succinate
> rowData names(0):
> colnames(57): 1 2 ... 56 57
> colData names(2): group steroids
```

## 3.2 Pre Processing

### 3.2.1 Missing Value Imputation

```
imputed <- st000336 %>%
  PomaImpute(method = "knn", zeros_as_na = TRUE, remove_na = TRUE, cutoff = 20)
> 2 features removed.

imputed
> class: SummarizedExperiment
> dim: 29 57
> metadata(0):
> assays(1): ''
> rownames(29): x1_methylhistidine x3_methylhistidine ... pyruvate
>   succinate
> rowData names(0):
> colnames(57): 1 2 ... 56 57
> colData names(2): group steroids
```

### 3.2.2 Normalization

```
normalized <- imputed %>%
  PomaNorm(method = "log_pareto")

normalized
> class: SummarizedExperiment
> dim: 29 57
> metadata(0):
> assays(1): ''
> rownames(29): x1_methylhistidine x3_methylhistidine ... pyruvate
>   succinate
> rowData names(0):
> colnames(57): 1 2 ... 56 57
> colData names(2): group steroids
```

#### 3.2.2.1 Normalization effect

```
PomaBoxplots(imputed, x = "samples") # data before normalization
```

![](data:image/png;base64...)

```
PomaBoxplots(normalized, x = "samples") # data after normalization
```

![](data:image/png;base64...)

```
PomaDensity(imputed, x = "features") # data before normalization
```

![](data:image/png;base64...)

```
PomaDensity(normalized, x = "features") # data after normalization
```

![](data:image/png;base64...)

### 3.2.3 Outlier Detection

```
PomaOutliers(normalized)$polygon_plot
```

![](data:image/png;base64...)

```
pre_processed <- PomaOutliers(normalized)$data
pre_processed
> class: SummarizedExperiment
> dim: 29 52
> metadata(0):
> assays(1): ''
> rownames(29): x1_methylhistidine x3_methylhistidine ... pyruvate
>   succinate
> rowData names(0):
> colnames(52): 1 2 ... 56 57
> colData names(2): group steroids
```

```
# pre_processed %>%
#   PomaUnivariate(method = "ttest") %>%
#   magrittr::extract2("result")
```

```
# imputed %>%
#   PomaVolcano(pval = "adjusted", labels = TRUE)
```

```
# pre_processed %>%
#   PomaUnivariate(method = "mann") %>%
#   magrittr::extract2("result")
```

```
# PomaLimma(pre_processed, contrast = "Controls-DMD", adjust = "fdr")
```

```
# poma_pca <- PomaMultivariate(pre_processed, method = "pca")
```

```
# poma_pca$scoresplot +
#   ggplot2::ggtitle("Scores Plot")
```

```
# poma_plsda <- PomaMultivariate(pre_processed, method = "plsda")
```

```
# poma_plsda$scoresplot +
#   ggplot2::ggtitle("Scores Plot")
```

```
# poma_plsda$errors_plsda_plot +
#   ggplot2::ggtitle("Error Plot")
```

```
# poma_cor <- PomaCorr(pre_processed, label_size = 8, coeff = 0.6)
# poma_cor$correlations
# poma_cor$corrplot
# poma_cor$graph
```

```
# PomaCorr(pre_processed, corr_type = "glasso", coeff = 0.6)$graph
```

```
# alpha = 1 for Lasso
# PomaLasso(pre_processed, alpha = 1, labels = TRUE)$coefficientPlot
```

```
# poma_rf <- PomaRandForest(pre_processed, ntest = 10, nvar = 10)
# poma_rf$error_tree
```

```
# poma_rf$confusionMatrix$table
```

```
# poma_rf$MeanDecreaseGini_plot
```

# 4 Session Information

```
sessionInfo()
> R version 4.5.1 Patched (2025-08-23 r88802)
> Platform: x86_64-pc-linux-gnu
> Running under: Ubuntu 24.04.3 LTS
>
> Matrix products: default
> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
>
> locale:
>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
>  [3] LC_TIME=en_GB              LC_COLLATE=C
>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
>
> time zone: America/New_York
> tzcode source: system (glibc)
>
> attached base packages:
> [1] stats     graphics  grDevices utils     datasets  methods   base
>
> other attached packages:
> [1] magrittr_2.0.4   patchwork_1.3.2  ggtext_0.1.2     POMA_1.20.0
> [5] BiocStyle_2.38.0
>
> loaded via a namespace (and not attached):
>  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
>  [3] impute_1.84.0               xfun_0.53
>  [5] bslib_0.9.0                 ggplot2_4.0.0
>  [7] Biobase_2.70.0              lattice_0.22-7
>  [9] vctrs_0.6.5                 tools_4.5.1
> [11] generics_0.1.4              parallel_4.5.1
> [13] stats4_4.5.1                tibble_3.3.0
> [15] cluster_2.1.8.1             pkgconfig_2.0.3
> [17] Matrix_1.7-4                RColorBrewer_1.1-3
> [19] S7_0.2.0                    S4Vectors_0.48.0
> [21] lifecycle_1.0.4             compiler_4.5.1
> [23] farver_2.1.2                stringr_1.5.2
> [25] tinytex_0.57                Seqinfo_1.0.0
> [27] permute_0.9-8               litedown_0.7
> [29] htmltools_0.5.8.1           sass_0.4.10
> [31] yaml_2.3.10                 pillar_1.11.1
> [33] jquerylib_0.1.4             tidyr_1.3.1
> [35] MASS_7.3-65                 cachem_1.1.0
> [37] DelayedArray_0.36.0         vegan_2.7-2
> [39] magick_2.9.0                abind_1.4-8
> [41] nlme_3.1-168                commonmark_2.0.0
> [43] tidyselect_1.2.1            digest_0.6.37
> [45] stringi_1.8.7               dplyr_1.1.4
> [47] purrr_1.1.0                 bookdown_0.45
> [49] splines_4.5.1               labeling_0.4.3
> [51] fastmap_1.2.0               grid_4.5.1
> [53] cli_3.6.5                   SparseArray_1.10.0
> [55] S4Arrays_1.10.0             dichromat_2.0-0.1
> [57] withr_3.0.2                 scales_1.4.0
> [59] rmarkdown_2.30              XVector_0.50.0
> [61] matrixStats_1.5.0           evaluate_1.0.5
> [63] knitr_1.50                  GenomicRanges_1.62.0
> [65] IRanges_2.44.0              viridisLite_0.4.2
> [67] mgcv_1.9-3                  markdown_2.0
> [69] rlang_1.1.6                 gridtext_0.1.5
> [71] Rcpp_1.1.0                  glue_1.8.0
> [73] BiocManager_1.30.26         xml2_1.4.1
> [75] BiocGenerics_0.56.0         jsonlite_2.0.0
> [77] R6_2.6.1                    MatrixGenerics_1.22.0
```

# References

Morgan, Martin, Valerie Obenchain, Jim Hester, and Hervé Pagès. 2020. *SummarizedExperiment: SummarizedExperiment Container*. <https://bioconductor.org/packages/SummarizedExperiment>.