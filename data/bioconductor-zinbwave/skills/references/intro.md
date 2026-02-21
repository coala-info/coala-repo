# An introduction to ZINB-WaVE

Davide Risso

#### Last modified: April 19, 2019; Compiled: October 30, 2025

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
  + [2.1 The ZINB-WaVE model](#the-zinb-wave-model)
  + [2.2 Example dataset](#example-dataset)
* [3 Gene filtering](#gene-filtering)
* [4 ZINB-WaVE](#zinb-wave)
  + [4.1 Adding covariates](#adding-covariates)
    - [4.1.1 Sample-level covariates](#sample-level-covariates)
    - [4.1.2 Gene-level covariates](#gene-level-covariates)
* [5 t-SNE representation](#t-sne-representation)
* [6 Normalized values and deviance residuals](#normalized-values-and-deviance-residuals)
* [7 The `zinbFit` function](#the-zinbfit-function)
* [8 Differential Expression](#differential-expression)
  + [8.1 Differential expression with edgeR](#differential-expression-with-edger)
  + [8.2 Differential expression with DESeq2](#differential-expression-with-deseq2)
* [9 Using `zinbwave` with Seurat](#using-zinbwave-with-seurat)
* [10 Working with large datasets](#working-with-large-datasets)
* [11 A note on performance and parallel computing](#a-note-on-performance-and-parallel-computing)
* [12 Session Info](#session-info)
* [References](#references)

# 1 Installation

The recommended way to install the `zinbwave` package is

```
install.packages("BiocManager")
BiocManager::install("zinbwave")
```

Note that `zinbwave` requires R (>=3.4) and Bioconductor (>=3.6).

# 2 Introduction

This vignette provides an introductory example on how to work with the `zinbwave`
package, which implements the ZINB-WaVE method proposed in (Risso et al. [2018](#ref-risso2017)).

First, let’s load the packages and set serial computations.

```
library(zinbwave)
library(scRNAseq)
library(matrixStats)
library(magrittr)
library(ggplot2)
library(biomaRt)
library(sparseMatrixStats)

# Register BiocParallel Serial Execution
BiocParallel::register(BiocParallel::SerialParam())
```

## 2.1 The ZINB-WaVE model

ZINB-WaVE is a general and flexible model for the analysis of high-dimensional zero-inflated count data, such as those recorded in single-cell RNA-seq assays. Given \(n\) samples (typically, \(n\) single cells) and \(J\) features (typically, \(J\) genes) that can be counted for each sample, we denote with \(Y\_{ij}\) the count of feature \(j\) (\(j=1,\ldots,J\)) for sample \(i\) (\(i=1,\ldots,n\)). To account for various technical and
biological effects, typical of single-cell sequencing
technologies, we model \(Y\_{ij}\) as a random variable following a zero-inflated negative binomial (ZINB) distribution with parameters \(\mu\_{ij}\), \(\theta\_{ij}\), and
\(\pi\_{ij}\), and consider the following regression models for the parameters:

\[\begin{align}
\label{eq:model1}
\ln(\mu\_{ij}) &= \left( X\beta\_\mu + (V\gamma\_\mu)^\top + W\alpha\_\mu + O\_\mu\right)\_{ij}\,,\\
\label{eq:model2}
\text{logit}(\pi\_{ij}) &= \left(X\beta\_\pi + (V\gamma\_\pi)^\top + W\alpha\_\pi + O\_\pi\right)\_{ij} \,, \\
\label{eq:model3}
\ln(\theta\_{ij}) &= \zeta\_j \,,
\end{align}\].

where the elements of the regression models are as follows.

* \(X\) is a known \(n \times M\) matrix corresponding to \(M\) cell-level covariates and \({\bf \beta}=(\beta\_\mu,\beta\_\pi)\) its associated \(M \times J\) matrices of regression parameters. \(X\) can typically include covariates that induce variation of interest, such as cell types, or covariates that induce unwanted variation, such as batch or quality control (QC) measures. By default, it includes only a constant column of ones, \({\bf 1}\_n\), to account for gene-specific intercepts.
* \(V\) is a known \(J \times L\) matrix corresponding to \(J\) gene-level covariates, such as gene length or GC-content, and \({\bf \gamma} = (\gamma\_\mu , \gamma\_\pi)\) its associated \(L\times n\) matrices of regression parameters. By default, \(V\) only includes a constant column of ones, \({\bf 1}\_J\), to account for cell-specific intercepts, such as size factors representing differences in library sizes.
* \(W\) is an unobserved \(n \times K\) matrix corresponding to \(K\) unknown cell-level covariates, which could be of “unwanted variation” or of interest (such as cell type), and \({\bf \alpha} = (\alpha\_\mu,\alpha\_{\pi})\) its associated \(K \times J\) matrices of regression parameters.
* \(O\_\mu\) and \(O\_\pi\) are known \(n \times J\) matrices of offsets.
* \(\zeta\in\mathbb{R}^J\) is a vector of gene-specific dispersion parameters on the log scale.

## 2.2 Example dataset

To illustrate the methodology, we will make use of the Fluidigm C1 dataset of
(Pollen et al. [2014](#ref-Pollen2014)). The data consist of 65 cells, each sequenced at high and low depth.
The data are publicly available as part of the [scRNAseq package](https://www.bioconductor.org/packages/release/data/experiment/html/scRNAseq.html), in the form of a `SummarizedExperiment` object.

```
fluidigm <- ReprocessedFluidigmData(assays = "tophat_counts")
fluidigm
```

```
## class: SummarizedExperiment
## dim: 26255 130
## metadata(3): sample_info clusters which_qc
## assays(1): tophat_counts
## rownames(26255): A1BG A1BG-AS1 ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(130): SRR1275356 SRR1274090 ... SRR1275366 SRR1275261
## colData names(28): NREADS NALIGNED ... Cluster1 Cluster2
```

```
table(colData(fluidigm)$Coverage_Type)
```

```
##
## High  Low
##   65   65
```

# 3 Gene filtering

First, we filter out the lowly expressed genes, by removing those genes that do
not have at least 5 reads in at least 5 samples.

```
filter <- rowSums(assay(fluidigm)>5)>5
table(filter)
```

```
## filter
## FALSE  TRUE
## 16127 10128
```

```
fluidigm <- fluidigm[filter,]
```

This leaves us with 10128 genes.

We next identify the 100 most variable genes, which will be the input of our
ZINB-WaVE procedure. Although we apply ZINB-WaVE to only these genes primarily
for computational reasons, it is generally a good idea to focus on a subset of
highly-variable genes, in order to remove transcriptional noise and focus on the
more biologically meaningful signals. However, at least 1,000 genes are probably
needed for real analyses.

```
assay(fluidigm) %>% log1p %>% rowVars -> vars
names(vars) <- rownames(fluidigm)
vars <- sort(vars, decreasing = TRUE)
head(vars)
```

```
##  IGFBPL1    STMN2     EGR1   ANP32E    CENPF     LDHA
## 13.06109 12.24748 11.90608 11.67819 10.83797 10.72307
```

```
fluidigm <- fluidigm[names(vars)[1:100],]
```

Before proceeding, we rename the first assay of `fluidigm` “counts” to avoid needing to specify which assay we should use for the `zinbwave` workflow. This is an optional step.

```
assayNames(fluidigm)[1] <- "counts"
```

# 4 ZINB-WaVE

The easiest way to obtain the low-dimensional representation of the data with ZINB-WaVE is to use the `zinbwave` function. This function takes as input a `SummarizedExperiment` object and returns a `SingleCellExperiment` object.

```
fluidigm_zinb <- zinbwave(fluidigm, K = 2, epsilon=1000)
```

By default, the `zinbwave` function fits a ZINB model with \(X = {\bf 1}\_n\) and \(V = {\bf 1}\_J\). In this case, the model is a factor model akin to principal component analysis (PCA), where \(W\) is a factor matrix and \(\alpha\_\mu\) and \(\alpha\_\pi\) are loading matrices.
By default, the `epsilon` parameter is set to the number of genes. We empirically
found that a high `epsilon` is often required to obtained a good low-level
representation. See `?zinbModel` for details. Here we set `epsilon=1000`.

The parameter \(K\) controls how many latent variables we want to infer
from the data. \(W\) is stored in the `reducedDim` slot of the object. (See the `SingleCellExperiment` vignette for details).

In this case, as we specified \(K=2\), we can visualize the resulting \(W\) matrix in a simple plot, color-coded by cell-type.

```
W <- reducedDim(fluidigm_zinb)

data.frame(W, bio=colData(fluidigm)$Biological_Condition,
           coverage=colData(fluidigm)$Coverage_Type) %>%
    ggplot(aes(W1, W2, colour=bio, shape=coverage)) + geom_point() +
    scale_color_brewer(type = "qual", palette = "Set1") + theme_classic()
```

![](data:image/png;base64...)

## 4.1 Adding covariates

The ZINB-WaVE model is more general than PCA, allowing the inclusion of additional sample and gene-level covariates that might help to infer the unknown factors.

### 4.1.1 Sample-level covariates

Typically, one could include batch information as sample-level covariate, to
account for batch effects. Here, we illustrate this capability by including the coverage (high or low) as a sample-level covariate.

The column `Coverage_Type` in the `colData` of `fluidigm` contains the coverage information. We can specify a design matrix that includes an intercept and an indicator
variable for the coverage, by using the formula interface of `zinbFit`.

```
fluidigm_cov <- zinbwave(fluidigm, K=2, X="~Coverage_Type", epsilon=1000)
```

```
W <- reducedDim(fluidigm_cov)

data.frame(W, bio=colData(fluidigm)$Biological_Condition,
           coverage=colData(fluidigm)$Coverage_Type) %>%
    ggplot(aes(W1, W2, colour=bio, shape=coverage)) + geom_point() +
    scale_color_brewer(type = "qual", palette = "Set1") + theme_classic()
```

![](data:image/png;base64...)

In this case, the inferred \(W\) matrix is essentially the same with or without
covariates, indicating that the scaling factor included in the model (the \(\gamma\) parameters associated with the intercept of \(V\)) are enough to achieve a good low-dimensional representation of the data.

### 4.1.2 Gene-level covariates

Analogously, we can include gene-level covariates, as columns of \(V\). Here, we
illustrate this capability by including gene length and GC-content.

We use the `biomaRt` package to compute gene length and GC-content.

```
mart <- useMart("ensembl")
mart <- useDataset("hsapiens_gene_ensembl", mart = mart)
bm <- getBM(attributes=c('hgnc_symbol', 'start_position',
                         'end_position', 'percentage_gene_gc_content'),
            filters = 'hgnc_symbol',
            values = rownames(fluidigm),
            mart = mart)

bm$length <- bm$end_position - bm$start_position
len <- tapply(bm$length, bm$hgnc_symbol, mean)
len <- len[rownames(fluidigm)]
gcc <- tapply(bm$percentage_gene_gc_content, bm$hgnc_symbol, mean)
gcc <- gcc[rownames(fluidigm)]
```

We then include the gene-level information as `rowData` in the `fluidigm` object.

```
rowData(fluidigm) <- data.frame(gccontent = gcc, length = len)
```

```
fluidigm_gcc <- zinbwave(fluidigm, K=2, V="~gccontent + log(length)", epsilon=1000)
```

# 5 t-SNE representation

A t-SNE representation of the data can be obtained by computing the cell distances
in the reduced space and running the t-SNE algorithm on the distance.

```
set.seed(93024)

library(Rtsne)
W <- reducedDim(fluidigm_cov)
tsne_data <- Rtsne(W, pca = FALSE, perplexity=10, max_iter=5000)

data.frame(Dim1=tsne_data$Y[,1], Dim2=tsne_data$Y[,2],
           bio=colData(fluidigm)$Biological_Condition,
           coverage=colData(fluidigm)$Coverage_Type) %>%
    ggplot(aes(Dim1, Dim2, colour=bio, shape=coverage)) + geom_point() +
    scale_color_brewer(type = "qual", palette = "Set1") + theme_classic()
```

![](data:image/png;base64...)

# 6 Normalized values and deviance residuals

Sometimes it is useful to have normalized values for visualization and residuals
for model evaluation. Both quantities can be computed with the `zinbwave()`
function.

```
fluidigm_norm <- zinbwave(fluidigm, K=2, epsilon=1000, normalizedValues=TRUE,
                    residuals = TRUE)
```

The `fluidigm_norm` object includes normalized values and residuals as additional `assays`.

```
fluidigm_norm
```

```
## class: SingleCellExperiment
## dim: 100 130
## metadata(3): sample_info clusters which_qc
## assays(3): counts normalizedValues residuals
## rownames(100): IGFBPL1 STMN2 ... SRSF7 FAM117B
## rowData names(0):
## colnames(130): SRR1275356 SRR1274090 ... SRR1275366 SRR1275261
## colData names(28): NREADS NALIGNED ... Cluster1 Cluster2
## reducedDimNames(1): zinbwave
## mainExpName: NULL
## altExpNames(0):
```

# 7 The `zinbFit` function

The `zinbwave` function is a user-friendly function to obtain the low-dimensional representation of the data, and optionally the normalized values and residuals from the model.

However, it is sometimes useful to store all the parameter estimates and the value of the likelihood. The `zinbFit` function allows the user to create an object of class `zinbModel` that can be used to store all the parameter estimates and have greater control on the results.

```
zinb <- zinbFit(fluidigm, K=2, epsilon=1000)
```

As with `zinbwave`, by default, the `zinbFit` function fits a ZINB model with \(X = {\bf 1}\_n\) and \(V = {\bf 1}\_J\).

If a user has run `zinbFit` and wants to obtain normalized values or the low-dimensional representation of the data in a `SingleCellExperiment` format, they can pass the `zinbModel` object to `zinbwave` to avoid repeating all the computations.

Here, we also specify `observationalWeights = TRUE` to compute observational weights, useful for differential expression (see next section).

```
fluidigm_zinb <- zinbwave(fluidigm, fitted_model = zinb, K = 2, epsilon=1000,
                          observationalWeights = TRUE)
```

# 8 Differential Expression

The `zinbwave` package can be used to compute observational weights to “unlock” bulk RNA-seq tools for single-cell applications, as illustrated in (Van den Berge et al. [2018](#ref-van2018observation)).

`zinbwave` optionally computes the observational weights when specifying `observationalWeights = TRUE` as in the code chuck above. See the man page of `zinbwave`.
The weights are stored in an `assay` named `weights` and can be accessed with the following call.

```
weights <- assay(fluidigm_zinb, "weights")
```

Note that in this example, the value of the penalty parameter `epsilon` was set at `1000`, although we do not recommend this for differential expression analysis in real applications. Our evaluations have shown that a value of `epsilon=1e12` gives good performance across a range of datasets, although this number is still arbitrary. In general, values between `1e6` and `1e13` give best performances.

## 8.1 Differential expression with edgeR

Once we have the observational weights, we can use them in `edgeR` to perform differential expression. Specifically, we use a moderated F-test in which the denominator residual degrees of freedom are adjusted by the extent of zero inflation (see (Van den Berge et al. [2018](#ref-van2018observation)) for details).

Here, we compare NPC to GW16. Note that we start from only 100 genes for computational reasons, but in real analyses we would use all the expressed genes.

```
library(edgeR)

dge <- DGEList(assay(fluidigm_zinb))
dge <- calcNormFactors(dge)

design <- model.matrix(~Biological_Condition, data = colData(fluidigm))
dge$weights <- weights
dge <- estimateDisp(dge, design)
fit <- glmFit(dge, design)

lrt <- glmWeightedF(fit, coef = 3)
topTags(lrt)
```

```
## Coefficient:  Biological_ConditionGW21+3
##              logFC   logCPM       LR       PValue   padjFilter          FDR
## VIM      -4.768897 13.21736 47.42589 2.393409e-10 2.393409e-08 2.393409e-08
## FOS      -5.314332 14.50176 37.36423 9.051878e-09 4.525939e-07 4.525939e-07
## USP47    -3.900577 13.37158 29.91750 2.219650e-07 7.398833e-06 7.398833e-06
## PTN      -3.190169 13.22778 22.67843 4.705508e-06 1.176377e-04 1.176377e-04
## MIR100HG  2.388532 14.26683 18.24713 3.533856e-05 6.554540e-04 6.554540e-04
## NNAT     -2.062978 13.60868 17.93144 3.932724e-05 6.554540e-04 6.554540e-04
## SPARC    -3.202994 13.23879 16.07823 1.050223e-04 1.500319e-03 1.500319e-03
## SFRP1    -3.405949 13.01425 14.44899 2.450571e-04 3.063214e-03 3.063214e-03
## EGR1     -2.658644 14.93922 13.57415 3.205559e-04 3.561733e-03 3.561733e-03
## ST8SIA1  -3.338410 13.35883 12.63813 5.345402e-04 5.345402e-03 5.345402e-03
```

## 8.2 Differential expression with DESeq2

Analogously, we can use the weights in a `DESeq2` analysis by using observation-level weights in the parameter estimation steps. In this case, there is no need to pass the weights to `DESeq2` since they are already in the `weights` assay of the object.

```
library(DESeq2)

counts(fluidigm_zinb) <- as.matrix(counts(fluidigm_zinb))
dds <- DESeqDataSet(fluidigm_zinb, design = ~ Biological_Condition)

dds <- DESeq(dds, sfType="poscounts", useT=TRUE, minmu=1e-6)
res <- lfcShrink(dds, contrast=c("Biological_Condition", "NPC", "GW16"),
                 type = "normal")
head(res)
```

```
## log2 fold change (MAP): Biological_Condition NPC vs GW16
## Wald test p-value: Biological Condition NPC vs GW16
## DataFrame with 6 rows and 6 columns
##          baseMean log2FoldChange     lfcSE      stat      pvalue        padj
##         <numeric>      <numeric> <numeric> <numeric>   <numeric>   <numeric>
## IGFBPL1  2054.403       -8.29483  0.705618  -7.84898 4.19419e-15 2.20747e-14
## STMN2    2220.078      -10.07429  0.769583  -9.37555 6.88190e-21 6.88190e-20
## EGR1     1342.465       -6.85394  0.662687 -10.34378 2.31566e-18 1.65404e-17
## ANP32E    806.983        1.99091  0.502374   3.96658 1.30782e-04 3.26955e-04
## CENPF     255.632        1.37109  0.553764   2.46388 1.60986e-02 2.72858e-02
## LDHA      311.760        2.36716  0.578059   4.08608 9.82542e-05 2.51934e-04
```

Note that `DESeq2`’s default normalization procedure is based on geometric means of counts, which are zero for genes with at least one zero count. This greatly limits the number of genes that can be used for normalization in scRNA-seq applications. We therefore use the normalization method suggested in the `phyloseq` package, which calculates the geometric mean for a gene by only using its positive counts, so that genes with zero counts could still be used for normalization purposes.
The `phyloseq` normalization procedure can be applied by setting the argument `type` equal to `poscounts` in `DESeq`.

For UMI data, for which the expected counts may be very low, the likelihood ratio test implemented in `nbinomLRT` should be used. For other protocols (i.e., non-UMI), the Wald test in `nbinomWaldTest` can be used, with null distribution a t-distribution with degrees of freedom corrected by the observational weights. In both cases, we recommend the minimum expected count to be set to a small value (e.g., `minmu=1e-6`).

# 9 Using `zinbwave` with Seurat

The factors inferred in the `zinbwave` model can be added as one of the low dimensional data representations in the `Seurat` object, for instance to find subpopulations using Seurat’s cluster analysis method.

We first need to convert the `SingleCellExperiment` object into a `Seurat` object, using Seurat’s `CreateSeuratObject` function.

Note that the following workflow has been tested with Seurat’s version 4.0.1.

Here we create a simple Seurat object with the raw data. Please, refer to the Seurat’s vignettes for a typical analysis, which includes filtering, normalization, etc.

```
library(Seurat)

seu <- as.Seurat(x = fluidigm_zinb, counts = "counts", data = "counts")
```

Note that our `zinbwave` factors are automatically in the Seurat object.

Finally, we can use the `zinbwave` factors for cluster analysis.

```
seu <- FindNeighbors(seu, reduction = "zinbwave",
                     dims = 1:2 #this should match K
                     )
seu <- FindClusters(object = seu)
```

# 10 Working with large datasets

When working with large datasets, `zinbwave` can be computationally demanding.
We provide an approximate strategy, implemented in the `zinbsurf` function, that
uses only a random subset of the cells to infer the low dimensional space and
subsequently projects all the cells into the inferred space.

```
fluidigm_surf <- zinbsurf(fluidigm, K = 2, epsilon = 1000,
                          prop_fit = 0.5)

W2 <- reducedDim(fluidigm_surf)

data.frame(W2, bio=colData(fluidigm)$Biological_Condition,
           coverage=colData(fluidigm)$Coverage_Type) %>%
    ggplot(aes(W1, W2, colour=bio, shape=coverage)) + geom_point() +
    scale_color_brewer(type = "qual", palette = "Set1") + theme_classic()
```

![](data:image/png;base64...)

Note that here we use 50% of the data to get a reasonable approximation, since
we start with only 130 cells. We found that for datasets with tens of thousands
of cells, 10% (the default value) is usally a reasonable choice.

Note that this is an experimental feature and has not been thoroughly tested. Use at your own risk!

# 11 A note on performance and parallel computing

The `zinbwave` package uses the `BiocParallel` package to allow for parallel
computing. Here, we used the `register` command
to ensure that the vignette runs with serial computations.

However, in real datasets, parallel computations can speed up the computations
dramatically, in the presence of many genes and/or many cells.

There are two ways of allowing parallel computations in `zinbwave`. The first is
to `register()` a parallel back-end (see `?BiocParallel::register` for details).
Alternatively, one can pass a `BPPARAM` object to `zinbwave` and `zinbFit`, e.g.

```
library(BiocParallel)
zinb_res <- zinbwave(fluidigm, K=2, BPPARAM=MulticoreParam(2))
```

We found that `MulticoreParam()` may have some performance issues on Mac; hence,
we recommend `DoparParam()` when working on Mac.

# 12 Session Info

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
##  [1] DESeq2_1.50.0               edgeR_4.8.0
##  [3] limma_3.66.0                Rtsne_0.17
##  [5] sparseMatrixStats_1.22.0    biomaRt_2.66.0
##  [7] ggplot2_4.0.0               magrittr_2.0.4
##  [9] scRNAseq_2.23.1             zinbwave_1.32.0
## [11] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [13] Biobase_2.70.0              GenomicRanges_1.62.0
## [15] Seqinfo_1.0.0               IRanges_2.44.0
## [17] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [19] generics_0.1.4              MatrixGenerics_1.22.0
## [21] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       jsonlite_2.0.0           magick_2.9.0
##   [4] GenomicFeatures_1.62.0   gypsum_1.6.0             farver_2.1.2
##   [7] rmarkdown_2.30           BiocIO_1.20.0            vctrs_0.6.5
##  [10] memoise_2.0.1            Rsamtools_2.26.0         RCurl_1.98-1.17
##  [13] tinytex_0.57             htmltools_0.5.8.1        S4Arrays_1.10.0
##  [16] progress_1.2.3           AnnotationHub_4.0.0      curl_7.0.0
##  [19] Rhdf5lib_1.32.0          SparseArray_1.10.0       rhdf5_2.54.0
##  [22] sass_0.4.10              alabaster.base_1.10.0    bslib_0.9.0
##  [25] alabaster.sce_1.10.0     httr2_1.2.1              cachem_1.1.0
##  [28] GenomicAlignments_1.46.0 lifecycle_1.0.4          pkgconfig_2.0.3
##  [31] Matrix_1.7-4             R6_2.6.1                 fastmap_1.2.0
##  [34] digest_0.6.37            AnnotationDbi_1.72.0     ExperimentHub_3.0.0
##  [37] RSQLite_2.4.3            labeling_0.4.3           filelock_1.0.3
##  [40] httr_1.4.7               abind_1.4-8              compiler_4.5.1
##  [43] bit64_4.6.0-1            withr_3.0.2              S7_0.2.0
##  [46] BiocParallel_1.44.0      DBI_1.2.3                HDF5Array_1.38.0
##  [49] alabaster.ranges_1.10.0  alabaster.schemas_1.10.0 rappdirs_0.3.3
##  [52] DelayedArray_0.36.0      rjson_0.2.23             tools_4.5.1
##  [55] glue_1.8.0               h5mread_1.2.0            restfulr_0.0.16
##  [58] rhdf5filters_1.22.0      grid_4.5.1               gtable_0.3.6
##  [61] ensembldb_2.34.0         hms_1.1.4                XVector_0.50.0
##  [64] BiocVersion_3.22.0       pillar_1.11.1            stringr_1.5.2
##  [67] genefilter_1.92.0        softImpute_1.4-3         splines_4.5.1
##  [70] dplyr_1.1.4              BiocFileCache_3.0.0      lattice_0.22-7
##  [73] survival_3.8-3           rtracklayer_1.70.0       bit_4.6.0
##  [76] annotate_1.88.0          tidyselect_1.2.1         locfit_1.5-9.12
##  [79] Biostrings_2.78.0        knitr_1.50               bookdown_0.45
##  [82] ProtGenerics_1.42.0      xfun_0.53                statmod_1.5.1
##  [85] stringi_1.8.7            UCSC.utils_1.6.0         lazyeval_0.2.2
##  [88] yaml_2.3.10              evaluate_1.0.5           codetools_0.2-20
##  [91] cigarillo_1.0.0          tibble_3.3.0             alabaster.matrix_1.10.0
##  [94] BiocManager_1.30.26      cli_3.6.5                xtable_1.8-4
##  [97] jquerylib_0.1.4          dichromat_2.0-0.1        Rcpp_1.1.0
## [100] GenomeInfoDb_1.46.0      dbplyr_2.5.1             png_0.1-8
## [103] XML_3.99-0.19            parallel_4.5.1           blob_1.2.4
## [106] prettyunits_1.2.0        AnnotationFilter_1.34.0  bitops_1.0-9
## [109] alabaster.se_1.10.0      scales_1.4.0             crayon_1.5.3
## [112] rlang_1.1.6              KEGGREST_1.50.0
```

# References

Pollen, Alex A, Tomasz J Nowakowski, Joe Shuga, Xiaohui Wang, Anne A Leyrat, Jan H Lui, Nianzhen Li, et al. 2014. “Low-coverage single-cell mRNA sequencing reveals cellular heterogeneity and activated signaling pathways in developing cerebral cortex.” *Nature Biotechnology* 32 (10): 1053–8.

Risso, D, F Perraudeau, S Gribkova, S Dudoit, and Vert JP. 2018. “A General and Flexible Method for Signal Extraction from Single-Cell RNA-Seq Data.” *Nature Communications* 9: 284.

Van den Berge, Koen, Fanny Perraudeau, Charlotte Soneson, Michael I Love, Davide Risso, Jean-Philippe Vert, Mark D Robinson, Sandrine Dudoit, and Lieven Clement. 2018. “Observation Weights to Unlock Bulk Rna-Seq Tools for Zero Inflation and Single-Cell Applications.” *bioRxiv*, 250126.