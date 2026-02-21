# Pulsed-SILAC data analysis

Marc Pagès-Gallego1 and Tobias B. Dansen1

1Center for Molecular Medicine, University Medical Center Utrecht, the Netherlands

#### 2020-03-17

#### Abstract

This document contains a tutorial on how to perform basic pulsed SILAC data analysis using the pulsedSilac package. This includes data organization, filtering, modelling and plotting.

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
* [3 Data organization](#data-organization)
  + [3.1 `SilacProteinExperiment` and `SilacPeptideExperiment`](#silacproteinexperiment-and-silacpeptideexperiment)
    - [3.1.1 Object construction](#object-construction)
    - [3.1.2 Accessor functions](#accessor-functions)
    - [3.1.3 Subsetting and aggregation](#subsetting-and-aggregation)
  + [3.2 `SilacProteomicsExperiment`](#silacproteomicsexperiment)
    - [3.2.1 Object construction](#object-construction-1)
    - [3.2.2 Accessor functions](#accessor-functions-1)
    - [3.2.3 Subsetting and aggregation](#subsetting-and-aggregation-1)
  + [3.3 `metaoptions`](#metaoptions)
* [4 Example data](#example-data)
* [5 Filtering](#filtering)
  + [5.1 Measurements across time](#measurements-across-time)
  + [5.2 Other filters](#other-filters)
* [6 Ratio and fraction calculation](#ratio-and-fraction-calculation)
* [7 Plotting assays](#plotting-assays)
  + [7.1 `plotDistributionAssay()`](#plotdistributionassay)
  + [7.2 `scatterCompareAssays()`](#scattercompareassays)
* [8 Model protein turnover](#model-protein-turnover)
  + [8.1 Output of `modelTurnover()`](#output-of-modelturnover)
  + [8.2 Calculating protein half-life](#calculating-protein-half-life)
  + [8.3 Plots](#plots)
    - [8.3.1 Individual models](#individual-models)
    - [8.3.2 Distributions](#distributions)
    - [8.3.3 Comparing conditions](#comparing-conditions)
  + [8.4 Comparing models](#comparing-models)
    - [8.4.1 Calculating the AIC](#calculating-the-aic)
    - [8.4.2 Relative model probabilities](#relative-model-probabilities)
* [9 Cell growth estimation](#cell-growth-estimation)
  + [9.1 Example data](#example-data-1)
  + [9.2 Most stable proteins](#most-stable-proteins)
  + [9.3 Estimating cell growth](#estimating-cell-growth)
  + [9.4 Comparing turnover rates](#comparing-turnover-rates)
* [10 Isotope recycling estimation](#isotope-recycling-estimation)
  + [10.1 Adding the information](#adding-the-information)
  + [10.2 Calculating light label recycling](#calculating-light-label-recycling)
* [11 Interoperability with other packages](#interoperability-with-other-packages)
* [12 Session info](#session-info)
* [References](#references)

# 1 Installation

To install this package, start R (version “3.6”) and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("pulsedSilac")
```

To install the development version of the package, please do it from the development branch in github.

```
BiocManager::install('marcpaga/pulsedSilac')
```

# 2 Introduction

SILAC (Stable Isotope Label by Amino acids in Cell culture) is a method that is often used to differentially compare protein expression between samples. Pulsed SILAC is a variant that is used to measure protein turnover. Rather than comparing samples that are labeled to completion with either heavy or light isotopes of amino acids, in pulsed SILAC cells are harvested at a series of time points after the growth media containing light amino acids was switched to media containing heavy amino acids. Each sample is then processed and analyzed by mass spectrometry. The isotope ratio each peptide at each time point can now be used to calculate the turnover rate of each measured protein in a proteome-wide fashion (Pratt et al. (2002), Doherty et al. (2005), Schwanhäusser et al. (2009)).

![Figure 1: Pulsed SILAC overview](data:image/png;base64...)

Figure 1: Pulsed SILAC overview

This package contains a set of functions to analyze pulsed SILAC quantitative data. Functions are provided to organize the data, calculate isotope ratios, isotope fractions, model protein turnover, compare turnover models, estimate cell growth and estimate isotope recycling. Several visualization tools are also included to perform basic data exploration, quality control, condition comparison, individual model inspection and model comparison.

# 3 Data organization

Many Bioconductor packages use `SummarizedExperiment` objects or derivatives from it to organize omics data. This is a rectangular class of object that contains assays (matrix-like organized data) in which rows represent features (genes, proteins, metabolites, …) and columns represent samples. If you are unfamiliar with this format, please read this introductory [vignette](https://bioconductor.org/packages/3.8/bioc/vignettes/SummarizedExperiment/inst/doc/SummarizedExperiment.html).

This package uses two `SummarizedExperiment` derived classes: `SilacProteinExperiment` and `SilacPeptideExperiment`. It also introduces a new class, the `SilacProteomicsExperiment`, which encapsulates both the previous classes.

## 3.1 `SilacProteinExperiment` and `SilacPeptideExperiment`

The `SilacProteinExperiment` and `SilacPeptideExperiment` are, as their name indicates, dedicated to store either protein or peptide related data. These two objects are almost identical to a `SummarizedExperiment` object. Their only difference is the initialization of the `metadata` slot with what will be called `metaoptions`. These `metaoptions` contain values that are indicative of where certain information, required for the analysis, is located in the object. For example, the `conditionCol` value is used to indicate which column of `colData` has the information about the different experiment conditions.

![Figure 2: SilacProteinExperiment/SilacPeptideExperiment object structure](data:image/png;base64...)

Figure 2: SilacProteinExperiment/SilacPeptideExperiment object structure

### 3.1.1 Object construction

Constructing a `SilacProteinExperiment` or a `SilacPeptideExperiment` is extremely similar to constructing a `SummarizedExperiment`. The only additional arguments are the different `metaoptions` values.

Here is an example of constructing a `SilacProteinExperiment`:

```
require(pulsedSilac)

## assays
assays_protein <- list(expression = matrix(1:9, ncol = 3))

## colData
colData <- data.frame(sample = c('A1', 'A2', 'A3'),
                      condition = c('A', 'A', 'A'),
                      time = c(1, 2, 3))
## rowData
rowData_protein <- data.frame(prot_id = LETTERS[1:3])

## construct the SilacProteinExperiment
protExp <- SilacProteinExperiment(assays = assays_protein,
                                  rowData = rowData_protein,
                                  colData = colData,
                                  conditionCol = 'condition',
                                  timeCol = 'time')
protExp
```

```
## class: SilacProteinExperiment
## dim: 3 3
## metadata(2): conditionCol timeCol
## assays(1): expression
## rownames: NULL
## rowData names(1): prot_id
## colnames: NULL
## colData names(3): sample condition time
```

Here is an example of constructing a `SilacPeptideExperiment`:

```
## assays
assays_peptide <- list(expression = matrix(1:15, ncol = 3))

## colData
colData <- data.frame(sample = c('A1', 'A2', 'A3'),
                      condition = c('A', 'A', 'A'),
                      time = c(1, 2, 3))
## rowData
rowData_peptide <- data.frame(pept_id = letters[1:5],
                              prot_id = c('A', 'A', 'B', 'C', 'C'))
## construct the SilacProteinExperiment
peptExp <- SilacPeptideExperiment(assays = assays_peptide,
                                  rowData = rowData_peptide,
                                  colData = colData,
                                  conditionCol = 'condition',
                                  timeCol = 'time')
peptExp
```

```
## class: SilacPeptideExperiment
## dim: 5 3
## metadata(3): conditionCol timeCol proteinCol
## assays(1): expression
## rownames: NULL
## rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

### 3.1.2 Accessor functions

The accessor functions are exactly the same as in a `SummarizedExperiment` object: `rowData()`, `colData()`, `assays()` and `metadata()`. To access the `metaoptions` slot the both the `metaoptions()` and `metadata()` functions can be used.

```
## assays
assays(protExp)
```

```
## List of length 1
## names(1): expression
```

```
assays(peptExp)
```

```
## List of length 1
## names(1): expression
```

```
## rowData
rowData(protExp)
```

```
## DataFrame with 3 rows and 1 column
##    prot_id
##   <factor>
## 1        A
## 2        B
## 3        C
```

```
rowData(peptExp)
```

```
## DataFrame with 5 rows and 2 columns
##    pept_id  prot_id
##   <factor> <factor>
## 1        a        A
## 2        b        A
## 3        c        B
## 4        d        C
## 5        e        C
```

```
## colData
colData(protExp)
```

```
## DataFrame with 3 rows and 3 columns
##     sample condition      time
##   <factor>  <factor> <numeric>
## 1       A1         A         1
## 2       A2         A         2
## 3       A3         A         3
```

```
colData(peptExp)
```

```
## DataFrame with 3 rows and 3 columns
##     sample condition      time
##   <factor>  <factor> <numeric>
## 1       A1         A         1
## 2       A2         A         2
## 3       A3         A         3
```

```
## metaoptions
metaoptions(protExp)
```

```
## $conditionCol
## [1] "condition"
##
## $timeCol
## [1] "time"
```

```
metaoptions(peptExp)[['proteinCol']] <- 'prot_id'
metaoptions(peptExp)
```

```
## $conditionCol
## [1] "condition"
##
## $timeCol
## [1] "time"
##
## $proteinCol
## [1] "prot_id"
```

### 3.1.3 Subsetting and aggregation

Similar to the accessor function, most of the `SummarizedExperiment` operations, such as subsetting and aggregating, can be applied to the two classes. For subsetting these are mainly: `[`, `subset`, `$`; and for aggregation these are mainly: `cbind`, `rbind` and `merge`. For a more detailed explanation please refer to the manual.

```
## subsetting by rows and columns
protExp[1, 1:2]
```

```
## class: SilacProteinExperiment
## dim: 1 2
## metadata(2): conditionCol timeCol
## assays(1): expression
## rownames: NULL
## rowData names(1): prot_id
## colnames: NULL
## colData names(3): sample condition time
```

```
peptExp[1, 1:2]
```

```
## class: SilacPeptideExperiment
## dim: 1 2
## metadata(3): conditionCol timeCol proteinCol
## assays(1): expression
## rownames: NULL
## rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

```
## subsetting by rows based on rowData
subset(protExp, prot_id == 'A')
```

```
## class: SilacProteinExperiment
## dim: 1 3
## metadata(2): conditionCol timeCol
## assays(1): expression
## rownames: NULL
## rowData names(1): prot_id
## colnames: NULL
## colData names(3): sample condition time
```

```
subset(peptExp, pept_id %in% c('a', 'b'))
```

```
## class: SilacPeptideExperiment
## dim: 2 3
## metadata(3): conditionCol timeCol proteinCol
## assays(1): expression
## rownames: NULL
## rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

```
## quick acces to colData
protExp$sample
```

```
## [1] A1 A2 A3
## Levels: A1 A2 A3
```

```
peptExp$condition
```

```
## [1] A A A
## Levels: A
```

```
## combining by columns
cbind(protExp[, 1], protExp[, 2:3])
```

```
## class: SilacProteinExperiment
## dim: 3 3
## metadata(2): conditionCol timeCol
## assays(1): expression
## rownames: NULL
## rowData names(1): prot_id
## colnames: NULL
## colData names(3): sample condition time
```

```
## combining by rows
rbind(peptExp[1:3,], peptExp[4:5, ])
```

```
## class: SilacPeptideExperiment
## dim: 5 3
## metadata(3): conditionCol timeCol proteinCol
## assays(1): expression
## rownames: NULL
## rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

```
## combine rows and columns
merge(peptExp[1:3, 1], peptExp[3:5, 2:3])
```

```
## class: SilacPeptideExperiment
## dim: 5 3
## metadata(3): conditionCol timeCol proteinCol
## assays(1): expression
## rownames: NULL
## rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

## 3.2 `SilacProteomicsExperiment`

The `SilacProteomicsExperiment` object contains both a `SilacProteinExperiment` and a `SilacPeptideExperiment` object. Therefore it can be used to store both levels of information in a single object. The protein and peptide level are aligned/linked by the `colData` slot and by the `linkerDf` slot. The `linkerDf` slot contains a `data.frame` that indicates which peptides are assigned to each protein and *vice versa*.

![Figure 3: SilacProteomicsExperiment object structure](data:image/png;base64...)

Figure 3: SilacProteomicsExperiment object structure

### 3.2.1 Object construction

To construct a `SilacProteomicsExperiment` we need both a `SilacProteinExperiment` object and a `SilacPeptideExperiment` object.

```
ProteomicsExp <- SilacProteomicsExperiment(SilacProteinExperiment = protExp,
                                           SilacPeptideExperiment = peptExp)
ProteomicsExp
```

```
## class: SilacProteomicsExperiment
## metadata(7): idColProt idColPept ... timeCol proteinCol
## protein:
##   |-- dim: 3 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(1): prot_id
## peptide:
##   |-- dim: 5 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

In this case, the levels are only aligned by columns. There is no information on which are the relationships between proteins and peptides. This information can be added in the `linkerDf` slot. Which contains a `data.frame` that indicates the relationships between the two levels features. One can be constructed with the `buildLinkerDf()` function.

```
## list with the relationships
protein_to_peptide <- list(A = c('a', 'b'), B = c('c'), C = c('d', 'e'))
## function to build the data.frame
linkerDf <- buildLinkerDf(protIDs = LETTERS[1:3],
                          pepIDs  = letters[1:5],
                          protToPep = protein_to_peptide)
linkerDf
```

```
##   protID pepID protRow pepRow
## 1      A     a       1      1
## 2      A     b       1      2
## 3      B     c       2      3
## 4      C     d       3      4
## 5      C     e       3      5
```

```
ProteomicsExp <- SilacProteomicsExperiment(SilacProteinExperiment = protExp,
                                           SilacPeptideExperiment = peptExp,
                                           linkerDf = linkerDf)
```

Linked `SilacProteomicsExperiment` objects can be useful to apply linked subsetting operations or to recalculate protein level data from peptide data.

### 3.2.2 Accessor functions

If the slot is general to the `SilacProteomicsExperiment` object then the same functions as in a `SummarizedExperiment` can be used.

```
## colData
colData(ProteomicsExp)
```

```
## DataFrame with 3 rows and 3 columns
##     sample condition      time
##   <factor>  <factor> <numeric>
## 1       A1         A         1
## 2       A2         A         2
## 3       A3         A         3
```

```
## linkerDf
linkerDf(ProteomicsExp)
```

```
##   protID pepID protRow pepRow
## 1      A     a       1      1
## 2      A     b       1      2
## 3      B     c       2      3
## 4      C     d       3      4
## 5      C     e       3      5
```

```
## metaoptions
metaoptions(ProteomicsExp)
```

```
## $conditionCol
## [1] "condition"
##
## $timeCol
## [1] "time"
##
## $idColProt
## [1] NA
##
## $idColPept
## [1] NA
##
## $linkedSubset
## [1] TRUE
##
## $subsetMode
## [1] "protein"
##
## $proteinCol
## [1] NA
```

But for names shared between protein and peptide slots, like `assays` and `rowData`, there are two options to access them. Using the `SummarizedExperiment` generic will return a named list with the two elements.

```
## assays
assays(ProteomicsExp)
```

```
## $protein
## List of length 1
## names(1): expression
##
## $peptide
## List of length 1
## names(1): expression
```

```
## rowData
rowData(ProteomicsExp)
```

```
## $protein
## DataFrame with 3 rows and 1 column
##    prot_id
##   <factor>
## 1        A
## 2        B
## 3        C
##
## $peptide
## DataFrame with 5 rows and 2 columns
##    pept_id  prot_id
##   <factor> <factor>
## 1        a        A
## 2        b        A
## 3        c        B
## 4        d        C
## 5        e        C
```

One can use the same functions and just add `Prot` or `Pept` as suffixes to specifically access a slot at the protein or the peptide level.

```
## assays of protein level
assaysProt(ProteomicsExp)
```

```
## List of length 1
## names(1): expression
```

```
## assays of peptide level
assaysPept(ProteomicsExp)
```

```
## List of length 1
## names(1): expression
```

```
## rowData of protein level
rowDataProt(ProteomicsExp)
```

```
## DataFrame with 3 rows and 1 column
##    prot_id
##   <factor>
## 1        A
## 2        B
## 3        C
```

```
## rowData of peptide level
rowDataPept(ProteomicsExp)
```

```
## DataFrame with 5 rows and 2 columns
##    pept_id  prot_id
##   <factor> <factor>
## 1        a        A
## 2        b        A
## 3        c        B
## 4        d        C
## 5        e        C
```

Finally, to extract the `SilacProteinExperiment` and `SilacPeptideExperiment` one can use the `ProtExp` and `PeptExp` functions.

```
ProtExp(ProteomicsExp)
```

```
## class: SilacProteinExperiment
## dim: 3 3
## metadata(2): conditionCol timeCol
## assays(1): expression
## rownames: NULL
## rowData names(1): prot_id
## colnames: NULL
## colData names(3): sample condition time
```

```
PeptExp(ProteomicsExp)
```

```
## class: SilacPeptideExperiment
## dim: 5 3
## metadata(3): conditionCol timeCol proteinCol
## assays(1): expression
## rownames: NULL
## rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

### 3.2.3 Subsetting and aggregation

When subsetting row-wise on a `SilacProteomicsExperiment` there will be two main questions:

* To which level (protein or peptide) is the subset applied?
* Is the subset from one level applied also to the other? For example, when I subset a protein, do I also want to subset also only those peptides related to that protein.

The answer to these questions is written in the `metaoptions` values. The first one is `subsetMode` which can be `protein` or `peptide`. The second one is `linkedSubset`, which can be `TRUE` or `FALSE`. Moreover, if the latter is set to `TRUE` then the `idColProt` and `idColPept` will also be required.

Here are some examples of using the `[` in different situations.

Subset at protein level without affecting the peptide level.

```
## indicate which rowDat columns have unique ids for proteins and peptides
metaoptions(ProteomicsExp)[['idColProt']] <- 'prot_id'
metaoptions(ProteomicsExp)[['idColPept']] <- 'pept_id'
## indicate that we want to apply the subset at protein level
metaoptions(ProteomicsExp)[['subsetMode']] <- 'protein'
## and not extend it to the peptide level
metaoptions(ProteomicsExp)[['linkedSubset']] <- FALSE

ProteomicsExp[1:2,]
```

```
## class: SilacProteomicsExperiment
## metadata(7): conditionCol timeCol ... subsetMode proteinCol
## protein:
##   |-- dim: 2 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(1): prot_id
## peptide:
##   |-- dim: 5 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

Note that the protein level has two proteins while the peptide level kept all five peptides.

Subset at protein level and extending the subset to the peptide level.

```
## to extend we set the metaoption to TRUE
metaoptions(ProteomicsExp)[['linkedSubset']] <- TRUE

ProteomicsExp[1:2,]
```

```
## class: SilacProteomicsExperiment
## metadata(7): conditionCol timeCol ... subsetMode proteinCol
## protein:
##   |-- dim: 2 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(1): prot_id
## peptide:
##   |-- dim: 3 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

In this case the protein level has two proteins and the peptide level has also been subset to the three peptides that are assigned to the two proteins in the `linkerDf`.

The same process can also be applied at peptide level.

```
## indicate that we want to apply the subset at protein level
metaoptions(ProteomicsExp)[['subsetMode']] <- 'peptide'
## to extend we set the metaoption to TRUE
metaoptions(ProteomicsExp)[['linkedSubset']] <- TRUE

ProteomicsExp[1:2,]
```

```
## class: SilacProteomicsExperiment
## metadata(7): conditionCol timeCol ... subsetMode proteinCol
## protein:
##   |-- dim: 1 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(1): prot_id
## peptide:
##   |-- dim: 2 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

In this case, the first two peptides, which belong to the first protein, are selected along with that protein.

Other subset operations can be done using `subsetProt()` and `subsetPep()`, which call the generic `subset()` on the `rowData` slot of the protein and peptide level respectively. Note that `subsetProt()` and `subsetPep()` will behave differently depending on the metaoption `linkedSubset` as seen above with `[`.

```
## without linked Subset
metaoptions(ProteomicsExp)[['linkedSubset']] <- FALSE
subsetProt(ProteomicsExp, prot_id == 'B')
```

```
## class: SilacProteomicsExperiment
## metadata(7): conditionCol timeCol ... subsetMode proteinCol
## protein:
##   |-- dim: 1 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(1): prot_id
## peptide:
##   |-- dim: 5 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

```
## with linked Subset
metaoptions(ProteomicsExp)[['linkedSubset']] <- TRUE
subsetProt(ProteomicsExp, prot_id == 'B')
```

```
## class: SilacProteomicsExperiment
## metadata(7): conditionCol timeCol ... subsetMode proteinCol
## protein:
##   |-- dim: 1 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(1): prot_id
## peptide:
##   |-- dim: 1 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

Finally, `cbind`, `rbind` and `merge` can be used for aggregation.

For `cbind` the number of proteins and peptides must be the same and they are expected to be in the same order.

```
## cbind
cbind(ProteomicsExp[, 1], ProteomicsExp[, 2])
```

```
## class: SilacProteomicsExperiment
## metadata(7): conditionCol timeCol ... subsetMode proteinCol
## protein:
##   |-- dim: 3 2
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(1): prot_id
## peptide:
##   |-- dim: 5 2
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

For `rbind` the number of samples must be the same and they are expected to be in the same order.

```
## rbind
rbind(ProteomicsExp[1:2,], ProteomicsExp[3,])
```

```
## class: SilacProteomicsExperiment
## metadata(7): conditionCol timeCol ... subsetMode proteinCol
## protein:
##   |-- dim: 2 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(1): prot_id
## peptide:
##   |-- dim: 3 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

`merge` can be used when samples have to be aggregated in one object but the proteins/peptides are not the same. It requires IDs that can be matched between experiments.

```
## merge
merge(ProteomicsExp[1:3, 1], ProteomicsExp[3:4, 2:3])
```

```
## class: SilacProteomicsExperiment
## metadata(7): conditionCol timeCol ... subsetMode proteinCol
## protein:
##   |-- dim: 3 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(1): prot_id
## peptide:
##   |-- dim: 4 3
##   |-- assays(1): expression
##   |-- rownames: NULL
##   |-- rowData names(2): pept_id prot_id
## colnames: NULL
## colData names(3): sample condition time
```

## 3.3 `metaoptions`

The `metaoptions` are a set of “option” values used to indicate where critical analysis information is required. The idea is that these values are defined at the beginning of the analysis so that it is not required to give them as arguments in each function call. Nevertheless, all the analysis functions can have these values passed as arguments. There are several `metaoptions` values by default, some of them are shared between the three classes while others are unique.

The following are related to data analysis:

* `conditionCol`: which column in `colData` indicates the different experiment conditions.
* `timeCol`: which column in `colData` indicates the different timepoints of the experiment.
* `proteinCol`: which column in `rowData` indicates the assigned protein to a peptide. (unique to `SilacPeptideExperiment`)

The following are related to `SilacProteomicsExperiment` subsetting operations:

* `idColProt`: which column in `rowDataProt` indicates unique protein IDs. (unique to `SilacProteomicsExperiment`)
* `idColPept`: which column in `rowDataPept` indicates unique peptide IDs. (unique to `SilacProteomicsExperiment`)
* `linkedSubset`: logical that indicates if the subsetting operation should be applied to both data levels (protein and peptide). (unique to `SilacProteomicsExperiment`)
* `subsetMode`: which level should be used for reference when subsetting (protein or peptide). (unique to `SilacProteomicsExperiment`)

These can be extended by the user to accommodate other experiment design and data analysis operations.

# 4 Example data

To demonstrate the use of the package functions, a reduced version of the pulsed-SILAC dataset from Visscher et al. (2016) has been built into a `SilacProteomicsExperiment` object. It is stored in an object named `wormsPE`. This object has been constructed from the output files from MaxQuant ‘proteinGroups.txt’ and ‘peptides.txt’.

```
wormsPE
```

```
## class: SilacProteomicsExperiment
## metadata(7): idColProt idColPept ... timeCol proteinCol
## protein:
##   |-- dim: 250 14
##   |-- assays(4): int_total int_light int_heavy ratio
##   |-- rownames: NULL
##   |-- rowData names(22): Protein.IDs Majority.protein.IDs ...
##     Peptide.is.razor protein_id
## peptide:
##   |-- dim: 3574 14
##   |-- assays(4): int_total int_light int_heavy ratio
##   |-- rownames: NULL
##   |-- rowData names(46): Sequence N.term.cleavage.window ... id
##     Protein.group.IDs
## colnames: NULL
## colData names(2): line timepoint
```

The dataset contains only the first 250 proteins and their corresponding peptides. It has 4 assays with the total intensity, light isotope and heavy isotope intensities and heavy/light isotope ratio. In the experiment there are 2 worm cell lines: OW40, which express \(\alpha\)-synuclein-YFP (model for Parkinson’s Disease) and OW450, which express YFP only. Worms were harvested after 4h, 6h, 8h, 13h, 24h, 28h and 32h of light to heavy isotope medium transition. Note that the analysis of the data presented in the paper by Visscher et al was not performed using this package. However, all data in that paper has been reanalyzed using this package, which resulted in general the same but also more extended conclusions.

# 5 Filtering

## 5.1 Measurements across time

To reliably model a protein’s turnover, several timepoints are required. Ideally a protein would be measured in all the timepoints of the experiment, but this is rarely the case. To count how many proteins/peptides have been measured in each sample the `barplotCounts()` can be used.

```
barplotCounts(wormsPE, assayName = 'ratio')
```

![](data:image/png;base64...)

There is some variability between samples but nothing too extreme. More importantly is knowing whether a protein has been measured across different timepoints. The function `barplotTimeCoverage()` can be used to visualize in how many timepoints each protein has been measured per condition.

```
barplotTimeCoverage(wormsPE, assayName = 'ratio')
```

![](data:image/png;base64...)

As it can be seen, most of the proteins are not measured in all timepoints. In this case there is a majority for proteins that have not been measured in any timepoint, this is because the dataset has been truncated for only the OW40 and OW450 lines. The original search was one with additional worm lines and the missing proteins were detected in the lines excluded from this vignette.

To filter proteins that have not been detected in sufficient timepoints the `filterByMissingTimepoints()` function can be used. With `maxMissing` the amount of missing values can be tuned. With `strict` proteins have to meet the maxMissing criteria only in one condition or in all.

```
wormsPE2 <- filterByMissingTimepoints(wormsPE,
                                      assayName = 'ratio',
                                      maxMissing = 2,
                                      strict = FALSE)

barplotTimeCoverage(wormsPE2, assayName = 'ratio')
```

![](data:image/png;base64...)

Because `strict` is set to `FALSE`, there are still some proteins that have been detected in less than 5 timepoints in one of the conditions. To visualize the overlap between conditions, the `upsetTimeCoverage()` function can be used. This can be especially useful when more the experiment contains more than two conditions. Here the overlap of proteins is shown.

```
upsetTimeCoverage(ProtExp(wormsPE2),
                  assayName = 'ratio',
                  maxMissing = 2)
```

![](data:image/png;base64...)

In this case there are 68 proteins that have been measured in at least 5 out of 7 timepoints in both conditions. These would be proteins for which turnover models can be compared between conditions.

Filtering by missing timepoints can also be done at peptide level if desired by changing `subsetMode` to `peptide`.

## 5.2 Other filters

Other filters can be easily applied using the `subset` method. For example, proteins with a low number of unique peptides can be filtered out.

```
subsetProt(wormsPE, Unique.peptides > 2)
```

Also, proteins that are known as common contaminants or identified using the reverse database can be filtered out.

```
subsetProt(wormsPE, Potential.contaminant != '+')
subsetProt(wormsPE, Reverse != '+')
```

# 6 Ratio and fraction calculation

To model protein turnover the isotope fractions from each timepoint are used. The isotope fraction can be calculated in many ways. A simple approach is to derive them from isotope ratios, which many raw mass spectrometry data analysis software report. If not, one can use the `calculateIsotopeRatio()` function, which will add a new assay named `ratio` to the object. In this example, the ratio of newly synthesized protein (heavy isotope) over old protein (light isotope) will be used.

```
## calculate the ratio of new istope over old isotope
wormsPE <- calculateIsotopeRatio(x = wormsPE,
                                 newIsotopeAssay = 'int_heavy',
                                 oldIsotopeAssay = 'int_light')
```

\[ratio = \frac{isotope\_{A}}{isotope\_{B}}\]

And then the fraction can be calculated as follows:

\[fraction\_{A} = \frac{ratio}{1 + ratio}\]

This can be easily done using the `calculateIsotopeFraction()` function, which adds a new assay named `fraction`. In this case the heavy isotope fraction is calculated, the light isotope fraction would just be 1-fractionA.

```
wormsPE <- calculateIsotopeFraction(wormsPE, ratioAssay = 'ratio')

assaysProt(wormsPE)
```

```
## List of length 5
## names(5): int_total int_light int_heavy ratio fraction
```

```
assaysPept(wormsPE)
```

```
## List of length 5
## names(5): int_total int_light int_heavy ratio fraction
```

Unfortunately, this approach might might lead to the loss some values because mass spectrometry has a bias towards the measurement of high abundance peptides. For example: if a protein has a very slow turnover rate, it might be that at the earliest timepoint, the new isotope signal was below the detection limit and a ratio could not be calculated. To also account for these proteins the `calculateIsotopeFraction` function has additional arguments to indicate which assays contain each isotope’s expression data and which timepoints are considered “early” or “late”.

```
wormsPE <- calculateIsotopeFraction(wormsPE,
                                    newIsoAssay = 'int_heavy',
                                    oldIsoAssay = 'int_light',
                                    earlyTimepoints = 1,
                                    lateTimepoints = 7)
```

# 7 Plotting assays

To visualize data stored in the `assays` slot there are two functions `plotDistributionAssay()` and `scatterCompareAssays()`. The first one will plot the distributions of the data for a selected assay for each timepoint and condition. The latter will plot each protein/peptide value of a condition against the other for each timepoint.

## 7.1 `plotDistributionAssay()`

```
plotDistributionAssay(wormsPE, assayName = 'fraction')
```

![](data:image/png;base64...)

From this plot it can already be seen that the OW450 line has a much faster heavy label incorporation than the OW40 line.

## 7.2 `scatterCompareAssays()`

For `scatterCompareAssays()` it is necessary to indicate which conditions should be compared. To make it simpler, only the protein data will be used.

```
protPE <- ProtExp(wormsPE)

scatterCompareAssays(x = protPE,
                     conditions = c('OW40', 'OW450'),
                     assayName = 'ratio')
```

![](data:image/png;base64...)

This plot shows that the OW450 has a faster incorporation of heavy label than the OW40 line.

```
scatterCompareAssays(x = protPE,
                     conditions = c('OW40', 'OW450'),
                     assayName = 'int_total')
```

![](data:image/png;base64...)

This plot shows that both the OW450 and OW40 have similar total protein expression over time.

# 8 Model protein turnover

To estimate protein turnover rate the `modelTurnover()` function can be used. Parameter fitting is done using the `nls` function, or the `nlrob` function from `robustbase` for robust modelling. The `formula`, `start` and `...` arguments are passed into these functions. By default, an exponential decay model is used, but it has been shown that some proteins follow other turnover kinetics McShane et al. (2016).

```
modelList <- modelTurnover(x = wormsPE,
                           assayName = 'fraction',
                           formula = 'fraction ~ 1 - exp(-k*t)',
                           start = list(k = 0.02),
                           mode = 'protein',
                           returnModel = TRUE)
```

## 8.1 Output of `modelTurnover()`

The output of `modelTurnover()` is a list with the main model metrics:

* `residuals`: a matrix of the same dimensions as `x` with the model residuals.
* `stderror`: a matrix with the standard error of each model.
* `param_values`: a matrix with the estimated parameter values of each model.
* `param_pval`: a matrix with the p-value of each parameter of each model.
* `param_tval`: a matrix with the t-statistic of each parameter of each model.
* `param_stderror`: a matrix with the standard error of each parameter of each model.

Models that fail to converge have `NA` as their output metrics.

There are more options to tune `modelTurnover()`, such as: `robust`, to use robust modelling; `returnModel`, which will return the actual model objects besides the metrics; `verbose`, to output a progress bar. For more information please refer to the manual.

## 8.2 Calculating protein half-life

To calculate protein half-life one has to separate the time variable on to one side of the equation and solve it. For this particular exponential decay model that has been applied it is quite simple. The new equation would be:

\[t = \frac{log(0.5)}{-k}\]

The half-life, of each protein can be calculated using this formula. Here it is calculated and added to the `modelList` object. In this way, the following plots can also be used on the protein half-life data.

```
modelList[['half_life']] <- log(0.5)/(-modelList$param_values$k)
```

## 8.3 Plots

The output of `modelTurnover()` with `returnModel = TRUE` can be used as input in the following functions to plot either individual protein/peptides models or the overall experiment distributions.

All the following function return objects of class `ggplot`, therefore their theme, scale, labels, etc. can be customized further customized. Moreover, if the argument `returnDataFrame` is set to `TRUE`, the `data.frame` used in the plot function will be returned instead.

### 8.3.1 Individual models

To plot individual models the `plotIndividualModel()` function can be used. As input it requires the `Experiment` object that was used in the `modelTurnover()` call and its output. This function also requires `returnModel = TRUE`.

```
modelList <- modelTurnover(x = wormsPE,
                           assayName = 'fraction',
                           formula = 'fraction ~ 1 - exp(-k*t)',
                           start = list(k = 0.02),
                           mode = 'protein',
                           returnModel = TRUE)

plotIndividualModel(x = wormsPE,
                    modelList = modelList,
                    num = 2)
```

![](data:image/png;base64...)

The plot shows the quantification data as dots and the fitted model as a curve. If the models are based on grouped peptide data then the values of each peptide are plotted as dots.

```
## to indicate which column of rowDataPept indicates the assigned protein
metaoptions(wormsPE)[['proteinCol']] <- 'Protein.group.IDs'
modelList <- modelTurnover(x = wormsPE,
                           assayName = 'fraction',
                           formula = 'fraction ~ 1 - exp(-k*t)',
                           start = list(k = 0.02),
                           mode = 'grouped',
                           returnModel = TRUE)
```

```
## Modelling peptides grouped by protein
```

```
plotIndividualModel(x = wormsPE,
                    modelList = modelList,
                    num = 2)
```

![](data:image/png;base64...)

### 8.3.2 Distributions

To plot the overall distributions of the model metrics per condition the `plotDistributionModel` function can be used. This will show global changes between conditions and/or can be used for quality control. Some metrics that might be interesting to check are the R2 error of the models, the estimated parameters, the residuals and the weights (only for robust modelling).

In this case, both the outputs of `modelTurnover()` with `returnModel = TRUE` or with `returnModel = FALSE` will work.

#### 8.3.2.1 R2 error

```
modelList <- modelTurnover(x = wormsPE,
                           assayName = 'fraction',
                           formula = 'fraction ~ 1 - exp(-k*t)',
                           start = list(k = 0.02),
                           mode = 'protein',
                           robust = TRUE,
                           returnModel = TRUE)
```

This plot shows the distribution of the error of all the models for each condition.

```
plotDistributionModel(modelList = modelList,
                      value = 'stderror',
                      plotType = 'density')
```

![](data:image/png;base64...)

#### 8.3.2.2 Turnover rate

This plot shows the distribution of the values for every fitted parameter. In this case there is only one: the turnover rate (**k**).

```
plotDistributionModel(modelList = modelList,
                      value = 'param_values',
                      plotType = 'density')
```

![](data:image/png;base64...)

#### 8.3.2.3 Residuals

This plot shows the distribution of residuals at each timepoint for each condition.

```
plotDistributionModel(modelList = modelList,
                      value = 'residuals',
                      plotType = 'density')
```

![](data:image/png;base64...)

#### 8.3.2.4 Weights

This plot shows the distribution of weights, from robust modelling, at each timepoint for each condition. This is only available if robust modelling is used.

```
plotDistributionModel(modelList = modelList,
                      value = 'weights',
                      plotType = 'density')
```

![](data:image/png;base64...)

#### 8.3.2.5 Half-lives

This plot shows the distribution of half-lives for each condition.

```
plotDistributionModel(modelList = modelList,
                      value = 'half_life',
                      plotType = 'density')
```

![](data:image/png;base64...)

### 8.3.3 Comparing conditions

To plot protein/peptide values and compare between conditions the `scatterCompareModels()` function can be used. It works like the `scatterCompareAssays()` function. The two conditions to be compared must be indicated as well as the desired metric.

```
scatterCompareModels(modelList = modelList,
                     conditions = c('OW40', 'OW450'),
                     value = 'param_values')
```

![](data:image/png;base64...)

```
scatterCompareModels(modelList = modelList,
                     conditions = c('OW40', 'OW450'),
                     value = 'stderror')
```

![](data:image/png;base64...)

## 8.4 Comparing models

It might be that some proteins follow a specific turnover model, while other follow a different one. In that case, one can run `modelTurnover()` for each different model and then compare the models for each protein. One metric often used to compare models is the Akaike Information Criteria (AIC). It can be calculated using the `calculateAIC()` function. Afterwards the probability of each model relative to the rest can be calculated with the `compareAIC()` function.

### 8.4.1 Calculating the AIC

To calculate the AIC the output from `modelTurnover()` can be used. The formula used to calculate it is the following:

\[AIC = 2k - 2ln(logLik)\]

There is also a formula that applies a small sample size correction:

\[AICc = AIC + \frac{2k(k + 1)}{n - k - 1}\]

Where *k* is the number of parameters and *n* is the number of observations (timepoints in this case).

```
modelList <- calculateAIC(modelList, smallSampleSize = TRUE)
```

The output will be the same given list plus an additional matrix with the AIC values for each model and condition.

```
names(modelList)
```

```
##  [1] "residuals"      "stderror"       "param_values"   "param_pval"
##  [5] "param_tval"     "param_stderror" "weights"        "models"
##  [9] "half_life"      "AIC"
```

```
plotDistributionModel(modelList = modelList, value = 'AIC')
```

![](data:image/png;base64...)

### 8.4.2 Relative model probabilities

After the AICs have been calculated, the probability of one model relative to the others can be calculated. This is done using the `compareAIC` function. This probability can be calculated using the following formula:

\[\prod AIC\_{i} = \frac{exp(\frac{AIC\_{min}-AIC\_{i}}{2})}{\sum\_{j}exp(\frac{AIC\_{min}-AIC\_{j}}{2})} \]

The `compareAIC` function uses as input an indefinite number of modelLists that have been processed through the `calculateAIC` function, and it returns a list of matrices with the relative probability of each model (columns) for each protein/peptide (rows).

```
modelList1 <- modelTurnover(x = wormsPE,
                            assayName = 'fraction',
                            formula = 'fraction ~ 1 - exp(-k*t)',
                            start = list(k = 0.02),
                            mode = 'protein',
                            robust = FALSE,
                            returnModel = TRUE)

modelList1 <- calculateAIC(modelList = modelList1,
                           smallSampleSize = TRUE)

modelList2 <- modelTurnover(x = wormsPE,
                            assayName = 'fraction',
                            formula = 'fraction ~ 1 - exp(-k*t) + b',
                            start = list(k = 0.02, b = 0),
                            mode = 'protein',
                            robust = FALSE,
                            returnModel = TRUE)

modelList2 <- calculateAIC(modelList = modelList2,
                           smallSampleSize = TRUE)
```

Here is a small example in which two different models have been applied.

```
modelProbabilities <- compareAIC(modelList1, modelList2)

plotDistributionModel(modelList = modelProbabilities,
                      value = 'aicprobabilities',
                      returnDataFrame = FALSE)
```

![](data:image/png;base64...)

The plot shows that model1 is the preferred model of the two in both conditions for most proteins, but there are some that have a better model with the `b` parameter.

# 9 Cell growth estimation

During most pulsed-SILAC experiment cells will keep dividing. This means that protein synthesis will be greater than protein degradation because biomass increases. When comparing conditions in which cells divide at similar rates this effect can be neglected. But if cell growth is different between conditions then steady-state protein turnover will be obfuscated by the difference in protein synthesis due to cell growth.

This issue can be corrected by using a turnover model which takes cell growth into consideration. For example, by adding the cell growth rate into the model (where tcc is the cell division average time):

\[f(H) = 1 - e^{-(k + \frac{log 2}{t\_{cc}})t}\]

If this information is not available, the `estimateCellGrowth()` function can be used. This function will fit an exponential degradation model based on the `n` most stable proteins (proteins which are measured in all time points and have the slowest new isotope incorporation). The rationale behind this approach is that the most stable proteins are very slowly degraded (for example structural proteins), but new proteins need to be synthesized for the daughter cells. Therefore, these proteins can be used to infer cell growth.

## 9.1 Example data

For the current dataset, cell division was not an issue since cells in the adult *C. elegans* soma no longer divide. To illustrate the effects of differential cell division on the output, data from mouse embryonic fibroblasts (MEFs) cultured with and without serum will be used. MEFs cultured with serum will divide at a “normal” rate while MEFs cultured without serum will hardly divide and hence the total biomass will be quite different between samples at the end of the experiment.

```
mefPE
```

```
## class: SilacProteinExperiment
## dim: 5223 10
## metadata(2): conditionCol timeCol
## assays(2): ratio fraction
## rownames: NULL
## rowData names(3): Protein.IDs Gene.names Fasta.headers
## colnames: NULL
## colData names(2): line timepoint
```

This can be appreciated if the heavy label fraction is plotted over time for the two conditions.

```
plotDistributionAssay(mefPE, assayName = 'fraction')
```

![](data:image/png;base64...)

## 9.2 Most stable proteins

To extract the most stable proteins the `mostStable()` function can be used. This function will rank the incorporation of new label across time and conditions, and then select the top `n` proteins/peptides.

```
stablePE <- mostStable(mefPE, assayName = 'fraction', n = 50)

stablePE
```

```
## class: SilacProteinExperiment
## dim: 50 10
## metadata(2): conditionCol timeCol
## assays(2): ratio fraction
## rownames: NULL
## rowData names(3): Protein.IDs Gene.names Fasta.headers
## colnames: NULL
## colData names(2): line timepoint
```

## 9.3 Estimating cell growth

The stable protein set can then be used to estimate the growth rate, assuming that the incorporation of heavy
isotope in these proteins is predominantly due to increased biomass rather than replacement. The `modelTurnover` function can be used again since it follows the same principles. In the following example, the same exponential degradation model is applied, but instead of the turnover rate the doubling time parameter is used.

```
stableModels  <- modelTurnover(x = stablePE,
                               assayName = 'fraction',
                               formula = 'fraction ~ 1 - exp(-(log(2)/tc)*t)',
                               start = list(tc = 20),
                               mode = 'protein',
                               robust = FALSE,
                               returnModel = FALSE)

plotDistributionModel(stableModels, value = 'param_values', plotType = 'boxplot')
```

![](data:image/png;base64...)

Because the doubling time will be modeled from 50 different proteins, the doubling time needs to be summarized. This can be done by taking for example the mean form these 50 models.

```
apply(stableModels$param_values$tc, 2, mean)
```

```
##  NoSerum    Serum
## 93.15081 25.10730
```

Note that there is a clear difference in the doubling times comparing the two conditions.

## 9.4 Comparing turnover rates

Next the turnover rates can be calculated using the doubling time correction model. Because each condition has a different doubling time, the models have to be run separately.

```
modelsNoSerum <- modelTurnover(x = mefPE[, 1:5],
                               assayName = 'fraction',
                               formula = 'fraction ~ 1 - exp(-(0.0074 + k)*t)',
                               start = list(k = 0.02),
                               mode = 'protein',
                               robust = FALSE,
                               returnModel = TRUE)

modelsSerum <- modelTurnover(x = mefPE[, 6:10],
                             assayName = 'fraction',
                             formula = 'fraction ~ 1 - exp(-(0.0276 + k)*t)',
                             start = list(k = 0.02),
                             mode = 'protein',
                             robust = FALSE,
                             returnModel = TRUE)

modelsMef <- mergeModelsLists(modelsNoSerum, modelsSerum)
```

To compare the output from the models without correction for increased biomass, the turnover is modeled without the doubling time correction.

```
modelsNoCorrect <- modelTurnover(x = mefPE,
                                 assayName = 'fraction',
                                 formula = 'fraction ~ 1 - exp(-(k)*t)',
                                 start = list(k = 0.02),
                                 mode = 'protein',
                                 robust = FALSE,
                                 returnModel = TRUE)
```

Finally, the distributions of the turnover rates can be plotted for each case.

With doubling time correction:

```
plotDistributionModel(modelList = modelsMef,
                      value = 'param_values',
                      plotType = 'density')
```

```
## Picking joint bandwidth of 0.00279
```

![](data:image/png;base64...)

Without doubling time correction:

```
plotDistributionModel(modelList = modelsNoCorrect,
                      value = 'param_values',
                      plotType = 'density')
```

```
## Picking joint bandwidth of 0.00279
```

![](data:image/png;base64...)

# 10 Isotope recycling estimation

Once a protein is degraded, its amino acids can be recycled to synthesize new proteins. This process will lead to an underestimation of protein turnover. For example, light label amino acids will be used to synthesize new proteins, but will be interpreted as being old proteins. This results in an overall overestimation of protein half-life.

To estimate how much “old” label is still being used in new proteins, miss-cleaved peptides can be used. If a miss-cleaved peptide contains both light and heavy label, it means that old label was used for a new protein. The amount of light label recycling can be estimated using the following formula:

\[ \frac{1}{2\frac{Intensity\_{NewNew}}{Intensity\_{NewOld}} + 1} = Old (Fraction)\]

Unfortunately MaxQuant does not search for mixed isotope peptides by default. Therefore a second search has to be done if one wants to obtain this information. But this could be different for other platforms.

## 10.1 Adding the information

To add the information on muss-cleaved peptides the `addMiscleavedPeptides()` function can be used. This function adds the data from the second search into a `SilacPeptideExperiment` or a `SilacProteomicsExperiment`. If the analysis has been done using protein data, then a `SilacPeptideExperiment` object with this information is created. In this example the SilacProteinExperiment object will be used because the peptide data in `wormsPE` is not complete.

```
protPE <- ProtExp(wormsPE)

missPE <- addMisscleavedPeptides(x = protPE,
                                 newdata = recycleLightLysine,
                                 idColPept = 'Sequence',
                                 modCol = 'Modifications',
                                 dataCols = c(18:31))

assays(missPE)
```

```
## List of length 2
## names(2): 2 Copy of Lys8 Copy of Lys8
```

There are two assays in the `missPE` object. These contain the intensities for peptides that contain two heavy isotope lysines (new label) and intensities for peptides that contain one heavy and one light isotope lysines.

## 10.2 Calculating light label recycling

To calculate the amount of light label used in protein synthesis the `calculateOldIsotopePool()` function can be used. This function applies the formula mentioned above and adds a new assay with the name of `oldIsotopePool`.

```
names(assays(missPE))[1:2] <- c('int_lys8lys8', 'int_lys8lys0')
missPE <- calculateOldIsotopePool(x = missPE, 'int_lys8lys8', 'int_lys8lys0')
```

Finally the distributions of these pools can be shown in a boxplot.

```
plotDistributionAssay(missPE, assayName = 'oldIsotopePool')
```

```
## Warning: Removed 8722 rows containing non-finite values (stat_boxplot).
```

![](data:image/png;base64...)

The supplemental figure 6B of Visscher et al. (2016) can be reproduced using the above method.

# 11 Interoperability with other packages

The main objective of this package is proteomics turnover analysis, but there are other types of analysis that can be done with the same data: enrichment analysis, differential protein expression, etc. To facilitate the interoperability from `SilacProteinExperiment` and `SilacPeptideExperiment` objects there are coercion methods available to the more general classes such as `SummarizedExperiment` and `data.frame`.

For example, the `DEP` [package](https://bioconductor.org/packages/release/bioc/vignettes/DEP/inst/doc/DEP.html#overview-of-the-analysis) uses the `SummarizedExperiment` class for their differential protein expression analysis functions.

```
protExp <- ProtExp(wormsPE)

as(protExp, 'SummarizedExperiment')
```

```
## class: SummarizedExperiment
## dim: 250 14
## metadata(2): conditionCol timeCol
## assays(5): int_total int_light int_heavy ratio fraction
## rownames: NULL
## rowData names(22): Protein.IDs Majority.protein.IDs ...
##   Peptide.is.razor protein_id
## colnames: NULL
## colData names(2): line timepoint
```

# 12 Session info

```
sessionInfo()
```

```
## R version 3.6.3 (2020-02-29)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.4 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.10-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.10-bioc/R/lib/libRlapack.so
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
## [1] pulsedSilac_1.0.1 BiocStyle_2.14.4
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.4                  lattice_0.20-40
##  [3] assertthat_0.2.1            digest_0.6.25
##  [5] R6_2.4.1                    MuMIn_1.43.15
##  [7] GenomeInfoDb_1.22.0         plyr_1.8.6
##  [9] ggridges_0.5.2              stats4_3.6.3
## [11] evaluate_0.14               ggplot2_3.3.0
## [13] pillar_1.4.3                zlibbioc_1.32.0
## [15] rlang_0.4.5                 magick_2.3
## [17] S4Vectors_0.24.3            R.utils_2.9.2
## [19] R.oo_1.23.0                 Matrix_1.2-18
## [21] rmarkdown_2.1               labeling_0.3
## [23] BiocParallel_1.20.1         stringr_1.4.0
## [25] RCurl_1.98-1.1              munsell_0.5.0
## [27] DelayedArray_0.12.2         compiler_3.6.3
## [29] xfun_0.12                   pkgconfig_2.0.3
## [31] BiocGenerics_0.32.0         htmltools_0.4.0
## [33] tidyselect_1.0.0            SummarizedExperiment_1.16.1
## [35] tibble_2.1.3                gridExtra_2.3
## [37] GenomeInfoDbData_1.2.2      bookdown_0.18
## [39] IRanges_2.20.2              matrixStats_0.56.0
## [41] crayon_1.3.4                dplyr_0.8.5
## [43] bitops_1.0-6                R.methodsS3_1.8.0
## [45] grid_3.6.3                  nlme_3.1-145
## [47] gtable_0.3.0                lifecycle_0.2.0
## [49] magrittr_1.5                scales_1.1.0
## [51] stringi_1.4.6               farver_2.0.3
## [53] XVector_0.26.0              reshape2_1.4.3
## [55] robustbase_0.93-5           cowplot_1.0.0
## [57] tools_3.6.3                 taRifx_1.0.6.1
## [59] Biobase_2.46.0              glue_1.3.2
## [61] DEoptimR_1.0-8              purrr_0.3.3
## [63] parallel_3.6.3              yaml_2.2.1
## [65] colorspace_1.4-1            BiocManager_1.30.10
## [67] UpSetR_1.4.0                GenomicRanges_1.38.0
## [69] knitr_1.28
```

# References

Doherty, Mary K, Colin Whitehead, Heather Mccormack, Simon J Gaskell, and Robert J Beynon. 2005. “Proteome dynamics in complex organisms : Using stable isotopes to monitor individual protein turnover rates,” 522–33. <https://doi.org/10.1002/pmic.200400959>.

McShane, Erik, Celine Sin, Henrik Zauber, Jonathan N. Wells, Neysan Donnelly, Xi Wang, Jingyi Hou, et al. 2016. “Kinetic Analysis of Protein Stability Reveals Age-Dependent Degradation.” *Cell* 167 (3). Elsevier Inc.:803–815.e21. <https://doi.org/10.1016/j.cell.2016.09.015>.

Pratt, Julie M, June Petty, Isabel Riba-garcia, Duncan H L Robertson, Simon J Gaskell, Stephen G Oliver, and Robert J Beynon. 2002. “Dynamics of Protein Turnover , a Missing Dimension in Proteomics \*,” 579–91. <https://doi.org/10.1074/mcp.M200046-MCP200>.

Schwanhäusser, Björn, Manfred Gossen, Gunnar Dittmar, and Matthias Selbach. 2009. “Global analysis of cellular protein translation by pulsed SILAC,” 205–9. <https://doi.org/10.1002/pmic.200800275>.

Visscher, Marieke, Sasha De Henau, Mattheus H.E. Wildschut, Robert M. van Es, Ineke Dhondt, Helen Michels, Patrick Kemmeren, et al. 2016. “Proteome-wide Changes in Protein Turnover Rates in C. elegans Models of Longevity and Age-Related Disease.” *Cell Reports* 16 (11). ElsevierCompany.:3041–51. <https://doi.org/10.1016/j.celrep.2016.08.025>.