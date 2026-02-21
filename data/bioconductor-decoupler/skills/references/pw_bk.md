Code

* Show All Code
* Hide All Code

# Pathway activity inference in bulk RNA-seq

Pau Badia-i-Mompel1

1Heidelberg Universiy

#### 29 October 2025

#### Package

decoupleR 2.16.0

Bulk RNA-seq yield many molecular readouts that are hard to interpret by
themselves. One way of summarizing this information is by inferring pathway
activities from prior knowledge.

In this notebook we showcase how to use `decoupleR` for pathway activity
inference with a bulk RNA-seq data-set where the transcription factor FOXA2 was
knocked out in pancreatic cancer cell lines.

The data consists of 3 Wild Type (WT) samples and 3 Knock Outs (KO). They are
freely available in
[GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE119931).

# 1 Loading packages

First, we need to load the relevant packages:

```
## We load the required packages
library(decoupleR)
library(dplyr)
library(tibble)
library(tidyr)
library(ggplot2)
library(pheatmap)
library(ggrepel)
```

# 2 Loading the data-set

Here we used an already processed bulk RNA-seq data-set. We provide the
normalized log-transformed counts, the experimental design meta-data and the
Differential Expressed Genes (DEGs) obtained using `limma`.

For this example we use `limma` but we could have used `DeSeq2`, `edgeR` or any
other statistical framework. decoupleR requires a gene level statistic to
perform enrichment analysis but it is agnostic of how it was generated. However,
we do recommend to use statistics that include the direction of change and its
significance, for example the t-value obtained for `limma`(`t`) or `DeSeq2`(`stat`).
edgeR does not return such statistic but we can create our own by weighting the
obtained logFC by pvalue with this formula: `-log10(pvalue) * logFC`.

We can open the data like this:

```
inputs_dir <- system.file("extdata", package = "decoupleR")
data <- readRDS(file.path(inputs_dir, "bk_data.rds"))
```

From `data` we can extract the mentioned information. Here we see the normalized
log-transformed counts:

```
# Remove NAs and set row names
counts <- data$counts %>%
  dplyr::mutate_if(~ any(is.na(.x)), ~ if_else(is.na(.x),0,.x)) %>%
  column_to_rownames(var = "gene") %>%
  as.matrix()
head(counts)
#>          PANC1.WT.Rep1 PANC1.WT.Rep2 PANC1.WT.Rep3 PANC1.FOXA2KO.Rep1 PANC1.FOXA2KO.Rep2 PANC1.FOXA2KO.Rep3
#> NOC2L        10.052588     11.949123     12.057774          12.312291          12.139918          11.494205
#> PLEKHN1       7.535115      8.125993      8.714880           8.048196           8.290154           8.621239
#> PERM1         6.281242      6.424582      6.589668           6.293285           6.486136           6.775344
#> ISG15        10.938252     11.469081     11.425415          11.549986          11.371464          11.178157
#> AGRN          6.956335      7.196108      7.522550           7.061549           7.485534           7.071555
#> C1orf159      9.546224      9.788721      9.794589           9.850830           9.988069           9.965357
```

The design meta-data:

```
design <- data$design
design
#> # A tibble: 6 × 2
#>   sample             condition
#>   <chr>              <chr>
#> 1 PANC1.WT.Rep1      PANC1.WT
#> 2 PANC1.WT.Rep2      PANC1.WT
#> 3 PANC1.WT.Rep3      PANC1.WT
#> 4 PANC1.FOXA2KO.Rep1 PANC1.FOXA2KO
#> 5 PANC1.FOXA2KO.Rep2 PANC1.FOXA2KO
#> 6 PANC1.FOXA2KO.Rep3 PANC1.FOXA2KO
```

And the results of `limma`, of which we are interested in extracting the
obtained t-value from the contrast:

