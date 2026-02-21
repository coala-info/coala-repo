# Identification and analysis of miRNA sponge regulation

\
Junpeng Zhang ()\
School of Engineering, Dali University

#### 2025-12-25

# Contents

* [1 Introduction](#introduction)
* [2 Identification of miRNA sponge interactions](#identification-of-mirna-sponge-interactions)
  + [2.1 miRHomology](#mirhomology)
  + [2.2 pc](#pc)
  + [2.3 sppc](#sppc)
  + [2.4 hermes](#hermes)
  + [2.5 ppc](#ppc)
  + [2.6 muTaME](#mutame)
  + [2.7 cernia](#cernia)
  + [2.8 SPONGE](#sponge)
  + [2.9 integrateMethod](#integratemethod)
* [3 Identifying sample-specific miRNA sponge interaction networks](#identifying-sample-specific-mirna-sponge-interaction-networks)
* [4 Identifying sample-sample correlation network](#identifying-sample-sample-correlation-network)
* [5 Validation of miRNA sponge interactions](#validation-of-mirna-sponge-interactions)
* [6 Module identification from miRNA sponge network](#module-identification-from-mirna-sponge-network)
* [7 Disease and functional enrichment analysis of miRNA sponge modules](#disease-and-functional-enrichment-analysis-of-mirna-sponge-modules)
* [8 Survival analysis of miRNA sponge modules](#survival-analysis-of-mirna-sponge-modules)
* [9 Conclusions](#conclusions)
* [10 References](#references)
* **Appendix**
* [A Session information](#session-information)

# 1 Introduction

MicroRNAs (miRNAs) are small non-coding RNAs (~22 nt) that control a
wide range of biological processes including cancers via regulating
target genes [1-5]. Therefore, it is important to uncover miRNA functions
and regulatory mechanisms in cancers.

The emergence of competing endogenous RNA (ceRNA) hypothesis [6]
has challenged the traditional knowledge that coding RNAs only act
as targets of miRNAs. Actually, a pool of coding and non-coding
RNAs that shares common miRNA biding sites competes with each other,
thus act as ceRNAs to release coding RNAs from miRNAs control.
These ceRNAs are also known as miRNA sponges or miRNA decoys, and
include long non-coding RNAs (lncRNAs), pseudogenes, circular RNAs
(circRNAs) and messenger RNAs (mRNAs), etc [7-10]. Recent
studies [11, 12] have shown that miRNA sponge regulation
can help to reveal the biological mechanism in cancer.

To accelerate the research of miRNA sponge, an R package named
‘miRspongeR’ is developed to implement popular methods for the identification and
analysis of miRNA sponge regulation from putative miRNA-target interactions or/and transcriptomics data (including bulk, single-cell and spatial gene expression data).

# 2 Identification of miRNA sponge interactions

In ‘spongeMethod’ function, ‘miRspongeR’ implements eight popular methods
(including miRHomology [13, 14], pc [15, 16], sppc [17], ppc [11], hermes [18],
muTaME [19], cernia [20], and SPONGE [21]) to identify miRNA sponge interactions.
The eight methods should meet a basic condition: the significance of
sharing of miRNAs by each RNA-RNA pair (e.g. adjusted p-value < 0.01).
Each method has its own merit due to different evaluating indicators.
Thus, ‘miRspongeR’ presents an integrate method to combine predicted miRNA
sponge interactions from different methods.

## 2.1 miRHomology

The miRHomology method is based on the homology of sharing miRNAs.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
miRHomologyceRInt_original <- spongeMethod(miRTarget, method = "miRHomology")
miRHomologyceRInt_parallel <- spongeMethod(miRTarget, method = "miRHomology_parallel")
head(miRHomologyceRInt_original)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "1.61969028532605e-05"
## [2,] "QKI"    "TCF4"   "20"           "0.00164001938044806"
## [3,] "QKI"    "TNKS2"  "28"           "0.00098462411218998"
## [4,] "QKI"    "PTEN"   "31"           "0.00172299770543381"
## [5,] "QKI"    "KLF6"   "25"           "1.61969028532605e-05"
## [6,] "SOX5"   "RB1"    "11"           "0.00313418502601189"
```

```
head(miRHomologyceRInt_parallel)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "1.61969028532605e-05"
## [2,] "QKI"    "TCF4"   "20"           "0.00164001938044806"
## [3,] "QKI"    "TNKS2"  "28"           "0.00098462411218998"
## [4,] "QKI"    "PTEN"   "31"           "0.0017229977054338"
## [5,] "QKI"    "KLF6"   "25"           "1.61969028532605e-05"
## [6,] "SOX5"   "RB1"    "11"           "0.00313418502601189"
```

## 2.2 pc

The pc method considers expression data based on miRHomology method.
Significantly positive miRNA sponge pairs are regarded as output.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
pcceRInt_original <- spongeMethod(miRTarget, ExpData, method = "pc")
pcceRInt_parallel <- spongeMethod(miRTarget, ExpData, method = "pc_parallel")
head(pcceRInt_original)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "1.61969028532605e-05"
## [2,] "QKI"    "TCF4"   "20"           "0.00164001938044806"
## [3,] "QKI"    "TNKS2"  "28"           "0.00098462411218998"
## [4,] "QKI"    "PTEN"   "31"           "0.00172299770543381"
## [5,] "QKI"    "KLF6"   "25"           "1.61969028532605e-05"
## [6,] "SOX5"   "RB1"    "11"           "0.00313418502601189"
##      correlation         p.adjusted_value of positive correlation
## [1,] "0.491729673394525" "1.31981734203614e-09"
## [2,] "0.732930517949784" "2.7017217087929e-24"
## [3,] "0.397085235409979" "1.57216583466138e-06"
## [4,] "0.554784433631471" "2.2899877573925e-12"
## [5,] "0.605337991455224" "5.23010520014821e-15"
## [6,] "0.239965818711153" "0.00427058208653246"
```

```
head(pcceRInt_parallel)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "1.61969028532605e-05"
## [2,] "QKI"    "TCF4"   "20"           "0.00164001938044806"
## [3,] "QKI"    "TNKS2"  "28"           "0.00098462411218998"
## [4,] "QKI"    "PTEN"   "31"           "0.0017229977054338"
## [5,] "QKI"    "KLF6"   "25"           "1.61969028532605e-05"
## [6,] "SOX5"   "RB1"    "11"           "0.00313418502601189"
##      correlation         p.adjusted_value of positive correlation
## [1,] "0.491729673394525" "1.31981734203614e-09"
## [2,] "0.732930517949784" "2.70172170879289e-24"
## [3,] "0.397085235409979" "1.57216583466138e-06"
## [4,] "0.554784433631471" "2.2899877573925e-12"
## [5,] "0.605337991455224" "5.2301052001482e-15"
## [6,] "0.239965818711153" "0.00427058208653247"
```

## 2.3 sppc

The sppc method is based on sensitivity correlation (difference between the Pearson and partial correlation coefficients).

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
sppcceRInt_original <- spongeMethod(miRTarget, ExpData, senscorcutoff = 0.1, method = "sppc")
sppcceRInt_parallel <- spongeMethod(miRTarget, ExpData, senscorcutoff = 0.1, method = "sppc_parallel")
head(sppcceRInt_original)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "1.61969028532605e-05"
## [2,] "QKI"    "TCF4"   "20"           "0.00164001938044806"
## [3,] "QKI"    "TNKS2"  "28"           "0.00098462411218998"
## [4,] "QKI"    "PTEN"   "31"           "0.00172299770543381"
## [5,] "QKI"    "KLF6"   "25"           "1.61969028532605e-05"
## [6,] "SOX5"   "RB1"    "11"           "0.00313418502601189"
##      correlation         p.adjusted_value of positive correlation
## [1,] "0.491729673394525" "1.31981734203614e-09"
## [2,] "0.732930517949784" "2.7017217087929e-24"
## [3,] "0.397085235409979" "1.57216583466138e-06"
## [4,] "0.554784433631471" "2.2899877573925e-12"
## [5,] "0.605337991455224" "5.23010520014821e-15"
## [6,] "0.239965818711153" "0.00427058208653246"
##      sensitivity correlation
## [1,] "0.307037199068781"
## [2,] "0.316438618435415"
## [3,] "0.138436130309621"
## [4,] "0.346274495026087"
## [5,] "0.35430035370136"
## [6,] "0.188537090552443"
```

```
head(sppcceRInt_parallel)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "1.61969028532605e-05"
## [2,] "QKI"    "TCF4"   "20"           "0.00164001938044806"
## [3,] "QKI"    "TNKS2"  "28"           "0.00098462411218998"
## [4,] "QKI"    "PTEN"   "31"           "0.0017229977054338"
## [5,] "QKI"    "KLF6"   "25"           "1.61969028532605e-05"
## [6,] "SOX5"   "RB1"    "11"           "0.00313418502601189"
##      correlation         p.adjusted_value of positive correlation
## [1,] "0.491729673394525" "1.31981734203614e-09"
## [2,] "0.732930517949784" "2.70172170879289e-24"
## [3,] "0.397085235409979" "1.57216583466138e-06"
## [4,] "0.554784433631471" "2.2899877573925e-12"
## [5,] "0.605337991455224" "5.2301052001482e-15"
## [6,] "0.239965818711153" "0.00427058208653247"
##      sensitivity correlation
## [1,] "0.307037199068781"
## [2,] "0.316438618435415"
## [3,] "0.138436130309621"
## [4,] "0.346274495026087"
## [5,] "0.35430035370136"
## [6,] "0.188537090552443"
```

## 2.4 hermes

The hermes method predicts competing endogenous RNAs via evidence for competition for miRNA regulation based on conditional mutual information.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
hermesceRInt_original <- spongeMethod(miRTarget, ExpData, num_perm = 10, method = "hermes")
hermesceRInt_parallel <- spongeMethod(miRTarget, ExpData, num_perm = 10, method = "hermes_parallel")
head(hermesceRInt_original)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "RB1"    "PTEN"   "21"           "0.00334325253854548"
## [2,] "NFIA"   "TCF4"   "21"           "1.81490295278364e-05"
## [3,] "NFIA"   "PTEN"   "29"           "0.000182921588755158"
## [4,] "TCF4"   "PTEN"   "23"           "2.77533469138317e-05"
## [5,] "TNKS2"  "PTEN"   "27"           "0.0023042979609089"
## [6,] "PTEN"   "KLF6"   "23"           "0.000212770128446523"
##      p.adjusted_value of RNA competition
## [1,] "0.00190914380538203"
## [2,] "0.00727766809264517"
## [3,] "0.000390185000361397"
## [4,] "0.00727766809264517"
## [5,] "6.66672576504017e-05"
## [6,] "0.00727766809264517"
```

```
head(hermesceRInt_parallel)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "1.61969028532605e-05"
## [2,] "RB1"    "PTEN"   "21"           "0.00334325253854548"
## [3,] "NFIA"   "TCF4"   "21"           "1.81490295278364e-05"
## [4,] "NFIA"   "PTEN"   "29"           "0.000182921588755158"
## [5,] "NFIA"   "KLF6"   "23"           "1.61969028532605e-05"
## [6,] "TCF4"   "TNKS2"  "18"           "0.00164001938044806"
##      p.adjusted_value of RNA competition
## [1,] "0.0078785132484684"
## [2,] "0.00471053545284145"
## [3,] "0.00724824883014864"
## [4,] "0.000580893842499218"
## [5,] "0.0078785132484684"
## [6,] "0.0078785132484684"
```

Parameter ‘num\_perm’ is used to set the number of permutations of input expression data. The larger the number is, the slower the calculation is.

## 2.5 ppc

The ppc method is a variant of the hermes method. However, it predicts competing endogenous RNAs via evidence for competition for miRNA regulation based on Partial Pearson Correlation.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
ppcceRInt_original <- spongeMethod(miRTarget, ExpData, num_perm = 10, method = "ppc")
ppcceRInt_parallel <- spongeMethod(miRTarget, ExpData, num_perm = 10, method = "ppc_parallel")
head(ppcceRInt_original)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "1.61969028532605e-05"
## [2,] "QKI"    "TCF4"   "20"           "0.00164001938044806"
## [3,] "QKI"    "TNKS2"  "28"           "0.00098462411218998"
## [4,] "QKI"    "PTEN"   "31"           "0.00172299770543381"
## [5,] "QKI"    "KLF6"   "25"           "1.61969028532605e-05"
## [6,] "SOX5"   "RB1"    "11"           "0.00313418502601189"
##      p.adjusted_value of RNA competition
## [1,] "3.92174124322764e-10"
## [2,] "2.77892977932343e-07"
## [3,] "4.88029646097132e-09"
## [4,] "3.92174124322764e-10"
## [5,] "1.4424121031224e-09"
## [6,] "0.000185650372948758"
```

```
head(ppcceRInt_parallel)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "1.61969028532605e-05"
## [2,] "QKI"    "TCF4"   "20"           "0.00164001938044806"
## [3,] "QKI"    "TNKS2"  "28"           "0.00098462411218998"
## [4,] "QKI"    "PTEN"   "31"           "0.0017229977054338"
## [5,] "QKI"    "KLF6"   "25"           "1.61969028532605e-05"
## [6,] "SOX5"   "RB1"    "11"           "0.00313418502601189"
##      p.adjusted_value of RNA competition
## [1,] "3.24863700780281e-10"
## [2,] "2.98062018570175e-07"
## [3,] "1.18405467502079e-08"
## [4,] "4.23392739007838e-10"
## [5,] "1.44241210312241e-09"
## [6,] "0.000507544768697646"
```

Parameter ‘num\_perm’ is used to set the number of permutations of input
expression data. The larger the number is, the slower the calculation is.

## 2.6 muTaME

‘miRspongeR’ implements the muTaME method based on the logarithm
of four scores: (1) the fraction of common miRNAs, (2) the density of the
MREs for all shared miRNAs, (3) the distribution of MREs of the putative
RNA-RNA pairs and (4) the relation between the overall number of MREs for
a putative miRNA sponge compared with the number of miRNAs that yield these
MREs. There is no reason to decide which score has more contribution than
the rest. Thus, ‘miRspongeR’ calculates a combined score by adding these four scores. To evaluate the strength of each RNA-RNA pair, ‘miRspongeR’ further normalizes the combined scores to obtain normalized scores with interval [0 1].

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
MREs <- system.file("extdata", "MREs.csv", package="miRspongeR")
mres <- read.csv(MREs, header=TRUE, sep=",")
muTaMEceRInt_original <- spongeMethod(miRTarget, mres = mres, method = "muTaME")
muTaMEceRInt_parallel <- spongeMethod(miRTarget, mres = mres, method = "muTaME_parallel")
head(muTaMEceRInt_original)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "1.61969028532605e-05"
## [2,] "QKI"    "TCF4"   "20"           "0.00164001938044806"
## [3,] "QKI"    "TNKS2"  "28"           "0.00098462411218998"
## [4,] "QKI"    "PTEN"   "31"           "0.00172299770543381"
## [5,] "QKI"    "KLF6"   "25"           "1.61969028532605e-05"
## [6,] "NFIA"   "PTEN"   "29"           "0.000182921588755158"
##      Score 1              Score 2             Score 3
## [1,] "-0.437213806422745" "-165.610621988223" "257.7778713546"
## [2,] "-0.470003629245736" "-100.765642874738" "155.515558123873"
## [3,] "-0.559615787935423" "-152.637669361688" "228.018475194044"
## [4,] "-0.626455806061273" "-172.33389579933"  "256.339724121501"
## [5,] "-0.336472236621213" "-134.332311526516" "203.667092432857"
## [6,] "-0.503905180921417" "-126.210306682534" "179.441855213251"
##      Score 4               Combined score     Normalized score
## [1,] "-0.0201046632956751" "91.7099308966585" "1"
## [2,] "-0.0188882845202057" "54.2610233353697" "0.638676224274825"
## [3,] "-0.0226424767497598" "74.7985475676708" "0.836831425131288"
## [4,] "-0.0192015809668538" "83.3601709351436" "0.919437788919319"
## [5,] "-0.0209431738452431" "68.9773654958742" "0.780666062178499"
## [6,] "-0.0470453636900539" "52.6805979861055" "0.623427575071551"
```

```
head(muTaMEceRInt_parallel)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "1.61969028532605e-05"
## [2,] "QKI"    "TCF4"   "20"           "0.00164001938044806"
## [3,] "QKI"    "TNKS2"  "28"           "0.00098462411218998"
## [4,] "QKI"    "PTEN"   "31"           "0.0017229977054338"
## [5,] "QKI"    "KLF6"   "25"           "1.61969028532605e-05"
## [6,] "NFIA"   "PTEN"   "29"           "0.000182921588755158"
##      Score 1              Score 2             Score 3
## [1,] "-0.437213806422745" "-165.610621988223" "257.7778713546"
## [2,] "-0.470003629245736" "-100.765642874738" "155.515558123873"
## [3,] "-0.559615787935423" "-152.637669361688" "228.018475194044"
## [4,] "-0.626455806061273" "-172.33389579933"  "256.339724121501"
## [5,] "-0.336472236621213" "-134.332311526516" "203.667092432857"
## [6,] "-0.503905180921417" "-126.210306682534" "179.441855213251"
##      Score 4               Combined score     Normalized score
## [1,] "-0.0201046632956751" "91.7099308966585" "1"
## [2,] "-0.0188882845202057" "54.2610233353697" "0.638676224274825"
## [3,] "-0.0226424767497598" "74.7985475676708" "0.836831425131288"
## [4,] "-0.0192015809668538" "83.3601709351436" "0.919437788919319"
## [5,] "-0.0209431738452431" "68.9773654958742" "0.780666062178499"
## [6,] "-0.0470453636900539" "52.6805979861055" "0.623427575071551"
```

## 2.7 cernia

The cernia method is based on the logarithm of seven scores:
(1) the fraction of common miRNAs, (2) the density of the MREs for all shared miRNAs, (3) the distribution of MREs of the putative RNA-RNA pairs, (4) the relation between the overall number of MREs for a putative miRNA sponge compared with the
number of miRNAs that yield these MREs, (5) the density of the
hybridization energies related to MREs for all shared miRNAs, (6)
the DT-Hybrid recommendation scores and (7) the pairwise Pearson
correlation between putative RNA-RNA pair expression data. There
is no reason to decide which score has more contribution than the
rest. Thus, ‘miRspongeR’ calculates a combined score by adding these seven scores.
To evaluate the strength of each RNA-RNA pair, ‘miRspongeR’ further normalizes
the combined scores to obtain normalized scores with interval [0 1].

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
MREs <- system.file("extdata", "MREs.csv", package="miRspongeR")
mres <- read.csv(MREs, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
cerniaceRInt_original <- spongeMethod(miRTarget, ExpData, mres, method = "cernia")
cerniaceRInt_parallel <- spongeMethod(miRTarget, ExpData, mres, method = "cernia_parallel")
head(cerniaceRInt_original)
head(cerniaceRInt_parallel)
```

## 2.8 SPONGE

The SPONGE method predicts competing endogenous RNAs with sparse partial correlation.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
null_model_file <- system.file("extdata", "precomputed_null_model.rda", package="miRspongeR")
load(null_model_file)
spongeceRInt_parallel <- spongeMethod(miRTarget, ExpData, padjustvaluecutoff = 0.05, senscorcutoff = 0.1, null_model = precomputed_null_model, method = "sponge_parallel")
head(spongeceRInt_parallel)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "2.09606978101018e-05"
## [2,] "QKI"    "TNKS2"  "28"           "0.00127421943930468"
## [3,] "QKI"    "PTEN"   "31"           "0.00222976173644375"
## [4,] "QKI"    "KLF6"   "25"           "2.09606978101018e-05"
## [5,] "SOX5"   "NFIA"   "11"           "0.0396676479882845"
## [6,] "SOX5"   "TNKS2"  "12"           "0.0163679216117328"
##      correlation         p.adjusted_value of positive correlation
## [1,] "0.491729673394525" "1.70799891322324e-09"
## [2,] "0.397085235409979" "1.52592566305369e-06"
## [3,] "0.554784433631471" "2.9635135683903e-12"
## [4,] "0.605337991455224" "6.76837143548591e-15"
## [5,] "0.40652609360582"  "9.4248730164215e-07"
## [6,] "0.311193449867247" "0.000189927771179422"
##      partial correlation  sensitivity correlation
## [1,] "0.184692474325744"  "0.307037199068781"
## [2,] "0.258649105100357"  "0.138436130309621"
## [3,] "0.208509938605384"  "0.346274495026087"
## [4,] "0.251037637753863"  "0.35430035370136"
## [5,] "0.0968069891680943" "0.309719104437726"
## [6,] "0.0826156937347892" "0.228577756132458"
##      p.adjusted_value of sensitivity correlation
## [1,] "0.02"
## [2,] "0.0166666666666667"
## [3,] "0.0375"
## [4,] "0.0166666666666667"
## [5,] "0.0166666666666667"
## [6,] "0.025"
```

## 2.9 integrateMethod

To obtain a list of high-confidence miRNA sponge interactions, ‘miRspongeR’
implements ‘integrateMethod’ function to integrate results of different methods.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
pcceRInt <- spongeMethod(miRTarget, ExpData, method = "pc")
sppcceRInt <- spongeMethod(miRTarget, ExpData, method = "sppc")
Interlist <- list(miRHomologyceRInt[, 1:2], pcceRInt[, 1:2], sppcceRInt[, 1:2])
IntegrateceRInt <- integrateMethod(Interlist, Intersect_num = 2)
head(IntegrateceRInt)
```

```
##      sponge_1 sponge_2
## [1,] "QKI"    "NFIA"
## [2,] "QKI"    "TCF4"
## [3,] "QKI"    "TNKS2"
## [4,] "QKI"    "PTEN"
## [5,] "QKI"    "KLF6"
## [6,] "SOX5"   "RB1"
```

Parameter ‘Intersect\_num’ is used to set the least number of methods
intersected for integration. That is to say, ‘miRspongeR’ only reserves those
miRNA sponge interactions predicted by at least ‘Intersect\_num’ methods.

# 3 Identifying sample-specific miRNA sponge interaction networks

‘miRspongeR’ uses a sample control variable strategy to infer sample-specific miRNA sponge interaction network. In the strategy, eight popular methods (miRHomology, pc, sppc, ppc, hermes, muTaME, cernia, and SPONGE) to identify miRNA sponge interactions for each sample.

```
ExpDatacsv <- system.file("extdata","ExpData.csv",package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
sponge_sample_specific_net <- sponge_sample_specific(miRTarget, ExpData, senscorcutoff = 0.1, method = "sppc")
head(sponge_sample_specific_net[[1]])
```

```
##    from    to
## 1 TNKS2  PTEN
## 2  TCF4 TNKS2
```

# 4 Identifying sample-sample correlation network

In terms of sample-specific miRNA sponge interaction networks, ‘miRspongeR’ further identifies sample-sample correlation network. The three similarity methods (Simpson [22], Jaccard [23] and Lin [24]) are used. The significance p-values of similarity are calculated using a hypergeometric distribution test.

```
ExpDatacsv <- system.file("extdata","ExpData.csv",package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
sponge_sample_specific_net <- sponge_sample_specific(miRTarget, ExpData, senscorcutoff = 0.1, method = "sppc")
sample_cor_network_res <- sample_cor_network(sponge_sample_specific_net, genes_num = 31, padjustvaluecutoff = 0.05)
head(sample_cor_network_res)
```

```
##      sample_1 sample_2 similarity p.adjusted_value of similarity
## [1,] "1"      "19"     "1"        "0.0159065628476203"
## [2,] "1"      "53"     "1"        "0.0159065628476203"
## [3,] "1"      "56"     "1"        "0.0178948832035728"
## [4,] "1"      "67"     "1"        "0.0159065628476203"
## [5,] "1"      "144"    "1"        "0.0178948832035728"
## [6,] "9"      "52"     "1"        "0.0178948832035728"
```

# 5 Validation of miRNA sponge interactions

To validate the predicted miRNA sponge interactions, ‘miRspongeR’ implements
‘spongeValidate’ function. The built-in groundtruth of miRNA sponge interactions
are from miRSponge (<http://bio-bigdata.hrbmu.edu.cn/miRSponge/>), lncACTdb (<http://bio-bigdata.hrbmu.edu.cn/LncACTdb/>), LncCeRBase (<http://www.insect-genome.com/LncCeRBase/front/>).

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
Groundtruthcsv <- system.file("extdata", "Groundtruth.csv", package="miRspongeR")
Groundtruth <- read.csv(Groundtruthcsv, header=TRUE, sep=",")
spongenetwork_validated <- spongeValidate(miRHomologyceRInt[, 1:2], directed = FALSE, Groundtruth)
spongenetwork_validated
```

```
##   sponge_1 sponge_2
## 1     PTEN     KLF6
## 2    TNKS2     PTEN
## 3      RB1     PTEN
```

# 6 Module identification from miRNA sponge network

To further understand the module-level properties of miRNA sponges, ‘miRspongeR’ implements ‘netModule’ function to identify miRNA sponge modules. Users can choose FN [25], MCL [26], LINKCOMM [27], MCODE [28], betweenness [29], infomap [30], prop [31], eigen [32], louvain [33] and walktrap [34] for module identification.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
spongenetwork_Cluster <- netModule(miRHomologyceRInt[, 1:2], modulesize = 2)
spongenetwork_Cluster
```

```
## [[1]]
## [1] "SOX5" "RB1"
##
## [[2]]
## [1] "QKI"   "NFIA"  "TCF4"  "TNKS2" "PTEN"  "KLF6"
```

# 7 Disease and functional enrichment analysis of miRNA sponge modules

‘miRspongeR’ implements ‘moduleDEA’ function to conduct disease enrichment analysis of modules. The disease databases used include DO: Disease
Ontology database (<http://disease-ontology.org/>),
DGN: DisGeNET database (<http://www.disgenet.org/>)
and NCG: Network of Cancer Genes database
(<http://ncg.kcl.ac.uk/>). Moreover, ‘moduleFEA’ function
is implemented to conduct functional GO, KEGG and Reactome
enrichment analysis of modules. The ontology databases used
contain GO: Gene Ontology database
(<http://www.geneontology.org/>), KEGG:
Kyoto Encyclopedia of Genes and Genomes Pathway Database
(<http://www.genome.jp/kegg/>), and Reactome:
Reactome Pathway Database (<http://reactome.org/>).

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
spongenetwork_Cluster <- netModule(miRHomologyceRInt[, 1:2], modulesize = 2)
sponge_Module_DEA <- moduleDEA(spongenetwork_Cluster)
sponge_Module_FEA <- moduleFEA(spongenetwork_Cluster)
```

# 8 Survival analysis of miRNA sponge modules

To make survival analysis of miRNA sponge modules, ‘miRspongeR’ implements ‘moduleSurvival’ function.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
SurvDatacsv <- system.file("extdata", "SurvData.csv", package="miRspongeR")
SurvData <- read.csv(SurvDatacsv, header=TRUE, sep=",")
pcceRInt <- spongeMethod(miRTarget, ExpData, method = "pc")
spongenetwork_Cluster <- netModule(pcceRInt[, 1:2], modulesize = 2)
sponge_Module_Survival <- moduleSurvival(spongenetwork_Cluster,
    ExpData, SurvData, devidePercentage=.5)
sponge_Module_Survival
```

```
##          Chi-square   p-value       HR   HRlow95   HRup95
## Module 1  2.0610023 0.1511107 1.269461 0.9062752 1.778192
## Module 2  0.5682278 0.4509640 1.134920 0.8109446 1.588325
```

Parameter ‘devidePercentage’ is used to set the percentage of high risk group.

# 9 Conclusions

‘miRspongeR’ provides several functions to explore miRNA sponge (also called ceRNA or miRNA decoy) regulation from putative miRNA-target interactions or/and transcriptomics data (including bulk, single-cell and spatial gene expression data). It provides eight popular methods for identifying miRNA sponge interactions, and an integrative method to integrate miRNA sponge interactions from different methods, as well as the functions to validate miRNA sponge interactions, and infer miRNA sponge modules, conduct enrichment analysis of miRNA sponge modules, and conduct survival analysis of miRNA sponge modules. By using a sample control variable strategy, it provides a function to infer sample-specific miRNA sponge interactions. In terms of sample-specific miRNA sponge interactions, it implements three similarity methods to construct sample-sample correlation network. It could provide a useful tool for the research of miRNA sponges.

# 10 References

# Appendix

[1] Ambros V. microRNAs: tiny regulators with great potential. Cell, 2001, 107:823–6.

[2] Bartel DP. MicroRNAs: genomics, biogenesis, mechanism, and function. Cell, 2004, 116:281–97.

[3] Du T, Zamore PD. Beginning to understand microRNA function. Cell Research, 2007, 17:661–3.

[4] Esquela-Kerscher A, Slack FJ. Oncomirs—microRNAs with a role in cancer.
Nature Reviews Cancer, 2006, 6:259–69.

[5] Lin S, Gregory RI. MicroRNA biogenesis pathways in cancer.
Nature Reviews Cancer, 2015, 15:321–33.

[6] Salmena L, Poliseno L, Tay Y, et al. A ceRNA hypothesis: the Rosetta Stone
of a hidden RNA language? Cell, 2011, 146(3):353-8.

[7] Cesana M, Cacchiarelli D, Legnini I, et al. A long noncoding RNA
controls muscle differentiation by functioning as a competing endogenous
RNA. Cell, 2011, 147:358–69.

[8] Poliseno L, Salmena L, Zhang J, et al. A coding-independent function
of gene and pseudogene mRNAs regulates tumour biology. Nature, 2010,
465:1033–8.

[9] Hansen TB, Jensen TI, Clausen BH, et al. Natural RNA circles function
as efficient microRNA sponges. Nature, 2013, 495:384–8.

[10] Memczak S, Jens M, Elefsinioti A, et al. Circular RNAs are a large
class of animal RNAs with regulatory potency. Nature, 2013, 495:333–8.

[11] Le TD, Zhang J, Liu L, et al. Computational methods for identifying
miRNA sponge interactions. Brief Bioinform., 2017, 18(4):577-590.

[12] Tay Y, Rinn J, Pandolfi PP. The multilayered complexity of
ceRNA crosstalk and competition. Nature, 2014, 505:344–52.

[13] Li JH, Liu S, Zhou H, et al. starBase v2.0: decoding miRNA-ceRNA,
miRNA-ncRNA and protein-RNA interaction networks from large-scale
CLIP-Seq data. Nucleic Acids Res., 2014, 42(Database issue):D92-7.

[14] Sarver AL, Subramanian S. Competing endogenous RNA database.
Bioinformation, 2012, 8(15):731-3.

[15] Zhou X, Liu J, Wang W, Construction and investigation of
breast-cancer-specific ceRNA network based on the mRNA and miRNA
expression data. IET Syst Biol., 2014, 8(3):96-103.

[16] Xu J, Li Y, Lu J, et al. The mRNA related ceRNA-ceRNA landscape
and significance across 20 major cancer types. Nucleic Acids Res.,
2015, 43(17):8169-82.

[17] Paci P, Colombo T, Farina L, Computational analysis identifies a
sponge interaction network between long non-coding RNAs and messenger
RNAs in human breast cancer. BMC Syst Biol., 2014, 8:83.

[18] Sumazin P, Yang X, Chiu HS, et al. An extensive microRNA-mediated
network of RNA-RNA interactions regulates established oncogenic pathways
in glioblastoma. Cell, 2011, 147(2):370-81.

[19] Tay Y, Kats L, Salmena L, et al. Coding-independent regulation of
the tumor suppressor PTEN by competing endogenous mRNAs. Cell,
2011, 147(2):344-57.

[20] Sardina DS, Alaimo S, Ferro A, et al. A novel computational method
for inferring competing endogenous interactions. Brief Bioinform.,
2017, 18(6):1071-1081.

[21] List M, Dehghani Amirabad A, Kostka D, Schulz MH. Large-scale inference of competing endogenous RNA networks with sparse partial correlation. Bioinformatics. 2019;35(14):i596-i604.

[22] Tucker CM, Cadotte MW, Carvalho SB, et al. A guide to phylogenetic metrics for conservation, community ecology and macroecology. Biol Rev Camb Philos Soc. 2017;92(2):698-715.

[23] Jaccard P. The Distribution of the Flora in the Alpine Zone. The New Phytologist 11, no. 2 (1912): 37–50.

[24] Lin D, et al. An information-theoretic definition of similarity. In: Icml, vol.
98. 1998. p. 296–304.

[25] Clauset A, Newman ME, Moore C. Finding community structure in
very large networks. Phys Rev E Stat Nonlin Soft Matter Phys., 2004,
70(6 Pt 2):066111.

[26] Enright AJ, Van Dongen S, Ouzounis CA. An efficient algorithm for
large-scale detection of protein families. Nucleic Acids Res., 2002,
30(7):1575-84.

[27] Kalinka AT, Tomancak P. linkcomm: an R package for the generation,
visualization, and analysis of link communities in networks of
arbitrary size and type. Bioinformatics, 2011, 27(14):2011-2.

[28] Bader GD, Hogue CW. An automated method for finding molecular
complexes in large protein interaction networks. BMC Bioinformatics,
2003, 4:2.

[29] Newman ME, Girvan M. Finding and evaluating community structure in networks. Phys Rev E Stat Nonlin Soft Matter Phys. 2004;69(2 Pt 2):026113.

[30] Rosvall M, Bergstrom CT. Maps of random walks on complex networks reveal community structure. Proc Natl Acad Sci U S A. 2008;105(4):1118-1123.

[31] Raghavan UN, Albert R, Kumara S. Near linear time algorithm to detect community structures in large-scale networks. Phys Rev E Stat Nonlin Soft Matter Phys. 2007;76(3 Pt 2):036106.

[32] Newman ME. Finding community structure in networks using the eigenvectors of matrices. Phys Rev E Stat Nonlin Soft Matter Phys. 2006;74(3 Pt 2):036104.

[33] Blondel VD, Guillaume JL, Lambiotte R, Lefebvre E. Fast unfolding of communities in large networks. Journal of statistical mechanics: theory and experiment, 2008, 2008(10): P10008.

[34] Pons P, Latapy M. Computing communities in large networks using random walks. Graph Algorithms Appl. 2006.

# A Session information

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] miRspongeR_2.14.1 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] fs_1.6.6                matrixStats_1.5.0       enrichplot_1.30.4
##   [4] lubridate_1.9.4         httr_1.4.7              RColorBrewer_1.1-3
##   [7] doParallel_1.0.17       tools_4.5.2             doRNG_1.8.6.2
##  [10] backports_1.5.0         R6_2.6.1                lazyeval_0.2.2
##  [13] GetoptLong_1.1.0        withr_3.0.2             graphite_1.56.0
##  [16] prettyunits_1.2.0       gridExtra_2.3           cli_3.6.5
##  [19] Biobase_2.70.0          gRbase_2.0.3            logging_0.10-108
##  [22] scatterpie_0.2.6        sass_0.4.10             S7_0.2.1
##  [25] randomForest_4.7-1.2    ggridges_0.5.7          systemfonts_1.3.1
##  [28] yulab.utils_0.2.3       gson_0.1.0              DOSE_4.4.0
##  [31] R.utils_2.13.0          dichromat_2.0-0.1       parallelly_1.46.0
##  [34] RSQLite_2.4.5           generics_0.1.4          gridGraphics_0.5-1
##  [37] shape_1.4.6.1           car_3.1-3               dplyr_1.1.4
##  [40] tnet_3.0.16             GO.db_3.22.0            Matrix_1.7-4
##  [43] S4Vectors_0.48.0        MetBrewer_0.2.0         abind_1.4-8
##  [46] R.methodsS3_1.8.2       lifecycle_1.0.4         yaml_2.3.12
##  [49] carData_3.0-5           recipes_1.3.1           qvalue_2.42.0
##  [52] BiocFileCache_3.0.0     grid_4.5.2              blob_1.2.4
##  [55] ppcor_1.1               crayon_1.5.3            ggtangle_0.0.9
##  [58] lattice_0.22-7          cowplot_1.2.0           KEGGREST_1.50.0
##  [61] pillar_1.11.1           knitr_1.51              ComplexHeatmap_2.26.0
##  [64] fgsea_1.36.0            rjson_0.2.23            corpcor_1.6.10
##  [67] future.apply_1.20.1     codetools_0.2-20        fastmatch_1.1-6
##  [70] glue_1.8.0              ggiraph_0.9.2           ggfun_0.2.0
##  [73] fontLiberation_0.1.0    data.table_1.18.0       vctrs_0.6.5
##  [76] png_0.1-8               treeio_1.34.0           gtable_0.3.6
##  [79] cachem_1.1.0            gower_1.0.2             xfun_0.55
##  [82] prodlim_2025.04.28      tidygraph_1.3.1         tidyverse_2.0.0
##  [85] Seqinfo_1.0.0           survival_3.8-3          timeDate_4051.111
##  [88] iterators_1.0.14        hardhat_1.4.2           lava_1.8.2
##  [91] ipred_0.9-15            nlme_3.1-168            ggtree_4.0.3
##  [94] bit64_4.6.0-1           fontquiver_0.2.1        cvms_2.0.0
##  [97] progress_1.2.3          filelock_1.0.3          MCL_1.0
## [100] bslib_0.9.0             otel_0.2.0              rpart_4.1.24
## [103] colorspace_2.1-2        BiocGenerics_0.56.0     DBI_1.2.3
## [106] nnet_7.3-20             tidyselect_1.2.1        bit_4.6.0
## [109] compiler_4.5.2          curl_7.0.0              graph_1.88.1
## [112] glmnet_4.1-10           httr2_1.2.2             expm_1.0-0
## [115] fontBitstreamVera_0.1.1 bookdown_0.46           scales_1.4.0
## [118] rappdirs_0.3.3          stringr_1.6.0           digest_0.6.39
## [121] rmarkdown_2.30          XVector_0.50.0          htmltools_0.5.9
## [124] pkgconfig_2.0.3         dbplyr_2.5.1            fastmap_1.2.0
## [127] rlang_1.1.6             GlobalOptions_0.1.3     htmlwidgets_1.6.4
## [130] farver_2.1.2            jquerylib_0.1.4         jsonlite_2.0.0
## [133] BiocParallel_1.44.0     GOSemSim_2.36.0         ModelMetrics_1.2.2.2
## [136] R.oo_1.27.1             magrittr_2.0.4          Formula_1.2-5
## [139] ggplotify_0.1.3         patchwork_1.3.2         Rcpp_1.1.0
## [142] ape_5.8-1               ggnewscale_0.5.2        viridis_0.6.5
## [145] gdtools_0.4.4           stringi_1.8.7           pROC_1.19.0.1
## [148] ggraph_2.2.2            MASS_7.3-65             org.Hs.eg.db_3.22.0
## [151] plyr_1.8.9              parallel_4.5.2          listenv_0.10.0
## [154] ggrepel_0.9.6           Biostrings_2.78.0       graphlayouts_1.2.2
## [157] splines_4.5.2           hms_1.1.4               circlize_0.4.17
## [160] SPONGE_1.32.0           igraph_2.2.1            ggpubr_0.6.2
## [163] ggsignif_0.6.4          rngtools_1.5.2          reshape2_1.4.5
## [166] biomaRt_2.66.0          stats4_4.5.2            evaluate_1.0.5
## [169] BiocManager_1.30.27     foreach_1.5.2           tweenr_2.0.3
## [172] tidyr_1.3.2             purrr_1.2.0             polyclip_1.10-7
## [175] future_1.68.0           clue_0.3-66             ggplot2_4.0.1
## [178] ReactomePA_1.54.0       ggforce_0.5.0           broom_1.0.11
## [181] reactome.db_1.94.0      tidytree_0.4.6          tidydr_0.0.6
## [184] rstatix_0.7.3           viridisLite_0.4.2       class_7.3-23
## [187] tibble_3.3.0            clusterProfiler_4.18.4  aplot_0.2.9
## [190] memoise_2.0.1           AnnotationDbi_1.72.0    IRanges_2.44.0
## [193] cluster_2.1.8.1         timechange_0.3.0        globals_0.18.0
## [196] caret_7.0-1
```