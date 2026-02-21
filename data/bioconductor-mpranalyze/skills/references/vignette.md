# Analyzing MPRA data with MPRAnalyze

Tal Ashuach

#### March 28, 2018

# Contents

true

# 1 Introduction

MPRAnalyze aims to infer the transcription rate induced by each enhacer in a Massively Parallel Reporter Assay (MPRA). MPRAnalyze uses a parametric graphical model that enables direct modeling of the observed count data, without the need to use ratio-based summary statistics, and provides robust statistical methodology that addresses all major uses of MPRA.

# 2 Setup

An MPRA experiment is made up of two matching datasets: the RNA counts used to estimate transcription, and the DNA counts used to normalize by copy-number. MPRAnalyze assumes the input is unnormalized count data. Normalization is achieved by external factors (to correct library size) and regressing out confounding factors (by carefully designing the model).

Throughout this vignette, we’ll be using a subset of enhancers from [Inoue et al.](TODO), that examined a set of enhancers that were tranduced and remained episomal, and after being genomically integrated. We’ll be using a subset of the data, both in terms of number of enhancers and number of barcodes, for runtime purposes.

## 2.1 Formatting the data

MPRanalyze expects the input to be provided as two matrices: one for the DNA and one for the RNA counts. The formatting is fairly straightforward: each row is a single enhancer, and each column is an observation. Annotations for the columns are provided for each matrix to identify batches, barcodes and conditions.
When formatting the data, note that all enhancers must have the same number of columns. In the case of missing data, padding with 0s is recommended.

```
library(MPRAnalyze)
data("ChrEpi")
summary(ce.colAnnot)
```

```
##  batch  condition    barcode
##  1:20   MT:20     1      : 4
##  2:20   WT:20     2      : 4
##                   3      : 4
##                   4      : 4
##                   5      : 4
##                   6      : 4
##                   (Other):16
```

```
head(ce.colAnnot)
```

```
##          batch condition barcode
## MT:1:001     1        MT       1
## MT:1:002     1        MT       2
## MT:1:003     1        MT       3
## MT:1:004     1        MT       4
## MT:1:005     1        MT       5
## MT:1:006     1        MT       6
```

In the filtered dataset we have 110 enhancers, 40 observations each: 10 unique barcodes, 2 replicates and 2 conditions (MT stands for episomal, WT for chromosomally integrated).
Note that while this datset is “paired”, and therefore the dimensionality of the two matrices and the annotations are identical, this is not always the case, and separate data frames can be used for the DNA and RNA annotations.

## 2.2 Creating an MpraObject object

The MpraObject is the basic class that the package works with, and is very easy to initialize once the data is properly formatted. In addition to the data itself, the user can specify certain enhancers as “controls” (usaully scrambled, random sequences included in the experiment). These will be used by MPRAnalyze to establish the null behavior.
Additionally, MPRAnalyze uses parallelization to reduce runtime, with the BiocParallel package. To utilize this, the user can create a BPPARAM object and pass it to the MpraObject, it will be used throughout the analysis.

```
obj <- MpraObject(dnaCounts = ce.dnaCounts, rnaCounts = ce.rnaCounts,
                  dnaAnnot = ce.colAnnot, rnaAnnot = ce.colAnnot,
                  controls = ce.control)
```

```
## Warning in MpraObject(dnaCounts = ce.dnaCounts, rnaCounts = ce.rnaCounts, : 1
## enhancers were removed from the analysis
```

Note that since we are using only a subset of the data, one of the enhancers included was not detected (all observations are 0). If this is the case, MPRAnalyze removes it from the analysis. In datasets with many zeros, it is possible to add pseudo-counts. With MPRA this should be done carefully, and we recommend only adding pseudocounts in cases where the RNA counts are positive but the DNA counts are 0 (these are the only cases we know this is a false 0).

## 2.3 Library size normalization

