# Introduction to `tpSVG`

Boyi Guo1

1Johns Hopkins Bloomberg School of Public Health, Baltimore, MD, USA

#### 30 October 2025

# Contents

* [1 Installation](#installation)
  + [1.1 GitHub](#github)
  + [1.2 Bioconductor (pending)](#bioconductor-pending)
* [2 Modeling spatially resolved gene expression using `tpSVG`](#modeling-spatially-resolved-gene-expression-using-tpsvg)
  + [2.1 Load Packages](#load-packages)
  + [2.2 Data processing](#data-processing)
  + [2.3 Modeling raw counts with Poisson model](#modeling-raw-counts-with-poisson-model)
  + [2.4 Gaussian model for log-transformed normalized data](#gaussian-model-for-log-transformed-normalized-data)
  + [2.5 Covariate-adjusted Model](#covariate-adjusted-model)
    - [2.5.1 image-based SRT in `SpatialExperiment` (e.g. `SpatialFeatureExperiment`)](#image-based-srt-in-spatialexperiment-e.g.-spatialfeatureexperiment)
* [3 Session Info](#session-info)

The objective of `tpSVG` is to detect spatially variable genes (SVG) when analyzing spatially-resolved transcriptomics data. This includes both unsupervised features where there’s not additional information is supplied besides the (normalized) gene counts and spatial coordinates, but also the spatial variation explained besides some covariates, such as tissue anatomy or possibly cell type composition.

Compared to previous SVG detection tools, `tpSVG` provides a scalable solution to model the gene expression as counts instead of logarithm-transformed counts. While log transformation provides convenience to model the spatial gene expression by mapping count data to the continuous domain, hence enabling well-understood Gaussian models, log transformation distorts low expressed genes counts and create bias populating high-expressed genes. For example, the rank of genes based on their effect size are commonly used for dimensional reduction, or its input. Hence, estimating gene ranking correctly is very important. Gaussian models, exemplified with `nnSVG`, often dissociates the mean-variance relationship which is commonly assumed for counts data, and hence often prioritizes the highly expressed genes over the lowly expressed genes. In the figure below, we saw that `nnSVG` is susceptible to such mean-rank relationship, meaning highly expressed genes are often ranked highly. In contrast, the proposed `tpSVG` with Poisson distribution is not susceptible to this mean-rank relationship when examining the [DLPFC dataset](https://pubmed.ncbi.nlm.nih.gov/33558695/).

![](data:image/png;base64...)

Model counts data with `tpSVG` avoids mean-rank relationship.

# 1 Installation

## 1.1 GitHub

You can install the development version of tpSVG from [GitHub](https://github.com/boyiguo1/tpSVG) with:

```
# install.packages("devtools")
devtools::install_github("boyiguo1/tpSVG")
```

## 1.2 Bioconductor (pending)

The package is currently submitted to Bioconductor for [review](https://github.com/Bioconductor/Contributions/issues/3264). Once the package
is accepted by Bioconductor, you can install the latest release
version of `tpSVG` from Bioconductor via the following code. Additional details
are shown on the Bioconductor page.

```
if (!require("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("tpSVG")
```

The latest development version can also be installed from the `devel` version
of Bioconductor or from GitHub following

```
BiocManager::install(version='devel')
```

# 2 Modeling spatially resolved gene expression using `tpSVG`

In the following section, we demonstrate the how to use `tpSVG` with a [`SpatialExperiment`](https://bioconductor.org/packages/release/bioc/html/SpatialExperiment.html) object.

## 2.1 Load Packages

To run the demonstration, there a couple of necessary packages to load. We will use the data set in [`STexampleData`](https://bioconductor.org/packages/STexampleData), which contains a 10x Visium dataset. Specifically, we will find one 10xVisium sample collected from the dorso lateral prefrontal region of a postmortem human brain from [`STexampleData`](https://bioconductor.org/packages/release/data/experiment/html/STexampleData.html) package, indexed by brain number of “151673” from [Maynard, Collado-Torres *et al*. (2021)](https://www.nature.com/articles/s41593-020-00787-0). For more information, please see the vignettes of [`STexampleData`](https://bioconductor.org/packages/release/data/experiment/vignettes/STexampleData/inst/doc/STexampleData_overview.html)

```
library(tpSVG)
library(SpatialExperiment)
library(STexampleData)          # Example data
library(scuttle)                # Data preprocess
```

## 2.2 Data processing

Before running the analysis using `tpSVG`, we will preprocess the data, which
includes 1) calculating normalization factor, or equivalently library size; 2)
down-sizing the number of genes to 6 to reduce running time. These preprocessing
step may not be necessary if real world data analysis.

```
spe <- Visium_humanDLPFC()
spe <- spe[, colData(spe)$in_tissue == 1]
spe <- logNormCounts(spe)

# Normalization factor
head(spe$sizeFactor)
#> AAACAAGTATCTCCCA-1 AAACAATCTACTAGCA-1 AAACACCAATAACTGC-1 AAACAGAGCGACTCCT-1
#>          1.8428941          0.3632188          0.8212187          1.1837838
#> AAACAGCTTTCAGAAG-1 AAACAGGGTCTATATT-1
#>          0.9321235          0.8724223

# Equivalently, library size
spe$total <- counts(spe) |> colSums()

# Down-sizing genes for faster computation
idx <- which(
  rowData(spe)$gene_name %in% c("MOBP", "PCP4", "SNAP25",
                                "HBB", "IGKC", "NPY")
)
spe <- spe[idx, ]
```

## 2.3 Modeling raw counts with Poisson model

The following example demonstrates how to model raw gene counts data with `tpSVG`.
The model fitting is simple, following `stats::glm` syntax to follow any
distributional assumption via the argument `family`. The only key point to
mention here is the model needs to account for any technical variation due to
the gene profiling procedure. To account for such techincal variation, we use
`offset` term in the model. In the following example, we use the commonly used
library size as the normalizing factor, and hence set `offset = log(spe$total)`
to account for the techinical variation in the data. Equivalently, it is also
possible/encouraged to use `offset = log(spe$sizeFactor)`, where `spe$sizeFactor`
is calculated during `logNormCounts` and is a linear function of the library
size, i.e. `spe$total`. Note: it is very important to use the log function in
the `offset` making sure the data scale is conformable.

```
set.seed(1)
spe_poisson  <- tpSVG(
  spe,
  family = poisson,
  assay_name = "counts",
  offset = log(spe$total)   # Natural log library size
)

rowData(spe_poisson)
#> DataFrame with 6 rows and 6 columns
#>                         gene_id   gene_name    feature_type test_stat     raw_p
#>                     <character> <character>     <character> <numeric> <numeric>
#> ENSG00000211592 ENSG00000211592        IGKC Gene Expression   3447.12         0
#> ENSG00000168314 ENSG00000168314        MOBP Gene Expression   7143.34         0
#> ENSG00000122585 ENSG00000122585         NPY Gene Expression   3596.18         0
#> ENSG00000244734 ENSG00000244734         HBB Gene Expression   1536.56         0
#> ENSG00000132639 ENSG00000132639      SNAP25 Gene Expression   3529.46         0
#> ENSG00000183036 ENSG00000183036        PCP4 Gene Expression   1381.63         0
#>                   runtime
#>                 <numeric>
#> ENSG00000211592     1.233
#> ENSG00000168314     1.277
#> ENSG00000122585     1.249
#> ENSG00000244734     1.254
#> ENSG00000132639     1.314
#> ENSG00000183036     1.173
```

## 2.4 Gaussian model for log-transformed normalized data

`tpSVG` provides flexibility regarding the distributional assumption. If interested,
it is possible to model log-transformed count data using Gaussian distribution.

```
spe_gauss <- tpSVG(
  spe,
  family = gaussian(),
  assay_name = "logcounts",
  offset = NULL
)
```

## 2.5 Covariate-adjusted Model

It is scientifically interesting to understand if and how much additional
spatial variation in gene expression when accounting some known biology. For example,
if known anatomy is accounted for in the model, is there any additional spatial variation
in the gene expression which can be informative to any unknown biology.
Statistically, this question is known as covariate adjustment, where the known
biology is quantified and accounted for in a model.

To address this question, `tpSVG` allows introducing covariates in the model via
the argument `X`, where `X` takes a vector of any kind, including categorical
variables.

The frist step is to remove any missing data in the dataset, specifically as
the covariate. This can be done via `complete.cases`.

```
# Check missing data
idx_complete_case <- complete.cases(spe$ground_truth)
# If multiple covariates
# idx_complete_case <- complete.cases(spe$ground_truth, spe$cell_count)

# Remove missing data
spe <- spe[, idx_complete_case]

# Create a design matrix
x <- spe$ground_truth

spe_poisson_cov  <- tpSVG(
  spe,
  X = x,
  family = poisson,
  assay_name = "counts",
  offset = log(spe$total)   # Natural log library size
)
```

### 2.5.1 image-based SRT in `SpatialExperiment` (e.g. `SpatialFeatureExperiment`)

`tpSVG` can be also used to model image-based SRT data. We use
the seqFISH data from [Lohoff and Ghazanfar *et al*. (2020)](https://www.nature.com/articles/s41587-021-01006-2) to demonstrate `tpSVG`. Specifically, we use the curated example data in [`STexampleData`](https://bioconductor.org/packages/release/data/experiment/html/STexampleData.html) package. For more information, please see the vignettes of [`STexampleData`](https://bioconductor.org/packages/release/data/experiment/vignettes/STexampleData/inst/doc/STexampleData_overview.html)

```
library(STexampleData)
spe <- seqFISH_mouseEmbryo()
#> see ?STexampleData and browseVignettes('STexampleData') for documentation
#> loading from cache
#> Loading required namespace: BumpyMatrix

spe
#> class: SpatialExperiment
#> dim: 351 11026
#> metadata(0):
#> assays(2): counts molecules
#> rownames(351): Abcc4 Acp5 ... Zfp57 Zic3
#> rowData names(1): gene_name
#> colnames(11026): embryo1_Pos0_cell10_z2 embryo1_Pos0_cell100_z2 ...
#>   embryo1_Pos28_cell97_z2 embryo1_Pos28_cell98_z2
#> colData names(14): cell_id embryo ... segmentation_vertices sample_id
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
#> spatialCoords names(2) : x y
#> imgData names(0):
```

The example data set contains `351` genes for `11026` genes. To make the
demonstration computationally feasible, we down-size the number of genes to 1.
The average computation times for 11026 cells is roughly 2 minutes.

```
# Calculate "library size"
spe$total <- counts(spe) |> colSums()

# Down-size genes
idx_gene <- which(
  rowData(spe)$gene_name %in%
    c("Sox2")
  )

library(tpSVG)

# Poisson model
tp_spe <- tpSVG(
  input = spe[idx_gene,],
  family = poisson(),
  offset = log(spe$total),
  assay_name = "counts")

rowData(tp_spe)
#> DataFrame with 1 row and 4 columns
#>        gene_name test_stat     raw_p   runtime
#>      <character> <numeric> <numeric> <numeric>
#> Sox2        Sox2   9588.51         0     3.654
```

# 3 Session Info

```
sessioninfo::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package              * version date (UTC) lib source
#>  abind                  1.4-8   2024-09-12 [2] CRAN (R 4.5.1)
#>  AnnotationDbi          1.72.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationHub        * 4.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  beachmat               2.26.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biobase              * 2.70.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocFileCache        * 3.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel           1.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocVersion            3.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0   2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1 2025-01-16 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4   2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.45    2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  BumpyMatrix            1.18.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  cachem                 1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  codetools              0.2-20  2024-03-31 [3] CRAN (R 4.5.1)
#>  crayon                 1.5.3   2024-06-20 [2] CRAN (R 4.5.1)
#>  curl                   7.0.0   2025-08-19 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3   2024-06-02 [2] CRAN (R 4.5.1)
#>  dbplyr               * 2.5.1   2025-09-10 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  digest                 0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  ExperimentHub        * 3.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  fastmap                1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  filelock               1.0.3   2023-12-11 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges        * 1.62.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  glue                   1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2                  1.2.1   2025-07-22 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  jquerylib              0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  magick                 2.9.0   2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4   2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0   2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1   2021-11-26 [2] CRAN (R 4.5.1)
#>  mgcv                 * 1.9-3   2025-04-04 [3] CRAN (R 4.5.1)
#>  nlme                 * 3.1-168 2025-03-31 [3] CRAN (R 4.5.1)
#>  pillar                 1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
#>  png                    0.1-8   2022-11-29 [2] CRAN (R 4.5.1)
#>  purrr                  1.1.0   2025-07-10 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs               0.3.3   2021-01-31 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
#>  rjson                  0.2.23  2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  RSQLite                2.4.3   2025-08-20 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sass                   0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  scuttle              * 1.20.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Seqinfo              * 1.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo            1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  SingleCellExperiment * 1.32.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SparseArray            1.10.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SpatialExperiment    * 1.20.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  STexampleData        * 1.17.1  2025-10-28 [2] Bioconductor 3.22 (R 4.5.1)
#>  SummarizedExperiment * 1.40.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
#>  tpSVG                * 1.6.0   2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  vctrs                  0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.53    2025-08-19 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpFuySUf/Rinst39d09384a802a
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```