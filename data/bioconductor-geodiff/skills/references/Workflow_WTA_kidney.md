# Workflow\_WTA

## Installation

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("GeoDiff")
```

## Overview

This vignette demonstrates the use of the GeoDiff package on NanoString GeoMx Digital Spatial Profiler (DSP) data. This package can be used for background modeling, target and sample QC, normalization and differential expression analysis.

We’ll analyze a NanoString GeoMx DSP dataset of diseased vs healthy kidney tissue using the Human Whole Transcriptome (WTA) panel. Seven slides were analyzed, 4 diseased and 3 healthy. Regions of Interest (ROI) were focused two different parts of a kidney’s structure: tubules or glomeruli.

## Data preparation

First we will load the necessary packages

```
library(GeoDiff)
library(dplyr)
library(ggplot2)
library(NanoStringNCTools)
library(GeomxTools)
library(Biobase)
library(reshape2)
```

Now let’s load our data and examine it.

```
data("kidney")

#Update to current NanoStringGeoMxSet version
kidney <- updateGeoMxSet(kidney)

kidney
#> NanoStringGeoMxSet (storageMode: lockedEnvironment)
#> assayData: 18642 features, 276 samples
#>   element names: exprs
#> protocolData
#>   sampleNames: DSP-1001250007851-H-A02.dcc DSP-1001250007851-H-A03.dcc
#>     ... DSP-1002510007866-C-H12.dcc (276 total)
#>   varLabels: FileVersion SoftwareVersion ... NTC (18 total)
#>   varMetadata: labelDescription
#> phenoData
#>   sampleNames: DSP-1001250007851-H-A02.dcc DSP-1001250007851-H-A03.dcc
#>     ... DSP-1002510007866-C-H12.dcc (276 total)
#>   varLabels: construct read_pattern ... nuclei (10 total)
#>   varMetadata: labelDescription
#> featureData
#>   featureNames: RTS0020877 RTS0020878 ... RTS0052009 (18642 total)
#>   fvarLabels: RTS_ID TargetName ... Negative (6 total)
#>   fvarMetadata: labelDescription
#> experimentData: use 'experimentData(object)'
#> Annotation: TAP_H_WTA_v1.0.pkc
#> signature: none
#> feature: Probe
#> analyte: RNA

head(pData(kidney))
#>                             construct read_pattern expected_neg slide name
#> DSP-1001250007851-H-A02.dcc directPCR         2x27            0   disease3
#> DSP-1001250007851-H-A03.dcc directPCR         2x27            0   disease3
#> DSP-1001250007851-H-A04.dcc directPCR         2x27            0   disease3
#> DSP-1001250007851-H-A05.dcc directPCR         2x27            0   disease3
#> DSP-1001250007851-H-A06.dcc directPCR         2x27            0   disease3
#> DSP-1001250007851-H-A07.dcc directPCR         2x27            0   disease3
#>                             class           segment     area     region
#> DSP-1001250007851-H-A02.dcc   DKD Geometric Segment 31797.59 glomerulus
#> DSP-1001250007851-H-A03.dcc   DKD Geometric Segment 16920.10 glomerulus
#> DSP-1001250007851-H-A04.dcc   DKD Geometric Segment 14312.33 glomerulus
#> DSP-1001250007851-H-A05.dcc   DKD Geometric Segment 20032.84 glomerulus
#> DSP-1001250007851-H-A06.dcc   DKD Geometric Segment 27583.26 glomerulus
#> DSP-1001250007851-H-A07.dcc   DKD Geometric Segment 18164.84 glomerulus
#>                             pathology nuclei
#> DSP-1001250007851-H-A02.dcc  abnormal  16871
#> DSP-1001250007851-H-A03.dcc  abnormal  17684
#> DSP-1001250007851-H-A04.dcc  abnormal  15108
#> DSP-1001250007851-H-A05.dcc  abnormal  15271
#> DSP-1001250007851-H-A06.dcc  abnormal  18256
#> DSP-1001250007851-H-A07.dcc  abnormal  16899

table(pData(kidney)$`slide name`)
#>
#> disease1B disease2B  disease3  disease4  normal2B   normal3   normal4
#>        39        37        59        24        35        59        23
table(pData(kidney)$region)
#>
#> glomerulus     tubule
#>        190         86
```

This data is stored in a NanoStringGeoMxSet object. For more examples on how to work with this data please look at `vignette("Developer_Introduction_to_the_NanoStringGeoMxSet", package = "GeomxTools")` or `vignette("GeomxTools_RNA-NGS_Analysis", package = "GeoMxWorkflows")`

In order to make the vignette run in a reasonable amount of time, we subset the data. We subset 16 ROIs with a similar distribution to the entire dataset: 8 ROIs from the disease3 and normal3 slides, 4 glomerulus and 4 tubule ROIs from each.

```
kidney <- kidney[, which(kidney$`slide name` %in% c("disease3", "normal3"))][, c(1:4, 48:51,
                                                                                 60:63, 115:118)]
table(kidney$region, kidney$`slide name`)
#>
#>              disease3 normal3
#>   glomerulus        4       4
#>   tubule            4       4
table(kidney$`slide name`, kidney$class)
#>
#>            DKD normal
#>   disease3   8      0
#>   normal3    0      8
```

## Background Modeling

Poisson background model using negative probes.

The background model works on the probe level data with all of the negative probes. Please do not use aggregateCounts from GeomxTools before modeling.

```
featureType(kidney)
#> [1] "Probe"

paste("## of Negative Probes:", sum(fData(kidney)$Negative))
#> [1] "## of Negative Probes: 139"
```

This model estimates a feature factor for each negative probe and a background size factor for each ROI.

```
kidney <- fitPoisBG(kidney)
#> Iteration = 1, squared error = 3.911046e+06
#> Iteration = 2, squared error = 0.000000e+00
#> Model converged.

summary(pData(kidney)$sizefact)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#> 0.01779 0.03267 0.04620 0.06250 0.07954 0.15591
summary(fData(kidney)$featfact[fData(kidney)$Negative])
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>     0.0   138.5   160.0   163.4   185.0   346.0
```

After running the model, we can diagnose it and see if there are any issues in the dataset. One key metric for Poisson model is the dispersion. When dispersion is big, it is called over-dispersion which often indicates batch effect or large outliers in the data.

```
set.seed(123)
kidney_diag <- diagPoisBG(kidney)
```

![](data:image/png;base64...)

```
notes(kidney_diag)$disper
#> [1] 0.9674666
```

If the dispersion is >2, one of these factors might be present in the data. We can check for outlier ROIs. People can choose to set outliers to be missing values and rerun the Poisson Background model. Since the dispersion is within range here, the model will not get run.

```
which(assayDataElement(kidney_diag, "low_outlier") == 1, arr.ind = TRUE)
which(assayDataElement(kidney_diag, "up_outlier") == 1, arr.ind = TRUE)
```

Or if a batch effect is assumed, the poisson model can be adjusted to take different groups into account. Here we are grouping the ROIs by slide.

```
kidney <- fitPoisBG(kidney, groupvar = "slide name")
#> Iteration = 1, squared error = 7.881119e+06
#> Iteration = 2, squared error = 7.290337e-26
#> Model converged.
```

The diagnosis of this model shows that when splitting by slide we similar results as without splitting in this dataset.

```
set.seed(123)
kidney_diag <- diagPoisBG(kidney, split = TRUE)
#> The results are based on stored `groupvar`, slide name
```

![](data:image/png;base64...)

```
notes(kidney_diag)$disper_sp
#> [1] 0.8865716
```

## Aggregate function

After subsetting, we have a couple probes with 0 counts in all 16 ROIs so we will remove them here.

aggreprobe is a GeoDiff specific function for probe aggregation and filtering. Probes get filtered based on either correlation and/or the score test within targets and then aggregated. The negative probes do not get aggregated or filtered.

```
all0probeidx <- which(rowSums(exprs(kidney))==0)
if (length(all0probeidx) > 0) {
    kidney <- kidney[-all0probeidx, ]
}
kidney <- aggreprobe(kidney, use = "cor")
```

## Target QC

### Score test

Using the background score test, we can determine which targets are expressed above the background of the negative probes across this dataset. We can then filter the data to only targets above background, using a suggested pvalue threshold of 1e-3.

```
kidney <- BGScoreTest(kidney)

sum(fData(kidney)[["pvalues"]] < 1e-3, na.rm = TRUE)
#> [1] 16265
```

For advanced users, there are 3 variables that can be changed in the score test. The default for all three variables is FALSE. Any combination of these variables can be used.

1. split - should the poisson background values split by group be used
2. removeoutlier - should outlier negatives be removed
3. useprior - use prior that the expression level of background follows a Beta distribution, this will lead to a more conservative test but is prone to influence by outliers

```
kidneySplit <- BGScoreTest(kidney, split = TRUE, removeoutlier = FALSE, useprior = FALSE)
#> The results are based on stored `groupvar`, slide name
sum(fData(kidneySplit)[["pvalues"]] < 1e-3, na.rm = TRUE)
#> [1] 16265

