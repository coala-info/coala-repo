# Making comparisons for differential abundance using contrasts

Mike Morgan

#### 27/01/2022

#### Package

miloR 2.6.0

```
library(miloR)
library(SingleCellExperiment)
library(scater)
library(scran)
library(dplyr)
library(patchwork)
library(MouseThymusAgeing)
library(scuttle)
```

# 1 Introduction

We have seen how Milo uses graph neighbourhoods to model cell state abundance differences in an experiment, when comparing 2 groups. However, we are often interested in
testing between 2 specific groups in our analysis when our experiment has collected data from \(\gt\) 2 groups. We can focus our analysis to a 2 group comparison and
still make use of all of the data for things like dispersion estimation, by using *contrasts*. For an in-depth use of contrasts we recommend users refer to the `limma`
and `edgeR` Biostars and Bioconductor community forum threads on the subject. Here I will give an overview of how to use contrasts in the context of a Milo analysis.

# 2 Load data

We will use the `MouseThymusAgeing` data package as there are multiple groups that we can compare.

```
thy.sce <- MouseSMARTseqData() # this function downloads the full SCE object
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## field not found in version - adding
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
## see ?MouseThymusAgeing and browseVignettes('MouseThymusAgeing') for documentation
```

```
## loading from cache
```

```
thy.sce <- logNormCounts(thy.sce)
thy.sce
```

```
## class: SingleCellExperiment
## dim: 48801 2327
## metadata(0):
## assays(2): counts logcounts
## rownames(48801): ERCC-00002 ERCC-00003 ... ENSMUSG00000064371
##   ENSMUSG00000064372
## rowData names(6): Geneid Chr ... Strand Length
## colnames(2327): B13.B002229.1_52.1.32.1_S109
##   B13.B002297.1_32.4.52.1_S73 ... P9.B002345.5_52.1.32.1_S93
##   P9.B002450.5_4.52.16.1_S261
## colData names(11): CellID ClusterID ... SubType sizeFactor
## reducedDimNames(1): PCA
## mainExpName: NULL
## altExpNames(0):
```

# 3 Define cell neighbourhoods

```
thy.sce <- runUMAP(thy.sce) # add a UMAP for plotting results later

thy.milo <- Milo(thy.sce) # from the SCE object
reducedDim(thy.milo, "UMAP") <- reducedDim(thy.sce, "UMAP")

plotUMAP(thy.milo, colour_by="SubType") + plotUMAP(thy.milo, colour_by="Age")
```

![](data:image/png;base64...)

These UMAPs shows how the different thymic epithelial cell subtypes and cells from different aged mice are distributed across our single-cell data set. Next
we build the KNN graph and define neighbourhoods to quantify cell abundance across our experimental samples.

```
# we build KNN graph
thy.milo <- buildGraph(thy.milo, k = 11, d = 40)
```

```
## Constructing kNN graph with k:11
```

```
thy.milo <- makeNhoods(thy.milo, prop = 0.2, k = 11, d=40, refined = TRUE, refinement_scheme="graph") # make nhoods using graph-only as this is faster
```

```
## Checking valid object
```

```
## Running refined sampling with graph
```

```
colData(thy.milo)$Sample <- paste(colData(thy.milo)$SortDay, colData(thy.milo)$Age, sep="_")
thy.milo <- countCells(thy.milo, meta.data = data.frame(colData(thy.milo)), samples="Sample") # make the nhood X sample counts matrix
```

```
## Checking meta.data validity
```

```
## Counting cells in neighbourhoods
```

```
plotNhoodSizeHist(thy.milo)
```

![](data:image/png;base64...)

# 4 Differential abundance testing with contrasts

Now we have the pieces in place for DA testing to demonstrate how to use contrasts. We will use these contrasts to explicitly define which groups will be
compared to each other.

```
thy.design <- data.frame(colData(thy.milo))[,c("Sample", "SortDay", "Age")]
thy.design <- distinct(thy.design)
rownames(thy.design) <- thy.design$Sample
## Reorder rownames to match columns of nhoodCounts(milo)
thy.design <- thy.design[colnames(nhoodCounts(thy.milo)), , drop=FALSE]
table(thy.design$Age)
```

```
##
## 16wk  1wk 32wk  4wk 52wk
##    5    5    5    5    5
```

To demonstrate the use of contrasts we will fit the whole model to the whole data set, but we will compare sequential pairs of time points. I’ll start with week 1 vs.
week 4 to illustrate the syntax.

