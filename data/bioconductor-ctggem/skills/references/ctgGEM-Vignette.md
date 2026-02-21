# Using ctgGEM

Carrie Minette

#### 2020-07-14

# Contents

* [1 Introduction](#introduction)
* [2 Installing *ctgGEM*](#installing-ctggem)
* [3 Preparing a `ctgGEMset` object](#preparing-a-ctggemset-object)
  + [3.1 Loading the Data](#loading-the-data)
  + [3.2 Constructing a `ctgGEMset` object](#constructing-a-ctggemset-object)
    - [3.2.1 Additional Info for the “monocle” method](#additional-info-for-the-monocle-method)
    - [3.2.2 Additional Info for the “TSCAN” method](#additional-info-for-the-tscan-method)
    - [3.2.3 Additional Info for the “sincell” method](#additional-info-for-the-sincell-method)
    - [3.2.4 Additional Info for the “destiny” method](#additional-info-for-the-destiny-method)
* [4 Using *ctgGEM*](#using-ctggem)
  + [4.1 Using the “monocle” method](#using-the-monocle-method)
  + [4.2 Using the “sincell” method](#using-the-sincell-method)
  + [4.3 Using the “TSCAN” method](#using-the-tscan-method)
  + [4.4 Using the “destiny” method](#using-the-destiny-method)
* [5 Replotting Trees](#replotting-trees)
* [6 Session Information](#session-information)
* [7 References](#references)
  + [7.1 destiny](#destiny)
  + [7.2 monocle](#monocle)
  + [7.3 sincell](#sincell)
  + [7.4 TSCAN](#tscan)

# 1 Introduction

Single-cell gene expression profiling methods are well suited for determining transcriptional
heterogeneity across a cell population. In many cases, this heterogeneity may reflect dynamic changes
in the transcriptional landscape due to biological processes such as differentiation or tumorigenesis. The
overall trajectory of this change may be unified or branched and is partially obscured by the noise of the
transcriptional programs within each cell. To address this computational challenge, a number of
packages have been created to calculate pseudotemporal ordering of cells to reflect cell-state
hierarchies from gene expression data. Each of these packages have unique inputs, outputs, and
visualization schemes, which makes comparisons across these methods time-consuming. Here we
present Cell Tree Generator for Gene Expression Matrices (*ctgGEM*), a package to streamline the
building of cell-state hierarchies from single-cell gene expression data across multiple existing tools for
improved comparability and reproducibility. ctgGEM provides the user with simplified way to build trees
with these packages using one function call with a single dataset and the desired visualization name as a
parameter. Results are also stored in the SIF file format for use in downstream analysis workflows or
input into Cytoscape. The packages currently supported by ctgGEM are:

* *[destiny](https://bioconductor.org/packages/3.11/destiny)*
* *[monocle](https://bioconductor.org/packages/3.11/monocle)*
* *[sincell](https://bioconductor.org/packages/3.11/sincell)*
* *[TSCAN](https://bioconductor.org/packages/3.11/TSCAN)*

# 2 Installing *ctgGEM*

*ctgGEM* requires R version 4.0 or higher (available
[here](http://www.r-project.org/)) and the most recent version of Bioconductor.
For more information on using Bioconductor, please see their website at <https://>
bioconductor.org. The following code will install Bioconductor,
*ctgGEM* and the following CRAN packages and their
dependencies: *[ggm](https://CRAN.R-project.org/package%3Dggm)*, *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)*, *[igraph](https://CRAN.R-project.org/package%3Digraph)*, *[irlba](https://CRAN.R-project.org/package%3Dirlba)*, *[maptpx](https://CRAN.R-project.org/package%3Dmaptpx)*, *[VGAM](https://CRAN.R-project.org/package%3DVGAM)*

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ctgGEM")
```

After installing, attach the *ctgGEM* package with the following
command:

```
library(ctgGEM)
```

# 3 Preparing a `ctgGEMset` object

The *ctgGEM* workflow is based around a single data class,
`ctgGEMset`, that extends the *[Biobase](https://bioconductor.org/packages/3.11/Biobase)* `SummarizedExperiment`
class, which provides a common interface familiar to those who have analyzed
microarray experiments with Bioconductor. The `ctgGEMset` class requires the
following three inputs:

1. `exprsData`, a numeric matrix of expression values, where rows are genes,
   and columns are cells/samples
2. `phenoData`, a data frame, where rows are cells/samples, and columns are
   cell/sample attributes (cell type, culture condition, day captured, etc.)
3. `featureData`, a data frame, where rows are features (e.g. genes), and
   columns are gene attributes (gene identifiers, gc content, etc.)

The expression value matrix must have the same number of columns as the
phenoData has rows, and it must have the same number of rows as the featureData
data frame has rows. Row names of the phenoData object must match the column
names of the expression matrix. Row names of the featureData object must
matchrow names of the expression matrix. Details for loading the data for and
constructing an example `ctgGEMset` object suitable for this vignette can be
found in the following section.

## 3.1 Loading the Data

A `ctgGEMset` object that will support all of the tree types in
*ctgGEM* requires a gene expression matrix, which for the `monocle`
and `TSCAN` tree types must contain strictly non-negative values.
For this vignette, we will construct a toy object, using
the data provided in the *[HSMMSingleCell](https://bioconductor.org/packages/3.11/HSMMSingleCell)* package. For more
information on this data set, please see the documentation available at
[https://doi.org/doi:10.18129/B9.bioc.HSMMSingleCell](https://doi.org/doi%3A10.18129/B9.bioc.HSMMSingleCell)

```
# load HSMMSingleCell package
library(HSMMSingleCell)
# load the data
data(HSMM_expr_matrix)
data(HSMM_sample_sheet)
data(HSMM_gene_annotation)
```

## 3.2 Constructing a `ctgGEMset` object

Using the data loaded in the previous step, we can construct the `ctgGEMset`
object for this vignette as follows:

```
toyGEMset <- ctgGEMset(exprsData = HSMM_expr_matrix,
                            phenoData = HSMM_sample_sheet,
                            featureData = HSMM_gene_annotation)
```

### 3.2.1 Additional Info for the “monocle” method

Using the “monocle” method requires a pair of parameters prepared with a column
name of gene identifiers in `featureData()` that corresponds to the gene short
names as the first item to be set, followed by the data type. The data type
must be one of “UMI”, “TC”, “FPKM”, “TPM”, “LTFPKM”, or “LTTPM”, where “UMI” is
UMI counts, “TC” is transcript counts, “FPKM” is FPKM, and “TPM” is TPM.
Monocle works best with untransformed data, but if you want to use
log-transformed FPKM or TPM, use data type “LTFPKM” or “LTTPM”, respectively.
Here we will use the *gene\_short\_name* column and the data type “FPKM”.

```
monocleInfo(toyGEMset, "gene_id") <- "gene_short_name"
monocleInfo(toyGEMset, "ex_type") <- "FPKM"
```

The “monocle” method can be used in either semi-supervised or unsupervised
mode. To run in semi-supervised mode, the names of two known classifying marker
genes from the column specified as “gene\_id” need to be set. If these two
marker genes are not set, unsupervised mode will run. The two genes we will
use for this demonstration are *MYF5*, a known marker for myoblasts, and
*ANPEP*, a known marker for fibroblasts.

```
# Set two marker genes to use semi-supervised mode
# Alternatively, omit the next two lines to run in unsupervised mode
monocleInfo(toyGEMset, "cell_id_1") <- "MYF5" # marks myoblasts
monocleInfo(toyGEMset, "cell_id_2") <- "ANPEP" # marks fibroblasts
```

### 3.2.2 Additional Info for the “TSCAN” method

In addition to its primary plot, the “TSCAN” method can also generate a single
gene vs. pseudotime plot. To generate this plot, we need to supply the rowname
of a single gene row in exprs(), and store it in TSCANinfo. Here we will use
the “ENSG00000000003.10” gene.

```
TSCANinfo(toyGEMset) <- "ENSG00000000003.10"
```

### 3.2.3 Additional Info for the “sincell” method

The “sincell” method can be used with a variety of parameters to control the
distance method used, which type (if any) dimensionality reduction to be used,
and which clustering method to use. If no options are specified, PCA will be
applied, with KNN clustering. Additional details concerning these parameters
can be found in the sincell package documentation. To use a distance method
with no dimensionality reduction, set the “method” parameter using the
`sincellInfo()` function to one of the following: “euclidean”, “L1” (Manhattan
distance), “cosine”, “pearson”, “spearman”, or “MI” (Mutual Information).

```
sincellInfo(toyGEMset, "method") <- "pearson"
```

To use dimensionality reduction with the “sincell” method, set the “method”
parameter to “PCA” for Principal Component Analysis, “ICA” for Independent
Component Analysis, “tSNE” for t-Distributed Stochastic Neighbor Embedding,
“classical-MDS” for classical Multidimensional Scaling, or “nonmetric-MDS” for
non-metric Multidimensional Scaling. If using “classical-MDS” or “nonmetric-
MDS”, we can also select the distance method to use with the “MDS.distance”
parameter. The options for “MDS.distance” are the same as those listed above
for no dimensionality reduction, with the exception the that the “cosine”
method cannot be selected for “MDS.distance”.

```
sincellInfo(toyGEMset, "method") <- "classical-MDS"
sincellInfo(toyGEMset, "MDS.distance") <- "spearman"
```

The final optional parameter for the “sincell” method is “clust.method”.
Acceptable values are “max-distance”, “percent”, “knn”, “k-medoids”, “ward.D”,
“ward.D2”, “single”, “complete”, “average”, “mcquitty”, “median”, or
“centroid”. In this example, we will set it to “k-medoids”.

```
sincellInfo(toyGEMset, "clust.method") <- "k-medoids"
```

### 3.2.4 Additional Info for the “destiny” method

Unlike the other tree types, the “destiny” method does not have the option to
provide further information. It should be noted, however, that the *[destiny](https://bioconductor.org/packages/3.11/destiny)* documentation recommends cleaned, referably normalized
data, and suggests that single-cell RNA-seq count data should be transformed
using a variance-stabilizing transformation (e.g. log or rlog).

# 4 Using *ctgGEM*

To use *ctgGEM*, call the `generate_tree` function with the
desired tree method and `ctgGEMset` object. The user can specify the desired output
directory using the ‘outputDir’ parameter, or default to the temporary directory
returned by `tempdir`.

## 4.1 Using the “monocle” method

To use our example `ctgGEMset` and the “monocle” method, we would type the
following:

```
toyGEMset <- generate_tree(dataSet = toyGEMset, treeType = "monocle")
```

```
## Warning: `group_by_()` is deprecated as of dplyr 0.7.0.
## Please use `group_by()` instead.
## See vignette('programming') for more help
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_warnings()` to see where this warning was generated.
```

```
## Warning: `select_()` is deprecated as of dplyr 0.7.0.
## Please use `select()` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_warnings()` to see where this warning was generated.
```

```
## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used

## Warning in if (class(projection) != "matrix") projection <-
## as.matrix(projection): the condition has length > 1 and only the first element
## will be used
```

This stores the final trees in the *originalTrees* list within the `ctgGEMset`
object, a simplified *[igraph](https://CRAN.R-project.org/package%3Digraph)* version of the tree in the
*treeList* within the `ctgGEMset` object, and if necessary creates a new
folder, called “CTG-Output”, that contains a folder called “SIFs” containing
the .SIF text file for the final tree, and a folder called “Plots” containing a
.png image of the following plot:

![](data:image/png;base64...)

## 4.2 Using the “sincell” method

To use our example `ctgGEMset` and the “sincell” method, we would type the
following:

```
toyGEMset <- generate_tree(dataSet = toyGEMset, treeType = "sincell")
```

This stores the final trees in the *originalTrees* list within the `ctgGEMset`
object, a simplified *[igraph](https://CRAN.R-project.org/package%3Digraph)* version of the tree in the
*treeList* within the `ctgGEMset` object, and if necessary creates a new
folder, called “CTG-Output”, that contains a folder called “Plots” containing
.png images of the following plots:

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

## 4.3 Using the “TSCAN” method

To use our example `ctgGEMset` and the “TSCAN”" method, we would type the
following:

```
toyGEMset <- generate_tree(dataSet = toyGEMset, treeType = "TSCAN")
```

This stores the final trees in the *originalTrees* list within the `ctgGEMset`
object, a simplified *[igraph](https://CRAN.R-project.org/package%3Digraph)* version of the tree in the
*treeList* within the `ctgGEMset` object, and if necessary creates a new
folder, called “CTG-Output”, that contains a folder called “SIFs” containing
the .SIF text file for the final tree, and a folder called “Plots” containing
.png images of the following plots:

![](data:image/png;base64...)![](data:image/png;base64...)

## 4.4 Using the “destiny” method

Note: some users may encounter problems installing and using the destiny package on R 4.0.0. To use our example `ctgGEMset` and the “destiny” method, we would type the following:

```
toyGEMset <- generate_tree(dataSet = toyGEMset, treeType = "destiny")
```

```
## Warning in destiny::DiffusionMap(es): You have 47192 genes. Consider passing
## e.g. n_pcs = 50 to speed up computation.
```

This stores the final trees in the *originalTrees* list within the `ctgGEMset`
object and if necessary creates a new folder, called “CTG-Output” that contains
a folder called “SIFs” containing the .SIF text file for the final tree, and
contains a folder called “Plots” containing .png images of the following plots:

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

# 5 Replotting Trees

If at some point we wish to view the plot of a tree generated after it’s been
created, but don’t want to have to regenerate it and all its files, *ctgGEM* has a function named `plotOriginalTree()`, that will
reproduce a plot stored in a ctgGEMset object. To use this function, we must
know the name of the tree we wish to plot. We can view the names of the trees
in our toyGEMset object using the `names()` function.

```
names(originalTrees(toyGEMset))
```

```
## [1] "monoclePrePCA"   "monocle"         "sincellMST"      "sincellSST"
## [5] "sincellIMC"      "TSCANclustering" "TSCANsingleGene" "destinyDM"
## [9] "destinyDPT"
```

Once we have the names, we can choose a tree to plot. Let’s plot the
“destinyDM” tree again.

```
plotOriginalTree(toyGEMset, "destinyDM")
```

![](data:image/png;base64...)![](data:image/png;base64...)

Using this function eliminates the need to regenerate the tree to view a plot
that was already created, thereby saving time for trees that require extensive
computations to generate.

To store your analysis session result for later use, you can use the .Rda
format.

```
save(toyGEMset, file = "toyGEMset.Rda")
```

# 6 Session Information

```
sessionInfo()
```

```
## R version 4.0.2 (2020-06-22)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.4 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.11-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.11-bioc/R/lib/libRlapack.so
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
##  [1] splines   stats4    parallel  stats     graphics  grDevices utils
##  [8] datasets  methods   base
##
## other attached packages:
##  [1] HSMMSingleCell_1.8.0        ctgGEM_1.0.3
##  [3] SummarizedExperiment_1.18.2 DelayedArray_0.14.1
##  [5] matrixStats_0.56.0          GenomicRanges_1.40.0
##  [7] GenomeInfoDb_1.24.2         IRanges_2.22.2
##  [9] S4Vectors_0.26.1            monocle_2.16.0
## [11] DDRTree_0.1.5               irlba_2.3.3
## [13] VGAM_1.1-3                  ggplot2_3.3.2
## [15] Biobase_2.48.0              BiocGenerics_0.34.0
## [17] Matrix_1.2-18               BiocStyle_2.16.0
##
## loaded via a namespace (and not attached):
##   [1] readxl_1.3.1                spam_2.5-1
##   [3] RcppEigen_0.3.3.7.0         plyr_1.8.6
##   [5] igraph_1.2.5                sp_1.4-2
##   [7] entropy_1.2.1               RcppHNSW_0.2.0
##   [9] densityClust_0.3            fastICA_1.2-2
##  [11] digest_0.6.25               foreach_1.5.0
##  [13] htmltools_0.5.0             viridis_0.5.1
##  [15] magick_2.4.0                gdata_2.18.0
##  [17] magrittr_1.5                cluster_2.1.0
##  [19] openxlsx_4.1.5              limma_3.44.3
##  [21] docopt_0.7.1                xts_0.12-0
##  [23] colorspace_1.4-1            ggrepel_0.8.2
##  [25] haven_2.3.1                 xfun_0.15
##  [27] dplyr_1.0.0                 hexbin_1.28.1
##  [29] sparsesvd_0.2               crayon_1.3.4
##  [31] RCurl_1.98-1.2              zoo_1.8-8
##  [33] iterators_1.0.12            glue_1.4.1
##  [35] gtable_0.3.0                zlibbioc_1.34.0
##  [37] XVector_0.28.0              car_3.0-8
##  [39] SingleCellExperiment_1.10.1 DEoptimR_1.0-8
##  [41] maps_3.3.0                  abind_1.4-5
##  [43] VIM_6.0.0                   scales_1.1.1
##  [45] ggplot.multistats_1.0.0     pheatmap_1.0.12
##  [47] ggthemes_4.2.0              Rcpp_1.0.5
##  [49] laeken_0.5.1                viridisLite_0.3.0
##  [51] xtable_1.8-4                foreign_0.8-80
##  [53] proxy_0.4-24                mclust_5.4.6
##  [55] dotCall64_1.0-0             vcd_1.4-7
##  [57] FNN_1.1.3                   gplots_3.0.4
##  [59] RColorBrewer_1.1-2          ellipsis_0.3.1
##  [61] pkgconfig_2.0.3             farver_2.0.3
##  [63] nnet_7.3-14                 tidyselect_1.1.0
##  [65] labeling_0.3                rlang_0.4.7
##  [67] reshape2_1.4.4              later_1.1.0.1
##  [69] cellranger_1.1.0            munsell_0.5.0
##  [71] tools_4.0.2                 generics_0.0.2
##  [73] ranger_0.12.1               evaluate_0.14
##  [75] stringr_1.4.0               fastmap_1.0.1
##  [77] yaml_2.2.1                  knitr_1.29
##  [79] zip_2.0.4                   robustbase_0.93-6
##  [81] caTools_1.18.0              purrr_0.3.4
##  [83] RANN_2.6.1                  nlme_3.1-148
##  [85] mime_0.9                    slam_0.1-47
##  [87] compiler_4.0.2              curl_4.3
##  [89] e1071_1.7-3                 knn.covertree_1.0
##  [91] smoother_1.1                tibble_3.0.3
##  [93] statmod_1.4.34              stringi_1.4.6
##  [95] RSpectra_0.16-0             forcats_0.5.0
##  [97] fields_10.3                 lattice_0.20-41
##  [99] TSCAN_1.26.0                vctrs_0.3.1
## [101] pillar_1.4.6                lifecycle_0.2.0
## [103] BiocManager_1.30.10         lmtest_0.9-37
## [105] combinat_0.0-8              data.table_1.12.8
## [107] bitops_1.0-6                httpuv_1.5.4
## [109] pcaMethods_1.80.0           R6_2.4.1
## [111] bookdown_0.20               promises_1.1.1
## [113] TSP_1.1-10                  KernSmooth_2.23-17
## [115] gridExtra_2.3               rio_0.5.16
## [117] sincell_1.20.0              codetools_0.2-16
## [119] boot_1.3-25                 MASS_7.3-51.6
## [121] gtools_3.8.2                destiny_3.2.0
## [123] withr_2.2.0                 qlcMatrix_0.9.7
## [125] GenomeInfoDbData_1.2.3      mgcv_1.8-31
## [127] hms_0.5.3                   grid_4.0.2
## [129] tidyr_1.1.0                 class_7.3-17
## [131] rmarkdown_2.3               carData_3.0-4
## [133] Rtsne_0.15                  TTR_0.23-6
## [135] scatterplot3d_0.3-41        shiny_1.5.0
```

# 7 References

## 7.1 destiny

Philipp Angerer et al. (2015): destiny: diffusion maps for large-scale
single-cell data in R. Helmholtz-Zentrum München. URL:
<http://bioinformatics.oxfordjournals.org/content/32/8/1241>

destiny package URL:
<https://bioconductor.org/packages/release/bioc/html/destiny.html>

## 7.2 monocle

Trapnell C, Cacchiarelli D, Grimsby J, Pokharel P, Li S, Morse M, Lennon NJ,
Livak KJ, Mikkelsen TS and Rinn JL (2014). “The dynamics and regulators of
cell fate decisions are revealed by pseudo-temporal ordering of single
cells.”
Nature Biotechnology.

monocle package URL:
<https://bioconductor.org/packages/release/bioc/html/monocle.html>

## 7.3 sincell

Juliá M, Telenti A, Rausell A (2014): Sincell: R package for the statistical
assessment of cell state hierarchies from single-cell RNA-seq data. bioRxiv
preprint

sincell package URL:
<https://bioconductor.org/packages/release/bioc/html/sincell.html>

## 7.4 TSCAN

Zhicheng Ji and Hongkai Ji (2015). TSCAN: TSCAN: Tools for Single-Cell
ANalysis. R package version 1.12.0.

TSCAN package URL:
<https://bioconductor.org/packages/release/bioc/html/TSCAN.html>