MPRAnalyze allows for external factors to be used for normalization, espacially useful for library depth correction. These factors can be estimated automatically using upper quartile (default), total sum, or DESeq2-style harmonic mean normalization. If other factors are to be used, the user can provide them directly using the `setDepthFactors` function, and providing correction factors for the RNA and DNA counts (length of the factors must be the same as the number of columns in the respective data matrix).
Note that unlike other genomic data, in which every column is a separate library, with MPRA a library is often multiple columns, since multiple barcodes can originate from a single library. For this reason, automatic estimation of library size requires the user to specify what columns belong to what library. This can be done easily by providing the names of factors from the annotations data.frame that identify library (this can be a single factor or multiple factors).

```
## If the library factors are different for the DNA and RNA data, separate
## estimation of these factors is needed. We can also change the estimation
## method (Upper quartile by default)
obj <- estimateDepthFactors(obj, lib.factor = c("batch", "condition"),
                            which.lib = "dna",
                            depth.estimator = "uq")
obj <- estimateDepthFactors(obj, lib.factor = c("condition"),
                            which.lib = "rna",
                            depth.estimator = "uq")

## In this case, the factors are the same - each combination of batch and
## condition is a single library, and we'll use the default estimation
obj <- estimateDepthFactors(obj, lib.factor = c("batch", "condition"),
                            which.lib = "both")
```

# 3 Model Design

MPRAnalyze fits two nested generalized linear models. The two models have a conceptually different role: the DNA model is estimating plasmid copy numbers, and the RNA model is estimating transcription rate. Different factors should therefore be included or not included in either model, and the nested nature of the overall model requires careful thinking about the model design, and often using a different design for the DNA and the RNA model.
Two common considerations are covered here:

## 3.1 DNA design of paired factors only

In some MPRA experiments, the DNA counts originate from pre-transduction plasmid libraries. In these cases, multiple replicates may be available, but they are independant of the multiple RNA replicates. Therefore, while there may be batch effect present in the DNA data, this effect cannot be transferred into the RNA model, and should be discarded. By not including it, the DNA estimates will be averaged over replicates, but the multiple replicates will still be used to estimate the dispersion.
Essentially - any factor that cannot or should not be carried from the DNA to the RNA model, should not be included in the DNA model at all.

## 3.2 including barcode annotations in the design

While replicate and condition factors are not always transferrable, barcode information - if available - is. Including barcode information in the DNA model allows MPRAnalyze to provide different estimated counts for each barcode, and dramatically increases the statistical power of the model. This should be done thoughtfully, as explained below. Overall, we recommend only modeling barcodes in the DNA model, and only in comparative analyses. When doing this makes the fitting the model unreasonably slow, MPRAnalyze offers a scalable model, explained below.
The two considertations behind these recommendations are:
### Type of analysis
While most experiment include a limited number of conditions or batches, many MPRA designs include dozens or sometimes hundreds of barcodes per enhancer. This could dramatically increase the complexity of the model, and therefore the time required to optimize the model parameters. In quantification analyses, the resulting estimates of transcription rate are often not impacted by modeling barcodes, and therefore the runtime cost doesn’t justify the gain in accuracy. However, in comparative analyses, the gain in statistical power from modeling barcodes can be substantial. We generally recommend modeling barcodes only in comparative analyses, and if the number of barcodes is very large (more than 100 barcodes per enhancer) - filtering the data should be considered.
### Modeling barcodes in the DNA model only
Barcodes should sometimes be modeled in the DNA model, but not necessarily in the RNA model. Modeling barcode effect in the RNA model essentially means different transcription rate estimates will be calculated for each different barcode of the same enhancer, which is not usually desired. In quantification analyses, this would make comparing enhancers to eachother exceedingly complicated, since unlike batch- or condition- effects, barcodes are not comparable between enhancers. In compartive analyses, while modeling barcodes isn’t conceptually problematic, in practice this could result in overfitting the model and inlfating the results.

# 4 Quantification Analysis

