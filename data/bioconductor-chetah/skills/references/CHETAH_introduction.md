![CHETAHbanner](data:image/png;base64...)

# Introduction to the CHETAH package

#### Jurrian de Kanter

#### 2025-10-29

* [1 Introduction](#introduction)
  + [1.1 At a glance](#at-a-glance)
* [2 Some background](#some-background)
* [3 Installation](#installation)
* [4 Preparing your data](#preparing-your-data)
  + [4.1 Required data](#required-data)
  + [4.2 `SingleCellExperiments`](#sce)
* [5 Running CHETAH](#running-chetah)
  + [5.1 The output](#the-output)
  + [5.2 Standard plots](#standard-plots)
  + [5.3 `CHETAHshiny`](#chetahshiny)
* [6 Changing classification](#changing-classification)
  + [6.1 Confidence score](#confidence-score)
  + [6.2 Renaming types](#renaming-types)
* [7 Creating a reference](#ref-prep)
  + [7.1 Step 0: Obtain a reference.](#step-0-obtain-a-reference.)
  + [7.2 Step 1: good reference characteristics](#step-1-good-reference-characteristics)
  + [7.3 Step 1: normalization](#step-1-normalization)
  + [7.4 Step 2: discaring of house-keeping genes](#step-2-discaring-of-house-keeping-genes)
  + [7.5 Step 3: Reference QC](#step-3-reference-qc)
    - [7.5.1 CorrelateReference](#correlatereference)
    - [7.5.2 ClassifyReference](#classifyreference)
* [8 Optimizing the classification](#optimizing-the-classification)

# 1 Introduction

**CHETAH (CHaracterization of cEll Types Aided by Hierarchical classification) is a package for cell type identification of single-cell RNA-sequencing (scRNA-seq) data.**
A pre-print of the article describing CHETAH is available at [bioRxiv](https://www.biorxiv.org/content/10.1101/558908v1).

Summary: Cell types are assigned by correlating the input data to a reference in a hierarchical manner. This creates the possibility of assignment to intermediate types if the data does not allow to fully classify to one of the types in the reference. CHETAH is built to work with scRNA-seq references, but will also work (with limited capabilities) with RNA-seq or micro-array reference datasets. So, to run CHETAH, you will only need:

* your input data
* a reference dataset, annotated with cell types
  + Both as a `SingleCellExperiment`

## 1.1 At a glance

To run chetah on an input count matrix `input_counts` with t-SNE1 coordinates in `input_tsne`, and a reference count matrix `ref_counts` with celltypes vector `ref_ct`, run:

```
## Make SingleCellExperiments
reference <- SingleCellExperiment(assays = list(counts = ref_counts),
                                     colData = DataFrame(celltypes = ref_ct))

input <- SingleCellExperiment(assays = list(counts = input_counts),
                              reducedDims = SimpleList(TSNE = input_tsne))

## Run CHETAH
input <- CHETAHclassifier(input = input, ref_cells = reference)

## Plot the classification
PlotCHETAH(input)

## Extract celltypes:
celltypes <- input$celltype_CHETAH
```

**A tumor micro-environment reference dataset containing all major cell types for tumor data can be downloaded:** [here](https://figshare.com/s/aaf026376912366f81b6). This reference can be used for all (tumor) input datasets.

# 2 Some background

CHETAH constructs a classification tree by hierarchically clustering the reference data. The classification is guided by this tree. In each node of the tree, input cells are either assigned to the right, or the left branch. A confidence score is calculated for each of these assignments. When the confidence score for an assignment is lower than the threshold (default = 0.1), the classification for that cell stops in that node.

This results in two types of classifications:

* **final types**: Cells that are classified to one of the leaf nodes of the tree (i.e. a cell type of the reference).
* **intermediate types**: Cells that had a confidence score lower than the threshold in a certain node are assigned to that intermediate node of the tree. This happens when a cell has approximately the same similarity to the cell types in right and the left branch of that node.

  CHETAH generates generic names for the intermediate types: “Unassigned” for cells that are classified to the very first node, and “Node1”, “Node2”, etc for the additional nodes

# 3 Installation

CHETAH will be a part of Bioconductor starting at release 2.9 (30th of April), and will be available by:

```
## Install BiocManager is necessary
if (!require("BiocManager")) {
    install.packages("BiocManager")
}
BiocManager::install('CHETAH')

# Load the package
library(CHETAH)
```

The development version can be downloaded from the development version of Bioconductor (in R v3.6).

```
## Install BiocManager is necessary
if (!require("BiocManager")) {
    install.packages("BiocManager")
}
BiocManager::install('CHETAH', version = "devel")

# Load the package
library(CHETAH)
```

# 4 Preparing your data

## 4.1 Required data

If you have your data stored as `SingleCellExperiments`, continue to [the next step](#sce). Otherwise, you need the following data before you begin:

* input scRNA-seq count data of the cells to be classified
  + a data.frame or matrix, with cells in the columns and genes in the rows
* (!) normalized scRNA-seq count data of reference cells
  + in similar format as the input
* the cell types of the reference cells
  + a named character vector (names corresponding to the colnames of the reference counts)
* (optional) a 2D reduced dimensional representation of your input data for visualization: e.g. t-SNE1, PCA.
  + a two-column matrix/data.frame, with the cells in the rows and the two dimensions in the columns

As an example on how to prepare your data, we will use melanoma input data from [Tirosh et al.](10.1126/science.aad0501) and head-neck tumor reference data from [Puram et al.](10.1016/j.cell.2017.10.044) as an example.

For information on how to create your own reference see [Creating a Reference](#ref-prep)

```
## load CHETAH's datasets
data('headneck_ref')
data('input_mel')

## To prepare the data from the package's internal data, run:
celltypes_hn <- headneck_ref$celltypes
counts_hn <- assay(headneck_ref)
counts_melanoma <- assay(input_mel)
tsne_melanoma <- reducedDim(input_mel)

## The input data: a Matrix
class(counts_melanoma)
#> [1] "dgCMatrix"
#> attr(,"package")
#> [1] "Matrix"
counts_melanoma[1:5, 1:5]
#> 5 x 5 sparse Matrix of class "dgCMatrix"
#>              mel_cell1 mel_cell2 mel_cell3 mel_cell4 mel_cell5
#> ELMO2           .         .         .         4.5633    .
#> PNMA1           .         4.3553    .         .         .
#> MMP2            .         .         .         .         .
#> TMEM216         .         .         .         .         5.5624
#> TRAF3IP2-AS1    2.1299    4.0542    2.4209    1.6531    1.3144

## The reduced dimensions of the input cells: 2 column matrix
tsne_melanoma[1:5, ]
#>               tSNE_1    tSNE_2
#> mel_cell1  4.5034553 13.596680
#> mel_cell2 -4.0025667 -7.075722
#> mel_cell3  0.4734054  9.277648
#> mel_cell4  3.2201815 11.445236
#> mel_cell5 -0.3354758  5.092415
all.equal(rownames(tsne_melanoma), colnames(counts_melanoma))
#> [1] TRUE

## The reference data: a Matrix
class(counts_hn)
#> [1] "matrix" "array"
counts_hn[1:5, 1:5]
#>              hn_cell1 hn_cell2 hn_cell3 hn_cell4 hn_cell5
#> ELMO2         0.00000        0  0.00000  1.55430   4.2926
#> PNMA1         0.00000        0  0.00000  4.55360   0.0000
#> MMP2          0.00000        0  7.02880  4.50910   6.3006
#> TMEM216       0.00000        0  0.00000  0.00000   0.0000
#> TRAF3IP2-AS1  0.14796        0  0.65352  0.28924   3.6365

## The cell types of the reference: a named character vector
str(celltypes_hn)
#>  Named chr [1:180] "Fibroblast" "Fibroblast" "Fibroblast" "Fibroblast" ...
#>  - attr(*, "names")= chr [1:180] "hn_cell1" "hn_cell2" "hn_cell3" "hn_cell4" ...

## The names of the cell types correspond with the colnames of the reference counts:
all.equal(names(celltypes_hn), colnames(counts_melanoma))
#> [1] "Lengths (180, 150) differ (string compare on first 150)"
#> [2] "150 string mismatches"
```

## 4.2 `SingleCellExperiments`

CHETAH expects data to be in the format of a `SingleCellExperiment`, which is an easy way to store different kinds of data together. Comprehensive information on this data type can be found [here](https://bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html).

A `SingleCellExperiment` holds three things:

* counts: `assays`
  + as a `list` of `Matrices`
* meta-data: `colData`
  + as `DataFrames`
* reduced dimensions (e.g. t-SNE, PCA): `ReducedDims`
  + as a `SimpleList` of 2-column `data.frames` or `matrices`

CHETAH needs

* a reference `SingleCellExperiment` with:
  + an assay
  + a colData column with the corresponding cell types (default “celltypes”)
* an input `SingleCellExperiment` with:
  + an assay
  + a reducedDim (e.g. t-SNE)

For the example data, we would make the two objects by running:

```
## For the reference we define a "counts" assay and "celltypes" metadata
headneck_ref <- SingleCellExperiment(assays = list(counts = counts_hn),
                                     colData = DataFrame(celltypes = celltypes_hn))

## For the input we define a "counts" assay and "TSNE" reduced dimensions
input_mel <- SingleCellExperiment(assays = list(counts = counts_melanoma),
                                  reducedDims = SimpleList(TSNE = tsne_melanoma))
```

Note: CHETAH functions default to the first `assay`/`reducedDim` in an object and “celltypes” for the reference’s `colData`. See ?CHETAHclassifier and ?PlotCHETAH on how to change this behaviour.

# 5 Running CHETAH

Now that the data is prepared, running chetah is easy:

```
input_mel <- CHETAHclassifier(input = input_mel,
                              ref_cells = headneck_ref)
#> Preparing data....
#> Running analysis...
```

## 5.1 The output

CHETAH returns the input object, but added:

* input$celltype\_CHETAH
  + a named character vector that can directly be used in any other workflow/method.
* “hidden” `int_colData` and `int_metadata`, not meant for direct interaction, but
  + which can all be viewed and interacted with using: `PlotCHETAH` and `CHETAHshiny`

## 5.2 Standard plots

CHETAH’s classification can be visualized using: `PlotCHETAH`. This function plots both the classification tree and the t-SNE (or other provided reduced dimension) map.

To plot the **final types**:

```
PlotCHETAH(input = input_mel)
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the CHETAH package.
#>   Please report the issue at <https://github.com/jdekanter/CHETAH>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the dendextend package.
#>   Please report the issue at <https://github.com/talgalili/dendextend/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

Please note that each type “NodeX” corresponds to the node with number X and that the type “Unassigned” corresponds to the node 0

Conversely, to color the **intermediate types**:

```
PlotCHETAH(input = input_mel, interm = TRUE)
```

![](data:image/png;base64...)

If you would like to use the classification, and thus the colors, in another package (e.g. Seurat2), you can extract the colors using:

```
colors <- PlotCHETAH(input = input_mel, return_col = TRUE)
```

## 5.3 `CHETAHshiny`

The classification of CHETAH and other outputs like profile and confidence scores can be visualized in a shiny application that allows for easy and interactive analysis of the classification.

Here you can view:

* the confidence of all assignments
* the classification in an interactive window
* the genes used by CHETAH, an it’s expression in the input data
* a lot more

The following command will open the shiny application as in an R window. The page can also be opened in your default web-browser by clicking “Open in Browser” at the very top.

```
CHETAHshiny(input = input_mel)
```

# 6 Changing classification

## 6.1 Confidence score

CHETAH calculates a confidence score for each assignment of an input cell to one of the branches of a node.

* has a value between 0 and 2
* will normally lie between 0 and 1
* 0 represents no confidence for an assignment, 1 high confidence.

**The default confidence threshold of CHETAH is 0.1.**
This means that whenever a cell is assigned to a branch and the confidence of that assignment is lower than 0.1, the classification will stop in that node.

**The confidence threshold can be adjusted in order to classify more or fewer cells to a final type:**

* Using a confidence threshold of 0 will classify all input cells to a final type. Be aware that this classification can be noisy and can contain incorrect classifications.
* Using a threshold of 0.2, 0.3, 0.4, etc, will classify a decreasing number of cells to a final type, with the remaining cells having a increasingly high confidence throughout all nodes in the tree.

For example, to only classify cells with very high confidence:

```
input_mel <- Classify(input = input_mel, 0.8)
PlotCHETAH(input = input_mel, tree = FALSE)
```

![](data:image/png;base64...)

Conversely, to classify all cells:

```
input_mel <- Classify(input_mel, 0)
PlotCHETAH(input = input_mel, tree = FALSE)
```

![](data:image/png;base64...)

## 6.2 Renaming types

For renaming types in the tree, CHETAH comes with the `RenameBelowNode` function. This can be interesting when you are more interested in the general types, type in the different **intermediate** and **final types**.

For the example data, let’s say that we are not interested in all the different subtypes of T-cells (under Node6 and Node7), we can name all these cells “T cells” by running:

```
input_mel <- RenameBelowNode(input_mel, whichnode = 6, replacement = "T cell")
PlotCHETAH(input = input_mel, tree = FALSE)
```

![](data:image/png;base64...)

To reset the classification to its default, just run `Classify` again:

```
input_mel <- Classify(input_mel) ## the same as Classify(input_mel, 0.1)
PlotCHETAH(input = input_mel, tree = FALSE)
```

![](data:image/png;base64...)

# 7 Creating a reference

## 7.1 Step 0: Obtain a reference.

* Download or use one of your own scRNA-seq datasets, for which cell type labels are available.
  + A tumor micro-environment reference dataset containing all major cell types for tumor data can be downloaded [here](https://figshare.com/s/aaf026376912366f81b6)
* Make a `SingleCellExperiment` object, as explained [above](#sce)

## 7.2 Step 1: good reference characteristics

CHETAH can use any scRNA-seq reference, but the used reference greatly influences the classification.
The following general rules apply on choosing and creating a reference:

* Better results can be achieved by using a reference and an input dataset that are from the same biological type, or at least consist of cells that are in the same cell state. E.g. for an input dataset of PBMCs, a bone marrow reference dataset could be used, but as these cells are more naive or precursor cells, this might negatively influence the classification. In this case, another PBMC dataset would work optimally.
* The annotation of the reference directly influences the classification. The more accurate the cell type labels, the better the classification. Also, discard any cells that are doublets, contaminations, etc.
* The sparser the reference data, the more reference cells are needed to create a reliable reference. For high coverage Smart-Seq23 data, as little as 10-20 cells are needed per cell type. For sparser 10X Genomics data, 100+ cells normally gives optimal results.

To reduce computation time with very big references, first try to subsample each cell type to 100-200 cells. CHETAH should have very similar performance to using all cells. For a `SingleCellExperiment` “ref” with cell type metadata “celltypes”, this could be done by:

```
cell_selection <- unlist(lapply(unique(ref$celltypes), function(type) {
    type_cells <- which(ref$celltypes == type)
    if (length(type_cells) > 200) {
        type_cells[sample(length(type_cells), 200)]
    } else type_cells
}))
ref_new <- ref[ ,cell_selection]
```

## 7.3 Step 1: normalization

CHETAH does not require normalized input data, but **the reference data has to be normalized beforehand**. The reference data that is used in this vignette is already normalized. **Only for sake of the example**, we use this dataset anyway to perform nomalization:

```
assay(headneck_ref, "counts") <- apply(assay(headneck_ref, "counts"), 2, function(column) log2((column/sum(column) * 100000) + 1))
```

## 7.4 Step 2: discaring of house-keeping genes

Certainly with reference with relatively high drop-out rates, CHETAH can be influenced by highly expressed, and thus highly variable, genes. In our experience, mainly ribosomal protein genes can cause such an effect. We therefore delete these genes, using the “ribosomal” list from [here](https://figshare.com/s/aaf026376912366f81b6)

```
ribo <- read.table("~/ribosomal.txt", header = FALSE, sep = '\t')
headneck_ref <- headneck_ref[!rownames(headneck_ref) %in% ribo[,1], ]
```

## 7.5 Step 3: Reference QC

The performance of CHETAH is heavily dependent on the quality of the reference.
The quality of the reference is affected by:

1. the quality of the scRNA-seq data
2. the accuracy of the cell type labels

To see how well CHETAH can distinguish between the cell types in a reference,
`CorrelateReference` and more importantly `ClassifyReference` can be run.

### 7.5.1 CorrelateReference

`CorrelateReference` is a function that, for every combination of two cell types, finds the genes with the highest fold-change between the two and uses these to correlate them to each other. If the reference is good, all types will correlate poorly or even better, will anti-correlate.

```
CorrelateReference(ref_cells = headneck_ref)
#> Running... in case of 1000s of cells, this may take a couple of minutes
```

![](data:image/png;base64...)

In this case, most cell types will be distinguishable: many types don’t correlate, or anti-correlate. However, some types are quite similar. Regulatory and CD4 T cells, or CD4 and CD8 T cells, might be hard to distinguish in the input data.

### 7.5.2 ClassifyReference

Another check to see whether CHETAH can distinguish between the cell types in the reference is `ClassifyReference`. This function uses the reference to classify the reference itself. If CHETAH works well with the reference, there should be almost no mix-ups in the classification, i.e. all cells of type A should be classified to type A.

```
ClassifyReference(ref_cells = headneck_ref)
#> Preparing data....
#> Running analysis...
```

![In this plot, the rows are the original cell type labels, the columns the labels that were assigned during classification. The colors and sizes of the squares indicate which part of the cells of the row name type are classified to the column type. E.g. 4th row, 2th column shows that 5-10% of CD4 T cells are classified as regulatory T cells.](data:image/png;base64...)

In this plot, the rows are the original cell type labels, the columns the labels that were assigned during classification. The colors and sizes of the squares indicate which part of the cells of the row name type are classified to the column type. E.g. 4th row, 2th column shows that 5-10% of CD4 T cells are classified as regulatory T cells.

In this reference, there is never more than 10% mix-up between two cell types. In addition, a low percentage of cells is classified as an intermediate type. Most mix-ups occur between subtypes of T cells. In this case the user should be aware that these cell type labels have the highest chance to interchange.

# 8 Optimizing the classification

CHETAH is optimized to give good results in most analyses, but it can happen that a classification is imperfect. When CHETAH does not give the desired output (too little cells are classified, visually random classification, etc),
These are the following steps to take (in this order):

* Check if your reference is correctly created (see [above](#ref-prep). This is the most important step!
* If too little cells are classified, lower the Confidence threshold to 0.05 or 0.01
  + Beware of false positives! Always check if the result makes sense.
  + using `input[!(grepl("^RP", rownames(input))), ]` is an imperfect, but very quick way to do this.
* Try using a different number of genes for the classification (the `n_genes` parameter).
  + this defaults to 200, but sometimes 100 or (in sparse data) 500 can give better results
* Find another reference
* Try one of the other scRNA-seq classification methods available.
* Open an issue on [github](github.com/jdekanter/CHETAH). We might be able to help you further

1 Van Der Maaten and Hinton (2008). Visualizing high-dimensional data using t-sne. *J Mach Learn Res*. 9: 2579-2605. doi: 10.1007/s10479-011-0841-3.

```
sessionInfo()
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
#>  [1] CHETAH_1.26.0               SingleCellExperiment_1.32.0
#>  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              S4Vectors_0.48.0
#>  [9] BiocGenerics_0.56.0         generics_0.1.4
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] ggplot2_4.0.0               Matrix_1.7-4
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
#>  [4] htmlwidgets_1.6.4   corrplot_0.95       lattice_0.22-7
#>  [7] vctrs_0.6.5         tools_4.5.1         tibble_3.3.0
#> [10] pkgconfig_2.0.3     pheatmap_1.0.13     data.table_1.17.8
#> [13] RColorBrewer_1.1-3  S7_0.2.0            lifecycle_1.0.4
#> [16] stringr_1.5.2       compiler_4.5.1      farver_2.1.2
#> [19] httpuv_1.6.16       htmltools_0.5.8.1   sass_0.4.10
#> [22] lazyeval_0.2.2      yaml_2.3.10         plotly_4.11.0
#> [25] crayon_1.5.3        tidyr_1.3.1         pillar_1.11.1
#> [28] later_1.4.4         jquerylib_0.1.4     DelayedArray_0.36.0
#> [31] cachem_1.1.0        viridis_0.6.5       abind_1.4-8
#> [34] mime_0.13           tidyselect_1.2.1    digest_0.6.37
#> [37] stringi_1.8.7       reshape2_1.4.4      purrr_1.1.0
#> [40] dplyr_1.1.4         labeling_0.4.3      cowplot_1.2.0
#> [43] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
#> [46] SparseArray_1.10.0  magrittr_2.0.4      S4Arrays_1.10.0
#> [49] dichromat_2.0-0.1   withr_3.0.2         scales_1.4.0
#> [52] promises_1.4.0      httr_1.4.7          rmarkdown_2.30
#> [55] XVector_0.50.0      otel_0.2.0          gridExtra_2.3
#> [58] shiny_1.11.1        evaluate_1.0.5      knitr_1.50
#> [61] viridisLite_0.4.2   rlang_1.1.6         Rcpp_1.1.0
#> [64] dendextend_1.19.1   xtable_1.8-4        glue_1.8.0
#> [67] bioDist_1.82.0      jsonlite_2.0.0      plyr_1.8.9
#> [70] R6_2.6.1
```