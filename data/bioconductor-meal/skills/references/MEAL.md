# Methylation Analysis with MEAL

Carlos Ruiz1,2 and Juan R. González1,2\*

1ISGlobal, Centre for Research in Environmental Epidemiology (CREAL), Barcelona, Spain
2Bioinformatics Research Group in Epidemiology

\*juanr.gonzalez@isglobal.org

#### 30 October 2025

#### Package

MEAL 1.40.0

# 1 Introduction

Illumina Infinium HumanMethylation 450K BeadChip assay has become a standard tool to analyse methylation in human samples. Developed in 2011, it has already been used in projects such as The Cancer Genome Atlas (TCGA). Their 450.000 probes provide a good overall image of the methylation state of the genome, being one of the reasons of its success.

Given its complex design111 More information can be found at this [minfi tutorial](http://www.bioconductor.org/help/course-materials/2014/BioC2014/minfi_BioC2014.pdf), many Bioconductor packages have been developed to assess normalization and pre-processing issues (e.g. *[minfi](https://bioconductor.org/packages/3.22/minfi)* (Aryee et al. [2014](#ref-Aryee2014)) or *[lumi](https://bioconductor.org/packages/3.22/lumi)* (Du, Kibbe, and Lin [2008](#ref-Du2008))). In addition, these packages can detect differentially methylated probes (DMPs) and differentially methylated regions (DMRs). However, the interfaces are not very intuitive and several scripting steps are usually required.

*[MEAL](https://bioconductor.org/packages/3.22/MEAL)* aims to facilitate the analysis of Illumina Methylation 450K chips. We have included two methods to analyze DMPs (Differentially Methylated Probes), that test differences in means (limma) or differences in variance (DiffVar). We have included three DMRs (Differentially Methylated Regions) detection algorithms (bumphunter, blockFinder and DMRcate) and a new method to test differences in methylation in a target region (RDA). Finally, we have prepared plots for all these analyses as well as a wrapper to run all the analyses in the same dataset.

# 2 Input data

*[MEAL](https://bioconductor.org/packages/3.22/MEAL)* is meant to analyze methylation data already preprocessed. All our functions accept a `GenomicRatioSet` as input, which is a class from *[minfi](https://bioconductor.org/packages/3.22/minfi)* package designed to manage preprocessed methylation data. Users willing to preprocess their own data are encouraged to take a look to [minfi’s vignette](http://bioconductor.org/packages/release/bioc/vignettes/minfi/inst/doc/minfi.pdf)

In this vignette, we will use methylation data from *[minfiData](https://bioconductor.org/packages/3.22/minfiData)* package.

```
library(MEAL)
library(MultiDataSet)
library(minfiData)
library(minfi)
library(ggplot2)

data("MsetEx")
```

`MsetEx` is a `MethylationRatioSet` that contains measurements for 485512 CpGs and 6 samples, as well as some phenotypic variables such as age or sex. The first step will be to convert it to a `GenomicRatioSet`. Then, we will add some extra features annotation. Finally, we will remove probes not measuring methylation, with SNPs or with NAs. For the sake of speed, we will select a subset of CpGs:

```
meth <- mapToGenome(ratioConvert(MsetEx))
rowData(meth) <- getAnnotation(meth)[, -c(1:3)]

## Remove probes measuring SNPs
meth <- dropMethylationLoci(meth)

## Remove probes with SNPs
meth <- dropLociWithSnps(meth)

## Remove probes with NAs
meth <- meth[!apply(getBeta(meth), 1, function(x) any(is.na(x))), ]

## Select a subset of samples
set.seed(0)
meth <- meth[sample(nrow(meth), 100000), ]
```

# 3 Analyzing Methylation data

## 3.1 Pipeline

The function `runPipeline` run all methods included in *[MEAL](https://bioconductor.org/packages/3.22/MEAL)* to the same dataset. We only need to pass to this function a `GenomicRatioSet` and the name of our variable of interest. In our case, we will analyze the effect of cancer on methylation:

```
res <- runPipeline(set = meth, variable_names = "status")
```

`runPipeline` includes several parameters to customize the analyses. The most important parameters are `covariable_names`, `betas` and `sva`. `covariable_names` is used to include covariates in our models. `betas` allows the user choosing between running the analyis with beta (TRUE) or M-values (FALSE). If `sva` is TRUE, Surrogate Variable Analysis is run and surrogate variables are included in the models. Finally, some parameters modify the behaviour of the methods included in the wrapper and they will be covered later on. More information about the parameters can be found in the documentation (by typing ?runPipeline).

We will run a new analysis including age as covariate:

```
resAdj <- runPipeline(set = meth, variable_names = "status",
                      covariable_names = "age", analyses = c("DiffMean", "DiffVar"))
resAdj
```

```
## Object of class 'ResultSet'
##  . created with: runPipeline
##  . sva:  no
##  . #results: 2 ( error: 0 )
##  . featureData: 100000 probes x 35 variables
```

## 3.2 Managing the results

`runPipeline` generates a `ResultSet` object. `ResultSet` is a class designed to encapsulate different results from the same dataset. It contains the results of the different methods, the feature data and other data required to get tables or plots. We can examine the analyses included in a `ResultSet` with the function `names`:

```
names(resAdj)
```

```
## [1] "DiffMean" "DiffVar"
```

Both objects contains five analyses. DiffMean is an analysis of difference of means performed with *[limma](https://bioconductor.org/packages/3.22/limma)* while the others are named with the method name (DiffVar, bumphunter, blockFinder and dmrcate).

We can use the function `getAssociation` to get a data.frame with the results, independent of the original method. This function has two main arguments: `object` and `rid`. `object` is the `ResultSet` with our data and `rid` is the name or the index of the analysis we want to extract.

```
head(getAssociation(resAdj, "DiffMean"))
```

```
##                 logFC       CI.L       CI.R   AveExpr         t      P.Value
## cg09383816 -0.5938196 -0.6310536 -0.5565855 0.4885486 -42.93778 7.098649e-07
## cg26729197 -0.5779628 -0.6186821 -0.5372435 0.3630791 -38.21419 1.176118e-06
## cg19333963 -0.6532176 -0.7032282 -0.6032071 0.4092923 -35.16587 1.685708e-06
## cg09150117 -0.6045812 -0.6509778 -0.5581846 0.4853409 -35.08275 1.703065e-06
## cg13307451 -0.5417324 -0.5838896 -0.4995751 0.3924193 -34.59696 1.809029e-06
## cg19859781  0.4257460  0.3904540  0.4610380 0.5983762  32.47878 2.377898e-06
##             adj.P.Val        B         SE
## cg09383816 0.01629257 5.595805 0.03090437
## cg26729197 0.01629257 5.410263 0.02239892
## cg19333963 0.01629257 5.258877 0.07809844
## cg09150117 0.01629257 5.254326 0.04401591
## cg13307451 0.01629257 5.227227 0.01771050
## cg19859781 0.01629257 5.098421 0.07097404
```

```
head(getAssociation(resAdj, "DiffVar"))
```

```
##                logFC      CI.L       CI.R   AveExpr         t      P.Value
## cg11847929 -2.327910 -3.146772 -1.5090476 1.4656792 -6.813262 0.0003320046
## cg06265760 -1.730019 -2.362333 -1.0977058 0.9442413 -6.557196 0.0004149426
## cg02076607 -1.541192 -2.106092 -0.9762907 1.1829703 -6.538591 0.0004218303
## cg05635754 -2.438282 -3.333548 -1.5430149 1.2934636 -6.527263 0.0004260870
## cg22891595 -1.525000 -2.085639 -0.9643620 0.9589610 -6.519089 0.0004291892
## cg01287975 -1.881061 -2.575312 -1.1868104 0.9752451 -6.493611 0.0004390231
##            adj.P.Val          B         SE
## cg11847929 0.1787794 0.23218162 0.10537499
## cg06265760 0.1787794 0.08995047 0.09685284
## cg02076607 0.1787794 0.07929272 0.16051859
## cg05635754 0.1787794 0.07278219 0.12877918
## cg22891595 0.1787794 0.06807333 0.16428448
## cg01287975 0.1787794 0.05334128 0.15043591
```

DiffMean and DiffVar are internally stored as a MArrayLM, the class from *[limma](https://bioconductor.org/packages/3.22/limma)* results. This class allows testing different constrasts or evaluating different variables simultaneously. The function `getProbeResults` helps the user performing these operations. It also has the arguments `object` and `rid` from `getAssociation`. `coef` is a numeric with the index of the coefficient from which we want the results. If we did not pass a custom model to `runPipeline`, the first coefficient (coef = 1) is the intercept and the second coefficient (coef = 2) is the first variable that we included in `variable_names`. We can evaluate different coefficients simultaneously by passing a vector to `coef`. `contrast` is a matrix with the contrasts that we want to evaluate. This option is useful when our variable of interest is a factor with several levels and we want to do all the different comparisons. Finally, the argument `fNames` is used to select the variables from features annotation that will be added to the tables.

To exemplify the use of this function, we will evaluate our whole adjusted model, including age coefficient. We will also add some annotation of the CpGs:

```
head(getProbeResults(resAdj, rid = 1, coef = 2:3,
                     fNames = c("chromosome", "start")))
```

```
##            statusnormal           age   AveExpr        F      P.Value
## cg09383816   -0.5938196 -0.0026657333 0.4885486 929.9010 1.924508e-06
## cg26729197   -0.5779628 -0.0005001219 0.3630791 730.3999 3.246391e-06
## cg13307451   -0.5417324 -0.0064613777 0.3924193 635.4818 4.387672e-06
## cg09150117   -0.6045812  0.0032853408 0.4853409 623.2986 4.575331e-06
## cg19333963   -0.6532176  0.0019529459 0.4092923 620.7215 4.616527e-06
## cg19859781    0.4257460 -0.0020866765 0.5983762 532.9428 6.419871e-06
##             adj.P.Val SE.statusnormal       SE.age chromosome    start
## cg09383816 0.04313762    0.0309043657 0.0014823190       chr8 67344556
## cg26729197 0.04313762    0.0223989196 0.0010743577      chr17 71161415
## cg13307451 0.04313762    0.0780984369 0.0037459690      chr10 22541442
## cg09150117 0.04313762    0.0440159139 0.0021112106       chr7 96653867
## cg19333963 0.04313762    0.0177105042 0.0008494792      chr19  1467979
## cg19859781 0.04313762    0.0709740354 0.0034042491      chr13 40174685
```

When more than one coefficient is evaluated, a estimate for each coefficient is returned and the t-statistic is substituted by a F-statistic. More information about linear models, including a detailed section of how to create a constrast matrix can be found in [limma users’ guide](https://bioconductor.org/packages/release/bioc/vignettes/limma/inst/doc/usersguide.pdf).

Finally, we can obtain the results of CpGs mapped to some genes with the function `getGeneVals`. This function accepts the same arguments than `getProbeResults` but includes the arguments `gene` and `genecol` to pass the names of the genes to be selected and the column name of feature data containing gene names.

We will retrieve the difference in variance results for all CpGs mapped to ARMS2. We can see in the rowData of `meth` that gene names are in the column ‘UCSC\_RefGene\_Name’:

```
getGeneVals(resAdj, "ARMS2", genecol = "UCSC_RefGene_Name", fNames = c("chromosome", "start"))
```

```
##                logFC        CI.L      CI.R   AveExpr        t    P.Value
## cg00676728 0.1106853  0.01259430 0.2087763 0.8206485 3.037987 0.03458282
## cg18222240 0.1874701 -0.01570234 0.3906426 0.5432686 2.484233 0.06300344
##            adj.P.Val         B         SE chromosome     start
## cg00676728 0.1946025 -4.130757 0.01303783      chr10 124213760
## cg18222240 0.2718642 -4.801220 0.02864301      chr10 124213527
##            UCSC_RefGene_Name
## cg00676728             ARMS2
## cg18222240             ARMS2
```

## 3.3 Plotting the results

We can easily get Manhattan plots, Volcano plots and QQ-plots for the probes results (DiffMean and DiffVar) using `plot` method. Our extension of `plot` method to `ResultSet` includes the arguments `rid` or `coef` that were already present in `getProbeResult`. In addition, the argument `type` allows choosing between a Manhattan plot (“manhattan”), a Volcano plot (“volcano”) or a qq-plot (“qq”).

### 3.3.1 Manhattan plot

We can customize different aspects of a Manhattan plot. We can highlight the CpGs of a target region by passing a `GenomicRanges` to the argument `highlight`. Similarly, we can get a Manhattan plot with only the CpGs of our target region passing a `GenomicRanges` to the argument `subset`. It should be noticed that the `GenomicRange` should have the chromosome as a number (1-24).

We will show these capabilities by highlighting and subsetting a region of ten Mb in chromosome X:

```
targetRange <- GRanges("23:13000000-23000000")
plot(resAdj, rid = "DiffMean", type = "manhattan", highlight = targetRange)
```

![](data:image/png;base64...)

```
plot(resAdj, rid = "DiffMean", type = "manhattan", subset = targetRange)
```

![](data:image/png;base64...)

We can also change the height of lines marking different levels of significance. Height of blue line can be set with `suggestiveline` parameter and red line with `genomewideline` parameter. It should be noticed that these values are expressed as -log10 of p-value. Finally, as our Manhattan plot is done with `base` framework, we can customize the plot using `base` plotting functions such as `points`, `lines` or `text` or arguments of `plot` function like `main`:

```
plot(resAdj, rid = "DiffMean", type = "manhattan", suggestiveline = 3,
     genomewideline = 6, main = "My custom Manhattan")
abline(h = 13, col = "yellow")
```

![](data:image/png;base64...)

### 3.3.2 Volcano plot

In our Volcano plot, we can also customize the thresholds for statistical significance and magnitude of the effect using the arguments `tPV` and `tFC`. As in the previous case, `tPV` is expressed as -log10 of p-value. On the other hand, `tFC` units will change depending if we used beta or M-values. `show.labels` can turn on and turn off the labelling of significant features. Finally, Volcano plot is based on *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* so we can further customize the plot adding new layers:

```
plot(resAdj, rid = "DiffMean", type = "volcano", tPV = 14, tFC = 0.4,
     show.labels = FALSE) + ggtitle("My custom Volcano")
```

![](data:image/png;base64...)

### 3.3.3 QQplot

Our QQplot include the computation of the lambda, a measure of the inflation of the p-values. We can remove this value with the parameter `show.lambda`.

Our qqplot is also based on *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* so we will add a title to customize it:

```
plot(resAdj, rid = "DiffMean", type = "qq") + ggtitle("My custom QQplot")
```

![](data:image/png;base64...)

### 3.3.4 Features

*[MEAL](https://bioconductor.org/packages/3.22/MEAL)* incorporates the function `plotFeature` to plot the beta values distribution of a CpG. `plotFeature` has three main arguments. `set` is the `GenomicRatioSet` with the methylation data. `feat` is the index or name of our target CpG. `variables` is a character vector with the names of the variables used in the plot. We can include two variables in our plot.

In the next line, we will plot a CpG with high difference in means between cases and controls (cg25104555) and a CpG with high difference in variance (cg11847929) vs cancer status. As plotFeature is based on *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)*, we can customize it:

```
plotFeature(set = meth, feat = "cg09383816", variables = "status") +
  ggtitle("Diff Means")
```

![](data:image/png;base64...)

```
plotFeature(set = meth, feat = "cg11847929", variables = "status") +
  ggtitle("Diff Vars")
```

![](data:image/png;base64...)

### 3.3.5 Regional plotting

We can simultaneously plot the different results in a target region along with gene and CpG annotation with the function `plotRegion`. This function has two main arguments. `rset` is the `ResultSet` and `range` is a `GenomicRanges` with our target region.

We will plot a region of 1 Mb in chromosome X:

```
targetRange <- GRanges("chrX:13000000-14000000")
plotRegion(resAdj, targetRange)
```

![](data:image/png;base64...)

Our plot has three main parts. The top contains the annotation of the regional genes and the CpGs included in the analysis. The middle part contains the results of the DMR detection methods (Bumphunter, blockFinder and DMRcate). The bottom part contains the results of the single probe analyses (differential mean and differential variance). Each analysis has two parts: the coefficients and the p-values. The line in the p-values plot marks the significance threshold.

By default,`plotRegion` includes all analyses run in the plot. However, we can plot only few analyses with the parameter `results`. We can also modify the height of the p-value line with the parameter `tPV` (units are -log10 of p-value):

```
plotRegion(resAdj, targetRange, results = c("DiffMean"), tPV = 10)
```

![](data:image/png;base64...)

## 3.4 Methods wrappers

*[MEAL](https://bioconductor.org/packages/3.22/MEAL)* includes wrappers to run the different methods of the pipeline individually. All these functions accept a `GenomicRatioSet` as input and can return the results in a `ResultSet`. Consequently, functionalities described in the above section for the results of the pipeline also apply for the results of a single method.

### 3.4.1 Differences of mean analysis

We can test if a phenotype causes changes in methylation means using the `runDiffMeanAnalysis`. This function is a wrapper of `lmFit` function from *[limma](https://bioconductor.org/packages/3.22/limma)* and requires two arguments: `set` and `model`. `set` contains the methylation data, either in a `GenomicRatioSet` or a matrix. `model` can be a matrix with the linear model or a formula indicating the model. In the former case, `set` must be a `GenomicRatioSet` and the variables included in the model must be present in the colData of our set.

We exemplify the use of this function by running the same linear model than in our pipeline:

```
resDM <- runDiffMeanAnalysis(set = meth, model = ~ status)
```

`runDiffMeanAnalysis` also has other parameters to customize the analysis. If `set` is a `GenomicRatioSet`, the parameter `betas` allows us choosing between betas (TRUE) and M-values (FALSE). We can also run a robust linear model changing the parameter `method` to “robust”. Finally, `resultSet` indicates if the function will return a `ResultSet` (TRUE) or a `MArrayLM` (FALSE).

All these parameters can be set in the `runPipeline` function with the argument `DiffMean_params`.

### 3.4.2 Differences of Variance analysis

We can test if a phenotype causes changes in methylation variance using the `runDiffVarAnalysis`. This function is a wrapper of `varFit` function from *[missMethyl](https://bioconductor.org/packages/3.22/missMethyl)* and requires three arguments: `set`, `model` and `coefficient`. `set` contains the methylation data in a `GenomicRatioSet`. `model` can be a matrix with the linear model or a formula indicating the model. In the former case, the variables included in the model must be present in the colData of our set. `coefficient` indicates the variables of the linear model for which the difference of variance will be computed. By default, all discrete variables will be included.

We exemplify the use of this function by running the same model than in our pipeline:

```
resDV <- runDiffVarAnalysis(set = meth, model = ~ status, coefficient = 2)
```

`runDiffVarAnalysis` also has the parameter `resultSet` that allows returning a `MArrayLM` object instead of a `ResultSet`. Finally, we can change other parameters of `varFit` function using the `...` argument. These parameters can also be set in the `runPipeline` function passing them to the argument `DiffVar_params`.

### 3.4.3 RDA

We can determine if a genomic region is differentially methylated with RDA (Redundancy Analysis). This analysis can be run with the function `runRDA` that requires three arguments: `set`, `model` and `range`. As in the previous functions, `set` is a `GenomicRatioSet` with the methylation data and `model` contains the linear model either in a matrix or in a formula. `range` is a `GenomicRanges` with the coordinates of our target region.

We will exemplify the use of this function by running `RDA` in a region of chromosome X:

```
targetRange <- GRanges("chrX:13000000-23000000")
resRDA <- runRDA(set = meth, model = ~ status, range = targetRange)
```

`runRDA` also has other parameters to customize the analysis. The parameter `betas` allows us choosing between betas (TRUE) and M-values (FALSE). `num_vars` selects the number of columns in model matrix considered as variables. The remaining columns will be considered as covariates. `num_permutations` indicates the number of permutations run to compute p-values. `resultSet` allows returning a `rda` object from *[vegan](https://CRAN.R-project.org/package%3Dvegan)* package instead of a `ResultSet`.

We can run RDA in our pipeline when we are a priori interested in a target genomic range. In this case, we will pass our target region to the argument `range` of `runPipeline`. We can pass other parameters of `runRDA` using the argument `rda_params`.

#### 3.4.3.1 Managing and plotting RDA results

We can retrieve RDA results using the function `getAssociation`:

```
getAssociation(resRDA, rid = "RDA")
```

```
##
## Call: rda(X = t(mat), Y = varsmodel, Z = covarsmodel)
##
##                Inertia Proportion Rank
## Total         260.3301     1.0000
## Constrained    26.9344     0.1035    1
## Unconstrained 233.3957     0.8965    4
##
## Inertia is variance
##
## -- NOTE:
## Some constraints or conditions were aliased because they were redundant.
## This can happen if terms are constant or linearly dependent (collinear):
## '(Intercept)'
##
## Eigenvalues for constrained axes:
##   RDA1
## 26.934
##
## Eigenvalues for unconstrained axes:
##    PC1    PC2    PC3    PC4
## 191.62  24.28  12.83   4.66
```

RDA results are encapsulated in a rda object from *[vegan](https://CRAN.R-project.org/package%3Dvegan)* package. We can get a summary of RDA results with the function `getRDAresults`:

```
getRDAresults(resRDA)
```

```
##          R2        pval   global.R2 global.pval
##   0.1034627   0.5000000   0.4226856   1.0000000
```

This function returns four values: R2, pval, global.R2 and global.pval. R2 is the ammount of variance that the model explains in our target region. pval is the probability of finding this ammount of variance of higher by change. global.R2 is the ammount of variance that our model explains in the whole genome. global.pval is the probability of finding a region with the same number of probes explaining the same or more variance than our target region. With these values, we can determine if our target region is differentially methylated and if this phenomena is local or global.

The function `topRDAhits` returns a data.frame with features associated to first two RDA components. This functions computes a Pearson correlation test between the methylation values and the RDA components. Only CpGs with a p-value lower than `tPV` parameter (by default 0.05) with any of the components are included in the data.frame:

```
topRDAhits(resRDA)
```

```
## [1] feat      RDA       cor       P.Value   adj.P.Val
## <0 rows> (or 0-length row.names)
```

Finally, we can plot the first two dimensions of our RDA with the function `plotRDA`. This function makes a biplot of samples and features. We can color the samples using categorical variables by passing in a data.frame to argument `pheno`.

We will plot RDA using status variable of our sets colData:

```
plotRDA(object = resRDA, pheno = colData(meth)[, "status", drop = FALSE])
```

![](data:image/png;base64...)

The RDA plot prints a label at the center of each group and the summary of RDA results (R2 and p-value) in the legend. `plotRDA` has two additional arguments. `main` is a character vector with the plot’s title. `n_feat` is a numeric with the number of feats that will have a label in the text. Only the `n_feat` features most associated to each of the components will be displayed.

`plotRDA` relies on `base` paradigm, so we can add layers using functions from this infrastructure (e.g. `lines`, `points`…):

```
plotRDA(object = resRDA, pheno = colData(meth)[, "status", drop = FALSE])
abline(h = -1)
```

![](data:image/png;base64...)

# 4 Session Info

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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] ggplot2_4.0.0
##  [2] minfiData_0.55.0
##  [3] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
##  [4] IlluminaHumanMethylation450kmanifest_0.4.0
##  [5] minfi_1.56.0
##  [6] bumphunter_1.52.0
##  [7] locfit_1.5-9.12
##  [8] iterators_1.0.14
##  [9] foreach_1.5.2
## [10] Biostrings_2.78.0
## [11] XVector_0.50.0
## [12] SummarizedExperiment_1.40.0
## [13] MatrixGenerics_1.22.0
## [14] matrixStats_1.5.0
## [15] GenomicRanges_1.62.0
## [16] Seqinfo_1.0.0
## [17] IRanges_2.44.0
## [18] S4Vectors_0.48.0
## [19] MEAL_1.40.0
## [20] MultiDataSet_1.38.0
## [21] Biobase_2.70.0
## [22] BiocGenerics_0.56.0
## [23] generics_0.1.4
## [24] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1
##   [2] BiocIO_1.20.0
##   [3] filelock_1.0.3
##   [4] bitops_1.0-9
##   [5] tibble_3.3.0
##   [6] preprocessCore_1.72.0
##   [7] rpart_4.1.24
##   [8] XML_3.99-0.19
##   [9] httr2_1.2.1
##  [10] lifecycle_1.0.4
##  [11] ensembldb_2.34.0
##  [12] lattice_0.22-7
##  [13] MASS_7.3-65
##  [14] base64_2.0.2
##  [15] scrime_1.3.5
##  [16] backports_1.5.0
##  [17] magrittr_2.0.4
##  [18] Hmisc_5.2-4
##  [19] limma_3.66.0
##  [20] sass_0.4.10
##  [21] rmarkdown_2.30
##  [22] jquerylib_0.1.4
##  [23] yaml_2.3.10
##  [24] doRNG_1.8.6.2
##  [25] askpass_1.2.1
##  [26] Gviz_1.54.0
##  [27] DBI_1.2.3
##  [28] RColorBrewer_1.1-3
##  [29] abind_1.4-8
##  [30] quadprog_1.5-8
##  [31] purrr_1.1.0
##  [32] AnnotationFilter_1.34.0
##  [33] biovizBase_1.58.0
##  [34] RCurl_1.98-1.17
##  [35] nnet_7.3-20
##  [36] VariantAnnotation_1.56.0
##  [37] rappdirs_0.3.3
##  [38] rentrez_1.2.4
##  [39] genefilter_1.92.0
##  [40] vegan_2.7-2
##  [41] annotate_1.88.0
##  [42] permute_0.9-8
##  [43] DelayedMatrixStats_1.32.0
##  [44] codetools_0.2-20
##  [45] DelayedArray_0.36.0
##  [46] xml2_1.4.1
##  [47] tidyselect_1.2.1
##  [48] UCSC.utils_1.6.0
##  [49] farver_2.1.2
##  [50] beanplot_1.3.1
##  [51] base64enc_0.1-3
##  [52] BiocFileCache_3.0.0
##  [53] illuminaio_0.52.0
##  [54] GenomicAlignments_1.46.0
##  [55] jsonlite_2.0.0
##  [56] multtest_2.66.0
##  [57] Formula_1.2-5
##  [58] survival_3.8-3
##  [59] progress_1.2.3
##  [60] missMethyl_1.44.0
##  [61] tools_4.5.1
##  [62] Rcpp_1.1.0
##  [63] glue_1.8.0
##  [64] gridExtra_2.3
##  [65] SparseArray_1.10.0
##  [66] xfun_0.53
##  [67] mgcv_1.9-3
##  [68] GenomeInfoDb_1.46.0
##  [69] dplyr_1.1.4
##  [70] HDF5Array_1.38.0
##  [71] withr_3.0.2
##  [72] BiocManager_1.30.26
##  [73] fastmap_1.2.0
##  [74] latticeExtra_0.6-31
##  [75] rhdf5filters_1.22.0
##  [76] openssl_2.3.4
##  [77] digest_0.6.37
##  [78] R6_2.6.1
##  [79] colorspace_2.1-2
##  [80] jpeg_0.1-11
##  [81] biomaRt_2.66.0
##  [82] dichromat_2.0-0.1
##  [83] RSQLite_2.4.3
##  [84] cigarillo_1.0.0
##  [85] h5mread_1.2.0
##  [86] tidyr_1.3.1
##  [87] calibrate_1.7.7
##  [88] data.table_1.17.8
##  [89] rtracklayer_1.70.0
##  [90] htmlwidgets_1.6.4
##  [91] prettyunits_1.2.0
##  [92] httr_1.4.7
##  [93] S4Arrays_1.10.0
##  [94] pkgconfig_2.0.3
##  [95] gtable_0.3.6
##  [96] IlluminaHumanMethylationEPICanno.ilm10b4.hg19_0.6.0
##  [97] blob_1.2.4
##  [98] S7_0.2.0
##  [99] siggenes_1.84.0
## [100] htmltools_0.5.8.1
## [101] bookdown_0.45
## [102] ProtGenerics_1.42.0
## [103] scales_1.4.0
## [104] png_0.1-8
## [105] rstudioapi_0.17.1
## [106] knitr_1.50
## [107] tzdb_0.5.0
## [108] rjson_0.2.23
## [109] checkmate_2.3.3
## [110] nlme_3.1-168
## [111] curl_7.0.0
## [112] org.Hs.eg.db_3.22.0
## [113] cachem_1.1.0
## [114] rhdf5_2.54.0
## [115] stringr_1.5.2
## [116] foreign_0.8-90
## [117] AnnotationDbi_1.72.0
## [118] restfulr_0.0.16
## [119] GEOquery_2.78.0
## [120] pillar_1.11.1
## [121] grid_4.5.1
## [122] reshape_0.8.10
## [123] vctrs_0.6.5
## [124] dbplyr_2.5.1
## [125] xtable_1.8-4
## [126] cluster_2.1.8.1
## [127] htmlTable_2.4.3
## [128] evaluate_1.0.5
## [129] qqman_0.1.9
## [130] readr_2.1.5
## [131] tinytex_0.57
## [132] GenomicFeatures_1.62.0
## [133] magick_2.9.0
## [134] cli_3.6.5
## [135] compiler_4.5.1
## [136] Rsamtools_2.26.0
## [137] rlang_1.1.6
## [138] crayon_1.5.3
## [139] rngtools_1.5.2
## [140] labeling_0.4.3
## [141] nor1mix_1.3-3
## [142] interp_1.1-6
## [143] mclust_6.1.1
## [144] plyr_1.8.9
## [145] stringi_1.8.7
## [146] deldir_2.0-4
## [147] BiocParallel_1.44.0
## [148] lazyeval_0.2.2
## [149] Matrix_1.7-4
## [150] BSgenome_1.78.0
## [151] hms_1.1.4
## [152] sparseMatrixStats_1.22.0
## [153] bit64_4.6.0-1
## [154] Rhdf5lib_1.32.0
## [155] KEGGREST_1.50.0
## [156] statmod_1.5.1
## [157] memoise_2.0.1
## [158] bslib_0.9.0
## [159] bit_4.6.0
```

# References

Aryee, Martin J, Andrew E Jaffe, Hector Corrada-Bravo, Christine Ladd-Acosta, Andrew P Feinberg, Kasper D Hansen, and Rafael A Irizarry. 2014. “Minfi: a flexible and comprehensive Bioconductor package for the analysis of Infinium DNA methylation microarrays.” *Bioinformatics (Oxford, England)* 30 (10): 1363–9. <https://doi.org/10.1093/bioinformatics/btu049>.

Du, Pan, Warren A Kibbe, and Simon M Lin. 2008. “lumi: a pipeline for processing Illumina microarray.” *Bioinformatics (Oxford, England)* 24 (13): 1547–8. <https://doi.org/10.1093/bioinformatics/btn224>.