```
rownames(thy.design) <- thy.design$Sample
contrast.1 <- c("Age1wk - Age4wk") # the syntax is <VariableName><ConditionLevel> - <VariableName><ControlLevel>

# we need to use the ~ 0 + Variable expression here so that we have all of the levels of our variable as separate columns in our model matrix
da_results <- testNhoods(thy.milo, design = ~ 0 + Age, design.df = thy.design, model.contrasts = contrast.1,
                         fdr.weighting="graph-overlap", norm.method="TMM")
```

```
## Using TMM normalisation
```

```
## Running with model contrasts
```

```
## Performing spatial FDR correction with graph-overlap weighting
```

```
table(da_results$SpatialFDR < 0.1)
```

```
##
## FALSE  TRUE
##   307    39
```

This calculates a Fold-change and corrected P-value for each neighbourhood, which indicates whether there is significant differential abundance between conditions for
39 neighbourhoods.

You will notice that the syntax for the contrasts is quite specific. It starts with the name of the column variable that contains the different group levels; in this case
it is the `Age` variable. We then define the comparison levels as `level1 - level2`. To understand this syntax we need to consider what we are concretely comparing. In this
case we are asking what is the ratio of the average cell count at week1 compared to the average cell count at week 4, where the averaging is across the replicates. The
reason we express this as a difference rather than a ratio is because we are dealing with the *log* fold change.

We can also pass multiple comparisons at the same time, for instance if we wished to compare each sequential pair of time points. This will give us a better intuition behind
how to use contrasts to compare multiple groups.

```
contrast.all <- c("Age1wk - Age4wk", "Age4wk - Age16wk", "Age16wk - Age32wk", "Age32wk - Age52wk")
# contrast.all <- c("Age1wk - Age4wk", "Age16wk - Age32wk")

# this is the edgeR code called by `testNhoods`
model <- model.matrix(~ 0 + Age, data=thy.design)
mod.constrast <- makeContrasts(contrasts=contrast.all, levels=model)

mod.constrast
```

```
##          Contrasts
## Levels    Age1wk - Age4wk Age4wk - Age16wk Age16wk - Age32wk Age32wk - Age52wk
##   Age16wk               0               -1                 1                 0
##   Age1wk                1                0                 0                 0
##   Age32wk               0                0                -1                 1
##   Age4wk               -1                1                 0                 0
##   Age52wk               0                0                 0                -1
```

This shows the contrast matrix. If we want to test each of these comparisons then we need to pass them sequentially to `testNhoods`, then apply an additional
multiple testing correction to the spatial FDR values.

```
contrast1.res <- testNhoods(thy.milo, design=~0+ Age, design.df=thy.design, fdr.weighting="graph-overlap", model.contrasts = contrast.all)
```

```
## Using TMM normalisation
```

```
## Running with model contrasts
```

```
## Performing spatial FDR correction with graph-overlap weighting
```

```
head(contrast1.res)
```

```
##   logFC.Age1wk...Age4wk logFC.Age4wk...Age16wk logFC.Age16wk...Age32wk
## 1             -1.143684            0.001781207                1.855287
## 2              0.000000            0.000000000               -4.014602
## 3             -2.984658           -0.116498724                1.049384
## 4              1.289584            2.638542991                0.000000
## 5              3.174679            1.225531994                0.000000
## 6             -1.240139           -1.434066483               -2.306808
##   logFC.Age32wk...Age52wk   logCPM         F       PValue          FDR Nhood
## 1              -0.7041312 13.53287 0.8524959 4.917506e-01 5.767652e-01     1
## 2              -1.1227393 13.77206 8.4948831 7.807492e-07 9.004641e-05     2
## 3               0.5636459 13.79275 2.0999373 7.810722e-02 1.308341e-01     3
## 4               0.0000000 13.44977 4.4212275 1.434753e-03 5.395918e-03     4
## 5               0.0000000 13.48386 6.2992630 4.682703e-05 6.549395e-04     5
## 6               0.7313569 13.83075 5.4711198 2.143748e-04 1.348613e-03     6
##     SpatialFDR
## 1 0.5574289340
## 2 0.0001886292
## 3 0.1300684820
## 4 0.0058807306
## 5 0.0007137975
## 6 0.0015135755
```