Quantification analysis is addressing the question of what is the transription rate for each enhancer in the dataset. These estimates can then be used to identify and classify active enhancers that induce a higher transcription rate.
Regarding model design - this data is from a paired experiment, so DNA factors are fully transferable to the RNA model. For the RNA, we will be interested in having a separate estimate of transcription rate for each condition (chromosomal and episomal), so this is the only factor included in the RNA model.
Finally, fitting the model is done by calling the `analyzeQuantification` function:

```
obj <- analyzeQuantification(obj = obj,
                              dnaDesign = ~ batch + condition,
                              rnaDesign = ~ condition)
```

```
## Fitting model...
```

```
## Analysis done!
```

We can now extract the transcription rate estimates from the model, denoted ‘alpha values’ in the MPRAnalyze model, and use the testing functionality to test for activtiy.
extracting alpha values is done with the `getAlpha` function, that will provide separate values per-factor if a factor is provided. In this case we want a separate alpha estimate by condition:

```
##extract alpha values from the fitted model
alpha <- getAlpha(obj, by.factor = "condition")

##visualize the estimates
boxplot(alpha)
```

![](data:image/png;base64...)

We can also leverage negative controls included in the data to establish a baseline rate of transcription, and use that to test for activty among the candidate enhancers. The `testEmpirical` function provides several statistics and p-values based on those statistics: empirical p-values, z-score based and MAD-score based p-values are currently supported.
In most cases, we recommend using the MAD-score pvalues, which are median-based variant of z-scores, which makes them more robust to outliers.

```
## test
res.epi <- testEmpirical(obj = obj,
                               statistic = alpha$MT)
summary(res.epi)
```

```
##    statistic       control            zscore            mad.score
##  Min.   : 2.709   Mode :logical   Min.   :-3.518741   Min.   :-4.6062
##  1st Qu.: 5.123   FALSE:99        1st Qu.: 0.004186   1st Qu.:-0.1681
##  Median : 5.905   TRUE :10        Median : 1.145429   Median : 1.2697
##  Mean   : 6.053                   Mean   : 1.360551   Mean   : 1.5407
##  3rd Qu.: 6.687                   3rd Qu.: 2.286174   3rd Qu.: 2.7068
##  Max.   :13.819                   Max.   :12.692923   Max.   :15.8170
##  pval.empirical      pval.mad         pval.zscore
##  Min.   :0.0000   Min.   :0.000000   Min.   :0.00000
##  1st Qu.:0.0000   1st Qu.:0.003397   1st Qu.:0.01112
##  Median :0.2000   Median :0.102102   Median :0.12602
##  Mean   :0.2826   Mean   :0.304606   Mean   :0.28808
##  3rd Qu.:0.6000   3rd Qu.:0.566729   3rd Qu.:0.49833
##  Max.   :1.0000   Max.   :0.999998   Max.   :0.99978
```

```
res.chr <- testEmpirical(obj = obj,
                               statistic = alpha$WT)
par(mfrow=c(2,2))

hist(res.epi$pval.mad, main="episomal, all")
hist(res.epi$pval.mad[ce.control], main="episomal, controls")
hist(res.chr$pval.mad, main="chromosomal, all")
hist(res.chr$pval.mad[ce.control], main="chromosomal, controls")
```

![](data:image/png;base64...)

```
par(mfrow=c(1,1))
```

P-values seem well calibrated, getting a uniform distribution for inactive enhancers, and enrichment for low p-values with the active enhancers.

# 5 Comparative Analysis

MPRAnalyze also supports comparative analyses, in this case: identifying enhancers that are differentially active between conditions. While we can do this indirectly by taking the quantification results and identify enhancers that are active in one condition but not the other, a direct compartive analysis is more sensitive, and allows identification of enhancers that are more or less active, avoiding the binarization of activity.
MPRAnalyze also leverages negative controls to estbalish the null differential behavior, thereby correcting any systemic bias that may be present in the data.
In terms of syntax, this analysis is done very similarly to quantification, with an additional reduced model that describes the null hypothesis. In this case, the null hypothesis is no differential activtiy between conditions, so the reduced model is an empty model (intercept only)

