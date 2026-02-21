# GOpro: Determine groups of genes and find their most characteristic GO term

Lidia Chrabaszcz

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Loading](#loading)
* [3 Overview](#overview)
* [4 Details](#details)
  + [4.1 Determining significantly different genes based on their expressions](#determining-significantly-different-genes-based-on-their-expressions)
  + [4.2 Grouping genes based on their similarity](#grouping-genes-based-on-their-similarity)
    - [4.2.1 All pairwise comparisons by Tukey’s test](#all-pairwise-comparisons-by-tukeys-test)
    - [4.2.2 Hierarchical clustering](#hierarchical-clustering)
  + [4.3 Finding characteristic gene ontology terms](#finding-characteristic-gene-ontology-terms)
* [5 Data](#data)
* [6 Example](#example)

# 1 Installation

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("GOpro", dependencies = TRUE)
```

# 2 Loading

After the package is installed, it can be loaded into R workspace typing

```
library(GOpro)
```

# 3 Overview

This document presents an overview of the GOpro package.
This package is for determining groups of genes and finding characteristic
functions for these groups. It allows for interpreting groups of genes by their
most characteristic biological function. It provides one function *findGO*
which is based on the set of methods. One of these methods allows for determining
significantly different genes between at least two distinct groups
(i.e. patients with different medical condition) - the ANOVA test with
correction for multiple testing. It also provides two methods for grouping
genes. One of them is so-called all pairwise comparisons
utilizing Tukey’s method. By this method profiles of genes are determined,
i.e. in terms of the gene expression genes are grouped according to the
differences in the expressions between given cohorts.
Another method of grouping is hierarchical
clustering. This package provides a method for finding the most characteristic
gene ontology terms for anteriorly obtained groups using the
one-sided Fisher’s test for overrepresentation of the gene ontology term.
If genes were grouped by the hierarchical clustering, then the most characteristic
function is
found for all possible groups (for each node in the dendrogram).

# 4 Details

Genes must be named with the gene aliases and they must be
arranged in the same order for each cohort.

## 4.1 Determining significantly different genes based on their expressions

Genes which are statistically differently expressed are selected for the
further analysis by ANOVA test.
The *topAOV* parameter denotes the maximum number of significantly
different genes
to be selected. The significance level of ANOVA test is specified
by the *sig.levelAOV* parameter.
This threshold is used as the significance level in the BH correction
for multiple testing.
In the case of equal p-values of the test (below the given threshold),
all genes for which the p-value of the test is the same as for the gene
numbered with the *topAOV* value are included in the result.

## 4.2 Grouping genes based on their similarity

There are two methods provided for grouping genes. They are
specified by the *grouped* parameter. The first one using
Tukey’s test is called when *grouped* equals *‘tukey’* and the
second one can be called by using the *‘clustering’* value.

### 4.2.1 All pairwise comparisons by Tukey’s test

The Tukey’s test is applied to group genes based on their profiles.
The *sig.levelTUK* parameter denotes the significance level of Tukey’s test.
For each gene two-sided Tukey’s test is conducted among cohorts.
The mean expressions in the cohorts are arranged in
ascending order and the result of the test is adapted. All genes with
the same order of means and the same result of the test are grouped together.
I.e. notation *colon=bladder<leukemia* denotes that the mean expression
calculated for a
particular gene in the colon cancer cohort is statistically the same as for the
bladder cancer cohort. Both mean values determined for aforementioned cohorts are
statistically lower than the mean expression measured for the leukemia cohort.

### 4.2.2 Hierarchical clustering

Hierarchical clustering is utilized for grouping genes based on dissimilarity
measures. In this case all clusters are subjected to the further analysis.
The *clust.metric* parameter is a method to calculate a distance measure
between genes, the *clust.method* is the agglomeration method used to cluster genes,
and the *dist.matrix* is an optional parameter for distance matrix if available
*clust.metric*
methods are not sufficient for the user.

## 4.3 Finding characteristic gene ontology terms

For each specified group the *org.Hs.eg.db* is searched for all relevant
GO terms. The number of counts of each GO term is calculated for each group.
Then the Fisher’s test is applied in order to find the most characteristic GO terms
for each group of genes.
The *minGO* and *maxGO* parameters denote the range of
counts of genes annotated with each GO term. All GO terms with
counts above or below this range are omitted in the analysis. It enables for the
exclusion of very rare or very common gene ontology terms.
Gene ontology domains to be searched for GO terms can be specified by the *onto*
parameter. Possible domains are: *‘MF’* (molecular function),
*‘BP’* (biological process), and *‘CC’* (cellular component).
The *sig.levelGO* parameter specifies the significance level of the Fisher’s test
(correction for multiple testing is included).

# 5 Data

Data used in this example comes from
[The Cancer Genome Atlas](https://tcga-data.nci.nih.gov/tcga/).
They were downloaded via RTCGA.PANCAN12 package. The data represents
expressions of 300 genes randomly chosen from 16115 genes determined
for each patient (sample). Three cohorts are
included: acute myleoid leukemia, colon cancer, and bladder cancer.
The data is stored in this *GOpro* package as a MultiAssayExperiment
object.

An example of the data structure:

```
exrtcga
```

```
## A MultiAssayExperiment object of 3 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 3:
##  [1] leukemia: matrix with 300 rows and 173 columns
##  [2] colon: matrix with 300 rows and 190 columns
##  [3] bladder: matrix with 300 rows and 122 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

# 6 Example

To run the analysis with default parameters on the exrtcga object call:

```
findGO(exrtcga)
```

```
## DataFrame with 7 rows and 4 columns
##                                       profile                              GOs
##                                        <list>                           <list>
## bladder=colon<leukemia bladder=colon<leukemia                       GO:0003779
## colon<bladder<leukemia colon<bladder<leukemia GO:0006357,GO:0043565,GO:0006821
## colon=bladder<leukemia colon=bladder<leukemia
## leukemia<bladder<colon leukemia<bladder<colon GO:0005759,GO:0005739,GO:0007605
## leukemia<bladder=colon leukemia<bladder=colon            GO:0005811,GO:0016616
## leukemia<colon<bladder leukemia<colon<bladder
## leukemia<colon=bladder leukemia<colon=bladder
##                                 p.values                  GENES
##                                   <list>                 <list>
## bladder=colon<leukemia             0.025           FAM46A WASF2
## colon<bladder<leukemia 0.001,0.001,0.001 ARID2 BPTF CCDC88A C..
## colon=bladder<leukemia                NA          DENND4B RCOR3
## leukemia<bladder<colon 0.000,0.001,0.007 AK1 BRI3 CCDC51 CD24..
## leukemia<bladder=colon       0.003,0.003             NSDHL PFKM
## leukemia<colon<bladder                NA BOLA1 EDF1 NDUFA1 NE..
## leukemia<colon=bladder                NA               NA NA NA
```

The results of the analysis can be presented in a more descriptive
way or in a concise one. To get more descriptive results use *extend=TRUE*
option.
Additionally, the *TERM*, *DEFINITION*, and *ONTOLOGY* for each ontology
term are returned.

```
findGO(exrtcga, extend = TRUE)
```

```
## DataFrame with 1 row and 5 columns
##           GROUP                                 GOID
##   <IntegerList>                      <CharacterList>
## 1     1,2,2,... GO:0003779,GO:0006357,GO:0043565,...
##                                                              TERM
##                                                   <CharacterList>
## 1 actin binding,regulation of transc..,sequence-specific DN..,...
##                                                                 DEFINITION
##                                                            <CharacterList>
## 1 Binding to monomeric..,Any process that mod..,Binding to DNA of a ..,...
##          ONTOLOGY
##   <CharacterList>
## 1    MF,BP,MF,...
```

In order to find top 2 GO terms for genes grouped by hierarchical clustering
run the following call. The result of clustering is
presented on the plot.

```
findGO(exrtcga, topGO = 2, grouped = 'clustering')
```

```
## DataFrame with 99 rows and 4 columns
##     profile                              GOs          p.values
##      <list>                           <list>            <list>
## G1       G1                                                 NA
## G2       G2                                                 NA
## G3       G3                                                 NA
## G4       G4                                                 NA
## G5       G5                                                 NA
## ...     ...                              ...               ...
## G95     G95 GO:0030027,GO:0006821,GO:0031209 0.007,0.007,0.007
## G96     G96            GO:0003755,GO:0005509       0.003,0.007
## G97     G97 GO:0006695,GO:0005739,GO:0003872             0,0,0
## G98     G98 GO:0006357,GO:0043565,GO:0006821 0.004,0.005,0.005
## G99     G99            GO:0006695,GO:0003872       0.002,0.008
##                      GENES
##                     <list>
## G1                   SMAGP
## G2                NA NA NA
## G3                  HSD3B7
## G4                  PLXNA1
## G5                     AK1
## ...                    ...
## G95 CCDC88A KIAA0226 LUC..
## G96             CD24 FKBP9
## G97 SMAGP PPAP2A HSD3B7 ..
## G98 FOSB CCDC88A KIAA022..
## G99 SMAGP PPAP2A HSD3B7 ..
```

![](data:image/png;base64...)
The plot can be also enriched with information about the most frequent
ontology domain for each node on the dendrogram.

```
findGO(exrtcga, topGO = 2, grouped = 'clustering', over.rep = TRUE)
```

```
## DataFrame with 99 rows and 4 columns
##     profile                              GOs          p.values
##      <list>                           <list>            <list>
## G1       G1                                                 NA
## G2       G2                                                 NA
## G3       G3                                                 NA
## G4       G4                                                 NA
## G5       G5                                                 NA
## ...     ...                              ...               ...
## G95     G95 GO:0030027,GO:0006821,GO:0031209 0.007,0.007,0.007
## G96     G96            GO:0003755,GO:0005509       0.003,0.007
## G97     G97 GO:0006695,GO:0005739,GO:0003872             0,0,0
## G98     G98 GO:0006357,GO:0043565,GO:0006821 0.004,0.005,0.005
## G99     G99            GO:0006695,GO:0003872       0.002,0.008
##                      GENES
##                     <list>
## G1                   SMAGP
## G2                NA NA NA
## G3                  HSD3B7
## G4                  PLXNA1
## G5                     AK1
## ...                    ...
## G95 CCDC88A KIAA0226 LUC..
## G96             CD24 FKBP9
## G97 SMAGP PPAP2A HSD3B7 ..
## G98 FOSB CCDC88A KIAA022..
## G99 SMAGP PPAP2A HSD3B7 ..
```

![](data:image/png;base64...)