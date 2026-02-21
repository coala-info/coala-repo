# Normalization Methods

Pol Castellano-Escuder, Ph.D.1\*

1Duke University

\*polcaes@gmail.com

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Load Packages](#load-packages)
* [3 Load Data and Imputation](#load-data-and-imputation)
* [4 Normalization](#normalization)
  + [4.1 Normalization effect on data dimensions](#normalization-effect-on-data-dimensions)
  + [4.2 Normalization effect on samples](#normalization-effect-on-samples)
  + [4.3 Normalization effect on features](#normalization-effect-on-features)
* [5 Session Information](#session-information)
* [References](#references)

**Compiled date**: 2025-10-30

**Last edited**: 2023-12-14

**License**: GPL-3

# 1 Installation

Run the following code to install the Bioconductor version of package.

```
# install.packages("BiocManager")
BiocManager::install("POMA")
```

# 2 Load Packages

```
library(POMA)
library(ggtext)
library(patchwork)
```

# 3 Load Data and Imputation

Let’s create a cleaned `SummarizedExperiment` object from the sample data `st000336` to explore the normalization effects.

```
example_data <- st000336 %>%
  PomaImpute() # KNN imputation
Loading required namespace: SummarizedExperiment
2 features removed.

example_data
class: SummarizedExperiment
dim: 29 57
metadata(0):
assays(1): ''
rownames(29): x1_methylhistidine x3_methylhistidine ... pyruvate
  succinate
rowData names(0):
colnames(57): 1 2 ... 56 57
colData names(2): group steroids
```

# 4 Normalization

Here we will evaluate the normalization methods that POMA offers on the same `SummarizedExperiment` object to compare them (Berg et al. [2006](#ref-normalization)).

```
none <- PomaNorm(example_data, method = "none")
auto_scaling <- PomaNorm(example_data, method = "auto_scaling")
level_scaling <- PomaNorm(example_data, method = "level_scaling")
log_scaling <- PomaNorm(example_data, method = "log_scaling")
log_transformation <- PomaNorm(example_data, method = "log")
vast_scaling <- PomaNorm(example_data, method = "vast_scaling")
log_pareto <- PomaNorm(example_data, method = "log_pareto")
```

## 4.1 Normalization effect on data dimensions

When we check for the dimension of the data after normalization we can see that all methods have the same effect on data dimension. `PomaNorm` **only** modifies the data dimension when the dataset contains **only-zero features** or **zero-variance features**.

```
dim(SummarizedExperiment::assay(none))
> [1] 29 57
dim(SummarizedExperiment::assay(auto_scaling))
> [1] 29 57
dim(SummarizedExperiment::assay(level_scaling))
> [1] 29 57
dim(SummarizedExperiment::assay(log_scaling))
> [1] 29 57
dim(SummarizedExperiment::assay(log_transformation))
> [1] 29 57
dim(SummarizedExperiment::assay(vast_scaling))
> [1] 29 57
dim(SummarizedExperiment::assay(log_pareto))
> [1] 29 57
```

## 4.2 Normalization effect on samples

Here we can evaluate the normalization effects on samples (Berg et al. [2006](#ref-normalization)).

```
a <- PomaBoxplots(none,
                  x = "samples") +
  ggplot2::ggtitle("Not Normalized")

b <- PomaBoxplots(auto_scaling,
                  x = "samples",
                  theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Auto Scaling") +
  ggplot2::theme(axis.text.x = ggplot2::element_blank())

c <- PomaBoxplots(level_scaling,
                  x = "samples",
                  theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Level Scaling") +
  ggplot2::theme(axis.text.x = ggplot2::element_blank())

d <- PomaBoxplots(log_scaling,
                  x = "samples",
                  theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Log Scaling") +
  ggplot2::theme(axis.text.x = ggplot2::element_blank())

e <- PomaBoxplots(log_transformation,
                  x = "samples",
                  theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Log Transformation") +
  ggplot2::theme(axis.text.x = ggplot2::element_blank())

f <- PomaBoxplots(vast_scaling,
                  x = "samples",
                  theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Vast Scaling") +
  ggplot2::theme(axis.text.x = ggplot2::element_blank())

g <- PomaBoxplots(log_pareto,
                  x = "samples",
                  theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Log Pareto") +
  ggplot2::theme(axis.text.x = ggplot2::element_blank())

a
```

![](data:image/png;base64...)

```
(b + c + d) / (e + f + g)
```

![](data:image/png;base64...)

## 4.3 Normalization effect on features

Here we can evaluate the normalization effects on features.

```
h <- PomaDensity(none,
                 x = "features",
                 theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Not Normalized")

i <- PomaDensity(auto_scaling,
                 x = "features",
                 theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Auto Scaling") +
  ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                 axis.title.y = ggplot2::element_blank())

j <- PomaDensity(level_scaling,
                 x = "features",
                 theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Level Scaling") +
  ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                 axis.title.y = ggplot2::element_blank())

k <- PomaDensity(log_scaling,
                 x = "features",
                 theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Log Scaling") +
  ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                 axis.title.y = ggplot2::element_blank())

l <- PomaDensity(log_transformation,
                 x = "features",
                 theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Log Transformation") +
  ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                 axis.title.y = ggplot2::element_blank())

m <- PomaDensity(vast_scaling,
                 x = "features",
                 theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Vast Scaling") +
  ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                 axis.title.y = ggplot2::element_blank())

n <- PomaDensity(log_pareto,
                 x = "features",
                 theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Log Pareto") +
  ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                 axis.title.y = ggplot2::element_blank())

h
```

![](data:image/png;base64...)

```
(i + j + k) / (l + m + n)
```

![](data:image/png;base64...)

# 5 Session Information

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
> [1] patchwork_1.3.2  ggtext_0.1.2     POMA_1.20.0      BiocStyle_2.38.0
>
> loaded via a namespace (and not attached):
>  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
>  [3] impute_1.84.0               xfun_0.53
>  [5] bslib_0.9.0                 ggplot2_4.0.0
>  [7] Biobase_2.70.0              lattice_0.22-7
>  [9] vctrs_0.6.5                 tools_4.5.1
> [11] generics_0.1.4              stats4_4.5.1
> [13] tibble_3.3.0                pkgconfig_2.0.3
> [15] Matrix_1.7-4                RColorBrewer_1.1-3
> [17] S7_0.2.0                    S4Vectors_0.48.0
> [19] lifecycle_1.0.4             compiler_4.5.1
> [21] farver_2.1.2                stringr_1.5.2
> [23] tinytex_0.57                Seqinfo_1.0.0
> [25] litedown_0.7                htmltools_0.5.8.1
> [27] sass_0.4.10                 yaml_2.3.10
> [29] pillar_1.11.1               jquerylib_0.1.4
> [31] tidyr_1.3.1                 cachem_1.1.0
> [33] DelayedArray_0.36.0         magick_2.9.0
> [35] abind_1.4-8                 commonmark_2.0.0
> [37] tidyselect_1.2.1            digest_0.6.37
> [39] stringi_1.8.7               dplyr_1.1.4
> [41] purrr_1.1.0                 bookdown_0.45
> [43] labeling_0.4.3              fastmap_1.2.0
> [45] grid_4.5.1                  cli_3.6.5
> [47] SparseArray_1.10.0          magrittr_2.0.4
> [49] S4Arrays_1.10.0             dichromat_2.0-0.1
> [51] withr_3.0.2                 scales_1.4.0
> [53] rmarkdown_2.30              XVector_0.50.0
> [55] matrixStats_1.5.0           evaluate_1.0.5
> [57] knitr_1.50                  GenomicRanges_1.62.0
> [59] IRanges_2.44.0              viridisLite_0.4.2
> [61] markdown_2.0                rlang_1.1.6
> [63] gridtext_0.1.5              Rcpp_1.1.0
> [65] glue_1.8.0                  BiocManager_1.30.26
> [67] xml2_1.4.1                  BiocGenerics_0.56.0
> [69] jsonlite_2.0.0              R6_2.6.1
> [71] MatrixGenerics_1.22.0
```

# References

Berg, Robert A van den, Huub CJ Hoefsloot, Johan A Westerhuis, Age K Smilde, and Mariët J van der Werf. 2006. “Centering, Scaling, and Transformations: Improving the Biological Information Content of Metabolomics Data.” *BMC Genomics* 7 (1): 142.