```
obj <- analyzeComparative(obj = obj,
                           dnaDesign = ~ barcode + batch + condition,
                           rnaDesign = ~ condition,
                           reducedDesign = ~ 1)
```

```
## Fitting controls-based background model...
```

```
## iter:2   log-likelihood:-20070.6217813438
```

```
## iter:3   log-likelihood:-19658.8266564237
```

```
## iter:4   log-likelihood:-19294.3316068404
```

```
## iter:5   log-likelihood:-19020.7506186242
```

```
## iter:6   log-likelihood:-18865.5970641262
```

```
## iter:7   log-likelihood:-18801.9115215954
```

```
## iter:8   log-likelihood:-18780.9731910153
```

```
## iter:9   log-likelihood:-18774.6426498273
```

```
## iter:10  log-likelihood:-18772.8142283535
```

```
## iter:11  log-likelihood:-18772.0915318687
```

```
## iter:12  log-likelihood:-18771.8905455559
```

```
## iter:13  log-likelihood:-18771.796841492
```

```
## iter:14  log-likelihood:-18771.7573126735
```

```
## iter:15  log-likelihood:-18771.7341184462
```

```
## iter:16  log-likelihood:-18771.7590458202
```

```
## Fitting model...
```

```
## Fitting reduced model...
```

```
## Analysis Done!
```

with the fitted model, we can now test for differential activity, by calling `testLrt`

```
res <- testLrt(obj)
```

```
## Performing Likelihood Ratio Test...
```

```
head(res)
```