kidneyOutliers <- BGScoreTest(kidney, split = FALSE, removeoutlier = TRUE, useprior = FALSE)
#> 2 negative probes are removed prior to the score test.
sum(fData(kidneyOutliers)[["pvalues"]] < 1e-3, na.rm = TRUE)
#> [1] 16449

kidneyPrior <- BGScoreTest(kidney, split = FALSE, removeoutlier = FALSE, useprior = TRUE)
sum(fData(kidneyPrior)[["pvalues"]] < 1e-3, na.rm = TRUE)
#> [1] 15662
```

### Estimate the size factor

To estimate the signal size factor, we use the fit negative binomial threshold function. This size factor represents technical variation between ROIs like sequencing depth

The feature\_high\_fitNBth labeled genes are ones well above background that will be used in later steps.

```
set.seed(123)

kidney <- fitNBth(kidney, split = TRUE)
#> `threshold_start` is missing. The default value is estimated based on fitPoisBG results with multiple slides.
#> Iteration = 1, squared error = 0.00302569241788513
#> Iteration = 2, squared error = 7.02945213722223e-05
#> Iteration = 3, squared error = 6.52583856503085e-06
#> Iteration = 4, squared error = 1.83601927519986e-06
#> Iteration = 5, squared error = 1.13430452946589e-06
#> Iteration = 6, squared error = 9.12780913129519e-07
#> Iteration = 7, squared error = 7.69149424318962e-07
#> Iteration = 8, squared error = 6.55130274591665e-07
#> Model converged.

features_high <- rownames(fData(kidney))[fData(kidney)$feature_high_fitNBth == 1]

length(features_high)
#> [1] 1500
```

We can compare this threshold to the mean of the background as a sanity check.

```
bgMean <- mean(fData(kidney)$featfact, na.rm = TRUE)

notes(kidney)[["threshold"]]
#> [1] 181.003
bgMean
#> [1] 164.5362
```

This is a sanity check to see that the signal size factor and background size factor are correlated but not redundant.

```
cor(kidney$sizefact, kidney$sizefact_fitNBth)
#> [1] 0.9412545
plot(kidney$sizefact, kidney$sizefact_fitNBth, xlab = "Background Size Factor",
     ylab = "Signal Size Factor")
abline(a = 0, b = 1)
```

![](data:image/png;base64...)

In this dataset, this size factor correlate well with different quantiles, including \(75\%\) quantile which is used in Q3 normalization.

```
# get only biological probes
posdat <- kidney[-which(fData(kidney)$CodeClass == "Negative"), ]
posdat <- exprs(posdat)

quan <- sapply(c(0.75, 0.8, 0.9, 0.95), function(y)
  apply(posdat, 2, function(x) quantile(x, probs = y)))

corrs <- apply(quan, 2, function(x) cor(x, kidney$sizefact_fitNBth))
names(corrs) <- c(0.75, 0.8, 0.9, 0.95)

corrs
#>      0.75       0.8       0.9      0.95
#> 0.9807485 0.9843475 0.9840228 0.9762128

quan75 <- apply(posdat, 2, function(x) quantile(x, probs = 0.75))
```

Quantile range (quantile - background size factor scaled by the mean feature factor of negative probes) has better correlation with the signal size factor.

```
kidney <- QuanRange(kidney, split = FALSE, probs = c(0.75, 0.8, 0.9, 0.95))

corrs <- apply(pData(kidney)[, as.character(c(0.75, 0.8, 0.9, 0.95))], 2, function(x)
  cor(x, kidney$sizefact_fitNBth))

names(corrs) <- c(0.75, 0.8, 0.9, 0.95)

corrs
#>      0.75       0.8       0.9      0.95
#> 0.9964594 0.9983635 0.9898354 0.9731683
```

## Sample QC

To filter out poor quality ROIs, we only keep those which have a high enough signal in comparison to the background. In this dataset, all ROIs remain.

```
ROIs_high <- sampleNames(kidney)[which((quantile(fData(kidney)[["para"]][, 1],
                                                  probs = 0.90, na.rm = TRUE) -
                                          notes(kidney)[["threshold"]])*kidney$sizefact_fitNBth>2)]

features_all <- rownames(posdat)
```

## DE modeling

### Fixed Effect Model

Running the DE model with default values.

```
NBthDEmod <- fitNBthDE(form = ~region,
                       split = FALSE,
                       object = kidney)
#> Iteration = 1, squared error = 1.547611e-05
#> Iteration = 2, squared error = 1.219171e-05

