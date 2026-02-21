# LineagePulse

David S. Fischer

#### *4 January 2019*

#### Package

LineagePulse 1.2.1

# Contents

* [1 Introduction](#introduction)
* [2 Differential expression analysis](#differential-expression-analysis)
  + [2.1 Manual analysis of expression trajectories](#manual-analysis-of-expression-trajectories)
  + [2.2 Fold changes](#fold-changes)
  + [2.3 Global expression profiles](#global-expression-profiles)
* [3 Session information](#session-information)

# 1 Introduction

LineagePulse is a differential expression algorithm for single-cell RNA-seq (scRNA-seq) data.
LineagePulse is based on zero-inflated negative binomial noise model and can capture both discrete and continuous population structures:
Discrete population structures are groups of cells (e.g. condition of an experiment or tSNE clusters).
Continous population structures can for example be pseudotemporal orderings of cells or temporal orderings of cells.
The main use and novelty of LineagePulse lies in its ability to fit gene expression trajectories on pseudotemporal orderings of cells well.
Note that LineagePulse does not infer a pseudotemporal ordering but is a downstream analytic tool to analyse gene expression trajectories on a given pseudotemporal ordering (such as from diffusion pseudotime or monocle2).

To run LineagPulse on scRNA-seq data, the user needs to use a minimal input parameter set for
the wrapper function runLineagePulse, which then performs all normalisation, model fitting and differential expression analysis steps without any more user interaction required:

* counts the count matrix (genes x cells) which MUST NOT be normalised in any way. A valid input option is expected counts from an aligner. Note that TPM or depth normalised expected counts are NOT count data. The statistical framework of LineagePulse rests on the assumption that matCounts contain count data. The count matrix can also be supplied as the path to a .mtx file (sparse matrix format file) or as a SummarizedExperiment or SingleCellExperiment object.
* dfAnnotation data frame that contains cell-wise annotation. The rownames of dfAnnotation must be equal to the column names of matCounts as both correspond to cells. Note that if counts is a SummarizedExperiment or SingleCellExperiment object, the annotation data frame is taken to be colData(counts) if dfAnnotation is NULL. dfAnnotation must contain
* a column named “continuous” if a continuous model is fit (e.g. strMuModel is impulse or splines and expression is fit as a function of time or pseudotime coordinates)
* a column named “groups” if a discrete population model is fit (e.g. strMuModel is groups and expression is fit as a function of group assignment, e.g. clusters or experimental conditions) that contains the assignemnt of cells to these groups as strings
* columns that describe the batch structure (if any).

Additionally, one can provide:

* matPiConstPredictors a matrix of gene-specific predictors of the drop-out rate (genes x predictors). We suggest to use the log average expression (unless strDropModel is “logistic\_ofMu”) and potentially parameters which may affect sequencing efficiency such as GC content of the gene.
* strMuModel the type of expression model to use as an alternative model for differential expression analysis: “impulse” for an impulse model and “splines” for a natural cubic spline model.
* vecConfoundersMu a vector of strings which corresond to column names in dfAnnotation which describe the batch structure to be corrected for.
* scaDFSplinesMu the degrees of freedom of the spline-based model for the mean parameter if strMuModel was set to “splines”.
* vecNormConstExternal cell-wise normalisation constants to be used (e.g. sequencing depth correction factors). the names of the elements have to be the column names of matCounts (cells).
* scaNProc to set the number of processes for parallelization.
* boolVerbose output basic progress reports while the wrapper functions runs.
* boolSuperVerbose output detailed progress reports for each step of the wrapper function.

Lastly, the experienced user who has a solid grasp of the mathematical and algorithmic basis of LineagePulse may change the defaults of these advanced input options:

* vecConfoundersDisp batch variables to be used to correct the dispersion (variance).
* strDispModelFull the dispersion model to be used for the full model.
* strDispModelRed the dispersion model to be used for the reduced model.
* strDropModel the drop-out model to be used.
* strDropFitGroup the groups of cells which receive one parameterisation of the drop-out model.
* scaDFSplinesDisp the degrees of freedom of the spline-based model for the dispersion parameter if strDispModel was set to “splines”.
* boolEstimateNoiseBasedOnH0 whether to estimate the drop-out model on the null or alternative expression model. Note that setting this to FALSE strongly increases the run time.
* scaMaxEstimationCycles maximum number of drop-out and expression model estimation iteration cycles.

# 2 Differential expression analysis

Here, we present a differential expression analysis scenario on a longitudinal ordering.
The differential expression results are in a data frame which can be accessed from the output object via list like properties ($).
The core differential expression analysis result are p-value and false-discovery-rate corrected p-value of differential expression which are the result of a gene-wise hypothesis test of a non-constant expression model (impulse, splines or groups) versus a constant expression model.

```
library(LineagePulse)
lsSimulatedData <- simulateContinuousDataSet(
  scaNCells = 100,
  scaNConst = 10,
  scaNLin = 10,
  scaNImp = 10,
  scaMumax = 100,
  scaSDMuAmplitude = 3,
  vecNormConstExternal=NULL,
  vecDispExternal=rep(20, 30),
  vecGeneWiseDropoutRates = rep(0.1, 30))
```

```
## Draw mean trajectories
```

```
## Setting size factors uniformly =1
```

```
## Draw dispersion
```

```
## Simulate negative binomial noise
```

```
## Simulate drop-out
```

```
objLP <- runLineagePulse(
  counts = lsSimulatedData$counts,
  dfAnnotation = lsSimulatedData$annot)
```

```
## LineagePulse for count data: v1.2.1
```

```
## --- Data preprocessing
```

```
## # 0 out of 100 cells did not have a continuous covariate and were excluded.
```

```
## # 0 out of 30 genes did not contain non-zero observations and are excluded from analysis.
```

```
## # 0 out of 100 cells did not contain non-zero observations and are excluded from analysis.
```

```
## --- Compute normalisation constants:
```

```
## # All size factors are set to one.
```

```
## --- Fit ZINB model for both H1 and H0.
```

```
## ### a) Fit ZINB model A (H0: mu=constant disp=constant) with noise model.
```

```
## #  .   Initialisation: ll -25190.1325634718
```

```
## # 1.  Iteration with ll   -13306.2971010603 in 0.02 min.
```

```
## # 2.  Iteration with ll   -13280.9433796012 in 0.03 min.
```

```
## # 3.  Iteration with ll   -13280.9433462211 in 0.02 min.
```

```
## Finished fitting zero-inflated negative binomial model A with noise model in 0.09 min.
```

```
## ### b) Fit ZINB model B (H1: mu=splines disp=constant).
```

```
## #  .   Initialisation: ll -14638.5981222956
```

```
## # 1.  Iteration with ll   -12740.3313963124 in 0.02 min.
```

```
## Finished fitting zero-inflated negative binomial model B in 0.03 min.
```

```
## ### c) Fit NB model A (H0: mu=constant disp=constant).
```

```
## #  .   Initialisation: ll -14447.7102607632
```

```
## # 1.  Iteration with ll   -14221.9209614956 in 0.01 min.
```

```
## Finished fitting NB model B in 0.02 min.
```

```
## ### d) Fit NB model B (H1: mu=splines disp=constant).
```

```
## #  .   Initialisation: ll -14662.1528733984
```

```
## # 1.  Iteration with ll   -14101.4004149343 in 0.02 min.
```

```
## Finished fitting NB model B in 0.03 min.
```

```
## Time elapsed during ZINB fitting: 0.19 min
```

```
## --- Run differential expression analysis.
```

```
## Finished runLineagePulse().
```

```
head(objLP$dfResults)
```

```
##          gene            p        padj   mean_H0         p_nb   padj_nb
## gene_1 gene_1 0.7557547744 0.944693468 15.588858 0.7557547744 0.9997173
## gene_2 gene_2 0.2432611735 0.405435289  3.060222 0.2432611735 0.8984204
## gene_3 gene_3 0.0005058157 0.001167267  8.930052 0.0005058157 0.9997173
## gene_4 gene_4 0.4496252855 0.613125389 31.689948 0.4496252855 0.9997173
## gene_5 gene_5 0.9896928925 1.000000000 33.710373 0.9896928925 0.9997173
## gene_6 gene_6 0.8649151229 0.997978988 24.980004 0.8649151229 0.9997173
##        df_full_zinb df_red_zinb df_full_nb df_red_nb loglik_full_zinb
## gene_1            7           2          7         2        -375.7548
## gene_2            7           2          7         2        -201.2241
## gene_3            7           2          7         2        -304.5651
## gene_4            7           2          7         2        -444.6015
## gene_5            7           2          7         2        -405.5557
## gene_6            7           2          7         2        -379.1557
##        loglik_red_zinb loglik_full_nb loglik_red_nb allZero
## gene_1       -377.0733      -375.8357     -377.1611   FALSE
## gene_2       -204.5782      -203.0706     -206.4477   FALSE
## gene_3       -315.6045      -305.2326     -306.4513   FALSE
## gene_4       -446.9668      -444.7911     -447.1600   FALSE
## gene_5       -405.8365      -443.0119     -443.0769   FALSE
## gene_6       -380.0978      -403.7465     -404.4986   FALSE
```

In addition to the raw p-values, one may be interested in further details of the expression models such as shape of the expression mean as a function of pseudotime, log fold changes (LFC) and global expression trends as function of pseudotime.
We address each of these follow-up questions with separate sections in the following.
Note that all of these follow-up questions are answered based on the model that were fit to compute the p-value of differential expression.
Therefore, once runLineagePulse() was called once, no further model fitting is required.

# Further inspection of results
## Plot gene-wise trajectories

Multiple options are available for gene-wise expression trajectory plotting:
Observations can be coloured by the posterior probability of drop-out (boolColourByDropout).
Observations can be normalized based on the alternative expression model
or taken as raw observerations for the scatter plot (boolH1NormCounts).
Lineage contours can be added to aid visual interpretation of non-uniform population density in pseudotime related effects (boolLineageContour).
Log counts can be displayed instead of counts if the fold changes are large (boolLogPlot).
In any case, the output object of the gene-wise expression trajectors plotting function plotGene
is a ggplot2 object which can then be printed or modified.

```
# plot the gene with the lowest p-value of differential expression
gplotExprProfile <- plotGene(
objLP = objLP, boolLogPlot = FALSE,
strGeneID = objLP$dfResults[which.min(objLP$dfResults$p),]$gene,
boolLineageContour = FALSE)
gplotExprProfile
```

![](data:image/png;base64...)

The function plotGene also shows the H1 model fit under a negative binomial noise model (“H1(NB)”) as a reference to show what the model fit looks like if drop-out is not accounted for.

## 2.1 Manual analysis of expression trajectories

LineagePulse provides the user with parameter extraction functions that allow the user to interact directly with the raw model fits for analytic tasks or questions not addressed above.

```
# extract the mean parameter fits per cell of the gene with the lowest p-value.
matMeanParamFit <- getFitsMean(
    lsMuModel = lsMuModelH1(objLP),
    vecGeneIDs = objLP$dfResults[which.min(objLP$dfResults$p),]$gene)
cat("Minimum fitted mean parameter: ", round(min(matMeanParamFit),1) )
```

```
## Minimum fitted mean parameter:  87.4
```

```
cat("Mean fitted mean parameter: ", round(mean(matMeanParamFit),1) )
```

```
## Mean fitted mean parameter:  259.8
```

## 2.2 Fold changes

Given a discrete population structure, such as tSNE cluster or experimental conditions, a fold change is the ratio of the mean expression value of both groups.
The definition of a fold change is less clear if a continous expression trajector is considered:
Of interest may be for example the fold change from the first to the last cell on the expression trajectory or from the minimum to the maximum expression value.
Note that in both cases, we compute fold changes on the model fit of the expression mean parameter which is corrected for noise and therefore more stable than the estimate based on the raw expression count observation.

```
# first, extract the model fits for a given gene again
vecMeanParamFit <- getFitsMean(
    lsMuModel = lsMuModelH1(objLP),
    vecGeneIDs = objLP$dfResults[which.min(objLP$dfResults$p),]$gene)
# compute log2-fold change from first to last cell on trajectory
idxFirstCell <- which.min(dfAnnotationProc(objLP)$pseudotime)
idxLastCell <- which.max(dfAnnotationProc(objLP)$pseudotime)
cat("LFC first to last cell on trajectory: ",
    round( (log(vecMeanParamFit[idxLastCell]) -
                log(vecMeanParamFit[idxFirstCell])) / log(2) ,1) )
```

```
## LFC first to last cell on trajectory:
```

```
# compute log2-fold change from minimum to maximum value of expression trajectory
cat("LFC minimum to maximum expression value of model fit: ",
    round( (log(max(vecMeanParamFit)) -
                log(min(vecMeanParamFit))) / log(2),1) )
```

```
## LFC minimum to maximum expression value of model fit:  2.2
```

## 2.3 Global expression profiles

Global expression profiles or expression profiles across large groups of genes can be visualised via heatmaps of expression z-scores.
One could extract the expression mean parameter fits as described above and create such heatmaps from scratch.
LineaegePulse also offers a wrapper for creating such a heatmap:

```
# create heatmap with all differentially expressed genes
lsHeatmaps <- sortGeneTrajectories(
    vecIDs = objLP$dfResults[which(objLP$dfResults$padj < 0.01),]$gene,
    lsMuModel = lsMuModelH1(objLP),
    dirHeatmap=NULL)
print(lsHeatmaps$hmGeneSorted)
```

![](data:image/png;base64...)

# 3 Session information

```
sessionInfo()
```

```
## R version 3.5.2 (2018-12-20)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] LineagePulse_1.2.1 BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.0                  lattice_0.20-38
##  [3] circlize_0.4.5              gtools_3.8.1
##  [5] assertthat_0.2.0            digest_0.6.18
##  [7] SingleCellExperiment_1.4.1  R6_2.3.0
##  [9] GenomeInfoDb_1.18.1         plyr_1.8.4
## [11] stats4_3.5.2                evaluate_0.12
## [13] ggplot2_3.1.0               pillar_1.3.1
## [15] gplots_3.0.1                GlobalOptions_0.1.0
## [17] zlibbioc_1.28.0             rlang_0.3.0.1
## [19] lazyeval_0.2.1              gdata_2.18.0
## [21] S4Vectors_0.20.1            GetoptLong_0.1.7
## [23] Matrix_1.2-15               rmarkdown_1.11
## [25] labeling_0.3                splines_3.5.2
## [27] BiocParallel_1.16.5         stringr_1.3.1
## [29] RCurl_1.95-4.11             munsell_0.5.0
## [31] DelayedArray_0.8.0          compiler_3.5.2
## [33] xfun_0.4                    pkgconfig_2.0.2
## [35] BiocGenerics_0.28.0         shape_1.4.4
## [37] htmltools_0.3.6             tidyselect_0.2.5
## [39] SummarizedExperiment_1.12.0 tibble_2.0.0
## [41] GenomeInfoDbData_1.2.0      bookdown_0.9
## [43] IRanges_2.16.0              matrixStats_0.54.0
## [45] crayon_1.3.4                dplyr_0.7.8
## [47] bitops_1.0-6                grid_3.5.2
## [49] gtable_0.2.0                magrittr_1.5
## [51] scales_1.0.0                KernSmooth_2.23-15
## [53] stringi_1.2.4               XVector_0.22.0
## [55] bindrcpp_0.2.2              rjson_0.2.20
## [57] RColorBrewer_1.1-2          tools_3.5.2
## [59] Biobase_2.42.0              glue_1.3.0
## [61] purrr_0.2.5                 parallel_3.5.2
## [63] yaml_2.2.0                  colorspace_1.3-2
## [65] BiocManager_1.30.4          GenomicRanges_1.34.0
## [67] caTools_1.17.1.1            ComplexHeatmap_1.20.0
## [69] knitr_1.21                  bindr_0.1.1
```