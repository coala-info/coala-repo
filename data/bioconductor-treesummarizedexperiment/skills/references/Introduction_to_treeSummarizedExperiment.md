# Introduction to TreeSummarizedExperiment

Ruizhu HUANG1,2, Charlotte Soneson1,2 and Mark Robinson1,2

1Institute of Molecular Life Sciences, University of Zurich.
2SIB Swiss Institute of Bioinformatics.

#### 30 October 2025

#### Package

TreeSummarizedExperiment 2.18.0

# Contents

* [1 Introduction](#introduction)
* [2 TreeSummarizedExperiment](#tse-class)
  + [2.1 Anatomy of TreeSummarizedExperiment](#anatomy-of-treesummarizedexperiment)
  + [2.2 Toy data](#toy-data)
  + [2.3 The construction of `TreeSummarizedExperiment`](#the-construction-of-treesummarizedexperiment)
  + [2.4 The accessor functions](#the-accessor-functions)
    - [2.4.1 Assays, rowData, colData, and metadata](#assays-rowdata-coldata-and-metadata)
    - [2.4.2 rowTree, colTree, rowLinks, colLinks](#linkData)
    - [2.4.3 Reference sequence data](#refSeq)
  + [2.5 The subseting function](#the-subseting-function)
  + [2.6 Changing the tree](#change-tree)
  + [2.7 Aggregation](#aggregation)
    - [2.7.1 The column dimension](#aggCol)
    - [2.7.2 The row dimension](#aggRow)
    - [2.7.3 Both dimensions](#both-dimensions)
  + [2.8 Functions operating on the `phylo` object.](#functions-operating-on-the-phylo-object.)
    - [2.8.1 Conversion of the node label and the node number](#conversion-of-the-node-label-and-the-node-number)
    - [2.8.2 Find the descendants](#find-the-descendants)
    - [2.8.3 More functions](#more-functions)
  + [2.9 Custom functions for the `TreeSummarizedExperiment` class](#modifyLink)
* [3 Session Info](#session-info)
* [Reference](#reference)

# 1 Introduction

The `TreeSummarizedExperiment` class is an extension of the
`SingleCellExperiment` class (Lun and Risso [2020](#ref-LunA2020)). It’s used to store rectangular data
of experimental results as in a `SingleCellExperiment`, and also supports the
storage of a hierarchical structure and its link information to the rectangular
data.

# 2 TreeSummarizedExperiment

## 2.1 Anatomy of TreeSummarizedExperiment

![The structure of the TreeSummarizedExperiment class.](data:image/png;base64...)

Figure 1: The structure of the TreeSummarizedExperiment class

Compared to the `SingleCellExperiment` objects, `TreeSummarizedExperiment` has
five additional slots:

* `rowTree`: the hierarchical structure on the rows of the `assays`.
* `rowLinks`: the link information between rows of the `assays` and the `rowTree`.
* `colTree`: the hierarchical structure on the columns of the `assays`.
* `colLinks`: the link information between columns of the `assays` and the
  `colTree`.
* `referenceSeq` (optional): the reference sequence data per feature (row).

The `rowTree` and\(/\)or `colTree` can be left empty (`NULL`) if no trees are
available; in this case, the `rowLinks` and\(/\)or `colLinks` are also set to
`NULL`. All other `TreeSummarizedExperiment` slots are inherited from
`SingleCellExperiment`.

The `rowTree` and `colTree` slots require the tree to be an object of the
`phylo` class. If a tree is available in an alternative format, it can often be
converted to a `phylo` object using dedicated R packages (e.g., `r Biocpkg("treeio")` (Wang et al. [2019](#ref-Wang2019))).

The `referenceSeq` slot is optional. It accepts the reference sequence data of
features either as `DNAStringSet` or `DNAStringSetList`. More details are in
[2.4.3](#refSeq).

Functions in the *[TreeSummarizedExperiment](https://bioconductor.org/packages/3.22/TreeSummarizedExperiment)* package fall in two
main categories: operations on the `TreeSummarizedExperiment` object or
operations on the tree (`phylo`) objects. The former includes constructors and
accessors, and the latter serves as “pieces” to be assembled as accessors or
functions that manipulate the `TreeSummarizedExperiment` object. Given that more
than 200 R packages make use of the `phylo` class, there are many resources
(e.g., *[ape](https://CRAN.R-project.org/package%3Dape)*) for users to manipulate the small “pieces” in
addition to those provided in *[TreeSummarizedExperiment](https://bioconductor.org/packages/3.22/TreeSummarizedExperiment)*.

## 2.2 Toy data

We generate a toy dataset that has observations of 6 entities collected from 4
samples as an example to show how to construct a `TreeSummarizedExperiment`
object.

```
library(TreeSummarizedExperiment)

# assays data (typically, representing observed data from an experiment)
assay_data <- rbind(rep(0, 4), matrix(1:20, nrow = 5))
colnames(assay_data) <- paste0("sample", 1:4)
rownames(assay_data) <- paste("entity", seq_len(6), sep = "")
assay_data
```

```
##         sample1 sample2 sample3 sample4
## entity1       0       0       0       0
## entity2       1       6      11      16
## entity3       2       7      12      17
## entity4       3       8      13      18
## entity5       4       9      14      19
## entity6       5      10      15      20
```

The information of entities and samples are given in the **row\_data** and
**col\_data**, respectively.

```
# row data (feature annotations)
row_data <- data.frame(Kingdom = "A",
                       Phylum = rep(c("B1", "B2"), c(2, 4)),
                       Class = rep(c("C1", "C2", "C3"), each = 2),
                       OTU = paste0("D", 1:6),
                       row.names = rownames(assay_data),
                       stringsAsFactors = FALSE)

row_data
```

```
##         Kingdom Phylum Class OTU
## entity1       A     B1    C1  D1
## entity2       A     B1    C1  D2
## entity3       A     B2    C2  D3
## entity4       A     B2    C2  D4
## entity5       A     B2    C3  D5
## entity6       A     B2    C3  D6
```

```
# column data (sample annotations)
col_data <- data.frame(gg = c(1, 2, 3, 3),
                       group = rep(LETTERS[1:2], each = 2),
                       row.names = colnames(assay_data),
                       stringsAsFactors = FALSE)
col_data
```

```
##         gg group
## sample1  1     A
## sample2  2     A
## sample3  3     B
## sample4  3     B
```

The hierarchical structure of the 6 entities and `r ncol(assay_data)` samples are denoted as **row\_tree** and **col\_tree**,
respectively. The two trees are `phylo` objects randomly created with `rtree`
from the package *[ape](https://CRAN.R-project.org/package%3Dape)*. Note that the row tree has 5 rather than 6
leaves; this is used later to show that multiple rows in the `assays` are
allowed to map to a single node in the tree.

```
library(ape)

# The first toy tree
set.seed(12)
row_tree <- rtree(5)

# The second toy tree
set.seed(12)
col_tree <- rtree(4)

# change node labels
col_tree$tip.label <- colnames(assay_data)
col_tree$node.label <- c("All", "GroupA", "GroupB")
```

We visualize the tree using the package *[ggtree](https://bioconductor.org/packages/3.22/ggtree)* (Yu et al. [2017](#ref-Yu2017)). Here,
the internal nodes of the **row\_tree** have no labels as shown in Figure
[2](#fig:plot-rtree).

```
library(ggtree)
library(ggplot2)

# Visualize the row tree
ggtree(row_tree, size = 2, branch.length = "none") +
    geom_text2(aes(label = node), color = "darkblue",
               hjust = -0.5, vjust = 0.7, size = 5.5) +
    geom_text2(aes(label = label), color = "darkorange",
               hjust = -0.1, vjust = -0.7, size = 5.5)
```

![\label{plot-rtree} The structure of the row tree. The node labels and the node numbers are in orange and blue text, respectively.](data:image/png;base64...)

Figure 2: The structure of the row tree
The node labels and the node numbers are in orange and blue text, respectively.

The **col\_tree** has labels for internal nodes.

```
# Visualize the column tree
ggtree(col_tree, size = 2, branch.length = "none") +
    geom_text2(aes(label = node), color = "darkblue",
               hjust = -0.5, vjust = 0.7, size = 5.5) +
    geom_text2(aes(label = label), color = "darkorange",
               hjust = -0.1, vjust = -0.7, size = 5.5)+
    ylim(c(0.8, 4.5)) +
    xlim(c(0, 2.2))
```

![\label{plot-ctree} The structure of the column tree. The node labels and the node numbers are in orange and blue text, respectively.](data:image/png;base64...)

Figure 3: The structure of the column tree
The node labels and the node numbers are in orange and blue text, respectively.

## 2.3 The construction of `TreeSummarizedExperiment`

The `TreeSummarizedExperiment` class is used to store the toy data generated in the previous section:
**assay\_data**, **row\_data**, **col\_data**, **col\_tree** and **row\_tree**. To
correctly store data, the link information between the rows (or columns) of
**assay\_data** and the nodes of the **row\_tree** (or **col\_tree**) can be provided via a character vector `rowNodeLab` (or `colNodeLab`), with length equal to the number of rows (or columns) of the `assays`; otherwise the row (or column) names are used. Those columns
or rows with labels that are not present among the node labels of the tree are removed with
warnings. The link data between the `assays` tables and the tree data is
automatically generated in the construction.

The row and column trees can be included simultaneously in the construction.
Here, the column names of **assay\_data** can be found in the node labels of the
column tree, which enables the link to be created between the column dimension
of **assay\_data** and the column tree **col\_tree**. If the row names of
**assay\_data** are not in the node labels of **row\_tree**, we would need to
provide their corresponding node labels (**row\_lab**) to `rowNodeLab` in the
construction of the object. It is allowed to have multiple rows or/and columns
mapped to a node, for example, the same leaf label is used for the first two
rows in **row\_lab**.

```
# all column names could be found in the node labels of the column tree
all(colnames(assay_data) %in% c(col_tree$tip.label, col_tree$node.label))
```

```
## [1] TRUE
```

```
# provide the node labels in rowNodeLab
tip_lab <- row_tree$tip.label
row_lab <- tip_lab[c(1, 1:5)]
row_lab
```

```
## [1] "t3" "t3" "t2" "t1" "t5" "t4"
```

```
both_tse <- TreeSummarizedExperiment(assays = list(Count = assay_data),
                                     rowData = row_data,
                                     colData = col_data,
                                     rowTree = row_tree,
                                     rowNodeLab = row_lab,
                                     colTree = col_tree)
```

```
both_tse
```

```
## class: TreeSummarizedExperiment
## dim: 6 4
## metadata(0):
## assays(1): Count
## rownames(6): entity1 entity2 ... entity5 entity6
## rowData names(4): Kingdom Phylum Class OTU
## colnames(4): sample1 sample2 sample3 sample4
## colData names(2): gg group
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (6 rows)
## rowTree: 1 phylo tree(s) (5 leaves)
## colLinks: a LinkDataFrame (4 rows)
## colTree: 1 phylo tree(s) (4 leaves)
```

When printing out **both\_tse**, we see a similar message as
`SingleCellExperiment` with four additional lines for `rowLinks`, `rowTree`,
`colLinks` and `colTree`.

## 2.4 The accessor functions

### 2.4.1 Assays, rowData, colData, and metadata

For slots inherited from the `SingleCellExperiment` class, the accessors are
exactly the same as shown in *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*. These
accessors are both setters and getters.

```
# to get the first table in the assays
(count <- assays(both_tse)[[1]])
```

```
##         sample1 sample2 sample3 sample4
## entity1       0       0       0       0
## entity2       1       6      11      16
## entity3       2       7      12      17
## entity4       3       8      13      18
## entity5       4       9      14      19
## entity6       5      10      15      20
```

```
# to get row data
rowData(both_tse)
```

```
## DataFrame with 6 rows and 4 columns
##             Kingdom      Phylum       Class         OTU
##         <character> <character> <character> <character>
## entity1           A          B1          C1          D1
## entity2           A          B1          C1          D2
## entity3           A          B2          C2          D3
## entity4           A          B2          C2          D4
## entity5           A          B2          C3          D5
## entity6           A          B2          C3          D6
```

```
# to get column data
colData(both_tse)
```

```
## DataFrame with 4 rows and 2 columns
##                gg       group
##         <numeric> <character>
## sample1         1           A
## sample2         2           A
## sample3         3           B
## sample4         3           B
```

```
# to get metadata: it's empty here
metadata(both_tse)
```

```
## list()
```

### 2.4.2 rowTree, colTree, rowLinks, colLinks

For new slots, we provide `rowTree` (and `colTree`) to retrieve the row (column)
trees, and `rowLinks` (and `colLinks`) to retrieve the link information between
`assays` and nodes of the row (column) tree. If the tree is not available, the
corresponding link data is `NULL`.

```
# get trees
rowTree(both_tse)
```

```
##
## Phylogenetic tree with 5 tips and 4 internal nodes.
##
## Tip labels:
##   t3, t2, t1, t5, t4
##
## Rooted; includes branch length(s).
```

```
colTree(both_tse)
```

```
##
## Phylogenetic tree with 4 tips and 3 internal nodes.
##
## Tip labels:
##   sample1, sample2, sample3, sample4
## Node labels:
##   All, GroupA, GroupB
##
## Rooted; includes branch length(s).
```

`rowTree` and `colTree` can work not only as getters but also as setters. The
replacement requires that the row/col names of the **TSE** object can be matched
to node labels of the new row/col tree; otherwise `changeTree` should be used
with `rowNodeLab` or `colNodeLab` available [2.6](#change-tree).

```
new_tse <- both_tse

# a new tree
new_tree <- rtree(nrow(new_tse))
new_tree$tip.label <- rownames(new_tse)

# the original row tree is replaced with the new tree
rowTree(new_tse) <- new_tree
identical(rowTree(new_tse), rowTree(both_tse))
```

```
## [1] FALSE
```

```
identical(rowTree(new_tse), new_tree)
```

```
## [1] TRUE
```

`rowLinks` and `colLinks` only work as getters.

```
# access the link data
(r_link <- rowLinks(both_tse))
```

```
## LinkDataFrame with 6 rows and 5 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##         <character>   <character> <integer> <logical> <character>
## entity1          t3       alias_1         1      TRUE       phylo
## entity2          t3       alias_1         1      TRUE       phylo
## entity3          t2       alias_2         2      TRUE       phylo
## entity4          t1       alias_3         3      TRUE       phylo
## entity5          t5       alias_4         4      TRUE       phylo
## entity6          t4       alias_5         5      TRUE       phylo
```

```
(c_link <- colLinks(both_tse))
```

```
## LinkDataFrame with 4 rows and 5 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##         <character>   <character> <integer> <logical> <character>
## sample1     sample1       alias_1         1      TRUE       phylo
## sample2     sample2       alias_2         2      TRUE       phylo
## sample3     sample3       alias_3         3      TRUE       phylo
## sample4     sample4       alias_4         4      TRUE       phylo
```

The link data objects are of the `LinkDataFrame` class, which extends the `DataFrame` class with the restriction that it has at least four columns:

* `nodeLab`: the labels of nodes on the tree
* `nodeLab_alias`: the alias labels of nodes on the tree
* `nodeNum`: the numbers of nodes on the tree
* `isLeaf`: whether the node is a leaf node
* `whichTree`: the name of the tree that is mapped to (See vignette 2).

More details about
the `DataFrame` class could be found in the *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* R/Bioconductor package.

```
class(r_link)
```

```
## [1] "LinkDataFrame"
## attr(,"package")
## [1] "TreeSummarizedExperiment"
```

```
showClass("LinkDataFrame")
```

```
## Class "LinkDataFrame" [package "TreeSummarizedExperiment"]
##
## Slots:
##
## Name:           rownames             nrows       elementType   elementMetadata
## Class: character_OR_NULL           integer         character DataFrame_OR_NULL
##
## Name:           metadata          listData
## Class:              list              list
##
## Extends:
## Class "DFrame", directly
## Class "LinkDataFrame_Or_NULL", directly
## Class "DataFrame", by class "DFrame", distance 2
## Class "SimpleList", by class "DFrame", distance 2
## Class "RectangularData", by class "DFrame", distance 3
## Class "List", by class "DFrame", distance 3
## Class "DataFrame_OR_NULL", by class "DFrame", distance 3
## Class "Vector", by class "DFrame", distance 4
## Class "list_OR_List", by class "DFrame", distance 4
## Class "Annotated", by class "DFrame", distance 5
## Class "vector_OR_Vector", by class "DFrame", distance 5
```

The link data is automatically generated when constructing the
`TreeSummarizedExperiment` object. We highly recommend users not to modify it
manually; otherwise the link might be broken. For R packages developers, we show
in the Section [2.9](#modifyLink) about how to update the link.

### 2.4.3 Reference sequence data

In addition to tree data, reference sequence data can be stored per feature in
a `TreeSummarizedExperiment` object.

```
refSeq <- DNAStringSet(rep("AGCT", nrow(both_tse)))
```

The data must match the number of rows in the object and can either be added to
the object upon creation or later on with the accessor function `referenceSeq`.

```
referenceSeq(both_tse) <- refSeq
referenceSeq(both_tse)
```

```
## DNAStringSet object of length 6:
##     width seq                                               names
## [1]     4 AGCT                                              entity1
## [2]     4 AGCT                                              entity2
## [3]     4 AGCT                                              entity3
## [4]     4 AGCT                                              entity4
## [5]     4 AGCT                                              entity5
## [6]     4 AGCT                                              entity6
```

Both `DNAStringSet` or `DNAStringSetList` can be used, so that a single or
multiple sequences can be stored per feature.

Now, one new line in the message is shown for the `referenceSeq` slot.

```
both_tse
```

```
## class: TreeSummarizedExperiment
## dim: 6 4
## metadata(0):
## assays(1): Count
## rownames(6): entity1 entity2 ... entity5 entity6
## rowData names(4): Kingdom Phylum Class OTU
## colnames(4): sample1 sample2 sample3 sample4
## colData names(2): gg group
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (6 rows)
## rowTree: 1 phylo tree(s) (5 leaves)
## colLinks: a LinkDataFrame (4 rows)
## colTree: 1 phylo tree(s) (4 leaves)
## referenceSeq: a DNAStringSet (6 sequences)
```

## 2.5 The subseting function

A `TreeSummarizedExperiment` object can be subset in two different ways: `[` to
subset by rows or columns, and `subsetByNode` to subset by nodes of a tree. As
the numeric ID of a node changes with the cut of a `phylo` tree, to keep track
of the original data, we do not update the tree structure in the subsetting.

```
sub_tse <- both_tse[1:2, 1]
sub_tse
```

```
## class: TreeSummarizedExperiment
## dim: 2 1
## metadata(0):
## assays(1): Count
## rownames(2): entity1 entity2
## rowData names(4): Kingdom Phylum Class OTU
## colnames(1): sample1
## colData names(2): gg group
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (2 rows)
## rowTree: 1 phylo tree(s) (5 leaves)
## colLinks: a LinkDataFrame (1 rows)
## colTree: 1 phylo tree(s) (4 leaves)
## referenceSeq: a DNAStringSet (2 sequences)
```

```
# The tree stays the same
identical(rowTree(sub_tse), rowTree(both_tse))
```

```
## [1] TRUE
```

`rowData`, `rowLinks`, `colData`, and `colLinks` are updated accordingly.

```
# the row data
rowData(sub_tse)
```

```
## DataFrame with 2 rows and 4 columns
##             Kingdom      Phylum       Class         OTU
##         <character> <character> <character> <character>
## entity1           A          B1          C1          D1
## entity2           A          B1          C1          D2
```

```
# the row link data
rowLinks(sub_tse)
```

```
## LinkDataFrame with 2 rows and 5 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##         <character>   <character> <integer> <logical> <character>
## entity1          t3       alias_1         1      TRUE       phylo
## entity2          t3       alias_1         1      TRUE       phylo
```

```
# The first four columns are from colLinks data and the others from colData
cbind(colLinks(sub_tse), colData(sub_tse))
```

```
## DataFrame with 1 row and 7 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree        gg
##         <character>   <character> <integer> <logical> <character> <numeric>
## sample1     sample1       alias_1         1      TRUE       phylo         1
##               group
##         <character>
## sample1           A
```

To subset by nodes, we specify the node by its node label or node number. Here,
*entity1* and *entity2* are both mapped to the same node `t3`, so both of them
are retained.

```
node_tse <- subsetByNode(x = both_tse, rowNode = "t3")

rowLinks(node_tse)
```

```
## LinkDataFrame with 2 rows and 5 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##         <character>   <character> <integer> <logical> <character>
## entity1          t3       alias_1         1      TRUE       phylo
## entity2          t3       alias_1         1      TRUE       phylo
```

Subsetting simultaneously in both dimensions is also allowed.

```
node_tse <- subsetByNode(x = both_tse, rowNode = "t3",
                         colNode = c("sample1", "sample2"))
assays(node_tse)[[1]]
```

```
##         sample1 sample2
## entity1       0       0
## entity2       1       6
```

## 2.6 Changing the tree

The current tree can be replaced by a new one using `changeTree`. If the
hierarchical information is available as a `data.frame` with each column
representing a taxonomic level (e.g., *row\_data*), we provide `toTree` to
convert it into a `phylo` object.

```
# The toy taxonomic table
(taxa <- rowData(both_tse))
```

```
## DataFrame with 6 rows and 4 columns
##             Kingdom      Phylum       Class         OTU
##         <character> <character> <character> <character>
## entity1           A          B1          C1          D1
## entity2           A          B1          C1          D2
## entity3           A          B2          C2          D3
## entity4           A          B2          C2          D4
## entity5           A          B2          C3          D5
## entity6           A          B2          C3          D6
```

```
# convert it to a phylo tree
taxa_tree <- toTree(data = taxa)

# Viz the new tree
ggtree(taxa_tree)+
    geom_text2(aes(label = node), color = "darkblue",
               hjust = -0.5, vjust = 0.7, size = 5.5) +
    geom_text2(aes(label = label), color = "darkorange",
               hjust = -0.1, vjust = -0.7, size = 5.5) +
    geom_point2()
```

![\label{plot-taxa2phylo} The structure of the taxonomic tree that is generated from the taxonomic table.](data:image/png;base64...)

Figure 4: The structure of the taxonomic tree that is generated from the taxonomic table

A mapping to match nodes of the two trees is required if nodes are labeled differently.

```
taxa_tse <- changeTree(x = both_tse, rowTree = taxa_tree,
                       rowNodeLab = taxa[["OTU"]])

taxa_tse
```

```
## class: TreeSummarizedExperiment
## dim: 6 4
## metadata(0):
## assays(1): Count
## rownames(6): entity1 entity2 ... entity5 entity6
## rowData names(4): Kingdom Phylum Class OTU
## colnames(4): sample1 sample2 sample3 sample4
## colData names(2): gg group
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (6 rows)
## rowTree: 1 phylo tree(s) (6 leaves)
## colLinks: a LinkDataFrame (4 rows)
## colTree: 1 phylo tree(s) (4 leaves)
## referenceSeq: a DNAStringSet (6 sequences)
```

```
rowLinks(taxa_tse)
```

```
## LinkDataFrame with 6 rows and 5 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##         <character>   <character> <integer> <logical> <character>
## entity1          D1       alias_1         1      TRUE       phylo
## entity2          D2       alias_2         2      TRUE       phylo
## entity3          D3       alias_3         3      TRUE       phylo
## entity4          D4       alias_4         4      TRUE       phylo
## entity5          D5       alias_5         5      TRUE       phylo
## entity6          D6       alias_6         6      TRUE       phylo
```

## 2.7 Aggregation

Since it may be of interest to report or analyze observed data on multiple
resolutions based on the provided tree, the `TreeSummarizedExperiment` package
offers functionionality to flexibly aggregate data to different levels of a
tree.

### 2.7.1 The column dimension

Here, we show the aggregation along the column dimension. The desired
aggregation level is given in the `colLevel` argument, which can be specified
via the node label (orange text in Figure [3](#fig:plot-ctree)) or the node
number (blue text in Figure [3](#fig:plot-ctree)). We could further specify how
to aggregate via the argument `colFun`.

```
# use node labels to specify colLevel
agg_col <- aggTSE(x = taxa_tse,
                  colLevel = c("GroupA", "GroupB"),
                  colFun = sum)

# or use node numbers to specify colLevel
agg_col <- aggTSE(x = taxa_tse, colLevel = c(6, 7), colFun = sum)
```

```
assays(agg_col)[[1]]
```

```
##         alias_6 alias_7
## entity1       0       0
## entity2       7      27
## entity3       9      29
## entity4      11      31
## entity5      13      33
## entity6      15      35
```

The `rowData` does not change, but the `colData` adjusts with the change of the
`assays` table. For example, the column **group** has the `A` value for
`GroupA` because the descendant nodes of `GroupA` all have the value `A`; the
column **gg** has the `NA` value for `GroupA` because the descendant nodes of
`GroupA` have different values, (1 and 2).

```
# before aggregation
colData(taxa_tse)
```

```
## DataFrame with 4 rows and 2 columns
##                gg       group
##         <numeric> <character>
## sample1         1           A
## sample2         2           A
## sample3         3           B
## sample4         3           B
```

```
# after aggregation
colData(agg_col)
```

```
## DataFrame with 2 rows and 2 columns
##                gg       group
##         <numeric> <character>
## alias_6        NA           A
## alias_7         3           B
```

We can decide which columns of `colData` to keep in the final output using
`colDataCols`. In situation with big data, this can speed up the aggregation by
dropping data that is not relevant. More arguments for `aggTSE` (e.g.,
`whichAssay`, `BPPARAM`) are available to customize the aggregation or to provide
parallel computation (`?aggTSE`).

```
agg_col <- aggTSE(x = taxa_tse, colLevel = c(6, 7),
                  colFun = sum, colDataCols = "group")
colData(agg_col)
```

```
## DataFrame with 2 rows and 1 column
##               group
##         <character>
## alias_6           A
## alias_7           B
```

The `colLinks` is updated to link the new rows of `assays` tables and the column
tree.

```
# the link data is updated
colLinks(agg_col)
```

```
## LinkDataFrame with 2 rows and 5 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##         <character>   <character> <integer> <logical> <character>
## alias_6      GroupA       alias_6         6     FALSE       phylo
## alias_7      GroupB       alias_7         7     FALSE       phylo
```

From Figure [3](#fig:plot-ctree), nodes 6 and 7 are
labeled with `GroupA` and `GroupB`, respectively, which agrees with the
column link data.

### 2.7.2 The row dimension

Similarly, we could aggregate the data to the phylum level by providing the
names of the internal nodes that represent the phylum level (see `taxa_one`
below).

```
# the phylum level
taxa <- c(taxa_tree$tip.label, taxa_tree$node.label)
(taxa_one <- taxa[startsWith(taxa, "Phylum:")])
```

```
## [1] "Phylum:B1" "Phylum:B2"
```

```
# aggregation
agg_taxa <- aggTSE(x = taxa_tse, rowLevel = taxa_one, rowFun = sum)
assays(agg_taxa)[[1]]
```

```
##          sample1 sample2 sample3 sample4
## alias_8        1       6      11      16
## alias_10      14      34      54      74
```

The user is nonetheless free to choose nodes from different taxonomic ranks. Note that not all rows in the original table are included in one of the aggregated rows. Similarly, it is possible for a row to contribute to multiple aggregated rows

```
# A mixed level
taxa_mix <- c("Class:C3", "Phylum:B1")
agg_any <- aggTSE(x = taxa_tse, rowLevel = taxa_mix, rowFun = sum)
rowData(agg_any)
```

```
## DataFrame with 2 rows and 4 columns
##              Kingdom      Phylum       Class       OTU
##          <character> <character> <character> <logical>
## alias_12           A          B2          C3        NA
## alias_8            A          B1          C1        NA
```

### 2.7.3 Both dimensions

The aggregation on both dimensions could be performed in one step using
`aggTSE`. The aggregate functions for the row and the column are specificed via
`rowFun` and `colFun`, respectively. The aggregation order is determined using
`rowFirst`. Here, we set `rowFirst = FALSE` to firstly aggregate on the column
dimension, and then on the row dimension.

```
agg_both <- aggTSE(x = both_tse, colLevel = c(6, 7),
                   rowLevel = 7:9, rowFun = sum,
                   colFun = mean, rowFirst = FALSE)
```

As expected, we obtain a table with 3 rows (`rowLevel = 7:9`) and 2 columns
(`colLevel = c(6, 7)`).

```
assays(agg_both)[[1]]
```

```
##         alias_6 alias_7
## alias_7     8.0    28.0
## alias_8    19.5    49.5
## alias_9    12.0    32.0
```

## 2.8 Functions operating on the `phylo` object.

Next, we highlight some functions to manipulate and/or to extract information
from the `phylo` object. Further operations can be found in other packages, such
as *[ape](https://CRAN.R-project.org/package%3Dape)* (Paradis and Schliep [2019](#ref-ape2019)), *[tidytree](https://CRAN.R-project.org/package%3Dtidytree)*(Yu [2020](#ref-R-tidytree)). These
functions are useful when users want to customize functions for the
`TreeSummarizedExperiment` class.

To show these functions, we use the tree shown in Figure [5](#fig:plot-exTree).

```
data("tinyTree")
ggtree(tinyTree, branch.length = "none") +
    geom_text2(aes(label = label), hjust = -0.1, size = 5.5) +
    geom_text2(aes(label = node), vjust = -0.8,
               hjust = -0.2, color = 'orange', size = 5.5)
```

![\label{plot-exTree} An example tree with node labels and numbers in black and orange texts, respectively.](data:image/png;base64...)

Figure 5: An example tree with node labels and numbers in black and orange texts, respectively

### 2.8.1 Conversion of the node label and the node number

The translation between the node labels and node numbers can be achieved by the function `convertNode`.

```
convertNode(tree = tinyTree, node = c(12, 1, 4))
```

```
## [1] "Node_12" "t2"      "t9"
```

```
convertNode(tree = tinyTree, node = c("t4", "Node_18"))
```

```
##      t4 Node_18
##       5      18
```

### 2.8.2 Find the descendants

To get descendants that are at the leaf level, we could set the argument
`only.leaf = TRUE` for the function `findDescendant`.

```
# only the leaf nodes
findDescendant(tree = tinyTree, node = 17, only.leaf = TRUE)
```

```
## $Node_17
## [1] 4 5 6
```

When `only.leaf = FALSE`, all descendants are returned.

```
# all descendant nodes
findDescendant(tree = tinyTree, node = 17, only.leaf = FALSE)
```

```
## $Node_17
## [1]  4  5  6 18
```

### 2.8.3 More functions

We list some functions that might also be useful in Table [1](#tab:phyloFun).
More are available in the package, and we encourage users to contribute their
functions that might be helpful for others.

Table 1: A table lists some functions operating on the `phylo` object that are available in the `TreeSummarizedExperiment`.

| Functions | Goal |
| --- | --- |
| printNode | print out the information of nodes |
| countNode | count the number of nodes |
| distNode | give the distance between a pair of nodes |
| matTree | list paths of a tree |
| findAncestor | find ancestor nodes |
| findChild | find child nodes |
| findSibling | find sibling nodes |
| shareNode | find the first node shared in the paths of nodes to the root |
| unionLeaf | find the union of descendant leaves |
| trackNode | track nodes by adding alias labels to a phylo object |
| isLeaf | test whether a node is a leaf node |

## 2.9 Custom functions for the `TreeSummarizedExperiment` class

Here, we show an example on how to write custom functions for
`TreeSummarizedExperiment` objects. To extract data of specific leaves, we
created a function `subsetByLeaf` by combining functions working on the `phylo`
class (e.g., `convertNode`, `keep.tip`, `trackNode`, `isLeaf`) with the accessor
function `subsetByNode`. Here, `convertNode`, `trackNode` and `isLeaf` are
available in `TreeSummarizedExperiment`, and `keep.tip` is from the `r CRANpkg("ape")` package. Since the node number of a node is changed after
pruning a tree with `keep.tip`, `trackNode` is provided to track the node and
further update the link between the data and the new tree.

```
# tse: a TreeSummarizedExperiment object
# rowLeaf: specific leaves
subsetByLeaf <- function(tse, rowLeaf) {
  # if rowLeaf is provided as node labels, convert them to node numbers
  if (is.character(rowLeaf)) {
    rowLeaf <- convertNode(tree = rowTree(tse), node = rowLeaf)
  }

  # subset data by leaves
  sse <- subsetByNode(tse, rowNode = rowLeaf)

  # update the row tree
    ## -------------- new tree: drop leaves ----------
    oldTree <- rowTree(sse)
    newTree <- ape::keep.tip(phy = oldTree, tip = rowLeaf)

    ## -------------- update the row link ----------
    # track the tree
    track <- trackNode(oldTree)
    track <- ape::keep.tip(phy = track, tip = rowLeaf)

    # row links
    rowL <- rowLinks(sse)
    rowL <- DataFrame(rowL)

    # update the row links:
    #   1. use the alias label to track and updates the nodeNum
    #   2. the nodeLab should be updated based on the new tree using the new
    #      nodeNum
    #   3. lastly, update the nodeLab_alias
    rowL$nodeNum <- convertNode(tree = track, node = rowL$nodeLab_alias,
                              message = FALSE)
    rowL$nodeLab <- convertNode(tree = newTree, node = rowL$nodeNum,
                              use.alias = FALSE, message = FALSE)
    rowL$nodeLab_alias <- convertNode(tree = newTree, node = rowL$nodeNum,
                                    use.alias = TRUE, message = FALSE)
    rowL$isLeaf <- isLeaf(tree = newTree, node = rowL$nodeNum)

    rowNL <- new("LinkDataFrame", rowL)

    ## update the row tree and links
    BiocGenerics:::replaceSlots(sse,
                              rowLinks = rowNL,
                              rowTree = list(phylo = newTree))
}
```

The row tree is updated after the subsetting. It now has only two leaves, `t2` and `t3`.

```
(both_sse <- subsetByLeaf(tse = both_tse, rowLeaf = c("t2", "t3")))
```

```
## class: TreeSummarizedExperiment
## dim: 3 4
## metadata(0):
## assays(1): Count
## rownames(3): entity1 entity2 entity3
## rowData names(4): Kingdom Phylum Class OTU
## colnames(4): sample1 sample2 sample3 sample4
## colData names(2): gg group
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (3 rows)
## rowTree: 1 phylo tree(s) (2 leaves)
## colLinks: a LinkDataFrame (4 rows)
## colTree: 1 phylo tree(s) (4 leaves)
## referenceSeq: a DNAStringSet (3 sequences)
```

```
rowLinks(both_sse)
```

```
## LinkDataFrame with 3 rows and 5 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##         <character>   <character> <integer> <logical> <character>
## entity1          t3       alias_1         1      TRUE       phylo
## entity2          t3       alias_1         1      TRUE       phylo
## entity3          t2       alias_2         2      TRUE       phylo
```

# 3 Session Info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] ggplot2_4.0.0                   ggtree_4.0.1
##  [3] ape_5.8-1                       TreeSummarizedExperiment_2.18.0
##  [5] Biostrings_2.78.0               XVector_0.50.0
##  [7] SingleCellExperiment_1.32.0     SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0                  GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0                   IRanges_2.44.0
## [13] S4Vectors_0.48.0                BiocGenerics_0.56.0
## [15] generics_0.1.4                  MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0               BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] ggiraph_0.9.2           tidyselect_1.2.1        dplyr_1.1.4
##  [4] farver_2.1.2            S7_0.2.0                fastmap_1.2.0
##  [7] lazyeval_0.2.2          fontquiver_0.2.1        digest_0.6.37
## [10] lifecycle_1.0.4         tidytree_0.4.6          magrittr_2.0.4
## [13] compiler_4.5.1          rlang_1.1.6             sass_0.4.10
## [16] tools_4.5.1             yaml_2.3.10             knitr_1.50
## [19] S4Arrays_1.10.0         labeling_0.4.3          htmlwidgets_1.6.4
## [22] DelayedArray_0.36.0     RColorBrewer_1.1-3      aplot_0.2.9
## [25] abind_1.4-8             BiocParallel_1.44.0     withr_3.0.2
## [28] purrr_1.1.0             grid_4.5.1              gdtools_0.4.4
## [31] scales_1.4.0            dichromat_2.0-0.1       tinytex_0.57
## [34] cli_3.6.5               rmarkdown_2.30          crayon_1.5.3
## [37] treeio_1.34.0           cachem_1.1.0            parallel_4.5.1
## [40] ggplotify_0.1.3         BiocManager_1.30.26     yulab.utils_0.2.1
## [43] vctrs_0.6.5             Matrix_1.7-4            jsonlite_2.0.0
## [46] fontBitstreamVera_0.1.1 bookdown_0.45           gridGraphics_0.5-1
## [49] patchwork_1.3.2         systemfonts_1.3.1       magick_2.9.0
## [52] tidyr_1.3.1             jquerylib_0.1.4         glue_1.8.0
## [55] codetools_0.2-20        gtable_0.3.6            tibble_3.3.0
## [58] pillar_1.11.1           rappdirs_0.3.3          htmltools_0.5.8.1
## [61] R6_2.6.1                evaluate_1.0.5          lattice_0.22-7
## [64] ggfun_0.2.0             fontLiberation_0.1.0    bslib_0.9.0
## [67] Rcpp_1.1.0              SparseArray_1.10.0      nlme_3.1-168
## [70] xfun_0.54               fs_1.6.6                pkgconfig_2.0.3
```

# Reference

Lun, Aaron, and Davide Risso. 2020. “SingleCellExperiment: S4 Classes for Single Cell Data.”

Paradis, E, and K Schliep. 2019. “ape 5.0: an environment for modern phylogenetics and evolutionary analyses in R.” *Bioinformatics* 35: 526–28.

Wang, Li-Gen, Tommy Tsan-Yuk Lam, Shuangbin Xu, Zehan Dai, Lang Zhou, Tingze Feng, Pingfan Guo, et al. 2019. “Treeio: An R Package for Phylogenetic Tree Input and Output with Richly Annotated and Associated Data.” *Molecular Biology and Evolution* 37 (2): 599–603. <https://doi.org/10.1093/molbev/msz240>.

Yu, Guangchuang. 2020. *tidytree: A Tidy Tool for Phylogenetic Tree Data Manipulation*.

Yu, Guangchuang, David K. Smith, Huachen Zhu, Yi Guan, and Tommy Tsan Yuk Lam. 2017. “Ggtree: An R Package for Visualization and Annotation of Phylogenetic Trees with Their Covariates and Other Associated Data.” *Methods in Ecology and Evolution* 8 (1): 28–36.