This matrix of contrasts will perform a quasi-likelihood F-test over all 5 contrasts, hence a single p-value and spatial FDR are returned. Log fold changes are returned for
each contrast of the `Age` variable, which gives 1 log-fold change column for each - this is the default behaviour of `glmQLFTest` in the `edgeR` package
which is what Milo uses for hypothesis testing. In general, and to avoid confusion, we recommend testing each pair of contrasts separately if these are the comparisons
of interest, as shown below.

```
# compare weeks 4 and 16, with week 4 as the reference.
cont.4vs16.res <- testNhoods(thy.milo, design=~0+ Age, design.df=thy.design, fdr.weighting="graph-overlap", model.contrasts = c("Age4wk - Age16wk"))
```

```
## Using TMM normalisation
```

```
## Running with model contrasts
```

```
## Performing spatial FDR correction with graph-overlap weighting
```

```
head(cont.4vs16.res)
```

```
##          logFC   logCPM            F     PValue       FDR Nhood SpatialFDR
## 1  0.001781207 13.53287 7.242033e-06 0.99785289 1.0000000     1  1.0000000
## 2  0.000000000 13.77206 0.000000e+00 1.00000000 1.0000000     2  1.0000000
## 3 -0.116498724 13.79275 1.318886e-02 0.90857307 1.0000000     3  1.0000000
## 4  2.638542991 13.44977 3.667571e+00 0.05552217 0.3049313     4  0.2805072
## 5  1.225531994 13.48386 1.073527e+00 0.30018627 0.5829568     5  0.5928761
## 6 -1.434066483 13.83075 1.189103e+00 0.27554855 0.5781829     6  0.5916077
```

Now we have a single logFC which compares nhood abundance between week 4 and week 16 - as we can see the LFC estimates should be the same, but the SpatialFDR will be different.

```
par(mfrow=c(1, 2))
plot(contrast1.res$logFC.Age4wk...Age16wk, cont.4vs16.res$logFC,
     xlab="4wk vs. 16wk LFC\nsingle contrast", ylab="4wk vs. 16wk LFC\nmultiple contrast")

plot(contrast1.res$SpatialFDR, cont.4vs16.res$SpatialFDR,
     xlab="Spatial FDR\nsingle contrast", ylab="Spatial FDR\nmultiple contrast")
```

![](data:image/png;base64...)

Contrasts are not limited to these simple pair-wise comparisons, we can also group levels together for comparisons. For instance, imagine we want to know
what the effect of the cell counts in the week 1 mice is *compared to all other time points*.

```
model <- model.matrix(~ 0 + Age, data=thy.design)
ave.contrast <- c("Age1wk - (Age4wk + Age16wk + Age32wk + Age52wk)/4")
mod.constrast <- makeContrasts(contrasts=ave.contrast, levels=model)

mod.constrast
```

```
##          Contrasts
## Levels    Age1wk - (Age4wk + Age16wk + Age32wk + Age52wk)/4
##   Age16wk                                             -0.25
##   Age1wk                                               1.00
##   Age32wk                                             -0.25
##   Age4wk                                              -0.25
##   Age52wk                                             -0.25
```

In this contrasts matrix we can see that we have taken the average effect over the other time points. Now running this using `testNhoods`

```
da_results <- testNhoods(thy.milo, design = ~ 0 + Age, design.df = thy.design, model.contrasts = ave.contrast, fdr.weighting="graph-overlap")
```

```
## Using TMM normalisation
```

```
## Running with model contrasts
```

```
## Performing spatial FDR correction with graph-overlap weighting
```

```
table(da_results$SpatialFDR < 0.1)
```

```
##
## FALSE  TRUE
##   225   121
```

```
head(da_results)
```

```
##        logFC   logCPM            F       PValue          FDR Nhood   SpatialFDR
## 1 -0.3907374 13.53287 1.388475e-01 7.094408e-01 9.740735e-01     1 9.997113e-01
## 2 -2.2879858 13.77206 3.778964e-07 9.995095e-01 9.997113e-01     2 9.997113e-01
## 3 -2.4064281 13.79275 4.957312e+00 2.601263e-02 7.758940e-02     3 8.273987e-02
## 4  3.2684909 13.44977 1.606685e+01 6.178716e-05 1.068918e-03     4 1.067767e-03
## 5  4.0938282 13.48386 2.518044e+01 5.351138e-07 2.756552e-05     5 3.183685e-05
## 6 -3.2862537 13.83075 7.219543e+00 7.228641e-03 3.426178e-02     6 3.822318e-02
```

The results table In this comparison there are 121 DA nhoods - which we can visualise on a superimposed single-cell UMAP.

