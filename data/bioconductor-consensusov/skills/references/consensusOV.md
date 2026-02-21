# Molecular subtyping for ovarian cancer

Gregory M Chen

#### 29 October 2025

#### Package

consensusOV 1.32.0

# Contents

* [1 Introduction](#introduction)
* [2 Load Data](#load-data)
* [3 Subtyping](#subtyping)
* [4 Subtype Scores](#subtype-scores)

# 1 Introduction

*[consensusOV](https://bioconductor.org/packages/3.22/consensusOV)* is a package for molecular subtyping for ovarian cancer. It is intended for whole-transcriptome gene expression datasets from patients with high-grade serous ovarian carcinoma. This package includes implementations of four previously published subtype classifiers
([Helland et al., 2011](https://doi.org/10.1371/journal.pone.0018064);
[Bentink et al., 2012](https://doi.org/10.1371/journal.pone.0030269);
[Verhaak et al., 2013](https://doi.org/10.1172/JCI65833);
[Konecny et al., 2014](https://doi.org/10.1093/jnci/dju249))
and a consensus random forest classifier ([Chen et al., 2018](https://doi.org/10.1158/1078-0432.CCR-18-0784)).

The `get.subtypes()` function is a wrapper for the other package subtyping functions `get.consensus.subtypes()`, `get.konecny.subtypes()`, `get.verhaak.subtypes()`,
`get.bentink.subtypes()`, `get.helland.subtypes()`. It can take as input either a matrix of gene expression values and a vector of Entrez IDs; or an `ExpressionSet` from the *[Biobase](https://bioconductor.org/packages/3.22/Biobase)* package. If `expression.dataset` is a matrix, it should be formatted with genes as rows and patients as columns; and `entrez.ids` should be a vector with length the same as `nrow(expression.dataset)`. The `method` argument specifies which of the five subtype classifiers to use.

# 2 Load Data

```
library(consensusOV)
library(Biobase)
library(genefu)
```

```
## Warning: replacing previous import 'limma::logsumexp' by 'mclust::logsumexp'
## when loading 'genefu'
```

The package contains a subset of the ovarian cancer microarray dataset
[GSE14764](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE14764) as example data.

```
data(GSE14764.eset)
dim(GSE14764.eset)
```

```
## Features  Samples
##     1175       41
```

```
GSE14764.expression.matrix <- exprs(GSE14764.eset)
GSE14764.expression.matrix[1:5,1:5]
```

```
##              GSE14764_GSM368661 GSE14764_GSM368662 GSE14764_GSM368664
## geneid.10397          10.856712          10.445412          11.976560
## geneid.65108          10.856441          10.312760          12.499419
## geneid.8655           11.518799          11.897707          11.782895
## geneid.22919           8.608944           8.756986           9.170513
## geneid.3925            7.658680           6.698586           7.159795
##              GSE14764_GSM368665 GSE14764_GSM368668
## geneid.10397          11.651318          10.907453
## geneid.65108          11.377340          11.088542
## geneid.8655           11.799197          11.958500
## geneid.22919           8.627511           8.849757
## geneid.3925            7.466107           6.566558
```

```
GSE14764.entrez.ids <- fData(GSE14764.eset)$EntrezGene.ID
head(GSE14764.entrez.ids)
```

```
## [1] "10397" "65108" "8655"  "22919" "3925"  "1718"
```

# 3 Subtyping

```
bentink.subtypes <- get.subtypes(GSE14764.eset, method = "Bentink")
bentink.subtypes$Bentink.subtypes
```

```
##  [1] "Angiogenic"    "nonAngiogenic" "nonAngiogenic" "Angiogenic"
##  [5] "Angiogenic"    "nonAngiogenic" "Angiogenic"    "nonAngiogenic"
##  [9] "nonAngiogenic" "Angiogenic"    "nonAngiogenic" "nonAngiogenic"
## [13] "Angiogenic"    "nonAngiogenic" "nonAngiogenic" "nonAngiogenic"
## [17] "nonAngiogenic" "Angiogenic"    "nonAngiogenic" "nonAngiogenic"
## [21] "Angiogenic"    "Angiogenic"    "Angiogenic"    "nonAngiogenic"
## [25] "nonAngiogenic" "Angiogenic"    "nonAngiogenic" "nonAngiogenic"
## [29] "nonAngiogenic" "nonAngiogenic" "nonAngiogenic" "Angiogenic"
## [33] "nonAngiogenic" "nonAngiogenic" "nonAngiogenic" "nonAngiogenic"
## [37] "nonAngiogenic" "Angiogenic"    "nonAngiogenic" "nonAngiogenic"
## [41] "nonAngiogenic"
```

```
konecny.subtypes <- get.subtypes(GSE14764.eset, method = "Konecny")
konecny.subtypes$Konecny.subtypes
```

```
##  [1] C3_profL C1_immL  C2_diffL C4_mescL C1_immL  C1_immL  C4_mescL C3_profL
##  [9] C3_profL C1_immL  C2_diffL C2_diffL C4_mescL C2_diffL C3_profL C2_diffL
## [17] C1_immL  C4_mescL C1_immL  C2_diffL C4_mescL C4_mescL C4_mescL C1_immL
## [25] C3_profL C3_profL C2_diffL C2_diffL C3_profL C2_diffL C3_profL C1_immL
## [33] C1_immL  C2_diffL C1_immL  C2_diffL C3_profL C3_profL C2_diffL C3_profL
## [41] C2_diffL
## Levels: C1_immL C2_diffL C3_profL C4_mescL
```

```
helland.subtypes <- get.subtypes(GSE14764.eset, method = "Helland")
helland.subtypes$Helland.subtypes
```

```
##  [1] C1 C2 C5 C1 C1 C2 C4 C1 C5 C2 C4 C4 C1 C5 C4 C4 C2 C1 C4 C5 C1 C1 C1 C2 C5
## [26] C1 C5 C2 C5 C4 C5 C2 C2 C4 C2 C4 C1 C1 C4 C1 C4
## Levels: C2 C4 C5 C1
```

```
# to align with the Verhaak subtypes, we need to remove the "geneid." in the rownames
temp_eset <- GSE14764.eset
rownames(temp_eset) <- gsub("geneid.", "", rownames(temp_eset))

verhaak.subtypes <- get.subtypes(temp_eset, method = "Verhaak")
```

```
## ℹ GSVA version 2.4.0
```

```
## ℹ Searching for genes/features with constant values
```

```
## ℹ Using a MulticoreParam parallel back-end with 2 workers
```

```
## ℹ Calculating  ssGSEA scores for 4 gene sets
```

```
## ℹ Calculating ranks
```

```
## ℹ Calculating rank weights
```

```
## ✔ Calculations finished
```

```
verhaak.subtypes$Verhaak.subtypes
```

```
##  [1] MES IMR DIF DIF MES IMR DIF MES PRO IMR DIF DIF MES DIF DIF DIF DIF MES DIF
## [20] PRO MES DIF DIF DIF MES MES DIF DIF PRO DIF PRO IMR IMR DIF DIF DIF PRO MES
## [39] DIF MES DIF
## Levels: IMR DIF PRO MES
```

```
consensus.subtypes <- get.subtypes(GSE14764.eset, method = "consensusOV")
```

```
## Loading training data
```

```
## Training Random Forest...
```

```
consensus.subtypes$consensusOV.subtypes
```

```
##  [1] MES_consensus IMR_consensus PRO_consensus DIF_consensus IMR_consensus
##  [6] IMR_consensus MES_consensus MES_consensus PRO_consensus IMR_consensus
## [11] DIF_consensus DIF_consensus MES_consensus PRO_consensus DIF_consensus
## [16] DIF_consensus IMR_consensus MES_consensus IMR_consensus PRO_consensus
## [21] MES_consensus MES_consensus MES_consensus IMR_consensus PRO_consensus
## [26] MES_consensus DIF_consensus IMR_consensus PRO_consensus DIF_consensus
## [31] PRO_consensus IMR_consensus IMR_consensus DIF_consensus DIF_consensus
## [36] DIF_consensus PRO_consensus PRO_consensus DIF_consensus MES_consensus
## [41] DIF_consensus
## Levels: IMR_consensus DIF_consensus PRO_consensus MES_consensus
```

```
## Alternatively, e.g.
data(sigOvcAngiogenic)
bentink.subtypes <- get.subtypes(GSE14764.expression.matrix, GSE14764.entrez.ids, method = "Bentink")
```

Each subtyping function outputs a list with two values. The first value is a factor of subtype labels. The second is an classifier-specific values. For the Konecny, Helland, Verhaak, and Consensus classifiers, this object is a dataframe with subtype specific scores. For the Bentink classifier, the object is the output of the `genefu` function call.

Subtype classifiers can alternatively be called using inner functions.

```
bentink.subtypes <- get.bentink.subtypes(GSE14764.expression.matrix, GSE14764.entrez.ids)
```

# 4 Subtype Scores

The Konecny, Helland, Verhaak, and Consensus classifiers produce real-valued subtype scores. We can use these in various ways - for example, here, we compute correlations between correspinding subtype scores.

We can compare the subtype scores between the Verhaak and Helland classifiers:

```
vest <- verhaak.subtypes$gsva.out
vest <- vest[,c("IMR", "DIF", "PRO", "MES")]
hest <- helland.subtypes$subtype.scores
hest <- hest[, c("C2", "C4", "C5", "C1")]
dat <- data.frame(
    as.vector(vest),
    rep(colnames(vest), each=nrow(vest)),
    as.vector(hest),
    rep(colnames(hest), each=nrow(hest)))
colnames(dat) <- c("Verhaak", "vsc", "Helland", "hsc")
## plot
library(ggplot2)
```

```
##
## Attaching package: 'ggplot2'
```

```
## The following object is masked from 'package:e1071':
##
##     element
```

```
## The following object is masked from 'package:consensusOV':
##
##     margin
```

```
ggplot(dat, aes(Verhaak, Helland)) + geom_point() + facet_wrap(vsc~hsc, nrow = 2, ncol = 2)
```

![](data:image/png;base64...)

Corresponding correlation values are
0.81,
0.85,
0.45, and
0.89.

Likewise, we can compare the subtype scores between the Konecny and Helland classifier:

```
kost <- konecny.subtypes$spearman.cc.vals
hest <- helland.subtypes$subtype.scores
hest <- hest[, c("C2", "C4", "C5", "C1")]
dat <- data.frame(
    as.vector(kost),
    rep(colnames(kost), each=nrow(kost)),
    as.vector(hest),
    rep(colnames(hest), each=nrow(hest)))
colnames(dat) <- c("Konecny", "ksc", "Helland", "hsc")
## plot
ggplot(dat, aes(Konecny, Helland)) + geom_point() + facet_wrap(ksc~hsc, nrow = 2, ncol = 2)
```

![](data:image/png;base64...)

Corresponding correlation values are
0.95,
0.84,
0.7,
and 0.95.