str(NBthDEmod)
#> List of 12
#>  $ X            : num [1:16, 1:2] 1 1 1 1 1 1 1 1 1 1 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:16] "DSP-1001250007851-H-A02.dcc" "DSP-1001250007851-H-A03.dcc" "DSP-1001250007851-H-A04.dcc" "DSP-1001250007851-H-A05.dcc" ...
#>   .. ..$ : chr [1:2] "(Intercept)" "regiontubule"
#>   ..- attr(*, "assign")= int [1:2] 0 1
#>   ..- attr(*, "contrasts")=List of 1
#>   .. ..$ region: chr "contr.treatment"
#>  $ para0        : num [1:4, 1:1500] 5.75 2.35 23.14 181 7.41 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:4] "(Intercept)" "regiontubule" "r" "threshold"
#>   .. ..$ : chr [1:1500] "DDT" "FOSL1" "FKBP11" "PIM1" ...
#>  $ para         : num [1:4, 1:18439] 12.38 -1.57 3.12 181 6.61 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:4] "(Intercept)" "regiontubule" "r" "threshold"
#>   .. ..$ : chr [1:18439] "A2M" "NAT2" "ACADM" "ACADS" ...
#>  $ sizefact     : Named num [1:16] 0.0683 0.0457 0.0426 0.0549 0.0729 ...
#>   ..- attr(*, "names")= chr [1:16] "DSP-1001250007851-H-A02.dcc" "DSP-1001250007851-H-A03.dcc" "DSP-1001250007851-H-A04.dcc" "DSP-1001250007851-H-A05.dcc" ...
#>  $ sizefact0    : Named num [1:16] 0.0671 0.0452 0.0427 0.0548 0.073 ...
#>   ..- attr(*, "names")= chr [1:16] "DSP-1001250007851-H-A02.dcc" "DSP-1001250007851-H-A03.dcc" "DSP-1001250007851-H-A04.dcc" "DSP-1001250007851-H-A05.dcc" ...
#>  $ preci1       : num [1:2, 1:2] 0.04 0.02 0.02 1.41
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:2] "(Intercept)" "regiontubule"
#>   .. ..$ : chr [1:2] "(Intercept)" "regiontubule"
#>  $ Im0          :List of 1500
#>   ..$ DDT       : num[0 , 0 ]
#>   ..$ FOSL1     : num[0 , 0 ]
#>   ..$ FKBP11    : num[0 , 0 ]
#>   ..$ PIM1      : num[0 , 0 ]
#>   ..$ RABEP2    : num[0 , 0 ]
#>   ..$ ASAP2     : num[0 , 0 ]
#>   ..$ IRX2      : num[0 , 0 ]
#>   ..$ CENPX     : num[0 , 0 ]
#>   ..$ NDUFS2    : num[0 , 0 ]
#>   ..$ MED11     : num[0 , 0 ]
#>   ..$ PDP1      : num[0 , 0 ]
#>   ..$ DCAF11    : num[0 , 0 ]
#>   ..$ GLCE      : num[0 , 0 ]
#>   ..$ ELAVL1    : num[0 , 0 ]
#>   ..$ SSH2      : num[0 , 0 ]
#>   ..$ CFHR1     : num[0 , 0 ]
#>   ..$ SEC23B    : num[0 , 0 ]
#>   ..$ DGCR8     : num[0 , 0 ]
#>   ..$ PVALEF    : num[0 , 0 ]
#>   ..$ BEGAIN    : num[0 , 0 ]
#>   ..$ FBXO21    : num[0 , 0 ]
#>   ..$ ERP29     : num[0 , 0 ]
#>   ..$ VPS13A    : num[0 , 0 ]
#>   ..$ CYBA      : num[0 , 0 ]
#>   ..$ S1PR3     : num[0 , 0 ]
#>   ..$ RDH14     : num[0 , 0 ]
#>   ..$ DIS3L2    : num[0 , 0 ]
#>   ..$ RNF185    : num[0 , 0 ]
#>   ..$ SLC50A1   : num[0 , 0 ]
#>   ..$ UPF3B     : num[0 , 0 ]
#>   ..$ ART1      : num[0 , 0 ]
#>   ..$ FAHD2B    : num[0 , 0 ]
#>   ..$ ZNF684    : num[0 , 0 ]
#>   ..$ PTGER4    : num[0 , 0 ]
#>   ..$ DMPK      : num[0 , 0 ]
#>   ..$ ID3       : num[0 , 0 ]
#>   ..$ STIM1     : num[0 , 0 ]
#>   ..$ PLRG1     : num[0 , 0 ]
#>   ..$ MPC2      : num[0 , 0 ]
#>   ..$ ENY2      : num[0 , 0 ]
#>   ..$ FUCA1     : num[0 , 0 ]
#>   ..$ TCAF1     : num[0 , 0 ]
#>   ..$ MTSS1     : num[0 , 0 ]
#>   ..$ STAU2     : num[0 , 0 ]
#>   ..$ MIS12     : num[0 , 0 ]
#>   ..$ ZBTB3     : num[0 , 0 ]
#>   ..$ GLRX3     : num[0 , 0 ]
#>   ..$ PLEKHB2   : num[0 , 0 ]
#>   ..$ BAD       : num[0 , 0 ]
#>   ..$ HIPK1     : num[0 , 0 ]
#>   ..$ ATP6V1D   : num[0 , 0 ]
#>   ..$ TMEM140   : num[0 , 0 ]
#>   ..$ WRNIP1    : num[0 , 0 ]
#>   ..$ OXCT2     : num[0 , 0 ]
#>   ..$ PAQR5     : num[0 , 0 ]
#>   ..$ DHDDS     : num[0 , 0 ]
#>   ..$ ARSL      : num[0 , 0 ]
#>   ..$ HSD3B2    : num[0 , 0 ]
#>   ..$ GAS8      : num[0 , 0 ]
#>   ..$ CLUAP1    : num[0 , 0 ]
#>   ..$ INO80D    : num[0 , 0 ]
#>   ..$ ROMO1     : num[0 , 0 ]
#>   ..$ ZNF785    : num[0 , 0 ]
#>   ..$ AFM       : num[0 , 0 ]
#>   ..$ FAM180A   : num[0 , 0 ]
#>   ..$ MAP3K20   : num[0 , 0 ]
#>   ..$ ATF6B     : num[0 , 0 ]
#>   ..$ EYA3      : num[0 , 0 ]
#>   ..$ BAIAP2    : num[0 , 0 ]
#>   ..$ USP8      : num[0 , 0 ]
#>   ..$ C1RL      : num[0 , 0 ]
#>   ..$ CERS5     : num[0 , 0 ]
#>   ..$ ZIC3      : num[0 , 0 ]
#>   ..$ WDR83OS   : num[0 , 0 ]
#>   ..$ CHRNB1    : num[0 , 0 ]
#>   ..$ TSEN15    : num[0 , 0 ]
#>   ..$ ERP27     : num[0 , 0 ]
#>   ..$ RIT1      : num[0 , 0 ]
#>   ..$ PSMG3     : num[0 , 0 ]
#>   ..$ GIPC2     : num[0 , 0 ]
#>   ..$ LMBRD1    : num[0 , 0 ]
#>   ..$ KCNJ15    : num[0 , 0 ]
#>   ..$ CRTC1     : num[0 , 0 ]
#>   ..$ ZNF300    : num[0 , 0 ]
#>   ..$ EP300     : num[0 , 0 ]
#>   ..$ PAOX      : num[0 , 0 ]
#>   ..$ PRPF6     : num[0 , 0 ]
#>   ..$ YES1      : num[0 , 0 ]
#>   ..$ FAM107B   : num[0 , 0 ]
#>   ..$ AFAP1L1   : num[0 , 0 ]
#>   ..$ TNRC18    : num[0 , 0 ]
#>   ..$ MYO18A    : num[0 , 0 ]
#>   ..$ TOPORS    : num[0 , 0 ]
#>   ..$ LATS2     : num[0 , 0 ]
#>   ..$ METRN     : num[0 , 0 ]
#>   ..$ ADRB1     : num[0 , 0 ]
#>   ..$ PCGF2     : num[0 , 0 ]
#>   ..$ JCAD      : num[0 , 0 ]
#>   ..$ THNSL2    : num[0 , 0 ]
#>   .. [list output truncated]
#>  $ Im           :List of 18439
#>   ..$ A2M       : num [1:4, 1:4] 21.1193 8.4932 -0.1702 0.0115 8.4932 ...
#>   ..$ NAT2      : num [1:4, 1:4] 13.980023 8.889424 -0.000736 0.204585 8.889424 ...
#>   ..$ ACADM     : num [1:4, 1:4] 29.2427 19.298 -0.0806 0.0802 19.298 ...
#>   ..$ ACADS     : num [1:4, 1:4] 80.38089 58.08503 -0.00332 0.30971 58.08503 ...
#>   ..$ ACAT1     : num [1:4, 1:4] 20.119 12.8538 -0.0882 0.0348 12.8538 ...
#>   ..$ ACVRL1    : num [1:4, 1:4] 50.7352 17.4421 -0.0244 0.2294 17.4421 ...
#>   ..$ PSEN1     : num [1:4, 1:4] 7.97e+01 5.61e+01 5.32e-05 3.96e-01 5.61e+01 ...
#>   ..$ ADA       : num [1:4, 1:4] 13.369595 8.410655 -0.000591 0.179334 8.410655 ...
#>   ..$ SGCA      : num [1:4, 1:4] 23.2047 14.9864 -0.0155 0.1293 14.9864 ...
#>   ..$ ADRB2     : num [1:4, 1:4] 2.67e+01 1.73e+01 1.11e-05 2.80e-01 1.73e+01 ...
#>   ..$ ADRB3     : num [1:4, 1:4] 3.89 2.25 7.38e-06 1.23e-01 2.25 ...
#>   ..$ AGL       : num [1:4, 1:4] 3.21e+01 2.39e+01 4.27e-05 2.94e-01 2.39e+01 ...
#>   ..$ AGXT      : num [1:4, 1:4] 13.23094 8.44229 -0.00958 0.16777 8.44229 ...
#>   ..$ ABCD1     : num [1:4, 1:4] 2.30e+01 1.12e+01 2.65e-04 2.47e-01 1.12e+01 ...
#>   ..$ ALDOB     : num [1:4, 1:4] 4.21739 2.36912 -0.8988 0.00155 2.36912 ...
#>   ..$ AMPD1     : num [1:4, 1:4] 1.34e+01 8.33 8.27e-05 2.11e-01 8.33 ...
#>   ..$ APC       : num [1:4, 1:4] 3.60e+01 1.84e+01 -6.27e-06 3.10e-01 1.84e+01 ...
#>   ..$ APOA1     : num [1:4, 1:4] 29.731091 17.393192 -0.000216 0.294057 17.393192 ...
#>   ..$ APOC3     : num [1:4, 1:4] 44.97556 28.34708 -0.00416 0.30886 28.34708 ...
#>   ..$ APOE      : num [1:4, 1:4] 8.629 4.8553 -0.2788 0.0135 4.8553 ...
#>   ..$ APOH      : num [1:4, 1:4] 3.48 2.33 9.81e-06 1.22e-01 2.33 ...
#>   ..$ ARG1      : num [1:4, 1:4] 2.22e+01 1.24e+01 3.97e-05 2.59e-01 1.24e+01 ...
#>   ..$ ARSB      : num [1:4, 1:4] 55.08495 32.15709 -0.00107 0.35459 32.15709 ...
#>   ..$ ASL       : num [1:4, 1:4] 110.21274 82.67433 -0.00755 0.39015 82.67433 ...
#>   ..$ ASPA      : num [1:4, 1:4] 39.4615 31.0805 -0.0081 0.2718 31.0805 ...
#>   ..$ ASS1      : num [1:4, 1:4] 20.81 11.2089 -0.1244 0.0192 11.2089 ...
#>   ..$ ATM       : num [1:4, 1:4] 8.79e+01 5.15e+01 -7.72e-06 4.10e-01 5.15e+01 ...
#>   ..$ ATP7A     : num [1:4, 1:4] 30.3052 17.8342 -0.0001 0.301 17.8342 ...
#>   ..$ ATP7B     : num [1:4, 1:4] 18.9844 12.1535 -0.0223 0.1922 12.1535 ...
#>   ..$ AVPR2     : num [1:4, 1:4] 5.3363 3.8201 0.0118 0.0785 3.8201 ...
#>   ..$ BLM       : num [1:4, 1:4] 11.0884 6.8214 -0.0199 0.153 6.8214 ...
#>   ..$ BRCA2     : num [1:4, 1:4] 12.86856 8.57854 -0.00287 0.16089 8.57854 ...
#>   ..$ BTD       : num [1:4, 1:4] 6.12e+01 3.71e+01 -4.94e-05 3.76e-01 3.71e+01 ...
#>   ..$ BTK       : num [1:4, 1:4] 9.01 5.80 2.38e-05 1.80e-01 5.80 ...
#>   ..$ SERPING1  : num [1:4, 1:4] 49.4224 25.9865 -0.0531 0.026 25.9865 ...
#>   ..$ C2        : num [1:4, 1:4] 5.103 2.8809 -0.0282 0.0937 2.8809 ...
#>   ..$ C3        : num [1:4, 1:4] 5.5587 4.09012 -0.47577 0.00521 4.09012 ...
#>   ..$ C6        : num [1:4, 1:4] 1.71e+01 1.04e+01 -1.87e-05 2.39e-01 1.04e+01 ...
#>   ..$ C8B       : num [1:4, 1:4] 10.09936 6.10875 -0.00615 0.15519 6.10875 ...
#>   ..$ CA2       : num [1:4, 1:4] 13.8916 9.0746 -0.1687 0.0134 9.0746 ...
#>   ..$ CACNA1S   : num [1:4, 1:4] 1.36e+01 7.37 -2.42e-05 2.17e-01 7.37 ...
#>   ..$ CBS       : num [1:4, 1:4] 53.7688 32.9032 -0.0282 0.2441 32.9032 ...
#>   ..$ CD36      : num [1:4, 1:4] 2.01e+01 9.88 -7.53e-05 2.51e-01 9.88 ...
#>   ..$ CD3G      : num [1:4, 1:4] 8.57 5.47 8.28e-07 1.79e-01 5.47 ...
#>   ..$ CD40LG    : num [1:4, 1:4] 7.45 5.07 -8.82e-06 1.70e-01 5.07 ...
#>   ..$ CDK4      : num [1:4, 1:4] 1.13e+02 7.64e+01 -2.24e-04 4.43e-01 7.64e+01 ...
#>   ..$ CDKN1C    : num [1:4, 1:4] 20.043 5.445 -0.156 0.018 5.445 ...
#>   ..$ CETP      : num [1:4, 1:4] 7.99 5.22 -5.37e-05 1.73e-01 5.22 ...
#>   ..$ CHRNE     : num [1:4, 1:4] 20.92902 14.39928 -0.00163 0.22871 14.39928 ...
#>   ..$ LYST      : num [1:4, 1:4] 7.79e+01 4.83e+01 -7.17e-06 3.96e-01 4.83e+01 ...
#>   ..$ ERCC8     : num [1:4, 1:4] 2.59e+01 2.00e+01 -3.07e-05 2.76e-01 2.00e+01 ...
#>   ..$ CLCN1     : num [1:4, 1:4] 6.863622 4.752721 0.000853 0.145601 4.752721 ...
#>   ..$ CLCN5     : num [1:4, 1:4] 12.3019 8.8857 -0.0996 0.1002 8.8857 ...
#>   ..$ CLN3      : num [1:4, 1:4] 7.92e+01 5.70e+01 9.40e-05 3.92e-01 5.70e+01 ...
#>   ..$ CNGA1     : num [1:4, 1:4] 2.21e+01 1.39e+01 6.66e-05 2.56e-01 1.39e+01 ...
#>   ..$ COL1A1    : num [1:4, 1:4] 14.2009 9.3169 -0.0846 0.0986 9.3169 ...
#>   ..$ COL1A2    : num [1:4, 1:4] 15.9212 8.5399 -0.1707 0.0259 8.5399 ...
#>   ..$ COL4A3    : num [1:4, 1:4] 44.8777 14.5803 -0.0867 0.0889 14.5803 ...
#>   ..$ COL5A1    : num [1:4, 1:4] 9.4377 5.696 -0.1002 0.0801 5.696 ...
#>   ..$ COMP      : num [1:4, 1:4] 2.56e+01 1.57e+01 -5.74e-05 2.82e-01 1.57e+01 ...
#>   ..$ CP        : num [1:4, 1:4] 15.15352 9.35684 0.00317 0.15809 9.35684 ...
#>   ..$ CPOX      : num [1:4, 1:4] 4.515809 3.034811 0.000221 0.127528 3.034811 ...
#>   ..$ CPT2      : num [1:4, 1:4] 46.5937 33.1216 -0.0215 0.24 33.1216 ...
#>   ..$ CST3      : num [1:4, 1:4] 126.617 71.484 -0.079 0.142 71.484 ...
#>   ..$ CSTB      : num [1:4, 1:4] 219.4472 130.611 0.0389 0.2303 130.611 ...
#>   ..$ CYP17A1   : num [1:4, 1:4] 9.67 5.8364 -0.1018 0.0993 5.8364 ...
#>   ..$ CYP19A1   : num [1:4, 1:4] 1.05e+01 6.49 2.92e-05 1.92e-01 6.49 ...
#>   ..$ CYP1B1    : num [1:4, 1:4] 17.7689 8.5408 -0.1127 0.0577 8.5408 ...
#>   ..$ CYP2D6    : num [1:4, 1:4] 24.6631 14.2632 -0.0171 0.2062 14.2632 ...
#>   ..$ DDB2      : num [1:4, 1:4] 1.79e+01 1.12e+01 -9.89e-05 2.48e-01 1.12e+01 ...
#>   ..$ DLD       : num [1:4, 1:4] 31.1145 21.3926 -0.0194 0.1057 21.3926 ...
#>   ..$ SLC26A3   : num [1:4, 1:4] 6.27 4.29 -2.19e-05 1.58e-01 4.29 ...
#>   ..$ SLC26A2   : num [1:4, 1:4] 2.58e+01 1.44e+01 3.20e-05 2.76e-01 1.44e+01 ...
#>   ..$ TOR1A     : num [1:4, 1:4] 24.5701 14.6413 0.0094 0.2208 14.6413 ...
#>   ..$ EDN3      : num [1:4, 1:4] 6.2384 4.4514 -0.0121 0.1262 4.4514 ...
#>   ..$ EMD       : num [1:4, 1:4] 1.53e+02 1.02e+02 3.06e-04 4.58e-01 1.02e+02 ...
#>   ..$ EPB42     : num [1:4, 1:4] 4.98e+01 2.70e+01 -4.45e-05 3.49e-01 2.70e+01 ...
#>   ..$ EPHX1     : num [1:4, 1:4] 89.4469 50.2899 -0.0287 0.2761 50.2899 ...
#>   ..$ EPOR      : num [1:4, 1:4] 4.73e+01 3.83e+01 1.07e-04 3.27e-01 3.83e+01 ...
#>   ..$ ERCC5     : num [1:4, 1:4] 55.2424 31.719 -0.0106 0.2411 31.719 ...
#>   ..$ ESR1      : num [1:4, 1:4] 2.89e+01 1.75e+01 -9.72e-05 2.93e-01 1.75e+01 ...
#>   ..$ EXT1      : num [1:4, 1:4] 6.06e+01 3.97e+01 -2.81e-06 3.72e-01 3.97e+01 ...
#>   ..$ F11       : num [1:4, 1:4] 9.266 6.973 -0.048 0.128 6.973 ...
#>   ..$ F13A1     : num [1:4, 1:4] 1.97e+01 1.52e+01 -5.98e-05 2.49e-01 1.52e+01 ...
#>   ..$ F5        : num [1:4, 1:4] 8.9431 2.5827 -0.0194 0.0897 2.5827 ...
#>   ..$ F9        : num [1:4, 1:4] 5.31e-02 -1.27e-02 -8.84e-07 1.97e-02 -1.27e-02 ...
#>   ..$ FABP2     : num [1:4, 1:4] 1.603669 1.039005 0.000355 0.081274 1.039005 ...
#>   ..$ FANCA     : num [1:4, 1:4] 1.25e+01 8.58 -1.56e-05 2.10e-01 8.58 ...
#>   ..$ FAH       : num [1:4, 1:4] 33.6251 20.5492 -0.0247 0.1941 20.5492 ...
#>   ..$ MS4A2     : num [1:4, 1:4] 2.36 1.51 -6.49e-06 1.02e-01 1.51 ...
#>   ..$ FECH      : num [1:4, 1:4] 19.8499 14.0699 -0.1093 0.0737 14.0699 ...
#>   ..$ FGFR2     : num [1:4, 1:4] 2.73e+01 2.22e+01 9.89e-05 2.70e-01 2.22e+01 ...
#>   ..$ FH        : num [1:4, 1:4] 30.8131 20.7216 -0.0877 0.1206 20.7216 ...
#>   ..$ FSHR      : num [1:4, 1:4] 5.00 3.48 -1.62e-05 1.42e-01 3.48 ...
#>   ..$ FUCA1     : num [1:4, 1:4] 47.0806 35.6624 0.0473 0.1502 35.6624 ...
#>   ..$ FUT1      : num [1:4, 1:4] 1.05e+01 5.59 2.35e-05 1.90e-01 5.59 ...
#>   ..$ FUT6      : num [1:4, 1:4] 9.4804 6.3025 -0.1181 0.0734 6.3025 ...
#>   ..$ G6PC      : num [1:4, 1:4] 4.9631 3.0396 -0.1614 0.0424 3.0396 ...
#>   ..$ GALC      : num [1:4, 1:4] 47.60254 23.18092 -0.00839 0.24879 23.18092 ...
#>   .. [list output truncated]
#>  $ conv0        : num [1:1500, 1] 0 0 0 0 0 0 0 0 0 0 ...
#>   ..- attr(*, "names")= chr [1:1500] "DDT" "FOSL1" "FKBP11" "PIM1" ...
#>  $ conv         : num [1:18439, 1] 0 0 0 0 0 0 0 0 0 0 ...
#>   ..- attr(*, "names")= chr [1:18439] "A2M" "NAT2" "ACADM" "ACADS" ...
#>  $ features_high: chr [1:1500] "DDT" "FOSL1" "FKBP11" "PIM1" ...
#>  $ features_all : chr [1:18439] "A2M" "NAT2" "ACADM" "ACADS" ...
```

### Mixed effect model

First take a look at the study design. It shows the two levels of region both exist in the same patient ID. This indicates the random effect model with random slope would be appropriate, still we fit both random intercept model and random slope model to showcase the capability of the mixed model function.

Here we subset features\_high to speed up DE in later steps as only these 30 genes are modeled.

```
pData(kidney)$region <- factor(pData(kidney)$region, levels=c("glomerulus", "tubule"))

