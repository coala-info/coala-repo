# Using scrapper to analyze single-cell data

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: January 4, 2025

#### Package

scrapper 1.4.0

# Contents

* [1 Overview](#overview)
* [2 Quick start](#quick-start)
* [3 Step-by-step](#step-by-step)
* [4 Dealing with multiple batches](#dealing-with-multiple-batches)
* [5 Handling multi-modal data](#handling-multi-modal-data)
* [6 Other useful functions](#other-useful-functions)
* [Session information](#session-information)

# 1 Overview

*[scrapper](https://bioconductor.org/packages/3.22/scrapper)* implements bindings to C++ code for analyzing single-cell data, mostly from the [**libscran**](https://github.com/libscran) libraries.
Each function performs an individual analysis step ranging from quality control to clustering and marker detection.
*[scrapper](https://bioconductor.org/packages/3.22/scrapper)* is mostly intended for other Bioconductor package developers to build more user-friendly end-to-end workflows.

# 2 Quick start

Let’s fetch a small single-cell RNA-seq dataset for demonstration purposes:

```
library(scRNAseq)
sce.z <- ZeiselBrainData()
sce.z
```

```
## class: SingleCellExperiment
## dim: 20006 3005
## metadata(0):
## assays(1): counts
## rownames(20006): Tspan12 Tshz1 ... mt-Rnr1 mt-Nd4l
## rowData names(1): featureType
## colnames(3005): 1772071015_C02 1772071017_G12 ... 1772066098_A12
##   1772058148_F03
## colData names(9): tissue group # ... level1class level2class
## reducedDimNames(0):
## mainExpName: gene
## altExpNames(2): repeat ERCC
```

We run it through the *[scrapper](https://bioconductor.org/packages/3.22/scrapper)* analysis pipeline:

```
# Finding the mitochondrial genes for QC purposes.
is.mito <- grepl("^mt-", rownames(sce.z))

# We can set the number of threads higher in real applications, but
# we want to avoid stressing out Bioconductor's build system.
nthreads <- 2

library(scrapper)
res <- analyze(
    sce.z,
    rna.subsets=list(mito=is.mito),
    num.threads=nthreads
)
```

Now we can have a look at some of the results.
For example, we can make a t-SNE plot:

```
tabulate(res$clusters)
```

```
##  [1] 304 201 510 192 212 229 202 169 193 177 235  34  79 137
```

```
plot(res$tsne[,1], res$tsne[,2], col=res$clusters)
```

![](data:image/png;base64...)

We can have a look at the markers defining each cluster:

```
# Top markers for each cluster, say, based on the median AUC:
top.markers <- lapply(res$rna.markers$auc, function(x) {
    head(rownames(x)[order(x$median, decreasing=TRUE)], 10)
})
head(top.markers)
```

```
## $`1`
##  [1] "Gad1"   "Gad2"   "Ndrg4"  "Stmn3"  "Tspyl4" "Scg5"   "Snap25" "Syp"
##  [9] "Slc6a1" "Atp1a3"
##
## $`2`
##  [1] "Stmn3"  "Calm1"  "Scg5"   "Chn1"   "Pcsk2"  "Snap25" "Calm2"  "Mdh1"
##  [9] "Mef2c"  "Nme1"
##
## $`3`
##  [1] "Stmn3"         "Chn1"          "Crym"          "3110035E14Rik"
##  [5] "Calm1"         "Neurod6"       "Calm2"         "Hpca"
##  [9] "Ppp3r1"        "Ppp3ca"
##
## $`4`
##  [1] "Ywhah"  "Syp"    "Ndrg4"  "Snap25" "Rab3a"  "Chn1"   "Vsnl1"  "Stmn3"
##  [9] "Rtn1"   "Pcsk2"
##
## $`5`
##  [1] "Ppp3ca"  "Atp1b1"  "Tspan13" "Rtn1"    "Hpca"    "Gria1"   "Nsg2"
##  [8] "Chn1"    "Syp"     "Wasf1"
##
## $`6`
##  [1] "Plp1"   "Mbp"    "Cnp"    "Mog"    "Mobp"   "Ugt8a"  "Cldn11" "Mal"
##  [9] "Sept4"  "Ermn"
```

```
# Aggregating all marker statistics for the first cluster
# (delta.mean is the same as the log-fold change in this case).
df1 <- reportGroupMarkerStatistics(res$rna.markers, 1)
df1 <- df1[order(df1$auc.median, decreasing=TRUE),]
head(df1[,c("mean", "detected", "auc.median", "delta.mean.median")])
```

```
##            mean  detected auc.median delta.mean.median
## Gad1   4.722606 0.9967105  0.9957528          4.531826
## Gad2   4.388107 0.9967105  0.9949948          4.256521
## Ndrg4  4.336871 0.9967105  0.9875505          3.697457
## Stmn3  4.676829 0.9934211  0.9860738          4.202509
## Tspyl4 3.316202 1.0000000  0.9776043          2.293416
## Scg5   4.738719 1.0000000  0.9759803          3.036928
```

Finally, we can convert the results into a `SingleCellExperiment` for interoperability with other Bioconductor packages like *[scater](https://bioconductor.org/packages/3.22/scater)*:

```
sce <- convertAnalyzeResults(res)
sce
```

```
## class: SingleCellExperiment
## dim: 20006 2874
## metadata(0):
## assays(2): filtered normalized
## rownames(20006): Tspan12 Tshz1 ... mt-Rnr1 mt-Nd4l
## rowData names(5): means variances fitted residuals is.highly.variable
## colnames(2874): 1772071015_C02 1772071017_G12 ... 1772063068_D01
##   1772066098_A12
## colData names(5): sum detected subsets.mito sizeFactor clusters
## reducedDimNames(3): pca tsne umap
## mainExpName: rna
## altExpNames(0):
```

# 3 Step-by-step

The `analyze()` function just calls a series of lower-level functions in *[scrapper](https://bioconductor.org/packages/3.22/scrapper)*.
First, some quality control:

```
counts <- assay(sce.z)
rna.qc.metrics <- computeRnaQcMetrics(counts, subsets=list(mt=is.mito), num.threads=nthreads)
rna.qc.thresholds <- suggestRnaQcThresholds(rna.qc.metrics)
rna.qc.filter <- filterRnaQcMetrics(rna.qc.thresholds, rna.qc.metrics)
filtered <- counts[,rna.qc.filter,drop=FALSE]
```

Then normalization:

```
size.factors <- centerSizeFactors(rna.qc.metrics$sum[rna.qc.filter])
normalized <- normalizeCounts(filtered, size.factors)
```

Feature selection and PCA:

```
gene.var <- modelGeneVariances(normalized, num.threads=nthreads)
top.hvgs <- chooseHighlyVariableGenes(gene.var$statistics$residuals)
pca <- runPca(normalized[top.hvgs,], num.threads=nthreads)
```

Some visualization and clustering:

```
umap.out <- runUmap(pca$components, num.threads=nthreads)
tsne.out <- runTsne(pca$components, num.threads=nthreads)
snn.graph <- buildSnnGraph(pca$components, num.threads=nthreads)
clust.out <- clusterGraph(snn.graph)
```

And finally marker detection:

```
markers <- scoreMarkers(normalized, groups=clust.out$membership, num.threads=nthreads)
```

Readers are referred to the [OSCA book](https://bioconductor.org/books/release/OSCA/) for more details on the theory behind each step.

# 4 Dealing with multiple batches

Let’s fetch another brain dataset and combine it with the previous one.

```
sce.t <- TasicBrainData()
common <- intersect(rownames(sce.z), rownames(sce.t))
combined <- cbind(assay(sce.t)[common,], assay(sce.z)[common,])
block <- rep(c("tasic", "zeisel"), c(ncol(sce.t), ncol(sce.z)))
```

We call `analyze()` with `block=` to account for the batch structure.
This ensures that the various calculations are not affected by inter-block differences.
It also uses MNN correction to batch effects in the low-dimensional space prior to further analyses.

```
# No mitochondrial genes in the combined set, so we'll just skip it.
blocked_res <- analyze(combined, block=block, num.threads=nthreads)

# Visually check whether the datasets were suitably merged together.
# Note that these two datasets don't have the same cell types, so
# complete overlap should not be expected.
plot(blocked_res$tsne[,1], blocked_res$tsne[,2], pch=16, col=factor(blocked_res$block))
```

![](data:image/png;base64...)

Again, we can see how to do this step by step.

```
library(scrapper)
rna.qc.metrics <- computeRnaQcMetrics(combined, subsets=list(), num.threads=nthreads)
rna.qc.thresholds <- suggestRnaQcThresholds(rna.qc.metrics, block=block)
rna.qc.filter <- filterRnaQcMetrics(rna.qc.thresholds, rna.qc.metrics, block=block)

filtered <- combined[,rna.qc.filter,drop=FALSE]
filtered.block <- block[rna.qc.filter]
size.factors <- centerSizeFactors(rna.qc.metrics$sum[rna.qc.filter], block=filtered.block)
normalized <- normalizeCounts(filtered, size.factors)

gene.var <- modelGeneVariances(normalized, num.threads=nthreads, block=filtered.block)
top.hvgs <- chooseHighlyVariableGenes(gene.var$statistics$residuals)
pca <- runPca(normalized[top.hvgs,], num.threads=nthreads, block=filtered.block)

# Now we do a MNN correction to get rid of the batch effect.
corrected <- correctMnn(pca$components, block=filtered.block, num.threads=nthreads)

umap.out <- runUmap(corrected$corrected, num.threads=nthreads)
tsne.out <- runTsne(corrected$corrected, num.threads=nthreads)
snn.graph <- buildSnnGraph(corrected$corrected, num.threads=nthreads)
clust.out <- clusterGraph(snn.graph)

markers <- scoreMarkers(normalized, groups=clust.out$membership, block=filtered.block, num.threads=nthreads)
```

We can also compute pseudo-bulk profiles for each cluster-dataset combination, e.g., for differential expression analyses.

```
aggregates <- aggregateAcrossCells(filtered, list(cluster=clust.out$membership, dataset=filtered.block))
```

# 5 Handling multi-modal data

Let’s fetch a single-cell dataset with both RNA-seq and CITE-seq data.
To keep the run-time short, we’ll only consider the first 5000 cells.

```
sce.s <- StoeckiusHashingData(mode=c("human", "adt1", "adt2"))
sce.s <- sce.s[,1:5000]
sce.s
```

```
## class: SingleCellExperiment
## dim: 27679 5000
## metadata(0):
## assays(1): counts
## rownames(27679): A1BG A1BG-AS1 ... hsa-mir-8072 snoU2-30
## rowData names(0):
## colnames(5000): TGCCAAATCTCTAAGG ACTGCTCAGGTGTTAA ... CGCTATCGTCCGTCAG
##   GGCGACTGTAAGGGAA
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(2): adt1 adt2
```

We extract the counts for both the RNA and the ADTs.

```
rna.counts <- assay(sce.s)
adt.counts <- rbind(assay(altExp(sce.s, "adt1")), assay(altExp(sce.s, "adt2")))
```

We pass both matrices to `analyze()`, which will proceess each modality separately before combining them for steps like clustering and visualization.

```
is.mito <- grepl("^MT-", rownames(rna.counts))
is.igg <- grepl("^IgG", rownames(adt.counts))
multi_res <- analyze(
    rna.counts,
    adt.x=adt.counts,
    rna.subsets=list(mito=is.mito),
    adt.subsets=list(igg=is.igg),
    num.threads=nthreads
)
```

Under the hood, the analysis looks like this:

```
# QC in both modalities, only keeping the cells that pass in both.
library(scrapper)
rna.qc.metrics <- computeRnaQcMetrics(rna.counts, subsets=list(MT=is.mito), num.threads=nthreads)
rna.qc.thresholds <- suggestRnaQcThresholds(rna.qc.metrics)
rna.qc.filter <- filterRnaQcMetrics(rna.qc.thresholds, rna.qc.metrics)

adt.qc.metrics <- computeAdtQcMetrics(adt.counts, subsets=list(IgG=is.igg), num.threads=nthreads)
adt.qc.thresholds <- suggestAdtQcThresholds(adt.qc.metrics)
adt.qc.filter <- filterAdtQcMetrics(adt.qc.thresholds, adt.qc.metrics)

keep <- rna.qc.filter & adt.qc.filter
rna.filtered <- rna.counts[,keep,drop=FALSE]
adt.filtered <- adt.counts[,keep,drop=FALSE]

rna.size.factors <- centerSizeFactors(rna.qc.metrics$sum[keep])
rna.normalized <- normalizeCounts(rna.filtered, rna.size.factors)

adt.size.factors <- computeClrm1Factors(adt.filtered, num.threads=nthreads)
adt.size.factors <- centerSizeFactors(adt.size.factors)
adt.normalized <- normalizeCounts(adt.filtered, adt.size.factors)

gene.var <- modelGeneVariances(rna.normalized, num.threads=nthreads)
top.hvgs <- chooseHighlyVariableGenes(gene.var$statistics$residuals)
rna.pca <- runPca(rna.normalized[top.hvgs,], num.threads=nthreads)

# Combining the RNA-derived PCs with ADT expression. Here, there's very few ADT
# tags so there's no need for further dimensionality reduction.
combined <- scaleByNeighbors(list(rna.pca$components, as.matrix(adt.normalized)), num.threads=nthreads)

umap.out <- runUmap(combined$combined, num.threads=nthreads)
tsne.out <- runTsne(combined$combined, num.threads=nthreads)
snn.graph <- buildSnnGraph(combined$combined, num.threads=nthreads)
clust.out <- clusterGraph(snn.graph)

rna.markers <- scoreMarkers(rna.normalized, groups=clust.out$membership, num.threads=nthreads)
adt.markers <- scoreMarkers(adt.normalized, groups=clust.out$membership, num.threads=nthreads)
```

# 6 Other useful functions

The `runAllNeighborSteps()` will run `runUmap()`, `runTsne()`, `buildSnnGraph()` and `clusterGraph()` in a single call.
This runs the UMAP/t-SNE iterations and the clustering in parallel to maximize use of multiple threads.

The `scoreGeneSet()` function will compute a gene set score based on the input expression matrix.
This can be used to summarize the activity of pathways into a single per-cell score for visualization.

The `subsampleByNeighbors()` function will deterministically select a representative subset of cells based on their local neighborhood.
This can be used to reduce the compute time of the various steps downstream of the PCA.

For CRISPR data, quality control can be performed using `computeCrisprQcMetrics()`, `suggestCrisprQcThresholds()` and `filterCrisprQcMetrics()`.
To normalize, we use size factors defined by centering the total sum of guide counts for each cell.
The resulting matrix can then be directly used in `scaleByNeighbors()`.

# Session information

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
##  [1] scrapper_1.4.0              scRNAseq_2.23.1
##  [3] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           knitr_1.50
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                bitops_1.0-9             httr2_1.2.1
##  [4] rlang_1.1.6              magrittr_2.0.4           gypsum_1.6.0
##  [7] compiler_4.5.1           RSQLite_2.4.3            GenomicFeatures_1.62.0
## [10] png_0.1-8                vctrs_0.6.5              ProtGenerics_1.42.0
## [13] pkgconfig_2.0.3          crayon_1.5.3             fastmap_1.2.0
## [16] magick_2.9.0             dbplyr_2.5.1             XVector_0.50.0
## [19] Rsamtools_2.26.0         rmarkdown_2.30           UCSC.utils_1.6.0
## [22] purrr_1.1.0              tinytex_0.57             bit_4.6.0
## [25] xfun_0.53                cachem_1.1.0             beachmat_2.26.0
## [28] cigarillo_1.0.0          GenomeInfoDb_1.46.0      jsonlite_2.0.0
## [31] blob_1.2.4               rhdf5filters_1.22.0      DelayedArray_0.36.0
## [34] Rhdf5lib_1.32.0          BiocParallel_1.44.0      parallel_4.5.1
## [37] R6_2.6.1                 bslib_0.9.0              rtracklayer_1.70.0
## [40] jquerylib_0.1.4          Rcpp_1.1.0               bookdown_0.45
## [43] Matrix_1.7-4             tidyselect_1.2.1         abind_1.4-8
## [46] yaml_2.3.10              codetools_0.2-20         curl_7.0.0
## [49] lattice_0.22-7           alabaster.sce_1.10.0     tibble_3.3.0
## [52] withr_3.0.2              KEGGREST_1.50.0          evaluate_1.0.5
## [55] BiocFileCache_3.0.0      alabaster.schemas_1.10.0 ExperimentHub_3.0.0
## [58] Biostrings_2.78.0        pillar_1.11.1            BiocManager_1.30.26
## [61] filelock_1.0.3           RCurl_1.98-1.17          BiocVersion_3.22.0
## [64] ensembldb_2.34.0         alabaster.base_1.10.0    glue_1.8.0
## [67] alabaster.ranges_1.10.0  alabaster.matrix_1.10.0  lazyeval_0.2.2
## [70] tools_4.5.1              AnnotationHub_4.0.0      BiocIO_1.20.0
## [73] BiocNeighbors_2.4.0      GenomicAlignments_1.46.0 XML_3.99-0.19
## [76] rhdf5_2.54.0             grid_4.5.1               AnnotationDbi_1.72.0
## [79] HDF5Array_1.38.0         restfulr_0.0.16          cli_3.6.5
## [82] rappdirs_0.3.3           S4Arrays_1.10.0          dplyr_1.1.4
## [85] AnnotationFilter_1.34.0  alabaster.se_1.10.0      sass_0.4.10
## [88] digest_0.6.37            SparseArray_1.10.0       rjson_0.2.23
## [91] memoise_2.0.1            htmltools_0.5.8.1        lifecycle_1.0.4
## [94] h5mread_1.2.0            httr_1.4.7               bit64_4.6.0-1
```