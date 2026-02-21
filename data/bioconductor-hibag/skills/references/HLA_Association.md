# HIBAG – an R Package for HLA Genotype Imputation with Attribute Bagging

#### Dr. Xiuwen Zheng

#### May 3, 2018

* [Overview](#overview)
* [Association Tests](#association-tests)
  + [Allelic Association](#allelic-association)
  + [Amino Acid Association](#amino-acid-association)
* [Resources](#resources)
* [Session Info](#session-info)
* [References](#references)

# Overview

The human leukocyte antigen (HLA) system, located in the major histocompatibility complex (MHC) on chromosome 6p21.3, is highly polymorphic. This region has been shown to be important in human disease, adverse drug reactions and organ transplantation (Shiina et al. 2009). HLA genes play a role in the immune system and autoimmunity as they are central to the presentation of antigens for recognition by T cells. Since they have to provide defense against a great diversity of environmental microbes, HLA genes must be able to present a wide range of peptides. Evolutionary pressure at these loci have given rise to a great deal of functional diversity. For example, the *HLA–B* locus has 1,898 four-digit alleles listed in the April 2012 release of the IMGT-HLA Database (Robinson et al. 2013) (<https://www.ebi.ac.uk/ipd/imgt/hla/>).

Classical HLA genotyping methodologies have been predominantly developed for tissue typing purposes, with sequence based typing (SBT) approaches currently considered the gold standard. While there is widespread availability of vendors offering HLA genotyping services, the complexities involved in performing this to the standard required for diagnostic purposes make using a SBT approach time-consuming and cost-prohibitive for most research studies wishing to look in detail at the involvement of classical HLA genes in disease.

Here we introduce a new prediction method for **H**LA **I**mputation using attribute **BAG**ging, HIBAG, that is highly accurate, computationally tractable, and can be used with published parameter estimates, eliminating the need to access large training samples (Zheng et al. 2014). It relies on a training set with known HLA and SNP genotypes, and combines the concepts of attribute bagging with haplotype inference from unphased SNPs and HLA types. Attribute bagging is a technique for improving the accuracy and stability of classifier ensembles using bootstrap aggregating and random variable selection (Breiman 1996, 2001; Bryll, Gutierrez-Osuna, and Quek 2003). In this case, individual classifiers are created which utilize a subset of SNPs to predict HLA types and haplotype frequencies estimated from a training data set of SNPs and HLA types. Each of the classifiers employs a variable selection algorithm with a random component to select a subset of the SNPs. HLA type predictions are determined by maximizing the average posterior probabilities from all classifiers.

# Association Tests

In the association tests of HLA allele, four models (dominant, additive, recessive and genotype) are allowed, and linear/logistic regressions can be conducted according to the dependent variable.

| Model | Description (given a specific HLA allele h) |
| --- | --- |
| dominant | [-/-] vs. [-/h,h/h] (0 vs. 1 in design matrix) |
| additive | [-] vs. [h] in Chi-squared and Fisher’s exact test, the allele dosage in regressions (0: -/-, 1: -/h, 2: h/h in design matrix) |
| recessive | [-/-,-/h] vs. [h/h] (0 vs. 1 in design matrix) |
| genotype | three categories: [-/-], [-/h], [h/h] |

```
# prepare data
fn <- "case_control.txt"
# or fn <- system.file("doc", "case_control.txt", package="HIBAG")
```

The example text file: <case_control.txt>.

```
dat <- read.table(fn, header=TRUE, stringsAsFactors=FALSE)
head(dat)
```

```
##   sample.id disease     A   A.1 trait     pc1     pc2    prob
## 1     N0001       0 68:01 11:01  0.59 -0.7768  1.9784 0.66486
## 2     N0002       1 03:01 24:02 -0.11 -0.2013  1.4537 0.80609
## 3     N0003       0 31:01 11:01  0.58 -0.1655  1.8288 0.70520
## 4     N0004       1 01:01 29:02  0.91  0.5545  1.3598 0.90045
## 5     N0005       1 03:01 03:01 -0.36  0.4781  1.6197 0.89971
## 6     N0006       0 31:01 24:02  0.60 -0.5116 -0.6259 0.72470
```

```
# make an object for hlaAssocTest
hla <- hlaAllele(dat$sample.id, H1=dat$A, H2=dat$A.1, locus="A", assembly="hg19", prob=dat$prob)
summary(hla)
```

```
## Gene: HLA-A
## Range: [29910247bp, 29913661bp] on hg19
## # of samples: 500
## # of unique HLA alleles: 18
## # of unique HLA genotypes: 132
## Posterior probability:
##    [0,0.25)  [0.25,0.5)  [0.5,0.75)    [0.75,1]
##    0 (0.0%)   20 (4.0%) 262 (52.4%) 218 (43.6%)
```

Or the best-guess HLA genotypes from `predict()` or `hlaPredict()`:

```
hla <- hlaPredict(model, yourgeno)
```

### Allelic Association

`h` in the formula is denoted for HLA genotypes. Pearson’s Chi-squared and Fisher’s exact test will be performed if the dependent variable is categorial, while two-sample t test or ANOVA F test will be used for continuous dependent variables.

```
hlaAssocTest(hla, disease ~ h, data=dat)  # 95% confidence interval (h.2.5%, h.97.5%)
```

```
## Logistic regression (dominant model) with 500 individuals:
##   glm(disease ~ h, family = binomial, data = data)
##       [-/-] [-/h,h/h] %.[-/-] %.[-/h,h/h]  chisq.st chisq.p fisher.p     h.est     h.2.5%   h.97.5%  h.pval
## 26:01   468        32    54.1        15.6 1.621e+01 <0.001*  <0.001* -1.849150    -2.8205   -0.8778 <0.001*
## -----
## 01:01   427        73    51.3        53.4 4.446e-02  0.833    0.800   0.085667    -0.4118    0.5832  0.736
## 02:01   474        26    52.3        38.5 1.381e+00  0.240    0.226  -0.562897    -1.3733    0.2475  0.173
## 02:05   441        59    52.8        42.4 1.881e+00  0.170    0.165  -0.420985    -0.9702    0.1282  0.133
## 03:01   383       117    50.1        56.4 1.175e+00  0.278    0.246   0.252607    -0.1641    0.6693  0.235
## 11:01   442        58    51.8        50.0 1.431e-02  0.905    0.889  -0.072430    -0.6199    0.4751  0.795
## 23:01   470        30    51.1        60.0 5.794e-01  0.447    0.354   0.362905    -0.3895    1.1153  0.345
## 24:02   387       113    50.4        55.8 8.045e-01  0.370    0.337   0.215608    -0.2057    0.6369  0.316
## 25:01   481        19    50.9        68.4 1.592e+00  0.207    0.163   0.735763    -0.2480    1.7195  0.143
## 26:08   455        45    52.3        44.4 7.234e-01  0.395    0.350  -0.315517    -0.9316    0.3006  0.315
## 29:01   472        28    52.5        35.7 2.361e+00  0.124    0.118  -0.689569    -1.4834    0.1043  0.089
## 29:02   440        60    51.6        51.7 3.369e-30  1.000    1.000   0.003034    -0.5367    0.5428  0.991
## 31:01   445        55    51.9        49.1 6.335e-02  0.801    0.775  -0.112809    -0.6732    0.4476  0.693
## 32:01   482        18    51.7        50.0 9.437e-31  1.000    1.000  -0.066414    -1.0075    0.8746  0.890
## 32:02   389       111    50.4        55.9 8.273e-01  0.363    0.333   0.219890    -0.2042    0.6440  0.310
## 33:01   498         2    51.4       100.0 4.403e-01  0.507    0.500  14.509828 -1208.8876 1237.9073  0.981
## 68:01   448        52    50.4        61.5 1.873e+00  0.171    0.144   0.452146    -0.1364    1.0407  0.132
## 68:06   433        67    51.0        55.2 2.565e-01  0.613    0.600   0.168144    -0.3489    0.6852  0.524
```

```
# show details
print(hlaAssocTest(hla, disease ~ h, data=dat, verbose=FALSE))
```

```
##       [-/-] [-/h,h/h] %.[-/-] %.[-/h,h/h]     chisq.st      chisq.p     fisher.p        h.est        h.2.5%
## 01:01   427        73    51.3        53.4 4.446014e-02 8.329998e-01 8.002913e-01  0.085667471    -0.4118182
## 02:01   474        26    52.3        38.5 1.381333e+00 2.398743e-01 2.262590e-01 -0.562897376    -1.3732827
## 02:05   441        59    52.8        42.4 1.880794e+00 1.702439e-01 1.650743e-01 -0.420985064    -0.9701514
## 03:01   383       117    50.1        56.4 1.174861e+00 2.784048e-01 2.464423e-01  0.252607162    -0.1640977
## 11:01   442        58    51.8        50.0 1.430580e-02 9.047946e-01 8.890155e-01 -0.072429838    -0.6199133
## 23:01   470        30    51.1        60.0 5.793734e-01 4.465580e-01 3.544810e-01  0.362905438    -0.3895338
## 24:02   387       113    50.4        55.8 8.045038e-01 3.697502e-01 3.367351e-01  0.215607533    -0.2057114
## 25:01   481        19    50.9        68.4 1.592268e+00 2.070025e-01 1.631167e-01  0.735763483    -0.2479520
## 26:01   468        32    54.1        15.6 1.621106e+01 5.666222e-05 2.764124e-05 -1.849150412    -2.8205279
## 26:08   455        45    52.3        44.4 7.234172e-01 3.950253e-01 3.500228e-01 -0.315516870    -0.9316086
## 29:01   472        28    52.5        35.7 2.361181e+00 1.243880e-01 1.181831e-01 -0.689569359    -1.4834203
## 29:02   440        60    51.6        51.7 3.369257e-30 1.000000e+00 1.000000e+00  0.003033523    -0.5367255
## 31:01   445        55    51.9        49.1 6.334576e-02 8.012839e-01 7.752251e-01 -0.112809340    -0.6732124
## 32:01   482        18    51.7        50.0 9.436715e-31 1.000000e+00 1.000000e+00 -0.066414443    -1.0074628
## 32:02   389       111    50.4        55.9 8.272755e-01 3.630615e-01 3.334643e-01  0.219889615    -0.2042055
## 33:01   498         2    51.4       100.0 4.402581e-01 5.069979e-01 4.995110e-01 14.509828058 -1208.8876041
## 68:01   448        52    50.4        61.5 1.872644e+00 1.711725e-01 1.440661e-01  0.452146012    -0.1364285
## 68:06   433        67    51.0        55.2 2.565230e-01 6.125190e-01 5.996497e-01  0.168144103    -0.3489354
##            h.97.5%       h.pval
## 01:01    0.5831531 0.7357343407
## 02:01    0.2474880 0.1733873224
## 02:05    0.1281813 0.1329712474
## 03:01    0.6693120 0.2347808891
## 11:01    0.4750536 0.7954074246
## 23:01    1.1153446 0.3445051873
## 24:02    0.6369265 0.3158607252
## 25:01    1.7194790 0.1426640661
## 26:01   -0.8777729 0.0001906754
## 26:08    0.3005749 0.3154994339
## 29:01    0.1042816 0.0886617025
## 29:02    0.5427926 0.9912112585
## 31:01    0.4475938 0.6931813422
## 32:01    0.8746339 0.8899840700
## 32:02    0.6439847 0.3095226073
## 33:01 1237.9072602 0.9814542781
## 68:01    1.0407206 0.1321558948
## 68:06    0.6852236 0.5239022516
```

```
hlaAssocTest(hla, disease ~ h, data=dat, prob.threshold=0.5)  # regression with a threshold
```

```
## Exclude 20 individuals from the study due to the call threshold (0.5)
## Logistic regression (dominant model) with 480 individuals:
##   glm(disease ~ h, family = binomial, data = data)
##       [-/-] [-/h,h/h] %.[-/-] %.[-/h,h/h]  chisq.st chisq.p fisher.p    h.est     h.2.5%   h.97.5%  h.pval
## 26:01   451        29    53.7        17.2 1.305e+01 <0.001*  <0.001* -1.71522    -2.6963   -0.7342 <0.001*
## -----
## 01:01   411        69    50.6        56.5 6.073e-01  0.436    0.435   0.23803    -0.2757    0.7518  0.364
## 02:01   456        24    52.0        41.7 6.009e-01  0.438    0.403  -0.41546    -1.2475    0.4165  0.328
## 02:05   422        58    52.8        41.4 2.244e+00  0.134    0.123  -0.46217    -1.0185    0.0942  0.103
## 03:01   367       113    50.1        55.8 8.776e-01  0.349    0.333   0.22566    -0.1982    0.6495  0.297
## 11:01   424        56    51.9        48.2 1.403e-01  0.708    0.670  -0.14697    -0.7047    0.4107  0.606
## 23:01   452        28    50.9        60.7 6.643e-01  0.415    0.336   0.39992    -0.3805    1.1804  0.315
## 24:02   370       110    50.5        54.5 3.959e-01  0.529    0.515   0.16070    -0.2664    0.5878  0.461
## 25:01   463        17    51.0        64.7 7.495e-01  0.387    0.327   0.56725    -0.4440    1.5785  0.272
## 26:08   436        44    52.1        45.5 4.594e-01  0.498    0.432  -0.26494    -0.8874    0.3575  0.404
## 29:01   452        28    52.4        35.7 2.319e+00  0.128    0.118  -0.68521    -1.4800    0.1095  0.091
## 29:02   423        57    51.5        50.9 1.075e-30  1.000    1.000  -0.02639    -0.5796    0.5268  0.925
## 31:01   427        53    52.0        47.2 2.669e-01  0.605    0.561  -0.19300    -0.7647    0.3788  0.508
## 32:01   462        18    51.5        50.0 2.527e-29  1.000    1.000  -0.06062    -1.0024    0.8812  0.900
## 32:02   373       107    50.1        56.1 9.490e-01  0.330    0.323   0.23884    -0.1935    0.6712  0.279
## 33:01   479         1    51.4       100.0 1.477e-30  1.000    1.000  13.51177 -1035.8748 1062.8984  0.980
## 68:01   429        51    50.3        60.8 1.591e+00  0.207    0.183   0.42427    -0.1689    1.0174  0.161
## 68:06   417        63    50.6        57.1 6.945e-01  0.405    0.347   0.26370    -0.2709    0.7983  0.334
```

```
hlaAssocTest(hla, disease ~ h, data=dat, showOR=TRUE)  # report odd ratio instead of log odd ratio
```

```
## Logistic regression (dominant model) with 500 individuals:
##   glm(disease ~ h, family = binomial, data = data)
##       [-/-] [-/h,h/h] %.[-/-] %.[-/h,h/h]  chisq.st chisq.p fisher.p  h.est_OR h.2.5%_OR h.97.5%_OR  h.pval
## 26:01   468        32    54.1        15.6 1.621e+01 <0.001*  <0.001* 1.574e-01   0.05957     0.4157 <0.001*
## -----
## 01:01   427        73    51.3        53.4 4.446e-02  0.833    0.800  1.089e+00   0.66244     1.7917  0.736
## 02:01   474        26    52.3        38.5 1.381e+00  0.240    0.226  5.696e-01   0.25327     1.2808  0.173
## 02:05   441        59    52.8        42.4 1.881e+00  0.170    0.165  6.564e-01   0.37903     1.1368  0.133
## 03:01   383       117    50.1        56.4 1.175e+00  0.278    0.246  1.287e+00   0.84866     1.9529  0.235
## 11:01   442        58    51.8        50.0 1.431e-02  0.905    0.889  9.301e-01   0.53799     1.6081  0.795
## 23:01   470        30    51.1        60.0 5.794e-01  0.447    0.354  1.437e+00   0.67737     3.0506  0.345
## 24:02   387       113    50.4        55.8 8.045e-01  0.370    0.337  1.241e+00   0.81407     1.8907  0.316
## 25:01   481        19    50.9        68.4 1.592e+00  0.207    0.163  2.087e+00   0.78040     5.5816  0.143
## 26:08   455        45    52.3        44.4 7.234e-01  0.395    0.350  7.294e-01   0.39392     1.3506  0.315
## 29:01   472        28    52.5        35.7 2.361e+00  0.124    0.118  5.018e-01   0.22686     1.1099  0.089
## 29:02   440        60    51.6        51.7 3.369e-30  1.000    1.000  1.003e+00   0.58466     1.7208  0.991
## 31:01   445        55    51.9        49.1 6.335e-02  0.801    0.775  8.933e-01   0.51007     1.5645  0.693
## 32:01   482        18    51.7        50.0 9.437e-31  1.000    1.000  9.357e-01   0.36514     2.3980  0.890
## 32:02   389       111    50.4        55.9 8.273e-01  0.363    0.333  1.246e+00   0.81529     1.9041  0.310
## 33:01   498         2    51.4       100.0 4.403e-01  0.507    0.500  2.002e+06   0.00000        Inf  0.981
## 68:01   448        52    50.4        61.5 1.873e+00  0.171    0.144  1.572e+00   0.87247     2.8313  0.132
## 68:06   433        67    51.0        55.2 2.565e-01  0.613    0.600  1.183e+00   0.70544     1.9842  0.524
```

```
hlaAssocTest(hla, disease ~ h + pc1, data=dat)  # confounding variable pc1
```

```
## Logistic regression (dominant model) with 500 individuals:
##   glm(disease ~ h + pc1, family = binomial, data = data)
##       [-/-] [-/h,h/h] %.[-/-] %.[-/h,h/h]  chisq.st chisq.p fisher.p     h.est     h.2.5%   h.97.5%  h.pval
## 26:01   468        32    54.1        15.6 1.621e+01 <0.001*  <0.001* -1.853857    -2.8256   -0.8821 <0.001*
## -----
## 01:01   427        73    51.3        53.4 4.446e-02  0.833    0.800   0.082045    -0.4158    0.5799  0.747
## 02:01   474        26    52.3        38.5 1.381e+00  0.240    0.226  -0.579229    -1.3919    0.2335  0.162
## 02:05   441        59    52.8        42.4 1.881e+00  0.170    0.165  -0.435378    -0.9869    0.1162  0.122
## 03:01   383       117    50.1        56.4 1.175e+00  0.278    0.246   0.250189    -0.1667    0.6671  0.240
## 11:01   442        58    51.8        50.0 1.431e-02  0.905    0.889  -0.069363    -0.6171    0.4784  0.804
## 23:01   470        30    51.1        60.0 5.794e-01  0.447    0.354   0.370754    -0.3825    1.1240  0.335
## 24:02   387       113    50.4        55.8 8.045e-01  0.370    0.337   0.219475    -0.2023    0.6412  0.308
## 25:01   481        19    50.9        68.4 1.592e+00  0.207    0.163   0.750118    -0.2352    1.7355  0.136
## 26:08   455        45    52.3        44.4 7.234e-01  0.395    0.350  -0.315579    -0.9318    0.3006  0.316
## 29:01   472        28    52.5        35.7 2.361e+00  0.124    0.118  -0.684869    -1.4791    0.1094  0.091
## 29:02   440        60    51.6        51.7 3.369e-30  1.000    1.000   0.008454    -0.5319    0.5488  0.976
## 31:01   445        55    51.9        49.1 6.335e-02  0.801    0.775  -0.107611    -0.6686    0.4534  0.707
## 32:01   482        18    51.7        50.0 9.437e-31  1.000    1.000  -0.074015    -1.0159    0.8679  0.878
## 32:02   389       111    50.4        55.9 8.273e-01  0.363    0.333   0.216892    -0.2075    0.6413  0.316
## 33:01   498         2    51.4       100.0 4.403e-01  0.507    0.500  14.514988 -1208.0722 1237.1022  0.981
## 68:01   448        52    50.4        61.5 1.873e+00  0.171    0.144   0.470353    -0.1215    1.0622  0.119
## 68:06   433        67    51.0        55.2 2.565e-01  0.613    0.600   0.165689    -0.3516    0.6830  0.530
##       pc1.est pc1.2.5% pc1.97.5% pc1.pval
## 26:01 0.04909  -0.1283    0.2265   0.588
## -----
## 01:01 0.03941  -0.1349    0.2138   0.658
## 02:01 0.04951  -0.1255    0.2246   0.579
## 02:05 0.05251  -0.1228    0.2278   0.557
## 03:01 0.03749  -0.1370    0.2120   0.674
## 11:01 0.03980  -0.1345    0.2141   0.655
## 23:01 0.04397  -0.1306    0.2185   0.622
## 24:02 0.04368  -0.1309    0.2183   0.624
## 25:01 0.04803  -0.1268    0.2228   0.590
## 26:08 0.04038  -0.1341    0.2148   0.650
## 29:01 0.03575  -0.1391    0.2106   0.689
## 29:02 0.04045  -0.1340    0.2149   0.649
## 31:01 0.03895  -0.1355    0.2134   0.662
## 32:01 0.04081  -0.1336    0.2152   0.646
## 32:02 0.03738  -0.1371    0.2119   0.675
## 33:01 0.04154  -0.1333    0.2163   0.641
## 68:01 0.05452  -0.1211    0.2301   0.543
## 68:06 0.03915  -0.1352    0.2135   0.660
```

```
hlaAssocTest(hla, disease ~ h, data=dat, model="additive")  # use an additive model
```

```
## Logistic regression (additive model) with 500 individuals:
##   glm(disease ~ h, family = binomial, data = data)
##       [-] [h] %.[-] %.[h]  chisq.st chisq.p fisher.p    h.est     h.2.5%   h.97.5%  h.pval
## 26:01 967  33  52.8  15.2 1.668e+01 <0.001*  <0.001* -1.82587    -2.7913   -0.8604 <0.001*
## -----
## 01:01 925  75  51.4  54.7 1.870e-01  0.665    0.632   0.13636    -0.3420    0.6147  0.576
## 02:01 972  28  52.0  39.3 1.279e+00  0.258    0.250  -0.46222    -1.1962    0.2718  0.217
## 02:05 941  59  52.2  42.4 1.763e+00  0.184    0.179  -0.42099    -0.9702    0.1282  0.133
## 03:01 876 124  51.0  55.6 7.518e-01  0.386    0.339   0.18821    -0.1929    0.5693  0.333
## 11:01 940  60  51.8  48.3 1.513e-01  0.697    0.690  -0.13812    -0.6588    0.3825  0.603
## 23:01 970  30  51.3  60.0 5.615e-01  0.454    0.362   0.36291    -0.3895    1.1153  0.345
## 24:02 878 122  50.8  57.4 1.603e+00  0.206    0.177   0.25841    -0.1197    0.6366  0.180
## 25:01 981  19  51.3  68.4 1.561e+00  0.211    0.167   0.73576    -0.2480    1.7195  0.143
## 26:08 953  47  52.0  42.6 1.258e+00  0.262    0.233  -0.36825    -0.9510    0.2145  0.216
## 29:01 972  28  52.1  35.7 2.293e+00  0.130    0.124  -0.68957    -1.4834    0.1043  0.089
## 29:02 938  62  51.7  50.0 1.667e-02  0.897    0.795  -0.06808    -0.5815    0.4453  0.795
## 31:01 943  57  51.9  47.4 2.723e-01  0.602    0.586  -0.17724    -0.7093    0.3548  0.514
## 32:01 982  18  51.6  50.0 4.632e-31  1.000    1.000  -0.06641    -1.0075    0.8746  0.890
## 32:02 886 114  51.0  56.1 8.668e-01  0.352    0.321   0.22164    -0.1856    0.6289  0.286
## 33:01 998   2  51.5 100.0 4.394e-01  0.507    0.500  14.50983 -1208.8876 1237.9073  0.981
## 68:01 948  52  51.1  61.5 1.770e+00  0.183    0.155   0.45215    -0.1364    1.0407  0.132
## 68:06 930  70  51.2  57.1 7.027e-01  0.402    0.386   0.23664    -0.2506    0.7239  0.341
```

```
hlaAssocTest(hla, trait ~ h, data=dat)  # continuous outcome
```

```
## Linear regression (dominant model) with 500 individuals:
##   glm(trait ~ h, data = data)
##       [-/-] [-/h,h/h] avg.[-/-] avg.[-/h,h/h] ttest.p    h.est  h.2.5% h.97.5% h.pval
## 33:01   498         2 -0.015763    -0.3650000  0.006* -0.34924 -1.6842  0.9857 0.608
## -----
## 01:01   427        73 -0.030445     0.0605479  0.461   0.09099 -0.1476  0.3295 0.455
## 02:01   474        26 -0.023312     0.0950000  0.558   0.11831 -0.2611  0.4978 0.541
## 02:05   441        59 -0.021701     0.0167797  0.779   0.03848 -0.2227  0.2997 0.773
## 03:01   383       117 -0.019817    -0.0084615  0.905   0.01136 -0.1877  0.2104 0.911
## 11:01   442        58 -0.014050    -0.0408621  0.842  -0.02681 -0.2900  0.2364 0.842
## 23:01   470        30 -0.006404    -0.1856667  0.295  -0.17926 -0.5338  0.1753 0.322
## 24:02   387       113 -0.021059    -0.0038053  0.862   0.01725 -0.1843  0.2188 0.867
## 25:01   481        19 -0.024844     0.1773684  0.452   0.20221 -0.2382  0.6427 0.369
## 26:01   468        32 -0.010107    -0.1203125  0.577  -0.11021 -0.4544  0.2340 0.531
## 26:08   455        45 -0.009187    -0.0977778  0.569  -0.08859 -0.3830  0.2058 0.556
## 29:01   472        28 -0.013242    -0.0832143  0.737  -0.06997 -0.4365  0.2965 0.708
## 29:02   440        60 -0.026705     0.0528333  0.563   0.07954 -0.1797  0.3388 0.548
## 31:01   445        55 -0.009843    -0.0763636  0.644  -0.06652 -0.3358  0.2028 0.629
## 32:01   482        18 -0.009606    -0.2194444  0.265  -0.20984 -0.6619  0.2422 0.363
## 32:02   389       111 -0.022159     0.0003604  0.835   0.02252 -0.1803  0.2253 0.828
## 68:01   448        52 -0.010804    -0.0719231  0.678  -0.06112 -0.3372  0.2149 0.665
## 68:06   433        67 -0.015658    -0.0268657  0.929  -0.01121 -0.2586  0.2362 0.929
```

### Amino Acid Association

We convert [P-coded](http://hla.alleles.org/alleles/p_groups.html) alleles to amino acid sequences. `hlaConvSequence(..., code="P.code.merge")` returns the protein sequence in the ‘antigen binding domains’ (exons 2 and 3 for HLA Class I genes, exon 2 for HLA Class II genes).

```
aa <- hlaConvSequence(hla, code="P.code.merge")
```

```
## Allelic ambiguity: 68:01, 03:01, 31:01, 01:01, 29:01, 02:01, 29:02, 32:01, 25:01, 02:05, 24:02, 26:01, 11:01, 33:01, 23:01
```

1. the sequence is displayed as a hyphen (-) where it is identical to the reference.
2. an insertion or deletion is represented by a period (.).
3. an unknown or ambiguous position in the alignment is represented by an asterisk (\*).
4. a capital X is used for the ‘stop’ codons in protein alignments.

```
head(c(aa$value$allele1, aa$value$allele2))
```

```
## [1] "*-------Y----------------------------------R-----------------RN---V--Q-----VD------------A------M-------S---------------------K--------------T--H----A-V---W-A----T--EW---------------*"
## [2] "*------------------------------------------R----------------------V--Q-----VD------------A--------------S--------------------------------------------A-E---L-A--D-T--EW---------------*"
## [3] "*-------T----------------------------------R-----------R----------V-----I--VD------------A------M-------S--------Q-----------------------------Q-----ARV---L-A----T--EW---------------*"
## [4] "*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*"
## [5] "*------------------------------------------R----------------------V--Q-----VD------------A--------------S--------------------------------------------A-E---L-A--D-T--EW---------------*"
## [6] "*-------T----------------------------------R-----------R----------V-----I--VD------------A------M-------S--------Q-----------------------------Q-----ARV---L-A----T--EW---------------*"
```

```
# show cross tabulation at each amino acid position
summary(aa)
```

```
##  Pos  Num    *    -    A    D    E    F    G    H    I    K    L    M    N    Q    R    S    T    V    W    Y
##    1 1000  839  161    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .
##    9 1000    .  359    .    .    .    .    .    .    .    .    .    .    .    .    .  152  149    .    .  340
##   43 1000    .  941    .    .    .    .    .    .    .    .    .    .    .    .   59    .    .    .    .    .
##   44 1000    .   75    .    .    .    .    .    .    .    .    .    .    .    .  925    .    .    .    .    .
##   56 1000    .  943    .    .    .    .    .    .    .    .    .    .    .    .   57    .    .    .    .    .
##   62 1000    .  448    .    .  152    .   87    .    .    .   90    .    .    .  223    .    .    .    .    .
##   63 1000    .  687    .    .    .    .    .    .    .    .    .    .  223   90    .    .    .    .    .    .
##   65 1000    .  848    .    .    .    .  152    .    .    .    .    .    .    .    .    .    .    .    .    .
##   66 1000    .  761    .    .    .    .    .    .    .  239    .    .    .    .    .    .    .    .    .    .
##   67 1000    .   75    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .  925    .    .
##   70 1000    .  604    .    .    .    .    .    .    .    .    .    .    .  396    .    .    .    .    .    .
##   73 1000    .  941    .    .    .    .    .    .   59    .    .    .    .    .    .    .    .    .    .    .
##   74 1000    .  913    .    .    .    .    .   87    .    .    .    .    .    .    .    .    .    .    .    .
##   76 1000    .  245    .    .  303    .    .    .    .    .    .    .    .    .    .    .    .  452    .    .
##   77 1000    .  397    .  452    .    .    .    .    .    .    .    .    .    .    .  151    .    .    .    .
##   79 1000    .  697    .    .    .    .    .    .    .    .    .    .    .    .  303    .    .    .    .    .
##   80 1000    .  697    .    .    .    .    .    .  303    .    .    .    .    .    .    .    .    .    .    .
##   81 1000    .  697  303    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .
##   82 1000    .  697    .    .    .    .    .    .    .    .  303    .    .    .    .    .    .    .    .    .
##   83 1000    .  697    .    .    .    .    .    .    .    .    .    .    .    .  303    .    .    .    .    .
##   90 1000    .  234  766    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .
##   95 1000    .  761    .    .    .    .    .    .    .    .  211    .    .    .    .    .    .   28    .    .
##   97 1000    .  259    .    .    .    .    .    .    .    .    .  555    .    .  186    .    .    .    .    .
##   99 1000    .  848    .    .    .  152    .    .    .    .    .    .    .    .    .    .    .    .    .    .
##  102 1000    .  972    .    .    .    .    .   28    .    .    .    .    .    .    .    .    .    .    .    .
##  105 1000    .  366    .    .    .    .    .    .    .    .    .    .    .    .    .  634    .    .    .    .
##  107 1000    .  913    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .   87    .
##  109 1000    .  868    .    .    .    .    .    .    .    .  132    .    .    .    .    .    .    .    .    .
##  114 1000    .  401    .    .   70    .    .  239    .    .    .    .    .  290    .    .    .    .    .    .
##  116 1000    .  691    .    .    .    .    .   70    .    .    .    .    .    .    .    .    .    .    .  239
##  127 1000    .  639    .    .    .    .    .    .    .  361    .    .    .    .    .    .    .    .    .    .
##  142 1000    .  791    .    .    .    .    .    .    .    .    .    .    .    .    .    .  209    .    .    .
##  144 1000    .  590    .    .    .    .    .    .    .    .    .    .    .  410    .    .    .    .    .    .
##  145 1000    .  791    .    .    .    .    .  209    .    .    .    .    .    .    .    .    .    .    .    .
##  149 1000    .  901    .    .    .    .    .    .    .    .    .    .    .    .    .    .   99    .    .    .
##  150 1000    .   75  925    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .
##  151 1000    .  803    .    .    .    .    .    .    .    .    .    .    .    .  197    .    .    .    .    .
##  152 1000    .  135    .    .  223    .    .    .    .    .    .    .    .    .    .    .    .  642    .    .
##  156 1000    .   75    .    .    .    .    .    .    .    .  349    .    .  343    .    .    .    .  233    .
##  158 1000    .   75  925    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .
##  161 1000    .  876    .  124    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .
##  163 1000    .  234    .    .    .    .    .    .    .    .    .    .    .    .    .    .  766    .    .    .
##  166 1000    .  227    .    .  773    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .
##  167 1000    .  227    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .  773    .
##  171 1000    .  998    .    .    .    .    .    2    .    .    .    .    .    .    .    .    .    .    .    .
##  183 1000  839  161    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .    .
```

```
# association tests
hlaAssocTest(aa, disease ~ h, data=dat, model="dominant")  # try dominant models
```

```
## Logistic regression (dominant model) with 500 individuals:
##     pos  num ref      poly fisher.p   amino.acid     h.est     h.2.5%    h.97.5%  h.pval
## 70   62 1000   Q -,E,G,L,R   0.089  -,E,L,R vs G  -0.48863 -9.682e-01 -9.098e-03  0.046*
## 91   74 1000   D       -,H   0.056        - vs H  -0.48863 -9.682e-01 -9.098e-03  0.046*
## 92   74 1000   D       -,H   0.056        - vs H  -0.48863 -9.682e-01 -9.098e-03  0.046*
## 94   76 1000   A     -,E,V   0.006*     - vs E,V   0.71784 -8.666e-03  1.444e+00  0.053
## 95   76 1000   A     -,E,V   0.006*     -,V vs E   0.38177  2.926e-02  7.343e-01  0.034*
## 96   76 1000   A     -,E,V   0.006*     -,E vs V   0.11153 -2.677e-01  4.907e-01  0.564
## 101  79 1000   G       -,R   0.016*       - vs R   0.38177  2.926e-02  7.343e-01  0.034*
## 102  79 1000   G       -,R   0.016*       - vs R   0.38177  2.926e-02  7.343e-01  0.034*
## 103  80 1000   T       -,I   0.016*       - vs I   0.38177  2.926e-02  7.343e-01  0.034*
## 104  80 1000   T       -,I   0.016*       - vs I   0.38177  2.926e-02  7.343e-01  0.034*
## 105  81 1000   L       -,A   0.016*       - vs A   0.38177  2.926e-02  7.343e-01  0.034*
## 106  81 1000   L       -,A   0.016*       - vs A   0.38177  2.926e-02  7.343e-01  0.034*
## 107  82 1000   R       -,L   0.016*       - vs L   0.38177  2.926e-02  7.343e-01  0.034*
## 108  82 1000   R       -,L   0.016*       - vs L   0.38177  2.926e-02  7.343e-01  0.034*
## 109  83 1000   G       -,R   0.016*       - vs R   0.38177  2.926e-02  7.343e-01  0.034*
## 110  83 1000   G       -,R   0.016*       - vs R   0.38177  2.926e-02  7.343e-01  0.034*
## 127  97 1000   I     -,M,R   0.002*     - vs M,R   0.06697 -7.878e-01  9.217e-01  0.878
## 128  97 1000   I     -,M,R   0.002*     -,R vs M   0.53138  5.976e-02  1.003e+00  0.027*
## 129  97 1000   I     -,M,R   0.002*     -,M vs R  -0.65698 -1.033e+00 -2.809e-01 <0.001*
## 142 107 1000   G       -,W   0.056        - vs W  -0.48863 -9.682e-01 -9.098e-03  0.046*
## 143 107 1000   G       -,W   0.056        - vs W  -0.48863 -9.682e-01 -9.098e-03  0.046*
## 195 149 1000   A       -,T   0.006*       - vs T  -0.55565 -1.012e+00 -9.979e-02  0.017*
## 196 149 1000   A       -,T   0.006*       - vs T  -0.55565 -1.012e+00 -9.979e-02  0.017*
```

```
hlaAssocTest(aa, disease ~ h, data=dat, model="dominant", prob.threshold=0.5)  # try dominant models
```

```
## Exclude 20 individuals from the study due to the call threshold (0.5)
## Logistic regression (dominant model) with 480 individuals:
##     pos num ref  poly fisher.p amino.acid     h.est     h.2.5%    h.97.5% h.pval
## 94   76 960   A -,E,V   0.026*   - vs E,V   0.66262 -7.054e-02    1.39577 0.076
## 95   76 960   A -,E,V   0.026*   -,V vs E   0.34761 -1.188e-02    0.70710 0.058
## 96   76 960   A -,E,V   0.026*   -,E vs V   0.06517 -3.216e-01    0.45198 0.741
## 101  79 960   G   -,R   0.035*     - vs R   0.34761 -1.188e-02    0.70710 0.058
## 102  79 960   G   -,R   0.035*     - vs R   0.34761 -1.188e-02    0.70710 0.058
## 103  80 960   T   -,I   0.035*     - vs I   0.34761 -1.188e-02    0.70710 0.058
## 104  80 960   T   -,I   0.035*     - vs I   0.34761 -1.188e-02    0.70710 0.058
## 105  81 960   L   -,A   0.035*     - vs A   0.34761 -1.188e-02    0.70710 0.058
## 106  81 960   L   -,A   0.035*     - vs A   0.34761 -1.188e-02    0.70710 0.058
## 107  82 960   R   -,L   0.035*     - vs L   0.34761 -1.188e-02    0.70710 0.058
## 108  82 960   R   -,L   0.035*     - vs L   0.34761 -1.188e-02    0.70710 0.058
## 109  83 960   G   -,R   0.035*     - vs R   0.34761 -1.188e-02    0.70710 0.058
## 110  83 960   G   -,R   0.035*     - vs R   0.34761 -1.188e-02    0.70710 0.058
## 127  97 960   I -,M,R   0.004*   - vs M,R   0.06089 -8.345e-01    0.95628 0.894
## 128  97 960   I -,M,R   0.004*   -,R vs M   0.55575  6.717e-02    1.04432 0.026*
## 129  97 960   I -,M,R   0.004*   -,M vs R  -0.63547 -1.020e+00   -0.25115 0.001*
## 195 149 960   A   -,T   0.012*     - vs T  -0.52109 -9.901e-01   -0.05203 0.029*
## 196 149 960   A   -,T   0.012*     - vs T  -0.52109 -9.901e-01   -0.05203 0.029*
```

```
hlaAssocTest(aa, disease ~ h, data=dat, model="recessive")  # try recessive models
```

```
## Logistic regression (recessive model) with 500 individuals:
##     pos  num ref      poly fisher.p   amino.acid     h.est     h.2.5%    h.97.5% h.pval
## 10    9 1000   F   -,S,T,Y   0.108    -,T,Y vs S   1.67600  1.590e-01    3.19299 0.030*
## 68   62 1000   Q -,E,G,L,R   0.089  -,G,L,R vs E   1.67600  1.590e-01    3.19299 0.030*
## 76   65 1000   R       -,G   0.095        - vs G   1.67600  1.590e-01    3.19299 0.030*
## 77   65 1000   R       -,G   0.095        - vs G   1.67600  1.590e-01    3.19299 0.030*
## 93   76 1000   A     -,E,V   0.006*     - vs E,V   0.45718  9.996e-02    0.81440 0.012*
## 94   76 1000   A     -,E,V   0.006*     -,V vs E   0.58152 -5.592e-02    1.21896 0.074
## 95   76 1000   A     -,E,V   0.006*     -,E vs V  -0.05768 -4.852e-01    0.36984 0.791
## 100  79 1000   G       -,R   0.016*       - vs R   0.58152 -5.592e-02    1.21896 0.074
## 101  79 1000   G       -,R   0.016*       - vs R   0.58152 -5.592e-02    1.21896 0.074
## 102  80 1000   T       -,I   0.016*       - vs I   0.58152 -5.592e-02    1.21896 0.074
## 103  80 1000   T       -,I   0.016*       - vs I   0.58152 -5.592e-02    1.21896 0.074
## 104  81 1000   L       -,A   0.016*       - vs A   0.58152 -5.592e-02    1.21896 0.074
## 105  81 1000   L       -,A   0.016*       - vs A   0.58152 -5.592e-02    1.21896 0.074
## 106  82 1000   R       -,L   0.016*       - vs L   0.58152 -5.592e-02    1.21896 0.074
## 107  82 1000   R       -,L   0.016*       - vs L   0.58152 -5.592e-02    1.21896 0.074
## 108  83 1000   G       -,R   0.016*       - vs R   0.58152 -5.592e-02    1.21896 0.074
## 109  83 1000   G       -,R   0.016*       - vs R   0.58152 -5.592e-02    1.21896 0.074
## 126  97 1000   I     -,M,R   0.002*     - vs M,R  -0.18350 -5.352e-01    0.16819 0.306
## 127  97 1000   I     -,M,R   0.002*     -,R vs M   0.28787 -1.043e-01    0.68003 0.150
## 128  97 1000   I     -,M,R   0.002*     -,M vs R  -0.97078 -2.029e+00    0.08766 0.072
## 130  99 1000   Y       -,F   0.095        - vs F   1.67600  1.590e-01    3.19299 0.030*
## 131  99 1000   Y       -,F   0.095        - vs F   1.67600  1.590e-01    3.19299 0.030*
## 186 144 1000   K       -,Q   0.108        - vs Q  -0.52294 -1.006e+00   -0.03991 0.034*
## 187 144 1000   K       -,Q   0.108        - vs Q  -0.52294 -1.006e+00   -0.03991 0.034*
## 193 149 1000   A       -,T   0.006*       - vs T -15.65097 -1.291e+03 1260.03779 0.981
## 194 149 1000   A       -,T   0.006*       - vs T -15.65097 -1.291e+03 1260.03779 0.981
```

# Resources

* Allele Frequency Net Database (AFND): <http://www.allelefrequencies.net>.
* IMGT/HLA Database: <https://www.ebi.ac.uk/ipd/imgt/hla/>.
* HLA Nomenclature: [G Codes](http://hla.alleles.org/alleles/g_groups.html) and [P Codes](http://hla.alleles.org/alleles/p_groups.html) for reporting of ambiguous allele typings.

# Session Info

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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] HIBAG_1.46.0
##
## loaded via a namespace (and not attached):
##  [1] crayon_1.5.3          vctrs_0.6.5           cli_3.6.5             knitr_1.50
##  [5] rlang_1.1.6           xfun_0.53             generics_0.1.4        S7_0.2.0
##  [9] jsonlite_2.0.0        labeling_0.4.3        RcppParallel_5.1.11-1 glue_1.8.0
## [13] htmltools_0.5.8.1     sass_0.4.10           scales_1.4.0          rmarkdown_2.30
## [17] grid_4.5.1            tibble_3.3.0          evaluate_1.0.5        jquerylib_0.1.4
## [21] fastmap_1.2.0         yaml_2.3.10           lifecycle_1.0.4       compiler_4.5.1
## [25] dplyr_1.1.4           RColorBrewer_1.1-3    pkgconfig_2.0.3       farver_2.1.2
## [29] digest_0.6.37         R6_2.6.1              tidyselect_1.2.1      dichromat_2.0-0.1
## [33] pillar_1.11.1         magrittr_2.0.4        bslib_0.9.0           withr_3.0.2
## [37] tools_4.5.1           gtable_0.3.6          ggplot2_4.0.0         cachem_1.1.0
```

# References

Breiman, Leo. 1996. “Bagging Predictors.” *Mach. Learn.* 24 (2): 123–40. [https://doi.org/10.1023/A:1018054314350](https://doi.org/10.1023/A%3A1018054314350).

———. 2001. “Random Forests.” *Mach. Learn.* 45 (1): 5–32. [https://doi.org/10.1023/A:1010933404324](https://doi.org/10.1023/A%3A1010933404324).

Bryll, Robert, Ricardo Gutierrez-Osuna, and Francis Quek. 2003. “Attribute Bagging: Improving Accuracy of Classifier Ensembles by Using Random Feature Subsets.” *Pattern Recognition* 36 (6): 1291–1302. [https://doi.org/10.1016/S0031-3203(02)00121-8](https://doi.org/10.1016/S0031-3203%2802%2900121-8).

Robinson, James, Jason A. Halliwell, Hamish McWilliam, Rodrigo Lopez, Peter Parham, and Steven G. E. Marsh. 2013. “The IMGT/HLA Database.” *Nucleic Acids Res* 41 (Database issue): 1222–7. <https://doi.org/10.1093/nar/gks949>.

Shiina, Takashi, Kazuyoshi Hosomichi, Hidetoshi Inoko, and Jerzy Kulski. 2009. “The HLA Genomic Loci Map: Expression, Interaction, Diversity and Disease.” *Journal of Human Genetics* 54 (1): 15–39. <https://doi.org/10.1038/jhg.2008.5>.

Zheng, Xiuwen, Judong Shen, Charles Cox, Jonathan C. Wakefield, Margaret G. Ehm, Matthew R. Nelson, and Bruce S. Weir. 2014. “HIBAG – HLA Genotype Imputation with Attribute Bagging.” *Pharmacogenomics J*. <https://doi.org/10.1038/tpj.2013.18>.