# GSgalgoR user Guide

Martin E. Guerrero-Gimenez1,2\*, Juan Manuel Fernandez-Muñoz1,2 and Carlos A. Catania3\*\*

1Laboratory of Oncology, Institute of Medicine and Experimental Biology of Cuyo (IMBECU), National Scientific and Technical Research Council (CONICET), Mendoza, Argentina.
2Institute of Biochemistry and Biotechnology, Medical School, National University of Cuyo, Mendoza, Argentina.
3LABSIN, Engineering School, National University of Cuyo, Mendoza, Argentina.

\*mguerrero@mendoza-conicet.gob.ar
\*\*harpo@ingenieria.uncuyo.edu.ar

#### 2025-10-30

#### Abstract

We report a novel method to identify specific transcriptomic phenotypes based on an elitist non-dominated sorting genetic algorithm that combines the advantages of clustering methods and the exploratory properties of genetic algorithms to discover biologically and clinically relevant molecular subtypes in different cancers.

# Contents

* [1 Overview](#overview)
* [2 Algorithm](#algorithm)
* [3 Installation](#installation)
  + [3.1 GSgalgoR library](#gsgalgor-library)
  + [3.2 Examples datasets](#examples-datasets)
* [4 Examples](#examples)
  + [4.1 Loading data](#loading-data)
  + [4.2 Data tidying and preparation](#data-tidying-and-preparation)
    - [4.2.1 Drop duplicates and NA’s](#drop-duplicates-and-nas)
    - [4.2.2 Expand probesets that map for multiple genes](#expand-probesets-that-map-for-multiple-genes)
    - [4.2.3 Rescale expression matrix](#rescale-expression-matrix)
    - [4.2.4 Survival Object](#survival-object)
  + [4.3 Run galgo()](#run-galgo)
    - [4.3.1 Setting parameters](#setting-parameters)
    - [4.3.2 Run Galgo algorithm](#run-galgo-algorithm)
    - [4.3.3 Galgo Object](#galgo-object)
  + [4.4 to\_list() function](#to_list-function)
  + [4.5 to\_dataframe() function](#to_dataframe-function)
  + [4.6 plot\_pareto()](#plot_pareto)
* [5 Case study](#case-study)
  + [5.1 Data Preprocessing](#data-preprocessing)
  + [5.2 Breast cancer classification](#breast-cancer-classification)
    - [5.2.1 Survival of UPP patients](#survival-of-upp-patients)
    - [5.2.2 Survival of TRANSBIG patients](#survival-of-transbig-patients)
  + [5.3 Find breast cancer gene signatures with GSgalgoR](#find-breast-cancer-gene-signatures-with-gsgalgor)
    - [5.3.1 Set configuration parameters](#set-configuration-parameters)
  + [5.4 Analyzing Galgo results](#analyzing-galgo-results)
    - [5.4.1 Pareto front](#pareto-front)
    - [5.4.2 Summary of the results](#summary-of-the-results)
    - [5.4.3 Select best performing solutions](#select-best-performing-solutions)
    - [5.4.4 Create prototypic centroids](#create-prototypic-centroids)
  + [5.5 Test Galgo signatures in a test set](#test-galgo-signatures-in-a-test-set)
    - [5.5.1 Classify train and test set into GSgalgoR subtypes](#classify-train-and-test-set-into-gsgalgor-subtypes)
    - [5.5.2 Calculate train and test set C.Index](#calculate-train-and-test-set-c.index)
    - [5.5.3 Calculate C.Index for training and test set using the prediction models](#calculate-c.index-for-training-and-test-set-using-the-prediction-models)
    - [5.5.4 Evaluate prediction survival of Galgo signatures](#evaluate-prediction-survival-of-galgo-signatures)
  + [5.6 Comparison of Galgo vs PAM50 classifier](#comparison-of-galgo-vs-pam50-classifier)
* [6 Session info](#session-info)

# 1 Overview

In the new era of omics data, precision medicine has become the new paradigm of
cancer treatment. Among all available omics techniques, gene expression
profiling, in particular, has been increasingly used to classify tumor subtypes
with different biological behavior. Cancer subtype discovery is usually
approached from two possible perspectives:

-Using the molecular data alone with unsupervised techniques such as clustering
analysis. -Using supervised techniques focusing entirely on survival data.

The problem of finding patients subgroups with survival differences while
maintaining cluster consistency could be viewed as a bi-objective problem, where
there is a trade-off between the separability of the different groups and the
ability of a given signature to consistently distinguish patients with different
clinical outcomes. This gives rise to a set of optimal solutions, also known as
Pareto-optimal solutions. To overcome these issues, we combined the advantages
of clustering methods for grouping heterogeneous omics data and the search
properties of genetic algorithms in GSgalgoR: A flexible yet robust
multi-objective meta-heuristic for disease subtype discovery based on an elitist
non-dominated sorting genetic algorithm (NSGA-II), driven by the underlying
premise of maximizing survival differences between groups while getting high
consistency and robustness of the clusters obtained.

# 2 Algorithm

In the GSgalgoR package, the NSGA-II framework was used for finding multiple
Pareto-optimal solutions to classify patients according to their gene expression
patterns. Basically, NSGA-II starts with a population of competing individuals
which are evaluated under a set of fitness functions that estimate the survival
differences and cohesiveness of the different transcriptomic groups. Then,
solutions are ranked and sorted according to their non-domination level which
will affect the way they are chosen to be submitted to the so-called
“evolutionary operators” such as crossover and mutation. Once a set of
well-suited solutions are selected and reproduced, a new offspring of
individuals composed of a mixture of the “genetic information” of the parents is
obtained. Parents and offspring are pooled and the best-ranked solutions are
selected and passed to the next generation which will start over the same
process again.

# 3 Installation

## 3.1 GSgalgoR library

To install GSgalgoR package, start R and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("GSgalgoR")
library(GSgalgoR)
```

Alternatively you can install GSgalgoR from github using the devtool package

```
devtools::install_github("https://github.com/harpomaxx/GSgalgoR")
library(GSgalgoR)
```

## 3.2 Examples datasets

To standardize the structure of genomic data, we use the
[ExpressionSet](https://www.bioconductor.org/packages/release/bioc/html/Biobase.html)
structure for the examples given in this guide. The `ExpressionSet` objects are
formed mainly by:

* A matrix of genetic expression, usually derived from microarray or RNAseq
  experiments. - Phenotypic data, where we find information on the samples
  (condition, status, treatment, survival, and other covariates). - Finally, these
  objects can also contain Annotations and feature Meta-data.

To start testing GSgalgoR, we will use two Breast Cancer datasets. Namely, the
[UPP](bioconductor.org/packages/release/data/experiment/html/breastCancerUPP.html)
and the
[TRANSBIG](bioconductor.org/packages/release/data/experiment/html/breastCancerTRANSBIG.html)
datasets. Additionally, we will use PAM50 centroids to perform breast cancer
sample classification. The datasets can be accessed from the following
[Bioconductor](https://bioconductor.org/) packages:

```
BiocManager::install("breastCancerUPP",version = "devel")
BiocManager::install("breastCancerTRANSBIG",version = "devel")
```

```
library(breastCancerTRANSBIG)
library(breastCancerUPP)
```

Also, some basic packages are needed to run the example in this vignette

```
library(GSgalgoR)
library(Biobase)
library(genefu)
library(survival)
library(survminer)
library(ggplot2)
data(pam50)
```

# 4 Examples

## 4.1 Loading data

To access the `ExpressionSets` we use:

```
data(upp)
Train<- upp
rm(upp)

data(transbig)
Test<- transbig
rm(transbig)

#To access gene expression data
train_expr<- exprs(Train)
test_expr<- exprs(Test)

#To access feature data
train_features<- fData(Train)
test_features<- fData(Test)

#To access clinical data
train_clinic <- pData(Train)
test_clinic <- pData(Test)
```

## 4.2 Data tidying and preparation

Galgo can accept any numeric data, like probe intensity from microarray
experiments or RNAseq normalized counts, nevertheless, features are expected to
be scaled across the dataset before being plugged in into the Galgo Framework.
For PAM50 classification, Gene Symbols are expected, so probesets are mapped
into their respective gene symbols. Probesets mapping for multiple genes are
expanded while Genes mapped to multiple probes are collapsed selecting the
probes with the highest variance for each duplicated gene.

### 4.2.1 Drop duplicates and NA’s

```
#Custom function to drop duplicated genes (keep genes with highest variance)

DropDuplicates<- function(eset, map= "Gene.symbol"){

    #Drop NA's
    drop <- which(is.na(fData(eset)[,map]))
    eset <- eset[-drop,]

    #Drop duplicates
    drop <- NULL
    Dup <- as.character(unique(fData(eset)[which(duplicated
            (fData(eset)[,map])),map]))
    Var <- apply(exprs(eset),1,var)
    for(j in Dup){
        pos <- which(fData(eset)[,map]==j)
        drop <- c(drop,pos[-which.max(Var[pos])])
    }

    eset <- eset[-drop,]

    featureNames(eset) <- fData(eset)[,map]
    return(eset)
}
```

### 4.2.2 Expand probesets that map for multiple genes

```
# Custom function to expand probesets mapping to multiple genes
expandProbesets <- function (eset, sep = "///", map="Gene.symbol"){
    x <- lapply(featureNames(eset), function(x) strsplit(x, sep)[[1]])
    y<- lapply(as.character(fData(eset)[,map]), function(x) strsplit(x,sep))
    eset <- eset[order(sapply(x, length)), ]
    x <- lapply(featureNames(eset), function(x) strsplit(x, sep)[[1]])
    y<- lapply(as.character(fData(eset)[,map]), function(x) strsplit(x,sep))
    idx <- unlist(sapply(1:length(x), function(i) rep(i,length(x[[i]]))))
    idy <- unlist(sapply(1:length(y), function(i) rep(i,length(y[[i]]))))
    xx <- !duplicated(unlist(x))
    idx <- idx[xx]
    idy <- idy[xx]
    x <- unlist(x)[xx]
    y <- unlist(y)[xx]
    eset <- eset[idx, ]
    featureNames(eset) <- x
    fData(eset)[,map] <- x
    fData(eset)$gene <- y
    return(eset)
}
```

```
Train=DropDuplicates(Train)
Train=expandProbesets(Train)
#Drop NAs in survival
Train <- Train[,!is.na(
    survival::Surv(time=pData(Train)$t.rfs,event=pData(Train)$e.rfs))]

Test=DropDuplicates(Test)
Test=expandProbesets(Test)
#Drop NAs in survival
Test <-
    Test[,!is.na(survival::Surv(
        time=pData(Test)$t.rfs,event=pData(Test)$e.rfs))]

#Determine common probes (Genes)
Int= intersect(rownames(Train),rownames(Test))

Train= Train[Int,]
Test= Test[Int,]

identical(rownames(Train),rownames(Test))
#> [1] TRUE
```

For simplicity and speed, we will create a reduced expression matrix for the
examples.

```
#First we will get PAM50 centroids from genefu package

PAM50Centroids <- pam50$centroids
PAM50Genes <- pam50$centroids.map$probe
PAM50Genes<- featureNames(Train)[ featureNames(Train) %in% PAM50Genes]

#Now we sample 200 random genes from expression matrix

Non_PAM50Genes<- featureNames(Train)[ !featureNames(Train) %in% PAM50Genes]
Non_PAM50Genes <- sample(Non_PAM50Genes,200, replace=FALSE)

reduced_set <- c(PAM50Genes, Non_PAM50Genes)

#Now we get the reduced training and test sets

Train<- Train[reduced_set,]
Test<- Test[reduced_set,]
```

### 4.2.3 Rescale expression matrix

Apply robust linear scaling as proposed in
[paper reference](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3283537/#bib61)

```
exprs(Train) <- t(apply(exprs(Train),1,genefu::rescale,na.rm=TRUE,q=0.05))
exprs(Test) <- t(apply(exprs(Test),1,genefu::rescale,na.rm=TRUE,q=0.05))

train_expr <- exprs(Train)
test_expr <- exprs(Test)
```

### 4.2.4 Survival Object

The ‘Surv’ object is created by the Surv() function of the survival package.
This uses phenotypic data that are contained in the corresponding datasets,
accessed by the `pData` command.

```
train_clinic <- pData(Train)
test_clinic <- pData(Test)

train_surv <- survival::Surv(time=train_clinic$t.rfs,event=train_clinic$e.rfs)
test_surv <- survival::Surv(time=test_clinic$t.rfs,event=test_clinic$e.rfs)
```

## 4.3 Run galgo()

The main function in this package is `galgo()`. It accepts an expression matrix
and survival object to find robust gene expression signatures related to a given
outcome. This function contains some parameters that can be modified, according
to the characteristics of the analysis to be performed.

### 4.3.1 Setting parameters

The principal parameters are:

* population: a number indicating the number of solutions in the population of
  solutions that will be evolved
* generations: a number indicating the number of iterations of the galgo
  algorithm
* nCV: number of cross-validation sets
* distancetype: character, it can be ‘pearson’ (centered pearson), ‘uncentered’
  (uncentered pearson), ‘spearman’ or ‘euclidean’
* TournamentSize: a number indicating the size of the tournaments for the
  selection procedure
* period: a number indicating the outcome period to evaluate the RMST

```
# For testing reasons it is set to a low number but ideally should be above 100
population <- 30
# For testing reasons it is set to a low number but ideally should be above 150
generations <-15
nCV <- 5
distancetype <- "pearson"
TournamentSize <- 2
period <- 3650
```

### 4.3.2 Run Galgo algorithm

```
set.seed(264)
output <- GSgalgoR::galgo(generations = generations,
                        population = population,
                        prob_matrix = train_expr,
                        OS = train_surv,
                        nCV = nCV,
                        distancetype = distancetype,
                        TournamentSize = TournamentSize,
                        period = period)
```

```
print(class(output))
#> [1] "galgo.Obj"
#> attr(,"package")
#> [1] "GSgalgoR"
```

### 4.3.3 Galgo Object

The output of the galgo() function is an object of type `galgo.Obj` that has two
slots with the elements:

* Solutions
* ParetoFront.

#### 4.3.3.1 Solutions

Is a l x (n + 5) matrix where n is the number of features evaluated and l is the
number of solutions obtained.

* The submatrix l x n is a binary matrix where each row represents the
  chromosome of an evolved solution from the solution population, where each
  feature can be present (1) or absent (0) in the solution.
* Column n+1 represent the k number of clusters for each solutions
* Column n+2 shows the SC Fitness
* Column n+3 represent Survival Fitness values
* Column n+4 shows the solution rank
* Column n+5 represent the crowding distance of the solution in the final pareto
  front

#### 4.3.3.2 ParetoFront

Is a list of length equal to the number of generations run in the algorithm.
Each element is a l x 2 matrix where l is the number of solutions obtained and
the columns are the SC Fitness and the Survival Fitness values respectively.

For easier interpretation of the `galgo.Obj`, the output can be transformed to a
`list` or to a `data.frame` objects.

## 4.4 to\_list() function

This function restructurates a `galgo.Obj` to a more easy to understand an use
list. This output is particularly useful if one wants to select a given solution
and use its outputs in a new classifier. The output of type list has a length
equals to the number of solutions obtained by the galgo algorithm.

Basically this output is a list of lists, where each element of the output is
named after the solution’s name (solution.n, where n is the number assigned to
that solution), and inside of it, it has all the constituents for that given
solution with the following structure:

* solution.n$Genes: A vector of the features included in the solution
* solution.n$k: The number of partitions found in that solution
* solution.n$SC.Fit: The average silhouette coefficient of the partitions found
* solution.n$Surv.Fit: The survival fitnes value
* solution.n$Rank: The solution rank
* CrowD: The solution crowding distance related to the rest of the solutions

```
outputList <- to_list(output)
head(names(outputList))
#> [1] "Solution.1" "Solution.2" "Solution.3" "Solution.4" "Solution.5"
#> [6] "Solution.6"
```

To evaluate the structure of the first solution we can run:

```
outputList[["Solution.1"]]
#> $Genes
#>   [1] "PHGDH"        "KRT5"         "RRM2"         "SLC39A6"      "BIRC5"
#>   [6] "MYC"          "CDC20"        "UBE2C"        "CDH3"         "PTTG1"
#>  [11] "BCL2"         "MMP11"        "CDC6"         "EXO1"         "MELK"
#>  [16] "KRT17"        "ESR1"         "MIA"          "CENPF"        "PGR"
#>  [21] "KRT14"        "GRB7"         "ERBB2"        "FGFR4"        "MKI67"
#>  [26] "FOXC1"        "NAT1"         "TYMS"         "MLPH"         "CEP55"
#>  [31] "ACTR3B"       "ORC6L"        "CCNB1"        "BLVRA"        "BAG1"
#>  [36] "FOXA1"        "MDM2"         "H2AFB2"       "TEP1"         "HBBP1"
#>  [41] "FXYD7"        "CAPG"         "FEZ2"         "ZNF814"       "ANKRD11"
#>  [46] "TMBIM6"       "CDH19"        "RS1"          "SEC61A2"      "CD180"
#>  [51] "EPS15L1"      "OR51E2"       "SCG3"         "ZNF692"       "GPN2"
#>  [56] "RPS19"        "SRSF8"        "RAB5B"        "RPL18AP6"     "RFC2"
#>  [61] "MBNL2"        "NPVF"         "SLC31A1"      "PFDN2"        "RAD51C"
#>  [66] "CYB5R2"       "LAPTM5"       "ANXA8L2"      "VARS"         "PPAP2B"
#>  [71] "COL13A1"      "VCAM1"        "C1RL"         "NUDT9"        "SLC17A1"
#>  [76] "SOCS3"        "WDR19"        "PFDN6"        "SUSD4"        "UBA2"
#>  [81] "ENY2"         "PFN2"         "NUP54"        "GZMK"         "ZNF212"
#>  [86] "RAD21"        "ARMCX1"       "NFYA"         "HSPB3"        "LDHAL6B"
#>  [91] "CES4"         "SLC38A3"      "AVPR1A"       "INADL"        "COIL"
#>  [96] "TRY6"         "FAF1"         "SATB1"        "JRKL"         "STAG3L4"
#> [101] "ZMIZ2"        "HARS2"        "PCGF1"        "LOC100131509" "CD4"
#> [106] "PABPC1P4"     "SMARCC2"      "MAN1A1"       "CPSF1"        "PGK1"
#> [111] "AURKB"        "GTF3C1"       "OPN3"         "FRG1B"        "LOC100131613"
#> [116] "CCND2"        "ARHGDIG"      "FUCA1"        "SLC47A1"      "PDSS1"
#> [121] "CPSF7"        "SERPINC1"     "CLIC5"        "MORF4L1"      "CASC5"
#> [126] "ACOT1"        "FDFT1"        "TRIM36"       "TSNAX"        "FBXL12"
#> [131] "PML"          "BEX4"         "MEPE"         "NOS2"         "PIKFYVE"
#> [136] "ZC3HAV1"      "EIF3M"        "MAP3K8"       "TOX3"         "SHPK"
#> [141] "C14orf135"    "FBXW2"        "GSN"          "KIT"          "SPI1"
#> [146] "HIST2H2AA4"   "NCAPD2"       "LOC390998"    "ACTR3P1"      "F11R"
#> [151] "ALX1"         "SLC35A5"      "CEP68"        "SLK"          "CDR2L"
#> [156] "SIM1"         "RBM15"        "CD3G"         "SLC16A5"      "KIAA0586"
#> [161] "SNAPC5"       "H1FX"         "MCF2L2"       "NOTCH3"       "TRPC5"
#> [166] "SLC13A1"      "NDUFB1"       "LOC442421"    "ITGA5"        "ZXDA"
#> [171] "KCNK2"        "SLC18A2"      "GRM6"         "PID1"         "SAMM50"
#> [176] "MAPKBP1"      "ORAI3"        "CXCL3"        "REPS1"        "OR1G1"
#> [181] "FAM173A"      "MSI1"         "PDCL"         "LOC653166"    "NUP153"
#> [186] "TESK2"        "ISYNA1"       "FNDC8"        "ASMT"         "PSMD9"
#> [191] "ATP5H"        "C22orf28"     "C14orf101"    "TARDBP"       "MAGEA9"
#> [196] "WIT1"         "MEGF9"        "LOC100128414" "PCDHGA6"      "KITLG"
#> [201] "CYP3A7"       "C9orf144"     "PTPN22"       "UCHL5"        "NPHS1"
#> [206] "CALU"         "CBLB"         "LOC731884"    "DEFB1"        "BRP44"
#> [211] "BEGAIN"       "RPS4XP7"
#>
#> $k
#> [1] 9
#>
#> $SC.Fit
#> [1] 0.02990057
#>
#> $Surv.Fit
#> [1] 821.8484
#>
#> $rank
#> [1] 1
#>
#> $CrowD
#> [1] Inf
```

## 4.5 to\_dataframe() function

The current function restructures a `galgo.Obj` to a more easy to understand
an use `data.frame`. The output data frame has m x n dimensions, were the
rownames (m) are the solutions obtained by the galgo algorithm. The columns has
the following structure:

* Genes: The features included in each solution in form of a list
* k: The number of partitions found in that solution
* SC.Fit: The average silhouette coefficient of the partitions found
* Surv.Fit: The survival fitness value
* Rank: The solution rank
* CrowD: The solution crowding distance related to the rest of the solutions

```
outputDF <- to_dataframe(output)
head(outputDF)
#>                    Genes k     SC.Fit Surv.Fit Rank     CrowD
#> Solutions.1 PHGDH, K.... 9 0.02990057 821.8484    1       Inf
#> Solutions.2 UBE2C, C.... 2 0.21266769 443.1795    1       Inf
#> Solutions.3 MYBL2, E.... 4 0.07378799 745.3619    1 0.7847555
#> Solutions.4 CDH3, PT.... 2 0.14895212 637.6258    1 0.6133874
#> Solutions.5 CDH3, PT.... 2 0.17492261 528.7644    1 0.4087623
#> Solutions.6 SLC39A6,.... 2 0.16904364 609.8327    1 0.2551413
```

## 4.6 plot\_pareto()

Once we obtain the `galgo.obj` from the output of `galgo()` we can plot the
obtained Pareto front and see how it evolved trough the tested number of
generations

```
plot_pareto(output)
```

![](data:image/png;base64...)![](data:image/png;base64...)

# 5 Case study

Breast cancer (BRCA) is the most common neoplasm in women to date and one of the
best studied cnacer types. Currently, numerous molecular alteration for this
type of cancer are well known and many transcriptomic signatures have been
developed for this type of cancer. In this regards, [Perou et
al.](https://pubmed.ncbi.nlm.nih.gov/10963602/) proposed one of the first
molecular subtype classification according to transcriptomic profiles of the
tumor, which recapitulates naturally-occurring gene expression patterns that
encompass different functional pathways and patient outcomes. These subtypes,
(LumA, LumB, Basal-like, HER2 and Normal-Like) have a strong overlap with the
classical histopathological classification of BRCA tumors and might affect
decision making when used to decided chemotherapy in certain cases.

## 5.1 Data Preprocessing

To evaluate Galgo’s performance along with PAM50 classification, we will use the
two already scaled and reduced BRCA gene expression datasets and will compare
Galgo performance with the widely used intrinsic molecular subtype PAM50
classification. Galgo performs feature selection by design, so this step is not
strictly necessary to use galgoR (although feature selection might fasten
GSgalgoRruns), nevertheless, appropriate gene expression scaling is critical
when running GSgalgoR.

## 5.2 Breast cancer classification

The scaled expression values of each patient are compared with the prototypical
centroids using Pearson’s correlation coefficient and the closest centroid to
each patient is used to assign the corresponding labels.

```
#The reduced UPP dataset will be used as training set
train_expression <- exprs(Train)
train_clinic<- pData(Train)
train_features<- fData(Train)
train_surv<- survival::Surv(time=train_clinic$t.rfs,event=train_clinic$e.rfs)

#The reduced TRANSBIG dataset will be used as test set

test_expression <- exprs(Test)
test_clinic<- pData(Test)
test_features<- fData(Test)
test_surv<- survival::Surv(time=test_clinic$t.rfs,event=test_clinic$e.rfs)

#PAM50 centroids
centroids<- pam50$centroids
#Extract features from both data.frames
inBoth<- Reduce(intersect, list(rownames(train_expression),rownames(centroids)))

#Classify samples

PAM50_train<- cluster_classify(train_expression[inBoth,],centroids[inBoth,],
                            method = "spearman")
table(PAM50_train)
#> PAM50_train
#>  1  2  3  4  5
#> 22 30 94 73 15

PAM50_test<- cluster_classify(test_expression[inBoth,],centroids[inBoth,],
                            method = "spearman")
table(PAM50_test)
#> PAM50_test
#>  1  2  3  4  5
#> 45 26 80 44  3

# Classify samples using genefu
#annot<- fData(Train)
#colnames(annot)[3]="Gene.Symbol"
#PAM50_train<- molecular.subtyping(sbt.model = "pam50",
#         data = t(train_expression), annot = annot,do.mapping = TRUE)
```

Once the patients are classified according to their closest centroids, we can
now evaluate the survival curves for the different types in each of the datasets

### 5.2.1 Survival of UPP patients

```
surv_formula <-
    as.formula("Surv(train_clinic$t.rfs,train_clinic$e.rfs)~ PAM50_train")
tumortotal1 <- surv_fit(surv_formula,data=train_clinic)
tumortotal1diff <- survdiff(surv_formula)
tumortotal1pval<- pchisq(tumortotal1diff$chisq, length(tumortotal1diff$n) - 1,
                         lower.tail = FALSE)

p<-ggsurvplot(tumortotal1,
            data=train_clinic,
            risk.table=TRUE,
            pval=TRUE,
            palette="dark2",
            title="UPP breast cancer \n PAM50 subtypes survival",
            surv.scale="percent",
            conf.int=FALSE,
            xlab="time (days)",
            ylab="survival(%)",
            xlim=c(0,3650),
            break.time.by = 365,
            ggtheme = theme_minimal(),
            risk.table.y.text.col = TRUE,
            risk.table.y.text = FALSE,censor=FALSE)
print(p)
```

![](data:image/png;base64...)

### 5.2.2 Survival of TRANSBIG patients

```
surv_formula <-
    as.formula("Surv(test_clinic$t.rfs,test_clinic$e.rfs)~ PAM50_test")
tumortotal2 <- surv_fit(surv_formula,data=test_clinic)
tumortotal2diff <- survdiff(surv_formula)
tumortotal2pval<- pchisq(tumortotal2diff$chisq, length(tumortotal2diff$n) - 1,
                        lower.tail = FALSE)

p<-ggsurvplot(tumortotal2,
            data=test_clinic,
            risk.table=TRUE,
            pval=TRUE,
            palette="dark2",
            title="TRANSBIG breast cancer \n PAM50 subtypes survival",
            surv.scale="percent",
            conf.int=FALSE,
            xlab="time (days)",
            ylab="survival(%)",
            xlim=c(0,3650),
            break.time.by = 365,
            ggtheme = theme_minimal(),
            risk.table.y.text.col = TRUE,
            risk.table.y.text = FALSE,
            censor=FALSE)
print(p)
```

![](data:image/png;base64...)

## 5.3 Find breast cancer gene signatures with GSgalgoR

Now we run Galgo to find cohesive and clinically meaningful signatures for BRCA
using UPP data as training set and TRANSBIG data as test set

### 5.3.1 Set configuration parameters

```
population <- 15
generations <-5
nCV <- 5
distancetype <- "pearson"
TournamentSize <- 2
period <- 3650
```

Run Galgo on the training set

```
output= GSgalgoR::galgo(generations = generations,
                    population = population,
                    prob_matrix = train_expression,
                    OS=train_surv,
                    nCV= nCV,
                    distancetype=distancetype,
                    TournamentSize=TournamentSize,
                    period=period)
print(class(output))
```

## 5.4 Analyzing Galgo results

### 5.4.1 Pareto front

```
plot_pareto(output)
```

![](data:image/png;base64...)![](data:image/png;base64...)

### 5.4.2 Summary of the results

```
output_df<- to_dataframe(output)
NonDom_solutions<- output_df[output_df$Rank==1,]

# N of non-dominated solutions
nrow(NonDom_solutions)
#> [1] 8

# N of partitions found
table(NonDom_solutions$k)
#>
#>  2  3  4  6  9 10
#>  2  1  1  1  1  2

#Average N of genes per signature
mean(unlist(lapply(NonDom_solutions$Genes,length)))
#> [1] 133.5

#SC range
range(NonDom_solutions$SC.Fit)
#> [1] 0.001589647 0.108184025

# Survival fitnesss range
range(NonDom_solutions$Surv.Fit)
#> [1]  298.581 1015.770
```

### 5.4.3 Select best performing solutions

Now we select the best performing solutions for each number of partitions (k)
according to C.Index

```
RESULT<- non_dominated_summary(output=output,
                            OS=train_surv,
                            prob_matrix= train_expression,
                            distancetype =distancetype
                            )

best_sol=NULL
for(i in unique(RESULT$k)){
    best_sol=c(
    best_sol,
    RESULT[RESULT$k==i,"solution"][which.max(RESULT[RESULT$k==i,"C.Index"])])
}

print(best_sol)
#> [1] "Solutions.1" "Solutions.6" "Solutions.3" "Solutions.4" "Solutions.7"
#> [6] "Solutions.8"
```

### 5.4.4 Create prototypic centroids

Now we create the prototypic centroids of the selected solutions

```
CentroidsList <- create_centroids(output,
                                solution_names = best_sol,
                                trainset = train_expression)
```

## 5.5 Test Galgo signatures in a test set

We will test the Galgo signatures found with the UPP training set in an
independent test set (TRANSBIG)

### 5.5.1 Classify train and test set into GSgalgoR subtypes

```
train_classes<- classify_multiple(prob_matrix=train_expression,
                                centroid_list= CentroidsList,
                                distancetype = distancetype)

test_classes<- classify_multiple(prob_matrix=test_expression,
                                centroid_list= CentroidsList,
                                distancetype = distancetype)
```

### 5.5.2 Calculate train and test set C.Index

To calculate the train and test C.Index, the risk coefficients are calculated
for each subclass in the training set and then are used to predict the risk of
the different groups in the test set. This is particularly important for
signatures with high number of partitions, were the survival differences of
different groups might overlap and change their relative order, which is of
great importance in the C.Index calculation.

```
Prediction.models<- list()

for(i in best_sol){

    OS<- train_surv
    predicted_class<- as.factor(train_classes[,i])
    predicted_classdf <- as.data.frame(predicted_class)
    colnames(predicted_classdf)<- i
    surv_formula <- as.formula(paste0("OS~ ",i))
    coxsimple=coxph(surv_formula,data=predicted_classdf)
    Prediction.models[[i]]<- coxsimple
}
```

### 5.5.3 Calculate C.Index for training and test set using the prediction models

```
C.indexes<- data.frame(train_CI=rep(NA,length(best_sol)),
                    test_CI=rep(NA,length(best_sol)))
rownames(C.indexes)<- best_sol

for(i in best_sol){
    predicted_class_train<- as.factor(train_classes[,i])
    predicted_class_train_df <- as.data.frame(predicted_class_train)
    colnames(predicted_class_train_df)<- i
    CI_train<-
        concordance.index(predict(Prediction.models[[i]],
                                predicted_class_train_df),
                                surv.time=train_surv[,1],
                                surv.event=train_surv[,2],
                                outx=FALSE)$c.index
    C.indexes[i,"train_CI"]<- CI_train
    predicted_class_test<- as.factor(test_classes[,i])
    predicted_class_test_df <- as.data.frame(predicted_class_test)
    colnames(predicted_class_test_df)<- i
    CI_test<-
        concordance.index(predict(Prediction.models[[i]],
                                predicted_class_test_df),
                                surv.time=test_surv[,1],
                                surv.event=test_surv[,2],
                                outx=FALSE)$c.index
    C.indexes[i,"test_CI"]<- CI_test
    }

print(C.indexes)
#>              train_CI   test_CI
#> Solutions.1 0.5742514 0.5371203
#> Solutions.6 0.6512249 0.5434320
#> Solutions.3 0.6116040 0.5978304
#> Solutions.4 0.6456296 0.5724260
#> Solutions.7 0.6231979 0.5672978
#> Solutions.8 0.6505696 0.5724260

best_signature<- best_sol[which.max(C.indexes$test_CI)]

print(best_signature)
#> [1] "Solutions.3"
```

### 5.5.4 Evaluate prediction survival of Galgo signatures

We test best galgo signature with training and test sets

```
train_class <- train_classes[,best_signature]

surv_formula <-
    as.formula("Surv(train_clinic$t.rfs,train_clinic$e.rfs)~ train_class")
tumortotal1 <- surv_fit(surv_formula,data=train_clinic)
tumortotal1diff <- survdiff(surv_formula)
tumortotal1pval<- pchisq(tumortotal1diff$chisq,
                        length(tumortotal1diff$n) - 1,
                        lower.tail = FALSE)

p<-ggsurvplot(tumortotal1,
            data=train_clinic,
            risk.table=TRUE,pval=TRUE,palette="dark2",
            title="UPP breast cancer \n Galgo subtypes survival",
            surv.scale="percent",
            conf.int=FALSE, xlab="time (days)",
            ylab="survival(%)", xlim=c(0,3650),
            break.time.by = 365,
            ggtheme = theme_minimal(),
            risk.table.y.text.col = TRUE,
            risk.table.y.text = FALSE,censor=FALSE)
print(p)
```

![](data:image/png;base64...)

```
test_class <- test_classes[,best_signature]

surv_formula <-
    as.formula("Surv(test_clinic$t.rfs,test_clinic$e.rfs)~ test_class")
tumortotal1 <- surv_fit(surv_formula,data=test_clinic)
tumortotal1diff <- survdiff(surv_formula)
tumortotal1pval<- pchisq(tumortotal1diff$chisq,
                        length(tumortotal1diff$n) - 1,
                        lower.tail = FALSE)

p<-ggsurvplot(tumortotal1,
            data=test_clinic,
            risk.table=TRUE,
            pval=TRUE,palette="dark2",
            title="TRANSBIG breast cancer \n Galgo subtypes survival",
            surv.scale="percent",
            conf.int=FALSE,
            xlab="time (days)",
            ylab="survival(%)",
            xlim=c(0,3650),
            break.time.by = 365,
            ggtheme = theme_minimal(),
            risk.table.y.text.col = TRUE,
            risk.table.y.text = FALSE,
            censor=FALSE)
print(p)
```

![](data:image/png;base64...)

## 5.6 Comparison of Galgo vs PAM50 classifier

Compare PAM50 classification vs Galgo classification in the TRANSBIG (test)
dataset

```
surv_formula1 <-
    as.formula("Surv(test_clinic$t.rfs,test_clinic$e.rfs)~ test_class")
tumortotal1 <- surv_fit(surv_formula1,data=test_clinic)
tumortotal1diff <- survdiff(surv_formula1)
tumortotal1pval<- pchisq(tumortotal1diff$chisq,
                        length(tumortotal1diff$n) - 1,
                        lower.tail = FALSE)

surv_formula2 <-
    as.formula("Surv(test_clinic$t.rfs,test_clinic$e.rfs)~ PAM50_test")
tumortotal2 <- surv_fit(surv_formula2,data=test_clinic)
tumortotal2diff <- survdiff(surv_formula2)
tumortotal2pval<- pchisq(tumortotal1diff$chisq,
                        length(tumortotal2diff$n) - 1,
                        lower.tail = FALSE)

SURV=list(GALGO=tumortotal1,PAM50=tumortotal2 )
COLS=c(1:8,10)
par(cex=1.35, mar=c(3.8, 3.8, 2.5, 2.5) + 0.1)
p=ggsurvplot(SURV,
            combine=TRUE,
            data=test_clinic,
            risk.table=TRUE,
            pval=TRUE,
            palette="dark2",
            title="Galgo vs. PAM50 subtypes \n BRCA survival comparison",
            surv.scale="percent",
            conf.int=FALSE,
            xlab="time (days)",
            ylab="survival(%)",
            xlim=c(0,period),
            break.time.by = 365,
            ggtheme = theme_minimal(),
            risk.table.y.text.col = TRUE,
            risk.table.y.text = FALSE,
            censor=FALSE)
print(p)
```

![](data:image/png;base64...)

# 6 Session info

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#>  [1] survminer_0.5.1             ggpubr_0.6.2
#>  [3] ggplot2_4.0.0               genefu_2.42.0
#>  [5] AIMS_1.42.0                 e1071_1.7-16
#>  [7] iC10_2.0.2                  biomaRt_2.66.0
#>  [9] survcomp_1.60.0             prodlim_2025.04.28
#> [11] survival_3.8-3              Biobase_2.70.0
#> [13] BiocGenerics_0.56.0         generics_0.1.4
#> [15] GSgalgoR_1.20.0             breastCancerUPP_1.47.0
#> [17] breastCancerTRANSBIG_1.47.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3     jsonlite_2.0.0         magrittr_2.0.4
#>   [4] magick_2.9.0           SuppDists_1.1-9.9      farver_2.1.2
#>   [7] rmarkdown_2.30         vctrs_0.6.5            memoise_2.0.1
#>  [10] tinytex_0.57           rstatix_0.7.3          htmltools_0.5.8.1
#>  [13] progress_1.2.3         curl_7.0.0             broom_1.0.10
#>  [16] Formula_1.2-5          sass_0.4.10            parallelly_1.45.1
#>  [19] KernSmooth_2.23-26     bslib_0.9.0            httr2_1.2.1
#>  [22] impute_1.84.0          zoo_1.8-14             cachem_1.1.0
#>  [25] lifecycle_1.0.4        iterators_1.0.14       pkgconfig_2.0.3
#>  [28] Matrix_1.7-4           R6_2.6.1               fastmap_1.2.0
#>  [31] future_1.67.0          digest_0.6.37          AnnotationDbi_1.72.0
#>  [34] S4Vectors_0.48.0       nsga2R_1.1             RSQLite_2.4.3
#>  [37] filelock_1.0.3         labeling_0.4.3         km.ci_0.5-6
#>  [40] httr_1.4.7             abind_1.4-8            compiler_4.5.1
#>  [43] proxy_0.4-27           bit64_4.6.0-1          withr_3.0.2
#>  [46] doParallel_1.0.17      S7_0.2.0               backports_1.5.0
#>  [49] carData_3.0-5          DBI_1.2.3              ggsignif_0.6.4
#>  [52] lava_1.8.1             rappdirs_0.3.3         tools_4.5.1
#>  [55] iC10TrainingData_2.0.1 future.apply_1.20.0    bootstrap_2019.6
#>  [58] glue_1.8.0             gridtext_0.1.5         grid_4.5.1
#>  [61] cluster_2.1.8.1        gtable_0.3.6           KMsurv_0.1-6
#>  [64] class_7.3-23           tidyr_1.3.1            data.table_1.17.8
#>  [67] hms_1.1.4              xml2_1.4.1             car_3.1-3
#>  [70] XVector_0.50.0         foreach_1.5.2          pillar_1.11.1
#>  [73] stringr_1.5.2          limma_3.66.0           splines_4.5.1
#>  [76] ggtext_0.1.2           dplyr_1.1.4            BiocFileCache_3.0.0
#>  [79] lattice_0.22-7         bit_4.6.0              tidyselect_1.2.1
#>  [82] Biostrings_2.78.0      knitr_1.50             gridExtra_2.3
#>  [85] bookdown_0.45          IRanges_2.44.0         Seqinfo_1.0.0
#>  [88] pamr_1.57              stats4_4.5.1           xfun_0.53
#>  [91] statmod_1.5.1          stringi_1.8.7          yaml_2.3.10
#>  [94] evaluate_1.0.5         codetools_0.2-20       tibble_3.3.0
#>  [97] BiocManager_1.30.26    cli_3.6.5              survivalROC_1.0.3.1
#> [100] xtable_1.8-4           jquerylib_0.1.4        survMisc_0.5.6
#> [103] dichromat_2.0-0.1      Rcpp_1.1.0             rmeta_3.0
#> [106] globals_0.18.0         dbplyr_2.5.1           png_0.1-8
#> [109] parallel_4.5.1         mco_1.17               blob_1.2.4
#> [112] prettyunits_1.2.0      mclust_6.1.1           listenv_0.9.1
#> [115] scales_1.4.0           purrr_1.1.0            crayon_1.5.3
#> [118] rlang_1.1.6            KEGGREST_1.50.0
```