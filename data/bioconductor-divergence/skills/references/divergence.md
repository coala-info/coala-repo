# Performing Divergence Analysis

## Wikum Dinalankara, Luigi Marchionni, Qian Ke

\section{Introduction}

Recently in [Dinalankara 2018](#ref-dinalankara2018digitizing) we introduced divergence analysis, a framework for analysing high dimensional omics data. The principle behind this approach is to simulate a clinical test which tests for deviation from a normal profile as a marker of some abnormal condition. Given a matrix of high dimensional omics data (RNA-Seq expression, microarray expression, CpG level methylation, etc) where one group of samples are designated as the baseline cohort, the other sample profiles can be converted to a binary or ternary string indicating whether each omics feature of the sample is outside the baseline range or not. This can be performed at the individual feature level (in which case the result will be a string of 0, 1, and -1 indicating no divergence, deviation by being above the baseline range, and deviation by being below the baseline range, respectively), or it can be perfomed at the multivariate feature level. Multivariate features are sets of single features (e.g. a functional gene set) and if divergence analysis is performed at this level, the result will be binary (0 indicating no deviation, 1 indicating deviation).

As we will see, the method is simple to work with. The method applies no special normalization procedures other than a sample specific quantile transformation which is applied to each sample before baseline computation and divergence coding. There are two paramters, \(\gamma\) and \(\beta\) that can be tuned during baseline computation. For more information about how the method works, see [Dinalankara 2018](#ref-dinalankara2018digitizing).

The package contains a small data set, which we will use here to demonstrate the workflow. The fololowing objects are included in the package:

* \textit{breastTCGA\_Mat}: This is a matrix of 260 genes and 887 samples of breast RNA-Seq data selected from the TCGA breast cancer cohort. The samples contain normals and primary tumors of both ER positive and negative subtypes. The values are gene level expression estimates in TPM (transcripts per million) format.
* \textit{breastTCGA\_Group}: This is a factor indicating whether each of the 887 samples mentioned above are normal or tumor.
* \textit{breastTCGA\_ER}: This is a factor indicating whether the tumor samples are ER positive or ER negative.
* \textit{msigdb\_Hallmarks}: This is a list of 10 gene sets, a subset of the hallmark functional get set collection from the MSigDB database[Liberzon 2011](#ref-liberzon2011molecular). We will use these 10 gene sets to demonstrate the multivariate divergence workflow.

We will use these objects throughout the following sections.

\section{Prepare Data}

The data preparation step is fairly straightforward, and involves deciding which samples will be used as the baseline, and which samples will be used as the main data that will be converted to the divergence form.

We will use the normal samples from the brest TCGA data set as our baseline cohort, and the tumor samples will be digitized with respect to this normal baseline.

We can prepare the baseline and data matrices, though this is strictly not necessary (as any preparations can be done on-the-fly as they are submitted to the functions). You may perform any other pre-processing or normalizing steps you would like to the data if deemed necessary depending on the experiment.

Note that we use the SummarizedExperiment container for matrix data, where the original data, quantile transformed data and divergence coding can be maintained together.

```
# load divergence package
library(divergence)
```

```
## Loading required package: SummarizedExperiment
```

```
## Loading required package: MatrixGenerics
```

```
## Loading required package: matrixStats
```

```
##
## Attaching package: 'MatrixGenerics'
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
##     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
##     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
##     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
##     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
##     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
##     colWeightedMeans, colWeightedMedians, colWeightedSds,
##     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
##     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
##     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
##     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
##     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
##     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
##     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
##     rowWeightedSds, rowWeightedVars
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
##
## Attaching package: 'Biobase'
```

```
## The following object is masked from 'package:MatrixGenerics':
##
##     rowMedians
```

```
## The following objects are masked from 'package:matrixStats':
##
##     anyMissing, rowMedians
```

```
# baseline cohort
mat.base = breastTCGA_Mat[, which(breastTCGA_Group == "NORMAL")]
# make SummarizedExperiment
seMat.base = SummarizedExperiment(assays=list(data=mat.base))

# data conort
mat.data = breastTCGA_Mat[, which(breastTCGA_Group == "TUMOR")]
# make SummarizedExperiment
seMat = SummarizedExperiment(assays=list(data=mat.data))
```

When creating the SummarizedExperiment object, use assay labeles ‘data’ for the original data and ‘quantile’ for quantile data (if the quantile transformation is being performed manually).

\section{Univariate Divergence}

Figure 1 shows the univariate workflow. As shown in the figure, there are three alternative routes the user can take. On one hand, the user can use the computeQuantileMatrix() function to convert the data (both the baseline data and the data to be digitized) to quantile form, and then use the computeUnivariateSupport() function to compute the baseline support if the \(\gamma\) paramter (labeled ‘gamma’ in the package functions) to use is already known, or alternatively findUnivariateGammaWithSupport() function can be used to compute the baseline which will select the best \(\gamma\) value from a given list. Then the computeUnivariateTernaryMatrix() function can be used to digitize the data with the baseline computed in this manner.

Or more simply, the user can use the computeUnivariateDigitization() function and supply the baseline data and the data to be digitized, and this function will perform the quantile transformation and the \(\gamma\) search and perform the digitization.

![Univariate workflow](data:image/jpeg;base64...)

To demonstrate, we start by applying the quantile transformation to our prepared baseline reference samples and our data samples. This is performed using the computeQuantileMatrix() function which takes a data matrix as input and outputs a data matrix of the same dimensions with each sample converted to a quantile. However, since the quantile transformation is a sample-wise operation you can supply one sample at a time if needed - i.e. it is not necessary to have all the required data in your analysis beforehand.

```
# convert normal data to quantiles
assays(seMat.base)$quantile = computeQuantileMatrix(seMat.base)
```

```
## Retrieving data: data
```

```
# view
assays(seMat.base)$quantile[1:5, 1:4]
```

```
##        TCGA.A7.A0CE.11 TCGA.A7.A0CH.11 TCGA.A7.A0D9.11 TCGA.A7.A0DB.11
## A2ML1       0.03861004       0.0312500           0.136      0.04545455
## ABAT        0.44015444       0.3164062           0.336      0.36363636
## ABCA3       0.40154440       0.5625000           0.532      0.50000000
## ACADSB      0.62162162       0.5351562           0.648      0.49173554
## ACOX2       0.29343629       0.4140625           0.696      0.56611570
```

```
# convert tumor data to quantiles
assays(seMat)$quantile = computeQuantileMatrix(seMat)
```

```
## Retrieving data: data
```

```
# view
assays(seMat)$quantile[1:5, 1:4]
```

```
##        TCGA.A1.A0SB.01 TCGA.A1.A0SD.01 TCGA.A1.A0SE.01 TCGA.A1.A0SF.01
## A2ML1       0.03968254       0.0156250       0.0000000       0.0078125
## ABAT        0.39682540       0.3398438       0.5447471       0.3593750
## ABCA3       0.48015873       0.4531250       0.5252918       0.4218750
## ACADSB      0.51190476       0.6640625       0.4124514       0.3710938
## ACOX2       0.15873016       0.1250000       0.3229572       0.1210938
```

Now we can compute the support using the quantile-form normal data. There are two functions provided for this, for two scenarios. The first is computeUnivariateSupport(), which can be used to compute the support if the \(\gamma\) and \(\beta\) parameters have already been decided by the user. For example, let us suppose we have decided to use \(\gamma = 0.1\) and \(\beta = 0.99\). The \(\gamma\) parameter controls the radius of the ball around each baseline sample, which in the univariate scenario becomes the distance to a certain nearest neighbour. The larger the \(\gamma\) value, the farther the neighbour will be. Since \(\beta = 0.99\), \(99\%\) of the reference samples will be included in the support.

```
baseline1 = computeUnivariateSupport(
  seMat=seMat.base,
  gamma=0.1,
  beta=0.99,
  parallel=FALSE
)
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.99, gamma=0.1]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.002772]
```

If the baseline data is larger, you can set the parallel option to TRUE which will use the mclapply function of the parallel package (if available) to run the computation parallelly.

The function returns a list containing the support information: a data frame Ranges containing the support (which is an interval in the univariate scenario), a matrix Support which indicates whether each sample was included in the support of each feature or not, and gamma and alpha values, where alpha is the average number of features divergent per sample. The Support matrix is a binary matrix, where if a sample is included in the support of a given feature it has a value of 1 and 0 otherwise.

```
head(baseline1$Ranges)
```

```
##        baseline.low baseline.high
## A2ML1     0.0000000     0.2055938
## ABAT      0.1818306     0.5990710
## ABCA3     0.1072151     0.8196078
## ACADSB    0.3462584     0.8978976
## ACOX2     0.1042471     0.7748125
## ACVR1B    0.3865060     0.6657095
```

```
baseline1$Support[1:5, 1:4]
```

```
##        TCGA.A7.A0CE.11 TCGA.A7.A0CH.11 TCGA.A7.A0D9.11 TCGA.A7.A0DB.11
## A2ML1                1               1               1               1
## ABAT                 1               1               1               1
## ABCA3                1               1               1               1
## ACADSB               1               1               1               1
## ACOX2                1               1               1               1
```

```
baseline1$alpha
```

```
## [1] 0.002772003
```

However, more often is general usage there will be no pre-determined gamma value to be used. Rather, we would like to limit the divergence of the baseline data lower than a certain threshold. The findUnivariateGammaWithSupport() function can be used in this case, which allows the user to provide a range of candidate gamma parameter values along with a beta value, and a thrshold alpha for the expected divergent number of features per sample. The function will search through the given gamma values in asending order until the expected divergent number of features per sample falls below the given alpha threshold, and select that gamma value.

The following will find a support such that the expected number of divergence features per sample is less than 0.5% in the baseline cohort:

```
baseline2 = findUnivariateGammaWithSupport(
  seMat=seMat.base,
  gamma=1:9/10,
  beta=0.9,
  alpha=0.005,
  parallel=FALSE
)
```

```
## Retrieving data: quantile
```

```
## Searching optimal gamma for alpha=0.005
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.9, gamma=0.1]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.040887]
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.9, gamma=0.2]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.025641]
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.9, gamma=0.3]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.0163895]
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.9, gamma=0.4]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.0123354]
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.9, gamma=0.5]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.00963271]
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.9, gamma=0.6]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.00814276]
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.9, gamma=0.7]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.00686071]
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.9, gamma=0.8]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.00540541]
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.9, gamma=0.9]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.0039501]
```

```
## Search results for alpha=0.005: gamma=0.9, expectation=0.0039501, optimal=TRUE
```

The computed baseline has various information on the paramters you can check:

```
# selected gamma
baseline2$gamma
```

```
##  g9
## 0.9
```

```
# alpha value: i.e. number of divergent features per sample in the baseliine cohort
baseline2$alpha
```

```
##          g9
## 0.003950104
```

```
# does the selected gamma meet the alpha threshold required by the user?
baseline2$optimal
```

```
## [1] TRUE
```

```
# view the alpha values obtained for each of the gamma values searched through
baseline2$alpha_space
```

```
##    gamma       alpha
## g1   0.1 0.040887041
## g2   0.2 0.025641026
## g3   0.3 0.016389466
## g4   0.4 0.012335412
## g5   0.5 0.009632710
## g6   0.6 0.008142758
## g7   0.7 0.006860707
## g8   0.8 0.005405405
## g9   0.9 0.003950104
```

Similar to the output from the computeUnivariateSupport() function, for the selected gamma you can obtain the Ranges data frame and Support matrix which respectively provides the feature level baseline intervals and indication of which samples are contained in each feature support.

```
head(baseline2$Ranges)
```

```
##        baseline.low baseline.high
## A2ML1    0.00000000     0.1454437
## ABAT     0.07593628     0.6339437
## ABCA3    0.05594758     0.8632812
## ACADSB   0.15503876     1.0000000
## ACOX2    0.00000000     1.0000000
## ACVR1B   0.27537743     0.7864002
```

Now we can covert the tumor data to ternary form using the baseline:

```
assays(seMat)$div = computeUnivariateTernaryMatrix(
  seMat = seMat,
  Baseline = baseline2
)
```

```
## Retrieving data: quantile
```

```
assays(seMat)$div[1:5, 1:4]
```

```
##        TCGA.A1.A0SB.01 TCGA.A1.A0SD.01 TCGA.A1.A0SE.01 TCGA.A1.A0SF.01
## A2ML1                0               0               0               0
## ABAT                 0               0               0               0
## ABCA3                0               0               0               0
## ACADSB               0               0               0               0
## ACOX2                0               0               0               0
```

The simpler approach is to use the computeUnivariateDigitization() function, which will perform all of the above steps:

```
div.2 = computeUnivariateDigitization(
  seMat = seMat,
  seMat.base = seMat.base,
  computeQuantiles = TRUE,
  gamma = 1:9/10,
  beta = 0.9,
  alpha = 0.01,
  parallel = FALSE
)
```

```
## Computing quantiles..
```

```
## Retrieving data: data
## Retrieving data: data
```

```
## Retrieving data: quantile
```

```
## Searching optimal gamma for alpha=0.01
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.9, gamma=0.1]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.040887]
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.9, gamma=0.2]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.025641]
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.9, gamma=0.3]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.0163895]
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.9, gamma=0.4]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.0123354]
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.9, gamma=0.5]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.00963271]
```

```
## Search results for alpha=0.01: gamma=0.5, expectation=0.00963271, optimal=TRUE
```

```
## Retrieving data: quantile
## Retrieving data: quantile
```

```
# digitized data matrix
dim(div.2$Mat.div)
```

```
## [1] 260 776
```

```
div.2$Mat.div[1:5, 1:4]
```

```
##        TCGA.A1.A0SB.01 TCGA.A1.A0SD.01 TCGA.A1.A0SE.01 TCGA.A1.A0SF.01
## A2ML1                0               0               0               0
## ABAT                 0               0               1               0
## ABCA3                0               0               0               0
## ACADSB               0               0               0               0
## ACOX2                0               0               0               0
```

```
# digitized baseline matrix
dim(div.2$baseMat.div)
```

```
## [1] 260 111
```

```
div.2$baseMat.div[1:5, 1:4]
```

```
##        TCGA.A7.A0CE.11 TCGA.A7.A0CH.11 TCGA.A7.A0D9.11 TCGA.A7.A0DB.11
## A2ML1                0               0               1               0
## ABAT                 0               0               0               0
## ABCA3                0               0               0               0
## ACADSB               0               0               0               0
## ACOX2                0               0               0               0
```

```
# divergent set size in each data matrix sample
head(div.2$div)
```

```
##                          sample count.div count.div.upper count.div.lower
## TCGA.A1.A0SB.01 TCGA.A1.A0SB.01        29              20               9
## TCGA.A1.A0SD.01 TCGA.A1.A0SD.01        25              12              13
## TCGA.A1.A0SE.01 TCGA.A1.A0SE.01        32              18              14
## TCGA.A1.A0SF.01 TCGA.A1.A0SF.01        39              22              17
## TCGA.A1.A0SG.01 TCGA.A1.A0SG.01        46              24              22
## TCGA.A1.A0SH.01 TCGA.A1.A0SH.01        18               9               9
```

```
# divergence probability of features
head(div.2$features.div)
```

```
##        feature    prob.div
## A2ML1    A2ML1 0.233247423
## ABAT      ABAT 0.324742268
## ABCA3    ABCA3 0.050257732
## ACADSB  ACADSB 0.099226804
## ACOX2    ACOX2 0.003865979
## ACVR1B  ACVR1B 0.067010309
```

```
# baseline information
head(div.2$Baseline$Ranges)
```

```
##        baseline.low baseline.high
## A2ML1   0.000000000     0.1124031
## ABAT    0.131782946     0.5417272
## ABCA3   0.097276265     0.7609617
## ACADSB  0.320220348     0.9948425
## ACOX2   0.007646597     0.8945312
## ACVR1B  0.351316437     0.7085039
```

```
div.2$Baseline$gamma
```

```
##  g5
## 0.5
```

If a phenotype of interest is available for the data, that can be supplied as an optional parameter to the computeUnivariateDigitization() function which will then also include the feature level divergent probabilities for each group:

```
# make a factor of the ER status phenotype
selection = which(colnames(breastTCGA_Mat) %in% colnames(seMat))
groups.ER = breastTCGA_ER[selection]

table(groups.ER, useNA='i')
```

```
## groups.ER
## Positive Negative
##      598      178
```

```
# perform divergence
div.3 = computeUnivariateDigitization(
  seMat = seMat,
  seMat.base = seMat.base,
  computeQuantiles = FALSE,
  gamma = 1:9/10,
  Groups = groups.ER,
  classes = c("Positive", "Negative"),
  parallel = FALSE
)
```

```
## Retrieving data: quantile
```

```
## Searching optimal gamma for alpha=0.01
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.95, gamma=0.1]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.0157311]
```

```
## Retrieving data: quantile
```

```
## Computing ranges from 111 reference samples for 260 features
```

```
## [beta=0.95, gamma=0.2]
```

```
## Retrieving data: quantile
```

```
## [Expected proportion of divergent features per sample=0.00796951]
```

```
## Search results for alpha=0.01: gamma=0.2, expectation=0.00796951, optimal=TRUE
```

```
## Retrieving data: quantile
## Retrieving data: quantile
```

```
# divergence probability of features
head(div.3$features.div)
```

```
##        feature   prob.div prob.div.Positive prob.div.Negative
## A2ML1    A2ML1 0.20618557        0.04849498        0.73595506
## ABAT      ABAT 0.37242268        0.45652174        0.08988764
## ABCA3    ABCA3 0.08247423        0.08361204        0.07865169
## ACADSB  ACADSB 0.14432990        0.08862876        0.33146067
## ACOX2    ACOX2 0.06056701        0.06187291        0.05617978
## ACVR1B  ACVR1B 0.14690722        0.15551839        0.11797753
```

\section{Finding differentially divergent features}

The package includes a computeChiSquaredTest() function which will apply the chisq.test() function provided in the stats package to each feature and over a given sample grouping and two classes to discriminted against. This can be used to identify features that are highly differentially divergent in the digitized form between two phenotypes. The output data frame will contain the \(\chi^2\)-test statistic and p-value for each feature sorted by p-value:

```
chi.1 = computeChiSquaredTest(
  Mat = assays(seMat)$div,
  Groups = groups.ER,
  classes = c("Positive", "Negative")
)

head(chi.1, 10)
```

```
##         statistic         pval
## CDC25A   427.8328 4.814726e-95
## CCNE1    426.9706 7.417267e-95
## A2ML1    388.1793 2.061767e-86
## E2F3     365.6002 1.698969e-81
## ART3     352.4434 1.244713e-78
## TBC1D9   325.8925 7.540746e-73
## CXorf61  287.6764 1.595378e-64
## SLC7A5   284.1068 9.564722e-64
## CENPA    280.9884 4.573082e-63
## GAL      278.9429 1.276287e-62
```

\section{Multivariate Divergence}

![Multivariate workflow](data:image/jpeg;base64...)

In this section we look at how to perform divergence analysis on multivariate features - i.e. sets of features. We use the hallmark gene sets mentioned previously to demonstrate this. As shown in figure 2, the workflow is similar to the univariate case, with the main difference being that the multivariate features need to be provided as input in each step.

```
length(msigdb_Hallmarks)
```

```
## [1] 10
```

```
lapply(msigdb_Hallmarks[1:3], head)
```

```
## $HALLMARK_ESTROGEN_RESPONSE_EARLY
## [1] "GREB1"    "CA12"     "SLC9A3R1" "MYB"      "ANXA9"    "IGFBP4"
##
## $HALLMARK_ESTROGEN_RESPONSE_LATE
## [1] "TFF1"     "SLC9A3R1" "TPD52L1"  "PRSS23"   "CA12"     "PDZK1"
##
## $HALLMARK_MTORC1_SIGNALING
## [1] "FADS1"  "DDIT4"  "CALR"   "HK2"    "PGK1"   "SLC7A5"
```

Starting with the quantile transformed data, we can use the computeMultivariateSupport() function to compute a multivariate baseliine if we already know which gamma prameter we would like to use.

```
baseline3 = computeMultivariateSupport(
  seMat=seMat.base,
  FeatureSets = msigdb_Hallmarks,
  gamma=0.1,
  beta=0.99
)
```

```
## Retrieving data: quantile
```

Or, we use the findMultivariateGammaWithSupport() to search through a given list of gamma values to find the best baseline that meets a given alpha threshold:

```
baseline4 = findMultivariateGammaWithSupport(
  seMat = seMat.base,
  FeatureSets = msigdb_Hallmarks,
  gamma=1:9/10,
  beta=0.9,
  alpha = .01
)
```

```
## Searching optimal support for alpha threshold=0.01
```

```
## Retrieving data: quantile
## Retrieving data: quantile
```

```
## 	[gamma=0.1, beta=0.9, alpha=0.0234234]
```

```
## Retrieving data: quantile
```

```
## 	[gamma=0.2, beta=0.9, alpha=0.00990991]
```

```
# selected gamma
baseline4$gamma
```

```
## [1] 0.2
```

```
# alpha value: i.e. number of divergent multivariate features per sample in the baseliine cohort
baseline4$alpha
```

```
## [1] 0.00990991
```

```
# does the selected gamma meet the alpha threshold required by the user?
baseline4$optimal
```

```
## [1] TRUE
```

```
# view the alpha values obtained for each of the gamma values searched through
baseline4$alpha_space
```

```
##   gamma      alpha
## 1   0.1 0.02342342
## 2   0.2 0.00990991
## 3   0.3         NA
## 4   0.4         NA
## 5   0.5         NA
## 6   0.6         NA
## 7   0.7         NA
## 8   0.8         NA
## 9   0.9         NA
```

Once the baseline has been computed, the binary digitized form can now be computed for the data matrix:

```
mat.div.2 = computeMultivariateBinaryMatrix(
  seMat = seMat,
  Baseline = baseline4
)
```

```
## Retrieving data: quantile
```

```
dim(mat.div.2)
```

```
## [1]  10 776
```

```
mat.div.2[1:5, 1:4]
```

```
##                                  TCGA.A1.A0SB.01 TCGA.A1.A0SD.01
## HALLMARK_ESTROGEN_RESPONSE_EARLY               1               1
## HALLMARK_ESTROGEN_RESPONSE_LATE                1               0
## HALLMARK_MTORC1_SIGNALING                      1               1
## HALLMARK_HYPOXIA                               1               0
## HALLMARK_XENOBIOTIC_METABOLISM                 0               1
##                                  TCGA.A1.A0SE.01 TCGA.A1.A0SF.01
## HALLMARK_ESTROGEN_RESPONSE_EARLY               0               1
## HALLMARK_ESTROGEN_RESPONSE_LATE                0               0
## HALLMARK_MTORC1_SIGNALING                      1               1
## HALLMARK_HYPOXIA                               0               0
## HALLMARK_XENOBIOTIC_METABOLISM                 0               0
```

As the the univariate case, all the steps can be performed together simply by using the computeMultivariateDigitization function. We use the ER status phenotype here as well, to obtain phenotype specific divergence probabilities for each gene set.

```
# perform divergence
div.4 = computeMultivariateDigitization(
  seMat = seMat,
  seMat.base = seMat.base,
  FeatureSets = msigdb_Hallmarks,
  computeQuantiles = TRUE,
  gamma = 1:9/10,
  Groups = groups.ER,
  classes = c("Positive", "Negative")
)
```

```
## Computing quantiles..
```

```
## Retrieving data: data
## Retrieving data: data
```

```
## Searching optimal support for alpha threshold=0.01
```

```
## Retrieving data: quantile
## Retrieving data: quantile
```

```
## 	[gamma=0.1, beta=0.95, alpha=0.018018]
```

```
## Retrieving data: quantile
```

```
## 	[gamma=0.2, beta=0.95, alpha=0.00630631]
```

```
## Retrieving data: quantile
## Retrieving data: quantile
```

```
# digitized data matrix
dim(div.4$Mat.div)
```

```
## [1]  10 776
```

```
div.4$Mat.div[1:5, 1:4]
```

```
##                                  TCGA.A1.A0SB.01 TCGA.A1.A0SD.01
## HALLMARK_ESTROGEN_RESPONSE_EARLY               1               1
## HALLMARK_ESTROGEN_RESPONSE_LATE                1               0
## HALLMARK_MTORC1_SIGNALING                      1               1
## HALLMARK_HYPOXIA                               1               0
## HALLMARK_XENOBIOTIC_METABOLISM                 0               1
##                                  TCGA.A1.A0SE.01 TCGA.A1.A0SF.01
## HALLMARK_ESTROGEN_RESPONSE_EARLY               0               1
## HALLMARK_ESTROGEN_RESPONSE_LATE                0               0
## HALLMARK_MTORC1_SIGNALING                      1               1
## HALLMARK_HYPOXIA                               0               0
## HALLMARK_XENOBIOTIC_METABOLISM                 0               0
```

```
# digitized baseline matrix
dim(div.4$baseMat.div)
```

```
## [1]  10 111
```

```
div.4$baseMat.div[1:5, 1:4]
```

```
##                                  TCGA.A7.A0CE.11 TCGA.A7.A0CH.11
## HALLMARK_ESTROGEN_RESPONSE_EARLY               0               0
## HALLMARK_ESTROGEN_RESPONSE_LATE                0               0
## HALLMARK_MTORC1_SIGNALING                      0               0
## HALLMARK_HYPOXIA                               0               0
## HALLMARK_XENOBIOTIC_METABOLISM                 0               0
##                                  TCGA.A7.A0D9.11 TCGA.A7.A0DB.11
## HALLMARK_ESTROGEN_RESPONSE_EARLY               0               0
## HALLMARK_ESTROGEN_RESPONSE_LATE                0               0
## HALLMARK_MTORC1_SIGNALING                      0               0
## HALLMARK_HYPOXIA                               0               0
## HALLMARK_XENOBIOTIC_METABOLISM                 0               0
```

```
# divergent set size in each data matrix sample
head(div.4$div)
```

```
##                          sample count.div
## TCGA.A1.A0SB.01 TCGA.A1.A0SB.01         7
## TCGA.A1.A0SD.01 TCGA.A1.A0SD.01         6
## TCGA.A1.A0SE.01 TCGA.A1.A0SE.01         4
## TCGA.A1.A0SF.01 TCGA.A1.A0SF.01         4
## TCGA.A1.A0SG.01 TCGA.A1.A0SG.01         8
## TCGA.A1.A0SH.01 TCGA.A1.A0SH.01         3
```

```
# divergence probability of features
head(div.4$features.div)
```

```
##                                                           feature  prob.div
## HALLMARK_ESTROGEN_RESPONSE_EARLY HALLMARK_ESTROGEN_RESPONSE_EARLY 0.7744845
## HALLMARK_ESTROGEN_RESPONSE_LATE   HALLMARK_ESTROGEN_RESPONSE_LATE 0.8453608
## HALLMARK_MTORC1_SIGNALING               HALLMARK_MTORC1_SIGNALING 0.8466495
## HALLMARK_HYPOXIA                                 HALLMARK_HYPOXIA 0.6430412
## HALLMARK_XENOBIOTIC_METABOLISM     HALLMARK_XENOBIOTIC_METABOLISM 0.3659794
## HALLMARK_G2M_CHECKPOINT                   HALLMARK_G2M_CHECKPOINT 0.9188144
##                                  prob.div.Positive prob.div.Negative
## HALLMARK_ESTROGEN_RESPONSE_EARLY         0.7491639         0.8595506
## HALLMARK_ESTROGEN_RESPONSE_LATE          0.8377926         0.8707865
## HALLMARK_MTORC1_SIGNALING                0.8327759         0.8932584
## HALLMARK_HYPOXIA                         0.6605351         0.5842697
## HALLMARK_XENOBIOTIC_METABOLISM           0.3411371         0.4494382
## HALLMARK_G2M_CHECKPOINT                  0.8979933         0.9887640
```

```
# baseline information
div.2$Baseline$gamma
```

```
##  g5
## 0.5
```

```
div.2$Baseline$alpha
```

```
##         g5
## 0.00963271
```

```
div.2$Baseline$optimal
```

```
## [1] TRUE
```

```
div.2$Baseline$alpha_space
```

```
##    gamma      alpha
## g1   0.1 0.04088704
## g2   0.2 0.02564103
## g3   0.3 0.01638947
## g4   0.4 0.01233541
## g5   0.5 0.00963271
## g6   0.6         NA
## g7   0.7         NA
## g8   0.8         NA
## g9   0.9         NA
```

\(\chi^2\)-Tests can be applied on the multivariate digitized data to find differentially divergent gene sets:

```
chi.2 = computeChiSquaredTest(
  Mat = div.4$Mat.div,
  Groups = groups.ER,
  classes = c("Positive", "Negative")
)

head(chi.2, 10)
```

```
##                                   statistic         pval
## HALLMARK_MYOGENESIS              63.4438969 1.649998e-15
## HALLMARK_IL2_STAT5_SIGNALING     44.7485500 2.240328e-11
## HALLMARK_G2M_CHECKPOINT          13.9586892 1.868719e-04
## HALLMARK_ESTROGEN_RESPONSE_EARLY  8.9482392 2.777372e-03
## HALLMARK_XENOBIOTIC_METABOLISM    6.4748166 1.094136e-02
## HALLMARK_MTORC1_SIGNALING         3.4130209 6.468393e-02
## HALLMARK_BILE_ACID_METABOLISM     3.4026143 6.509318e-02
## HALLMARK_HYPOXIA                  3.1515138 7.585656e-02
## HALLMARK_P53_PATHWAY              1.3361010 2.477227e-01
## HALLMARK_ESTROGEN_RESPONSE_LATE   0.9038107 3.417620e-01
```

\section{Summary}

The above workflows provide a concise summary of how to work with the package. Mainly, the user can use the computeUnivariateDigitization() and computeMultivariateDigitization() functions to obtain the divergence coding given a baseline data matrix and a main experimental data matrix. Otherwise, there are other functions for working at both the univariate and multivariate level for a more step by step approach to performing divergence analysis.

\section{Session Information}

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
##  [1] divergence_1.26.0           SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0
##
## loaded via a namespace (and not attached):
##  [1] SparseArray_1.10.0  Matrix_1.7-4        xfun_0.53
##  [4] lattice_0.22-7      abind_1.4-8         S4Arrays_1.10.0
##  [7] XVector_0.50.0      knitr_1.50          grid_4.5.1
## [10] DelayedArray_0.36.0 compiler_4.5.1      tools_4.5.1
## [13] evaluate_1.0.5
```

\section{References}

(????).
“The Cancer Genome Atlas.”
<https://cancergenome.nih.gov/abouttcga>.
[Online].

Dinalankara W, Ke Q, Xu Y, Ji L, Pagane N, Lien A, Matam T, Fertig EJ, Price ND, Younes L, others (2018).
“Digitizing omics profiles by divergence from a baseline.”
*Proceedings of the National Academy of Sciences*, **115**(18), 4545–4552.

Liberzon A, Subramanian A, Pinchback R, Thorvaldsdóttir H, Tamayo P, Mesirov JP (2011).
“Molecular signatures database (MSigDB) 3.0.”
*Bioinformatics*, **27**(12), 1739–1740.