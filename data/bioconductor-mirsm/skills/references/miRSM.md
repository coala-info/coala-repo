# miRSM: inferring miRNA sponge modules in heterogeneous data

\
Junpeng Zhang (zjp@dali.edu.cn)\
School of Engineering, Dali University

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Identification of gene modules](#identification-of-gene-modules)
  + [2.1 Load BRCA sample data](#load-brca-sample-data)
  + [2.2 module\_WGCNA](#module_wgcna)
  + [2.3 module\_GFA](#module_gfa)
  + [2.4 module\_igraph](#module_igraph)
  + [2.5 module\_ProNet](#module_pronet)
  + [2.6 module\_NMF](#module_nmf)
  + [2.7 module\_clust](#module_clust)
  + [2.8 module\_biclust](#module_biclust)
* [3 Discovery of miRNA sponge modules](#discovery-of-mirna-sponge-modules)
* [4 Inference of sample-specific miRNA sponge modules](#inference-of-sample-specific-mirna-sponge-modules)
* [5 Modular analysis of miRNA sponge modules](#modular-analysis-of-mirna-sponge-modules)
  + [5.1 Functional analysis of miRNA sponge modules](#functional-analysis-of-mirna-sponge-modules)
  + [5.2 Cancer enrichment analysis of miRNA sponge modules](#cancer-enrichment-analysis-of-mirna-sponge-modules)
  + [5.3 Validation of miRNA sponge interactions in miRNA sponge modules](#validation-of-mirna-sponge-interactions-in-mirna-sponge-modules)
  + [5.4 Co-expression analysis of miRNA sponge modules](#co-expression-analysis-of-mirna-sponge-modules)
  + [5.5 Distribution analysis of sharing miRNAs](#distribution-analysis-of-sharing-mirnas)
  + [5.6 Predicting miRNA-target interactions](#predicting-mirna-target-interactions)
  + [5.7 Identifying miRNA sponge interactions](#identifying-mirna-sponge-interactions)
* [6 Conclusions](#conclusions)
* [7 References](#references)
* **Appendix**
* [A Session information](#session-information)

# 1 Introduction

MicroRNAs (miRNAs) play key roles in many biological processes including cancers [1-5]. Thus, uncovering miRNA functions and regulatory mechanisms is important for gene diagnosis and therapy.

Previous studies [6-9] have shown that a pool of coding and non-coding RNAs that shares common miRNA biding sites competes with each other, thus alter miRNA activity. The corresponding regulatory mechanism is named competing endogenous RNA (ceRNA) hypothesis [10]. These RNAs are called ceRNAs or miRNA sponges or miRNA decoys, and include long non-coding RNAs (lncRNAs), pseudogenes, circular RNAs (circRNAs) and messenger RNAs (mRNAs), etc. To study the module-level properties of miRNA sponges, it is necessary to identify miRNA sponge modules. The miRNA sponge modules will help to reveal the biological mechanism in cancer.

To speed up the research of miRNA sponge modules, we develop an R/Bioconductor package `miRSM` to infer miRNA sponge modules. Unlike the existing R/Bioconductor packages (*[miRspongeR](https://bioconductor.org/packages/3.22/miRspongeR)* and *[SPONGE](https://bioconductor.org/packages/3.22/SPONGE)*), `miRSM` focuses on identifying miRNA sponge modules by integrating expression data and miRNA-target binding information instead of miRNA sponge interaction networks. In addition to identifying miRNA sponge modules in the form of external competition (e.g. a group of lncRNAs compete with a group of mRNAs), `miRSM` can also infer miRNA sponge modules in the form of internal competition (e.g. a group of mRNAs compete with another group of mRNAs). Moreover, `miRSM` can infer miRNA sponge modules at both single-sample and multi-sample levels.

# 2 Identification of gene modules

Given matched ceRNA and mRNA expression data or single gene expression data, `miRSM` infers gene modules by using several methods from 21 packages, including `WGCNA`, `GFA`, `igraph`, `ProNet`, `NMF`, `stats`, `flashClust`, `dbscan`, `subspace`, `mclust`, `SOMbrero`, `ppclust`, `biclust`, `runibic`, `iBBiG`, `fabia`, `BicARE`, `isa2`, `s4vd`, `BiBitR` and `rqubic`. We assemble these methods into 7 functions: *module\_WGCNA*, *module\_GFA*, *module\_igraph*, *module\_ProNet*, *module\_NMF*, *module\_clust* and *module\_biclust*.

## 2.1 Load BRCA sample data

The BRCA sample data includes matched miRNA, lncRNA, mRNA expression data, putative miRNA-target binding information and BRCA-related genes (lncRNAs and mRNAs).

```
data(BRCASampleData)
```

## 2.2 module\_WGCNA

By using WGCNA method [11], `miRSM` identifies co-expressed gene modules from matched ceRNA and mRNA expression data or single gene expression data.

```
modulegenes_WGCNA <- module_WGCNA(ceRExp[, seq_len(80)],
                                  mRExp[, seq_len(80)])
```

```
##    Power SFT.R.sq  slope truncated.R.sq mean.k. median.k. max.k.
## 1      1   0.0755  0.331       -0.10700  54.100  65.50000  83.70
## 2      2   0.0476 -0.260        0.09470  28.000  33.30000  56.60
## 3      3   0.1720 -0.315        0.40700  17.100  18.20000  41.80
## 4      4   0.2940 -0.400        0.26500  11.400  10.30000  32.80
## 5      5   0.5200 -0.518        0.41100   7.970   5.99000  26.50
## 6      6   0.7650 -0.599        0.72800   5.770   3.55000  21.90
## 7      7   0.8470 -0.644        0.87100   4.290   2.14000  18.30
## 8      8   0.7110 -0.740        0.70500   3.260   1.31000  15.40
## 9      9   0.1560 -1.720        0.07550   2.520   0.81700  13.10
## 10    10   0.1690 -1.850        0.08770   1.980   0.52000  11.30
## 11    12   0.8620 -0.954        0.89900   1.260   0.22000   8.43
## 12    14   0.8510 -1.030        0.85100   0.844   0.09870   6.44
## 13    16   0.1800 -1.910        0.00065   0.584   0.04630   4.99
## 14    18   0.1850 -1.870        0.01020   0.417   0.02160   3.91
## 15    20   0.9260 -1.030        0.96000   0.305   0.00998   3.11
## ..connectivity..
## ..matrix multiplication (system BLAS)..
## ..normalization..
## ..done.
```

```
modulegenes_WGCNA
```

```
## GeneSetCollection
##   names: Module 1 (1 total)
##   unique identifiers: A2M-AS1, EMX2OS, ..., GRASP (36 total)
##   types in collection:
##     geneIdType: NullIdentifier (1 total)
##     collectionType: NullCollection (1 total)
```

## 2.3 module\_GFA

The gene modules are identified by using GFA method [12, 13] from matched ceRNA and mRNA expression data or single gene expression data.

```
modulegenes_GFA <- module_GFA(ceRExp[seq_len(20), seq_len(15)],
                              mRExp[seq_len(20), seq_len(15)],
                              iter.max = 3000)
```

```
## [1] "Running GFA with 2 data sources paired in one mode."
## [1] "Initializing GFA with 10 components."
## [1] "Learning: 100/3000 - K=10 - 2025-10-30 01:08:24.710064"
## [1] "Learning: 200/3000 - K=8 - 2025-10-30 01:08:24.820896"
## [1] "Learning: 300/3000 - K=4 - 2025-10-30 01:08:24.911925"
## [1] "Learning: 400/3000 - K=2 - 2025-10-30 01:08:24.979087"
## [1] "Learning: 500/3000 - K=2 - 2025-10-30 01:08:25.030464"
## [1] "Learning: 600/3000 - K=2 - 2025-10-30 01:08:25.081873"
## [1] "Learning: 700/3000 - K=1 - 2025-10-30 01:08:25.126792"
## [1] "Learning: 800/3000 - K=1 - 2025-10-30 01:08:25.166285"
## [1] "Learning: 900/3000 - K=1 - 2025-10-30 01:08:25.205942"
## [1] "Learning: 1000/3000 - K=1 - 2025-10-30 01:08:25.244948"
## [1] "Learning: 1100/3000 - K=1 - 2025-10-30 01:08:25.284977"
## [1] "Learning: 1200/3000 - K=1 - 2025-10-30 01:08:25.327874"
## [1] "Learning: 1300/3000 - K=1 - 2025-10-30 01:08:25.373193"
## [1] "Learning: 1400/3000 - K=1 - 2025-10-30 01:08:25.418619"
## [1] "Learning: 1500/3000 - K=1 - 2025-10-30 01:08:25.504435"
## [1] "Learning: 1600/3000 - K=1 - 2025-10-30 01:08:25.541111"
## [1] "Learning: 1700/3000 - K=1 - 2025-10-30 01:08:25.577764"
## [1] "Learning: 1800/3000 - K=1 - 2025-10-30 01:08:25.615582"
## [1] "Learning: 1900/3000 - K=1 - 2025-10-30 01:08:25.651887"
## [1] "Learning: 2000/3000 - K=1 - 2025-10-30 01:08:25.688599"
## [1] "Learning: 2100/3000 - K=1 - 2025-10-30 01:08:25.725483"
## [1] "Learning: 2200/3000 - K=1 - 2025-10-30 01:08:25.762107"
## [1] "Learning: 2300/3000 - K=1 - 2025-10-30 01:08:25.798792"
## [1] "Learning: 2400/3000 - K=1 - 2025-10-30 01:08:25.835233"
## [1] "Learning: 2500/3000 - K=1 - 2025-10-30 01:08:25.872509"
## [1] "Learning: 2600/3000 - K=1 - 2025-10-30 01:08:25.908577"
## [1] "Learning: 2700/3000 - K=1 - 2025-10-30 01:08:25.943539"
## [1] "Learning: 2800/3000 - K=1 - 2025-10-30 01:08:25.979212"
## [1] "Learning: 2900/3000 - K=1 - 2025-10-30 01:08:26.013714"
## [1] "Learning: 3000/3000 - K=1 - 2025-10-30 01:08:26.048195"
## [1] "Starting convergence check"
## [1] "Convergence diagnostic: 0.0483"
## [1] "Values significantly greater than 0.05 imply a non-converged model."
```

```
modulegenes_GFA
```

```
## GeneSetCollection
##   names:  (0 total)
##   unique identifiers:  (0 total)
##   types in collection:
##     geneIdType:  (0 total)
##     collectionType:  (0 total)
```

## 2.4 module\_igraph

By using `igraph` package [14], `miRSM` infers gene modules from matched ceRNA and mRNA expression data or single gene expression data. In the `igraph` package, users can select “betweenness”, “greedy”, “infomap”, “prop”, “eigen”, “louvain” and “walktrap” methods for gene module identification. The default method is “greedy”.

```
modulegenes_igraph <- module_igraph(ceRExp[, seq_len(10)],
                                    mRExp[, seq_len(10)])
modulegenes_igraph
```

```
## GeneSetCollection
##   names: Module 1, Module 2 (2 total)
##   unique identifiers: A2M-AS1, ABCA11P, ..., E2F8 (19 total)
##   types in collection:
##     geneIdType: NullIdentifier (1 total)
##     collectionType: NullCollection (1 total)
```

## 2.5 module\_ProNet

In the `ProNet` package, users can select FN [15], MCL [16], LINKCOMM [17] and MCODE [18] for gene module identification from matched ceRNA and mRNA expression data or single gene expression data. The default method is MCL.

```
modulegenes_ProNet <- module_ProNet(ceRExp[, seq_len(10)],
                                    mRExp[, seq_len(10)])
modulegenes_ProNet
```

```
## GeneSetCollection
##   names: Module 1, Module 2 (2 total)
##   unique identifiers: A2M-AS1, ACVR2B-AS1, ..., E2F7 (12 total)
##   types in collection:
##     geneIdType: NullIdentifier (1 total)
##     collectionType: NullCollection (1 total)
```

## 2.6 module\_NMF

By using `NMF` package [20], users infer gene modules from matched ceRNA and mRNA expression data or single gene expression data. In the `NMF` package, we can select “brunet”, “Frobenius”, “KL”, “lee”, “nsNMF”, “offset”, “siNMF”, “snmf/l” and “snmf/r” methods for gene module identification. The default method is “brunet”.

```
# Reimport NMF package to avoid conflicts with DelayedArray package
library(NMF)
modulegenes_NMF <- module_NMF(ceRExp[, seq_len(10)],
                              mRExp[, seq_len(10)])
modulegenes_NMF
```

```
## GeneSetCollection
##   names:  (0 total)
##   unique identifiers:  (0 total)
##   types in collection:
##     geneIdType:  (0 total)
##     collectionType:  (0 total)
```

## 2.7 module\_clust

`miRSM` Identifies gene modules from matched ceRNA and mRNA expression data or single gene expression data using a series of clustering packages, including `stats` [21], `flashClust` [22], `dbscan` [23], `subspace` [24], `mclust` [25], `SOMbrero` [26] and `ppclust` [27]. The clustering methods include “kmeans”, “hclust”, “dbscan”, “clique”, “gmm”, “som” and “fcm”. The default method is “kmeans”.

```
modulegenes_clust <- module_clust(ceRExp[, seq_len(30)],
                                  mRExp[, seq_len(30)])
modulegenes_clust
```

```
## GeneSetCollection
##   names: Module 1, Module 2, Module 3 (3 total)
##   unique identifiers: ADAM21P1, ADORA2A-AS1, ..., FIGN (31 total)
##   types in collection:
##     geneIdType: NullIdentifier (1 total)
##     collectionType: NullCollection (1 total)
```

## 2.8 module\_biclust

`miRSM` Identifies gene modules from matched ceRNA and mRNA expression data or single gene expression data using a series of biclustering packages, including `biclust` [28], `iBBiG` [29], `fabia` [30], `BicARE` [31], `isa2` [32], `s4vd` [33], `BiBitR` [34] and `rqubic` [35]. The biclustering methods include “BCBimax”, “BCCC”, “BCPlaid”, “BCQuest”, “BCSpectral”, “BCXmotifs”, “iBBiG”, “fabia”, “fabiap”, “fabias”, “mfsc”, “nmfdiv”, “nmfeu”, “nmfsc”, “FLOC”, “isa”, “BCs4vd”, “BCssvd”, “bibit” and “quBicluster”. The default method is “fabia”.

```
modulegenes_biclust <- module_biclust(ceRExp[, seq_len(30)],
                                      mRExp[, seq_len(30)])
```

```
## Cycle: 0
Cycle: 20
Cycle: 40
Cycle: 60
Cycle: 80
Cycle: 100
Cycle: 120
Cycle: 140
Cycle: 160
Cycle: 180
Cycle: 200
Cycle: 220
Cycle: 240
Cycle: 260
Cycle: 280
Cycle: 300
Cycle: 320
Cycle: 340
Cycle: 360
Cycle: 380
Cycle: 400
Cycle: 420
Cycle: 440
Cycle: 460
Cycle: 480
Cycle: 500
```

```
modulegenes_biclust
```

```
## GeneSetCollection
##   names: Module 1 (1 total)
##   unique identifiers: COL10A1, FIGF, ..., ACVR2B-AS1 (12 total)
##   types in collection:
##     geneIdType: NullIdentifier (1 total)
##     collectionType: NullCollection (1 total)
```

# 3 Discovery of miRNA sponge modules

The identified gene modules are regarded as candidate miRNA sponge modules. Based on the candidate miRNA sponge modules, `miRSM` uses the sensitivity canonical correlation (SCC), sensitivity distance correlation (SDC), sensitivity RV coefficient (SRVC), sensitivity similarity index (SSI), sensitivity generalized coefficient of determination (SGCD) and sensitivity Coxhead’s or Rozeboom’s coefficient (SCRC) methods to identify miRNA sponge modules. In addition, the sponge module (SM) method proposed in [36] is also added to predict miRNA sponge modules.

```
modulegenes_igraph <- module_igraph(ceRExp[, seq_len(10)],
                                  mRExp[, seq_len(10)])
# Identify miRNA sponge modules using sensitivity RV coefficient (SRVC)
miRSM_igraph_SRVC <- miRSM(miRExp, ceRExp, mRExp, miRTarget,
                        modulegenes_igraph,
                        num_shared_miRNAs = 3, pvalue.cutoff = 0.05,
                        method = "SRVC", MC.cutoff = 0.8,
                        SMC.cutoff = 0.01, RV_method = "RV")
miRSM_igraph_SRVC
```

```
## [1] "No miRNA sponge modules identified!"
```

# 4 Inference of sample-specific miRNA sponge modules

`miRSM` uses statistical perturbation strategy to infer sample-specific miRNA sponge modules. By using the statistical perturbation strategy, `miRSM` identifies differential miRNA sponge modules between two cases (all samples and all samples except sample k).

```
nsamples <- 3
modulegenes_all <- module_igraph(ceRExp[, 151:300], mRExp[, 151:300])
modulegenes_exceptk <- lapply(seq(nsamples), function(i)
                              module_WGCNA(ceRExp[-i, seq(150)],
                              mRExp[-i, seq(150)]))
```

```
##    Power SFT.R.sq  slope truncated.R.sq mean.k. median.k. max.k.
## 1      1   0.0965  0.328         0.1180  98.900  119.0000 155.00
## 2      2   0.0678 -0.225         0.3120  50.900   60.7000 105.00
## 3      3   0.2200 -0.355         0.2670  31.000   33.3000  78.10
## 4      4   0.3780 -0.461         0.2450  20.500   19.0000  60.70
## 5      5   0.5620 -0.557         0.4370  14.200   11.1000  48.30
## 6      6   0.7680 -0.620         0.7580  10.200    6.6600  39.10
## 7      7   0.8290 -0.635         0.8600   7.550    4.1500  32.00
## 8      8   0.7280 -0.746         0.7440   5.710    2.5800  26.50
## 9      9   0.1570 -1.810         0.0595   4.390    1.6100  22.10
## 10    10   0.1630 -1.800         0.0635   3.440    1.0200  18.60
## 11    12   0.7620 -0.929         0.7250   2.210    0.4260  13.70
## 12    14   0.9630 -0.894         0.9590   1.500    0.1980  10.40
## 13    16   0.9500 -0.911         0.9400   1.060    0.0905   8.04
## 14    18   0.9540 -0.886         0.9590   0.778    0.0420   6.32
## 15    20   0.9290 -0.924         0.9260   0.590    0.0205   5.43
## ..connectivity..
## ..matrix multiplication (system BLAS)..
## ..normalization..
## ..done.
##    Power SFT.R.sq  slope truncated.R.sq mean.k. median.k. max.k.
## 1      1   0.0915  0.319         0.0654  98.600  118.0000 154.00
## 2      2   0.0803 -0.240         0.2250  50.600   60.3000 104.00
## 3      3   0.2310 -0.355         0.2720  30.700   33.0000  77.80
## 4      4   0.3820 -0.468         0.2380  20.300   19.0000  60.40
## 5      5   0.5450 -0.570         0.4170  14.100   11.0000  48.10
## 6      6   0.7630 -0.617         0.7560  10.100    6.5200  38.90
## 7      7   0.8230 -0.661         0.8530   7.450    3.9300  31.90
## 8      8   0.7330 -0.752         0.7510   5.620    2.4300  26.40
## 9      9   0.1580 -1.790         0.0651   4.330    1.5400  22.00
## 10    10   0.1660 -1.860         0.0649   3.390    0.9870  18.60
## 11    12   0.1750 -1.890         0.0725   2.180    0.4010  13.60
## 12    14   0.9710 -0.897         0.9700   1.480    0.1850  10.30
## 13    16   0.9780 -0.909         0.9740   1.050    0.0868   7.96
## 14    18   0.9550 -0.888         0.9650   0.769    0.0410   6.26
## 15    20   0.9520 -0.915         0.9540   0.583    0.0196   5.37
## ..connectivity..
## ..matrix multiplication (system BLAS)..
## ..normalization..
## ..done.
##    Power SFT.R.sq  slope truncated.R.sq mean.k. median.k. max.k.
## 1      1   0.0797  0.302         0.0932  99.100  119.0000 155.00
## 2      2   0.0610 -0.231         0.2280  51.000   60.9000 105.00
## 3      3   0.2110 -0.356         0.2630  31.100   33.3000  78.40
## 4      4   0.4050 -0.469         0.2650  20.600   18.9000  61.00
## 5      5   0.5180 -0.563         0.3810  14.300   11.1000  48.60
## 6      6   0.7660 -0.620         0.7560  10.300    6.6400  39.40
## 7      7   0.8370 -0.636         0.8740   7.600    4.0500  32.30
## 8      8   0.7960 -0.741         0.8130   5.740    2.5000  26.70
## 9      9   0.6690 -0.842         0.6500   4.430    1.5700  22.40
## 10    10   0.1640 -1.840         0.0645   3.470    0.9900  18.80
## 11    12   0.1750 -1.900         0.0704   2.230    0.4150  13.90
## 12    14   0.9230 -0.920         0.9100   1.510    0.1920  10.50
## 13    16   0.9620 -0.912         0.9510   1.070    0.0921   8.14
## 14    18   0.9450 -0.893         0.9470   0.788    0.0436   6.41
## 15    20   0.9300 -0.910         0.9330   0.597    0.0211   5.39
## ..connectivity..
## ..matrix multiplication (system BLAS)..
## ..normalization..
## ..done.
```

```
miRSM_SRVC_all <- miRSM(miRExp, ceRExp[, 151:300], mRExp[, 151:300],
                        miRTarget, modulegenes_all,
                        method = "SRVC", SMC.cutoff = 0.01,
                        RV_method = "RV")
miRSM_SRVC_exceptk <- lapply(seq(nsamples), function(i) miRSM(miRExp[-i, ],
                            ceRExp[-i, seq(150)], mRExp[-i, seq(150)],
                            miRTarget, modulegenes_exceptk[[i]],
                            method = "SRVC",
                            SMC.cutoff = 0.01, RV_method = "RV"))

Modulegenes_all <- miRSM_SRVC_all[[2]]
Modulegenes_exceptk <- lapply(seq(nsamples), function(i) miRSM_SRVC_exceptk[[i]][[2]])

Modules_SS <- miRSM_SS(Modulegenes_all, Modulegenes_exceptk)
Modules_SS
```

```
## $`Sample 1`
## $`Sample 1`$`miRSM 1`
## $`Sample 1`$`miRSM 1`$ceRNA
##  [1] "LINC00998"   "LINC01006"   "LINC01091"   "LINC01128"   "LINC01140"
##  [6] "LINC-PINT"   "LOH12CR2"    "MALAT1"      "MBL1P"       "MBNL1-AS1"
## [11] "MEG3"        "MIR22HG"     "MIR99AHG"    "MIRLET7BHG"  "NBR2"
## [16] "NCF1B"       "NEAT1"       "NKAPP1"      "NPY6R"       "NR2F1-AS1"
## [21] "NUDT16P1"    "PAX8-AS1"    "PAXIP1-AS2"  "PLEKHA8P1"   "PPP1R3E"
## [26] "PSMG3-AS1"   "PTENP1"      "RAMP2-AS1"   "RAPGEF4-AS1" "RP9P"
## [31] "RPL31P11"    "SCARNA7"     "SCARNA9"     "SFTA1P"      "SLC25A5-AS1"
## [36] "SMAD5-AS1"   "SMIM8"       "SNAI3-AS1"   "ST7"         "ST7-AS1"
## [41] "ST7-OT4"     "STAG3L4"     "TDGF1P3"     "TPTEP1"      "WDFY3-AS2"
## [46] "WWC2-AS2"    "ZFHX4-AS1"   "ZNF192P1"    "ZNF280D"
##
## $`Sample 1`$`miRSM 1`$mRNA
##  [1] "KL"          "KLB"         "KLF11"       "KLF15"       "KLF4"
##  [6] "KLF6"        "KLF8"        "KLF9"        "KLHDC1"      "KLHL3"
## [11] "KLHL31"      "LARP6"       "LCN10"       "LDB2"        "LEPR"
## [16] "LETMD1"      "LGR4"        "LHFP"        "LHX6"        "LIFR"
## [21] "LIMS2"       "LMO2"        "LONRF1"      "LPL"         "LRCH1"
## [26] "LRCH2"       "LRRC2"       "LRRC34"      "LRRN3"       "LYVE1"
## [31] "MAOA"        "MAP1LC3C"    "MAP3K8"      "MAP7D3"      "MASP1"
## [36] "MSRB3"       "MTMR10"      "MTURN"       "MYCT1"       "MYL9"
## [41] "MYOC"        "MYOCD"       "NAALAD2"     "NAT8L"       "NATD1"
## [46] "NDEL1"       "NDN"         "NECAB1"      "NFIA"        "NLGN1"
## [51] "NLRP1"       "NMNAT2"      "NMT2"        "NMUR1"       "NNAT"
## [56] "NOTCH4"      "NPR1"        "NR3C1"       "NRN1"        "OGN"
## [61] "OSBPL1A"     "P2RX6"       "PALM2-AKAP2" "PARK2"       "RAPGEF2"
## [66] "RB1"         "RBMS2"       "RBMS3"       "REV3L"       "RGL1"
##
##
## $`Sample 1`$`miRSM 2`
## $`Sample 1`$`miRSM 2`$ceRNA
## [1] "A2M-AS1"   "EMX2OS"    "GGTA1P"    "LINC00961"
##
## $`Sample 1`$`miRSM 2`$mRNA
##  [1] "C10orf10"  "C10orf54"  "C14orf180" "C17orf51"  "EBF1"      "EBF3"
##  [7] "FBLN5"     "FERMT2"    "FGF2"      "FGF9"      "FHL1"      "FHL5"
## [13] "FIGF"      "FIGN"      "FLRT2"     "FOXN3"     "FOXO1"     "FREM1"
## [19] "FRMD1"     "FRMD4A"    "FZD4"      "GABARAPL1" "GALNT15"   "GCOM1"
## [25] "GDF10"     "GHR"       "GID4"      "GIMAP6"    "GIMAP8"    "GIPC2"
## [31] "GLYAT"     "GNAI1"     "GNAL"      "GPAM"      "GPD1"      "GPIHBP1"
## [37] "GPLD1"     "GPR146"    "GPR17"     "GPX3"      "GRASP"     "GYG2"
## [43] "GYPC"      "HIF3A"     "HN1L"      "HSPB6"     "HSPB7"     "HYAL1"
## [49] "IGF1"      "IGF2"      "IGSF10"    "IL33"      "INMT"      "IQSEC3"
## [55] "ITIH5"     "ITM2A"     "KANK1"     "KCNAB1"    "KCNB1"     "KCNIP2"
## [61] "KCTD12"    "KIAA0355"  "KIAA0408"
##
##
##
## $`Sample 2`
## $`Sample 2`$`miRSM 1`
## $`Sample 2`$`miRSM 1`$ceRNA
##  [1] "LINC00998"   "LINC01006"   "LINC01091"   "LINC01128"   "LINC01140"
##  [6] "LINC-PINT"   "LOH12CR2"    "MALAT1"      "MBL1P"       "MBNL1-AS1"
## [11] "MEG3"        "MIR22HG"     "MIR99AHG"    "MIRLET7BHG"  "NBR2"
## [16] "NCF1B"       "NEAT1"       "NKAPP1"      "NPY6R"       "NR2F1-AS1"
## [21] "NUDT16P1"    "PAX8-AS1"    "PAXIP1-AS2"  "PLEKHA8P1"   "PPP1R3E"
## [26] "PSMG3-AS1"   "PTENP1"      "RAMP2-AS1"   "RAPGEF4-AS1" "RP9P"
## [31] "RPL31P11"    "SCARNA7"     "SCARNA9"     "SFTA1P"      "SLC25A5-AS1"
## [36] "SMAD5-AS1"   "SMIM8"       "SNAI3-AS1"   "ST7"         "ST7-AS1"
## [41] "ST7-OT4"     "STAG3L4"     "TDGF1P3"     "TPTEP1"      "WDFY3-AS2"
## [46] "WWC2-AS2"    "ZFHX4-AS1"   "ZNF192P1"    "ZNF280D"
##
## $`Sample 2`$`miRSM 1`$mRNA
##  [1] "KL"          "KLB"         "KLF11"       "KLF15"       "KLF4"
##  [6] "KLF6"        "KLF8"        "KLF9"        "KLHDC1"      "KLHL3"
## [11] "KLHL31"      "LARP6"       "LCN10"       "LDB2"        "LEPR"
## [16] "LETMD1"      "LGR4"        "LHFP"        "LHX6"        "LIFR"
## [21] "LIMS2"       "LMO2"        "LONRF1"      "LPL"         "LRCH1"
## [26] "LRCH2"       "LRRC2"       "LRRC34"      "LRRN3"       "LYVE1"
## [31] "MAOA"        "MAP1LC3C"    "MAP3K8"      "MAP7D3"      "MASP1"
## [36] "MSRB3"       "MTMR10"      "MTURN"       "MYCT1"       "MYL9"
## [41] "MYOC"        "MYOCD"       "NAALAD2"     "NAT8L"       "NATD1"
## [46] "NDEL1"       "NDN"         "NECAB1"      "NFIA"        "NLGN1"
## [51] "NLRP1"       "NMNAT2"      "NMT2"        "NMUR1"       "NNAT"
## [56] "NOTCH4"      "NPR1"        "NR3C1"       "NRN1"        "OGN"
## [61] "OSBPL1A"     "P2RX6"       "PALM2-AKAP2" "PARK2"       "RAPGEF2"
## [66] "RB1"         "RBMS2"       "RBMS3"       "REV3L"       "RGL1"
##
##
## $`Sample 2`$`miRSM 2`
## $`Sample 2`$`miRSM 2`$ceRNA
## [1] "A2M-AS1"   "EMX2OS"    "GGTA1P"    "LINC00961"
##
## $`Sample 2`$`miRSM 2`$mRNA
##  [1] "C10orf10"  "C10orf54"  "C14orf180" "C17orf51"  "EBF1"      "EBF3"
##  [7] "FBLN5"     "FBXO31"    "FERMT2"    "FGF2"      "FGF9"      "FHL1"
## [13] "FHL5"      "FIGF"      "FIGN"      "FLRT2"     "FOXN3"     "FOXO1"
## [19] "FREM1"     "FRMD1"     "FRMD4A"    "FZD4"      "GABARAPL1" "GALNT15"
## [25] "GCOM1"     "GDF10"     "GDF5"      "GHR"       "GID4"      "GIMAP6"
## [31] "GIMAP8"    "GIPC2"     "GLYAT"     "GNAI1"     "GNAL"      "GPAM"
## [37] "GPD1"      "GPIHBP1"   "GPLD1"     "GPR146"    "GPR17"     "GPX3"
## [43] "GRASP"     "GYG2"      "GYPC"      "HIF3A"     "HN1L"      "HSPB6"
## [49] "HSPB7"     "HYAL1"     "IGF1"      "IGF2"      "IGSF10"    "IL33"
## [55] "INMT"      "IQSEC3"    "ITIH5"     "ITM2A"     "KANK1"     "KAT2B"
## [61] "KCNAB1"    "KCNB1"     "KCNIP2"    "KCTD12"    "KIAA0355"  "KIAA0408"
## [67] "KIF26A"
##
##
##
## $`Sample 3`
## $`Sample 3`$`miRSM 1`
## $`Sample 3`$`miRSM 1`$ceRNA
##  [1] "LINC00998"   "LINC01006"   "LINC01091"   "LINC01128"   "LINC01140"
##  [6] "LINC-PINT"   "LOH12CR2"    "MALAT1"      "MBL1P"       "MBNL1-AS1"
## [11] "MEG3"        "MIR22HG"     "MIR99AHG"    "MIRLET7BHG"  "NBR2"
## [16] "NCF1B"       "NEAT1"       "NKAPP1"      "NPY6R"       "NR2F1-AS1"
## [21] "NUDT16P1"    "PAX8-AS1"    "PAXIP1-AS2"  "PLEKHA8P1"   "PPP1R3E"
## [26] "PSMG3-AS1"   "PTENP1"      "RAMP2-AS1"   "RAPGEF4-AS1" "RP9P"
## [31] "RPL31P11"    "SCARNA7"     "SCARNA9"     "SFTA1P"      "SLC25A5-AS1"
## [36] "SMAD5-AS1"   "SMIM8"       "SNAI3-AS1"   "ST7"         "ST7-AS1"
## [41] "ST7-OT4"     "STAG3L4"     "TDGF1P3"     "TPTEP1"      "WDFY3-AS2"
## [46] "WWC2-AS2"    "ZFHX4-AS1"   "ZNF192P1"    "ZNF280D"
##
## $`Sample 3`$`miRSM 1`$mRNA
##  [1] "KL"          "KLB"         "KLF11"       "KLF15"       "KLF4"
##  [6] "KLF6"        "KLF8"        "KLF9"        "KLHDC1"      "KLHL3"
## [11] "KLHL31"      "LARP6"       "LCN10"       "LDB2"        "LEPR"
## [16] "LETMD1"      "LGR4"        "LHFP"        "LHX6"        "LIFR"
## [21] "LIMS2"       "LMO2"        "LONRF1"      "LPL"         "LRCH1"
## [26] "LRCH2"       "LRRC2"       "LRRC34"      "LRRN3"       "LYVE1"
## [31] "MAOA"        "MAP1LC3C"    "MAP3K8"      "MAP7D3"      "MASP1"
## [36] "MSRB3"       "MTMR10"      "MTURN"       "MYCT1"       "MYL9"
## [41] "MYOC"        "MYOCD"       "NAALAD2"     "NAT8L"       "NATD1"
## [46] "NDEL1"       "NDN"         "NECAB1"      "NFIA"        "NLGN1"
## [51] "NLRP1"       "NMNAT2"      "NMT2"        "NMUR1"       "NNAT"
## [56] "NOTCH4"      "NPR1"        "NR3C1"       "NRN1"        "OGN"
## [61] "OSBPL1A"     "P2RX6"       "PALM2-AKAP2" "PARK2"       "RAPGEF2"
## [66] "RB1"         "RBMS2"       "RBMS3"       "REV3L"       "RGL1"
##
##
## $`Sample 3`$`miRSM 2`
## $`Sample 3`$`miRSM 2`$ceRNA
## [1] "A2M-AS1"   "EMX2OS"    "GGTA1P"    "LINC00961"
##
## $`Sample 3`$`miRSM 2`$mRNA
##  [1] "C10orf10"  "C10orf54"  "C14orf180" "C17orf51"  "EBF1"      "EBF3"
##  [7] "FBLN5"     "FERMT2"    "FGF2"      "FGF9"      "FHL1"      "FHL5"
## [13] "FIGF"      "FIGN"      "FLRT2"     "FOXN3"     "FOXO1"     "FREM1"
## [19] "FRMD1"     "FRMD4A"    "FZD4"      "GABARAPL1" "GALNT15"   "GCOM1"
## [25] "GDF10"     "GDF5"      "GHR"       "GID4"      "GIMAP6"    "GIMAP8"
## [31] "GIPC2"     "GLYAT"     "GNAI1"     "GNAL"      "GPAM"      "GPD1"
## [37] "GPIHBP1"   "GPLD1"     "GPR146"    "GPR17"     "GPX3"      "GRASP"
## [43] "GSTM5"     "GYG2"      "GYPC"      "HIF3A"     "HN1L"      "HSPB6"
## [49] "HSPB7"     "HYAL1"     "IGF1"      "IGF2"      "IGSF10"    "IL33"
## [55] "INMT"      "IQSEC3"    "ITIH5"     "ITM2A"     "KANK1"     "KCNAB1"
## [61] "KCNB1"     "KCNIP2"    "KCTD12"    "KIAA0355"  "KIAA0408"  "KIF26A"
```

# 5 Modular analysis of miRNA sponge modules

## 5.1 Functional analysis of miRNA sponge modules

`miRSM` implements *module\_FA* function to conduct functional analysis of miRNA sponge modules. The functional analysis includes two types: functional enrichment analysis (FEA) and disease enrichment analysis (DEA). Functional enrichment analysis includes GO, KEGG and Reactome enrichment analysis. The ontology databases used contain GO: Gene Ontology database (<http://www.geneontology.org/>), KEGG: Kyoto Encyclopedia of Genes and Genomes Pathway Database (<http://www.genome.jp/kegg/>), and Reactome: Reactome Pathway Database (<http://reactome.org/>). Disease enrichment analysis includes DO, DGN and NCG enrichment analysis. The disease databases used include DO: Disease Ontology database (<http://disease-ontology.org/>), DGN: DisGeNET database (<http://www.disgenet.org/>) and NCG: Network of Cancer Genes database (<http://ncg.kcl.ac.uk/>).

```
modulegenes_WGCNA <- module_WGCNA(ceRExp[, seq_len(150)],
                                  mRExp[, seq_len(150)])
# Identify miRNA sponge modules using sensitivity RV coefficient (SRVC)
miRSM_WGCNA_SRVC <- miRSM(miRExp, ceRExp, mRExp, miRTarget,
                         modulegenes_WGCNA, method = "SRVC",
                         SMC.cutoff = 0.01, RV_method = "RV")
miRSM_WGCNA_SRVC_genes <- miRSM_WGCNA_SRVC[[2]]
miRSM_WGCNA_SRVC_FEA <- module_FA(miRSM_WGCNA_SRVC_genes, Analysis.type = 'FEA')
miRSM_WGCNA_SRVC_DEA <- module_FA(miRSM_WGCNA_SRVC_genes, Analysis.type = 'DEA')
```

## 5.2 Cancer enrichment analysis of miRNA sponge modules

To investigate whether the identified miRNA sponge modules are functionally associated with cancer of interest, `miRSM` implements *module\_CEA* function to conduct cancer enrichment analysis by using a hypergeometric test.

```
modulegenes_WGCNA <- module_WGCNA(ceRExp[, seq_len(150)],
                                  mRExp[, seq_len(150)])
```

```
##    Power SFT.R.sq  slope truncated.R.sq mean.k. median.k. max.k.
## 1      1   0.0895  0.309         0.1170  98.900  119.0000 155.00
## 2      2   0.0596 -0.227         0.2320  50.800   60.6000 105.00
## 3      3   0.2130 -0.351         0.2590  30.900   33.1000  78.20
## 4      4   0.3920 -0.466         0.2520  20.400   18.8000  60.80
## 5      5   0.5420 -0.569         0.4120  14.200   11.0000  48.40
## 6      6   0.7680 -0.619         0.7610  10.200    6.6000  39.20
## 7      7   0.8130 -0.651         0.8450   7.530    4.0200  32.10
## 8      8   0.7970 -0.740         0.8160   5.690    2.4800  26.60
## 9      9   0.6740 -0.843         0.6600   4.380    1.5500  22.20
## 10    10   0.1650 -1.840         0.0659   3.430    0.9810  18.70
## 11    12   0.1760 -1.910         0.0729   2.200    0.4040  13.80
## 12    14   0.9700 -0.898         0.9690   1.490    0.1860  10.40
## 13    16   0.9630 -0.922         0.9530   1.060    0.0876   8.05
## 14    18   0.9490 -0.889         0.9570   0.777    0.0419   6.33
## 15    20   0.9310 -0.919         0.9270   0.589    0.0198   5.38
## ..connectivity..
## ..matrix multiplication (system BLAS)..
## ..normalization..
## ..done.
```

```
# Identify miRNA sponge modules using sensitivity RV coefficient (SRVC)
miRSM_WGCNA_SRVC <- miRSM(miRExp, ceRExp, mRExp, miRTarget,
                         modulegenes_WGCNA, method = "SRVC",
                         SMC.cutoff = 0.01, RV_method = "RV")
miRSM_WGCNA_SRVC_genes <- miRSM_WGCNA_SRVC[[2]]
miRSM.CEA.pvalue <- module_CEA(ceRExp, mRExp, BRCA_genes, miRSM_WGCNA_SRVC_genes)
miRSM.CEA.pvalue
```

```
##   miRSM 1
## 0.2835354
```

## 5.3 Validation of miRNA sponge interactions in miRNA sponge modules

The function *module\_Validate* is implemented to validate the miRNA sponge interactions existed in each miRNA sponge module. The built-in high-confidence groundtruth of miRNA sponge interactions is obtained from miRSponge (<http://bio-bigdata.hrbmu.edu.cn/miRSponge/>), LncACTdb 3.0 (<http://bio-bigdata.hrbmu.edu.cn/LncACTdb/>), LncCeRBase (<http://www.insect-genome.com/LncCeRBase/front/>).

If you want to use low-confidence groundtruth of miRNA sponge interactions for validation, ENCORI (<https://rnasysu.com/encori/>) is suggested. For example, by using web API of ENCORI, the mRNA related miRNA sponge interactions are from <https://rna.sysu.edu.cn/encori/api/ceRNA/?assembly=hg38&geneType=mRNA&ceRNA=all&miRNAnum=1&pval=0.01&fdr=0.01&pancancerNum=1>, the lncRNA related miRNA sponge interactions are from <https://rna.sysu.edu.cn/encori/api/ceRNA/?assembly=hg38&geneType=lncRNA&ceRNA=all&miRNAnum=1&pval=0.01&fdr=0.01&pancancerNum=1>, and the pseudogene related miRNA sponge interactions are from <https://rna.sysu.edu.cn/encori/api/ceRNA/?assembly=hg38&geneType=pseudogene&ceRNA=all&miRNAnum=1&pval=0.01&fdr=0.01&pancancerNum=1>.

```
# Using the built-in groundtruth from the miRSM package
Groundtruthcsv <- system.file("extdata", "Groundtruth_high.csv", package="miRSM")
Groundtruth <- read.csv(Groundtruthcsv, header=TRUE, sep=",")
# Using the identified miRNA sponge modules based on WGCNA and sensitivity RV coefficient (SRVC)
miRSM.Validate <- module_Validate(miRSM_WGCNA_SRVC_genes, Groundtruth)
```

## 5.4 Co-expression analysis of miRNA sponge modules

To evaluate whether the ceRNAs and mRNAs in the miRNA sponge modules are not randomly co-expressed, `miRSM` implements *module\_Coexpress* function to calculate average (mean and median) absolute Pearson correlation of all the ceRNA-mRNA pairs in each miRNA sponge module to see the overall co-expression level between the ceRNAs and mRNAs in the miRNA sponge module. For each miRNA sponge module, `miRSM` performs a permutation test by generating random modules (the parameter *resample* is the number of random modules to be generated) with the same number of ceRNAs and mRNAs for it to compute the statistical significance p-value of the co-expression level.

```
# Using the identified miRNA sponge modules based on WGCNA and sensitivity RV coefficient (SRVC)
miRSM_WGCNA_Coexpress <-  module_Coexpress(ceRExp, mRExp, miRSM_WGCNA_SRVC_genes, resample = 10, method = "mean", test.method = "t.test")
miRSM_WGCNA_Coexpress
```

```
## $`Real miRNA sponge modules`
## [1] 0.7512547
##
## $`Random miRNA sponge modules`
## [1] 0.2859385
##
## $`Statistical significance p-value`
## [1] 5.150866e-08
```

## 5.5 Distribution analysis of sharing miRNAs

To investigate the distribution of sharing miRNAs in the identified miRNA sponge modules, `miRSM` implements *module\_miRdistribute* function. The miRNA distribution analysis can understand whether the sharing miRNAs act as crosslinks across different miRNA sponge modules.

```
# Using the identified miRNA sponge modules based on WGCNA and sensitivity RV coefficient (SRVC)
miRSM_WGCNA_share_miRs <-  share_miRs(miRExp, miRTarget, miRSM_WGCNA_SRVC_genes)
miRSM_WGCNA_miRdistribute <- module_miRdistribute(miRSM_WGCNA_share_miRs)
head(miRSM_WGCNA_miRdistribute)
```

```
##      miRNA             Module ID Number of modules
## [1,] "hsa-let-7b-5p"   "miRSM 1" "1"
## [2,] "hsa-let-7d-5p"   "miRSM 1" "1"
## [3,] "hsa-let-7e-5p"   "miRSM 1" "1"
## [4,] "hsa-miR-125a-5p" "miRSM 1" "1"
## [5,] "hsa-miR-148b-3p" "miRSM 1" "1"
## [6,] "hsa-miR-149-5p"  "miRSM 1" "1"
```

## 5.6 Predicting miRNA-target interactions

Since the identified miRNA sponge modules and their sharing miRNAs can also be used to predict miRNA-target interactions (including miRNA-ceRNA and miRNA-mRNA interactions), `miRSM` implements *module\_miRtarget* function to predict miRNA-target interactions underlying in each miRNA sponge module.

```
# Using the identified miRNA sponge modules based on WGCNA and sensitivity RV coefficient (SRVC)
miRSM_WGCNA_miRtarget <- module_miRtarget(miRSM_WGCNA_share_miRs, miRSM_WGCNA_SRVC_genes)
```

## 5.7 Identifying miRNA sponge interactions

To extract miRNA sponge interactions of each miRNA sponge module, `miRSM` implements *module\_miRsponge* function to identify miRNA sponge interactions.

```
# Using the identified miRNA sponge modules based on WGCNA and sensitivity RV coefficient (SRVC)
miRSM_WGCNA_miRsponge <- module_miRsponge(miRSM_WGCNA_SRVC_genes)
```

# 6 Conclusions

`miRSM` provides several functions to study miRNA sponge modules at single-sample and multi-sample levels, including popular methods for inferring gene modules (candidate miRNA sponge or ceRNA modules), and two functions to identify miRNA sponge modules at single-sample and multi-sample levels, as well as several functions to conduct modular analysis of miRNA sponge modules. It could provide a useful tool for the research of miRNA sponge modules at single-sample and multi-sample levels.

# 7 References

# Appendix

[1] Ambros V. microRNAs: tiny regulators with great potential. Cell, 2001, 107:823–6.

[2] Bartel DP. MicroRNAs: genomics, biogenesis, mechanism, and function. Cell, 2004, 116:281–97.

[3] Du T, Zamore PD. Beginning to understand microRNA function. Cell Research, 2007, 17:661–3.

[4] Esquela-Kerscher A, Slack FJ. Oncomirs—microRNAs with a role in cancer.
Nature Reviews Cancer, 2006, 6:259–69.

[5] Lin S, Gregory RI. MicroRNA biogenesis pathways in cancer.
Nature Reviews Cancer, 2015, 15:321–33.

[6] Cesana M, Cacchiarelli D, Legnini I, et al. A long noncoding RNA
controls muscle differentiation by functioning as a competing endogenous
RNA. Cell, 2011, 147:358–69.

[7] Poliseno L, Salmena L, Zhang J, et al. A coding-independent function
of gene and pseudogene mRNAs regulates tumour biology. Nature, 2010,
465:1033–8.

[8] Hansen TB, Jensen TI, Clausen BH, et al. Natural RNA circles function
as efficient microRNA sponges. Nature, 2013, 495:384–8.

[9] Memczak S, Jens M, Elefsinioti A, et al. Circular RNAs are a large
class of animal RNAs with regulatory potency. Nature, 2013, 495:333–8.

[10] Salmena L, Poliseno L, Tay Y, et al. A ceRNA hypothesis: the Rosetta Stone
of a hidden RNA language? Cell, 2011, 146(3):353-8.

[11] Langfelder P, Horvath S. WGCNA: an R package for weighted correlation network analysis. BMC Bioinformatics, 2008, 9:559.

[12] Bunte K, Lepp"{a}aho E, Saarinen I, Kaski S. Sparse group factor analysis for biclustering of multiple data sources. Bioinformatics, 2016, 32(16):2457-63.

[13] Lepp"{a}aho E, Ammad-ud-din M, Kaski S. GFA: exploratory analysis of multiple data sources with group factor analysis. J Mach Learn Res., 2017, 18(39):1-5.

[14] Csardi G, Nepusz T. The igraph software package for complex network research, InterJournal, Complex Systems, 2006:1695.

[15] Clauset A, Newman ME, Moore C. Finding community structure in very large networks. Phys Rev E Stat Nonlin Soft Matter Phys., 2004, 70(6 Pt 2):066111.

[16] Enright AJ, Van Dongen S, Ouzounis CA. An efficient algorithm for large-scale detection of protein families. Nucleic Acids Res., 2002, 30(7):1575-84.

[17] Kalinka AT, Tomancak P. linkcomm: an R package for the generation, visualization, and analysis of link communities in networks of arbitrary size and type. Bioinformatics, 2011, 27(14):2011-2.

[18] Bader GD, Hogue CW. An automated method for finding molecular complexes in large protein interaction networks. BMC Bioinformatics, 2003, 4:2.

[19] Zhang Y, Phillips CA, Rogers GL, Baker EJ, Chesler EJ, Langston MA. On finding bicliques in bipartite graphs: a novel algorithm and its application to the integration of diverse biological data types. BMC Bioinformatics, 2014, 15:110.

[20] Gaujoux R, Seoighe C. A flexible R package for nonnegative matrix factorization. BMC Bioinformatics, 2010, 11:367.

[21] R Core Team. R: A language and environment for statistical computing. R Foundation for
Statistical Computing, Vienna, Austria, 2018.

[22] Langfelder P, Horvath S. Fast R Functions for Robust Correlations and Hierarchical Clustering.
Journal of Statistical Software. 2012, 46(11):1-17.

[23] Hahsler M, Piekenbrock M. dbscan: Density Based Clustering of
Applications with Noise (DBSCAN) and Related Algorithms. R package version 1.1-2, 2018.

[24] Cebeci Z, Yildiz F, Kavlak AT, Cebeci C, Onder H. ppclust: Probabilistic and
Possibilistic Cluster Analysis. R package version 0.1.1, 2018.

[25] Scrucca L, Fop M, Murphy TB, Raftery AE. mclust 5: clustering, classification and density estimation using Gaussian finite mixture models The R Journal 8/1, 2016, pp. 205-233.

[26] Villa-Vialaneix N, Bendhaiba L, Olteanu M. SOMbrero: SOM Bound to Realize Euclidean and Relational Outputs. R package version 1.2-3, 2018.

[27] Cebeci Z, Yildiz F, Kavlak AT, Cebeci C, Onder H. ppclust: Probabilistic and Possibilistic Cluster Analysis. R package version 0.1.2, 2019.

[28] Kaiser S, Santamaria R, Khamiakova T, Sill M, Theron R, Quintales L, Leisch F, De TE. biclust: BiCluster Algorithms. R package version 1.2.0., 2015.

[29] Gusenleitner D, Howe EA, Bentink S, Quackenbush J, Culhane AC. iBBiG: iterative binary bi-clustering of gene sets. Bioinformatics, 2012, 28(19):2484-92.

[30] Hochreiter S, Bodenhofer U, Heusel M, Mayr A, Mitterecker A, Kasim A, Khamiakova T, Van Sanden S, Lin D, Talloen W, Bijnens L, G"{o}hlmann HW, Shkedy Z, Clevert DA. FABIA: factor analysis for bicluster acquisition. Bioinformatics, 2010, 26(12):1520-7.

[31] Yang J, Wang H, Wang W, Yu, PS. An improved biclustering method for analyzing gene expression. Int J Artif Intell Tools, 2005, 14(5): 771-789.

[32] Bergmann S, Ihmels J, Barkai N. Iterative signature algorithm for the analysis of large-scale gene expression data. Phys Rev E Stat Nonlin Soft Matter Phys., 2003, 67(3 Pt 1):031902.

[33] Sill M, Kaiser S, Benner A, Kopp-Schneider A. Robust biclustering by sparse singular value decomposition incorporating stability selection. Bioinformatics, 2011, 27(15):2089-97.

[34] Rodriguez-Baena DS, Perez-Pulido AJ, Aguilar-Ruiz JS. A biclustering algorithm for extracting bit-patterns from binary datasets. Bioinformatics, 2011, 27(19):2738-45.

[35] Li G, Ma Q, Tang H, Paterson AH, Xu Y. QUBIC: a qualitative biclustering algorithm for analyses of gene expression data. Nucleic Acids Res., 2009, 37(15):e101.

[36] Zhang J, Le TD, Liu L, Li J. Identifying miRNA sponge modules using biclustering and regulatory scores. BMC Bioinformatics, 2017, 18(Suppl 3):44.

# A Session information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] NMF_0.28            cluster_2.1.8.1     rngtools_1.5.2
##  [4] registry_0.5-1      miRSM_2.6.0         bigmemory_4.6.4
##  [7] Biobase_2.70.0      BiocGenerics_0.56.0 generics_0.1.4
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] fs_1.6.6                    matrixStats_1.5.0
##   [3] enrichplot_1.30.0           httr_1.4.7
##   [5] RColorBrewer_1.1-3          doParallel_1.0.17
##   [7] dynamicTreeCut_1.63-1       tools_4.5.1
##   [9] backports_1.5.0             R6_2.6.1
##  [11] lazyeval_0.2.2              MatrixCorrelation_0.10.1
##  [13] ppclust_1.1.0.1             withr_3.0.2
##  [15] graphite_1.56.0             prettyunits_1.2.0
##  [17] gridExtra_2.3               preprocessCore_1.72.0
##  [19] flexclust_1.5.0             WGCNA_1.73
##  [21] cli_3.6.5                   flashClust_1.01-2
##  [23] iBBiG_1.54.0                sass_0.4.10
##  [25] inaparc_1.2.1               S7_0.2.0
##  [27] systemfonts_1.3.1           yulab.utils_0.2.1
##  [29] dbscan_1.2.3                gson_0.1.0
##  [31] foreign_0.8-90              DOSE_4.4.0
##  [33] R.utils_2.13.0              dichromat_2.0-0.1
##  [35] plotrix_3.8-4               impute_1.84.0
##  [37] rstudioapi_0.17.1           RSQLite_2.4.3
##  [39] gridGraphics_0.5-1          dplyr_1.1.4
##  [41] dendextend_1.19.1           GO.db_3.22.0
##  [43] Matrix_1.7-4                interp_1.1-6
##  [45] PMA_1.2-4                   S4Vectors_0.48.0
##  [47] abind_1.4-8                 R.methodsS3_1.8.2
##  [49] SOMbrero_1.5.0              lifecycle_1.0.4
##  [51] scatterplot3d_0.3-44        yaml_2.3.10
##  [53] SummarizedExperiment_1.40.0 qvalue_2.42.0
##  [55] SparseArray_1.10.0          Rtsne_0.17
##  [57] grid_4.5.1                  blob_1.2.4
##  [59] crayon_1.5.3                ggtangle_0.0.7
##  [61] lattice_0.22-7              cowplot_1.2.0
##  [63] rqubic_1.56.0               annotate_1.88.0
##  [65] KEGGREST_1.50.0             pillar_1.11.1
##  [67] knitr_1.50                  fgsea_1.36.0
##  [69] GenomicRanges_1.62.0        boot_1.3-32
##  [71] codetools_0.2-20            fastmatch_1.1-6
##  [73] glue_1.8.0                  ggiraph_0.9.2
##  [75] V8_8.0.1                    ggfun_0.2.0
##  [77] fontLiberation_0.1.0        data.table_1.17.8
##  [79] kpeaks_1.1.0                vctrs_0.6.5
##  [81] png_0.1-8                   additivityTests_1.1-4.2
##  [83] treeio_1.34.0               gtable_0.3.6
##  [85] cachem_1.1.0                xfun_0.53
##  [87] S4Arrays_1.10.0             tidygraph_1.3.1
##  [89] Seqinfo_1.0.0               pracma_2.4.6
##  [91] survival_3.8-3              rJava_1.0-11
##  [93] iterators_1.0.14            nlme_3.1-168
##  [95] ggtree_4.0.0                bit64_4.6.0-1
##  [97] fontquiver_0.2.1            progress_1.2.3
##  [99] MCL_1.0                     ggwordcloud_0.6.2
## [101] bslib_0.9.0                 rpart_4.1.24
## [103] fabia_2.56.0                colorspace_2.1-2
## [105] DBI_1.2.3                   Hmisc_5.2-4
## [107] ade4_1.7-23                 nnet_7.3-20
## [109] tidyselect_1.2.1            bit_4.6.0
## [111] compiler_4.5.1              curl_7.0.0
## [113] graph_1.88.0                BiBitR_0.3.1
## [115] htmlTable_2.4.3             expm_1.0-0
## [117] xml2_1.4.1                  fontBitstreamVera_0.1.1
## [119] DelayedArray_0.36.0         bookdown_0.45
## [121] checkmate_2.3.3             scales_1.4.0
## [123] metR_0.18.2                 rappdirs_0.3.3
## [125] stringr_1.5.2               digest_0.6.37
## [127] rmarkdown_2.30              XVector_0.50.0
## [129] htmltools_0.5.8.1           pkgconfig_2.0.3
## [131] BicARE_1.68.0               base64enc_0.1-3
## [133] lhs_1.2.0                   MatrixGenerics_1.22.0
## [135] fastmap_1.2.0               rlang_1.1.6
## [137] htmlwidgets_1.6.4           farver_2.1.2
## [139] jquerylib_0.1.4             energy_1.7-12
## [141] jsonlite_2.0.0              mclust_6.1.1
## [143] BiocParallel_1.44.0         GOSemSim_2.36.0
## [145] R.oo_1.27.1                 magrittr_2.0.4
## [147] modeltools_0.2-24           Formula_1.2-5
## [149] ggplotify_0.1.3             patchwork_1.3.2
## [151] Rcpp_1.1.0                  biclust_2.0.3.1
## [153] ape_5.8-1                   viridis_0.6.5
## [155] gdtools_0.4.4               stringi_1.8.7
## [157] ggraph_2.2.2                MASS_7.3-65
## [159] plyr_1.8.9                  org.Hs.eg.db_3.22.0
## [161] parallel_4.5.1              randomcoloR_1.1.0.1
## [163] ggrepel_0.9.6               bigmemory.sri_0.1.8
## [165] GFA_1.0.5                   deldir_2.0-4
## [167] Biostrings_2.78.0           graphlayouts_1.2.2
## [169] splines_4.5.1               gridtext_0.1.5
## [171] multtest_2.66.0             hms_1.1.4
## [173] igraph_2.2.1                uuid_1.2-1
## [175] fastcluster_1.3.0           markdown_2.0
## [177] reshape2_1.4.4              stats4_4.5.1
## [179] XML_3.99-0.19               evaluate_1.0.5
## [181] BiocManager_1.30.26         foreach_1.5.2
## [183] tweenr_2.0.3                tidyr_1.3.1
## [185] purrr_1.1.0                 polyclip_1.10-7
## [187] isa2_0.3.6                  ggplot2_4.0.0
## [189] gridBase_0.4-7              ReactomePA_1.54.0
## [191] ggforce_0.5.0               xtable_1.8-4
## [193] reactome.db_1.94.0          RSpectra_0.16-2
## [195] tidytree_0.4.6              viridisLite_0.4.2
## [197] class_7.3-23                gsl_2.1-8
## [199] tibble_3.3.0                clusterProfiler_4.18.0
## [201] aplot_0.2.9                 memoise_2.0.1
## [203] AnnotationDbi_1.72.0        IRanges_2.44.0
## [205] GSEABase_1.72.0
```