table(pData(kidney)[, c("region", "slide name")])
#>             slide name
#> region       disease3 normal3
#>   glomerulus        4       4
#>   tubule            4       4

features_high_subset <- features_high[1:30]
```

Random intercept model only for high genes as an example, takes about 1 hour on the full dataset.

```
set.seed(123)
NBthmDEmod <- fitNBthmDE(object = kidney,
                         form = ~ region+(1|`slide name`),
                         ROIs_high = ROIs_high,
                         split = FALSE,
                         features_all = features_high_subset,
                         preci1=NBthDEmod$preci1,
                         threshold_mean = bgMean,
                         sizescale = TRUE,
                         controlRandom=list(nu=12, nmh_e=400, thin_e=60))

str(NBthmDEmod)
#> List of 17
#>  $ X            : num [1:16, 1:2] 1 1 1 1 1 1 1 1 1 1 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:16] "DSP-1001250007851-H-A02.dcc" "DSP-1001250007851-H-A03.dcc" "DSP-1001250007851-H-A04.dcc" "DSP-1001250007851-H-A05.dcc" ...
#>   .. ..$ : chr [1:2] "(Intercept)" "regiontubule"
#>   ..- attr(*, "assign")= int [1:2] 0 1
#>   ..- attr(*, "contrasts")=List of 1
#>   .. ..$ region: chr "contr.treatment"
#>   ..- attr(*, "msgScaleX")= chr(0)
#>  $ Z            : num [1:16, 1:2] 1 1 1 1 0 0 0 0 0 0 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:16] "DSP-1001250007851-H-A02.dcc" "DSP-1001250007851-H-A03.dcc" "DSP-1001250007851-H-A04.dcc" "DSP-1001250007851-H-A05.dcc" ...
#>   .. ..$ : chr [1:2] "disease3" "normal3"
#>  $ rt           :List of 10
#>   ..$ Zt     :Formal class 'dgCMatrix' [package "Matrix"] with 6 slots
#>   .. .. ..@ i       : int [1:16] 0 0 0 0 1 1 1 1 1 1 ...
#>   .. .. ..@ p       : int [1:17] 0 1 2 3 4 5 6 7 8 9 ...
#>   .. .. ..@ Dim     : int [1:2] 2 16
#>   .. .. ..@ Dimnames:List of 2
#>   .. .. .. ..$ : chr [1:2] "disease3" "normal3"
#>   .. .. .. ..$ : chr [1:16] "DSP-1001250007851-H-A02.dcc" "DSP-1001250007851-H-A03.dcc" "DSP-1001250007851-H-A04.dcc" "DSP-1001250007851-H-A05.dcc" ...
#>   .. .. ..@ x       : num [1:16] 1 1 1 1 1 1 1 1 1 1 ...
#>   .. .. ..@ factors : list()
#>   ..$ theta  : num 1
#>   ..$ Lind   : int [1:2] 1 1
#>   ..$ Gp     : int [1:2] 0 2
#>   ..$ lower  : num 0
#>   ..$ Lambdat:Formal class 'dgCMatrix' [package "Matrix"] with 6 slots
#>   .. .. ..@ i       : int [1:2] 0 1
#>   .. .. ..@ p       : int [1:3] 0 1 2
#>   .. .. ..@ Dim     : int [1:2] 2 2
#>   .. .. ..@ Dimnames:List of 2
#>   .. .. .. ..$ : NULL
#>   .. .. .. ..$ : NULL
#>   .. .. ..@ x       : num [1:2] 1 1
#>   .. .. ..@ factors : list()
#>   ..$ flist  :List of 1
#>   .. ..$ slide name: Factor w/ 2 levels "disease3","normal3": 1 1 1 1 2 2 2 2 2 2 ...
#>   .. ..- attr(*, "assign")= int 1
#>   ..$ cnms   :List of 1
#>   .. ..$ slide name: chr "(Intercept)"
#>   ..$ Ztlist :List of 1
#>   .. ..$ 1 | `slide name`:Formal class 'dgCMatrix' [package "Matrix"] with 6 slots
#>   .. .. .. ..@ i       : int [1:16] 0 0 0 0 1 1 1 1 1 1 ...
#>   .. .. .. ..@ p       : int [1:17] 0 1 2 3 4 5 6 7 8 9 ...
#>   .. .. .. ..@ Dim     : int [1:2] 2 16
#>   .. .. .. ..@ Dimnames:List of 2
#>   .. .. .. .. ..$ : chr [1:2] "disease3" "normal3"
#>   .. .. .. .. ..$ : chr [1:16] "DSP-1001250007851-H-A02.dcc" "DSP-1001250007851-H-A03.dcc" "DSP-1001250007851-H-A04.dcc" "DSP-1001250007851-H-A05.dcc" ...
#>   .. .. .. ..@ x       : num [1:16] 1 1 1 1 1 1 1 1 1 1 ...
#>   .. .. .. ..@ factors : list()
#>   ..$ nl     : Named int 2
#>   .. ..- attr(*, "names")= chr "slide name"
#>  $ para0        : logi NA
#>  $ para         : num [1:4, 1:30] 0.316 0.983 25.049 1 0.315 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:4] "(Intercept)" "regiontubule" "r" "threshold"
#>   .. ..$ : chr [1:30] "ACADM" "CPT2" "DLD" "EPOR" ...
#>  $ sizefact     : Named num [1:16] 0.0685 0.0458 0.043 0.0545 0.0742 ...
#>   ..- attr(*, "names")= chr [1:16] "DSP-1001250007851-H-A02.dcc" "DSP-1001250007851-H-A03.dcc" "DSP-1001250007851-H-A04.dcc" "DSP-1001250007851-H-A05.dcc" ...
#>  $ sizefact0    : logi NA
#>  $ preci1       : num [1:2, 1:2] 0.04 0.02 0.02 1.41
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:2] "(Intercept)" "regiontubule"
#>   .. ..$ : chr [1:2] "(Intercept)" "regiontubule"
#>  $ conv0        : logi NA
#>  $ conv         : Named num [1:30] 1 1 1 1 1 1 1 1 1 1 ...
#>   ..- attr(*, "names")= chr [1:30] "ACADM" "CPT2" "DLD" "EPOR" ...
#>  $ Im0          : logi NA
#>  $ Im           :List of 30
#>   ..$ ACADM  : num [1:4, 1:4] -13.758 -9.6919 0.0169 -2.6892 -9.6919 ...
#>   ..$ CPT2   : num [1:4, 1:4] 10.54007 7.58089 -0.00985 9.06924 7.58089 ...
#>   ..$ DLD    : num [1:4, 1:4] -7.20 -5.94 4.78e-05 -3.02 -5.94 ...
#>   ..$ EPOR   : num [1:4, 1:4] 2.06e+01 1.67e+01 -8.86e-06 2.28e+01 1.67e+01 ...
#>   ..$ EXT1   : num [1:4, 1:4] 2.53e+01 1.66e+01 -3.26e-05 2.50e+01 1.66e+01 ...
#>   ..$ FAH    : num [1:4, 1:4] 18.67848 11.03644 0.00448 16.12426 11.03644 ...
#>   ..$ FUCA1  : num [1:4, 1:4] 37.9216 28.3651 0.0402 19.4395 28.3651 ...
#>   ..$ GALC   : num [1:4, 1:4] 2.55e+01 1.31e+01 7.60e-05 2.11e+01 1.31e+01 ...
#>   ..$ GCDH   : num [1:4, 1:4] 16.007108 11.856229 -0.000202 22.516921 11.856229 ...
#>   ..$ HMGCL  : num [1:4, 1:4] 8.09586 5.68893 -0.00836 5.90205 5.68893 ...
#>   ..$ SGSH   : num [1:4, 1:4] 31.398879 20.798212 -0.000164 30.110903 20.798212 ...
#>   ..$ IDUA   : num [1:4, 1:4] 24.90896 16.5413 0.00559 18.80844 16.5413 ...
#>   ..$ ITGA6  : num [1:4, 1:4] 11.47 7.7 0.02 5.26 7.7 ...
#>   ..$ MTR    : num [1:4, 1:4] 4.0096 2.9677 0.0398 3.8683 2.9677 ...
#>   ..$ POU3F4 : num [1:4, 1:4] 2.28e+01 1.75e+01 -4.38e-06 3.40e+01 1.75e+01 ...
#>   ..$ TCN2   : num [1:4, 1:4] 11.6566 6.2443 -0.0671 8.5455 6.2443 ...
#>   ..$ UROS   : num [1:4, 1:4] 1.43e+01 1.15e+01 2.55e-05 1.27e+01 1.15e+01 ...
#>   ..$ WAS    : num [1:4, 1:4] 1.05e+01 7.38 5.32e-05 1.39e+01 7.38 ...
#>   ..$ COL5A2 : num [1:4, 1:4] 1.14e+01 6.93 5.60e-05 7.60 6.93 ...
#>   ..$ CRYAA  : num [1:4, 1:4] 4.3882 2.1914 -0.0533 4.8393 2.1914 ...
#>   ..$ CTSK   : num [1:4, 1:4] 1.93e+01 1.38e+01 1.07e-04 2.70e+01 1.38e+01 ...
#>   ..$ HLCS   : num [1:4, 1:4] 2.17e+01 1.65e+01 -3.24e-05 3.19e+01 1.65e+01 ...
#>   ..$ HSD17B4: num [1:4, 1:4] -7.38 -5.85 -4.52e-05 -4.26 -5.85 ...
#>   ..$ IL4R   : num [1:4, 1:4] 1.22e+01 4.90 -1.78e-05 1.41e+01 4.90 ...
#>   ..$ UBE3A  : num [1:4, 1:4] 10.90394 6.65153 0.00593 10.82684 6.65153 ...
#>   ..$ AMT    : num [1:4, 1:4] 1.98e+01 1.41e+01 7.88e-05 2.86e+01 1.41e+01 ...
#>   ..$ FBP1   : num [1:4, 1:4] 5.798 3.798 0.035 3.691 3.798 ...
#>   ..$ GH1    : num [1:4, 1:4] 1.78e+01 1.15e+01 5.53e-06 2.01e+01 1.15e+01 ...
#>   ..$ KCNJ11 : num [1:4, 1:4] 1.78e+01 1.26e+01 -3.09e-05 2.63e+01 1.26e+01 ...
#>   ..$ SMPD1  : num [1:4, 1:4] 2.90e+01 1.62e+01 -6.89e-05 3.03e+01 1.62e+01 ...
#>  $ features_high: logi NA
#>  $ features_all : chr [1:30] "ACADM" "CPT2" "DLD" "EPOR" ...
#>  $ theta        : num [1, 1:30] 0.917 0.238 0.969 0.192 0.174 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : NULL
#>   .. ..$ : chr [1:30] "ACADM" "CPT2" "DLD" "EPOR" ...
#>   ..- attr(*, "names")= chr [1:30] "ACADM" "CPT2" "DLD" "EPOR" ...
#>  $ varcov       : num [1, 1:30] 0.8414 0.0567 0.9391 0.0369 0.0304 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : NULL
#>   .. ..$ : chr [1:30] "ACADM" "CPT2" "DLD" "EPOR" ...
#>  $ Uvec         : num [1:2, 1:30] 0.10845 1.2896 0.00944 0.24002 0.08512 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : NULL
#>   .. ..$ : chr [1:30] "ACADM" "CPT2" "DLD" "EPOR" ...
```

Random slope model (recommended for this study design), takes about 4 hours on the full dataset.

```
set.seed(123)
NBthmDEmodslope <- fitNBthmDE(object = kidney,
                              form = ~ region+(1+region|`slide name`),
                              ROIs_high = ROIs_high,
                              split = FALSE,
                              features_all = features_high_subset,
                              preci1=NBthDEmod$preci1,
                              threshold_mean = bgMean,
                              sizescale = TRUE,
                              controlRandom=list(nu=12, nmh_e=400, thin_e=60))
