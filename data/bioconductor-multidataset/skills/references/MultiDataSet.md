# Introduction to MultiDataSet

### Carles Hernandez-Ferrer, Carlos Ruiz-Arenas, Juan R. González

| Center for Research in Environmental Epidemiology (CREAL), Barcelona, Spain
| Bioinformatics Research Group in Epidemiology
| ()

#### 2025-10-30

#### Package

MultiDataSet 1.38.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Create a new MultiDataSet](#create-a-new-multidataset)
* [2 Adding sets](#adding-sets)
  + [2.1 General functions](#general-functions)
    - [2.1.1 Add eSet](#add-eset)
    - [2.1.2 Add SummarizedExperiment](#add-summarizedexperiment)
  + [2.2 Specific functions](#specific-functions)
* [3 Subsetting](#subsetting)
  + [3.1 Samples](#samples)
  + [3.2 Tables](#tables)
  + [3.3 GenomicRanges](#genomicranges)
  + [3.4 Multiple subsetting](#multiple-subsetting)
  + [3.5 Advanced subsetting](#advanced-subsetting)

# 1 Introduction

`MultiDataSet` is a new class designed to manage different omic datasets with samples in common. The main purpose when developing `MultiDataSet` was to ease the integration of multiple biological datasets.

`MultiDataSet` is based in Bioconductor’s framework and it can work with S4 classes derived from `eSet` or from `SummarizedExperiment`. The following data is extracted from each set that is added to a `MultiDataSet`:

* The matrix or matrices of data
* The phenotypic data
* The feature data
* A function to recover the original set

It should be taken into account that phenotypic data is stored independently for each set. This allows storing variables with the same name but different values in different sets (e.g. technical variables). Another fact is that feature data is stored in the form of an `AnnotatedDataFrame` and `GenomicRanges`. This design allows to quickly perform subsets using `GenomicRanges` while preserving the possibility of storing sets that do not have genomic coordinates (e.g. metabolic or exposure data).

In this document, addition of sets and subsetting will be presented. Advanced features such as creating new functions to add sets or developing integration functions using `MultiDataSet` are covered in other documents.

In the code below, the libraries needed in this tutorial are loaded:

```
library(MultiDataSet)
library(brgedata)
library(GenomicRanges)
```

## 1.1 Create a new MultiDataSet

`MultiDataSet` objects should be created prior to adding any object using the constructor:

```
multi <- createMultiDataSet()
multi
```

```
## Object of class 'MultiDataSet'
##  . assayData: 0 elements
##  . featureData:
##  . rowRanges:
##  . phenoData:
```

The function `names` recovers the names of sets included in the `MultiDataSet`. Right now, the object is empty so there are no names:

```
names(multi)
```

```
## NULL
```

```
length(names(multi))
```

```
## [1] 0
```

# 2 Adding sets

Sets can be added to `MultiDataSet` using two classes of functions: general and specific. General functions add any `eSet` or `SummarizedExperiment` while specific functions add more specific objects (e.g. `ExpressionSet`).

## 2.1 General functions

General functions directly interact with the `MultiDataSet` and change its content. They only check if the incoming set is an `eSet` or a `SummarizedExperiment`. Due to their flexibility, they are thought to be used by developers to create specific functions.

`MultiDataSet` contains two general functions: `add_eset` and `add_rse`. They work similarly but they are adapted to the particularities of `eSet` and `SummarizedExperiment`. Therefore, their common features will only be covered in the add eSet section.

### 2.1.1 Add eSet

`add_eset` is the general function to add eSet-derived classes. This function has three important arguments. `object` is the `MultiDataSet` where the set will be added, `set` is the `eSet` that will be added and `dataset.type` is the type of the new set. The next lines will illustrate its use by adding an `ExpressionSet` from *brgedata*:

```
data("brge_gexp")
brge_gexp
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 67528 features, 100 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: x0001 x0002 ... x0139 (100 total)
##   varLabels: age sex
##   varMetadata: labelDescription
## featureData
##   featureNames: TC01000001.hg.1 TC01000002.hg.1 ...
##     TCUn_gl000247000001.hg.1 (67528 total)
##   fvarLabels: transcript_cluster_id probeset_id ... notes (11 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

```
multi2 <- add_eset(multi, brge_gexp, dataset.type = "expression")
```

```
## Warning in add_eset(multi, brge_gexp, dataset.type = "expression"): No id
## column found in pData. The id will be equal to the sampleNames
```

```
multi2
```

```
## Object of class 'MultiDataSet'
##  . assayData: 1 elements
##     . expression: 67528 features, 100 samples
##  . featureData:
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . expression: YES
##  . phenoData:
##     . expression: 100 samples, 3 cols (age, ..., sex)
```

```
multi
```

```
## Object of class 'MultiDataSet'
##  . assayData: 0 elements
##  . featureData:
##  . rowRanges:
##  . phenoData:
```

The print of multi2 shows the names of the sets that has been added and, for each set, the number of features and samples and if it has a rowRanges. It should be noticed that `add_eset` **does not modify** the `MultiDataSet` passed in the `object` argument. Consequently, multi is still empty. This property is common of all the functions used to add sets to the `MultiDataSet`.

By default, the name of the incoming set is equal to dataset.type. If we want to add another set of the same type, we can use the argument `dataset.name` to differentiate them. As an example, we will add the same `ExpressionSet` of the previous example but with another name:

```
multi2 <- add_eset(multi2, brge_gexp, dataset.type = "expression", dataset.name = "new")
```

```
## Warning in add_eset(multi2, brge_gexp, dataset.type = "expression",
## dataset.name = "new"): No id column found in pData. The id will be equal to the
## sampleNames
```

```
multi2
```

```
## Object of class 'MultiDataSet'
##  . assayData: 2 elements
##     . expression: 67528 features, 100 samples
##     . expression+new: 67528 features, 100 samples
##  . featureData:
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##     . expression+new: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . expression: YES
##     . expression+new: YES
##  . phenoData:
##     . expression: 100 samples, 3 cols (age, ..., sex)
##     . expression+new: 100 samples, 3 cols (age, ..., sex)
```

If `dataset.name` is used, the resulting name is “dataset.type+dataset.name”. With this strategy, we can have different datasets of the same type and we can still retrieve those datasets corresponding to the same type of data.

In order to assure sample consistency across the difference datasets, we use a common sample identifier across all datasets. Sample identifier should be introduced by adding a column called `id` in the phenotypic data (`phenoData`) of the object. If it is not already present, it is created by default using the sample names of the given set.

Because our `ExpressionSet` does not contain this column, a warning is raised. To solve it, we can manually add an `id` to our dataset:

```
brge_gexp2 <- brge_gexp
brge_gexp2$id <- 1:100
multi2 <- add_eset(multi, brge_gexp2, dataset.type = "expression")
multi2
```

```
## Object of class 'MultiDataSet'
##  . assayData: 1 elements
##     . expression: 67528 features, 100 samples
##  . featureData:
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . expression: YES
##  . phenoData:
##     . expression: 100 samples, 3 cols (age, ..., sex)
```

There are three additional arguments: `warnings`, `overwrite` and `GRanges`. `warnings` can be used to enable or disable the warnings. `overwrite` is used when we want to add a set with a name that is currently used. If TRUE, the set is substituted. If FALSE, nothing is changed:

```
brge_gexp2 <- brge_gexp[, 1:10]
multi2 <- add_eset(multi, brge_gexp, dataset.type = "expression", warnings = FALSE)
multi2
```

```
## Object of class 'MultiDataSet'
##  . assayData: 1 elements
##     . expression: 67528 features, 100 samples
##  . featureData:
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . expression: YES
##  . phenoData:
##     . expression: 100 samples, 3 cols (age, ..., sex)
```

```
multi2 <- add_eset(multi2, brge_gexp2, dataset.type = "expression", warnings = FALSE, overwrite = FALSE)
```

```
## Error in add_eset(multi2, brge_gexp2, dataset.type = "expression", warnings = FALSE, : There is already an object in this slot. Set overwrite = TRUE to overwrite the previous set.
```

```
multi2
```

```
## Object of class 'MultiDataSet'
##  . assayData: 1 elements
##     . expression: 67528 features, 100 samples
##  . featureData:
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . expression: YES
##  . phenoData:
##     . expression: 100 samples, 3 cols (age, ..., sex)
```

```
multi2 <- add_eset(multi2, brge_gexp2, dataset.type = "expression", warnings = FALSE, overwrite = TRUE)
multi2
```

```
## Object of class 'MultiDataSet'
##  . assayData: 1 elements
##     . expression: 67528 features, 10 samples
##  . featureData:
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . expression: YES
##  . phenoData:
##     . expression: 10 samples, 3 cols (age, ..., sex)
```

Finally, `GRanges` argument is used add a `GenomicRanges` with the annotation. By default, a `GenomicRanges` will be generated from the set’s `fData`. With this parameter, we can directly supply a `GenomicRanges` or, if the annotation of our dataset cannot be transformed to a `GenomicRanges` (e.g. proteomic data), we can set this parameter to NA:

```
multi2 <- add_eset(multi, brge_gexp, dataset.type = "expression", warnings = FALSE, GRanges = NA)
multi2
```

```
## Object of class 'MultiDataSet'
##  . assayData: 1 elements
##     . expression: 67528 features, 100 samples
##  . featureData:
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . expression: NO
##  . phenoData:
##     . expression: 100 samples, 3 cols (age, ..., sex)
```

Now, we can see that rowRanges is NO for expression. The implications will be described in the *Filtering by `GenomicRanges`* section.

### 2.1.2 Add SummarizedExperiment

`SummarizedExperiment`s are added using `add_rse`. Its arguments and behavior are very similar to those of `add_eset`. The only difference is that there is `GRanges` argument (annotation data is already in the form of a `GenomicRanges`). To exemplify its use, we will add a `GenomicRatioSet` containing methylation data from *brgedata* package:

```
data("brge_methy")
brge_methy2 <- brge_methy[1:100, ] ### Subset the original set to speed up
```

```
## Loading required namespace: minfi
```

```
## Setting options('download.file.method.GEOquery'='auto')
```

```
## Setting options('GEOquery.inmemory.gpl'=FALSE)
```

```
multi <- createMultiDataSet()
multi2 <- add_rse(multi, brge_methy, dataset.type = "methylation", warnings = FALSE)
```

```
## Warning in add_rse(multi, brge_methy, dataset.type = "methylation", warnings =
## FALSE): No id column found in colData. The id will be equal to the sampleNames
```

```
multi2
```

```
## Object of class 'MultiDataSet'
##  . assayData: 1 elements
##     . methylation: 392277 features, 20 samples
##  . featureData:
##     . methylation: 392277 rows, 19 cols (seqnames, ..., Regulatory_Feature_Group)
##  . rowRanges:
##     . methylation: YES
##  . phenoData:
##     . methylation: 20 samples, 10 cols (age, ..., Neu)
```

## 2.2 Specific functions

Specific functions are designed to add specific datasets to `MultiDataSet`. They call general functions to add the data and they usually perform several checks (e.g: checking the class of the set or checking fData’s columns). As a result, only sets with some features can be introduced to `MultiDataSet` and no later checks on data structure are required. Specific functions should always be used by users to ensure that the sets are properly added to `MultiDataSet`.

In `MultiDataSet` we have introduced four specific functions: `add_genexp`, `add_rnaseq`, `add_methy` and `add_snps`. All these functions has two arguments: `object` with the `MultiDataSet` and a second argument with the incoming set. The name of the second argument depends on the specific function (e.g: gexpSet for `add_genexp`, snpSet for `add_snps`…). Despite we will only show examples of `add_genexp` and `add_snps`, the other specific functions share the same behavior and features.

`add_genexp` adds an `ExpressionSet` to the slot “expression”. We will use the `ExpressionSet` of *brgedata* as example:

```
multi <- createMultiDataSet()
multi2 <- add_genexp(multi, brge_gexp)
```

```
## Warning in add_eset(object, gexpSet, dataset.type = "expression", GRanges =
## range, : No id column found in pData. The id will be equal to the sampleNames
```

```
brge_gexp
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 67528 features, 100 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: x0001 x0002 ... x0139 (100 total)
##   varLabels: age sex
##   varMetadata: labelDescription
## featureData
##   featureNames: TC01000001.hg.1 TC01000002.hg.1 ...
##     TCUn_gl000247000001.hg.1 (67528 total)
##   fvarLabels: transcript_cluster_id probeset_id ... notes (11 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

Given that `add_genexp` calls `add_eset`, the arguments of `add_eset` can also be used but `dataset.type` and `GRanges`. Let’s add the same `ExpressionSet` to another slot using `dataset.name`:

```
multi2 <- add_genexp(multi2, brge_gexp, dataset.name = "2")
```

```
## Warning in add_eset(object, gexpSet, dataset.type = "expression", GRanges =
## range, : No id column found in pData. The id will be equal to the sampleNames
```

```
multi2
```

```
## Object of class 'MultiDataSet'
##  . assayData: 2 elements
##     . expression: 67528 features, 100 samples
##     . expression+2: 67528 features, 100 samples
##  . featureData:
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##     . expression+2: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . expression: YES
##     . expression+2: YES
##  . phenoData:
##     . expression: 100 samples, 3 cols (age, ..., sex)
##     . expression+2: 100 samples, 3 cols (age, ..., sex)
```

# 3 Subsetting

Subsetting of `MultiDataSet`s can be done by samples, by tables or using a `GenomicRanges`. In order to illustrate these operations, we will use the `ExpressionSet` and the `GenomicRatioSet` of *brgedata*. First, we will add these sets to a `MultiDataSet`. The `ExpressionSet` will be added to another slot but setting GRanges = NA:

```
multi <- createMultiDataSet()

# Remove probes without a position before adding the object
multi <- add_methy(multi, brge_methy)
```

```
## Warning in add_rse(object, methySet, dataset.type = "methylation"): No id
## column found in colData. The id will be equal to the sampleNames
```

```
multi <- add_genexp(multi, brge_gexp)
```

```
## Warning in add_eset(object, gexpSet, dataset.type = "expression", GRanges =
## range, : No id column found in pData. The id will be equal to the sampleNames
```

```
multi <- add_eset(multi, brge_gexp, dataset.type = "test", GRanges = NA)
```

```
## Warning in add_eset(multi, brge_gexp, dataset.type = "test", GRanges = NA): No
## id column found in pData. The id will be equal to the sampleNames
```

```
multi
```

```
## Object of class 'MultiDataSet'
##  . assayData: 3 elements
##     . methylation: 392277 features, 20 samples
##     . expression: 67528 features, 100 samples
##     . test: 67528 features, 100 samples
##  . featureData:
##     . methylation: 392277 rows, 19 cols (seqnames, ..., Regulatory_Feature_Group)
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##     . test: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . methylation: YES
##     . expression: YES
##     . test: NO
##  . phenoData:
##     . methylation: 20 samples, 10 cols (age, ..., Neu)
##     . expression: 100 samples, 3 cols (age, ..., sex)
##     . test: 100 samples, 3 cols (age, ..., sex)
```

The expression data contains 100 samples and 67528 features and the methylation data 115 samples and 476946 CpGs.

## 3.1 Samples

Subsetting by samples can be done in two different ways. The first option is to introduce a vector of sample ids. `MultiDataSet` has the operator `[` overloaded and samples are the first element:

```
samples <- sampleNames(brge_gexp)[76:100]
multi[samples, ]
```

```
## Object of class 'MultiDataSet'
##  . assayData: 3 elements
##     . methylation: 392277 features, 2 samples
##     . expression: 67528 features, 25 samples
##     . test: 67528 features, 25 samples
##  . featureData:
##     . methylation: 392277 rows, 19 cols (seqnames, ..., Regulatory_Feature_Group)
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##     . test: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . methylation: YES
##     . expression: YES
##     . test: NO
##  . phenoData:
##     . methylation: 2 samples, 10 cols (age, ..., Neu)
##     . expression: 25 samples, 3 cols (age, ..., sex)
##     . test: 25 samples, 3 cols (age, ..., sex)
```

Samples’ subsetting returns, for each set, all the samples that are present in the filtering vector. In our example, we selected the last 25 samples of the `ExpressionSet`. In the `GenomicRatioSet`, only 9 of these samples were present.

We can also select only those samples that are present in all the datasets with the function `commonSamples`. This method returns a new `MultiDataSet` but only with the common samples:

```
commonSamples(multi)
```

```
## Object of class 'MultiDataSet'
##  . assayData: 3 elements
##     . methylation: 392277 features, 20 samples
##     . expression: 67528 features, 20 samples
##     . test: 67528 features, 20 samples
##  . featureData:
##     . methylation: 392277 rows, 19 cols (seqnames, ..., Regulatory_Feature_Group)
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##     . test: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . methylation: YES
##     . expression: YES
##     . test: NO
##  . phenoData:
##     . methylation: 20 samples, 10 cols (age, ..., Neu)
##     . expression: 20 samples, 3 cols (age, ..., sex)
##     . test: 20 samples, 3 cols (age, ..., sex)
```

```
length(intersect(sampleNames(brge_gexp), sampleNames(brge_methy)))
```

```
## [1] 20
```

The resulting `MultiDataSet` contains 84 samples for expression and methylation, the same that the intersection between the sample names of the original sets.

## 3.2 Tables

We can select the datasets of a `MultiDataSet` using their names. They should be placed in the second position of `[`:

```
multi[, "expression"]
```

```
## Object of class 'MultiDataSet'
##  . assayData: 1 elements
##     . expression: 67528 features, 100 samples
##  . featureData:
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . expression: YES
##  . phenoData:
##     . expression: 100 samples, 3 cols (age, ..., sex)
```

```
multi[, c("methylation", "test")]
```

```
## Object of class 'MultiDataSet'
##  . assayData: 2 elements
##     . methylation: 392277 features, 20 samples
##     . test: 67528 features, 100 samples
##  . featureData:
##     . methylation: 392277 rows, 19 cols (seqnames, ..., Regulatory_Feature_Group)
##     . test: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . methylation: YES
##     . test: NO
##  . phenoData:
##     . methylation: 20 samples, 10 cols (age, ..., Neu)
##     . test: 100 samples, 3 cols (age, ..., sex)
```

If we want to retrieve the original object, we can set `drop = TRUE` or use the `[[` operator:

```
multi[["expression"]]
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 67528 features, 100 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: x0001 x0002 ... x0139 (100 total)
##   varLabels: age sex id
##   varMetadata: labelDescription
## featureData
##   featureNames: TC01000001.hg.1 TC01000002.hg.1 ...
##     TCUn_gl000247000001.hg.1 (67528 total)
##   fvarLabels: transcript_cluster_id probeset_id ... notes (11 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

```
multi[, "expression", drop = TRUE]
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 67528 features, 100 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: x0001 x0002 ... x0139 (100 total)
##   varLabels: age sex id
##   varMetadata: labelDescription
## featureData
##   featureNames: TC01000001.hg.1 TC01000002.hg.1 ...
##     TCUn_gl000247000001.hg.1 (67528 total)
##   fvarLabels: transcript_cluster_id probeset_id ... notes (11 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

## 3.3 GenomicRanges

Finally, `MultiDataSet` can be filtered by `GenomicRanges`. In this case, only those features inside the range will be returned and those datasets without `GenomicRanges` data will be discarded. The GenomicRanges should be placed in the third position of `[`:

```
range <- GRanges("chr17:1-100000")
multi[, , range]
```

```
## Object of class 'MultiDataSet'
##  . assayData: 2 elements
##     . methylation: 36 features, 20 samples
##     . expression: 6 features, 100 samples
##  . featureData:
##     . methylation: 36 rows, 19 cols (seqnames, ..., Regulatory_Feature_Group)
##     . expression: 6 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . methylation: YES
##     . expression: YES
##  . phenoData:
##     . methylation: 20 samples, 10 cols (age, ..., Neu)
##     . expression: 100 samples, 3 cols (age, ..., sex)
```

As a consequence of filtering by `GenomicRanges`, the set “test” that did not have rowRanges have been discarded. If the `GenomicRanges` contains more than one range, features present in any of the ranges are selected:

```
range2 <- GRanges(c("chr17:1-100000", "chr17:1000000-2000000"))
multi[, , range2]
```

```
## Object of class 'MultiDataSet'
##  . assayData: 2 elements
##     . methylation: 685 features, 20 samples
##     . expression: 51 features, 100 samples
##  . featureData:
##     . methylation: 685 rows, 19 cols (seqnames, ..., Regulatory_Feature_Group)
##     . expression: 51 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . methylation: YES
##     . expression: YES
##  . phenoData:
##     . methylation: 20 samples, 10 cols (age, ..., Neu)
##     . expression: 100 samples, 3 cols (age, ..., sex)
```

## 3.4 Multiple subsetting

These three operations can be combined to apply the three filters. In this case, first the sets are selected, then the samples and lastly the features:

```
multi[samples, "expression", range]
```

```
## Object of class 'MultiDataSet'
##  . assayData: 1 elements
##     . expression: 6 features, 25 samples
##  . featureData:
##     . expression: 6 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . expression: YES
##  . phenoData:
##     . expression: 25 samples, 3 cols (age, ..., sex)
```

```
multi[samples, "methylation", range, drop = TRUE]
```

```
## class: GenomicRatioSet
## dim: 36 2
## metadata(0):
## assays(1): Beta
## rownames(36): cg09002677 cg21726327 ... cg17224754 cg11788856
## rowData names(14): Forward_Sequence SourceSeq ...
##   Regulatory_Feature_Group DHS
## colnames(2): x0077 x0079
## colData names(10): age sex ... Neu id
## Annotation
##   array: IlluminaHumanMethylation450k
##   annotation: ilmn12.hg19
## Preprocessing
##   Method: NA
##   minfi version: NA
##   Manifest version: NA
```

## 3.5 Advanced subsetting

The base R function `subset` can be used to perform advanced subsetting. This function can be used to filter the features by a column each dataset feature data. For instance, we can use this function to select all the features associated to a gene:

```
subset(multi, genes == "SLC35E2")
```

```
## Warning in .local(x, ...): The following sets could not be filtered by feature
## id: expression, test
```

```
## Object of class 'MultiDataSet'
##  . assayData: 3 elements
##     . methylation: 1 features, 20 samples
##     . expression: 67528 features, 100 samples
##     . test: 67528 features, 100 samples
##  . featureData:
##     . methylation: 1 rows, 19 cols (seqnames, ..., Regulatory_Feature_Group)
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##     . test: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . methylation: YES
##     . expression: YES
##     . test: NO
##  . phenoData:
##     . methylation: 20 samples, 10 cols (age, ..., Neu)
##     . expression: 100 samples, 3 cols (age, ..., sex)
##     . test: 100 samples, 3 cols (age, ..., sex)
```

This line returns a `MultiDataSet` with the features associated to the gene SLC35E2. The expression uses `genes` because it is a column that is common to the datasets include in `multi`. This function accepts any expression that returns a logical. Therefore, we can also use the `%in%` operator or include more than one expression:

```
subset(multi, genes %in% c("SLC35E2", "IPO13", "TRPV1"))
```

```
## Warning in .local(x, ...): The following sets could not be filtered by feature
## id: expression, test
```

```
## Object of class 'MultiDataSet'
##  . assayData: 3 elements
##     . methylation: 19 features, 20 samples
##     . expression: 67528 features, 100 samples
##     . test: 67528 features, 100 samples
##  . featureData:
##     . methylation: 19 rows, 19 cols (seqnames, ..., Regulatory_Feature_Group)
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##     . test: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . methylation: YES
##     . expression: YES
##     . test: NO
##  . phenoData:
##     . methylation: 20 samples, 10 cols (age, ..., Neu)
##     . expression: 100 samples, 3 cols (age, ..., sex)
##     . test: 100 samples, 3 cols (age, ..., sex)
```

```
subset(multi, genes == "EEF1A1" | genes == "LPP")
```

```
## Warning in .local(x, ...): The following sets could not be filtered by feature
## id: expression, test
```

```
## Object of class 'MultiDataSet'
##  . assayData: 3 elements
##     . methylation: 37 features, 20 samples
##     . expression: 67528 features, 100 samples
##     . test: 67528 features, 100 samples
##  . featureData:
##     . methylation: 37 rows, 19 cols (seqnames, ..., Regulatory_Feature_Group)
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##     . test: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . methylation: YES
##     . expression: YES
##     . test: NO
##  . phenoData:
##     . methylation: 20 samples, 10 cols (age, ..., Neu)
##     . expression: 100 samples, 3 cols (age, ..., sex)
##     . test: 100 samples, 3 cols (age, ..., sex)
```

A similar approach can be used for selection samples with a common phenotype. In this case, we should pass the expression in the third argument and the column must also be present in the phenodata of the datasets:

```
subset(multi, , sex == "Female")
```

```
## Object of class 'MultiDataSet'
##  . assayData: 3 elements
##     . methylation: 392277 features, 11 samples
##     . expression: 67528 features, 48 samples
##     . test: 67528 features, 48 samples
##  . featureData:
##     . methylation: 392277 rows, 19 cols (seqnames, ..., Regulatory_Feature_Group)
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##     . test: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . methylation: YES
##     . expression: YES
##     . test: NO
##  . phenoData:
##     . methylation: 11 samples, 10 cols (age, ..., Neu)
##     . expression: 48 samples, 3 cols (age, ..., sex)
##     . test: 48 samples, 3 cols (age, ..., sex)
```

With this line of code, we can select all the women of the study. Both subsetting can be applied at the same time:

```
subset(multi, genes == "SLC35E2", sex == "Female")
```

```
## Warning in .local(x, ...): The following sets could not be filtered by feature
## id: expression, test
```

```
## Object of class 'MultiDataSet'
##  . assayData: 3 elements
##     . methylation: 1 features, 11 samples
##     . expression: 67528 features, 48 samples
##     . test: 67528 features, 48 samples
##  . featureData:
##     . methylation: 1 rows, 19 cols (seqnames, ..., Regulatory_Feature_Group)
##     . expression: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##     . test: 67528 rows, 11 cols (transcript_cluster_id, ..., gene_assignment)
##  . rowRanges:
##     . methylation: YES
##     . expression: YES
##     . test: NO
##  . phenoData:
##     . methylation: 11 samples, 10 cols (age, ..., Neu)
##     . expression: 48 samples, 3 cols (age, ..., sex)
##     . test: 48 samples, 3 cols (age, ..., sex)
```