# Comparing totalVI and OSCA book CITE-seq analyses

OSCA book authors and Vincent J. Carey, stvjc at channing.harvard.edu

#### October 30, 2025

# Contents

* [1 Overview](#overview)
* [2 Technical steps to facilitate comparison](#technical-steps-to-facilitate-comparison)
  + [2.1 Acquire software](#acquire-software)
  + [2.2 Obtain key data representations](#obtain-key-data-representations)
  + [2.3 Assemble a SingleCellExperiment with totalVI outputs](#assemble-a-singlecellexperiment-with-totalvi-outputs)
    - [2.3.1 Acquire cell identities and batch labels](#acquire-cell-identities-and-batch-labels)
    - [2.3.2 Acquire quantifications and latent space positions](#acquire-quantifications-and-latent-space-positions)
    - [2.3.3 Drop 5k data from all](#drop-5k-data-from-all)
    - [2.3.4 Label the rows of components](#label-the-rows-of-components)
    - [2.3.5 Find common cell ids](#find-common-cell-ids)
    - [2.3.6 Build the totalVI SingleCellExperiment](#build-the-totalvi-singlecellexperiment)
    - [2.3.7 Reduce the chapter 12 dataset to the cells held in common](#reduce-the-chapter-12-dataset-to-the-cells-held-in-common)
* [3 Key outputs of the chapter 12 analysis](#key-outputs-of-the-chapter-12-analysis)
  + [3.1 Clustering and projection based on the ADT quantifications](#clustering-and-projection-based-on-the-adt-quantifications)
  + [3.2 Cluster profiles based on averaging ADT quantities within clusters](#cluster-profiles-based-on-averaging-adt-quantities-within-clusters)
  + [3.3 Marker expression patterns in mRNA-based sub-clusters of ADT-based clusters](#marker-expression-patterns-in-mrna-based-sub-clusters-of-adt-based-clusters)
  + [3.4 Graduated relationships between mRNA and surface protein expression](#graduated-relationships-between-mrna-and-surface-protein-expression)
* [4 Analogs to the chapter 12 findings, based on totalVI quantifications](#analogs-to-the-chapter-12-findings-based-on-totalvi-quantifications)
  + [4.1 The Leiden clustering in UMAP projection](#the-leiden-clustering-in-umap-projection)
  + [4.2 Cluster profiles based on average ADT abundance, using denoised protein quantifications](#cluster-profiles-based-on-average-adt-abundance-using-denoised-protein-quantifications)
  + [4.3 Concordance in ADT-based clustering between OSCA and totalVI](#concordance-in-adt-based-clustering-between-osca-and-totalvi)
  + [4.4 Subcluster assessment for OSCA cluster “3”](#subcluster-assessment-for-osca-cluster-3)
  + [4.5 Graduated relationships between ADT and mRNA abundance as measured by totalVI](#graduated-relationships-between-adt-and-mrna-abundance-as-measured-by-totalvi)
* [5 Conclusions](#conclusions)
* [6 Session information](#session-information)

# 1 Overview

This vignette endeavors to put Bioconductor and scvi-tools
together to help understand how different data structures and methods
relevant to CITE-seq analysis contribute to interpretation
of CITE-seq exeperiments.

The scvi-tools tutorial (for version 0.20.0)
analyzes a pair of 10x PBMC CITE-seq experiments (5k and 10k cells).
Chapter 12 of the OSCA book analyzes only the 10k dataset.

# 2 Technical steps to facilitate comparison

The following subsections are essentially “code-only”. We
exhibit steps necessary to assemble a SingleCellExperiment
instance with the subset of the totalVI quantifications
produced for the cells from the “10k” dataset.

## 2.1 Acquire software

```
library(SingleCellExperiment)
library(scater)
library(scviR)
```

## 2.2 Obtain key data representations

```
ch12sce = getCh12Sce(clear_cache=FALSE)
ch12sce
```

```
## class: SingleCellExperiment
## dim: 33538 7472
## metadata(2): Samples se.averaged
## assays(2): counts logcounts
## rownames(33538): ENSG00000243485 ENSG00000237613 ... ENSG00000277475
##   ENSG00000268674
## rowData names(3): ID Symbol Type
## colnames(7472): AAACCCAAGATTGTGA-1 AAACCCACATCGGTTA-1 ...
##   TTTGTTGTCGAGTGAG-1 TTTGTTGTCGTTCAGA-1
## colData names(3): Sample Barcode sizeFactor
## reducedDimNames(0):
## mainExpName: Gene Expression
## altExpNames(1): Antibody Capture
```

```
options(timeout=3600)
fullvi = getTotalVI5k10kAdata()
fullvi
```

```
## AnnData object with n_obs × n_vars = 10849 × 4000
##     obs: 'n_genes', 'percent_mito', 'n_counts', 'batch', '_scvi_labels', '_scvi_batch', 'leiden_totalVI'
##     var: 'highly_variable', 'highly_variable_rank', 'means', 'variances', 'variances_norm', 'highly_variable_nbatches'
##     uns: '_scvi_manager_uuid', '_scvi_uuid', 'hvg', 'leiden', 'log1p', 'neighbors', 'umap'
##     obsm: 'X_totalVI', 'X_umap', 'denoised_protein', 'protein_expression', 'protein_foreground_prob'
##     layers: 'counts', 'denoised_rna'
##     obsp: 'connectivities', 'distances'
```

## 2.3 Assemble a SingleCellExperiment with totalVI outputs

### 2.3.1 Acquire cell identities and batch labels

```
totvi_cellids = rownames(fullvi$obs)
totvi_batch = fullvi$obs$batch
```

### 2.3.2 Acquire quantifications and latent space positions

```
totvi_latent = fullvi$obsm$get("X_totalVI")
totvi_umap = fullvi$obsm$get("X_umap")
totvi_denoised_rna = fullvi$layers$get("denoised_rna")
totvi_denoised_protein = fullvi$obsm$get("denoised_protein")
totvi_leiden = fullvi$obs$leiden_totalVI
```

### 2.3.3 Drop 5k data from all

```
is5k = which(totvi_batch == "PBMC5k")
totvi_cellids = totvi_cellids[-is5k]
totvi_latent = totvi_latent[-is5k,]
totvi_umap = totvi_umap[-is5k,]
totvi_denoised_rna = totvi_denoised_rna[-is5k,]
totvi_denoised_protein = totvi_denoised_protein[-is5k,]
totvi_leiden = totvi_leiden[-is5k]
```

### 2.3.4 Label the rows of components

```
rownames(totvi_latent) = totvi_cellids
rownames(totvi_umap) = totvi_cellids
rownames(totvi_denoised_rna) = totvi_cellids
rownames(totvi_denoised_protein) = totvi_cellids
names(totvi_leiden) = totvi_cellids
```

### 2.3.5 Find common cell ids

In this section we reduce the cell collections
to cells common to the chapter 12 and totalVI
datasets.

```
comm = intersect(totvi_cellids, ch12sce$Barcode)
```

### 2.3.6 Build the totalVI SingleCellExperiment

```
# select and order
totvi_latent = totvi_latent[comm,]
totvi_umap = totvi_umap[comm,]
totvi_denoised_rna = totvi_denoised_rna[comm,]
totvi_denoised_protein = totvi_denoised_protein[comm,]
totvi_leiden = totvi_leiden[comm]

# organize the totalVI into SCE with altExp

totsce = SingleCellExperiment(SimpleList(logcounts=t(totvi_denoised_rna))) # FALSE name
rowData(totsce) = S4Vectors::DataFrame(fullvi$var)
rownames(totsce) = rownames(fullvi$var)
rowData(totsce)$Symbol = rownames(totsce)
nn = SingleCellExperiment(SimpleList(logcounts=t(totvi_denoised_protein))) # FALSE name
reducedDims(nn) = list(UMAP=totvi_umap)
altExp(totsce) = nn
altExpNames(totsce) = "denoised_protein"
totsce$leiden = totvi_leiden
altExp(totsce)$leiden = totvi_leiden
altExp(totsce)$ch12.clusters = altExp(ch12sce[,comm])$label

# add average ADT abundance to metadata, for adt_profiles

tot.se.averaged <- sumCountsAcrossCells(altExp(totsce), altExp(totsce)$leiden,
    exprs_values="logcounts", average=TRUE)
rownames(tot.se.averaged) = gsub("_TotalSeqB", "", rownames(tot.se.averaged))
metadata(totsce)$se.averaged = tot.se.averaged
```

### 2.3.7 Reduce the chapter 12 dataset to the cells held in common

```
colnames(ch12sce) = ch12sce$Barcode
ch12sce_matched = ch12sce[, comm]
```

# 3 Key outputs of the chapter 12 analysis

## 3.1 Clustering and projection based on the ADT quantifications

The TSNE projection of the normalized ADT quantifications and
the [walktrap](https://arxiv.org/abs/physics/0512106) cluster assignments
are produced for the cells common to the two approaches.

```
plotTSNE(altExp(ch12sce_matched), color_by="label", text_by="label")
```

```
## Warning: Removed 1 row containing missing values or values outside the scale range
## (`geom_text_repel()`).
```

![](data:image/png;base64...)

## 3.2 Cluster profiles based on averaging ADT quantities within clusters

This heatmap uses precomputed cluster averages that are
lodged in the metadata element of the SingleCellExperiment.
Colors represent the log2-fold change from the grand average across all clusters.

```
adtProfiles(ch12sce_matched)
```

![](data:image/png;base64...)

## 3.3 Marker expression patterns in mRNA-based sub-clusters of ADT-based clusters

We enhance the annotation of the list of subclusters retrieved
using `getCh12AllSce` and then drill into mRNA-based
subclusters of ADT-based cluster 3 to compare expression levels
of three genes.

```
ch12_allsce = getCh12AllSce()
ch12_allsce = lapply(ch12_allsce, function(x) {
   colnames(x)= x$Barcode;
   cn = colnames(x);
   x = x[,intersect(cn,comm)]; x})
of.interest <- "3"
markers <- c("GZMH", "IL7R", "KLRB1")
plotExpression(ch12_allsce[[of.interest]], x="subcluster",
    features=markers, swap_rownames="Symbol", ncol=3)
```

![](data:image/png;base64...)

There is a suggestion of a boolean basis for subcluster
identity, depending on low or high expression of the selected genes.

## 3.4 Graduated relationships between mRNA and surface protein expression

Following the exploration in OSCA chapter 12, cluster 3 is analyzed
for a regression association between expression
measures of three genes and the ADT-based abundance of CD127.

```
plotExpression(ch12_allsce[["3"]], x="CD127", show_smooth=TRUE, show_se=FALSE,
    features=c("IL7R", "TPT1", "KLRB1", "GZMH"), swap_rownames="Symbol")
```

```
## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

![](data:image/png;base64...)

# 4 Analogs to the chapter 12 findings, based on totalVI quantifications

## 4.1 The Leiden clustering in UMAP projection

```
plotUMAP(altExp(totsce), color_by="leiden", text_by="leiden")
```

![](data:image/png;base64...)

## 4.2 Cluster profiles based on average ADT abundance, using denoised protein quantifications

The approach to profiling the ADT abundances used in the totalVI
tutorial employs scaling to (0,1).

```
tav = S4Vectors::metadata(totsce)$se.averaged
ata = assay(tav)
uscale = function(x) (x-min(x))/max(x)
scmat = t(apply(ata,1,uscale))
pheatmap::pheatmap(scmat, cluster_rows=FALSE)
```

![](data:image/png;base64...)

## 4.3 Concordance in ADT-based clustering between OSCA and totalVI

A quick view of the concordance of the two clustering outcomes
is

```
atot = altExp(totsce)
ach12 = altExp(ch12sce_matched)
tt = table(ch12=ach12$label, VI=atot$leiden)
pheatmap::pheatmap(log(tt+1))
```

![](data:image/png;base64...)

With this we can pick out some
clusters with many cells in common:

```
lit = tt[c("9", "12", "5", "3"), c("0", "1", "2", "8", "6", "5")]
rownames(lit) = sQuote(rownames(lit))
colnames(lit) = sQuote(colnames(lit))
lit
```

```
##       VI
## ch12    '0'  '1'  '2'  '8'  '6'  '5'
##   '9'  1334    0    0    0    0    0
##   '12'    0  993    0    0   15    0
##   '5'     0  102  671    8   44    2
##   '3'     0    0    5  322  297   67
```

## 4.4 Subcluster assessment for OSCA cluster “3”

Let’s examine the distributions of marker mRNAs in
the Leiden totalVI clusters corresponding to OSCA cluster “3”:

```
tsub = totsce[,which(altExp(totsce)$leiden %in% c("5", "6", "8"))]
markers <- c("GZMH", "IL7R", "KLRB1")
altExp(tsub)$leiden = factor(altExp(tsub)$leiden) # squelch unused levels
tsub$leiden = factor(tsub$leiden) # squelch unused levels
plotExpression(tsub, x="leiden",
    features=markers, swap_rownames="Symbol", ncol=3)
```

![](data:image/png;base64...)

Note that the y axis label is incorrect – we are plotting the denoised
expression values from totalVI.

The display seems roughly consistent with the “boolean basis” observed above with
the mRNA-based subclustering.

## 4.5 Graduated relationships between ADT and mRNA abundance as measured by totalVI

The same approach is taken as above. We don’t have TPT1 in the 4000 genes
retained in the totalVI exercise.

```
rn = rownames(altExp(tsub))
rn = gsub("_TotalSeqB", "", rn)
rownames(altExp(tsub)) = rn
rowData(altExp(tsub)) = DataFrame(Symbol=rn)
plotExpression(tsub, x="CD127", show_smooth=TRUE, show_se=FALSE,
   features=c("IL7R", "KLRB1", "GZMH"), swap_rownames="Symbol")
```

```
## `geom_smooth()` using method = 'gam' and formula = 'y ~ s(x, bs = "cs")'
```

![](data:image/png;base64...)

# 5 Conclusions

We have shown how rudimentary programming and data
organization can be used to make
outputs of OSCA and totalVI methods amenable to comparison
in the Bioconductor framework.

The scviR package includes a shiny app in the function
`explore_subcl` that should be expanded to facilitate
exploration of totalVI subclusters. Much more work
remains to be done in the area of exploring

* additional approaches to integrative interpretation of
  ADT and mRNA abundance patterns, such as intersection and
  concatenation methods in the feature selection materials
  in OSCA ch. 12
* effects of tuning and architecture details for the totalVI VAE

# 6 Session information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88803)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /media/volume/biocgpu2/biocbuild/bbs-3.22-bioc-gpu/R/lib/libRblas.so
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
##  [1] scviR_1.10.0                shiny_1.11.1
##  [3] basilisk_1.21.5             reticulate_1.44.0
##  [5] scater_1.37.0               ggplot2_4.0.0
##  [7] scuttle_1.19.0              SingleCellExperiment_1.31.1
##  [9] SummarizedExperiment_1.39.2 Biobase_2.69.1
## [11] GenomicRanges_1.61.8        Seqinfo_0.99.4
## [13] IRanges_2.43.8              S4Vectors_0.47.6
## [15] BiocGenerics_0.55.4         generics_0.1.4
## [17] MatrixGenerics_1.21.0       matrixStats_1.5.0
## [19] BiocStyle_2.37.1
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3            gridExtra_2.3        httr2_1.2.1
##  [4] rlang_1.1.6          magrittr_2.0.4       otel_0.2.0
##  [7] compiler_4.5.1       RSQLite_2.4.3        mgcv_1.9-3
## [10] dir.expiry_1.17.0    png_0.1-8            vctrs_0.6.5
## [13] pkgconfig_2.0.3      fastmap_1.2.0        dbplyr_2.5.1
## [16] XVector_0.49.3       labeling_0.4.3       promises_1.4.0
## [19] rmarkdown_2.30       ggbeeswarm_0.7.2     tinytex_0.57
## [22] purrr_1.1.0          bit_4.6.0            xfun_0.53
## [25] cachem_1.1.0         beachmat_2.25.5      jsonlite_2.0.0
## [28] blob_1.2.4           later_1.4.4          DelayedArray_0.35.4
## [31] BiocParallel_1.43.4  irlba_2.3.5.1        parallel_4.5.1
## [34] R6_2.6.1             bslib_0.9.0          RColorBrewer_1.1-3
## [37] limma_3.65.7         jquerylib_0.1.4      Rcpp_1.1.0
## [40] bookdown_0.45        knitr_1.50           splines_4.5.1
## [43] httpuv_1.6.16        Matrix_1.7-4         tidyselect_1.2.1
## [46] abind_1.4-8          yaml_2.3.10          viridis_0.6.5
## [49] codetools_0.2-20     curl_7.0.0           lattice_0.22-7
## [52] tibble_3.3.0         withr_3.0.2          S7_0.2.0
## [55] evaluate_1.0.5       BiocFileCache_2.99.6 pillar_1.11.1
## [58] BiocManager_1.30.26  filelock_1.0.3       rprojroot_2.1.1
## [61] scales_1.4.0         xtable_1.8-4         glue_1.8.0
## [64] pheatmap_1.0.13      tools_4.5.1          BiocNeighbors_2.3.1
## [67] ScaledMatrix_1.17.0  cowplot_1.2.0        grid_4.5.1
## [70] nlme_3.1-168         beeswarm_0.4.0       BiocSingular_1.25.1
## [73] vipor_0.4.7          cli_3.6.5            rsvd_1.0.5
## [76] rappdirs_0.3.3       S4Arrays_1.9.2       viridisLite_0.4.2
## [79] dplyr_1.1.4          gtable_0.3.6         sass_0.4.10
## [82] digest_0.6.37        SparseArray_1.9.1    ggrepel_0.9.6
## [85] farver_2.1.2         memoise_2.0.1        htmltools_0.5.8.1
## [88] lifecycle_1.0.4      here_1.0.2           statmod_1.5.1
## [91] mime_0.13            bit64_4.6.0-1
```