```

Relation between models.

```
plot(NBthDEmod$para[2,names(NBthmDEmod$para[2,])], NBthmDEmod$para[2,],
     xlab = "Fixed Effect Model Output Parameters", ylab = "Mixed Effect Model Output Parameters")
abline(a=0,b=1)
```

![](data:image/png;base64...)

```
plot(NBthDEmod$para[2,names(NBthmDEmodslope$para[2,])], NBthmDEmodslope$para[2,],
     xlab = "Fixed Effect Model Output Parameters", ylab = "Random Slope Model Output Parameters")
abline(a=0,b=1)
```

![](data:image/png;base64...)

Genes with larger difference in estimates between fixed effect model and random slope model have larger random effect variance for the random slope.

```
diff_high <- names(which(abs(NBthDEmod$para[2,names(NBthmDEmodslope$para[2,])]-
                               NBthmDEmodslope$para[2,])>0.6))
diff_high
#> [1] "ACADM" "DLD"   "FUCA1"
set.seed(123)

NBthmDEmodslope$theta[3, "ACADM"]
#>     ACADM
#> 0.8217112

annot <- pData(kidney)
annot$ACADM <- posdat["ACADM",]
```

The figure below shows there are huge variation in the difference between two levels of region within each slide.

```
plot_dat <- annot[,c("region", "ACADM", "slide name")]

