Code

* Show All Code
* Hide All Code

# Guide to Multi-Gene Plots

Nicholas J. Eagles1\* and Leonardo Collado-Torres1,2\*\*

1Lieber Institute for Brain Development, Johns Hopkins Medical Campus
2Department of Biostatistics, Johns Hopkins Bloomberg School of Public Health

\*nickeagles77@gmail.com
\*\*lcolladotor@gmail.com

#### 4 November 2025

#### Package

spatialLIBD 1.22.0

One of the goals of `spatialLIBD` is to provide options for visualizing Visium data by 10x Genomics. In
particular, `vis_gene()` and `vis_clus()` allow plotting of individual continuous or
discrete quantities belonging to each Visium spot, in a spatially accurate manner and
optionally atop histology images.

This vignette explores a more complex capability of `vis_gene()`: to visualize a summary
metric of several continuous variables simultaneously. We’ll start with a basic one-gene
use case for `vis_gene()` before moving to more advanced cases.

First, let’s load some example data for us to work on. This data is a subset from a recent publication with Visium data from the dorsolateral prefrontal cortex (DLPFC) (Huuki-Myers, Spangler, Eagles, Montgomergy, Kwon, Guo, Grant-Peters, Divecha, Tippani, Sriworarat, Nguyen, Ravichandran, Tran, Seyedian, Consortium, Hyde, Kleinman, Battle, Page, Ryten, Hicks, Martinowich, Collado-Torres, and Maynard, 2024).

```
library("spatialLIBD")
spe <- fetch_data(type = "spatialDLPFC_Visium_example_subset")
spe
#> class: SpatialExperiment
#> dim: 28916 12107
#> metadata(1): BayesSpace.data
#> assays(2): counts logcounts
#> rownames(28916): ENSG00000243485 ENSG00000238009 ... ENSG00000278817 ENSG00000277196
#> rowData names(7): source type ... gene_type gene_search
#> colnames(12107): AAACAAGTATCTCCCA-1 AAACACCAATAACTGC-1 ... TTGTTTGTATTACACG-1 TTGTTTGTGTAAATTC-1
#> colData names(155): age array_col ... VistoSeg_proportion wrinkle_type
#> reducedDimNames(8): 10x_pca 10x_tsne ... HARMONY UMAP.HARMONY
#> mainExpName: NULL
#> altExpNames(0):
#> spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
#> imgData names(4): sample_id image_id data scaleFactor
```

Next, let’s define several genes known to be markers for white matter (Tran, Maynard, Spangler et al., 2021).

```
white_matter_genes <- c("GFAP", "AQP4", "MBP", "PLP1")
white_matter_genes <- rowData(spe)$gene_search[
    rowData(spe)$gene_name %in% white_matter_genes
]

## Our list of white matter genes
white_matter_genes
#> [1] "GFAP; ENSG00000131095" "AQP4; ENSG00000171885" "MBP; ENSG00000197971"  "PLP1; ENSG00000123560"
```

# 1 Plotting One Gene

A typical use of `vis_gene()` involves
plotting the spatial distribution of a single gene or continuous variable of interest.
For example, let’s plot just the expression of *GFAP*.

```
vis_gene(
    spe,
    geneid = white_matter_genes[1],
    point_size = 1.5
)
```

![](data:image/png;base64...)

We can see a little **V** shaped section with higher expression of this gene. This seems to mark the location of layer 1. The bottom right corner seems to mark the location of white matter.

```
plot(imgRaster(spe))
```

![](data:image/png;base64...)

This particular gene is known to have high expression in both layer 1 and white matter in the dorsolateral prefrontal cortex as can be seen below (Maynard, Collado-Torres, Weber et al., 2021). It’s the 386th highest ranked white matter marker gene based on the enrichment test.

