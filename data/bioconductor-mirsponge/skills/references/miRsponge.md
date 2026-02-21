# miRsponge: identification and analysis of miRNA sponge interaction networks and modules

\
Junpeng Zhang ()\
School of Engineering, Dali University

#### 2019-03-14

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
  + [2.8 integrateMethod](#integratemethod)
* [3 Validation of miRNA sponge interactions](#validation-of-mirna-sponge-interactions)
* [4 Module identification from miRNA sponge interaction network](#module-identification-from-mirna-sponge-interaction-network)
* [5 Disease and functional enrichment analysis of miRNA sponge modules](#disease-and-functional-enrichment-analysis-of-mirna-sponge-modules)
* [6 Survival analysis of miRNA sponge modules](#survival-analysis-of-mirna-sponge-modules)
* [7 Conclusions](#conclusions)
* [8 References](#references)
* [9 Session information](#session-information)

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
studies [11, 12] have shown that miRNA sponge network and module
can help to reveal the biological mechanism in cancer.

To accelerate the research of miRNA sponge, we develop an R package
‘miRsponge’ to implement popular methods in the identification and
analysis of miRNA sponge network and module.

# 2 Identification of miRNA sponge interactions

In ‘spongeMethod’ function, We implement seven popular methods
(miRHomology [13, 14], pc [15, 16], sppc [17], ppc [11], hermes [18],
muTaME [19], and cernia [20]) to identify miRNA sponge interactions.
The seven methods should meet a basic condition: the significance of
sharing of miRNAs by each RNA-RNA pair (e.g. adjusted p-value < 0.01).
Each method has its own merit due to different evaluating indicators.
Thus, we present an integrate method to combine predicted miRNA
sponge interactions from different methods.

## 2.1 miRHomology

We implement miRHomology method based on the
homology of sharing miRNAs.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
head(miRHomologyceRInt)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "3.81103596547305e-06"
## [2,] "QKI"    "TCF4"   "20"           "0.00115766073913981"
## [3,] "QKI"    "TNKS2"  "28"           "0.0005791906542294"
## [4,] "QKI"    "PTEN"   "31"           "0.00131758648062585"
## [5,] "QKI"    "KLF6"   "25"           "3.68538343253899e-06"
## [6,] "SOX5"   "RB1"    "11"           "0.00276545737589284"
```

## 2.2 pc

The pc function considers expression data based on miRHomology method.
Significantly positive miRNA sponge interaction pairs are regarded as output.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRsponge")
ExpData <- read.csv(ExpDatacsv, header=FALSE, sep=",")
pcceRInt <- spongeMethod(miRTarget, ExpData, method = "pc")
head(pcceRInt)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "3.81103596547305e-06"
## [2,] "QKI"    "TCF4"   "20"           "0.00115766073913981"
## [3,] "QKI"    "TNKS2"  "28"           "0.0005791906542294"
## [4,] "QKI"    "PTEN"   "31"           "0.00131758648062585"
## [5,] "QKI"    "KLF6"   "25"           "3.68538343253899e-06"
## [6,] "SOX5"   "RB1"    "11"           "0.00276545737589284"
##      correlation         p.adjusted_value of positive correlation
## [1,] "0.491729673394525" "3.881815711871e-10"
## [2,] "0.732930517949784" "1.58924806399582e-25"
## [3,] "0.397085235409979" "8.32323088938377e-07"
## [4,] "0.554784433631471" "5.38820648798236e-13"
## [5,] "0.605337991455224" "9.22959741202624e-16"
## [6,] "0.239965818711153" "0.00376816066458747"
```

## 2.3 sppc

We implement sppc method based on sensitivity
correlation (difference between the Pearson and partial
correlation coefficients).

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRsponge")
ExpData <- read.csv(ExpDatacsv, header=FALSE, sep=",")
sppcceRInt <- spongeMethod(miRTarget, ExpData, senscorcutoff = 0.1, method = "sppc")
head(sppcceRInt)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "3.81103596547305e-06"
## [2,] "QKI"    "TCF4"   "20"           "0.00115766073913981"
## [3,] "QKI"    "TNKS2"  "28"           "0.0005791906542294"
## [4,] "QKI"    "PTEN"   "31"           "0.00131758648062585"
## [5,] "QKI"    "KLF6"   "25"           "3.68538343253899e-06"
## [6,] "SOX5"   "RB1"    "11"           "0.00276545737589284"
##      correlation         p.adjusted_value of positive correlation
## [1,] "0.491729673394525" "3.881815711871e-10"
## [2,] "0.732930517949784" "1.58924806399582e-25"
## [3,] "0.397085235409979" "8.32323088938377e-07"
## [4,] "0.554784433631471" "5.38820648798236e-13"
## [5,] "0.605337991455224" "9.22959741202624e-16"
## [6,] "0.239965818711153" "0.00376816066458747"
##      sensitivity partial pearson correlation
## [1,] "0.307037199068782"
## [2,] "0.316438618435417"
## [3,] "0.138436130309623"
## [4,] "0.346274495026087"
## [5,] "0.354300353701363"
## [6,] "0.188537090552444"
```

## 2.4 hermes

The hermes method predicts competing endogenous RNAs
via evidence for competition for miRNA regulation based on conditional
mutual information.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRsponge")
ExpData <- read.csv(ExpDatacsv, header=FALSE, sep=",")
hermesceRInt <- spongeMethod(miRTarget, ExpData, num_perm = 10, method = "hermes")
head(hermesceRInt)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "TNKS2"  "28"           "0.0005791906542294"
## [2,] "RB1"    "PTEN"   "21"           "0.00314659062451339"
## [3,] "NFIA"   "PTEN"   "29"           "8.60807476494863e-05"
## [4,] "NFIA"   "KLF6"   "23"           "1.26902693353692e-06"
## [5,] "TCF4"   "PTEN"   "23"           "9.79529891076414e-06"
## [6,] "TNKS2"  "PTEN"   "27"           "0.00189765714427792"
##      p.adjusted_value of RNA competition
## [1,] "0.00204399749756164"
## [2,] "0.000136220891883833"
## [3,] "1.41043899195259e-05"
## [4,] "0.0022966191579945"
## [5,] "0.00123168613030408"
## [6,] "9.52026317591749e-06"
```

Parameter ‘num\_perm’ is used to set the number of permutations of
input expression data. The larger the number is, the slower the calculation is.

## 2.5 ppc

The ppc method is a variant of the hermes method.
However, it predicts competing endogenous RNAs via evidence for competition
for miRNA regulation based on Partial Pearson Correlation.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRsponge")
ExpData <- read.csv(ExpDatacsv, header=FALSE, sep=",")
ppcceRInt <- spongeMethod(miRTarget, ExpData, num_perm = 10, method = "ppc")
head(ppcceRInt)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "3.81103596547305e-06"
## [2,] "QKI"    "TCF4"   "20"           "0.00115766073913981"
## [3,] "QKI"    "TNKS2"  "28"           "0.0005791906542294"
## [4,] "QKI"    "PTEN"   "31"           "0.00131758648062585"
## [5,] "QKI"    "KLF6"   "25"           "3.68538343253899e-06"
## [6,] "SOX5"   "RB1"    "11"           "0.00276545737589284"
##      p.adjusted_value of RNA competition
## [1,] "1.91096294576635e-11"
## [2,] "1.10699275781112e-07"
## [3,] "2.32268229931332e-09"
## [4,] "4.98109104715102e-11"
## [5,] "3.39391083087626e-10"
## [6,] "0.000406939930071935"
```

Parameter ‘num\_perm’ is used to set the number of permutations of input
expression data. The larger the number is, the slower the calculation is.

## 2.6 muTaME

We implement the muTaME method based on the logarithm
of four scores: (1) the fraction of common miRNAs, (2) the density of the
MREs for all shared miRNAs, (3) the distribution of MREs of the putative
RNA-RNA pairs and (4) the relation between the overall number of MREs for
a putative miRNA sponge compared with the number of miRNAs that yield these
MREs. There is no reason to decide which score has more contribution than
the rest. Thus, we calculate a combined score by adding these four scores.
To evaluate the strength of each RNA-RNA pair, we further normalize the combined
scores to obtain normalized scores with interval [0 1].

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
MREs <- system.file("extdata", "MREs.csv", package="miRsponge")
mres <- read.csv(MREs, header=TRUE, sep=",")
muTaMEceRInt <- spongeMethod(miRTarget, mres = mres, method = "muTaME")
head(muTaMEceRInt)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "3.81103596547305e-06"
## [2,] "QKI"    "TCF4"   "20"           "0.00115766073913981"
## [3,] "QKI"    "TNKS2"  "28"           "0.0005791906542294"
## [4,] "QKI"    "PTEN"   "31"           "0.00131758648062585"
## [5,] "QKI"    "KLF6"   "25"           "3.68538343253899e-06"
## [6,] "NFIA"   "PTEN"   "29"           "8.60807476494863e-05"
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

We implement the cernia method based on the
logarithm of seven scores: (1) the fraction of common miRNAs, (2)
the density of the MREs for all shared miRNAs, (3) the distribution
of MREs of the putative RNA-RNA pairs, (4) the relation between the
overall number of MREs for a putative miRNA sponge compared with the
number of miRNAs that yield these MREs, (5) the density of the
hybridization energies related to MREs for all shared miRNAs, (6)
the DT-Hybrid recommendation scores and (7) the pairwise Peason
correlation between putative RNA-RNA pair expression data. There
is no reason to decide which score has more contribution than the
rest. Thus, we calculate a combined score by adding these seven scores.
To evaluate the strength of each RNA-RNA pair, we further normalize
the combined scores to obtain normalized scores with interval [0 1].

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
MREs <- system.file("extdata", "MREs.csv", package="miRsponge")
mres <- read.csv(MREs, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRsponge")
ExpData <- read.csv(ExpDatacsv, header=FALSE, sep=",")
cerniaceRInt <- spongeMethod(miRTarget, ExpData, mres, method = "cernia")
head(cerniaceRInt)
```

```
##      sponge_1 sponge_2 #shared miRNAs p.adjusted_value of shared miRNAs
## [1,] "QKI"    "NFIA"   "31"           "3.81103596547305e-06"
## [2,] "QKI"    "TCF4"   "20"           "0.00115766073913981"
## [3,] "QKI"    "TNKS2"  "28"           "0.0005791906542294"
## [4,] "QKI"    "PTEN"   "31"           "0.00131758648062585"
## [5,] "QKI"    "KLF6"   "25"           "3.68538343253899e-06"
## [6,] "SOX5"   "RB1"    "11"           "0.00276545737589284"
##      Score 1              Score 2             Score 3
## [1,] "-0.437213806422745" "-165.610621988223" "257.7778713546"
## [2,] "-0.470003629245736" "-100.765642874738" "155.515558123873"
## [3,] "-0.559615787935423" "-152.637669361688" "228.018475194044"
## [4,] "-0.626455806061273" "-172.33389579933"  "256.339724121501"
## [5,] "-0.336472236621213" "-134.332311526516" "203.667092432857"
## [6,] "-0.693147180559945" "-48.1031359789178" "59.3153148480852"
##      Score 4               Score 5             Score 6
## [1,] "-0.0201046632956751" "-92.2247034012848" "0.106465490518013"
## [2,] "-0.0188882845202057" "-56.2215260182082" "0.093724938445459"
## [3,] "-0.0226424767497598" "-84.6432209105312" "0.105901597149822"
## [4,] "-0.0192015809668538" "-92.9082256214383" "0.111354127972192"
## [5,] "-0.0209431738452431" "-73.2294093715465" "0.0969028171707324"
## [6,] "-0.0224308469881821" "-20.3501801808809" "0.075154823978529"
##      Score 7              Combined score      Normalized score
## [1,] "-0.709826157809743" "-1.11813317191805" "0.756556965720048"
## [2,] "-0.310704372925734" "-2.17748211731878" "0.737120534653221"
## [3,] "-0.923604322573739" "-10.6623760682843" "0.581443732308459"
## [4,] "-0.589175648556801" "-10.0258762068793" "0.593121929312341"
## [5,] "-0.501968313383334" "-4.65710937188486" "0.691625512060294"
## [6,] "-1.42725878781999"  "-11.205683303103"  "0.57147538933374"
```

## 2.8 integrateMethod

To obtain a list of high-confidence miRNA sponge interactions, we
implement ‘integrateMethod’ function to integrate results of different methods.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRsponge")
ExpData <- read.csv(ExpDatacsv, header=FALSE, sep=",")
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
intersected for integration. That is to say, we only reserve those
miRNA sponge interactions predicted by at least ‘Intersect\_num’ methods.

# 3 Validation of miRNA sponge interactions

To validate the predicted miRNA sponge interactions, we implement
‘spongeValidate’ function. The groundtruth of miRNA sponge interactions
are from miRSponge (<http://www.bio-bigdata.net/miRSponge/>) and the experimentally validated miRNA sponge interactions of related literatures.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
Groundtruthcsv <- system.file("extdata", "Groundtruth.csv", package="miRsponge")
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

# 4 Module identification from miRNA sponge interaction network

To further understand the module-level properties of miRNA sponges in
cancer, we implement ‘netModule’ function to identify miRNA sponge modules.
Users can choose FN [21], MCL [22], LINKCOMM [23] and MCODE [24] for module identification.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
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

# 5 Disease and functional enrichment analysis of miRNA sponge modules

We implement ‘moduleDEA’ function to make disease enrichment analysis of
modules. The disease databases used include DO: Disease
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
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
spongenetwork_Cluster <- netModule(miRHomologyceRInt[, 1:2], modulesize = 2)
sponge_Module_DEA <- moduleDEA(spongenetwork_Cluster)
sponge_Module_FEA <- moduleFEA(spongenetwork_Cluster)
```

# 6 Survival analysis of miRNA sponge modules

To make survival analysis of miRNA sponge modules, we implement
‘moduleSurvival’ function.

```
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRsponge")
ExpData <- read.csv(ExpDatacsv, header=FALSE, sep=",")
SurvDatacsv <- system.file("extdata", "SurvData.csv", package="miRsponge")
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

# 7 Conclusions

miRsponge provides several functions to study miRNA sponge (also called ceRNA or miRNA decoy), including popular methods for identifying miRNA sponge interactions, and the integrative method to integrate miRNA sponge interactions from different methods, as well as the functions to validate miRNA sponge interactions, and infer miRNA sponge modules, conduct enrichment analysis of modules, and conduct survival analysis of modules. It could provide a useful tool for the research of miRNA sponges.

# 8 References

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

[21] Clauset A, Newman ME, Moore C. Finding community structure in
very large networks. Phys Rev E Stat Nonlin Soft Matter Phys., 2004,
70(6 Pt 2):066111.

[22] Enright AJ, Van Dongen S, Ouzounis CA. An efficient algorithm for
large-scale detection of protein families. Nucleic Acids Res., 2002,
30(7):1575-84.

[23] Kalinka AT, Tomancak P. linkcomm: an R package for the generation,
visualization, and analysis of link communities in networks of
arbitrary size and type. Bioinformatics, 2011, 27(14):2011-2.

[24] Bader GD, Hogue CW. An automated method for finding molecular
complexes in large protein interaction networks. BMC Bioinformatics,
2003, 4:2.

# 9 Session information

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
## [1] miRsponge_1.8.2  BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##   [1] enrichplot_1.2.0       bit64_0.9-7            RColorBrewer_1.1-2
##   [4] progress_1.2.0         httr_1.4.0             MCL_1.0
##   [7] UpSetR_1.3.3           dynamicTreeCut_1.63-1  backports_1.1.3
##  [10] tools_3.5.2            R6_2.4.0               DBI_1.0.0
##  [13] lazyeval_0.2.1         BiocGenerics_0.28.0    colorspace_1.4-0
##  [16] graphite_1.28.2        tidyselect_0.2.5       gridExtra_2.3
##  [19] prettyunits_1.0.2      bit_1.1-14             compiler_3.5.2
##  [22] graph_1.60.0           Biobase_2.42.0         expm_0.999-3
##  [25] xml2_1.2.0             bookdown_0.9           triebeard_0.3.0
##  [28] checkmate_1.9.1        scales_1.0.0           linkcomm_1.0-11
##  [31] ggridges_0.5.1         rappdirs_0.3.1         stringr_1.4.0
##  [34] digest_0.6.18          rmarkdown_1.12         DOSE_3.8.2
##  [37] pkgconfig_2.0.2        htmltools_0.3.6        rlang_0.3.1
##  [40] RSQLite_2.1.1          gridGraphics_0.3-0     farver_1.1.0
##  [43] jsonlite_1.6           BiocParallel_1.16.6    GOSemSim_2.8.0
##  [46] dplyr_0.8.0.1          magrittr_1.5           ggplotify_0.0.3
##  [49] GO.db_3.7.0            Matrix_1.2-16          Rcpp_1.0.0
##  [52] munsell_0.5.0          S4Vectors_0.20.1       viridis_0.5.1
##  [55] stringi_1.4.3          yaml_2.2.0             ggraph_1.0.2
##  [58] MASS_7.3-51.1          plyr_1.8.4             qvalue_2.14.1
##  [61] grid_3.5.2             blob_1.1.1             parallel_3.5.2
##  [64] ggrepel_0.8.0          DO.db_2.9              crayon_1.3.4
##  [67] lattice_0.20-38        cowplot_0.9.4          splines_3.5.2
##  [70] hms_0.4.2              knitr_1.22             pillar_1.3.1
##  [73] varhandle_2.0.3        fgsea_1.8.0            igraph_1.2.4
##  [76] corpcor_1.6.9          reshape2_1.4.3         stats4_3.5.2
##  [79] fastmatch_1.1-0        glue_1.3.1             evaluate_0.13
##  [82] data.table_1.12.0      BiocManager_1.30.4     tweenr_1.0.1
##  [85] urltools_1.7.2         gtable_0.2.0           purrr_0.3.1
##  [88] polyclip_1.10-0        tidyr_0.8.3            assertthat_0.2.0
##  [91] ggplot2_3.1.0          ReactomePA_1.26.0      xfun_0.5
##  [94] ggforce_0.2.1          europepmc_0.3          reactome.db_1.66.0
##  [97] survival_2.43-3        viridisLite_0.3.0      tibble_2.0.1
## [100] clusterProfiler_3.10.1 rvcheck_0.1.3          AnnotationDbi_1.44.0
## [103] memoise_1.1.0          IRanges_2.16.0
```