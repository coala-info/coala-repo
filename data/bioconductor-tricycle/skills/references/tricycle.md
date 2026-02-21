# tricycle: Transferable Representation and Inference of Cell Cycle

Shijie C. Zheng1\*

1Department of Biostatistics, Johns Hopkins Bloomberg School of Public Health

\*shijieczheng@gmail.com

#### 30 October 2025

#### Package

tricycle 1.18.0

# Contents

* [1 Introduction](#introduction)
* [2 Prerequisites](#prerequisites)
* [3 Overview of the package functionality](#overview-of-the-package-functionality)
* [4 Project a single cell data set to pre-learned cell cycle space](#project-a-single-cell-data-set-to-pre-learned-cell-cycle-space)
* [5 Infer cell cycle position](#infer-cell-cycle-position)
* [6 Assessing performance](#assessing-performance)
* [7 Alternative: Infer cell cycle stages](#alternative-infer-cell-cycle-stages)
* [8 Plot out the kernel density](#plot-out-the-kernel-density)
* [9 Plot out embedding scater plot colored by cell cycle position](#plot-out-embedding-scater-plot-colored-by-cell-cycle-position)
* [10 Make a new reference](#make-a-new-reference)
* [11 Make a new reference using datasets with batch effects](#make-a-new-reference-using-datasets-with-batch-effects)
* [Session info](#session-info)
* [12 References](#references)
* **Appendix**

![logo](data:image/png;base64...)

# 1 Introduction

Here we describe a package for inferring cell cycle position for a single-cell
RNA-seq dataset. The theoretical justification as well as benchmarks are
included in (Zheng et al. [2022](#ref-Zheng.2022)). In our hands, our approach (called TriCycle) works
robustly across a variety of data modalities including across species (human
and mouse), cell types and assay technology (10X, Fluidigm C1); we have yet to
encounter a dataset where this approach does not work. The main output is a
continuous estimate of the relative time within the cell cycle, represented as
a number between 0 and 2pi (which we refer to as cell cycle position). In
addition to the estimation process, we include a number of convenience functions
for visualizing cell cycle time and we also provide an implementation of a
discrete cell cycle stage predictor.

# 2 Prerequisites

```
library(tricycle)
```

We recommend users to start with a *SingleCellExperiment* object. The output
will usually be the *SingleCellExperiment* with new info added. The functions
work on *matrix* or *SummarizedExperiment* objects although the output changes,
since these type of objects do not have the capability to store both the input
object and the estimates.

In the package, we include a example *SingleCellExperiment* dataset, which is a
real subset of mouse Neurosphere RNAseq of 2 samples. 200 cells from sample AX1
and AX2 were randonly sampled from the full data. This dataset is the same data
as we use for constructing our cell cycle embedding.

```
data(neurosphere_example)
```

**Important**: Please note that the user should **normalize library size**
before putting into the tricycle functions. The library size normalization could
be done by *normalizeCounts* function in *scater* package or by calculating CPM
values.

# 3 Overview of the package functionality

The method is based on taking a new dataset and projecting it into an embedding
representing cell cycle. This embedding is constructed using a reference
dataset. What is perhaps surprising is our finding that the same embedding is
appropriate for all the experiments we have looked at, including across species,
cell types and datasets. We are providing this embedding space as part of the
package, and we do not expect users to change this embedding (although the
functions in the package supports other embeddings).

The method is simple: you take a new dataset and project it into the latent
space and infer cell cycle time. The key functions here are

* `project_cycle_space()`
* `estimate_cycle_position()`

The next step is to verify that the cell cycle time was successfully predicted.
This involves looking at a number of useful plots. This involves a number of
useful visualization. Note for example our use of color scheme - because cell
cycle time “wraps around” the \([0,2\pi]\) interval, it is very useful to use a
color palette which also “wraps around”. The relevant functions are

* `plot_emb_circle_space()`
* `circle_space_legend()`
* `fit_periodic_loess()`

We also provide a separate cell cycle stage predictor, predicting 5 different
stages; `estimate_Schwabe_stage()`. This predictor is a small modification of the
method proposed by (Schwabe et al. [2020](#ref-Schwabe.2020)). **We include this function only for the purpose of convenience.**
**This is not part of tricycle method!**

Finally we have a set of functions for creating your own reference latent space.

# 4 Project a single cell data set to pre-learned cell cycle space

`project_cycle_space()` will automatically project the assay with name
`logcounts` into the cell cycle embedding without any other argument input. You
could specify species (default as mouse), gene IDs, gene ID type, and
`AnnotationDb` object if gene mapping is needed. Refer to
`man(project_cycle_space)` for details.

```
neurosphere_example <- project_cycle_space(neurosphere_example)
#> No custom reference projection matrix provided. The ref learned from mouse Neuroshpere data will be used.
#> The number of projection genes found in the new data is 500.
neurosphere_example
#> class: SingleCellExperiment
#> dim: 1500 400
#> metadata(0):
#> assays(2): counts logcounts
#> rownames(1500): ENSMUSG00000056763 ENSMUSG00000025925 ...
#>   ENSMUSG00000044221 ENSMUSG00000040234
#> rowData names(2): Gene Accession
#> colnames(400): AX1_CTACGTCCAAACCCAT AX1_AACTCTTTCATTCACT ...
#>   AX2_CGAGAAGCACTACAGT AX2_CATATTCGTCTGCGGT
#> colData names(2): TotalUMIs sample
#> reducedDimNames(1): tricycleEmbedding
#> mainExpName: NULL
#> altExpNames(0):
```

The projected cell cycle space will be stored in *reducedDims* with name
“tricycleEmbedding” (you could set other embedding name.).

```
library(ggplot2)
library(scattermore)
library(scater)
scater::plotReducedDim(neurosphere_example, dimred = "tricycleEmbedding") +
    labs(x = "Projected PC1", y = "Projected PC2") +
    ggtitle(sprintf("Projected cell cycle space (n=%d)",
                    ncol(neurosphere_example))) +
    theme_bw(base_size = 14)
```

![](data:image/png;base64...)

# 5 Infer cell cycle position

Once the new data has been projected into the cell cycle embedding, cell cycle
position is estimated using `estimate_cycle_position()`. If the data has not
been projected, this function will do the projection for you. Assuming a
*SingleCellExperiment* as input, the cell cycle position will be addded to the
`colData` of the object, with the name `tricyclePosition`.

```
neurosphere_example <- estimate_cycle_position(neurosphere_example)
names(colData(neurosphere_example))
#> [1] "TotalUMIs"        "sample"           "tricyclePosition"
```

The estimated cell cycle position is bound between 0 and 2pi. Note that we
strive to get high resolution of cell cycle state, and we think the continuous
position is more appropriate when describing the cell cycle. However, to help
users understand the position variable, we also note that users can
approximately relate 0.5pi to be the start of S stage, pi to be the start of G2M
stage, 1.5pi to be the middle of M stage, and 1.75pi-0.25pi to be G1/G0 stage.

# 6 Assessing performance

We have two ways of (quickly) assessing whether TriCycle works. They are

1. Look at the projection of the data into the cell cycle embedding.
2. Look at the expression of key genes as a function of cell cycle position.

Plotting the projection of the data into the cell cycle embedding is shown
above. Our observation is that deeper sequenced data will have a more clearly
ellipsoid pattern with an empty interior. As sequencing depth decreases, the
radius of the ellipsoid decreases until the empty interior disappears. So the
absence of an interior does not mean the method does not work.

It is more important to inspect a couple of genes as a function of cell cycle
position. We tend to use Top2a which is highly expressed and therefore
“plottable” in every dataset. Other candidates are for example Smc2. To plot
this data, we provide a convenient function `fit_periodic_loess()` to fit a
loess line between the cyclic variable \(\theta\) and other response variables.
This fitting is done by making `theta.v` 3 periods
`(c(theta.v - 2 * pi, theta.v, theta.v + 2 * pi))` and repeating `y` 3 times.
Only the fitted values corresponding to original `theta.v` will be returned.
In this example, we show how well the expression of the cell cycle marker gene
*Top2a* change along \(\theta\).

```
top2a.idx <- which(rowData(neurosphere_example)$Gene == 'Top2a')
fit.l <- fit_periodic_loess(neurosphere_example$tricyclePosition,
                            assay(neurosphere_example, 'logcounts')[top2a.idx,],
                            plot = TRUE,
                       x_lab = "Cell cycle position \u03b8", y_lab = "log2(Top2a)",
                       fig.title = paste0("Expression of Top2a along \u03b8 (n=",
                                          ncol(neurosphere_example), ")"))
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the tricycle package.
#>   Please report the issue at <https://github.com/hansenlab/tricycle/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the tricycle package.
#>   Please report the issue at <https://github.com/hansenlab/tricycle/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
names(fit.l)
#> [1] "fitted"   "residual" "pred.df"  "loess.o"  "rsquared" "fig"
fit.l$fig + theme_bw(base_size = 14)
```

![](data:image/png;base64...)

For Top2a we expect peak expression around \(\pi\).

# 7 Alternative: Infer cell cycle stages

This method was proposed by Schwabe et al. ([2020](#ref-Schwabe.2020)). We did small modifications to
reduce `NA` assignments. But on average, the performance is quite similar to the
original implementation in [Revelio](https://github.com/danielschw188/Revelio/)
package. In brief, we calculate the *z*-scores of highly expressed stage
specific cell cycle marker genes, and assgin the cell to the stage with the
greatest *z*-score.

```
neurosphere_example <- estimate_Schwabe_stage(neurosphere_example,
                                            gname.type = 'ENSEMBL',
                                            species = 'mouse')
#> This function is a re-implementation of Schwabe et al. 2020. If you want to use tricycle method, please run estimate_cycle_position!
#> No gname input. Rownames of x will be used.
#>
#> No AnnotationDb desginated. org.Mm.eg.db will be used to map Mouse ENSEMBL id to gene SYMBOL.
#> Batch 1 phase G1.S gene:50
#> Batch 1 phase S gene:43
#> Batch 1 phase G2 gene:61
#> Batch 1 phase G2.M gene:67
#> Batch 1 phase M.G1 gene:30
scater::plotReducedDim(neurosphere_example, dimred = "tricycleEmbedding",
                       colour_by = "CCStage") +
  labs(x = "Projected PC1", y = "Projected PC2",
       title = paste0("Projected cell cycle space (n=", ncol(neurosphere_example), ")")) +
  theme_bw(base_size = 14)
```

![](data:image/png;base64...)

# 8 Plot out the kernel density

Another useful function is *plot\_ccposition\_den*, which computes kernel density
of \(\theta\) conditioned on a phenotype using von Mises distribution. The ouput
figures are provided in two flavors, polar coordinates and Cartesian
coordinates. This could be useful when comparing different cell types,
treatments, or just stages. (Because we use a very small dataset here as
example, we set the bandwith, i.e. the concentration parameter of the von Mises
distribution as 10 to get a smooth line.)

```
plot_ccposition_den(neurosphere_example$tricyclePosition,
                    neurosphere_example$sample, 'sample',
                    bw = 10, fig.title = "Kernel density of \u03b8") +
  theme_bw(base_size = 14)
```

![](data:image/png;base64...)

```
plot_ccposition_den(neurosphere_example$tricyclePosition,
                    neurosphere_example$sample, 'sample', type = "circular",
                    bw = 10,  fig.title = "Kernel density of \u03b8") +
  theme_bw(base_size = 14)
```

![](data:image/png;base64...)

# 9 Plot out embedding scater plot colored by cell cycle position

To visualize the cell cycle position \(\theta\) on any embedding, we need to
carefully choose a cyclic color palette. Thus, we include such functions to
plot any embedding of *SingleCellExperiment* object with cyclic variables. A
companion helper function to create the cyclic legend is also available.

```
library(cowplot)
p <- plot_emb_circle_scale(neurosphere_example, dimred = 1,
                           point.size = 3.5, point.alpha = 0.9) +
  theme_bw(base_size = 14)
legend <- circle_scale_legend(text.size = 5, alpha = 0.9)
plot_grid(p, legend, ncol = 2, rel_widths = c(1, 0.4))
```

![](data:image/png;base64...)

We plot our our projection embedding. In practice, user could use other
embedding, such as UMAP or t-SNE and get informative representations too.

# 10 Make a new reference

Users could make their own reference by doing PCA on the cell cycle genes, and
use the learned rotation matrix as the reference matrix in other functions. Here
is an example, we just use *run\_pca\_cc\_genes* function to extract Gene Ontology
cell cycle genes (GO:0007049) and run PCA. By projecting the data itself with
the learned reference, the projections are equivalent to direct PCA results.
But you could use this newly learned reference to project other datasets.

```
set.seed(100)
gocc_sce.o <- run_pca_cc_genes(neurosphere_example,
                               exprs_values = "logcounts", species = "mouse")
#> No AnnotationDb desginated. org.Mm.eg.db will be used to map Mouse ENSEMBL id to gene SYMBOL.
#> No gname input. Rownames of sce.o will be used.
#> 'select()' returned 1:many mapping between keys and columns
#> 559 out of 3883 Gene Ontology cell cycle genes found in your data.
new.ref <- attr(reducedDim(gocc_sce.o, 'PCA'), 'rotation')[, seq_len(2)]
head(new.ref)
#>                            PC1         PC2
#> ENSMUSG00000040204  0.22398543 -0.16792534
#> ENSMUSG00000023067 -0.02874398  0.16193205
#> ENSMUSG00000020649  0.18325463 -0.16423536
#> ENSMUSG00000001403  0.18625220  0.21602791
#> ENSMUSG00000060860  0.04242764  0.07928622
#> ENSMUSG00000020914  0.19612816 -0.02306874
new_sce <- estimate_cycle_position(neurosphere_example, ref.m  = new.ref,
                                   dimred = 'tricycleEmbedding2')
#> The designated dimred do not exist in the SingleCellExperiment or in altexp. project_cycle_space will be run to calculate embedding tricycleEmbedding2
#> The number of projection genes found in the new data is 500.
```

Note: If user wants to calculate correlation between two cyclic variables, such
as cell cycle position, traditional pearson’s correlation coefficient won’t
consider the cyclic nature. Users could use (absolute) circular correlation
values instead. (The signs of PC1 and PC2 are not deterministic when
re-learning the reference by performing PCA. If the PC1 is flipped, there will
be a \(\pi\) shift. So does PC2. If the user fixes the reference, there won’t be
any flipping. But considering the variations around \(0\) or \(2\pi\), circular
correlation should still be used instead of pearson’s correlation coefficient.)

```
cor(neurosphere_example$tricyclePosition, new_sce$tricyclePosition)
#> [1] -0.3157748
CircStats::circ.cor(neurosphere_example$tricyclePosition, new_sce$tricyclePosition)
#>           r
#> 1 0.9656581
qplot(x = neurosphere_example$tricyclePosition,y = new_sce$tricyclePosition) +
  labs(x = "Original \u03b8", y = "New \u03b8",
       title = paste0("Comparison of two \u03b8 (n=", ncol(neurosphere_example), ")")) +
  theme_bw(base_size = 14)
#> Warning: `qplot()` was deprecated in ggplot2 3.4.0.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

# 11 Make a new reference using datasets with batch effects

This section introduce how to make a new reference using dataset with batch
effects. It is only recommended for expert users who identifies batch effects in
their data and want to use that data to build a custom reference.
In theory, the users could use other methods to remove batch effect. Here, we
use *Seurat*, which is used to construct our Neurosphere reference
(Zheng et al. ([2022](#ref-Zheng.2022))), as an example. (The code in this section is not evaluated.)

```
# suppose we have a count matrix containing all cells across batches; we first subset the matrix to GO cell cycle genes
library(org.Mm.eg.db)
library(AnnotationDbi)
cc.genes <- AnnotationDbi::select(org.Mm.eg.db, keytype = "GOALL",
                                  keys = "GO:0007049",
                                  columns = "ENSEMBL")[, "ENSEMBL"]
count_cc.m <- count.m[ensembl.ids %in% cc.genes, ]  # ensembl.ids is the ensembl.ids for each row of count.m

# we then construct a Seurat object using the subset matrix and set the batch variable
library(Seurat)
seurat.o <- CreateSeuratObject(counts = count_cc.m)
seurat.o[["batch"]] <- batch.v

# make a Seurat list and normalize for each batch separately
# variable features definition is required for FindIntegrationAnchors function
seurat.list <- lapply(SplitObject(seurat.o, split.by = "batch"),
                      function(x) FindVariableFeatures(NormalizeData(x)))

# find anchors and merge data
seurat.anchors <- FindIntegrationAnchors(object.list = seurat.list)
seurat.integrated <- IntegrateData(anchorset = seurat.anchors)
corrected.m <- seurat.integrated@assays$integrated@data

# run PCA on the batch effects corrected matrix and get the rotaions scores for the top 2 PCs
pca.m <- scater::calculatePCA(corrected.m, ntop = 500)
new.ref <- attr(pca.m, 'rotation')[, seq_len(2)]
```

# Session info

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] cowplot_1.2.0               scater_1.38.0
#>  [3] scuttle_1.20.0              scattermore_1.2
#>  [5] ggplot2_4.0.0               tricycle_1.18.0
#>  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [9] Biobase_2.70.0              GenomicRanges_1.62.0
#> [11] Seqinfo_1.0.0               IRanges_2.44.0
#> [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [15] generics_0.1.4              MatrixGenerics_1.22.0
#> [17] matrixStats_1.5.0           BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1     viridisLite_0.4.2    vipor_0.4.7
#>  [4] dplyr_1.1.4          farver_2.1.2         blob_1.2.4
#>  [7] viridis_0.6.5        Biostrings_2.78.0    S7_0.2.0
#> [10] fastmap_1.2.0        digest_0.6.37        rsvd_1.0.5
#> [13] mime_0.13            lifecycle_1.0.4      KEGGREST_1.50.0
#> [16] RSQLite_2.4.3        magrittr_2.0.4       compiler_4.5.1
#> [19] CircStats_0.2-7      rlang_1.1.6          sass_0.4.10
#> [22] tools_4.5.1          yaml_2.3.10          knitr_1.50
#> [25] labeling_0.4.3       S4Arrays_1.10.0      bit_4.6.0
#> [28] DelayedArray_0.36.0  RColorBrewer_1.1-3   abind_1.4-8
#> [31] BiocParallel_1.44.0  withr_3.0.2          grid_4.5.1
#> [34] beachmat_2.26.0      MASS_7.3-65          scales_1.4.0
#> [37] tinytex_0.57         dichromat_2.0-0.1    cli_3.6.5
#> [40] mvtnorm_1.3-3        rmarkdown_2.30       crayon_1.5.3
#> [43] httr_1.4.7           DBI_1.2.3            ggbeeswarm_0.7.2
#> [46] cachem_1.1.0         parallel_4.5.1       AnnotationDbi_1.72.0
#> [49] BiocManager_1.30.26  XVector_0.50.0       vctrs_0.6.5
#> [52] boot_1.3-32          Matrix_1.7-4         jsonlite_2.0.0
#> [55] bookdown_0.45        BiocSingular_1.26.0  BiocNeighbors_2.4.0
#> [58] ggrepel_0.9.6        bit64_4.6.0-1        irlba_2.3.5.1
#> [61] beeswarm_0.4.0       magick_2.9.0         ggnewscale_0.5.2
#> [64] jquerylib_0.1.4      glue_1.8.0           org.Mm.eg.db_3.22.0
#> [67] codetools_0.2-20     gtable_0.3.6         circular_0.5-2
#> [70] ScaledMatrix_1.18.0  tibble_3.3.0         pillar_1.11.1
#> [73] htmltools_0.5.8.1    R6_2.6.1             evaluate_1.0.5
#> [76] lattice_0.22-7       png_0.1-8            memoise_2.0.1
#> [79] bslib_0.9.0          Rcpp_1.1.0           gridExtra_2.3
#> [82] SparseArray_1.10.0   xfun_0.53            pkgconfig_2.0.3
```

# 12 References

Schwabe, Daniel, Sara Formichetti, Jan Philipp Junker, Martin Falcke, and Nikolaus Rajewsky. 2020. “The Transcriptome Dynamics of Single Cells During the Cell Cycle.” *Molecular Systems Biology* 16 (11): e9946. <https://doi.org/10.15252/msb.20209946>.

Zheng, Shijie C., Genevieve Stein-O’Brien, Jonathan J. Augustin, Jared Slosberg, Giovanni A. Carosso, Briana Winer, Gloria Shin, Hans T. Bjornsson, Loyal A. Goff, and Kasper D. Hansen. 2022. “Universal Prediction of Cell Cycle Position Using Transfer Learning.” *Genome Biology* 23: 41. <https://doi.org/10.1186/s13059-021-02581-y>.

# Appendix

In the package, we provide a reference, learned from the full dataset of the
mouse Neurosphere RNAseq. The reference gives weights of 500 cell cycle genes
and their IDs. Although learned from mouse, it is applicable to human data as
well, with the gene mapped by gene symbols.

```
data(neuroRef)
head(neuroRef)
#>                          pc1.rot     pc2.rot            ensembl symbol SYMBOL
#> ENSMUSG00000040204.6  -0.1989885  0.11245580 ENSMUSG00000040204  Pclaf  PCLAF
#> ENSMUSG00000020914.17 -0.1878494  0.04252486 ENSMUSG00000020914  Top2a  TOP2A
#> ENSMUSG00000060860.8  -0.0567803 -0.07531686 ENSMUSG00000060860  Ube2s  UBE2S
#> ENSMUSG00000001403.13 -0.1662416 -0.15992459 ENSMUSG00000001403  Ube2c  UBE2C
#> ENSMUSG00000026605.14 -0.1721841 -0.11416861 ENSMUSG00000026605  Cenpf  CENPF
#> ENSMUSG00000029177.9  -0.1357597 -0.19290262 ENSMUSG00000029177  Cenpa  CENPA
```