```
modeling_results <- fetch_data(type = "modeling_results")
#> 2025-11-04 11:48:00.21571 loading file /home/biocbuild/.cache/R/BiocFileCache/195c812bb20746_Human_DLPFC_Visium_modeling_results.Rdata%3Fdl%3D1
sce_layer <- fetch_data(type = "sce_layer")
#> 2025-11-04 11:48:01.671405 loading file /home/biocbuild/.cache/R/BiocFileCache/195c81712eaa17_Human_DLPFC_Visium_processedData_sce_scran_sce_layer_spatialLIBD.Rdata%3Fdl%3D1
sig_genes <- sig_genes_extract_all(
    n = 400,
    modeling_results = modeling_results,
    sce_layer = sce_layer
)
i_gfap <- subset(sig_genes, gene == "GFAP" &
    test == "WM")$top
i_gfap
#> [1] 386
set.seed(20200206)
layer_boxplot(
    i = i_gfap,
    sig_genes = sig_genes,
    sce_layer = sce_layer
)
```

![](data:image/png;base64...)

# 2 Plotting Multiple Genes

As of version 1.15.2, the `geneid` parameter to `vis_gene()` may also take a vector of genes or continuous
variables in `colData(spe)`. In this way, the expression of multiple continuous variables can be summarized
into a single value for each spot, displayed just as a single input for `geneid` would be.
`spatialLIBD` provides three methods for merging the information from multiple continuous
variables, which may be specified through the `multi_gene_method` parameter to `vis_gene()`.

## 2.1 Averaging Z-scores

The default is `multi_gene_method = "z_score"`. Essentially, each continuous variable (could be a mix of genes with spot-level covariates) is
normalized to be a Z-score by centering and scaling. If a particular spot has a value of `1` for a particular continuous variable,
this would indicate that spot has expression one standard deviation above the mean expression
across all spots for that continuous variable. Next, for each spot, Z-scores are averaged across continuous variables.
Compared to simply averaging raw gene expression across genes, the `"z_score"` method
is insensitive to absolute expression levels (highly expressed genes don’t dominate plots),
and instead focuses on how each gene varies spatially, weighting each gene equally.

Let’s plot all four white matter genes using this method.

```
vis_gene(
    spe,
    geneid = white_matter_genes,
    multi_gene_method = "z_score",
    point_size = 1.5
)
```

![](data:image/png;base64...)

Now the bottom right corner where the white matter is located starts to pop up more, though the mixed layer 1 and white matter signal provided by *GFAP* is still noticeable (the **V** shape).

## 2.2 Summarizing with PCA

Another option is `multi_gene_method = "pca"`. A matrix is formed, where genes or continuous
features are columns, and spots are rows. PCA is performed, and the first principal component
is plotted spatially. The idea is that the first PC captures the dominant spatial signature
of the feature set. Next, its direction is reversed if the majority of coefficients (from the
“rotation matrix”) across features are negative. When the features are genes whose expression
is highly correlated (like our white-matter-gene example!), this optional reversal encourages
higher values in the plot to represent areas of higher expression of the features. For our case,
this leads to the intuitive result that “expression” is higher in white matter for white-matter
genes, which is not otherwise guaranteed (the “sign” of PCs is arbitrary)!

```
vis_gene(
    spe,
    geneid = white_matter_genes,
    multi_gene_method = "pca",
    point_size = 1.5
)
```

![](data:image/png;base64...)

## 2.3 Plotting Sparsity of Expression

This final option is `multi_gene_method = "sparsity"`. For each spot, the proportion of features
with positive expression is plotted. This method is typically only meaningful when features
are raw gene counts that are expected to be quite sparse (have zero counts) at certain regions
of the tissue and not others. It also performs better with a larger number of genes; with our
example of four white-matter genes, the proportion may only hold values of 0, 0.25, 0.5, 0.75,
and 1, which is not visually informative.

The white-matter example is thus poor due to lack of sparsity and low number of genes as you can see below.

```
vis_gene(
    spe,
    geneid = white_matter_genes,
    multi_gene_method = "sparsity",
    point_size = 1.5
)
```

![](data:image/png;base64...)

# 3 With more marker genes

Below we can plot via `multi_gene_method = "z_score"` the top 25 or top 50 white matter marker genes identified via the enrichment test in a previous dataset (Maynard, Collado-Torres, Weber et al., 2021).

```
vis_gene(
    spe,
    geneid = subset(sig_genes, test == "WM")$ensembl[seq_len(25)],
    multi_gene_method = "z_score",
    point_size = 1.5
)
```

