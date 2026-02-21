Code

* Show All Code
* Hide All Code

# Pathway activity inference from scRNA-seq

Pau Badia-i-Mompel1

1Heidelberg Universiy

#### 29 October 2025

#### Package

decoupleR 2.16.0

scRNA-seq yield many molecular readouts that are hard to interpret by
themselves. One way of summarizing this information is by inferring pathway
activities from prior knowledge.

In this notebook we showcase how to use `decoupleR` for pathway activity
inference with a down-sampled PBMCs 10X data-set. The data consists of 160
PBMCs from a Healthy Donor. The original data is freely available from 10x Genomics
[here](https://cf.10xgenomics.com/samples/cell/pbmc3k/pbmc3k_filtered_gene_bc_matrices.tar.gz)
from this [webpage](https://support.10xgenomics.com/single-cell-gene-expression/datasets/1.1.0/pbmc3k).

# 1 Loading packages

First, we need to load the relevant packages, `Seurat` to handle scRNA-seq data
and `decoupleR` to use statistical methods.

```
## We load the required packages
library(Seurat)
library(decoupleR)

# Only needed for data handling and plotting
library(dplyr)
library(tibble)
library(tidyr)
library(patchwork)
library(ggplot2)
library(pheatmap)
```

# 2 Loading the data-set

Here we used a down-sampled version of the data used in the `Seurat`
[vignette](https://satijalab.org/seurat/articles/pbmc3k_tutorial.html).
We can open the data like this:

```
inputs_dir <- system.file("extdata", package = "decoupleR")
data <- readRDS(file.path(inputs_dir, "sc_data.rds"))
```

We can observe that we have different cell types:

```
DimPlot(data, reduction = "umap", label = TRUE, pt.size = 0.5) + NoLegend()
```

![](data:image/png;base64...)

### 2.0.1 PROGENy model

[PROGENy](https://saezlab.github.io/progeny/) is a comprehensive resource containing a curated collection of pathways and their target genes, with weights for each interaction.
For this example we will use the human weights (other organisms are available) and we will use the top 500 responsive genes ranked by p-value. Here is a brief description of each pathway:

* **Androgen**: involved in the growth and development of the male reproductive organs.
* **EGFR**: regulates growth, survival, migration, apoptosis, proliferation, and differentiation in mammalian cells
* **Estrogen**: promotes the growth and development of the female reproductive organs.
* **Hypoxia**: promotes angiogenesis and metabolic reprogramming when O2 levels are low.
* **JAK-STAT**: involved in immunity, cell division, cell death, and tumor formation.
* **MAPK**: integrates external signals and promotes cell growth and proliferation.
* **NFkB**: regulates immune response, cytokine production and cell survival.
* **p53**: regulates cell cycle, apoptosis, DNA repair and tumor suppression.
* **PI3K**: promotes growth and proliferation.
* **TGFb**: involved in development, homeostasis, and repair of most tissues.
* **TNFa**: mediates haematopoiesis, immune surveillance, tumour regression and protection from infection.
* **Trail**: induces apoptosis.
* **VEGF**: mediates angiogenesis, vascular permeability, and cell migration.
* **WNT**: regulates organ morphogenesis during development and tissue repair.

To access it we can use `decoupleR`:

```
net <- get_progeny(organism = 'human', top = 500)
#> Warning in OmnipathR::get_annotation_resources(): 'OmnipathR::get_annotation_resources' is deprecated.
#> Use 'annotation_resources' instead.
#> See help("Deprecated")
#> Warning in readLines(con = path, encoding = encoding): incomplete final line found on
#> 'https://omnipathdb.org/resources'
#> Warning in OmnipathR::import_omnipath_annotations(resources = name, ..., : 'OmnipathR::import_omnipath_annotations' is deprecated.
#> Use 'annotations' instead.
#> See help("Deprecated")
#> Warning in readLines(con = path, encoding = encoding): incomplete final line found on
#> 'https://omnipathdb.org/resources'
net
#> # A tibble: 7,000 × 4
#>    source   target  weight  p_value
#>    <chr>    <chr>    <dbl>    <dbl>
#>  1 Androgen TMPRSS2  11.5  2.38e-47
#>  2 Androgen NKX3-1   10.6  2.21e-44
#>  3 Androgen MBOAT2   10.5  4.63e-44
#>  4 Androgen KLK2     10.2  1.94e-40
#>  5 Androgen SARG     11.4  2.79e-40
#>  6 Androgen SLC38A4   7.36 1.25e-39
#>  7 Androgen MTMR9     6.13 2.53e-38
#>  8 Androgen ZBTB16   10.6  1.57e-36
#>  9 Androgen KCNN2     9.47 7.71e-36
#> 10 Androgen OPRK1    -5.63 1.11e-35
#> # ℹ 6,990 more rows
```

# 3 Activity inference with Multivariate Linear Model (MLM)

To infer pathway enrichment scores we will run the Multivariate Linear Model (`mlm`) method. For each sample in our dataset (`mat`), it fits a linear model that predicts the observed gene expression based on all pathways’ Pathway-Gene interactions weights.
Once fitted, the obtained t-values of the slopes are the scores. If it is positive, we interpret that the pathway is active and if it is negative we interpret that it is inactive.

![](data:text/html; charset=utf-8...)

mlm

To run `decoupleR` methods, we need an input matrix (`mat`), an input prior
knowledge network/resource (`net`), and the name of the columns of net that we
want to use.

```
# Extract the normalized log-transformed counts
mat <- as.matrix(data@assays$RNA@data)

# Run mlm
acts <- run_mlm(mat=mat, net=net, .source='source', .target='target',
                .mor='weight', minsize = 5)
acts
#> # A tibble: 2,240 × 5
#>    statistic source   condition         score  p_value
#>    <chr>     <chr>    <chr>             <dbl>    <dbl>
#>  1 mlm       Androgen AAACATACAACCAC-1  0.559 0.576
#>  2 mlm       EGFR     AAACATACAACCAC-1  3.59  0.000328
#>  3 mlm       Estrogen AAACATACAACCAC-1 -0.868 0.386
#>  4 mlm       Hypoxia  AAACATACAACCAC-1  1.24  0.215
#>  5 mlm       JAK-STAT AAACATACAACCAC-1 -1.01  0.313
#>  6 mlm       MAPK     AAACATACAACCAC-1 -2.73  0.00634
#>  7 mlm       NFkB     AAACATACAACCAC-1 -0.226 0.821
#>  8 mlm       PI3K     AAACATACAACCAC-1 -1.13  0.257
#>  9 mlm       TGFb     AAACATACAACCAC-1  0.260 0.795
#> 10 mlm       TNFa     AAACATACAACCAC-1  2.22  0.0265
#> # ℹ 2,230 more rows
```

# 4 Visualization

From the obtained results, we will select the `ulm` activities and store
them in our object as a new assay called `pathwaysmlm`:

```
# Extract mlm and store it in pathwaysmlm in data
data[['pathwaysmlm']] <- acts %>%
  pivot_wider(id_cols = 'source', names_from = 'condition',
              values_from = 'score') %>%
  column_to_rownames('source') %>%
  Seurat::CreateAssayObject(.)

# Change assay
DefaultAssay(object = data) <- "pathwaysmlm"

# Scale the data
data <- ScaleData(data)
data@assays$pathwaysmlm@data <- data@assays$pathwaysmlm@scale.data
```

This new assay can be used to plot activities. Here we visualize the Trail
pathway, associated with apoptosis, which seems that in B and NK cells is more
active.

```
p1 <- DimPlot(data, reduction = "umap", label = TRUE, pt.size = 0.5) +
  NoLegend() + ggtitle('Cell types')
p2 <- (FeaturePlot(data, features = c("Trail")) &
  scale_colour_gradient2(low = 'blue', mid = 'white', high = 'red')) +
  ggtitle('Trail activity')
p1 | p2
```

![](data:image/png;base64...)

# 5 Exploration

We can also see what is the mean activity per group across pathways:

```
# Extract activities from object as a long dataframe
df <- t(as.matrix(data@assays$pathwaysmlm@data)) %>%
  as.data.frame() %>%
  mutate(cluster = Idents(data)) %>%
  pivot_longer(cols = -cluster, names_to = "source", values_to = "score") %>%
  group_by(cluster, source) %>%
  summarise(mean = mean(score))

# Transform to wide matrix
top_acts_mat <- df %>%
  pivot_wider(id_cols = 'cluster', names_from = 'source',
              values_from = 'mean') %>%
  column_to_rownames('cluster') %>%
  as.matrix()

# Choose color palette
palette_length = 100
my_color = colorRampPalette(c("Darkblue", "white","red"))(palette_length)

my_breaks <- c(seq(-2, 0, length.out=ceiling(palette_length/2) + 1),
               seq(0.05, 2, length.out=floor(palette_length/2)))

# Plot
pheatmap(top_acts_mat, border_color = NA, color=my_color, breaks = my_breaks)
```

![](data:image/png;base64...)

In this specific example, we can observe that Trail is more active in B and NK
cells.

# 6 Session information

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-29
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package          * version   date (UTC) lib source
#>  abind              1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
#>  backports          1.5.0     2024-05-23 [2] CRAN (R 4.5.1)
#>  bibtex             0.5.1     2023-01-26 [2] CRAN (R 4.5.1)
#>  BiocManager        1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel       1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle        * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64              4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
#>  blob               1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown           0.45      2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib              0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem             1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  cellranger         1.1.0     2016-07-27 [2] CRAN (R 4.5.1)
#>  checkmate          2.3.3     2025-08-18 [2] CRAN (R 4.5.1)
#>  chromote           0.5.1     2025-04-24 [2] CRAN (R 4.5.1)
#>  cli                3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  cluster            2.1.8.1   2025-03-12 [3] CRAN (R 4.5.1)
#>  codetools          0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
#>  cowplot            1.2.0     2025-07-07 [2] CRAN (R 4.5.1)
#>  crayon             1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  curl               7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
#>  data.table         1.17.8    2025-07-10 [2] CRAN (R 4.5.1)
#>  DBI                1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
#>  decoupleR        * 2.16.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  deldir             2.0-4     2024-02-28 [2] CRAN (R 4.5.1)
#>  dichromat          2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
#>  digest             0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  dotCall64          1.2       2024-10-04 [2] CRAN (R 4.5.1)
#>  dplyr            * 1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate           1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  farver             2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastDummies        1.7.5     2025-01-20 [2] CRAN (R 4.5.1)
#>  fastmap            1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  fastmatch          1.1-6     2024-12-23 [2] CRAN (R 4.5.1)
#>  fgsea              1.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  fitdistrplus       1.2-4     2025-07-03 [2] CRAN (R 4.5.1)
#>  fs                 1.6.6     2025-04-12 [2] CRAN (R 4.5.1)
#>  future             1.67.0    2025-07-29 [2] CRAN (R 4.5.1)
#>  future.apply       1.20.0    2025-06-06 [2] CRAN (R 4.5.1)
#>  generics           0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  ggplot2          * 4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
#>  ggrepel          * 0.9.6     2024-09-07 [2] CRAN (R 4.5.1)
#>  ggridges           0.5.7     2025-08-27 [2] CRAN (R 4.5.1)
#>  globals            0.18.0    2025-05-08 [2] CRAN (R 4.5.1)
#>  glue               1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  goftest            1.2-3     2021-10-07 [2] CRAN (R 4.5.1)
#>  gridExtra          2.3       2017-09-09 [2] CRAN (R 4.5.1)
#>  gtable             0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
#>  hms                1.1.4     2025-10-17 [2] CRAN (R 4.5.1)
#>  htmltools          0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets        1.6.4     2023-12-06 [2] CRAN (R 4.5.1)
#>  httpuv             1.6.16    2025-04-16 [2] CRAN (R 4.5.1)
#>  httr               1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2              1.2.1     2025-07-22 [2] CRAN (R 4.5.1)
#>  ica                1.0-3     2022-07-08 [2] CRAN (R 4.5.1)
#>  igraph             2.2.1     2025-10-27 [2] CRAN (R 4.5.1)
#>  irlba              2.3.5.1   2022-10-03 [2] CRAN (R 4.5.1)
#>  jquerylib          0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite           2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  KernSmooth         2.23-26   2025-01-01 [3] CRAN (R 4.5.1)
#>  knitr              1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling           0.4.3     2023-08-29 [2] CRAN (R 4.5.1)
#>  later              1.4.4     2025-08-27 [2] CRAN (R 4.5.1)
#>  lattice            0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lazyeval           0.2.2     2019-03-15 [2] CRAN (R 4.5.1)
#>  lifecycle          1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  listenv            0.9.1     2024-01-29 [2] CRAN (R 4.5.1)
#>  lmtest             0.9-40    2022-03-21 [2] CRAN (R 4.5.1)
#>  logger             0.4.1     2025-09-11 [2] CRAN (R 4.5.1)
#>  lubridate          1.9.4     2024-12-08 [2] CRAN (R 4.5.1)
#>  magick             2.9.0     2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr           2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
#>  MASS               7.3-65    2025-02-28 [3] CRAN (R 4.5.1)
#>  Matrix             1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
#>  matrixStats        1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise            2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
#>  mime               0.13      2025-03-17 [2] CRAN (R 4.5.1)
#>  miniUI             0.1.2     2025-04-17 [2] CRAN (R 4.5.1)
#>  nlme               3.1-168   2025-03-31 [3] CRAN (R 4.5.1)
#>  OmnipathR          3.18.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  otel               0.2.0     2025-08-29 [2] CRAN (R 4.5.1)
#>  parallelly         1.45.1    2025-07-24 [2] CRAN (R 4.5.1)
#>  patchwork        * 1.3.2     2025-08-25 [2] CRAN (R 4.5.1)
#>  pbapply            1.7-4     2025-07-20 [2] CRAN (R 4.5.1)
#>  pheatmap         * 1.0.13    2025-06-05 [2] CRAN (R 4.5.1)
#>  pillar             1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig          2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  plotly             4.11.0    2025-06-19 [2] CRAN (R 4.5.1)
#>  plyr               1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
#>  png                0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
#>  polyclip           1.10-7    2024-07-23 [2] CRAN (R 4.5.1)
#>  prettyunits        1.2.0     2023-09-24 [2] CRAN (R 4.5.1)
#>  processx           3.8.6     2025-02-21 [2] CRAN (R 4.5.1)
#>  progress           1.2.3     2023-12-06 [2] CRAN (R 4.5.1)
#>  progressr          0.17.0    2025-10-15 [2] CRAN (R 4.5.1)
#>  promises           1.4.0     2025-10-22 [2] CRAN (R 4.5.1)
#>  ps                 1.9.1     2025-04-12 [2] CRAN (R 4.5.1)
#>  purrr              1.1.0     2025-07-10 [2] CRAN (R 4.5.1)
#>  R.methodsS3        1.8.2     2022-06-13 [2] CRAN (R 4.5.1)
#>  R.oo               1.27.1    2025-05-02 [2] CRAN (R 4.5.1)
#>  R.utils            2.13.0    2025-02-24 [2] CRAN (R 4.5.1)
#>  R6                 2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  RANN               2.6.2     2024-08-25 [2] CRAN (R 4.5.1)
#>  rappdirs           0.3.3     2021-01-31 [2] CRAN (R 4.5.1)
#>  RColorBrewer       1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp               1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  RcppAnnoy          0.0.22    2024-01-23 [2] CRAN (R 4.5.1)
#>  RcppHNSW           0.6.0     2024-02-04 [2] CRAN (R 4.5.1)
#>  readr              2.1.5     2024-01-10 [2] CRAN (R 4.5.1)
#>  readxl             1.4.5     2025-03-07 [2] CRAN (R 4.5.1)
#>  RefManageR       * 1.4.0     2022-09-30 [2] CRAN (R 4.5.1)
#>  reshape2           1.4.4     2020-04-09 [2] CRAN (R 4.5.1)
#>  reticulate         1.44.0    2025-10-25 [2] CRAN (R 4.5.1)
#>  rlang              1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown          2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  ROCR               1.0-11    2020-05-02 [2] CRAN (R 4.5.1)
#>  RSpectra           0.16-2    2024-07-18 [2] CRAN (R 4.5.1)
#>  RSQLite            2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
#>  Rtsne              0.17      2023-12-07 [2] CRAN (R 4.5.1)
#>  rvest              1.0.5     2025-08-29 [2] CRAN (R 4.5.1)
#>  S7                 0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
#>  sass               0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  scales             1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
#>  scattermore        1.2       2023-06-12 [2] CRAN (R 4.5.1)
#>  sctransform        0.4.2     2025-04-30 [2] CRAN (R 4.5.1)
#>  selectr            0.4-2     2019-11-20 [2] CRAN (R 4.5.1)
#>  sessioninfo        1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  Seurat           * 5.3.1     2025-10-29 [2] CRAN (R 4.5.1)
#>  SeuratObject     * 5.2.0     2025-08-27 [2] CRAN (R 4.5.1)
#>  shiny              1.11.1    2025-07-03 [2] CRAN (R 4.5.1)
#>  sp               * 2.2-0     2025-02-01 [2] CRAN (R 4.5.1)
#>  spam               2.11-1    2025-01-20 [2] CRAN (R 4.5.1)
#>  spatstat.data      3.1-9     2025-10-18 [2] CRAN (R 4.5.1)
#>  spatstat.explore   3.5-3     2025-09-22 [2] CRAN (R 4.5.1)
#>  spatstat.geom      3.6-0     2025-09-20 [2] CRAN (R 4.5.1)
#>  spatstat.random    3.4-2     2025-09-21 [2] CRAN (R 4.5.1)
#>  spatstat.sparse    3.1-0     2024-06-21 [2] CRAN (R 4.5.1)
#>  spatstat.univar    3.1-4     2025-07-13 [2] CRAN (R 4.5.1)
#>  spatstat.utils     3.2-0     2025-09-20 [2] CRAN (R 4.5.1)
#>  stringi            1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr            1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
#>  survival           3.8-3     2024-12-17 [3] CRAN (R 4.5.1)
#>  tensor             1.5.1     2025-06-17 [2] CRAN (R 4.5.1)
#>  tibble           * 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr            * 1.3.1     2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect         1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange         0.3.0     2024-01-18 [2] CRAN (R 4.5.1)
#>  tinytex            0.57      2025-04-15 [2] CRAN (R 4.5.1)
#>  tzdb               0.5.0     2025-03-15 [2] CRAN (R 4.5.1)
#>  utf8               1.2.6     2025-06-08 [2] CRAN (R 4.5.1)
#>  uwot               0.2.3     2025-02-24 [2] CRAN (R 4.5.1)
#>  vctrs              0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  viridisLite        0.4.2     2023-05-02 [2] CRAN (R 4.5.1)
#>  vroom              1.6.6     2025-09-19 [2] CRAN (R 4.5.1)
#>  websocket          1.4.4     2025-04-10 [2] CRAN (R 4.5.1)
#>  withr              3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun               0.53      2025-08-19 [2] CRAN (R 4.5.1)
#>  XML                3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
#>  xml2               1.4.1     2025-10-27 [2] CRAN (R 4.5.1)
#>  xtable             1.8-4     2019-04-21 [2] CRAN (R 4.5.1)
#>  yaml               2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>  zip                2.3.3     2025-05-13 [2] CRAN (R 4.5.1)
#>  zoo                1.8-14    2025-04-10 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpwS46co/Rinst3e53b4d0d164d
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```