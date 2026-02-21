# Cepo for differential stability analysis of scRNA-seq data

Hani Jieun Kim1\*

1The University of Sydney

\*hani.kim127@gmail.com

#### 10/29/2025

# Contents

* [1 Introduction](#introduction)
  + [1.1 Package installation](#package-installation)
* [2 Differential stability analysis using Cepo](#differential-stability-analysis-using-cepo)
  + [2.1 Example data](#example-data)
  + [2.2 Run Cepo to generate list of cell identity genes](#run-cepo-to-generate-list-of-cell-identity-genes)
    - [2.2.1 Main arguments of Cepo](#main-arguments-of-cepo)
    - [2.2.2 Filtering](#filtering)
    - [2.2.3 Computing p-values](#computing-p-values)
  + [2.3 Visualizing results](#visualizing-results)
* [3 Running Cepo in a pipeline](#running-cepo-in-a-pipeline)
  + [3.1 Example data](#example-data-1)
  + [3.2 scMerge to remove batch effect](#scmerge-to-remove-batch-effect)
  + [3.3 Running Cepo by batch](#running-cepo-by-batch)
  + [3.4 Downstream analyses using Cepo genes](#downstream-analyses-using-cepo-genes)
    - [3.4.1 Marker gene identification and visualisation](#marker-gene-identification-and-visualisation)
    - [3.4.2 Gene set enrichment analysis](#gene-set-enrichment-analysis)
* [4 Running out-of-memory computation with Cepo](#running-out-of-memory-computation-with-cepo)
* [5 Session info](#session-info)

# 1 Introduction

We introduce *Cepo*, a method to determine genes governing cell identity from scRNA-seq data. We propose a biologically motivated metric—differential stability (DS)—to define cell identity. Our motivation is driven by the hypothesis that stable gene expression is a key component of cell identity. This hypothesis implies that genes marking a cell type should be (i) expressed and (ii) stable in its expression relative to other cell types. We translate these criteria into a computational framework where, using predefined cell-type labels, we compute a cell-type-specific score to prioritise genes that are differential stably expressed against other cell types between all cell-type pair comparisons.

*Cepo* is therefore distinct from most methods for differential analysis (e.g., differential expression) that prioritise differences in the mean abundance between cell types. *Cepo* is able to capture subtle variations in distribution that does not necessarily involve changes in mean. *Cepo* is particularly suitable for large atlas data as it is computationally efficient and fast. Moreover, *Cepo* can perform differential stability analysis for multi-group comparisons in single-cell data.

To access the R code used in the vignettes, type:

```
browseVignettes("Cepo")
```

Questions relating to *Cepo* should be reported as a new issue at *[BugReports](https://github.com/PYangLab/Cepo/issues)*.

To cite *Cepo*, type:

```
citation("Cepo")
```

## 1.1 Package installation

The development version of *Cepo* can be installed with the following command:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Cepo")
```

# 2 Differential stability analysis using Cepo

The differential stability analysis in *Cepo* aims to investigate differential stability patterns between cells of different cell types. To use *Cepo* one needs data with cell type labels (or cluster labels). If no cell-type labels are provided, cells first need to be clustered and classified in groups via some form of clustering algorithms. *Cepo* can then be applied to identify differentially stable genes between cell types.

## 2.1 Example data

Load the example dataset, a small and randomly sampled subset of the [Cellbench](https://github.com/LuyiTian/sc_mixology) dataset consisting of 3 cell types 895 cells and 894 genes.

```
library(Cepo)
library(SingleCellExperiment)
data("cellbench", package = "Cepo")
cellbench
```

```
## class: SingleCellExperiment
## dim: 894 895
## metadata(3): scPipe Biomart log.exprs.offset
## assays(2): counts logcounts
## rownames(894): AP000902.1 TNNI3 ... SCMH1 IGF2BP2
## rowData names(0):
## colnames(895): CELL_000001 CELL_000003 ... CELL_000955 CELL_000965
## colData names(17): unaligned aligned_unmapped ... sizeFactor celltype
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

```
cellbench = cellbench[!duplicated(rownames(cellbench)),]
```

Columns of the `colData` indicate the individual id and various metadata for each cell. `colData` contains `celltype` labels, which will be required to run *Cepo*. Differential stability analysis performed on the entire cell type repertoire.

```
colData(cellbench)[1:5,]
```

```
## DataFrame with 5 rows and 17 columns
##             unaligned aligned_unmapped mapped_to_exon mapped_to_intron
##             <integer>        <integer>      <integer>        <integer>
## CELL_000001    167234             8341         526950            40991
## CELL_000003    174510             8608         513021            42270
## CELL_000004    158346             7796         504676            39684
## CELL_000005    159070             6968         486645            38252
## CELL_000006    144914             8610         465126            33435
##             ambiguous_mapping mapped_to_ERCC mapped_to_MT number_of_genes
##                     <integer>      <integer>    <integer>       <numeric>
## CELL_000001             21392              0        22342           11237
## CELL_000003             20170              0        20943           11203
## CELL_000004             18628              0        14021           11237
## CELL_000005             20029              0        14100           10920
## CELL_000006             21732              0        11855           11157
##             total_count_per_cell non_mt_percent non_ribo_percent outliers
##                        <numeric>      <numeric>        <numeric> <factor>
## CELL_000001               266880       0.823985         0.797096    FALSE
## CELL_000003               251204       0.828956         0.801715    FALSE
## CELL_000004               250040       0.839618         0.816149    FALSE
## CELL_000005               244441       0.838746         0.798577    FALSE
## CELL_000006               235288       0.817904         0.788378    FALSE
##               cell_line cell_line_demuxlet demuxlet_cls sizeFactor    celltype
##             <character>        <character>  <character>  <numeric> <character>
## CELL_000001      HCC827             HCC827          SNG    2.15032      HCC827
## CELL_000003      HCC827             HCC827          SNG    2.00889      HCC827
## CELL_000004      HCC827             HCC827          SNG    2.06447      HCC827
## CELL_000005      HCC827             HCC827          SNG    1.92110      HCC827
## CELL_000006       H1975              H1975          SNG    1.92716       H1975
```

Note that, if cell-type labels are unknown, we would need to cluster cells into groups via some clustering algorithm. In the example dataset, we have 3 cell types, H1975, H2228 and HCC827, all of which are commonly used cell lines of lung adenocarcinomas.

```
unique(cellbench$celltype)
```

```
## [1] "HCC827" "H1975"  "H2228"
```

## 2.2 Run Cepo to generate list of cell identity genes

### 2.2.1 Main arguments of Cepo

There are two main arguments to *Cepo*:
1) `exprsMat` is the input data, which should be normalized data, such as counts per million (CPM) or log2-CPM (e.g., `logcounts` as created via `scater::logNormCounts`).
2) `cellTypes` receives as input a vector of cell-type labels. Note that the cell-type labels should be equal in length and ordered the same as the column names in `exprsMat`.

```
ds_res = Cepo(exprsMat = logcounts(cellbench),
              cellType = cellbench$celltype)
```

The `Cepo` function returns a list of two elements by default. The first element is a `DataFrame` of DS statistics. In this `DataFrame`, each column corresponds to the DS statistics for that celltype across all genes. A higher DS statistic value denotes a gene that is more prioritized as a differentially stable gene in that given cell type. In the output DataFrame, the columns correspond to each cell type and each row correspond to a gene.

```
ds_res
```

```
## $stats
## DataFrame with 889 rows and 3 columns
##                H1975     H2228    HCC827
##            <numeric> <numeric> <numeric>
## AC092447.7  0.852809 -0.450000 -0.402809
## CT45A3      0.834831 -0.408146 -0.426685
## AL049870.3  0.815309 -0.465169 -0.350140
## TDRD9       0.753652 -0.440871 -0.312781
## TNNI3       0.748876 -0.358848 -0.390028
## ...              ...       ...       ...
## STK24      -0.655478  0.369663  0.285815
## CPVL       -0.669382  0.136236  0.533146
## BBOX1-AS1  -0.674860  0.436657  0.238202
## COL4A2     -0.689747  0.397331  0.292416
## KCNK1      -0.700702  0.329916  0.370787
##
## $pvalues
## NULL
##
## attr(,"class")
## [1] "Cepo" "list"
```

### 2.2.2 Filtering

In many cases, it is beneficial to perform filtering of lowly expressed genes prior to differential analysis. The parameter `exprsPct` specifies the threshold for filtering of lowly expressed genes should be performed. By default, this is set of `NULL`. A value between 0 and 1 should be provided. Whilst there is no set rule to the threshold, we recommend a value between `0.05` and `0.07`, which will keep any genes that are expressed in 5-7% in at least one cell type, for microfluidic-based data.

```
ds_res_zprop = Cepo::Cepo(exprsMat = logcounts(cellbench),
                          cellTypes = cellbench$celltype,
                          exprsPct = 0.5)
```

The parameter `logfc` specifies minimum log fold-change in gene expression. A value of `0.2` will keep any genes that show at least `abs(0.2)` log fold change in gene expression in at least one cell type. By default, this value is `NULL`.

```
ds_res_logfc = Cepo(exprsMat = logcounts(cellbench),
                    cellTypes = cellbench$celltype,
                    logfc = 1)
```

`Cepo` outputs some useful stats, including the number of genes `nrow` and gene names `rownames`. By checking `nrow`, we can see that as expected with filtering the number of genes included in the `Cepo` run becomes fewer.

```
nrow(ds_res$stats)
```

```
## [1] 889
```

```
nrow(ds_res_zprop$stats)
```

```
## [1] 841
```

```
nrow(ds_res_logfc$stats)
```

```
## [1] 853
```

### 2.2.3 Computing p-values

There are two methods to compute p-values in `Cepo`. The fast approach uses normal approximation of the Cepo statistics to estimate the null distribution. As this only required 100-200 sample runs of Cepo, it is much quicker, and the default approach, than the second permutation approach.

The output of running the p-value computation is a `DataFrame` of p-values associated with the DS statistics. In this `DataFrame`, each column corresponds to the p-values associated with the DS statistics.

```
ds_res_pvalues = Cepo(exprsMat = logcounts(cellbench),
                      cellType = cellbench$celltype,
                      computePvalue = 200,
                      prefilter_pzero = 0.4)
```

```
## Prefiltering 235 genes....
```

We can visualise the correlation between the Cepo statistics and -log10 p-values.

```
idx = rownames(ds_res_pvalues$stats)

par(mfrow=c(1,3))
for (i in unique(cellbench$celltype)) {

  plot(rank(ds_res_pvalues$stats[[i]]),
       rank(-log10(ds_res_pvalues$pvalues[idx, i])),
       main = i,
       xlab = "rank Cepo statistics",
       ylab = "rank -log10 p-values")

}
```

![](data:image/png;base64...)

```
par(mfrow=c(1,1))
```

The permutation approach requires the users to set the `computePvalue` argument to a number of bootstrap runs required (we recommend this to be at least 10000). Each column of the `DataFrame` corresponds to the p-values associated with the DS statistics obtained through bootstrap on the cells.

```
ds_res_pvalues = Cepo(exprsMat = logcounts(cellbench),
                      cellType = cellbench$celltype,
                      # we use a low value for demonstration purposes
                      computePvalue = 100,
                      computeFastPvalue = FALSE)
ds_res_pvalues
```

```
## $stats
## DataFrame with 889 rows and 3 columns
##                H1975     H2228    HCC827
##            <numeric> <numeric> <numeric>
## AC092447.7  0.852809 -0.450000 -0.402809
## CT45A3      0.834831 -0.408146 -0.426685
## AL049870.3  0.815309 -0.465169 -0.350140
## TDRD9       0.753652 -0.440871 -0.312781
## TNNI3       0.748876 -0.358848 -0.390028
## ...              ...       ...       ...
## STK24      -0.655478  0.369663  0.285815
## CPVL       -0.669382  0.136236  0.533146
## BBOX1-AS1  -0.674860  0.436657  0.238202
## COL4A2     -0.689747  0.397331  0.292416
## KCNK1      -0.700702  0.329916  0.370787
##
## $pvalues
## DataFrame with 889 rows and 3 columns
##                H1975     H2228    HCC827
##            <numeric> <numeric> <numeric>
## AC092447.7         0         1         1
## CT45A3             0         1         1
## AL049870.3         0         1         1
## TDRD9              0         1         1
## TNNI3              0         1         1
## ...              ...       ...       ...
## STK24              1      0.00         0
## CPVL               1      0.01         0
## BBOX1-AS1          1      0.00         0
## COL4A2             1      0.00         0
## KCNK1              1      0.00         0
##
## attr(,"class")
## [1] "Cepo" "list"
```

## 2.3 Visualizing results

We can visualize the overlap of differential stability genes between cell types.

```
library(UpSetR)
res_name = topGenes(object = ds_res, n = 500)
upset(fromList(res_name), nsets = 3)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

Density plot of two genes from each cell type.

```
plotDensities(x = cellbench,
              cepoOutput = ds_res,
              nGenes = 2,
              assay = "logcounts",
              celltypeColumn = "celltype")
```

```
## AC092447.7, CT45A3, HLA-DRB6, AR, CASC9, AC011632.1 will be plotted
```

```
## Warning: The dot-dot notation (`..density..`) was deprecated in ggplot2 3.4.0.
## ℹ Please use `after_stat(density)` instead.
## ℹ The deprecated feature was likely used in the Cepo package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

We can also specify the genes to be plotted.

```
plotDensities(x = cellbench,
              cepoOutput = ds_res,
              genes = c("PLTP", "CPT1C", "MEG3", "SYCE1", "MICOS10P3", "HOXB7"),
              assay = "logcounts",
              celltypeColumn = "celltype")
```

![](data:image/png;base64...)

# 3 Running Cepo in a pipeline

## 3.1 Example data

We will load an example dataset, a small, randomly subsampled subset of the human pancreas datasets from the [scMerge paper](https://www.pnas.org/content/116/20/9775) consisting of 3 batches, 2 cell types, 528 cells, and 1358 genes.

```
data("sce_pancreas", package = "Cepo")
sce_pancreas
```

```
## class: SingleCellExperiment
## dim: 1403 528
## metadata(0):
## assays(1): counts
## rownames(1403): SCGN SCG5 ... IFITM3 ZFP36L1
## rowData names(0):
## colnames(528): human2_lib2.final_cell_0117 human1_lib3.final_cell_0318
##   ... 9th_C61_S25 9th_C84_S60
## colData names(2): batch cellTypes
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

Given the presences of batches, we will visualize the data for any batch effect. Clearly these is separation of the data points by batch.

```
library(scater)
```

```
## Loading required package: scuttle
```

```
## Loading required package: ggplot2
```

```
sce = sce_pancreas
sce = scater::logNormCounts(sce)
sce = scater::runPCA(sce)

scater::plotPCA(
  sce,
  colour_by = "cellTypes",
  shape_by = "batch")
```

![](data:image/png;base64...)

## 3.2 scMerge to remove batch effect

We can run the analysis on batch corrected data. For this, we can implement batch correction methods on the data suing batch correction methods such as scMerge.

```
library(scMerge)
data("segList", package = "scMerge")
head(segList$human$human_scSEG)
```

```
## [1] "AAR2"  "AATF"  "ABCF3" "ABHD2" "ABT1"  "ACAP2"
```

```
corrected <- scMerge(
  sce_combine = sce,
  ctl = segList$human$human_scSEG,
  kmeansK = c(2, 2),
  assay_name = "scMerge",
  cell_type = sce$cellTypes)
```

```
## Dimension of the replicates mapping matrix:
## [1] 528   2
```

```
## Step 2: Performing RUV normalisation. This will take minutes to hours.
```

```
## scMerge complete!
```

Let us visualise the corrected data.

```
corrected = runPCA(corrected,
                            exprs_values = "scMerge")

scater::plotPCA(
  corrected,
  colour_by = "cellTypes",
  shape_by = "batch")
```

![](data:image/png;base64...)

```
ds_res = Cepo::Cepo(exprsMat = assay(corrected, "scMerge"),
              cellType = corrected$cellTypes)
```

## 3.3 Running Cepo by batch

Rather than running *Cepo* on the corrected values, we can run the differential analysis independently on individual batches using the `block` argument. By default, the `block` argument is set to `NULL`, ignoring batch information. If batches are present and the data is not corrected for batch effect, ensure you run the analyses by block.

```
ds_res_batches = Cepo::Cepo(exprsMat = logcounts(sce),
                            cellTypes = sce$cellTypes,
                            block = sce$batch,
                            minCelltype = 2)
```

Note that the resulting output in a list of `Cepo` class objects where each slot denotes the individual results for the three batches, as well as the averaged results saved as `average`.

```
names(ds_res_batches)
```

```
## [1] "batch 1" "batch 4" "batch 5" "average"
```

We can confirm that the `Cepo` statistics from across batches demonstrate a strong correlation. The clustered correlation heatmap below shows that there is high correlation between the scores of the same cell type across batches.

```
idx = Reduce(intersect, lapply(ds_res_batches, function(x) names(x$stats[, 1])))

combinedRes = as.data.frame(do.call(cbind, lapply(ds_res_batches, function(x)
  x$stats[idx,]
)))

batches = rep(names(ds_res_batches), sapply(ds_res_batches, function(x) length(x$stats)))
cty = unlist(lapply(ds_res_batches, function(x) names(x$stats)), use.name = FALSE)
colnames(combinedRes) = gsub("[.]", "_", colnames(combinedRes))

annot = data.frame(
  batch = batches,
  celltype = cty
)
rownames(annot) = colnames(combinedRes)

pheatmap::pheatmap(cor(combinedRes),
                   annotation = annot)
```

![](data:image/png;base64...)

## 3.4 Downstream analyses using Cepo genes

### 3.4.1 Marker gene identification and visualisation

One of the useful applications of `Cepo` is to find marker genes or cell identity genes on clustered data. We can visualise the top three marker genes for beta and ductal cells on the PCA.

```
cepo_genes = Cepo::topGenes(ds_res_batches$average, n = 3)

markersPlot = lapply(cepo_genes, function(x) {
  pp = lapply(x, function(gene) {
  p = scater::plotPCA(
  corrected,
  colour_by = gene,
  shape_by = "cellTypes")
  return(p)
  })
  pp = patchwork::wrap_plots(pp, ncol = 3) + patchwork::plot_layout(guides = "auto")
  return(pp)
})
patchwork::wrap_plots(markersPlot, nrow = 2)
```

![](data:image/png;base64...)

### 3.4.2 Gene set enrichment analysis

We can also perform a plethora of downstream analyses, from gene set enrichment analyses to deconvolution of bulk RNA-seq, with the cell identity gene scores generated from the `Cepo` package. As an example, we will perform gene set enrichment analysis using the `fgsea` and `escape` package.

```
library(escape)
library(fgsea)
hallmarkList <- getGeneSets(species = "Homo sapiens",
                           library = "H")

fgseaRes <- fgsea(pathways = hallmarkList,
                  stats    = sort(ds_res_batches[4]$average$stats[,"beta"]),
                  minSize = 15,
                  maxSize = 500)
```

```
## Warning in preparePathwaysAndStats(pathways, stats, minSize, maxSize, gseaParam, : There are ties in the preranked stats (0.93% of the list).
## The order of those tied genes will be arbitrary, which may produce unexpected results.
```

```
enriched_beta <- -log10(fgseaRes[order(pval), "padj"][[1]])
names(enriched_beta) <- fgseaRes[order(pval), "pathway"][[1]]
```

Note the top 5 enriched pathways for `beta cells`.

```
enriched_beta[1:5]
```

```
##       HALLMARK-PANCREAS-BETA-CELLS   HALLMARK-TNFA-SIGNALING-VIA-NFKB
##                           9.409647                           6.900876
## HALLMARK-INTERFERON-GAMMA-RESPONSE           HALLMARK-APICAL-JUNCTION
##                           6.034075                           2.248760
##           HALLMARK-MITOTIC-SPINDLE
##                           2.248760
```

Finally, we can visualise the enrichment using the `plotEnrichment` function from the `fgsea` package.

```
plotEnrichment(hallmarkList[["HALLMARK-PANCREAS-BETA-CELLS"]],
               sort(ds_res_batches$average$stats[, "beta"])) + labs(title="HALLMARK-PANCREAS-BETA-CELLS")
```

![](data:image/png;base64...)

# 4 Running out-of-memory computation with Cepo

To facilitate analysis of high-throughput atlas data consisting of millions of cells, `Cepo` also enables out-of-memory and parallel computation.

The `Cepo` function naturally handles matrices under the `DelayedArray` wrapper. Briefly, `DelayedArray` is a wrapper around many matrix classes in `R`, including `matrix`, `sparseMatrix` and `HDF5Array`. The last of which allows for out-of-memory computation, which means the computation is done outside of RAM. This will inevitably slow down the computational speed, but the major gain in doing this is that we can perform computations on data much larger than what our RAM can store at once.

```
library(DelayedArray)
```

```
## Loading required package: Matrix
```

```
##
## Attaching package: 'Matrix'
```

```
## The following object is masked from 'package:S4Vectors':
##
##     expand
```

```
## Loading required package: S4Arrays
```

```
## Loading required package: abind
```

```
##
## Attaching package: 'S4Arrays'
```

```
## The following object is masked from 'package:abind':
##
##     abind
```

```
## The following object is masked from 'package:base':
##
##     rowsum
```

```
## Loading required package: SparseArray
```

```
##
## Attaching package: 'DelayedArray'
```

```
## The following objects are masked from 'package:base':
##
##     apply, scale, sweep
```

```
library(HDF5Array)
```

```
## Loading required package: h5mread
```

```
## Loading required package: rhdf5
```

```
##
## Attaching package: 'h5mread'
```

```
## The following object is masked from 'package:rhdf5':
##
##     h5ls
```

```
da_matrix = DelayedArray(realize(logcounts(cellbench), "HDF5Array"))
class(da_matrix)
```

```
## [1] "HDF5Matrix"
## attr(,"package")
## [1] "HDF5Array"
```

```
class(seed(da_matrix))
```

```
## [1] "HDF5ArraySeed"
## attr(,"package")
## [1] "HDF5Array"
```

```
da_output = Cepo(exprsMat = da_matrix, cellType = cellbench$celltype)
```

Even though out-of-memory computation is slow, one way that we can speed up the computation is through parallel processing. This requires some configurations of the `DelayedArray` package via the `setAutoBPPARAM` function. `BiocParallel` package uses the `MulticoreParam` parameter for Linux/Mac and `SnowParam` for Windows.

```
library(BiocParallel)

BPPARAM = if (.Platform$OS.type == "windows") {
  BiocParallel::SnowParam(workers = 2)
} else {
  BiocParallel::MulticoreParam(workers = 2)
}

DelayedArray::setAutoBPPARAM(BPPARAM = BPPARAM) ## Setting two cores for computation

da_output_parallel = Cepo(exprsMat = da_matrix, cellTypes = cellbench$celltype)

DelayedArray::setAutoBPPARAM(BPPARAM = SerialParam()) ## Revert back to only one core
```

# 5 Session info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] BiocParallel_1.44.0         HDF5Array_1.38.0
##  [3] h5mread_1.2.0               rhdf5_2.54.0
##  [5] DelayedArray_0.36.0         SparseArray_1.10.0
##  [7] S4Arrays_1.10.0             abind_1.4-8
##  [9] Matrix_1.7-4                fgsea_1.36.0
## [11] escape_2.6.0                scMerge_1.26.0
## [13] scater_1.38.0               ggplot2_4.0.0
## [15] scuttle_1.20.0              UpSetR_1.4.0
## [17] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [19] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [21] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [23] Cepo_1.16.0                 GSEABase_1.72.0
## [25] graph_1.88.0                annotate_1.88.0
## [27] XML_3.99-0.19               AnnotationDbi_1.72.0
## [29] IRanges_2.44.0              S4Vectors_0.48.0
## [31] Biobase_2.70.0              BiocGenerics_0.56.0
## [33] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1             batchelor_1.26.0
##   [3] bitops_1.0-9              tibble_3.3.0
##   [5] rpart_4.1.24              lifecycle_1.0.4
##   [7] edgeR_4.8.0               StanHeaders_2.32.10
##   [9] lattice_0.22-7            MASS_7.3-65
##  [11] ggdist_3.3.3              backports_1.5.0
##  [13] magrittr_2.0.4            limma_3.66.0
##  [15] Hmisc_5.2-4               sass_0.4.10
##  [17] rmarkdown_2.30            jquerylib_0.1.4
##  [19] yaml_2.3.10               metapod_1.18.0
##  [21] pkgbuild_1.4.8            cowplot_1.2.0
##  [23] DBI_1.2.3                 RColorBrewer_1.1-3
##  [25] ResidualMatrix_1.20.0     sfsmisc_1.1-22
##  [27] purrr_1.1.0               nnet_7.3-20
##  [29] ggrepel_0.9.6             inline_0.3.21
##  [31] densEstBayes_1.0-2.2      irlba_2.3.5.1
##  [33] pheatmap_1.0.13           dqrng_0.4.1
##  [35] cvTools_0.3.3             DelayedMatrixStats_1.32.0
##  [37] codetools_0.2-20          tidyselect_1.2.1
##  [39] farver_2.1.2              ScaledMatrix_1.18.0
##  [41] viridis_0.6.5             base64enc_0.1-3
##  [43] jsonlite_2.0.0            BiocNeighbors_2.4.0
##  [45] Formula_1.2-5             bbmle_1.0.25.1
##  [47] tools_4.5.1               startupmsg_1.0.0
##  [49] Rcpp_1.1.0                glue_1.8.0
##  [51] gridExtra_2.3             xfun_0.53
##  [53] mgcv_1.9-3                distributional_0.5.0
##  [55] dplyr_1.1.4               loo_2.8.0
##  [57] withr_3.0.2               numDeriv_2016.8-1.1
##  [59] BiocManager_1.30.26       fastmap_1.2.0
##  [61] bluster_1.20.0            rhdf5filters_1.22.0
##  [63] caTools_1.18.3            digest_0.6.37
##  [65] rsvd_1.0.5                R6_2.6.1
##  [67] colorspace_2.1-2          reldist_1.7-2
##  [69] gtools_3.9.5              dichromat_2.0-0.1
##  [71] RSQLite_2.4.3             data.table_1.17.8
##  [73] robustbase_0.99-6         httr_1.4.7
##  [75] htmlwidgets_1.6.4         pkgconfig_2.0.3
##  [77] gtable_0.3.6              blob_1.2.4
##  [79] S7_0.2.0                  XVector_0.50.0
##  [81] htmltools_0.5.8.1         bookdown_0.45
##  [83] ruv_0.9.7.1               scales_1.4.0
##  [85] png_0.1-8                 scran_1.38.0
##  [87] knitr_1.50                rstudioapi_0.17.1
##  [89] reshape2_1.4.4            checkmate_2.3.3
##  [91] nlme_3.1-168              curl_7.0.0
##  [93] bdsmatrix_1.3-7           M3Drop_1.36.0
##  [95] cachem_1.1.0              stringr_1.5.2
##  [97] KernSmooth_2.23-26        parallel_4.5.1
##  [99] vipor_0.4.7               foreign_0.8-90
## [101] proxyC_0.5.2              pillar_1.11.1
## [103] grid_4.5.1                vctrs_0.6.5
## [105] gplots_3.2.0              BiocSingular_1.26.0
## [107] beachmat_2.26.0           xtable_1.8-4
## [109] cluster_2.1.8.1           beeswarm_0.4.0
## [111] htmlTable_2.4.3           evaluate_1.0.5
## [113] locfit_1.5-9.12           mvtnorm_1.3-3
## [115] cli_3.6.5                 compiler_4.5.1
## [117] rlang_1.1.6               crayon_1.5.3
## [119] rstantools_2.5.0          labeling_0.4.3
## [121] plyr_1.8.9                ggbeeswarm_0.7.2
## [123] stringi_1.8.7             rstan_2.32.7
## [125] viridisLite_0.4.2         QuickJSR_1.8.1
## [127] Biostrings_2.78.0         V8_8.0.1
## [129] patchwork_1.3.2           sparseMatrixStats_1.22.0
## [131] bit64_4.6.0-1             Rhdf5lib_1.32.0
## [133] KEGGREST_1.50.0           statmod_1.5.1
## [135] igraph_2.2.1              memoise_2.0.1
## [137] RcppParallel_5.1.11-1     bslib_0.9.0
## [139] fastmatch_1.1-6           DEoptimR_1.1-4
## [141] bit_4.6.0                 distr_2.9.7
```