![](data:image/png;base64...)

```
vis_gene(
    spe,
    geneid = subset(sig_genes, test == "WM")$ensembl[seq_len(50)],
    multi_gene_method = "z_score",
    point_size = 1.5
)
```

![](data:image/png;base64...)

We can repeat this process for `multi_gene_method = "pca"`.

```
vis_gene(
    spe,
    geneid = subset(sig_genes, test == "WM")$ensembl[seq_len(25)],
    multi_gene_method = "pca",
    point_size = 1.5
)
```

![](data:image/png;base64...)

```
vis_gene(
    spe,
    geneid = subset(sig_genes, test == "WM")$ensembl[seq_len(50)],
    multi_gene_method = "pca",
    point_size = 1.5
)
```

![](data:image/png;base64...)

And finally, lets look at the results of `multi_gene_method = "sparsity"`.

```
vis_gene(
    spe,
    geneid = subset(sig_genes, test == "WM")$ensembl[seq_len(25)],
    multi_gene_method = "sparsity",
    point_size = 1.5
)
```

![](data:image/png;base64...)

```
vis_gene(
    spe,
    geneid = subset(sig_genes, test == "WM")$ensembl[seq_len(50)],
    multi_gene_method = "sparsity",
    point_size = 1.5
)
```

![](data:image/png;base64...)

In this case, it seems that for both the top 25 or top 50 marker genes, `z_score` and `pca` provided cleaner visualizations than `sparsity`. Give them a try on your own datasets!

# 4 Visualizing non-gene continuous variables

So far, we have only visualized multiple genes. But these methods can be applied to several continuous variables stored in `colData(spe)` as shown below.

```
vis_gene(
    spe,
    geneid = c("sum_gene", "sum_umi"),
    multi_gene_method = "z_score",
    point_size = 1.5
)
```

![](data:image/png;base64...)

We can also combine continuous variables from `colData(spe)` along with actual genes. We can combine for example the expression of *GFAP*, which is a known astrocyte marker gene, with the spot deconvolution results for astrocytes computed using Tangram (Huuki-Myers, Spangler, Eagles et al., 2024).

```
vis_gene(
    spe,
    geneid = c("broad_tangram_astro"),
    point_size = 1.5
)
```

![](data:image/png;base64...)

```
vis_gene(
    spe,
    geneid = c("broad_tangram_astro", white_matter_genes[1]),
    multi_gene_method = "pca",
    point_size = 1.5
)
```

![](data:image/png;base64...)

These tools enable you to further explore your data in new ways. Have fun using them!

# 5 Reproducibility

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("multi_gene_plots.Rmd"))