```
# Extract t-values per gene
deg <- data$limma_ttop %>%
    select(ID, t) %>%
    filter(!is.na(t)) %>%
    column_to_rownames(var = "ID") %>%
    as.matrix()
head(deg)
#>                  t
#> RHBDL2  -12.810588
#> PLEKHH2 -10.794453
#> HEG1     -9.788112
#> CLU      -9.761618
#> FHL1      8.950191
#> RBP4     -8.529074
```

# 3 PROGENy model

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

# 4 Activity inference with Multivariate Linear Model (MLM)

To infer pathway enrichment scores we will run the Multivariate Linear Model (`mlm`) method. For each sample in our dataset (`mat`), it fits a linear model that predicts the observed gene expression based on all pathways’ Pathway-Gene interactions weights.
Once fitted, the obtained t-values of the slopes are the scores. If it is positive, we interpret that the pathway is active and if it is negative we interpret that it is inactive.

![](data:text/html; charset=utf-8...)

mlm

To run `decoupleR` methods, we need an input matrix (`mat`), an input prior
knowledge network/resource (`net`), and the name of the columns of net that we
want to use.

```
# Run mlm
sample_acts <- run_mlm(mat=counts, net=net, .source='source', .target='target',
                  .mor='weight', minsize = 5)
sample_acts
#> # A tibble: 84 × 5
#>    statistic source   condition        score  p_value
#>    <chr>     <chr>    <chr>            <dbl>    <dbl>
#>  1 mlm       Androgen PANC1.WT.Rep1 -0.692   0.489
#>  2 mlm       EGFR     PANC1.WT.Rep1  0.00798 0.994
#>  3 mlm       Estrogen PANC1.WT.Rep1 -0.366   0.714
#>  4 mlm       Hypoxia  PANC1.WT.Rep1 -2.10    0.0362
#>  5 mlm       JAK-STAT PANC1.WT.Rep1 -0.138   0.890
#>  6 mlm       MAPK     PANC1.WT.Rep1 -0.596   0.552
#>  7 mlm       NFkB     PANC1.WT.Rep1 -3.04    0.00238
#>  8 mlm       PI3K     PANC1.WT.Rep1  3.57    0.000360
#>  9 mlm       TGFb     PANC1.WT.Rep1 -1.43    0.153
#> 10 mlm       TNFa     PANC1.WT.Rep1  2.24    0.0250
#> # ℹ 74 more rows
```

# 5 Visualization

From the obtained results we
will observe the obtained activities per sample in a heat-map:

```
# Transform to wide matrix
sample_acts_mat <- sample_acts %>%
  pivot_wider(id_cols = 'condition', names_from = 'source',
              values_from = 'score') %>%
  column_to_rownames('condition') %>%
  as.matrix()

# Scale per feature
sample_acts_mat <- scale(sample_acts_mat)

# Choose color palette
palette_length = 100
my_color = colorRampPalette(c("Darkblue", "white","red"))(palette_length)

my_breaks <- c(seq(-3, 0, length.out=ceiling(palette_length/2) + 1),
               seq(0.05, 3, length.out=floor(palette_length/2)))

# Plot
pheatmap(sample_acts_mat, border_color = NA, color=my_color, breaks = my_breaks)
```

![](data:image/png;base64...)

We can also infer pathway activities from the t-values of the DEGs between KO
and WT:

```
# Run mlm
contrast_acts <- run_mlm(mat=deg, net=net, .source='source', .target='target',
                  .mor='weight', minsize = 5)
contrast_acts
#> # A tibble: 14 × 5
#>    statistic source   condition  score  p_value
#>    <chr>     <chr>    <chr>      <dbl>    <dbl>
#>  1 mlm       Androgen t         -0.222 8.25e- 1
#>  2 mlm       EGFR     t         -0.822 4.11e- 1
#>  3 mlm       Estrogen t          3.95  7.92e- 5
#>  4 mlm       Hypoxia  t          0.286 7.75e- 1
#>  5 mlm       JAK-STAT t          5.90  3.73e- 9
#>  6 mlm       MAPK     t         13.1   4.27e-39
#>  7 mlm       NFkB     t          1.40  1.61e- 1
#>  8 mlm       PI3K     t          5.67  1.50e- 8
#>  9 mlm       TGFb     t         -0.666 5.05e- 1
#> 10 mlm       TNFa     t          1.86  6.32e- 2
#> 11 mlm       Trail    t         -2.02  4.32e- 2
#> 12 mlm       VEGF     t          2.77  5.57e- 3
#> 13 mlm       WNT      t         -1.49  1.37e- 1
#> 14 mlm       p53      t         -4.81  1.51e- 6
```