```
##                                                                   statistic
## A:HNF4A-ChMod_chr10:11917871-11917984_[chr10:11917842-11918013]  5.74520184
## A:HNF4A-ChMod_chr10:34165653-34165745_[chr10:34165613-34165784]  2.00821613
## A:HNF4A-ChMod_chr10:52009954-52010059_[chr10:52009921-52010092]  0.49202491
## A:HNF4A-ChMod_chr10:60767336-60767487_[chr10:60767326-60767497] 10.50745205
## A:HNF4A-ChMod_chr10:60797400-60797480_[chr10:60797354-60797525]  4.77027295
## A:HNF4A-ChMod_chr10:72112555-72112707_[chr10:72112545-72112716]  0.07449976
##                                                                        pval
## A:HNF4A-ChMod_chr10:11917871-11917984_[chr10:11917842-11918013] 0.016533756
## A:HNF4A-ChMod_chr10:34165653-34165745_[chr10:34165613-34165784] 0.156449183
## A:HNF4A-ChMod_chr10:52009954-52010059_[chr10:52009921-52010092] 0.483025424
## A:HNF4A-ChMod_chr10:60767336-60767487_[chr10:60767326-60767497] 0.001188941
## A:HNF4A-ChMod_chr10:60797400-60797480_[chr10:60797354-60797525] 0.028955235
## A:HNF4A-ChMod_chr10:72112555-72112707_[chr10:72112545-72112716] 0.784894385
##                                                                        fdr
## A:HNF4A-ChMod_chr10:11917871-11917984_[chr10:11917842-11918013] 0.19945209
## A:HNF4A-ChMod_chr10:34165653-34165745_[chr10:34165613-34165784] 0.48722746
## A:HNF4A-ChMod_chr10:52009954-52010059_[chr10:52009921-52010092] 0.79772381
## A:HNF4A-ChMod_chr10:60767336-60767487_[chr10:60767326-60767497] 0.02842045
## A:HNF4A-ChMod_chr10:60797400-60797480_[chr10:60797354-60797525] 0.26301005
## A:HNF4A-ChMod_chr10:72112555-72112707_[chr10:72112545-72112716] 0.90699403
##                                                                 df.test df.dna
## A:HNF4A-ChMod_chr10:11917871-11917984_[chr10:11917842-11918013]       1     12
## A:HNF4A-ChMod_chr10:34165653-34165745_[chr10:34165613-34165784]       1      8
## A:HNF4A-ChMod_chr10:52009954-52010059_[chr10:52009921-52010092]       1      6
## A:HNF4A-ChMod_chr10:60767336-60767487_[chr10:60767326-60767497]       1      9
## A:HNF4A-ChMod_chr10:60797400-60797480_[chr10:60797354-60797525]       1     10
## A:HNF4A-ChMod_chr10:72112555-72112707_[chr10:72112545-72112716]       1      8
##                                                                 df.rna.full
## A:HNF4A-ChMod_chr10:11917871-11917984_[chr10:11917842-11918013]           5
## A:HNF4A-ChMod_chr10:34165653-34165745_[chr10:34165613-34165784]           5
## A:HNF4A-ChMod_chr10:52009954-52010059_[chr10:52009921-52010092]           5
## A:HNF4A-ChMod_chr10:60767336-60767487_[chr10:60767326-60767497]           5
## A:HNF4A-ChMod_chr10:60797400-60797480_[chr10:60797354-60797525]           5
## A:HNF4A-ChMod_chr10:72112555-72112707_[chr10:72112545-72112716]           5
##                                                                 df.rna.red
## A:HNF4A-ChMod_chr10:11917871-11917984_[chr10:11917842-11918013]          4
## A:HNF4A-ChMod_chr10:34165653-34165745_[chr10:34165613-34165784]          4
## A:HNF4A-ChMod_chr10:52009954-52010059_[chr10:52009921-52010092]          4
## A:HNF4A-ChMod_chr10:60767336-60767487_[chr10:60767326-60767497]          4
## A:HNF4A-ChMod_chr10:60797400-60797480_[chr10:60797354-60797525]          4
## A:HNF4A-ChMod_chr10:72112555-72112707_[chr10:72112545-72112716]          4
##                                                                       logFC
## A:HNF4A-ChMod_chr10:11917871-11917984_[chr10:11917842-11918013]  0.24811732
## A:HNF4A-ChMod_chr10:34165653-34165745_[chr10:34165613-34165784] -0.42948773
## A:HNF4A-ChMod_chr10:52009954-52010059_[chr10:52009921-52010092]  0.25913304
## A:HNF4A-ChMod_chr10:60767336-60767487_[chr10:60767326-60767497]  0.48409448
## A:HNF4A-ChMod_chr10:60797400-60797480_[chr10:60797354-60797525]  0.31063488
## A:HNF4A-ChMod_chr10:72112555-72112707_[chr10:72112545-72112716]  0.06572601
```

```
summary(res)
```

```
##    statistic              pval                fdr               df.test
##  Min.   :1.432e-04   Min.   :8.000e-08   Min.   :0.0000089   Min.   :1
##  1st Qu.:1.741e-01   1st Qu.:1.092e-01   1st Qu.:0.4250950   1st Qu.:1
##  Median :8.825e-01   Median :3.475e-01   Median :0.6887301   Median :1
##  Mean   :2.129e+00   Mean   :4.052e-01   Mean   :0.6398476   Mean   :1
##  3rd Qu.:2.566e+00   3rd Qu.:6.765e-01   3rd Qu.:0.8931959   3rd Qu.:1
##  Max.   :2.877e+01   Max.   :9.905e-01   Max.   :0.9904515   Max.   :1
##      df.dna        df.rna.full   df.rna.red     logFC
##  Min.   : 5.000   Min.   :5    Min.   :4    Min.   :-0.42949
##  1st Qu.: 8.000   1st Qu.:5    1st Qu.:4    1st Qu.:-0.03682
##  Median : 9.000   Median :5    Median :4    Median : 0.11172
##  Mean   : 9.239   Mean   :5    Mean   :4    Mean   : 0.12056
##  3rd Qu.:11.000   3rd Qu.:5    3rd Qu.:4    3rd Qu.: 0.27804
##  Max.   :13.000   Max.   :5    Max.   :4    Max.   : 0.83722
```