p <- ggplot(plot_dat, aes(x=`slide name`, y=ACADM, fill=region)) +
  geom_boxplot()

plot(p)
```

![](data:image/png;base64...)

### Generate DE result

A list of inference results can be generated using coefNBth. This produces a list of Wald test inference results on model coefficients.

```
coeff <- coefNBth(NBthDEmod)
coefr <- coefNBth(NBthmDEmod)
coefrslope <- coefNBth(NBthmDEmodslope)

str(coeff)
#> List of 4
#>  $ estimate : num [1:2, 1:18439] 12.3783 -1.5742 6.6138 -0.0494 8.401 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:2] "(Intercept)" "regiontubule"
#>   .. ..$ : chr [1:18439] "A2M" "NAT2" "ACADM" "ACADS" ...
#>  $ wald_stat: num [1:2, 1:18439] 45.036 -3.835 16.565 -0.106 28.026 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:2] "(Intercept)" "regiontubule"
#>   .. ..$ : chr [1:18439] "A2M" "NAT2" "ACADM" "ACADS" ...
#>  $ p_value  : num [1:2, 1:18439] 0.00 1.25e-04 1.24e-61 9.15e-01 7.81e-173 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:2] "(Intercept)" "regiontubule"
#>   .. ..$ : chr [1:18439] "A2M" "NAT2" "ACADM" "ACADS" ...
#>  $ se       : num [1:2, 1:18439] 0.275 0.41 0.399 0.465 0.3 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:2] "(Intercept)" "regiontubule"
#>   .. ..$ : chr [1:18439] "A2M" "NAT2" "ACADM" "ACADS" ...
```

If you see an NA it is an extremely insignificant gene, these p-values can be changed to 1.

We can find the baselevel of this DE comparison by looking at the comparison name after coefNBth. The base level is not listed here as it is what everything else is compared to. So in this case the base level is regionglomerulus.

```
rownames(coeff$estimate)[-1]
#> [1] "regiontubule"
```

DE tables can be generated using DENBth. This will produce a table using the inference list generated by coefNBth. Negative fold changes indicate higher expression in the base condition.

```
DEtab <- DENBth(coeff, variable = "regiontubule")
DEtabr <- DENBth(coefr, variable = "regiontubule")
DEtabrslope <- DENBth(coefrslope, variable = "regiontubule")

head(DEtab)
#>             log2FC       pvalue         adjp
#> A2M    -1.57418905 1.253401e-04 3.533863e-03
#> NAT2   -0.04940311 9.153924e-01 9.999853e-01
#> ACADM   0.99602679 5.627888e-03 7.712778e-02
#> ACADS   0.58740387 1.460334e-02 1.569391e-01
#> ACAT1   1.19268220 4.517334e-03 6.538078e-02
#> ACVRL1 -1.36849239 9.799709e-07 5.090052e-05
```

For datasets with multiple comparisons, contrastNBth() can be used to create all pair-wise comparisons. That output can also be run through DENBth to create a DE table.

## Normalization

Here we normalize the data using a Poisson threshold model based normalization-log2 transformation. In this first normalization, we will not split by slide.

```
set.seed(123)

names(assayData(kidney))
#> [1] "exprs"