Let’s show the changes
in activity between KO and WT:

```
# Plot
ggplot(contrast_acts, aes(x = reorder(source, score), y = score)) +
    geom_bar(aes(fill = score), stat = "identity") +
    scale_fill_gradient2(low = "darkblue", high = "indianred",
        mid = "whitesmoke", midpoint = 0) +
    theme_minimal() +
    theme(axis.title = element_text(face = "bold", size = 12),
        axis.text.x =
            element_text(angle = 45, hjust = 1, size =10, face= "bold"),
        axis.text.y = element_text(size =10, face= "bold"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
    xlab("Pathways")
```

![](data:image/png;base64...)

The pathway p53 and Trail are deactivated in KO when
compared to WT, while MAPKK and JAK-STAT and seem to be activated.

We can further visualize the most responsive genes in each pathway along their
t-values to interpret the results. For example, let’s see the genes that are
belong to the MAPK pathway:

```
pathway <- 'MAPK'

df <- net %>%
  filter(source == pathway) %>%
  arrange(target) %>%
  mutate(ID = target, color = "3") %>%
  column_to_rownames('target')
inter <- sort(intersect(rownames(deg),rownames(df)))
df <- df[inter, ]
df['t_value'] <- deg[inter, ]
df <- df %>%
  mutate(color = if_else(weight > 0 & t_value > 0, '1', color)) %>%
  mutate(color = if_else(weight > 0 & t_value < 0, '2', color)) %>%
  mutate(color = if_else(weight < 0 & t_value > 0, '2', color)) %>%
  mutate(color = if_else(weight < 0 & t_value < 0, '1', color))

ggplot(df, aes(x = weight, y = t_value, color = color)) + geom_point() +
  scale_colour_manual(values = c("red","royalblue3","grey")) +
  geom_label_repel(aes(label = ID)) +
  theme_minimal() +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 'dotted') +
  geom_hline(yintercept = 0, linetype = 'dotted') +
  ggtitle(pathway)
#> Warning: ggrepel: 442 unlabeled data points (too many overlaps). Consider increasing max.overlaps
```

![](data:image/png;base64...)

