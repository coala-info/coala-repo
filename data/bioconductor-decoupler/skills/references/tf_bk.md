Code

* Show All Code
* Hide All Code

# Transcription factor activity inference in bulk RNA-seq

Pau Badia-i-Mompel1

1Heidelberg Universiy

#### 29 October 2025

#### Package

decoupleR 2.16.0

Bulk RNA-seq yield many molecular readouts that are hard to interpret by
themselves. One way of summarizing this information is by inferring
transcription factor (TF) activities from prior knowledge.

In this notebook we showcase how to use `decoupleR` for transcription factor activity
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
obtained t-value and p-value from the contrast:

```
# Extract t-values per gene
deg <- data$limma_ttop %>%
    select(ID, logFC, t, P.Value) %>%
    filter(!is.na(t)) %>%
    column_to_rownames(var = "ID") %>%
    as.matrix()
head(deg)
#>             logFC          t      P.Value
#> RHBDL2  -1.823940 -12.810588 3.030276e-06
#> PLEKHH2 -1.568830 -10.794453 9.932046e-06
#> HEG1    -1.725806  -9.788112 1.939734e-05
#> CLU     -1.786200  -9.761618 1.975813e-05
#> FHL1     2.087082   8.950191 3.552199e-05
#> RBP4    -1.728960  -8.529074 4.904579e-05
```

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
# Run ulm
sample_acts <- run_ulm(mat=counts, net=net, .source='source', .target='target',
                  .mor='mor', minsize = 5)
sample_acts
#> # A tibble: 3,480 × 5
#>    statistic source condition           score p_value
#>    <chr>     <chr>  <chr>               <dbl>   <dbl>
#>  1 ulm       ABL1   PANC1.FOXA2KO.Rep1 -0.428  0.669
#>  2 ulm       ABL1   PANC1.FOXA2KO.Rep2 -0.104  0.917
#>  3 ulm       ABL1   PANC1.FOXA2KO.Rep3  0.335  0.738
#>  4 ulm       ABL1   PANC1.WT.Rep1       0.142  0.887
#>  5 ulm       ABL1   PANC1.WT.Rep2      -0.344  0.731
#>  6 ulm       ABL1   PANC1.WT.Rep3      -0.523  0.601
#>  7 ulm       AHR    PANC1.FOXA2KO.Rep1  1.58   0.113
#>  8 ulm       AHR    PANC1.FOXA2KO.Rep2  1.70   0.0885
#>  9 ulm       AHR    PANC1.FOXA2KO.Rep3  1.85   0.0640
#> 10 ulm       AHR    PANC1.WT.Rep1       1.38   0.169
#> # ℹ 3,470 more rows
```

# 5 Visualization

From the obtained results we will observe the most variable activities across samples in a heat-map:

```
n_tfs <- 25

# Transform to wide matrix
sample_acts_mat <- sample_acts %>%
  pivot_wider(id_cols = 'condition', names_from = 'source',
              values_from = 'score') %>%
  column_to_rownames('condition') %>%
  as.matrix()

# Get top tfs with more variable means across clusters
tfs <- sample_acts %>%
  group_by(source) %>%
  summarise(std = sd(score)) %>%
  arrange(-abs(std)) %>%
  head(n_tfs) %>%
  pull(source)
sample_acts_mat <- sample_acts_mat[,tfs]

# Scale per sample
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

We can also infer TF activities from the t-values of the DEGs between KO
and WT:

```
# Run ulm
contrast_acts <- run_ulm(mat=deg[, 't', drop=FALSE], net=net, .source='source', .target='target',
                  .mor='mor', minsize = 5)
contrast_acts
#> # A tibble: 580 × 5
#>    statistic source condition   score p_value
#>    <chr>     <chr>  <chr>       <dbl>   <dbl>
#>  1 ulm       ABL1   t          1.08    0.280
#>  2 ulm       AHR    t          1.19    0.234
#>  3 ulm       AIRE   t         -0.155   0.877
#>  4 ulm       AP1    t          2.42    0.0154
#>  5 ulm       APEX1  t          0.877   0.380
#>  6 ulm       AR     t         -0.404   0.686
#>  7 ulm       ARID1A t         -0.236   0.813
#>  8 ulm       ARID3A t          1.85    0.0639
#>  9 ulm       ARID3B t          1.24    0.215
#> 10 ulm       ARID4A t         -0.0674  0.946
#> # ℹ 570 more rows
```

Let’s show the changes
in activity between KO and WT:

```
# Filter top TFs in both signs
f_contrast_acts <- contrast_acts %>%
  mutate(rnk = NA)
msk <- f_contrast_acts$score > 0
f_contrast_acts[msk, 'rnk'] <- rank(-f_contrast_acts[msk, 'score'])
f_contrast_acts[!msk, 'rnk'] <- rank(-abs(f_contrast_acts[!msk, 'score']))
tfs <- f_contrast_acts %>%
  arrange(rnk) %>%
  head(n_tfs) %>%
  pull(source)
f_contrast_acts <- f_contrast_acts %>%
  filter(source %in% tfs)

# Plot
ggplot(f_contrast_acts, aes(x = reorder(source, score), y = score)) +
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
    xlab("TFs")
```

![](data:image/png;base64...)

The TFs GLI3 and SPDEF are deactivated in KO when
compared to WT, while MUC and NFKB1 seem to be activated.

We can further visualize the most differential target genes in each TF along their
p-values to interpret the results. For example, let’s see the genes that are
belong to SP1:

```
tf <- 'SP1'

df <- net %>%
  filter(source == tf) %>%
  arrange(target) %>%
  mutate(ID = target, color = "3") %>%
  column_to_rownames('target')

inter <- sort(intersect(rownames(deg),rownames(df)))
df <- df[inter, ]
df[,c('logfc', 't_value', 'p_value')] <- deg[inter, ]
df <- df %>%
  mutate(color = if_else(mor > 0 & t_value > 0, '1', color)) %>%
  mutate(color = if_else(mor > 0 & t_value < 0, '2', color)) %>%
  mutate(color = if_else(mor < 0 & t_value > 0, '2', color)) %>%
  mutate(color = if_else(mor < 0 & t_value < 0, '1', color))

ggplot(df, aes(x = logfc, y = -log10(p_value), color = color, size=abs(mor))) +
  geom_point() +
  scale_colour_manual(values = c("red","royalblue3","grey")) +
  geom_label_repel(aes(label = ID, size=1)) +
  theme_minimal() +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 'dotted') +
  geom_hline(yintercept = 0, linetype = 'dotted') +
  ggtitle(tf)
```

![](data:image/png;base64...)

Here blue means that the sign of multiplying the `mor` and `t-value` is negative,
meaning that these genes are “deactivating” the TF, and red means that the sign
is positive, meaning that these genes are “activating” the TF.

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