When the hypothesis teseting is simple (two-condition comparison), a fold-change estimate is also available:

```
## plot log Fold-Change
plot(density(res$logFC))
```

![](data:image/png;base64...)

```
## plot volcano
plot(res$logFC, -log10(res$pval))
```

![](data:image/png;base64...)

# 6 Allelic Comparison / Mutagensis Analyses

Another common use of MPRAs are when one wishes to compare the activity of two different sequences. This is a comparative analysis that requires a different model design, since these sequences are often tested at the same time and under the same conditions, and therefore do not share barcodes.
Running these analyses in MPRAnalyze is fairly straight forward: the formatting of the data and the functions are the same as a comparative analysis. The only difference is that since the “conditions” no longer share barcodes, the model needs to treat the barcodes differently within each condition. This can be done by changing the annotations of the samples. Using the data we’ve been using, we can achieve this as follows:

```
ce.colAnnot$barcode_allelic <- interaction(ce.colAnnot$barcode, ce.colAnnot$condition)
summary(ce.colAnnot)
```

```
##  batch  condition    barcode   barcode_allelic
##  1:20   MT:20     1      : 4   1.MT   : 2
##  2:20   WT:20     2      : 4   2.MT   : 2
##                   3      : 4   3.MT   : 2
##                   4      : 4   4.MT   : 2
##                   5      : 4   5.MT   : 2
##                   6      : 4   6.MT   : 2
##                   (Other):16   (Other):28
```

Now each barcode is only associated with a single condition, and the next steps are the same as before: creating an object, normalizing library size and running a comparative analysis.

# 7 scalable mode (from version 1.7.0)

When modeling barcodes in comparative analyses, MPRAnalyze creates a coefficient in the model for each distinct barcode, making the model potentially very big, and correspondingly the runtime might get very slow. To address this, MPRAnalyze implements a scalable mode, with limited capabilities, that uses the DNA counts directly as estimates instead of creating a DNA model.
This mode runs much faster and reaches similar results as the classic MPRAnalyze model in terms of the measured effect size, but has reduced statistical power and does not support control-based correction. Additionally, this model is only available in situations where the DNA and RNA observations are matched: meaning each RNA observation has a single corresponding DNA observation.
Running this analysis is simply calling the same `analyzeComparative` function with the argument `mode="scale"`. dnaDesign is not necessary in this mode, since no DNA model is created.

```
obj <- analyzeComparative(obj = obj,
                          rnaDesign = ~ condition,
                          reducedDesign = ~ 1,
                          mode="scale")
```

```
## Warning in analyzeComparative(obj = obj, rnaDesign = ~condition, reducedDesign
## = ~1, : Control-based correction is not currently supported in scalable mode
```

```
## Fitting model...
```

```
## Fitting reduced model...
```

```
## Analysis Done!
```

```
res.scale <- testLrt(obj)
```

```
## Performing Likelihood Ratio Test...
```

```
head(res.scale)
```

