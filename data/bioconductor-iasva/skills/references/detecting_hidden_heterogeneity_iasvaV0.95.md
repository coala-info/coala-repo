# Detecting hidden heterogeneity in single cell RNA-Seq data

#### Donghyung Lee

#### May 10th, 2018

The iasva package can be used to detect hidden heterogenity within bulk or single cell sequencing data. To illustrate how to use the iasva package for heterogenity detection, we use real-world single cell RNA sequencing (scRNA-Seq) data obtained from human pancreatic islet samples ([Lawlor et. al., 2016](http://genome.cshlp.org/content/early/2017/01/16/gr.212720.116)).

## Load packages

```
library(irlba)
library(iasva)
library(sva)
library(Rtsne)
library(pheatmap)
library(corrplot)
library(DescTools)
library(RColorBrewer)
library(SummarizedExperiment)
set.seed(100)
color.vec <- brewer.pal(3, "Set1")
```

## Load the islet single cell RNA-Seq data

To illustrate how IA-SVA can be used to detect hidden heterogeneity within a homogenous cell population (i.e., alpha cells), we use read counts of alpha cells from healthy (non-diabetic) subjects (n = 101).

```
counts_file <- system.file("extdata", "iasva_counts_test.Rds",
                         package = "iasva")
# matrix of read counts where genes are rows, samples are columns
counts <- readRDS(counts_file)
# matrix of sample annotations/metadata
anns_file <- system.file("extdata", "iasva_anns_test.Rds",
                         package = "iasva")
anns <- readRDS(anns_file)
```

## Calculate geometric library size, i.e., library size of log-transfromed read counts.

It is well known that the geometric library size (i.e., library size of log-transfromed read counts) or proportion of expressed genes in each cell explains a very large portion of variability of scRNA-Seq data ([Hicks et. al. 2015 BioRxiv](http://biorxiv.org/content/early/2015/08/25/025528), [McDavid et. al. 2016 Nature Biotechnology](http://www.nature.com/nbt/journal/v34/n6/full/nbt.3498.html)). Frequently, the first principal component of log-transformed scRNA-Seq read counts is highly correlated with the geometric library size (r ~ 0.9). Here, we calculate the geometric library size vector, which will be used as a known factor in the IA-SVA algorithm.

```
geo_lib_size <- colSums(log(counts + 1))
barplot(geo_lib_size, xlab = "Cell", ylab = "Geometric Lib Size", las = 2)
```

![](data:image/png;base64...)

```
lcounts <- log(counts + 1)

# PC1 and Geometric library size correlation
pc1 <- irlba(lcounts - rowMeans(lcounts), 1)$v[, 1]
cor(geo_lib_size, pc1)
```

```
## [1] -0.99716
```

## Run IA-SVA

Here, we run IA-SVA using patient\_id and geo\_lib\_size as known factors and identify five hidden factors. SVs are plotted in a pairwise fashion to uncover which SVs can seperate cell types.

```
set.seed(100)
patient_id <- anns$Patient_ID
mod <- model.matrix(~patient_id + geo_lib_size)
# create a summarizedexperiment class
summ_exp <- SummarizedExperiment(assays = counts)
iasva.res<- iasva(summ_exp, mod[, -1],verbose = FALSE,
                  permute = FALSE, num.sv = 5)
```

```
## IA-SVA running...
```

```
##
## SV 1 Detected!
```

```
##
## SV 2 Detected!
```

```
##
## SV 3 Detected!
```

```
##
## SV 4 Detected!
```

```
##
## SV 5 Detected!
```

```
##
## # of significant surrogate variables: 5
```

```
iasva.sv <- iasva.res$sv
plot(iasva.sv[, 1], iasva.sv[, 2], xlab = "SV1", ylab = "SV2")
```

![](data:image/png;base64...)

```
cell_type <- as.factor(iasva.sv[, 1] > -0.1)
levels(cell_type) <- c("Cell1", "Cell2")
table(cell_type)
```

```
## cell_type
## Cell1 Cell2
##     6    95
```

```
# We identified 6 outlier cells based on SV1 that are marked in red
pairs(iasva.sv, main = "IA-SVA", pch = 21, col = color.vec[cell_type],
      bg = color.vec[cell_type], oma = c(4,4,6,12))
legend("right", levels(cell_type), fill = color.vec, bty = "n")
```

![](data:image/png;base64...)

```
plot(iasva.sv[, 1:2], main = "IA-SVA", pch = 21, xlab = "SV1", ylab = "SV2",
     col = color.vec[cell_type], bg = color.vec[cell_type])
```

![](data:image/png;base64...)

```
cor(geo_lib_size, iasva.sv[, 1])
```

```
## [1] -0.1469422
```

```
corrplot(cor(iasva.sv))
```

![](data:image/png;base64...)

As shown in the above figure, SV1 clearly separates alpha cells into two groups: 6 outlier cells (marked in red) and the rest of the alpha cells (marked in blue). ## Find marker genes for the detected heterogeneity (SV1). Here, using the find\_markers() function we find marker genes that are significantly associated with SV1 (multiple testing adjusted p-value < 0.05, default significance cutoff, and R-squared value > 0.3, default R-squared cutoff).

```
marker.counts <- find_markers(summ_exp, as.matrix(iasva.sv[,1]))
```

```
## # of markers (): 33
```

```
## total # of unique markers: 33
```

```
nrow(marker.counts)
```

```
## [1] 33
```

```
rownames(marker.counts)
```

```
##  [1] "PMEPA1"   "FAM198B"  "FLT1"     "ENG"      "SOX4"     "ITGA5"
##  [7] "PXDN"     "PRDM1"    "ERG"      "CLIC4"    "A2M"      "PPAP2B"
## [13] "THBS1"    "CLIC2"    "S100A16"  "STC1"     "ACVRL1"   "COL4A1"
## [19] "MSN"      "TNFAIP2"  "MMP2"     "SERPINE1" "SPARC"    "SPARCL1"
## [25] "ESAM"     "KDR"      "CD9"      "CXCR4"    "PODXL"    "PLVAP"
## [31] "CALD1"    "MMP1"     "ADAMTS4"
```

```
anno.col <- data.frame(cell_type = cell_type)
rownames(anno.col) <- colnames(marker.counts)
head(anno.col)
```

```
##             cell_type
## 4th-C63_S30     Cell2
## 4th-C66_S36     Cell2
## 4th-C18_S31     Cell2
## 4th-C57_S18     Cell1
## 4th-C56_S17     Cell2
## 4th-C68_S41     Cell2
```

```
pheatmap(log(marker.counts + 1), show_colnames = FALSE,
         clustering_method = "ward.D2", cutree_cols = 2,
         annotation_col = anno.col)
```

![](data:image/png;base64...)

## Run tSNE to detect the hidden heterogeneity.

For comparison purposes, we applied tSNE on read counts of all genes to identify the hidden heterogeneity. We used the Rtsne R package with default settings.

```
set.seed(100)
tsne.res <- Rtsne(t(lcounts), dims = 2)

plot(tsne.res$Y, main = "tSNE", xlab = "tSNE Dim1", ylab = "tSNE Dim2",
     pch = 21, col = color.vec[cell_type], bg = color.vec[cell_type],
     oma = c(4, 4, 6, 12))
legend("bottomright", levels(cell_type), fill = color.vec, bty = "n")
```

![](data:image/png;base64...)

As shown above, tSNE fails to detect the outlier cells that are identified by IA-SVA when all genes are used. Same color coding is used as above.

## Run tSNE post IA-SVA analyses, i.e., run tSNE on marker genes associated with SV1 as detected by IA-SVA.

Here, we apply tSNE on the marker genes for SV1 obtained from IA-SVA

```
set.seed(100)
tsne.res <- Rtsne(unique(t(log(marker.counts + 1))), dims = 2)
plot(tsne.res$Y, main = "tSNE post IA-SVA", xlab = "tSNE Dim1",
     ylab = "tSNE Dim2", pch = 21, col = color.vec[cell_type],
     bg = color.vec[cell_type], oma = c(4, 4, 6, 12))
legend("bottomright", levels(cell_type), fill = color.vec, bty = "n")
```

![](data:image/png;base64...)

tSNE using SV1 marker genes better seperate these ourlier cells. This analyses suggest that gene selection using IA-SVA combined with tSNE analyses can be a powerful way to detect rare cells introducing variability in the single cell gene expression data.

## Using a faster implementation of IA-SVA (fast\_iasva)

Here, we run a faster implementation of IA-SVA using the same known factors (patient\_id and geo\_lib\_size) as demonstrated above. This function is useful when working with particularly large datasets.

```
iasva.res <- fast_iasva(summ_exp, mod[, -1], num.sv = 5)
```

```
## fast IA-SVA running...
```

```
##
## SV 1 Detected!
```

```
##
## SV 2 Detected!
```

```
##
## SV 3 Detected!
```

```
##
## SV 4 Detected!
```

```
##
## SV 5 Detected!
```

```
##
## # of obtained surrogate variables: 5
```

## Tuning parameters for IA-SVA

The R-squared thresholds used to identify marker genes (find\_markers) can greatly influence the 1) number of marker genes identified and 2) the quality of clustering results. With the study\_R2() function, users can visualize how different R-squared thresholds influence both factors.

```
study_res <- study_R2(summ_exp, iasva.sv)
```

```
## # of markers (): 274
```

```
## total # of unique markers: 274
```

```
## # of markers (): 177
```

```
## total # of unique markers: 177
```

```
## # of markers (): 123
```

```
## total # of unique markers: 123
```

```
## # of markers (): 84
```

```
## total # of unique markers: 84
```

```
## # of markers (): 54
```

```
## total # of unique markers: 54
```

```
## # of markers (): 39
```

```
## total # of unique markers: 39
```

```
## # of markers (): 30
```

```
## total # of unique markers: 30
```

```
## # of markers (): 23
```

```
## total # of unique markers: 23
```

```
## # of markers (): 7
```

```
## total # of unique markers: 7
```

```
## # of markers (): 3
```

```
## total # of unique markers: 3
```

```
## # of markers (): 0
```

```
## total # of unique markers: 0
```

![](data:image/png;base64...) This function produces a plot of the number of genes selected vs. the cluster quality (average silhouette score) for different R-squared values.

## Session Info

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
##  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [5] IRanges_2.44.0              S4Vectors_0.48.0
##  [7] BiocGenerics_0.56.0         generics_0.1.4
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] RColorBrewer_1.1-3          DescTools_0.99.60
## [13] corrplot_0.95               pheatmap_1.0.13
## [15] Rtsne_0.17                  sva_3.58.0
## [17] BiocParallel_1.44.0         genefilter_1.92.0
## [19] mgcv_1.9-3                  nlme_3.1-168
## [21] iasva_1.28.0                irlba_2.3.5.1
## [23] Matrix_1.7-4
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3            gld_2.6.8            readxl_1.4.5
##  [4] rlang_1.1.6          magrittr_2.0.4       e1071_1.7-16
##  [7] compiler_4.5.1       RSQLite_2.4.3        png_0.1-8
## [10] vctrs_0.6.5          pkgconfig_2.0.3      crayon_1.5.3
## [13] fastmap_1.2.0        XVector_0.50.0       rmarkdown_2.30
## [16] tzdb_0.5.0           haven_2.5.5          bit_4.6.0
## [19] xfun_0.53            cachem_1.1.0         jsonlite_2.0.0
## [22] blob_1.2.4           DelayedArray_0.36.0  parallel_4.5.1
## [25] cluster_2.1.8.1      R6_2.6.1             bslib_0.9.0
## [28] limma_3.66.0         boot_1.3-32          jquerylib_0.1.4
## [31] cellranger_1.1.0     Rcpp_1.1.0           knitr_1.50
## [34] readr_2.1.5          splines_4.5.1        rstudioapi_0.17.1
## [37] dichromat_2.0-0.1    abind_1.4-8          yaml_2.3.10
## [40] codetools_0.2-20     lattice_0.22-7       tibble_3.3.0
## [43] withr_3.0.2          KEGGREST_1.50.0      evaluate_1.0.5
## [46] survival_3.8-3       proxy_0.4-27         Biostrings_2.78.0
## [49] pillar_1.11.1        hms_1.1.4            scales_1.4.0
## [52] rootSolve_1.8.2.4    xtable_1.8-4         class_7.3-23
## [55] glue_1.8.0           lmom_3.2             tools_4.5.1
## [58] data.table_1.17.8    annotate_1.88.0      locfit_1.5-9.12
## [61] forcats_1.0.1        Exact_3.3            fs_1.6.6
## [64] mvtnorm_1.3-3        XML_3.99-0.19        grid_4.5.1
## [67] AnnotationDbi_1.72.0 edgeR_4.8.0          cli_3.6.5
## [70] expm_1.0-0           S4Arrays_1.10.0      gtable_0.3.6
## [73] sass_0.4.10          digest_0.6.37        SparseArray_1.10.0
## [76] farver_2.1.2         memoise_2.0.1        htmltools_0.5.8.1
## [79] lifecycle_1.0.4      httr_1.4.7           statmod_1.5.1
## [82] bit64_4.6.0-1        MASS_7.3-65
```