## Extract the R code
library("knitr")
knit("multi_gene_plots.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-11-04 11:48:30 EST"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 40.283 secs
```

`R` session information.

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
#>  date     2025-11-04
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version   date (UTC) lib source
#>  abind                  1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
#>  AnnotationDbi          1.72.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationHub          4.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  attempt                0.3.1     2020-05-03 [2] CRAN (R 4.5.1)
#>  backports              1.5.0     2024-05-23 [2] CRAN (R 4.5.1)
#>  beachmat               2.26.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  beeswarm               0.4.0     2021-06-01 [2] CRAN (R 4.5.1)
#>  benchmarkme            1.0.8     2022-06-12 [2] CRAN (R 4.5.1)
#>  benchmarkmeData        1.0.4     2020-04-23 [2] CRAN (R 4.5.1)
#>  bibtex                 0.5.1     2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocFileCache        * 3.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocIO                 1.20.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocNeighbors          2.4.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocParallel           1.44.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocSingular           1.26.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.38.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocVersion            3.22.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
#>  bitops                 1.0-9     2024-10-03 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.45      2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  Cairo                  1.7-0     2025-10-29 [2] CRAN (R 4.5.1)
#>  cigarillo              1.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  circlize               0.4.16    2024-02-20 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  clue                   0.3-66    2024-11-13 [2] CRAN (R 4.5.1)
#>  cluster                2.1.8.1   2025-03-12 [3] CRAN (R 4.5.1)
#>  codetools              0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
#>  colorspace             2.1-2     2025-09-22 [2] CRAN (R 4.5.1)
#>  ComplexHeatmap         2.26.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  config                 0.3.2     2023-08-30 [2] CRAN (R 4.5.1)
#>  cowplot                1.2.0     2025-07-07 [2] CRAN (R 4.5.1)
#>  crayon                 1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  curl                   7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
#>  data.table             1.17.8    2025-07-10 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
#>  dbplyr               * 2.5.1     2025-09-10 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  DelayedMatrixStats     1.32.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat              2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  doParallel             1.0.17    2022-02-07 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  dqrng                  0.4.1     2024-05-28 [2] CRAN (R 4.5.1)
#>  DropletUtils           1.30.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  DT                     0.34.0    2025-09-02 [2] CRAN (R 4.5.1)
#>  edgeR                  4.8.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  evaluate               1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  ExperimentHub          3.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  filelock               1.0.3     2023-12-11 [2] CRAN (R 4.5.1)
#>  foreach                1.5.2     2022-02-02 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicAlignments      1.46.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicRanges        * 1.62.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  GetoptLong             1.0.5     2020-12-15 [2] CRAN (R 4.5.1)
#>  ggbeeswarm             0.7.2     2023-04-29 [2] CRAN (R 4.5.1)
#>  ggplot2                4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
#>  ggrepel                0.9.6     2024-09-07 [2] CRAN (R 4.5.1)
#>  GlobalOptions          0.1.2     2020-06-10 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  golem                  0.5.1     2024-08-27 [2] CRAN (R 4.5.1)
#>  gridExtra              2.3       2017-09-09 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
#>  h5mread                1.2.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  HDF5Array              1.38.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  htmltools              0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets            1.6.4     2023-12-06 [2] CRAN (R 4.5.1)
#>  httpuv                 1.6.16    2025-04-16 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2                  1.2.1     2025-07-22 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  irlba                  2.3.5.1   2022-10-03 [2] CRAN (R 4.5.1)
#>  iterators              1.0.14    2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling               0.4.3     2023-08-29 [2] CRAN (R 4.5.1)
#>  later                  1.4.4     2025-08-27 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lazyeval               0.2.2     2019-03-15 [2] CRAN (R 4.5.1)
#>  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  limma                  3.66.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  lobstr               * 1.1.2     2022-06-22 [2] CRAN (R 4.5.1)
#>  locfit                 1.5-9.12  2025-03-05 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4     2024-12-08 [2] CRAN (R 4.5.1)
#>  magick                 2.9.0     2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
#>  mime                   0.13      2025-03-17 [2] CRAN (R 4.5.1)
#>  otel                   0.2.0     2025-08-29 [2] CRAN (R 4.5.1)
#>  paletteer              1.6.0     2024-01-21 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  plotly                 4.11.0    2025-06-19 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
#>  png                    0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
#>  prettyunits            1.2.0     2023-09-24 [2] CRAN (R 4.5.1)
#>  prismatic              1.1.2     2024-04-10 [2] CRAN (R 4.5.1)
#>  promises               1.5.0     2025-11-01 [2] CRAN (R 4.5.1)
#>  purrr                  1.1.0     2025-07-10 [2] CRAN (R 4.5.1)
#>  R.methodsS3            1.8.2     2022-06-13 [2] CRAN (R 4.5.1)
#>  R.oo                   1.27.1    2025-05-02 [2] CRAN (R 4.5.1)
#>  R.utils                2.13.0    2025-02-24 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs               0.3.3     2021-01-31 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  RCurl                  1.98-1.17 2025-03-22 [2] CRAN (R 4.5.1)
#>  RefManageR           * 1.4.0     2022-09-30 [2] CRAN (R 4.5.1)
#>  rematch2               2.1.2     2020-05-01 [2] CRAN (R 4.5.1)
#>  restfulr               0.0.16    2025-06-27 [2] CRAN (R 4.5.1)
#>  rhdf5                  2.54.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  rhdf5filters           1.22.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  Rhdf5lib               1.32.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  rjson                  0.2.23    2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  Rsamtools              2.26.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  RSQLite                2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
#>  rsvd                   1.0.5     2021-04-16 [2] CRAN (R 4.5.1)
#>  rtracklayer          * 1.70.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Arrays               1.10.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  ScaledMatrix           1.18.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  scales                 1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
#>  scater                 1.38.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  scuttle                1.20.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  Seqinfo              * 1.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  shape                  1.4.6.1   2024-02-23 [2] CRAN (R 4.5.1)
#>  shiny                  1.11.1    2025-07-03 [2] CRAN (R 4.5.1)
#>  shinyWidgets           0.9.0     2025-02-21 [2] CRAN (R 4.5.1)
#>  SingleCellExperiment * 1.32.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  SparseArray            1.10.1    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  sparseMatrixStats      1.22.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  SpatialExperiment    * 1.20.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  spatialLIBD          * 1.22.0    2025-11-04 [1] Bioconductor 3.22 (R 4.5.1)
#>  statmod                1.5.1     2025-10-09 [2] CRAN (R 4.5.1)
#>  stringi                1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment * 1.40.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr                  1.3.1     2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0     2024-01-18 [2] CRAN (R 4.5.1)
#>  tinytex                0.57      2025-04-15 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  vipor                  0.4.7     2023-12-18 [2] CRAN (R 4.5.1)
#>  viridis                0.6.5     2024-01-29 [2] CRAN (R 4.5.1)
#>  viridisLite            0.4.2     2023-05-02 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.54      2025-10-30 [2] CRAN (R 4.5.1)
#>  XML                    3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
#>  xml2                   1.4.1     2025-10-27 [2] CRAN (R 4.5.1)
#>  xtable                 1.8-4     2019-04-21 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpBXD2ka/Rinst8a4186f8154c0
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 6 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025), *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2014) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-huukimyers2024data)
L. A. Huuki-Myers, A. Spangler, N. J. Eagles, et al.
“A data-driven single-cell and spatial transcriptomic map of the human prefrontal cortex”.
In: *Science* (2024).
DOI: [10.1126/science.adh1938](https://doi.org/10.1126/science.adh1938).
URL: <https://doi.org/10.1126/science.adh1938>.

[[3]](#cite-maynard2021transcriptome)
K. R. Maynard, L. Collado-Torres, L. M. Weber, et al.
“Transcriptome-scale spatial gene expression in the human dorsolateral prefrontal cortex”.
In: *Nature Neuroscience* (2021).
DOI: [10.1038/s41593-020-00787-0](https://doi.org/10.1038/s41593-020-00787-0).
URL: <https://www.nature.com/articles/s41593-020-00787-0>.

[[4]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[5]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[6]](#cite-pardo2022spatiallibd)
B. Pardo, A. Spangler, L. M. Weber, et al.
“spatialLIBD: an R/Bioconductor package to visualize spatially-resolved transcriptomics data”.
In: *BMC Genomics* (2022).
DOI: [10.1186/s12864-022-08601-w](https://doi.org/10.1186/s12864-022-08601-w).
URL: <https://doi.org/10.1186/s12864-022-08601-w>.

[[7]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[8]](#cite-righelli2022spatialexperiment)
D. Righelli, L. M. Weber, H. L. Crowell, et al.
“SpatialExperiment: infrastructure for spatially-resolved transcriptomics data in R using Bioconductor”.
In: *Bioinformatics* 38.11 (2022), pp. -3.
DOI: [https://doi.org/10.1093/bioinformatics/btac299](https://doi.org/https%3A//doi.org/10.1093/bioinformatics/btac299).

[[9]](#cite-tran2021)
M. N. Tran, K. R. Maynard, A. Spangler, et al.
“Single-nucleus transcriptome analysis reveals cell-type-specific molecular signatures across reward circuitry in the human brain”.
In: *Neuron* (2021).
DOI: [10.1016/j.neuron.2021.09.001](https://doi.org/10.1016/j.neuron.2021.09.001).

[[10]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[11]](#cite-xie2014knitr)
Y. Xie.
“knitr: A Comprehensive Tool for Reproducible Research in R”.
In:
*Implementing Reproducible Computational Research*.
Ed. by V. Stodden, F. Leisch and R. D. Peng.
ISBN 978-1466561595.
Chapman and Hall/CRC, 2014.