```
##                                                                 statistic
## A:HNF4A-ChMod_chr10:11917871-11917984_[chr10:11917842-11918013] 4.0743883
## A:HNF4A-ChMod_chr10:34165653-34165745_[chr10:34165613-34165784] 1.6184314
## A:HNF4A-ChMod_chr10:52009954-52010059_[chr10:52009921-52010092] 0.2245349
## A:HNF4A-ChMod_chr10:60767336-60767487_[chr10:60767326-60767497] 9.4880038
## A:HNF4A-ChMod_chr10:60797400-60797480_[chr10:60797354-60797525] 4.1160719
## A:HNF4A-ChMod_chr10:72112555-72112707_[chr10:72112545-72112716] 1.1093860
##                                                                        pval
## A:HNF4A-ChMod_chr10:11917871-11917984_[chr10:11917842-11918013] 0.043538028
## A:HNF4A-ChMod_chr10:34165653-34165745_[chr10:34165613-34165784] 0.203310646
## A:HNF4A-ChMod_chr10:52009954-52010059_[chr10:52009921-52010092] 0.635606075
## A:HNF4A-ChMod_chr10:60767336-60767487_[chr10:60767326-60767497] 0.002068197
## A:HNF4A-ChMod_chr10:60797400-60797480_[chr10:60797354-60797525] 0.042477599
## A:HNF4A-ChMod_chr10:72112555-72112707_[chr10:72112545-72112716] 0.292215463
##                                                                        fdr
## A:HNF4A-ChMod_chr10:11917871-11917984_[chr10:11917842-11918013] 0.21571114
## A:HNF4A-ChMod_chr10:34165653-34165745_[chr10:34165613-34165784] 0.54050879
## A:HNF4A-ChMod_chr10:52009954-52010059_[chr10:52009921-52010092] 0.82603154
## A:HNF4A-ChMod_chr10:60767336-60767487_[chr10:60767326-60767497] 0.05168129
## A:HNF4A-ChMod_chr10:60797400-60797480_[chr10:60797354-60797525] 0.21571114
## A:HNF4A-ChMod_chr10:72112555-72112707_[chr10:72112545-72112716] 0.66357261
##                                                                 df.test
## A:HNF4A-ChMod_chr10:11917871-11917984_[chr10:11917842-11918013]       1
## A:HNF4A-ChMod_chr10:34165653-34165745_[chr10:34165613-34165784]       1
## A:HNF4A-ChMod_chr10:52009954-52010059_[chr10:52009921-52010092]       1
## A:HNF4A-ChMod_chr10:60767336-60767487_[chr10:60767326-60767497]       1
## A:HNF4A-ChMod_chr10:60797400-60797480_[chr10:60797354-60797525]       1
## A:HNF4A-ChMod_chr10:72112555-72112707_[chr10:72112545-72112716]       1
##                                                                 df.rna.full
## A:HNF4A-ChMod_chr10:11917871-11917984_[chr10:11917842-11918013]           5
## A:HNF4A-ChMod_chr10:34165653-34165745_[chr10:34165613-34165784]           5
## A:HNF4A-ChMod_chr10:52009954-52010059_[chr10:52009921-52010092]           5
## A:HNF4A-ChMod_chr10:60767336-60767487_[chr10:60767326-60767497]           5
## A:HNF4A-ChMod_chr10:60797400-60797480_[chr10:60797354-60797525]           5
## A:HNF4A-ChMod_chr10:72112555-72112707_[chr10:72112545-72112716]           5
##                                                                 df.rna.red
## A:HNF4A-ChMod_chr10:11917871-11917984_[chr10:11917842-11918013]          4
## A:HNF4A-ChMod_chr10:34165653-34165745_[chr10:34165613-34165784]          4
## A:HNF4A-ChMod_chr10:52009954-52010059_[chr10:52009921-52010092]          4
## A:HNF4A-ChMod_chr10:60767336-60767487_[chr10:60767326-60767497]          4
## A:HNF4A-ChMod_chr10:60797400-60797480_[chr10:60797354-60797525]          4
## A:HNF4A-ChMod_chr10:72112555-72112707_[chr10:72112545-72112716]          4
##                                                                      logFC
## A:HNF4A-ChMod_chr10:11917871-11917984_[chr10:11917842-11918013]  0.2271102
## A:HNF4A-ChMod_chr10:34165653-34165745_[chr10:34165613-34165784] -0.5125338
## A:HNF4A-ChMod_chr10:52009954-52010059_[chr10:52009921-52010092]  0.1735249
## A:HNF4A-ChMod_chr10:60767336-60767487_[chr10:60767326-60767497]  0.4793433
## A:HNF4A-ChMod_chr10:60797400-60797480_[chr10:60797354-60797525]  0.2239507
## A:HNF4A-ChMod_chr10:72112555-72112707_[chr10:72112545-72112716]  0.2585286
```

```
plot(res$logFC, res.scale$logFC)
```

![](data:image/png;base64...)