kidney <- fitPoisthNorm(object = kidney,
                        ROIs_high = ROIs_high,
                        threshold_mean = bgMean,
                        sizescalebythreshold = TRUE)
#> probe finished
#> Iteration = 1, squared error = 2.91754531023175e-10
#> probe finished
#> Iteration = 2, squared error = 3.26328541435472e-06
#> Model converged.

names(assayData(kidney))
#> [1] "exprs"    "normmat"  "normmat0"

head(fData(kidney)[,(ncol(fData(kidney))-6):ncol(fData(kidney))])
#>        feature_high_fitNBth para0_norm.var1 para0_norm.var2 para0_norm.var3
#> A2M                       0              NA              NA              NA
#> NAT2                      0              NA              NA              NA
#> ACADM                     1      0.76373984     -0.05916228      0.31052135
#> ACADS                     0              NA              NA              NA
#> ACAT1                     0              NA              NA              NA
#> ACVRL1                    0              NA              NA              NA
#>        para0_norm.var4 para0_norm.var5 para0_norm.var6 para0_norm.var7
#> A2M                 NA              NA              NA              NA
#> NAT2                NA              NA              NA              NA
#> ACADM       0.88761436      2.15986536      2.84090288      2.23548133
#> ACADS               NA              NA              NA              NA
#> ACAT1               NA              NA              NA              NA
#> ACVRL1              NA              NA              NA              NA
#>        para0_norm.var8 para0_norm.var9 para0_norm.var10 para0_norm.var11
#> A2M                 NA              NA               NA               NA
#> NAT2                NA              NA               NA               NA
#> ACADM       3.18795382      1.50015562       1.91174994       0.39531923
#> ACADS               NA              NA               NA               NA
#> ACAT1               NA              NA               NA               NA
#> ACVRL1              NA              NA               NA               NA
#>        para0_norm.var12 para0_norm.var13 para0_norm.var14 para0_norm.var15
#> A2M                  NA               NA               NA               NA
#> NAT2                 NA               NA               NA               NA
#> ACADM        1.23939853       1.44930550       1.00497996       0.76812843
#> ACADS                NA               NA               NA               NA
#> ACAT1                NA               NA               NA               NA
#> ACVRL1               NA               NA               NA               NA
#>        para0_norm.var16 para0_norm.var17 para_norm.var1 para_norm.var2
#> A2M                  NA               NA     5.38702209     5.07771273
#> NAT2                 NA               NA    -0.88353080     0.21187517
#> ACADM        1.97825644       0.99999492     0.78233085     0.19737554
#> ACADS                NA               NA     0.50405487     0.41515531
#> ACAT1                NA               NA     0.69858913     1.07797143
#> ACVRL1               NA               NA     1.77675492     0.98993152
#>        para_norm.var3 para_norm.var4 para_norm.var5 para_norm.var6
#> A2M        4.95417730     5.08075695     0.83120061     3.16967304
#> NAT2      -1.39558687    -0.03454269    -1.44618151    -0.15917182
#> ACADM      0.38932376     0.88371496     2.15562564     2.82486903
#> ACADS      1.25404543     0.41872669     0.99477388     1.42998840
#> ACAT1      1.04697213     0.39462843     3.39672239     3.56289950
#> ACVRL1     1.33244422     1.04010075    -0.45056197    -0.02372771
#>        para_norm.var7 para_norm.var8 para_norm.var9 para_norm.var10
#> A2M        1.08418321     3.48814015     5.48093549      5.30352575
#> NAT2      -0.52774955    -0.96280223     0.37662693     -1.20564324
#> ACADM      2.24539182     3.17786194     1.48169333      1.87766532
#> ACADS      1.90871342     1.94181042     1.31420424     -0.01536813
#> ACAT1      2.83223630     4.29470891     1.33883516      1.65890371
#> ACVRL1    -0.27510003     0.40076473     2.33391514      1.82097597
#>        para_norm.var11 para_norm.var12 para_norm.var13 para_norm.var14
#> A2M         5.32603687      5.14175520      2.82420302      4.89964033
#> NAT2       -0.52438320     -0.76408312     -0.08729068     -0.39533007
#> ACADM       0.59371945      1.26660975      1.44532167      1.05468387
#> ACADS       1.15446980      1.21531708      1.34502889      1.15202447
#> ACAT1       2.59369045      2.13079198      2.03942818      2.03560798
#> ACVRL1      1.36677139      1.77829576      0.56330890      0.97886823
#>        para_norm.var15 para_norm.var16 para_norm.var17 conv0 conv features_high
#> A2M         1.96804202      3.75187158      0.99984959    NA    0            NA
#> NAT2       -0.63478752     -0.31499497      0.99946387    NA    0            NA
#> ACADM       0.89408800      1.93904300      0.99995722     0    0             1
#> ACADS       0.99706676      1.05952507      0.99990491    NA    0            NA
#> ACAT1       1.21601300      2.02759855      0.99980196    NA    0            NA
#> ACVRL1      0.07202561      0.05830864      0.99987044    NA    0            NA
#>        features_all
#> A2M               1
#> NAT2              1
#> ACADM             1
#> ACADS             1
#> ACAT1             1
#> ACVRL1            1

head(pData(kidney))
#>                             construct read_pattern expected_neg slide name
#> DSP-1001250007851-H-A02.dcc directPCR         2x27            0   disease3
#> DSP-1001250007851-H-A03.dcc directPCR         2x27            0   disease3
#> DSP-1001250007851-H-A04.dcc directPCR         2x27            0   disease3
#> DSP-1001250007851-H-A05.dcc directPCR         2x27            0   disease3
#> DSP-1001250007864-D-A02.dcc directPCR         2x27            0    normal3
#> DSP-1001250007864-D-A03.dcc directPCR         2x27            0    normal3
#>                              class           segment     area     region
#> DSP-1001250007851-H-A02.dcc    DKD Geometric Segment 31797.59 glomerulus
#> DSP-1001250007851-H-A03.dcc    DKD Geometric Segment 16920.10 glomerulus
#> DSP-1001250007851-H-A04.dcc    DKD Geometric Segment 14312.33 glomerulus
#> DSP-1001250007851-H-A05.dcc    DKD Geometric Segment 20032.84 glomerulus
#> DSP-1001250007864-D-A02.dcc normal             PanCK 20265.55     tubule
#> DSP-1001250007864-D-A03.dcc normal               neg 91483.62     tubule
#>                             pathology nuclei   sizefact sizefact_sp
#> DSP-1001250007851-H-A02.dcc  abnormal  16871 0.07178719  0.07178719
#> DSP-1001250007851-H-A03.dcc  abnormal  17684 0.04699198  0.04699198
#> DSP-1001250007851-H-A04.dcc  abnormal  15108 0.03800758  0.03800758
#> DSP-1001250007851-H-A05.dcc  abnormal  15271 0.05091165  0.05091165
#> DSP-1001250007864-D-A02.dcc        NA  15471 0.03893244  0.03893244
#> DSP-1001250007864-D-A03.dcc        NA  14470 0.10618339  0.10618339
#>                             sizefact_fitNBth     0.75      0.8      0.9
#> DSP-1001250007851-H-A02.dcc       0.06852788 17.18841 20.18841 29.18841
#> DSP-1001250007851-H-A03.dcc       0.04575636 12.26812 14.26812 20.26812
#> DSP-1001250007851-H-A04.dcc       0.04295373 10.74638 12.74638 18.74638
#> DSP-1001250007851-H-A05.dcc       0.05450095 13.62319 16.62319 23.62319
#> DSP-1001250007864-D-A02.dcc       0.07420946 16.59420 20.59420 32.59420
#> DSP-1001250007864-D-A03.dcc       0.10564591 25.52899 30.52899 48.52899
#>                                 0.95 sizefact_norm sizefact0_norm
#> DSP-1001250007851-H-A02.dcc 43.18841    0.06885679     0.06852690
#> DSP-1001250007851-H-A03.dcc 30.26812    0.04577810     0.04575708
#> DSP-1001250007851-H-A04.dcc 27.74638    0.04273820     0.04295500
#> DSP-1001250007851-H-A05.dcc 35.62319    0.05466829     0.05450382
#> DSP-1001250007864-D-A02.dcc 50.59420    0.07343304     0.07420609
#> DSP-1001250007864-D-A03.dcc 75.52899    0.10529391     0.10563945
```

After normalization, 2 matrices are added to the assayData:

normmat0 - normalization after iteration 1

normmat - normalization after iteration 2

Convergence and parameter values are added to pData and fData.

In this normalize, we split by slide.

```
set.seed(123)

kidney <- fitPoisthNorm(object = kidney,
                        split = TRUE,
                        ROIs_high = ROIs_high,
                        threshold_mean = bgMean,
                        sizescalebythreshold = TRUE)
