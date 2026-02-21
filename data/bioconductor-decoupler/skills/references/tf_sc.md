Code

* Show All Code
* Hide All Code

# Transcription factor activity inference from scRNA-seq

Pau Badia-i-Mompel1

1Heidelberg Universiy

#### 29 October 2025

#### Package

decoupleR 2.16.0

scRNA-seq yield many molecular readouts that are hard to interpret by
themselves. One way of summarizing this information is by inferring
transcription factor (TF) activities from prior knowledge.

In this notebook we showcase how to use `decoupleR` for transcription factor activity
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

# 3 CollecTRI network

[CollecTRI](https://github.com/saezlab/CollecTRI) is a comprehensive resource
containing a curated collection of TFs and their transcriptional targets
compiled from 12 different resources. This collection provides an increased
coverage of transcription factors and a superior performance in identifying
perturbed TFs compared to our previous
[DoRothEA](https://saezlab.github.io/dorothea/) network and other literature
based GRNs. Similar to DoRothEA, interactions are weighted by their mode of
regulation (activation or inhibition).

For this example we will use the human version (mouse and rat are also
available). We can use `decoupleR` to retrieve it from `OmniPath`. The argument
`split_complexes` keeps complexes or splits them into subunits, by default we
recommend to keep complexes together.

```
net <- get_collectri(organism='human', split_complexes=FALSE)
#> Warning in OmnipathR::import_tf_mirna_interactions(genesymbols = TRUE, resources = "CollecTRI", : 'OmnipathR::import_tf_mirna_interactions' is deprecated.
#> Use 'tf_mirna' instead.
#> See help("Deprecated")
#> Warning in readLines(con = path, encoding = encoding): incomplete final line found on
#> 'https://omnipathdb.org/resources'
net
#> # A tibble: 43,159 × 3
#>    source target   mor
#>    <chr>  <chr>  <dbl>
#>  1 MYC    TERT       1
#>  2 SPI1   BGLAP      1
#>  3 SMAD3  JUN        1
#>  4 SMAD4  JUN        1
#>  5 STAT5A IL2        1
#>  6 STAT5B IL2        1
#>  7 RELA   FAS        1
#>  8 WT1    NR0B1      1
#>  9 NR0B2  CASP1      1
#> 10 SP1    ALDOA      1
#> # ℹ 43,149 more rows
```

# 4 Activity inference with Univariate Linear Model (ULM)

To infer TF enrichment scores we will run the Univariate Linear Model (`ulm`) method. For each sample in our dataset (`mat`) and each TF in our network (`net`), it fits a linear model that predicts the observed gene expression
based solely on the TF’s TF-Gene interaction weights. Once fitted, the obtained t-value of the slope is the score. If it is positive, we interpret that the TF is active and if it is negative we interpret that it is inactive.

![](data:text/html; charset=utf-8...)

ulm

To run `decoupleR` methods, we need an input matrix (`mat`), an input prior
knowledge network/resource (`net`), and the name of the columns of net that we
want to use.

```
# Extract the normalized log-transformed counts
mat <- as.matrix(data@assays$RNA@data)

# Run ulm
acts <- run_ulm(mat=mat, net=net, .source='source', .target='target',
                .mor='mor', minsize = 5)
acts
#> # A tibble: 80,640 × 5
#>    statistic source condition         score p_value
#>    <chr>     <chr>  <chr>             <dbl>   <dbl>
#>  1 ulm       ABL1   AAACATACAACCAC-1  2.64  0.00820
#>  2 ulm       ABL1   AAACGCTGTTTCTG-1  0.893 0.372
#>  3 ulm       ABL1   AACCTTTGGACGGA-1  2.79  0.00525
#>  4 ulm       ABL1   AACGCCCTCGTACA-1  1.80  0.0721
#>  5 ulm       ABL1   AACGTCGAGTATCG-1  1.63  0.104
#>  6 ulm       ABL1   AACTCACTCAAGCT-1  1.71  0.0871
#>  7 ulm       ABL1   AAGATGGAAAACAG-1  1.12  0.264
#>  8 ulm       ABL1   AAGATTACCGCCTT-1  2.43  0.0151
#>  9 ulm       ABL1   AAGCCATGAACTGC-1  1.62  0.105
#> 10 ulm       ABL1   AAGGTCTGCAGATC-1 -0.292 0.771
#> # ℹ 80,630 more rows
```

# 5 Visualization

From the obtained results, we store
them in our object as a new assay called `tfsulm`:

```
# Extract ulm and store it in tfsulm in pbmc
data[['tfsulm']] <- acts %>%
  pivot_wider(id_cols = 'source', names_from = 'condition',
              values_from = 'score') %>%
  column_to_rownames('source') %>%
  Seurat::CreateAssayObject(.)

# Change assay
DefaultAssay(object = data) <- "tfsulm"

# Scale the data
data <- ScaleData(data)
data@assays$tfsulm@data <- data@assays$tfsulm@scale.data
```

This new assay can be used to plot activities. Here we observe the activity
inferred for PAX5 across cells, which it is particulary active in B cells.
Interestingly, PAX5 is a known TF crucial for B cell identity and function.
The inference of activities from “foot-prints” of target genes is more
informative than just looking at the molecular readouts of a given TF, as an
example here is the gene expression of PAX5, which is not very informative by
itself:

```
p1 <- DimPlot(data, reduction = "umap", label = TRUE, pt.size = 0.5) +
  NoLegend() + ggtitle('Cell types')
p2 <- (FeaturePlot(data, features = c("PAX5")) &
  scale_colour_gradient2(low = 'blue', mid = 'white', high = 'red')) +
  ggtitle('PAX5 activity')
DefaultAssay(object = data) <- "RNA"
p3 <- FeaturePlot(data, features = c("PAX5")) + ggtitle('PAX5 expression')
DefaultAssay(object = data) <- "tfsulm"
p1 | p2 | p3
```

![](data:image/png;base64...)

# 6 Exploration

We can also see what is the mean activity per group of the top 20 more variable
TFs:

```
n_tfs <- 25
# Extract activities from object as a long dataframe
df <- t(as.matrix(data@assays$tfsulm@data)) %>%
  as.data.frame() %>%
  mutate(cluster = Idents(data)) %>%
  pivot_longer(cols = -cluster, names_to = "source", values_to = "score") %>%
  group_by(cluster, source) %>%
  summarise(mean = mean(score))

# Get top tfs with more variable means across clusters
tfs <- df %>%
  group_by(source) %>%
  summarise(std = sd(mean)) %>%
  arrange(-abs(std)) %>%
  head(n_tfs) %>%
  pull(source)

# Subset long data frame to top tfs and transform to wide matrix
top_acts_mat <- df %>%
  filter(source %in% tfs) %>%
  pivot_wider(id_cols = 'cluster', names_from = 'source',
              values_from = 'mean') %>%
  column_to_rownames('cluster') %>%
  as.matrix()

# Choose color palette
palette_length = 100
my_color = colorRampPalette(c("Darkblue", "white","red"))(palette_length)

my_breaks <- c(seq(-3, 0, length.out=ceiling(palette_length/2) + 1),
               seq(0.05, 3, length.out=floor(palette_length/2)))

# Plot
pheatmap(top_acts_mat, border_color = NA, color=my_color, breaks = my_breaks)
```

![](data:image/png;base64...)

Here we can observe other known marker TFs appearing, EBF1 for B cells
RFX5 for the myeloid lineage and EOMES for the lymphoid.

# 7 Session information

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