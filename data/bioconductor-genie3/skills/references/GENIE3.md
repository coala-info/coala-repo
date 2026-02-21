# GENIE3 vignette

Van Anh Huynh-Thu (vahuynh@uliege.be)

#### 2025-10-30

#### Package

GENIE3 1.32.0

# Contents

* [Format of expression data](#format-of-expression-data)
  + [Format of steady-state expression data](#format-of-steady-state-expression-data)
* [How to run GENIE3](#how-to-run-genie3)
  + [Run GENIE3 with the default parameters](#run-genie3-with-the-default-parameters)
  + [Restrict the candidate regulators to a subset of genes](#restrict-the-candidate-regulators-to-a-subset-of-genes)
  + [Change the tree-based method and its settings](#change-the-tree-based-method-and-its-settings)
  + [Parallel GENIE3](#parallel-genie3)
  + [Obtain more information](#obtain-more-information)
* [Get the list of the regulatory links](#get-the-list-of-the-regulatory-links)
  + [Get all the regulatory links](#get-all-the-regulatory-links)
  + [Get only the top-ranked links](#get-only-the-top-ranked-links)
  + [Get only the links with a weight higher than some threshold](#get-only-the-links-with-a-weight-higher-than-some-threshold)
  + [*Important note* on the interpretation of the weights](#important-note-on-the-interpretation-of-the-weights)
  + [Obtain more information](#obtain-more-information-1)

This is the documentation for the R implementation of GENIE3.

The GENIE3 method is described in:

> Huynh-Thu V. A., Irrthum A., Wehenkel L., and Geurts P. (2010) Inferring regulatory networks from expression data using tree-based methods. *PLoS ONE*, 5(9):e12776.

## Format of expression data

### Format of steady-state expression data

The `GENIE3()` function takes as input argument a gene expression matrix `exprMatr`. Each row of that matrix must correspond to a gene and each column must correspond to a sample. The gene names must be specified in `rownames(exprMatr)`. The sample names can be specified in `colnames(exprMatr)`, but this is not mandatory. For example, the following command lines generate a fake expression matrix (for the purpose of this tutorial only):

```
exprMatr <- matrix(sample(1:10, 100, replace=TRUE), nrow=20)
rownames(exprMatr) <- paste("Gene", 1:20, sep="")
colnames(exprMatr) <- paste("Sample", 1:5, sep="")
head(exprMatr)
```

```
##       Sample1 Sample2 Sample3 Sample4 Sample5
## Gene1      10       3       5       5       8
## Gene2       2       7       6       2       2
## Gene3       9       7       6       8       1
## Gene4       9       7       7       3       8
## Gene5       6       9      10       9       1
## Gene6       6       2       1       6       2
```

This matrix contains the expression data of 20 genes from 5 samples. The expression data does not need to be normalised in any particular way (but whether it is normalized/filtered/log-transformed WILL affect the results!).

## How to run GENIE3

### Run GENIE3 with the default parameters

The following command runs GENIE3 on the expression data `exprMatr` with the default parameters:

```
library(GENIE3)
set.seed(123) # For reproducibility of results
weightMat <- GENIE3(exprMatr)
```

```
dim(weightMat)
```

```
## [1] 20 20
```

```
weightMat[1:5,1:5]
```

```
##            Gene1      Gene2       Gene3      Gene4       Gene5
## Gene1 0.00000000 0.09690928 0.020587175 0.04414538 0.092099809
## Gene2 0.04072364 0.00000000 0.009270253 0.00996494 0.009297827
## Gene3 0.03832475 0.03864980 0.000000000 0.02338944 0.122090728
## Gene4 0.13558821 0.03074694 0.018374538 0.00000000 0.077713840
## Gene5 0.09640476 0.04300721 0.133539357 0.03281287 0.000000000
```

The algorithm outputs a matrix containing the weights of the putative regulatory links, with higher weights corresponding to more likely regulatory links. `weightMat[i,j]` is the weight of the link directed from the \(i\)-th gene to \(j\)-th gene.

### Restrict the candidate regulators to a subset of genes

By default, all the genes in `exprMatr` are used as candidate regulators. The list of candidate regulators can however be restricted to a subset of genes. This can be useful when you know which genes are transcription factors.

```
# Genes that are used as candidate regulators
regulators <- c(2, 4, 7)
# Or alternatively:
regulators <- c("Gene2", "Gene4", "Gene7")
weightMat <- GENIE3(exprMatr, regulators=regulators)
```

Here, only `Gene2`, `Gene4` and `Gene7` (respectively corresponding to rows 2, 4 and 7 in `exprMatr`) were used as candidate regulators. In the resulting `weightMat`, the links that are directed from genes that are not candidate regulators have a weight equal to 0.

To request different regulators for each gene & return as list:

```
regulatorsList <- list("Gene1"=rownames(exprMatr)[1:10],
                       "Gene2"=rownames(exprMatr)[10:20],
                       "Gene20"=rownames(exprMatr)[15:20])
set.seed(123)
weightList <- GENIE3(exprMatr, nCores=1, targets=names(regulatorsList), regulators=regulatorsList, returnMatrix=FALSE)
```

### Change the tree-based method and its settings

GENIE3 is based on regression trees. These trees can be learned using either the Random Forest method 111 Breiman L. (2001) Random forests. *Machine learning*, 45(1):5-32. or the Extra-Trees method 222 Geurts P., Ernst D. and Wehenkel L. (2006) Extremely randomized trees. *Machine learning*, 36(1):3-42.. The tree-based method can be specified using the `tree.method` parameter (`tree.method="RF"` for Random Forests, which is the default choice, or `tree.method="ET"` for Extra-Trees).

Each tree-based method has two parameters: `K` and `ntrees`. `K` is the number of candidate regulators that are randomly selected at each tree node for the best split determination. Let \(p\) be the number of candidate regulators. `K` must be either:

* `"sqrt"`, which sets \(K=\sqrt{p}\). This is the default value.
* `"all"`, which sets \(K=p\).
* Or any integer between \(1\) and \(p\).

The parameter `ntrees` specifies the number of trees that are grown per ensemble. It can be set to any strictly positive integer (the default value is 1000).

An example is shown below:

```
# Use Extra-Trees (ET) method
# 7 randomly chosen candidate regulators at each node of a tree
# 5 trees per ensemble
weightMat <- GENIE3(exprMatr, treeMethod="ET", K=7, nTrees=50)
```

### Parallel GENIE3

To decrease the computing times, GENIE3 can be run on multiple cores. The parameter `ncores` specifies the number of cores you want to use. For example:

```
set.seed(123) # For reproducibility of results
weightMat <- GENIE3(exprMatr, nCores=4, verbose=TRUE)
```

Note that `seet.seed` allows to get the same results across different runs, but only within `nCores==1` or `nCores>1`. e.g. A run with `set.seed(123)` and `nCores=1` and another with the same seed but `nCores>1` may provide different results.

### Obtain more information

```
?GENIE3
```

## Get the list of the regulatory links

### Get all the regulatory links

You can obtain the list of all the regulatory links (from most likely to least likely) with this command:

```
linkList <- getLinkList(weightMat)
dim(linkList)
```

```
## [1] 57  3
```

```
head(linkList)
```

```
##   regulatoryGene targetGene    weight
## 1          Gene7      Gene4 0.8516276
## 2          Gene4      Gene7 0.7749775
## 3          Gene2     Gene10 0.6874191
## 4          Gene4     Gene15 0.6751255
## 5          Gene4     Gene13 0.6714076
## 6          Gene2     Gene11 0.6625960
```

The resulting `linkList` matrix contains the ranking of links. Each row corresponds to a regulatory link. The first column shows the regulator, the second column shows the target gene, and the last column indicates the weight of the link.

(Note that the ranking that is obtained will be slightly different from one run to another. This is due to the intrinsic randomness of the Random Forest and Extra-Trees methods. The variance of the ranking can be decreased by increasing the number of trees per ensemble.)

### Get only the top-ranked links

Usually, one is only interested in extracting the most likely regulatory links. The optional parameter `report.max` sets the number of top-ranked links to report:

```
linkList <- getLinkList(weightMat, reportMax=5)
```

### Get only the links with a weight higher than some threshold

Alternatively, a threshold can be set on the weights of the links:

```
linkList <- getLinkList(weightMat, threshold=0.1)
```

### *Important note* on the interpretation of the weights

The weights of the links returned by `GENIE3()` **do not have any statistical meaning** and only provide a way to rank the regulatory links. There is therefore no standard threshold value, and caution must be taken when choosing one.

### Obtain more information

```
?getLinkList
```