#> The results are based on stored `groupvar`, slide name
#> probe finished
#> Iteration = 1, squared error = 0.0312926443045409
#> probe finished
#> Iteration = 2, squared error = 5.03280049509318e-06
#> Model converged.
#> probe finished
#> Iteration = 1, squared error = 0.0481495578446135
#> probe finished
#> Iteration = 2, squared error = 1.54012866325245e-06
#> Model converged.

names(assayData(kidney))
#> [1] "exprs"       "normmat0_sp" "normmat"     "normmat_sp"  "normmat0"
```

After normalization, 2 matrices are added to the assayData labeled with -sp for split:

normmat0-sp - normalization after iteration 1

normmat-sp - normalization after iteration 2

### Comparison of normalization methods

Compared to quantile 75 (Q3) normalization

```
norm_dat_backqu75 <- sweep(posdat[, ROIs_high], 2,
                           (kidney[, ROIs_high]$sizefact * bgMean),
                           FUN = "-") %>%
  sweep(., 2, quan75[ROIs_high], FUN = "/") %>%
  pmax(., 0) %>%
  `+`(., 0.01) %>%
  log2()
```

```
dat_plot <- cbind(pData(kidney)[ROIs_high, c("slide name", "region")],
                  t(norm_dat_backqu75[features_all, ]))

dat_plot <- cbind(dat_plot, ROI_ID = ROIs_high)

dat_plot <- melt(dat_plot, id.vars = c("ROI_ID", "slide name", "region"))

ggplot(dat_plot, aes(x = value)) +
  geom_density(aes(fill = region, group = ROI_ID, alpha = 0.01)) +
  facet_grid(~`slide name`) +
  ggtitle("Q3 Normalization")+
  labs(x = "Q3 Normalized Value (log2)")
```

![](data:image/png;base64...)

Here you can see that Q3 normalization is prone to low values.

```
annot <- pData(kidney)

dat_plot <- cbind(annot[ROIs_high, c("slide name", "region")],
                  t(assayDataElement(kidney[features_high, ROIs_high], "normmat_sp")))

dat_plot <- cbind(dat_plot, ROI_ID = ROIs_high)

dat_plot <- melt(dat_plot, id.vars = c("ROI_ID", "slide name", "region"))

ggplot(dat_plot, aes(x = value)) +
  geom_density(aes(fill = region, group = ROI_ID, alpha = 0.01)) +
  facet_wrap(~`slide name`) +
  ggtitle("Poisson threshold normalization")+
  labs(x = "Poisson Threshold Normalized Value (log2)")
```

![](data:image/png;base64...)

In contrast, you can see that the poisson threshold normalized values follow more of a normal curve, eliminating the spikes in low values.

#### Clustering

```
dat <- t(norm_dat_backqu75[features_high, ])
dat_pca <- prcomp(dat, center = TRUE, scale. = TRUE)
dat <- as.data.frame(dat)

dat$PC1 <- dat_pca$x[, 1]
dat$PC2 <- dat_pca$x[, 2]
dat$id <- annot$`slide name`[match(ROIs_high, colnames(posdat))]
dat$class <- annot$class[match(ROIs_high, colnames(posdat))]
dat$region <- annot$region[match(ROIs_high, colnames(posdat))]
dat$sizeratio <- kidney[, ROIs_high]$sizefact_fitNBth / kidney[, ROIs_high]$sizefact

p <- ggplot(data = dat, aes(x = PC1, y = PC2)) +
  geom_point(aes(colour = paste(class, region))) +
  theme_bw()+
  labs(title = "Q3 Normalized Data")

plot(p)
```

![](data:image/png;base64...)

```
p <- ggplot(data = dat, aes(x = PC1, y = PC2)) +
  geom_point(aes(colour = log2(sizeratio))) +
  theme_bw()+
  scale_color_gradient2(high = "gold", mid = "grey50", low = "darkblue", midpoint = 0.2)+
  labs(title = "Q3 Normalized Data")

plot(p)
```

![](data:image/png;base64...)

As you can see in the first PCA plot, the ROIs cluster by region and class. However, the first PC is mostly driven by the ratio of background to signal size ratio as shown in the second PCA plot.

With the Poisson Threshold normalization, the ROIs still cluster by region and class but the first PC is not strictly driven by the background to signal size ratio.

```
dat <- t(assayDataElement(kidney[features_high, ROIs_high],"normmat_sp"))
dat_pca <- prcomp(dat, center = TRUE, scale. = TRUE)
dat <- as.data.frame(dat)

dat$PC1 <- dat_pca$x[, 1]
dat$PC2 <- dat_pca$x[, 2]
dat$id <- annot$`slide name`[match(ROIs_high, colnames(posdat))]
dat$class <- annot$class[match(ROIs_high, colnames(posdat))]
dat$region <- annot$region[match(ROIs_high, colnames(posdat))]
dat$sizeratio <- kidney[, ROIs_high]$sizefact_fitNBt / kidney[, ROIs_high]$sizefact

p <- ggplot(data = dat, aes(x = PC1, y = PC2)) +
  geom_point(aes(colour = paste(class, region))) +
  theme_bw()+
  labs(title = "Poisson Threshold Normalized Data")

plot(p)
```

![](data:image/png;base64...)

```
p <- ggplot(data = dat, aes(x = PC1, y = PC2)) +
  geom_point(aes(colour = log2(sizeratio))) +
  theme_bw()+
  scale_color_gradient2(high = "gold", mid = "grey50", low = "darkblue", midpoint = 0.2)+
  labs(title = "Poisson Threshold Normalized Data")

plot(p)
```

![](data:image/png;base64...)

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] reshape2_1.4.4           GeomxTools_3.14.0        NanoStringNCTools_1.18.0
#>  [4] S4Vectors_0.48.0         ggplot2_4.0.0            dplyr_1.1.4
#>  [7] GeoDiff_1.16.0           Biobase_2.70.0           BiocGenerics_0.56.0
#> [10] generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#>   [1] Rdpack_2.6.4            testthat_3.2.3          readxl_1.4.5
#>   [4] rlang_1.1.6             magrittr_2.0.4          compiler_4.5.1
#>   [7] systemfonts_1.3.1       vctrs_0.6.5             stringr_1.5.2
#>  [10] pkgconfig_2.0.3         crayon_1.5.3            fastmap_1.2.0
#>  [13] XVector_0.50.0          labeling_0.4.3          rmarkdown_2.30
#>  [16] nloptr_2.2.1            ggbeeswarm_0.7.2        purrr_1.1.0
#>  [19] xfun_0.53               cachem_1.1.0            jsonlite_2.0.0
#>  [22] EnvStats_3.1.0          parallel_4.5.1          R6_2.6.1
#>  [25] bslib_0.9.0             stringi_1.8.7           RColorBrewer_1.1-3
#>  [28] GGally_2.4.0            parallelly_1.45.1       boot_1.3-32
#>  [31] rrcov_1.7-7             brio_1.1.5              jquerylib_0.1.4
#>  [34] cellranger_1.1.0        numDeriv_2016.8-1.1     Rcpp_1.1.0
#>  [37] Seqinfo_1.0.0           knitr_1.50              future.apply_1.20.0
#>  [40] IRanges_2.44.0          Matrix_1.7-4            splines_4.5.1
#>  [43] tidyselect_1.2.1        dichromat_2.0-0.1       yaml_2.3.10
#>  [46] codetools_0.2-20        listenv_0.9.1           lattice_0.22-7
#>  [49] tibble_3.3.0            lmerTest_3.1-3          plyr_1.8.9
#>  [52] withr_3.0.2             S7_0.2.0                evaluate_1.0.5
#>  [55] future_1.67.0           ggstats_0.11.0          Biostrings_2.78.0
#>  [58] pillar_1.11.1           reformulas_0.4.2        pcaPP_2.0-5
#>  [61] sp_2.2-0                scales_1.4.0            minqa_1.2.8
#>  [64] globals_0.18.0          robust_0.7-5            glue_1.8.0
#>  [67] gdtools_0.4.4           pheatmap_1.0.13         tools_4.5.1
#>  [70] robustbase_0.99-6       data.table_1.17.8       lme4_1.1-37
#>  [73] ggiraph_0.9.2           mvtnorm_1.3-3           dotCall64_1.2
#>  [76] grid_4.5.1              tidyr_1.3.1             rbibutils_2.3
#>  [79] nlme_3.1-168            fit.models_0.64         beeswarm_0.4.0
#>  [82] vipor_0.4.7             cli_3.6.5               spam_2.11-1
#>  [85] fontBitstreamVera_0.1.1 ggthemes_5.1.0          gtable_0.3.6
#>  [88] DEoptimR_1.1-4          sass_0.4.10             digest_0.6.37
#>  [91] fontquiver_0.2.1        progressr_0.17.0        rjson_0.2.23
#>  [94] htmlwidgets_1.6.4       SeuratObject_5.2.0      farver_2.1.2
#>  [97] htmltools_0.5.8.1       lifecycle_1.0.4         fontLiberation_0.1.0
#> [100] MASS_7.3-65
```