The pathway seems to be active since the majority of target genes with positive
weights have positive t-values (1st quadrant), and the majority of the ones with
negative weights have negative t-values (3d quadrant).

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
#>  package      * version   date (UTC) lib source
#>  backports      1.5.0     2024-05-23 [2] CRAN (R 4.5.1)
#>  bibtex         0.5.1     2023-01-26 [2] CRAN (R 4.5.1)
#>  BiocManager    1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel   1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle    * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit            4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64          4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
#>  blob           1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown       0.45      2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib          0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem         1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  cellranger     1.1.0     2016-07-27 [2] CRAN (R 4.5.1)
#>  checkmate      2.3.3     2025-08-18 [2] CRAN (R 4.5.1)
#>  chromote       0.5.1     2025-04-24 [2] CRAN (R 4.5.1)
#>  cli            3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  codetools      0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
#>  cowplot        1.2.0     2025-07-07 [2] CRAN (R 4.5.1)
#>  crayon         1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  curl           7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
#>  data.table     1.17.8    2025-07-10 [2] CRAN (R 4.5.1)
#>  DBI            1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
#>  decoupleR    * 2.16.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  dichromat      2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
#>  digest         0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr        * 1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate       1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  farver         2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap        1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  fastmatch      1.1-6     2024-12-23 [2] CRAN (R 4.5.1)
#>  fgsea          1.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  fs             1.6.6     2025-04-12 [2] CRAN (R 4.5.1)
#>  generics       0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  ggplot2      * 4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
#>  ggrepel      * 0.9.6     2024-09-07 [2] CRAN (R 4.5.1)
#>  glue           1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable         0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
#>  hms            1.1.4     2025-10-17 [2] CRAN (R 4.5.1)
#>  htmltools      0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  httr           1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2          1.2.1     2025-07-22 [2] CRAN (R 4.5.1)
#>  igraph         2.2.1     2025-10-27 [2] CRAN (R 4.5.1)
#>  jquerylib      0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite       2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr          1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling       0.4.3     2023-08-29 [2] CRAN (R 4.5.1)
#>  later          1.4.4     2025-08-27 [2] CRAN (R 4.5.1)
#>  lattice        0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle      1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  logger         0.4.1     2025-09-11 [2] CRAN (R 4.5.1)
#>  lubridate      1.9.4     2024-12-08 [2] CRAN (R 4.5.1)
#>  magick         2.9.0     2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr       2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix         1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
#>  memoise        2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
#>  OmnipathR      3.18.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  otel           0.2.0     2025-08-29 [2] CRAN (R 4.5.1)
#>  parallelly     1.45.1    2025-07-24 [2] CRAN (R 4.5.1)
#>  pheatmap     * 1.0.13    2025-06-05 [2] CRAN (R 4.5.1)
#>  pillar         1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig      2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr           1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
#>  prettyunits    1.2.0     2023-09-24 [2] CRAN (R 4.5.1)
#>  processx       3.8.6     2025-02-21 [2] CRAN (R 4.5.1)
#>  progress       1.2.3     2023-12-06 [2] CRAN (R 4.5.1)
#>  promises       1.4.0     2025-10-22 [2] CRAN (R 4.5.1)
#>  ps             1.9.1     2025-04-12 [2] CRAN (R 4.5.1)
#>  purrr          1.1.0     2025-07-10 [2] CRAN (R 4.5.1)
#>  R.methodsS3    1.8.2     2022-06-13 [2] CRAN (R 4.5.1)
#>  R.oo           1.27.1    2025-05-02 [2] CRAN (R 4.5.1)
#>  R.utils        2.13.0    2025-02-24 [2] CRAN (R 4.5.1)
#>  R6             2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs       0.3.3     2021-01-31 [2] CRAN (R 4.5.1)
#>  RColorBrewer   1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp           1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  readr          2.1.5     2024-01-10 [2] CRAN (R 4.5.1)
#>  readxl         1.4.5     2025-03-07 [2] CRAN (R 4.5.1)
#>  RefManageR   * 1.4.0     2022-09-30 [2] CRAN (R 4.5.1)
#>  rlang          1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown      2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  RSQLite        2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
#>  rvest          1.0.5     2025-08-29 [2] CRAN (R 4.5.1)
#>  S7             0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
#>  sass           0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  scales         1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
#>  selectr        0.4-2     2019-11-20 [2] CRAN (R 4.5.1)
#>  sessioninfo    1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  stringi        1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr        1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
#>  tibble       * 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr        * 1.3.1     2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect     1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange     0.3.0     2024-01-18 [2] CRAN (R 4.5.1)
#>  tinytex        0.57      2025-04-15 [2] CRAN (R 4.5.1)
#>  tzdb           0.5.0     2025-03-15 [2] CRAN (R 4.5.1)
#>  utf8           1.2.6     2025-06-08 [2] CRAN (R 4.5.1)
#>  vctrs          0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  vroom          1.6.6     2025-09-19 [2] CRAN (R 4.5.1)
#>  websocket      1.4.4     2025-04-10 [2] CRAN (R 4.5.1)
#>  withr          3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun           0.53      2025-08-19 [2] CRAN (R 4.5.1)
#>  XML            3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
#>  xml2           1.4.1     2025-10-27 [2] CRAN (R 4.5.1)
#>  yaml           2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>  zip            2.3.3     2025-05-13 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpwS46co/Rinst3e53b4d0d164d
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```