# Analysis of MCIA Decomposition

Max Mattessich, Joaquin Reyna, Edel Aron and Anna Konstorum

#### Compiled: February 03, 2026

# Introduction

## Motivation

Multiple co-inertia analysis (MCIA) is a member of the family of joint
dimensionality reduction (jDR) methods that extend unsupervised dimension reduction
techniques such as Principal Components Analysis (PCA) and Non-negative Matrix
Factorization (NMF) to datasets with multiple data blocks
(alternatively called views) ([Cantini, 2021](https://doi.org/10.1038/s41467-020-20430-7)).

Here, we present a new implementation in R of MCIA, `nipalsMCIA`,
that uses an extension of Non-linear Iterative Partial Least Squares (NIPALS)
to solve the MCIA optimization problem ([Hanafi, 2011](https://doi.org/10.1016/j.chemolab.2010.05.010)).
This implementation has several features, including speed-up over approaches that
employ the Singular Value Decomposition (SVD), several options for pre-processing
and deflation to customize algorithm performance, methodology to perform
out-of-sample global embedding, and analysis and visualization capabilities to
maximize result interpretation.

While there exist additional implementations of MCIA (e.g. [mogsa](https://www.bioconductor.org/packages/release/bioc/html/mogsa.html),
[omicade4](https://bioconductor.org/packages/release/bioc/html/omicade4.html)),
ours is unique in providing a pipeline that incorporates pre-processing data
options including those present in the original development of MCIA
(including a theoretically grounded calculation of inertia, or total variance)
with an iterative solver that shows speed-up for larger datasets, and is
explicitly designed for simultaneous ease of use as a tool for multi-view data
decomposition as well as a foundation for theoretical and computational
development of MCIA and related methodology. A manuscript detailing our
implementation is forthcoming.

## Overview

In this vignette, we will cover the most important functions
within the `nipalsMCIA` package as well as downstream analyses that can help
interpret the MCIA decomposition using a cancer data set from
[Meng et al., 2016](https://doi.org/10.1093/bib/bbv108) that includes 21
subjects with three data blocks. The data blocks include mRNA levels
(12895 features), microRNA levels (537 features) and protein levels
(7016 features).

The `nipals_multiblock` function performs MCIA using the NIPALS algorithm.
`nipals_multiblock` outputs a decomposition that includes a low-dimensional
embedding of the data in the form of global scores, and the contributions of
the data blocks (block score weights) and features (global loadings) to these
same global scores. `nipalsMCIA` provides several additional functions to
visualize, analyze, and interpret these results.

The `nipals_multiblock` function accepts as input a [MultiAssayExperiment](https://bioconductor.org/packages/release/bioc/html/MultiAssayExperiment.html)
(MAE) object. Such objects represent a modern classed-based approach to
organizing multi-omics data in which each assay can be stored as an individual
experiment alongside relevant metadata for samples and experiments. If users
have a list of data blocks with matching sample names (and optional sample-level
metadata), we provide a simple conversion function (`simple_mae.R`) to generate
an MAE object. For more sophisticated MAE object construction, please consult
the MAE documentation.

In the context of the NCI-60 data set and this vignette, we will show you the
power of MCIA to find important relationships between mRNA, microRNA and
proteins. More specifically, we will show you how to interpret the global
factor scores in [Part 1: Interpreting Global Factor Scores](#part-1-interpreting-global-factor-scores) and global loadings
in [Part 2: Interpreting Global Loadings](#part-2-interpreting-global-loadings).

## Installation

```
# devel version

# install.packages("devtools")
devtools::install_github("Muunraker/nipalsMCIA", ref = "devel",
                         force = TRUE, build_vignettes = TRUE) # devel version
```

```
# release version
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("nipalsMCIA")
```

```
library(ComplexHeatmap)
library(dplyr)
library(fgsea)
library(ggplot2)
library(ggpubr)
library(nipalsMCIA)
library(stringr)

# NIPALS starts with a random vector
set.seed(42)
```

## Preview of the NCI-60 dataset

The NCI-60 data set has been included with the `nipalsMCIA` package and is
easily available as shown below:

```
# load the dataset which uses the name data_blocks
data(NCI60)

# examine the contents
data_blocks$miRNA[1:3, 1:3]
```

|  | MI0000060\_miRNA | MI0000061\_miRNA | MI0000061.1\_miRNA |
| --- | --- | --- | --- |
| CNS.SF\_268 | 11.91 | 6.71 | 13.11 |
| CNS.SF\_295 | 11.94 | 7.13 | 12.86 |
| CNS.SF\_539 | 11.50 | 5.79 | 12.10 |

```
data_blocks$mrna[1:3, 1:3]
```

|  | 5-HT3C2\_1\_mrna | A1BG-AS1\_2\_mrna | A2LD1\_3\_mrna |
| --- | --- | --- | --- |
| CNS.SF\_268 | 0.53 | 0.35 | -0.05 |
| CNS.SF\_295 | -0.42 | 0.54 | -1.04 |
| CNS.SF\_539 | 0.00 | 0.80 | 0.85 |

```
data_blocks$prot[1:3, 1:3]
```

|  | STAU1\_1\_prot | NRAS\_2\_prot | HRAS\_3\_prot |
| --- | --- | --- | --- |
| CNS.SF\_268 | 5.712331 | 7.385177 | 5.758845 |
| CNS.SF\_295 | 0.000000 | 6.327175 | 0.000000 |
| CNS.SF\_539 | 0.000000 | 6.597432 | 0.000000 |

To convert data\_blocks into an MAE object we provide the `simple_mae()`
function:

```
data_blocks_mae <- simple_mae(data_blocks, row_format = "sample")
```

# Running and reviewing the MCIA output

We can compute the MCIA decomposition for \(r\) global factors. For our example,
we take \(r=10\).

```
set.seed(42)
mcia_results <- nipals_multiblock(data_blocks_mae,
                                  col_preproc_method = "colprofile",
                                  num_PCs = 10, tol = 1e-12, plots = "none")
```

The result is an NipalsResult object containing several outputs from the decomposition:

```
slotNames(mcia_results)
```

```
##  [1] "global_scores"        "global_loadings"      "block_score_weights"
##  [4] "block_scores"         "block_loadings"       "eigvals"
##  [7] "col_preproc_method"   "block_preproc_method" "block_variances"
## [10] "metadata"
```

We describe the first two in more detail below, and will discuss several others
in the remainder of the vignette. For additional details on the decomposition, see
([Hanafi, 2011](https://doi.org/10.1016/j.chemolab.2010.05.010),
[Mattesich, 2022](http://hdl.handle.net/10427/CZ30Q6773)).

## Brief overview of the Global Scores Matrix (\(F\))

The `global_scores` matrix is represented by \(\mathbf{F}\) with dimensions
\(n \times r\), where \(n\) is the number of samples and \(r\) is the number of
factors chosen by using the `num_PCs = r` argument. Each column \(j\) of this matrix
represents the global scores for factor \(j\),

\[
\mathbf{F} = \begin{pmatrix}
| & |& & |\\
\mathbf{f}^{(1)} &\mathbf{f}^{(2)} & \dots & \mathbf{f}^{(r)}\\
| & |& & |
\end{pmatrix} \in \mathbb{R}^{n \times r}
\]

This matrix encodes a low-dimensional representation of the data set, with the
\(i\)-th row representing a set of \(r\)-dimensional coordinates for the \(i\)-th
sample.

## Brief overview of the Global Loadings Matrix (\(A\))

The `global_loadings` matrix is represented by \(\mathbf{A}\) that is \(p \times r\),
where \(p\) is the number of features across all omics and \(r\) is as before.
Each column \(j\) of this matrix represents the global loadings for factor \(j\),
i.e.

\[
\mathbf{A} = \begin{pmatrix}
| & |& & |\\
\mathbf{a}^{(1)} &\mathbf{a}^{(2)} & \dots & \mathbf{a}^{(r)}\\
| & |& & |
\end{pmatrix} \in \mathbb{R}^{p \times r}
\]

This matrix encodes the contribution (`loading`) of each feature to the global
score.

The remainder of this vignette will be broken down into two sections,
[Part 1: Interpreting Global Factor Scores](#part-1-interpreting-global-factor-scores) and [Part 2: Interpreting Global Loadings](#part-2-interpreting-global-loadings)
where we show how to interpret \(\mathbf{F}\) and \(\mathbf{A}\), respectively.

# Part 1: Interpreting Global Factor Scores

## nipals\_multiblock() Generates Basic Visualizations

In the introduction we showed how to calculate the MCIA decomposition using
`nipals_multiblock()` but used the parameter `plots = "none"` to avoid the
default plotting behavior of this function. By default, this function will
generate two plots which help establish an initial intuition for the MCIA
decomposition. Here we will re-run `nipals_multiblock()` with the default `plots`
parameter (`all`):

```
set.seed(42)
mcia_results <- nipals_multiblock(data_blocks_mae,
                                  col_preproc_method = "colprofile",
                                  num_PCs = 10, tol = 1e-12)
```

![](data:image/jpeg;base64...)

The first plot visualizes each sample using factor 1 and 2 as a lower
dimensional representation (factor plot).

* Each sample is represented by 4 points, a center point (solid bla’ck
  dot) which represents the global factor score, a mRNA factor score (square), a
  miRNA factor score (circle), and a protein factor score (triangle).
* The last three omic-specific block factor scores are connected to the global
  factor score. If a block factor scores is plotted far from its
  corresponding global factor score, then this is an indication that the block
  does not agree with/contribute to the trend found by the global decomposition.
* As an example, we can take a look at the global factor score at \((-1.1, 0.4)\).
  The block factor scores are all quite near which suggests all three omics are
  contributing somewhat equally. This is in contrast to the global factor score at
  \((-0.3, 0.9)\) where the mRNA factor score is close, but the mRNA and miRNA are
  far from their respective global factor score.

The second plot is a scree plot of normalized singular values corresponding to
the variance explained by each factor.

## Visualizing a Factor Plot with Only Global Factor Scores

For clustering, it is useful to look at global factor scores without block
factor scores. The `projection_plot()` function can be used to generate such a
plot using `projection = "global"`.

```
projection_plot(mcia_results, projection = "global", orders = c(1, 2))
```

![](data:image/jpeg;base64...)

In addition, scores can be colored by a meaningful label such as cancer type
which is highly relevant to NCI-60. To do so, the `colData` slot of the associated
MAE object must be loaded with sample-level metadata prior to invoking
`projection_plot()`. The sample metadata is composed of row names corresponding to
the primary sample names of the MAE object, and columns contain different
metadata (e.g. age, disease status, etc). For instance, each of the 21 samples
in the NCI-60 dataset represents a cell line with one of three cancer types:
CNS, Leukemia, or Melanoma. We have provided this metadata as part of the
`data(NCI60)` dataset and we next show how it can be included in the resulting MAE
object using the `colData` parameter in `simple_mae()`:

```
# preview of metadata
head(metadata_NCI60)
```

|  | cancerType |
| --- | --- |
| CNS.SF\_268 | CNS |
| CNS.SF\_295 | CNS |
| CNS.SF\_539 | CNS |
| CNS.SNB\_19 | CNS |
| CNS.SNB\_75 | CNS |
| CNS.U251 | CNS |

```
# loading of mae with metadata
data_blocks_mae <- simple_mae(data_blocks, row_format = "sample",
                              colData = metadata_NCI60)
```

We now rerun `nipals_multiblock()` using the updated MAE object, where the
`colData` is passed to the `metadata` slot of the `NipalsResult` instance, and
then visualize the global factor scores using the `projection_plot()` function.

```
# adding metadata as part of the nipals_multiblock() function
set.seed(42)
mcia_results <- nipals_multiblock(data_blocks_mae,
                                  col_preproc_method = "colprofile",
                                  plots = "none",
                                  num_PCs = 10, tol = 1e-12)
```

The `color_col` argument of `projection_plot()` can then be used to determine
which column of `metadata` is used for coloring the individual data points, in
this case `cancerType`. `color_pal` is used to assign a color palette and
requires a vector of colors (i.e. `c("blue", "red", "green")`). To help create
this vector we also provide `get_metadata_colors()`, a helper function (used
below) that can be used with a `scales::<function>` to return an appropriate
vector of colors. Note: colors are applied by lexicographically sorting the list
of unique metadata values then assigning the first color to the first value,
second with second and so on.

```
# meta_colors = c("blue", "grey", "yellow") can use color names
# meta_colors = c("#00204DFF", "#7C7B78FF", "#FFEA46FF") can use hex codes
meta_colors <- get_metadata_colors(mcia_results, color_col = 1,
                                   color_pal_params = list(option = "E"))

projection_plot(mcia_results, projection = "global", orders = c(1, 2),
                color_col = "cancerType", color_pal = meta_colors,
                legend_loc = "bottomleft")
```

![](data:image/jpeg;base64...)

Using this plot one can observe that global factor scores for factor 1 and 2 can
separate samples into their cancer types.

## Visualizing the Clustering of Samples by Factor Scores

A heatmap can be used to cluster samples based on global scores across all factors
using `global_scores_heatmap()`. The samples can be colored by the associated metadata
using `color_cor` + `color_pal`as shown below.

```
global_scores_heatmap(mcia_results = mcia_results,
                      color_col = "cancerType", color_pal = meta_colors)
```

![](data:image/jpeg;base64...)

Like the projection plot, one can observe that the clustering can differentiate
between cancer type quite effectively.

# Part 2: Interpreting Global Loadings

In addition to the global scores matrix, MCIA also calculates a global loadings
matrix \(A\) that is \(p\times r\).

## Pseudoeigenvalues Representing the Contribution of Each Omic to the Global Factor Score

The global loadings matrix is calculated using a weighted sum of the block loadings.
These weights can be interpreted as the contribution of each omic to the global
factor score (i.e. *pseudoeigenvalue*), and can be visualized using the function `block_weights_heatmap()`.

```
block_weights_heatmap(mcia_results)
```

![](data:image/jpeg;base64...)

For example, we can observe that factors 7-9 have the strongest contribution
from the protein data.

## Visualize All Feature Loadings on Two Axes

MCIA returns feature loadings for each factor that can be used to understand
important contributions. To get a sense of which omics features show high
contribution to each factor, one can plot feature loadings for any two omics
using the `vis_load_plot` function. The features that take the most extreme
values will be the strongest contributors to that factor.

```
# colors_omics = c("red", "blue", "green")
# colors_omics <- get_colors(mcia_results, color_pal = colors_omics)
colors_omics <- get_colors(mcia_results)

vis_load_plot(mcia_results, axes = c(1, 4), color_pal = colors_omics)
```

```
## Warning: Use of `gl_f[[colnames(gl_f)[1]]]` is discouraged.
## ℹ Use `.data[[colnames(gl_f)[1]]]` instead.
```

```
## Warning: Use of `gl_f[[colnames(gl_f)[2]]]` is discouraged.
## ℹ Use `.data[[colnames(gl_f)[2]]]` instead.
```

![](data:image/jpeg;base64...)

From this plot, we can deduce that individual miRNA features tend to
have the most extreme values in factors 1 and 4, thereby contributing most strongly
to the global scores for those factors.

## Scree Plot: Visualizing the Top Features per Factor

To dive into each factor users can generate a scree plot of top loading
values using the following two steps/functions: 1) `ord_loadings()` which
calculates a list of ranked feature loadings, and 2) `vis_load_ord()` which
takes as input ranked values from step (1) to generate a scree plot. Features
can be ranked based on ascending or descending values and/or absolute value.
Users can also plot features from all omics together or focus on a specific
omic by using a corresponding block name (i.e. mrna).

### Factor 1

Here, we visualize two ranked lists for Factor 1: using all omics,
or just mrna.

```
# generate the visualizations
all_pos_1_vis <- vis_load_ord(mcia_results, omic = "all", factor = 1,
                              absolute = FALSE, descending = TRUE)
mrna_pos_1_vis <- vis_load_ord(mcia_results, omic = "mrna", factor = 1,
                               absolute = FALSE, descending = TRUE)

ggpubr::ggarrange(all_pos_1_vis, mrna_pos_1_vis)
```

![](data:image/jpeg;base64...)

The ordering itself can be easily obtained using the `ord_loadings(...)`
function.

```
# obtain the loadings as plotted above
all_pos_1 <- ord_loadings(mcia_results, omic = "all", factor = 1,
                          absolute = FALSE, descending = TRUE)
mrna_pos_1 <- ord_loadings(mcia_results, omic = "mrna", factor = 1,
                           absolute = FALSE, descending = TRUE)
```

```
# visualize the tabular data
all_pos_1[1:3, ]
```

|  | loading | omic | omic\_name | factor |
| --- | --- | --- | --- | --- |
| MI0000284\_miRNA | 0.0975913 | miRNA | MI0000284\_miRNA | 1 |
| MI0000266\_miRNA | 0.0973219 | miRNA | MI0000266\_miRNA | 1 |
| MI0000267\_miRNA | 0.0880913 | miRNA | MI0000267\_miRNA | 1 |

```
mrna_pos_1[1:3, ]
```

|  | loading | omic | omic\_name | factor |
| --- | --- | --- | --- | --- |
| GNS\_3797\_mrna | 0.0185457 | mrna | GNS\_3797\_mrna | 1 |
| WASL\_12215\_mrna | 0.0185012 | mrna | WASL\_12215\_mrna | 1 |
| LAPTM4A\_4988\_mrna | 0.0174990 | mrna | LAPTM4A\_4988\_mrna | 1 |

The first plot shows that that miRNA has the overall top positive feature loadings for
factor 1, whereas the second plot allows us to focus on only mRNA signals,
where genes like *GNS* and *WASL* come up as top contributors.

### Factor 2

Here, we return and visualize two ranked lists for Factor 2: using all omics,
or just protein, this time ranking features by magnitude (absolute value).

```
# define the loadings
all_abs_2 <- vis_load_ord(mcia_results, omic = "all", factor = 2,
                          absolute = TRUE, descending = TRUE)

prot_abs_2 <- vis_load_ord(mcia_results, omic = "prot", factor = 2,
                           absolute = TRUE, descending = TRUE)

ggpubr::ggarrange(all_abs_2, prot_abs_2)
```

![](data:image/jpeg;base64...)

```
# obtain the loadings as plotted above
all_abs_2_vis <- ord_loadings(mcia_results, omic = "all", factor = 2,
                          absolute = TRUE, descending = TRUE)
prot_abs_2_vis <- ord_loadings(mcia_results, omic = "prot", factor = 2,
                          absolute = TRUE, descending = TRUE)
```

```
# visualize the tabular data
all_abs_2_vis[1:3, ]
```

|  | loading | omic | abs | omic\_name | factor |
| --- | --- | --- | --- | --- | --- |
| MI0001735\_miRNA | -0.1505451 | miRNA | 0.1505451 | MI0001735\_miRNA | 2 |
| MI0003132\_miRNA | -0.1326578 | miRNA | 0.1326578 | MI0003132\_miRNA | 2 |
| MI0000744\_miRNA | -0.1254875 | miRNA | 0.1254875 | MI0000744\_miRNA | 2 |

```
prot_abs_2_vis[1:3, ]
```

|  | loading | omic | abs | omic\_name | factor |
| --- | --- | --- | --- | --- | --- |
| THY1\_1801\_prot | -0.0267105 | prot | 0.0267105 | THY1\_1801\_prot | 2 |
| IGFBP7\_1337\_prot | -0.0261220 | prot | 0.0261220 | IGFBP7\_1337\_prot | 2 |
| COL5A1\_6730\_prot | -0.0245067 | prot | 0.0245067 | COL5A1\_6730\_prot | 2 |

For factor 2, we again see that across all omics, miRNA is playing the strongest
role. One important difference (relative to factor 1) is made by ranking the
values according to the absolute value. Doing so allows us to identify 9 (out
of 15) features with a strong negative loading value. The right plot shows that
the negatively values protein features have the largest absolute values, indicating
that they may play a distinct role from the miRNA in global scores for this factor.

### Factor 4

We return and visualize a ranked list for Factor 4 with the top 60 features.

```
# visualization
all_4_plot <- vis_load_ord(mcia_results, omic = "all", factor = 4,
                           absolute = FALSE, descending = TRUE, n_feat = 60)
all_4_plot
```

![](data:image/jpeg;base64...)

```
# visualize the tabular data
all_4 <- ord_loadings(mcia_results, omic = "all", factor = 4,
                      absolute = FALSE, descending = TRUE)
```

One can observe that while miRNA dominate the top features, proteins are also
represented.

## Pathway Analysis for the Top Factors using Data from Gene-Centric Omics Blocks

The NCI-60 data set includes gene expression data, and its corresponding global
loading matrix is a gene by factor matrix. We can learn more about the pathways
over-represented in a given factor by running the global loadings for the factor
through a gene set enrichment analysis (GSEA). Here, we look at factors 1 and 3.
We run `gsea_report()`, which reports on the p-value of the most significant
pathway as well as the total number of significant pathways for each factor.

### Gather Data and Generate the Report

```
# extract mRNA global loadings
mrna_gfscores <- nmb_get_gl(mcia_results)
mrna_rows <- str_detect(row.names(mrna_gfscores), "_mrna")
mrna_gfscores <- mrna_gfscores[mrna_rows, ]

# rename rows to contain HUGO based gene symbols
row.names(mrna_gfscores) <- str_remove(rownames(mrna_gfscores), "_[0-9]*_.*")

# load pathway data
path.database <- "https://data.broadinstitute.org/gsea-msigdb/msigdb/release/6.2/c2.cp.reactome.v6.2.symbols.gmt"
pathways <- fgsea::gmtPathways(gmt.file = path.database)

# generate the GSEA report
geneset_report <- gsea_report(metagenes = mrna_gfscores, path.database,
                              factors = seq(1, 3), pval.thr = 0.05, nproc = 2)
```

### Investigating the GSEA Summary Table

The report comes in the form of a list where the first element is a data frame
with summary level of the GSEA analysis per factor. Ideally, each factor is
capturing a select number of pathways with a high significance. From this
report (below) we can see that the most significant pathway is associated with
Factor 3 and that there is a large variation in the number of total (significant)
pathways ranging from 7 (Factor 8) to 143 (Factor 4).

```
geneset_report[[1]]
```

|  | min\_pval | total\_pathways |
| --- | --- | --- |
| Factor1 | 2.38e-09 | 119 |
| Factor2 | 2.81e-08 | 95 |
| Factor3 | 8.45e-21 | 88 |

As just mentioned, Factor 3 contains the most enriched gene set so we can
re-run GSEA for this factor in order to get a full list of enrichment scores
across all gene sets:

```
# re-running GSEA
factor3_paths <- fgseaMultilevel(pathways, stats = mrna_gfscores[, 3],
                                 nPermSimple = 10000, minSize = 15,
                                 nproc = 2, maxSize = 500)
```

```
head(factor3_paths[, c("pathway", "padj")])
```

| pathway | padj |
| --- | --- |
| REACTOME CELL CYCLE | 1.59e-20 |
| REACTOME CELL CYCLE MITOTIC | 4.50e-18 |
| REACTOME GENERIC TRANSCRIPTION PATHWAY | 5.81e-13 |
| REACTOME DNA REPLICATION | 1.92e-09 |
| REACTOME MITOTIC M M G1 PHASES | 2.24e-09 |
| REACTOME PROCESSING OF CAPPED INTRON CONTAINING PR… | 4.43e-09 |

We observe that the most significant gene set is the REACTOME\_CELL\_CYCLE gene set.
Below we can take a look at the list of genes from REACTOME\_CELL\_CYCLE that
likely contribute to factor 3. This analysis can be repeated as necessary to
make sense of other gene based factor loadings.

```
# extracting REACTOME_CELL_CYCLE, the most significant gene set
sig_path3 <- factor3_paths[min(factor3_paths$padj) == factor3_paths$padj, ][1, ]
sig_path3$leadingEdge[[1]][1:10]
```

```
##  [1] "XRN2"  "FBXW7" "FBXL5" "USP11" "FBXW4" "NOP56" "FBXL3" "FBXO4" NA
## [10] NA
```

# Session Info

**Session Info**

```
sessionInfo()
```

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
## [1] grid      stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] stringr_1.6.0         nipalsMCIA_1.8.1      ggpubr_0.6.2
## [4] ggplot2_4.0.2         fgsea_1.36.2          dplyr_1.2.0
## [7] ComplexHeatmap_2.26.1 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rlang_1.1.7                 magrittr_2.0.4
##  [3] clue_0.3-66                 GetoptLong_1.1.0
##  [5] otel_0.2.0                  matrixStats_1.5.0
##  [7] compiler_4.5.2              png_0.1-8
##  [9] vctrs_0.7.1                 pkgconfig_2.0.3
## [11] shape_1.4.6.1               crayon_1.5.3
## [13] fastmap_1.2.0               backports_1.5.0
## [15] magick_2.9.0                XVector_0.50.0
## [17] labeling_0.4.3              rmarkdown_2.30
## [19] pracma_2.4.6                tinytex_0.58
## [21] purrr_1.2.1                 xfun_0.56
## [23] MultiAssayExperiment_1.36.1 cachem_1.1.0
## [25] jsonlite_2.0.0              DelayedArray_0.36.0
## [27] BiocParallel_1.44.0         broom_1.0.12
## [29] parallel_4.5.2              cluster_2.1.8.1
## [31] R6_2.6.1                    bslib_0.10.0
## [33] stringi_1.8.7               RColorBrewer_1.1-3
## [35] car_3.1-5                   GenomicRanges_1.62.1
## [37] jquerylib_0.1.4             Rcpp_1.1.1
## [39] Seqinfo_1.0.0               bookdown_0.46
## [41] SummarizedExperiment_1.40.0 iterators_1.0.14
## [43] knitr_1.51                  IRanges_2.44.0
## [45] BiocBaseUtils_1.12.0        Matrix_1.7-4
## [47] tidyselect_1.2.1            dichromat_2.0-0.1
## [49] abind_1.4-8                 yaml_2.3.12
## [51] doParallel_1.0.17           codetools_0.2-20
## [53] lattice_0.22-7              tibble_3.3.1
## [55] Biobase_2.70.0              withr_3.0.2
## [57] S7_0.2.1                    evaluate_1.0.5
## [59] circlize_0.4.17             pillar_1.11.1
## [61] BiocManager_1.30.27         MatrixGenerics_1.22.0
## [63] carData_3.0-6               foreach_1.5.2
## [65] stats4_4.5.2                generics_0.1.4
## [67] S4Vectors_0.48.0            scales_1.4.0
## [69] glue_1.8.0                  tools_4.5.2
## [71] data.table_1.18.2.1         RSpectra_0.16-2
## [73] ggsignif_0.6.4              fastmatch_1.1-8
## [75] cowplot_1.2.0               Cairo_1.7-0
## [77] tidyr_1.3.2                 colorspace_2.1-2
## [79] Formula_1.2-5               cli_3.6.5
## [81] S4Arrays_1.10.1             viridisLite_0.4.2
## [83] gtable_0.3.6                rstatix_0.7.3
## [85] sass_0.4.10                 digest_0.6.39
## [87] BiocGenerics_0.56.0         SparseArray_1.10.8
## [89] rjson_0.2.23                farver_2.1.2
## [91] htmltools_0.5.9             lifecycle_1.0.5
## [93] GlobalOptions_0.1.3
```