```
thy.milo <- buildNhoodGraph(thy.milo)

plotUMAP(thy.milo, colour_by="SubType") + plotNhoodGraphDA(thy.milo, da_results, alpha=0.1) +
  plot_layout(guides="auto" )
```

```
## Adding nhood effect sizes to neighbourhood graph attributes
```

![](data:image/png;base64...)

In these side-by-side UMAPs we can see that there is an enrichment of the Perinatal cTEC and Proliferating TEC populations in the 1 week old compared to
the other time points.

For a more extensive description of the uses of contrasts please take a look at the edgeR documentation .

**Session Info**

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
##  [1] MouseThymusAgeing_1.17.0    patchwork_1.3.2
##  [3] dplyr_1.1.4                 scran_1.38.0
##  [5] scater_1.38.0               ggplot2_4.0.0
##  [7] scuttle_1.20.0              SingleCellExperiment_1.32.0
##  [9] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [11] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [13] IRanges_2.44.0              S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [19] miloR_2.6.0                 edgeR_4.8.0
## [21] limma_3.66.0                BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3   jsonlite_2.0.0       magrittr_2.0.4
##   [4] ggbeeswarm_0.7.2     magick_2.9.0         farver_2.1.2
##   [7] rmarkdown_2.30       vctrs_0.6.5          memoise_2.0.1
##  [10] tinytex_0.57         htmltools_0.5.8.1    S4Arrays_1.10.0
##  [13] AnnotationHub_4.0.0  curl_7.0.0           BiocNeighbors_2.4.0
##  [16] SparseArray_1.10.0   sass_0.4.10          pracma_2.4.6
##  [19] bslib_0.9.0          httr2_1.2.1          cachem_1.1.0
##  [22] igraph_2.2.1         lifecycle_1.0.4      pkgconfig_2.0.3
##  [25] rsvd_1.0.5           Matrix_1.7-4         R6_2.6.1
##  [28] fastmap_1.2.0        digest_0.6.37        numDeriv_2016.8-1.1
##  [31] AnnotationDbi_1.72.0 dqrng_0.4.1          irlba_2.3.5.1
##  [34] ExperimentHub_3.0.0  RSQLite_2.4.3        beachmat_2.26.0
##  [37] filelock_1.0.3       labeling_0.4.3       httr_1.4.7
##  [40] polyclip_1.10-7      abind_1.4-8          compiler_4.5.1
##  [43] bit64_4.6.0-1        withr_3.0.2          S7_0.2.0
##  [46] BiocParallel_1.44.0  viridis_0.6.5        DBI_1.2.3
##  [49] ggforce_0.5.0        MASS_7.3-65          rappdirs_0.3.3
##  [52] DelayedArray_0.36.0  bluster_1.20.0       gtools_3.9.5
##  [55] tools_4.5.1          vipor_0.4.7          beeswarm_0.4.0
##  [58] glue_1.8.0           grid_4.5.1           cluster_2.1.8.1
##  [61] gtable_0.3.6         tidyr_1.3.1          BiocSingular_1.26.0
##  [64] tidygraph_1.3.1      ScaledMatrix_1.18.0  metapod_1.18.0
##  [67] XVector_0.50.0       ggrepel_0.9.6        BiocVersion_3.22.0
##  [70] pillar_1.11.1        stringr_1.5.2        splines_4.5.1
##  [73] tweenr_2.0.3         BiocFileCache_3.0.0  lattice_0.22-7
##  [76] FNN_1.1.4.1          bit_4.6.0            tidyselect_1.2.1
##  [79] locfit_1.5-9.12      Biostrings_2.78.0    knitr_1.50
##  [82] gridExtra_2.3        bookdown_0.45        xfun_0.53
##  [85] graphlayouts_1.2.2   statmod_1.5.1        stringi_1.8.7
##  [88] yaml_2.3.10          evaluate_1.0.5       codetools_0.2-20
##  [91] ggraph_2.2.2         tibble_3.3.0         BiocManager_1.30.26
##  [94] cli_3.6.5            uwot_0.2.3           jquerylib_0.1.4
##  [97] dichromat_2.0-0.1    Rcpp_1.1.0           dbplyr_2.5.1
## [100] png_0.1-8            parallel_4.5.1       blob_1.2.4
## [103] viridisLite_0.4.2    scales_1.4.0         purrr_1.1.0
## [106] crayon_1.5.3         rlang_1.1.6          cowplot_1.2.0
## [109] KEGGREST_1.50.0
```