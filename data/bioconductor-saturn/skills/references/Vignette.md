# satuRn - vignette

#### Jeroen Gilis

#### 14/07/2022

* [Introduction](#introduction)
* [Package installation](#package-installation)
* [Load libraries](#load-libraries)
* [Load data](#load-data)
* [Data pre-processing](#data-pre-processing)
* [Import transcript information](#import-transcript-information)
  + [Data wrangling](#data-wrangling)
  + [Filtering](#filtering)
  + [Create a design matrix](#create-a-design-matrix)
  + [Generate SummarizedExperiment](#generate-summarizedexperiment)
* [Fit quasi-binomial generalized linear models models](#fit-quasi-binomial-generalized-linear-models-models)
* [Test for DTU](#test-for-dtu)
  + [Set up contrast matrix](#set-up-contrast-matrix)
  + [Perform the test](#perform-the-test)
* [Visualize DTU](#visualize-dtu)
* [Optional post-processing of results: Two-stage testing procedure with stageR](#optional-post-processing-of-results-two-stage-testing-procedure-with-stager)
* [Session](#session)
* [References](#references)

# Introduction

`satuRn` is an R package for performing differential transcript usage analyses in bulk and single-cell transcriptomics datasets. The package has three main functions.

1. The first function, `fitDTU`, is used to model transcript usage profiles by means of a quasi-binomial generalized linear model.
2. Second, the `testDTU` function tests for differential usage of transcripts between certain groups of interest (e.g. different treatment groups or cell types).
3. Finally, the `plotDTU` can be used to visualize the usage profiles of selected transcripts in different groups of interest.

All details about the `satuRn` model and statistical tests are described in our preprint (Gilis Jeroen 2021).

In this vignette, we analyze a small subset of the data from (Tasic Bosiljka 2018). More specifically, an expression matrix and the corresponding metadata of the subset data has been provided with the `satuRn` package. We will adopt this dataset to showcase the different functionalities of `satuRn`.

# Package installation

`satuRn` (version 1.4.0) can be installed from Bioconductor with:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("satuRn")
```

Alternatively, the development version of `satuRn` can be downloaded with:

```
devtools::install_github("statOmics/satuRn")
```

*! for this vignette, we use the development version of satuRn.* The vignette for the officially released satuRn version 1.4.0 can be viewed from [Bioconductor](https://bioconductor.org/packages/release/bioc/vignettes/satuRn/inst/doc/Vignette.html)

# Load libraries

```
library(satuRn)
library(AnnotationHub)
library(ensembldb)
library(edgeR)
library(SummarizedExperiment)
library(ggplot2)
library(DEXSeq)
library(stageR)
```

# Load data

The following data corresponds to a small subset of the dataset from (Tasic Bosiljka 2018) and is readily available from the `satuRn` package. To check how the subset was generate, please check `?Tasic_counts_vignette`.

```
data(Tasic_counts_vignette) # transcript expression matrix
data(Tasic_metadata_vignette) # metadata
```

# Data pre-processing

We start the analysis from scratch, in order to additionally showcase some of the prerequisite steps for performing a DTU analysis.

# Import transcript information

First, we need an object that links transcripts to their corresponding genes. We suggest using the BioConductor R packages `AnnotationHub` and `ensembldb` for this purpose.

```
ah <- AnnotationHub() # load the annotation resource.
all <- query(ah, "EnsDb") # query for all available EnsDb databases
ahEdb <- all[["AH75036"]] # for Mus musculus (choose correct release date)
txs <- transcripts(ahEdb)
```

## Data wrangling

Next, we perform some data wrangling steps to get the data in a format that is suited for satuRn. First, we create a `DataFrame` or `Matrix` linking transcripts to their corresponding genes.

! Important: `satuRn` is implemented such that the columns with transcript identifiers is names `isoform_id`, while the column containing gene identifiers should be named `gene_id`. In addition, following chunk removes transcripts that are the only isoform expressed of a certain gene, as they cannot be used in a DTU analysis.

```
# Get the transcript information in correct format
txInfo <- as.data.frame(matrix(data = NA, nrow = length(txs), ncol = 2))
colnames(txInfo) <- c("isoform_id", "gene_id")
txInfo$isoform_id <- txs$tx_id
txInfo$gene_id <- txs$gene_id
rownames(txInfo) <- txInfo$isoform_id

# Remove transcripts that are the only isoform expressed of a certain gene
rownames(Tasic_counts_vignette) <- sub("\\..*", "",
                                       rownames(Tasic_counts_vignette))
# remove transcript version identifiers

txInfo <- txInfo[txInfo$isoform_id %in% rownames(Tasic_counts_vignette), ]
txInfo <- subset(txInfo,
                 duplicated(gene_id) | duplicated(gene_id, fromLast = TRUE))

Tasic_counts_vignette <- Tasic_counts_vignette[which(
  rownames(Tasic_counts_vignette) %in% txInfo$isoform_id), ]
```

## Filtering

Here we perform some feature-level filtering. For this task, we adopt the filtering criterion that is implemented in the R package `edgeR`. Alternatively, one could adopt the `dmFilter` criterion from the `DRIMSeq` R package, which provides a more stringent filtering when both methods are run in default settings. After filtering, we again remove transcripts that are the only isoform expressed of a certain gene.

```
filter_edgeR <- filterByExpr(Tasic_counts_vignette,
    design = NULL,
    group = Tasic_metadata_vignette$brain_region,
    lib.size = NULL,
    min.count = 10,
    min.total.count = 30,
    large.n = 20,
    min.prop = 0.7
) # more stringent than default to reduce run time of the vignette

table(filter_edgeR)
```

```
## filter_edgeR
## FALSE  TRUE
##  5996 10982
```

```
Tasic_counts_vignette <- Tasic_counts_vignette[filter_edgeR, ]

# Update txInfo according to the filtering procedure
txInfo <- txInfo[which(
  txInfo$isoform_id %in% rownames(Tasic_counts_vignette)), ]

# remove txs that are the only isoform expressed within a gene (after filtering)
txInfo <- subset(txInfo,
                 duplicated(gene_id) | duplicated(gene_id, fromLast = TRUE))
Tasic_counts_vignette <- Tasic_counts_vignette[which(rownames(
  Tasic_counts_vignette) %in% txInfo$isoform_id), ]

# satuRn requires the transcripts in the rowData and
# the transcripts in the count matrix to be in the same order.
txInfo <- txInfo[match(rownames(Tasic_counts_vignette), txInfo$isoform_id), ]
```

## Create a design matrix

Here we set up the design matrix of the experiment. The subset of the dataset from (Tasic Bosiljka 2018) contains cells of several different cell types (variable `cluster`) in two different areas of the mouse neocortex (variable `brain_region`). As such, we can model the data with a factorial design, i.e. by generating a new variable `group` that encompasses all different cell type - brain region combinations.

```
Tasic_metadata_vignette$group <- paste(Tasic_metadata_vignette$brain_region,
                                       Tasic_metadata_vignette$cluster,
                                       sep = ".")
```

## Generate SummarizedExperiment

All three main functions of `satuRn` require a `SummarizedExperiment` object as an input class. See the SummarizedExperiment vignette (Morgan Martin, n.d.) for more information on this object class.

For the sake of completeness, it is advised to include the design matrix formula in the SummarizedExperiment as indicated below.

```
sumExp <- SummarizedExperiment::SummarizedExperiment(
    assays = list(counts = Tasic_counts_vignette),
    colData = Tasic_metadata_vignette,
    rowData = txInfo
)

# for sake of completeness: specify design formula from colData
metadata(sumExp)$formula <- ~ 0 + as.factor(colData(sumExp)$group)
sumExp
```

```
## class: SummarizedExperiment
## dim: 9151 60
## metadata(1): formula
## assays(1): counts
## rownames(9151): ENSMUST00000037739 ENSMUST00000228774 ...
##   ENSMUST00000127554 ENSMUST00000132683
## rowData names(2): isoform_id gene_id
## colnames(60): F2S4_160622_013_D01 F2S4_160624_023_C01 ...
##   F2S4_160919_010_B01 F2S4_160915_002_D01
## colData names(4): sample_name brain_region cluster group
```

# Fit quasi-binomial generalized linear models models

The `fitDTU` function of `satuRn` is used to model transcript usage in different groups of samples or cells. Here we adopt the default settings of the function. Without parallelized execution, this code runs for approximately 15 seconds on a 2018 macbook pro laptop.

```
system.time({
sumExp <- satuRn::fitDTU(
    object = sumExp,
    formula = ~ 0 + group,
    parallel = FALSE,
    BPPARAM = BiocParallel::bpparam(),
    verbose = TRUE
)
})
```

```
##    user  system elapsed
##  19.658   1.034  20.696
```

The resulting model fits are now saved into the `rowData` of our SummarizedExperiment object under the name `fitDTUModels`. These models can be accessed as follows:

```
rowData(sumExp)[["fitDTUModels"]]$"ENSMUST00000037739"
```

```
## An object of class "StatModel"
## Slot "type":
## [1] "glm"
##
## Slot "params":
## $coefficients
##  designgroupALM.L5_IT_ALM_Tmem163_Dmrtb1
##                                 1.612656
##             designgroupALM.L5_IT_ALM_Tnc
##                                 1.773648
## designgroupVISp.L5_IT_VISp_Hsd11b1_Endou
##                                 1.232522
##
## $df.residual
## [1] 55
##
## $dispersion
## [1] 28.14375
##
## $vcovUnsc
##                                          designgroupALM.L5_IT_ALM_Tmem163_Dmrtb1
## designgroupALM.L5_IT_ALM_Tmem163_Dmrtb1                              0.004760564
## designgroupALM.L5_IT_ALM_Tnc                                         0.000000000
## designgroupVISp.L5_IT_VISp_Hsd11b1_Endou                             0.000000000
##                                          designgroupALM.L5_IT_ALM_Tnc
## designgroupALM.L5_IT_ALM_Tmem163_Dmrtb1                   0.000000000
## designgroupALM.L5_IT_ALM_Tnc                              0.004363295
## designgroupVISp.L5_IT_VISp_Hsd11b1_Endou                  0.000000000
##                                          designgroupVISp.L5_IT_VISp_Hsd11b1_Endou
## designgroupALM.L5_IT_ALM_Tmem163_Dmrtb1                               0.000000000
## designgroupALM.L5_IT_ALM_Tnc                                          0.000000000
## designgroupVISp.L5_IT_VISp_Hsd11b1_Endou                              0.004042164
##
##
## Slot "varPosterior":
## [1] 27.73451
##
## Slot "dfPosterior":
## [1] 58.87993
```

The models are instances of the `StatModel` class as defined in the `satuRn` package. These contain all relevant information for the downstream analysis. For more details, read the StatModel documentation with ?satuRn::`StatModel-class`.

# Test for DTU

Here we test for differential transcript usage between select groups of interest. In this example, the groups of interest are the three different cell types that are present in the dataset associated with this vignette.

## Set up contrast matrix

First, we set up a contrast matrix. This allows us to test for differential transcript usage between groups of interest. The `group` factor in this toy example contains three levels; (1) ALM.L5\_IT\_ALM\_Tmem163\_Dmrtb1, (2) ALM.L5\_IT\_ALM\_Tnc, (3) VISp.L5\_IT\_VISp\_Hsd11b1\_Endou. Here we show to assess DTU between cells of the groups 1 and 3 and between cells of groups 2 and 3.

The contrast matrix can be constructed manually;

```
group <- as.factor(Tasic_metadata_vignette$group)
design <- model.matrix(~ 0 + group) # construct design matrix
colnames(design) <- levels(group)

L <- matrix(0, ncol = 2, nrow = ncol(design)) # initialize contrast matrix
rownames(L) <- colnames(design)
colnames(L) <- c("Contrast1", "Contrast2")

L[c("VISp.L5_IT_VISp_Hsd11b1_Endou","ALM.L5_IT_ALM_Tnc"),1] <-c(1,-1)
L[c("VISp.L5_IT_VISp_Hsd11b1_Endou","ALM.L5_IT_ALM_Tmem163_Dmrtb1"),2] <-c(1,-1)
L # contrast matrix
```

```
##                               Contrast1 Contrast2
## ALM.L5_IT_ALM_Tmem163_Dmrtb1          0        -1
## ALM.L5_IT_ALM_Tnc                    -1         0
## VISp.L5_IT_VISp_Hsd11b1_Endou         1         1
```

This can also be done automatically with the `makeContrasts` function of the `limma` R package.

```
group <- as.factor(Tasic_metadata_vignette$group)
design <- model.matrix(~ 0 + group) # construct design matrix
colnames(design) <- levels(group)

L <- limma::makeContrasts(
    Contrast1 = VISp.L5_IT_VISp_Hsd11b1_Endou - ALM.L5_IT_ALM_Tnc,
    Contrast2 = VISp.L5_IT_VISp_Hsd11b1_Endou - ALM.L5_IT_ALM_Tmem163_Dmrtb1,
    levels = design
)
L # contrast matrix
```

```
##                                Contrasts
## Levels                          Contrast1 Contrast2
##   ALM.L5_IT_ALM_Tmem163_Dmrtb1          0        -1
##   ALM.L5_IT_ALM_Tnc                    -1         0
##   VISp.L5_IT_VISp_Hsd11b1_Endou         1         1
```

## Perform the test

Next we can perform differential usage testing using `testDTU`. We again adopt default settings. For more information on the parameter settings, please consult the help file of the `testDTU` function. Note that the arguments `diagplot1` and `diagplot2` were not yet implemented in `satuRn` v1.1.1.

```
sumExp <- satuRn::testDTU(
    object = sumExp,
    contrasts = L,
    diagplot1 = TRUE,
    diagplot2 = TRUE,
    sort = FALSE
)
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

When set to TRUE, the `diagplot1` and `diagplot2` arguments generate a diagnostic plot.

For `diagplot1`, the histogram of the z-scores (computed from p-values) is displayed using the locfdr function of the `locfdr` package. The blue dashed curve is fitted to the mid 50% of the z-scores, which are assumed to originate from null transcripts, thus representing the estimated empirical null component densities. The maximum likelihood estimates (MLE) and central matching estimates (CME) of this estimated empirical null distribution are given below the plot. If the MLE estimates for delta and sigma deviate from 0 and 1 respectively, the downstream inference will be influenced by the empirical adjustment implemented in satuRn (see below).

For `diagplot2`, a plot of the histogram of the “empirically adjusted” test statistics and the standard normal distribution will be displayed. Ideally, the majority (mid portion) of the adjusted test statistics should follow the standard normal. If this is not the case, the inference may be untrustworthy and results should be treated with care. One potential solution is to include (additional) potential covariates in the analysis.

The test results are now saved into the `rowData` of our SummarizedExperiment object under the name `fitDTUResult_` followed by the name of the contrast of interest (i.e. the column names of the contrast matrix). The results can be accessed as follows:

```
head(rowData(sumExp)[["fitDTUResult_Contrast1"]]) # first contrast
```

```
##                     estimates        se       df          t       pval
## ENSMUST00000037739 -0.5411265 0.4828263 58.87993 -1.1207478 0.26694568
## ENSMUST00000228774  0.5411265 0.4828263 58.87993  1.1207478 0.26694568
## ENSMUST00000025204  0.1929718 0.1936406 60.87993  0.9965461 0.32292942
## ENSMUST00000237499 -0.1929718 0.1936406 60.87993 -0.9965461 0.32292942
## ENSMUST00000042857 -0.8245461 0.4360516 57.87993 -1.8909370 0.06364136
## ENSMUST00000114415  0.8245461 0.4360516 57.87993  1.8909370 0.06364136
##                    regular_FDR empirical_pval empirical_FDR
## ENSMUST00000037739   0.6436301      0.3960748     0.9783123
## ENSMUST00000228774   0.6436301      0.4155835     0.9805421
## ENSMUST00000025204   0.6930521      0.4696864     0.9832446
## ENSMUST00000237499   0.6930521      0.4487298     0.9816784
## ENSMUST00000042857   0.3560815      0.1596473     0.9169444
## ENSMUST00000114415   0.3560815      0.1701525     0.9235306
```

```
head(rowData(sumExp)[["fitDTUResult_Contrast2"]]) # second contrast
```

```
##                     estimates        se       df          t        pval
## ENSMUST00000037739 -0.3801339 0.4941046 58.87993 -0.7693389 0.444767534
## ENSMUST00000228774  0.3801339 0.4941046 58.87993  0.7693389 0.444767534
## ENSMUST00000025204  0.2971434 0.1905116 60.87993  1.5597130 0.124011439
## ENSMUST00000237499 -0.2971434 0.1905116 60.87993 -1.5597130 0.124011439
## ENSMUST00000042857 -1.4866500 0.5008434 57.87993 -2.9682930 0.004350088
## ENSMUST00000114415  1.4866500 0.5008434 57.87993  2.9682930 0.004350088
##                    regular_FDR empirical_pval empirical_FDR
## ENSMUST00000037739   0.7761164     0.56145740     0.9888549
## ENSMUST00000228774   0.7761164     0.58498552     0.9888549
## ENSMUST00000025204   0.4965490     0.26410011     0.9888549
## ENSMUST00000237499   0.4965490     0.24960317     0.9888549
## ENSMUST00000042857   0.1485967     0.03403358     0.9888549
## ENSMUST00000114415   0.1485967     0.03705910     0.9888549
```

The results for are, for each contrast, a dataframe with 8 columns:

* `estimates`: The estimated log-odds ratios (log base e). In the most simple case, an estimate of +1 would mean that the odds of picking that transcript from the pool of transcripts within its corresponding gene is exp(1) = 2.72 times larger in condition B than in condition A.
* `se`: The standard error on this estimate.
* `df`: The posterior degrees of freedom for the test statistic.
* `t`: The student’s t-test statistic, computed with a Wald test given `estimates` and `se`.
* `pval`: The “raw” p-value given `t` and `df`.
* `FDR`: The false discovery rate, computed using the multiple testing correction of Benjamini and Hochberg on `pval`.
* `empirical_pval`: An “empirical” p-value that is computed by estimating the null distribution of the test statistic empirically. For more details, see our publication.
* `empirical_FDR`: The false discovery rate, computed using the multiple testing correction of Benjamini and Hochberg on `pval_empirical`.

**!Note: based on the benchmarks in our publication, we always recommend using** **the empirical p-values from column 7 over the “raw” p-value from column 5.** When the MLE estimates for the mean and standard deviation (delta and sigma) of the empirical null density (blue dashed curve in `diagplot1`) deviate from 0 and 1 respectively, there will be a discrepancy between the “raw” and “empirically adjusted” p-values. A deviation in the standard deviation only affects the magnitude of the p-values, whereas a deviation in the mean also affects the ranking of transcripts according to their p-value.

# Visualize DTU

Finally, we may visualize the usage of select transcripts in select groups of interest.

```
group1 <- colnames(sumExp)[colData(sumExp)$group ==
                             "VISp.L5_IT_VISp_Hsd11b1_Endou"]
group2 <- colnames(sumExp)[colData(sumExp)$group ==
                             "ALM.L5_IT_ALM_Tnc"]

plots <- satuRn::plotDTU(
    object = sumExp,
    contrast = "Contrast1",
    groups = list(group1, group2),
    coefficients = list(c(0, 0, 1), c(0, 1, 0)),
    summaryStat = "model",
    transcripts = c("ENSMUST00000081554",
                    "ENSMUST00000195963",
                    "ENSMUST00000132062"),
    genes = NULL,
    top.n = 6
)

# to have same layout as in our paper
for (i in seq_along(plots)) {
    current_plot <- plots[[i]] +
        scale_fill_manual(labels = c("VISp", "ALM"), values = c("royalblue4",
                                                                "firebrick")) +
        scale_x_discrete(labels = c("Hsd11b1_Endou", "Tnc"))

    print(current_plot)
}
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

# Optional post-processing of results: Two-stage testing procedure with stageR

`satuRn` returns transcript-level p-values for each of the specified contrasts. While we have shown that `satuRn` is able to adequately control the false discovery rate (FDR) at the transcript level (Gilis Jeroen 2021), (Van den Berge Koen 2017) argued that it is often desirable to control the FDR at the gene level. This boosts statistical power and eases downstream biological interpretation and validation, which typically occur at the gene level.

To this end, (Van den Berge Koen 2017) developed a testing procedure that is implemented in the BioConductor R package `stageR`. The procedure consists of two stages; a screening stage and a confirmation stage.

In the screening stage, gene-level FDR-adjusted p-values are computed, which aggregate the evidence for differential transcript usage over all transcripts within the gene. Only genes with an FDR below the desired nominal level are further considered in the second stage. In the confirmation stage, transcript-level p-values are adjusted for those genes, using a FWER-controlling method on the FDR-adjusted significance level.

In its current implementation, `stageR` can only perform stage-wise testing if only one contrast is of interest in a DTU setting. An analogous correction for the assessment of multiple contrasts for multiple transcripts per gene has not yet been implemented.

Below, we demonstrate how the transcript-level p-values for the first contrast as returned by `satuRn` can be post-processed using `stageR`. We rely on the `perGeneQValue` function:

```
# transcript level p-values from satuRn
pvals <- rowData(sumExp)[["fitDTUResult_Contrast1"]]$empirical_pval

# compute gene level q-values
geneID <- factor(rowData(sumExp)$gene_id)
geneSplit <- split(seq(along = geneID), geneID)
pGene <- sapply(geneSplit, function(i) min(pvals[i]))
pGene[is.na(pGene)] <- 1
theta <- unique(sort(pGene))

# gene-level significance testing
q <- DEXSeq:::perGeneQValueExact(pGene, theta, geneSplit)
qScreen <- rep(NA_real_, length(pGene))
qScreen <- q[match(pGene, theta)]
qScreen <- pmin(1, qScreen)
names(qScreen) <- names(geneSplit)

# prepare stageR input
tx2gene <- as.data.frame(rowData(sumExp)[c("isoform_id", "gene_id")])
colnames(tx2gene) <- c("transcript", "gene")

pConfirmation <- matrix(matrix(pvals),
    ncol = 1,
    dimnames = list(rownames(tx2gene), "transcript")
)

# create a stageRTx object
stageRObj <- stageR::stageRTx(
    pScreen = qScreen,
    pConfirmation = pConfirmation,
    pScreenAdjusted = TRUE,
    tx2gene = tx2gene
)

# perform the two-stage testing procedure
stageRObj <- stageR::stageWiseAdjustment(
    object = stageRObj,
    method = "dtu",
    alpha = 0.05,
    allowNA = TRUE
)

# retrieves the adjusted p-values from the stageRTx object
padj <- stageR::getAdjustedPValues(stageRObj,
    order = TRUE,
    onlySignificantGenes = FALSE
)
```

```
## The returned adjusted p-values are based on a stage-wise testing approach and are only valid for the provided target OFDR level of 5%. If a different target OFDR level is of interest,the entire adjustment should be re-run.
```

```
head(padj)
```

```
##               geneID               txID       gene transcript
## 1 ENSMUSG00000058013 ENSMUST00000201421 0.03948351 0.06026752
## 2 ENSMUSG00000058013 ENSMUST00000201700 0.03948351 1.00000000
## 3 ENSMUSG00000058013 ENSMUST00000074733 0.03948351 1.00000000
## 4 ENSMUSG00000058013 ENSMUST00000202217 0.03948351 1.00000000
## 5 ENSMUSG00000058013 ENSMUST00000202196 0.03948351 1.00000000
## 6 ENSMUSG00000058013 ENSMUST00000202308 0.03948351 1.00000000
```

# Session

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
##  [1] stageR_1.32.0               DEXSeq_1.56.0
##  [3] RColorBrewer_1.1-3          DESeq2_1.50.0
##  [5] BiocParallel_1.44.0         ggplot2_4.0.0
##  [7] SummarizedExperiment_1.40.0 MatrixGenerics_1.22.0
##  [9] matrixStats_1.5.0           edgeR_4.8.0
## [11] limma_3.66.0                ensembldb_2.34.0
## [13] AnnotationFilter_1.34.0     GenomicFeatures_1.62.0
## [15] AnnotationDbi_1.72.0        Biobase_2.70.0
## [17] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [19] IRanges_2.44.0              S4Vectors_0.48.0
## [21] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [23] dbplyr_2.5.1                BiocGenerics_0.56.0
## [25] generics_0.1.4              satuRn_1.18.0
## [27] knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                bitops_1.0-9             pbapply_1.7-4
##  [4] httr2_1.2.1              biomaRt_2.66.0           rlang_1.1.6
##  [7] magrittr_2.0.4           compiler_4.5.1           RSQLite_2.4.3
## [10] png_0.1-8                vctrs_0.6.5              stringr_1.5.2
## [13] ProtGenerics_1.42.0      pkgconfig_2.0.3          crayon_1.5.3
## [16] fastmap_1.2.0            XVector_0.50.0           labeling_0.4.3
## [19] Rsamtools_2.26.0         rmarkdown_2.30           UCSC.utils_1.6.0
## [22] purrr_1.1.0              bit_4.6.0                xfun_0.53
## [25] cachem_1.1.0             cigarillo_1.0.0          GenomeInfoDb_1.46.0
## [28] jsonlite_2.0.0           progress_1.2.3           blob_1.2.4
## [31] DelayedArray_0.36.0      prettyunits_1.2.0        parallel_4.5.1
## [34] R6_2.6.1                 stringi_1.8.7            bslib_0.9.0
## [37] genefilter_1.92.0        rtracklayer_1.70.0       boot_1.3-32
## [40] jquerylib_0.1.4          Rcpp_1.1.0               Matrix_1.7-4
## [43] splines_4.5.1            tidyselect_1.2.1         dichromat_2.0-0.1
## [46] abind_1.4-8              yaml_2.3.10              codetools_0.2-20
## [49] hwriter_1.3.2.1          curl_7.0.0               lattice_0.22-7
## [52] tibble_3.3.0             withr_3.0.2              KEGGREST_1.50.0
## [55] S7_0.2.0                 evaluate_1.0.5           survival_3.8-3
## [58] Biostrings_2.78.0        pillar_1.11.1            BiocManager_1.30.26
## [61] filelock_1.0.3           RCurl_1.98-1.17          hms_1.1.4
## [64] BiocVersion_3.22.0       scales_1.4.0             xtable_1.8-4
## [67] glue_1.8.0               lazyeval_0.2.2           tools_4.5.1
## [70] BiocIO_1.20.0            annotate_1.88.0          locfit_1.5-9.12
## [73] GenomicAlignments_1.46.0 XML_3.99-0.19            grid_4.5.1
## [76] restfulr_0.0.16          cli_3.6.5                rappdirs_0.3.3
## [79] S4Arrays_1.10.0          dplyr_1.1.4              gtable_0.3.6
## [82] sass_0.4.10              digest_0.6.37            SparseArray_1.10.0
## [85] geneplotter_1.88.0       rjson_0.2.23             farver_2.1.2
## [88] memoise_2.0.1            htmltools_0.5.8.1        lifecycle_1.0.4
## [91] httr_1.4.7               locfdr_1.1-8             statmod_1.5.1
## [94] bit64_4.6.0-1
```

# References

Gilis Jeroen, Koen Van den Berge & Lieven Clement, Kristoffer Vitting-Seerup. 2021. “satuRn: Scalable Analysis of differential Transcript Usage for bulk and single-cell RNA-sequencing applications.” *F1000*, May. [https://doi.org/https://doi.org/10.12688/f1000research.51749.1](https://doi.org/https%3A//doi.org/10.12688/f1000research.51749.1).

Morgan Martin, Hester Jim, Obenchain Valerie. n.d. “SummarizedExperiment.” <https://bioconductor.org/packages/SummarizedExperiment>.

Tasic Bosiljka, Lucas T. Graybuck, Zizhen Yao. 2018. “Shared and distinct transcriptomic cell types across neocortical areas.” *Nature*, 72–78. <https://doi.org/10.1038/s41586-018-0654-5>.

Van den Berge Koen, Mark Robinson & Lieven Clement, Charlotte Soneson. 2017. “stageR: a general stage-wise method for controlling the gene-level false discovery rate in differential expression and differential transcript usage.” *Genome Biology*. <https://doi.org/10.1186/s13059-017-1277-0>.