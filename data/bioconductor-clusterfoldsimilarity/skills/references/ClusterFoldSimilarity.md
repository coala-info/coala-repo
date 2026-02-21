# ClusterFoldSimilarity: comparing cell-groups from independent single-cell experiments

Óscar González-Velasco1

1Division of Applied Bioinformatics, German Cancer Research Center DKFZ

#### 29 October 2025

#### Package

ClusterFoldSimilarity 1.6.0

# 1 Installation

The package can be installed using bioconductor install manager:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ClusterFoldSimilarity")
```

```
library(ClusterFoldSimilarity)
```

# 2 Introduction

Comparing single-cell data across different datasets, samples and batches has demonstrated to be challenging. `ClusterFoldSimilarity` aims to solve the complexity of comparing different single-cell datasets by computing similarity scores between clusters (or user-defined groups) from any number of independent single-cell experiments, including different species and sequencing technologies. It accomplishes this by identifying analogous fold-change patterns across cell groups that share a common set of features (such as genes). Additionally, it selects and reports the top important features that have contributed to the observed similarity, serving as a tool for feature selection.

The output is a table that contains the similarity values for all the combinations of cluster-pairs from the independent datasets. `ClusterFoldSimilarity` also includes various plotting utilities to enhance the interpretability of the similarity scores.

### 2.0.1 Cross-species analysis and sequencing technologies (e.g.: Human vs Mouse, ATAC-Seq vs RNA-Seq)

`ClusterFoldSimilarity` is able to compare **any number** of independent experiments, including **different organisms**, making it useful for matching cell populations across different organisms, and thus, useful for inter-species analysis. Additionally, it can be used with **single-cell RNA-Seq data, single-cell ATAC-Seq data**, or more broadly, with continuous numerical data that shows changes in feature abundance across a set of common features between different groups.

### 2.0.2 Compatibility

It can be easily integrated on any existing single-cell analysis pipeline, and it is compatible with the most used single-cell objects: `Seurat` and `SingleCellExperiment`.

Parallel computing is available through the option parallel=TRUE which make use of BiocParallel.

# 3 Using ClusterFoldSimilarity to find similar clusters/cell-groups across datasets

Typically, `ClusterFoldSimilarity` will receive as input either a list of two or more `Seurat` or `SingleCellExperiment` objects.

`ClusterFoldSimilarity` will obtain the **raw count data** from these objects ( `GetAssayData(assay, slot = "counts")` in the case of `Seurat`, or `counts()` for `SingleCellExperiment` object), and **group or cluster label information** (using `Idents()` function from `Seurat`, or `colLabels()` for `SingleCellExperiment` ).

For the sake of illustration, we will employ the scRNAseq package, which contains numerous individual-cell datasets ready for download and encompassing samples from both human and mouse origins. In this example, we specifically utilize 2 human single-cell datasets obtained from the pancreas.

```
library(Seurat)
library(scRNAseq)
library(dplyr)
# Human pancreatic single cell data 1
pancreasMuraro <- scRNAseq::MuraroPancreasData(ensembl=FALSE)
pancreasMuraro <- pancreasMuraro[,rownames(colData(pancreasMuraro)[!is.na(colData(pancreasMuraro)$label),])]
colData(pancreasMuraro)$cell.type <- colData(pancreasMuraro)$label
rownames(pancreasMuraro) <- make.names(unlist(lapply(strsplit(rownames(pancreasMuraro), split="__"), function(x)x[[1]])), unique = TRUE)
singlecell1Seurat <- CreateSeuratObject(counts=counts(pancreasMuraro), meta.data=as.data.frame(colData(pancreasMuraro)))
```

Table 1: Cell-types on pancreas dataset from Muraro et al.

| Var1 | Freq |
| --- | --- |
| acinar | 219 |
| alpha | 812 |
| beta | 448 |
| delta | 193 |
| duct | 245 |
| endothelial | 21 |
| epsilon | 3 |
| mesenchymal | 80 |
| pp | 101 |
| unclear | 4 |

```
# Human pancreatic single cell data 2
pancreasBaron <- scRNAseq::BaronPancreasData(which="human", ensembl=FALSE)
colData(pancreasBaron)$cell.type <- colData(pancreasBaron)$label
rownames(pancreasBaron) <- make.names(rownames(pancreasBaron), unique = TRUE)

singlecell2Seurat <- CreateSeuratObject(counts=counts(pancreasBaron), meta.data=as.data.frame(colData(pancreasBaron)))
```

Table 2: Cell-types on pancreas dataset from Baron et al.

| Var1 | Freq |
| --- | --- |
| acinar | 958 |
| activated\_stellate | 284 |
| alpha | 2326 |
| beta | 2525 |
| delta | 601 |
| ductal | 1077 |
| endothelial | 252 |
| epsilon | 18 |
| gamma | 255 |
| macrophage | 55 |
| mast | 25 |
| quiescent\_stellate | 173 |
| schwann | 13 |
| t\_cell | 7 |

As we want to perform clustering analysis for later comparison of these cluster groups using `ClusterFoldSimilarity`, we first need to normalize and identify variable features for each dataset independently.

*Note: these steps should be done tailored to each independent dataset, here we apply the same parameters for the sake of simplicity:*

```
# Create a list with the unprocessed single-cell datasets
singlecellObjectList <- list(singlecell1Seurat, singlecell2Seurat)
# Apply the same processing to each dataset and return a list of single-cell analysis
singlecellObjectList <- lapply(X=singlecellObjectList, FUN=function(scObject){
scObject <- NormalizeData(scObject)
scObject <- FindVariableFeatures(scObject, selection.method="vst", nfeatures=2000)
scObject <- ScaleData(scObject, features=VariableFeatures(scObject))
scObject <- RunPCA(scObject, features=VariableFeatures(object=scObject))
scObject <- FindNeighbors(scObject, dims=seq(16))
scObject <- FindClusters(scObject, resolution=0.4)
})
```

Once we have all of our single-cell datasets analyzed independently, we can compute the similarity values. `clusterFoldSimilarity()` takes as arguments:

* `scList`: a list of single-cell objects (mandatory) either of class `Seurat` or of class `SingleCellExperiment`.
* `sampleNames`: vector with names for each of the datasets. If not set the datasets will be named in the given order as: *1, 2, …, N*.
* `topN`: the top n most similar clusters/groups to report for each cluster/group (default: `1`, the top most similar cluster). If set to `Inf` it will return the values from all the possible cluster-pairs.
* `topNFeatures`: the top *n* features (e.g.: genes) that contribute to the observed similarity between the pair of clusters (default: `1`, the top contributing gene). If a negative number, the tool will report the *n* most dissimilar features.
* `nSubsampling`: number of subsamplings (1/3 of cells on each iteration) at group level for calculating the fold-changes (default: `15`). At start, the tool will report a message with the recommended number of subsamplings for the given data (average n of subsamplings needed to observe all cells).
* `parallel`: whether to use parallel computing with multiple threads or not (default: `FALSE`). If we want to use a specific single-cell experiment for annotation (from which we know a ground-truth label, e.g. cell type, cell cycle, treatment… etc.), we can use that label to directly compare the single-cell datasets.

Here we will use the annotated pancreas cell-type labels from the dataset 1 to illustrate how to match clusters to cell-types using a reference dataset:

```
# Assign cell-type annotated from the original study to the cell labels:
Idents(singlecellObjectList[[1]]) <- factor(singlecellObjectList[[1]][[]][, "cell.type"])

library(ClusterFoldSimilarity)
similarityTable <- clusterFoldSimilarity(scList=singlecellObjectList,
                                         sampleNames=c("human", "humanNA"),
                                         topN=1,
                                         nSubsampling=24)
```

![](data:image/png;base64...)

Table 3: A table of the first 10 rows of the similarity results.

|  | similarityValue | w | datasetL | clusterL | datasetR | clusterR | topFeatureConserved | featureScore |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| acinar | 50.38169 | 6.82 | human | acinar | humanNA | 2 | REG1A | 50.427213 |
| alpha | 34.65354 | 6.51 | human | alpha | humanNA | 3 | GCG | 34.122804 |
| beta | 33.92137 | 6.59 | human | beta | humanNA | 4 | INS | 30.337947 |
| delta | 29.38112 | 6.29 | human | delta | humanNA | 4 | PCSK1 | 7.573988 |
| duct | 33.42910 | 6.42 | human | duct | humanNA | 5 | SPP1 | 13.135512 |
| endothelial | 45.73913 | 7.01 | human | endothelial | humanNA | 9 | PLVAP | 18.286168 |

A data.frame with the results is returned containing:

* `similarityValue`: The top similarity value calculated between datasetL:clusterL and datasetR.
* `w`: Weight associated with the similarity score value.
* `datasetL`: Dataset left, the dataset/sample which has been used to be compared.
* `clusterL`: Cluster left, the cluster source from datasetL which has been compared.
* `datasetR`: Dataset right, the dataset/sample used for comparison against datasetL.
* `clusterR`: Cluster right, the cluster target from datasetR which is being compared with the clusterL from datasetL.
* `topFeatureConserved`: The features (e.g.: genes, peaks…) that most contributed to the similarity between clusterL & clusterR.
* `featureScore`: The similarity score contribution for the specific topFeatureConserved (e.g.: genes, peaks…).

By default, `clusterFoldSimilarity()` will plot a graph network that visualizes the connections between the clusters from the different datasets using the similarity table that has been obtained. The arrows point in the direction of the similarity (datasetL:clusterL -> datasetR:clusterR); it can be useful for identifying relationships between groups of clusters and cell-populations that tend to be more similar. The graph plot can also be obtained by using the function `plotClustersGraph()` from this package, using as input the similarity table.

In this example, as we have information regarding cell-type labels, we can check how the cell types match by calculating the most abundant cell type on each of the similar clusters:

```
typeCount <- singlecellObjectList[[2]][[]] %>%
  group_by(seurat_clusters) %>%
  count(cell.type) %>%
  arrange(desc(n), .by_group = TRUE) %>%
  filter(row_number()==1)
```

Table 4: Cell-type label matching on pancreas single-cell data.

| seurat\_clusters | cell.type | n | matched.type |
| --- | --- | --- | --- |
| 0 | alpha | 1308 | alpha |
| 1 | beta | 1022 | beta |
| 2 | acinar | 927 | acinar |
| 3 | alpha | 967 | alpha |
| 4 | beta | 958 | beta |
| 5 | ductal | 817 | duct |
| 6 | delta | 586 | delta |
| 7 | beta | 494 | beta |
| 8 | activated\_stellate | 283 | mesenchymal |
| 9 | endothelial | 250 | endothelial |
| 10 | gamma | 211 | epsilon |
| 11 | ductal | 174 | acinar |
| 12 | macrophage | 55 | unclear |
| 13 | ductal | 77 | unclear |

## 3.1 Analyzing graph communities to identify super-groups of similar cell populations

To easily analyze and identify the similarities between the different datasets and cell-groups, we can find the communities that constitute the directed graph (cluster the nodes based on the graph´s closely-related elements).

We can make so by using the function `findCommunitiesSimmilarity()` from the `ClusterFoldSimilarity` package. It uses the InfoMap algorithm to find the best fitting communities. We just need the similarity table obtained from `clusterFoldSimilarity()` as explained on the previous section, the function will plot the graph with the communities and return a data frame containing the community that each sample & cluster/group belongs to.

```
cellCommunities <- findCommunitiesSimmilarity(similarityTable = similarityTable)
```

![](data:image/png;base64...)

|  | sample | group | community |
| --- | --- | --- | --- |
| human\_group\_acinar | human | acinar | 1 |
| human\_group\_alpha | human | alpha | 2 |
| human\_group\_beta | human | beta | 3 |
| human\_group\_delta | human | delta | 3 |
| human\_group\_duct | human | duct | 4 |
| human\_group\_endothelial | human | endothelial | 5 |

## 3.2 Retrieving the top-n similarities

If we suspect that clusters could be related with more than one cluster of other datasets, we can retrieve the top n similarities for each cluster:

```
# Retrieve the top 3 similar cluster for each of the clusters:
similarityTable3Top <- clusterFoldSimilarity(scList=singlecellObjectList,
                                             topN=3,
                                             sampleNames=c("human", "humanNA"),
                                             nSubsampling=24)
```

![](data:image/png;base64...)

Table 5: Similarity results showing the top 3 most similar clusters.

|  | similarityValue | w | datasetL | clusterL | datasetR | clusterR | topFeatureConserved | featureScore |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| acinar.3 | 50.00145 | 6.81 | human | acinar | humanNA | 2 | REG1A | 49.999513 |
| acinar.12 | 42.70464 | 6.65 | human | acinar | humanNA | 11 | REG3A | 40.070842 |
| acinar.6 | 27.00327 | 5.95 | human | acinar | humanNA | 5 | SERPINA3 | 14.315774 |
| alpha.4 | 34.50439 | 6.51 | human | alpha | humanNA | 3 | GCG | 33.757464 |
| alpha.1 | 31.33150 | 6.33 | human | alpha | humanNA | 0 | GCG | 29.997441 |
| alpha.5 | 29.70890 | 6.35 | human | alpha | humanNA | 4 | CPE | 7.782267 |

## 3.3 Obtaining the top-n feature markers

If we are interested on the features that contribute the most to the similarity, we can retrieve the top n features:

```
# Retrieve the top 5 features that contribute the most to the similarity between each pair of clusters:
similarityTable5TopFeatures <- clusterFoldSimilarity(scList=singlecellObjectList,
                                                     topNFeatures=5,
                                                     nSubsampling=24)
```

![](data:image/png;base64...)

Table 6: Similarity results showing the top 5 features that most contributed to the similarity.

|  | similarityValue | w | datasetL | clusterL | datasetR | clusterR | topFeatureConserved | featureScore |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| acinar.11 | 50.59540 | 6.84 | 1 | acinar | 2 | 2 | REG1A | 51.04858 |
| acinar.12 | 50.59540 | 6.84 | 1 | acinar | 2 | 2 | CTRB2 | 47.57484 |
| acinar.13 | 50.59540 | 6.84 | 1 | acinar | 2 | 2 | REG1B | 46.55425 |
| acinar.14 | 50.59540 | 6.84 | 1 | acinar | 2 | 2 | PRSS1 | 45.54733 |
| acinar.15 | 50.59540 | 6.84 | 1 | acinar | 2 | 2 | CELA3A | 41.50131 |
| alpha.16 | 34.52617 | 6.50 | 1 | alpha | 2 | 3 | GCG | 33.61875 |
| alpha.17 | 34.52617 | 6.50 | 1 | alpha | 2 | 3 | TTR | 22.43977 |
| alpha.18 | 34.52617 | 6.50 | 1 | alpha | 2 | 3 | CHGB | 13.33365 |
| alpha.19 | 34.52617 | 6.50 | 1 | alpha | 2 | 3 | PCSK2 | 11.68422 |
| alpha.20 | 34.52617 | 6.50 | 1 | alpha | 2 | 3 | TM4SF4 | 11.57276 |

## 3.4 Retrieving all the similarity values and plotting a similarity heatmap

Sometimes it is useful to retrieve all the similarity values for downstream analysis (e.g. identify more than one cluster that is similar to a cluster of interest, finding the most dissimilar clusters, etc). To obtain all the values, we need to specify `topN=Inf`.

By default, `clusterFoldSimilarity` creates a heatmap plot with the computed similarity values (from the perspective of the first dataset found on `scList`; to modify this plot see the following section). The top 2 similarities for each group within dataset 1 (heatmap row-wise) are highlighted with colored borders.

```
similarityTableAllValues <- clusterFoldSimilarity(scList=singlecellObjectList,
                                                  sampleNames=c("human", "humanNA"),
                                                  topN=Inf)
```

![](data:image/png;base64...)

```
dim(similarityTableAllValues)
```

```
## [1] 280   8
```

For downstream analysis of the similarities, it can be convenient to create a matrix with all the scores from the comparison of two datasets:

```
library(dplyr)
dataset1 <- "human"
dataset2 <- "humanNA"
similarityTable2 <- similarityTableAllValues %>%
  filter(datasetL == dataset1 & datasetR == dataset2) %>%
  arrange(desc(as.numeric(clusterL)), as.numeric(clusterR))
cls <- unique(similarityTable2$clusterL)
cls2 <- unique(similarityTable2$clusterR)
similarityMatrixAll <- t(matrix(similarityTable2$similarityValue, ncol=length(unique(similarityTable2$clusterL))))
rownames(similarityMatrixAll) <- cls
colnames(similarityMatrixAll) <- cls2
```

Table 7: A 2 datasets Similarity matrix.

|  | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| acinar | -10.56 | 31.63 | 23.51 | 23.94 | -9.63 | -12.46 | 0.39 | -11.83 | 23.42 | -15.30 | -11.05 | 27.54 | 31.27 | 26.93 |
| alpha | -11.10 | -11.83 | -7.44 | -9.94 | 22.68 | -16.51 | 50.04 | -11.42 | -11.75 | -12.91 | 27.40 | -7.00 | -26.26 | 16.02 |
| beta | 7.82 | -16.39 | -16.08 | 34.82 | 25.82 | 26.04 | -13.54 | -15.79 | 24.00 | -17.11 | 26.30 | -15.08 | -17.21 | 29.94 |
| delta | 33.72 | 29.42 | -15.33 | -14.81 | 18.10 | -15.09 | 24.77 | -15.12 | 26.46 | -15.52 | -15.01 | -13.63 | 33.40 | 15.63 |
| duct | -10.12 | 15.29 | -14.02 | 29.98 | -15.15 | 26.00 | 25.36 | 28.94 | -12.27 | -13.34 | 20.92 | -14.01 | 23.99 | -12.13 |
| endothelial | -18.84 | 28.12 | 32.98 | 28.61 | -15.43 | -14.51 | 23.54 | -15.93 | 23.74 | -11.68 | -7.63 | -17.63 | -15.68 | -14.81 |
| epsilon | 13.63 | 33.85 | -14.68 | 48.55 | -15.65 | -6.25 | -10.02 | -17.64 | -15.47 | -14.82 | 10.31 | 45.71 | -10.17 | 32.65 |
| mesenchymal | -15.68 | 20.14 | -17.78 | 25.53 | 22.13 | 24.26 | -13.87 | -13.53 | 30.10 | -15.97 | 26.91 | -8.09 | 42.36 | -19.38 |
| pp | -19.15 | -17.71 | 29.31 | -1.01 | -15.72 | -6.95 | -12.08 | 30.60 | -10.35 | -13.69 | -13.27 | -11.84 | 14.49 | 24.68 |
| unclear | 26.43 | 22.03 | -13.59 | 31.11 | 22.19 | -20.62 | -19.66 | -17.55 | 30.26 | 17.34 | 23.79 | 3.76 | -17.56 | 41.91 |

# 4 Using ClusterFoldSimilarity across species and numerous datasets:

`ClusterFoldSimilarity` can compare **any number** of independent studies, including **different organisms**, making it useful for inter-species analysis. Also, it can be used on different sequencing data technologies: e.g.: compare single-cell **ATAC-Seq VS RNA-seq**.

In this example, we are going to add a pancreas single-cell dataset from **Mouse** to the 2 existing ones from **Human** that we have processed in the previous steps.

```
# Mouse pancreatic single cell data
pancreasBaronMM <- scRNAseq::BaronPancreasData(which="mouse", ensembl=FALSE)
```

Table 8: Cell-types on pancreas dataset from Baron et al.

| Var1 | Freq |
| --- | --- |
| B\_cell | 10 |
| T\_cell | 7 |
| activated\_stellate | 14 |
| alpha | 191 |
| beta | 894 |
| delta | 218 |
| ductal | 275 |
| endothelial | 139 |
| gamma | 41 |
| immune\_other | 8 |
| macrophage | 36 |
| quiescent\_stellate | 47 |
| schwann | 6 |

```
colData(pancreasBaronMM)$cell.type <- colData(pancreasBaronMM)$label
# Translate mouse gene ids to human ids
# *for the sake of simplicity we are going to transform to uppercase all mouse gene names
rownames(pancreasBaronMM) <- make.names(toupper(rownames(pancreasBaronMM)), unique=TRUE)
# Create seurat object
singlecell3Seurat <- CreateSeuratObject(counts=counts(pancreasBaronMM), meta.data=as.data.frame(colData(pancreasBaronMM)))

# We append the single-cell object to our list
singlecellObjectList[[3]] <- singlecell3Seurat
```

Now, we process the new single-cell dataset from mouse, and we calculate the similarity scores between the 3 independent datasets.

```
scObject <- singlecellObjectList[[3]]
scObject <- NormalizeData(scObject)
scObject <- FindVariableFeatures(scObject, selection.method="vst", nfeatures=2000)
scObject <- ScaleData(scObject, features=VariableFeatures(scObject))
scObject <- RunPCA(scObject, features=VariableFeatures(object=scObject))
scObject <- FindNeighbors(scObject, dims=seq(16))
scObject <- FindClusters(scObject, resolution=0.4)
singlecellObjectList[[3]] <- scObject
```

This time we will make use of the option parallel=TRUE. We can set the specific number of CPUs to use using `BiocParallel::register()`

```
# We use the cell labels as a second reference, but we can also use the cluster labels if our interest is to match clusters
Idents(singlecellObjectList[[3]]) <- factor(singlecellObjectList[[3]][[]][,"cell.type"])

# We subset the most variable genes in each experiment
singlecellObjectListVariable <- lapply(singlecellObjectList, function(x){x[VariableFeatures(x),]})

# Setting the number of CPUs with BiocParallel:
BiocParallel::register(BPPARAM =  BiocParallel::MulticoreParam(workers = 6))

similarityTableHumanMouse <- clusterFoldSimilarity(scList=singlecellObjectListVariable,
                                                        sampleNames=c("human", "humanNA", "mouse"),
                                                        topN=1,
                                                        nSubsampling=24,
                                                        parallel=TRUE)
```

![](data:image/png;base64...)

We can compute and visualize with a heatmap all the similarities for each cluster/group of cells from the 3 datasets using `topN=Inf`. Additionally, we can use the function `similarityHeatmap()` from this package to plot the heatmap with the datasets in a different order, or just plot the 2 datasets we are interested in. The top 2 similarities are highlighted to help visualizing the best matching groups.

```
similarityTableHumanMouseAll <- clusterFoldSimilarity(scList=singlecellObjectListVariable,
                                                          sampleNames=c("human", "humanNA", "mouse"),
                                                          topN=Inf,
                                                          nSubsampling=24,
                                                          parallel=TRUE)
```

![](data:image/png;base64...)

As the similarity values might not be symmetric (e.g. a cluster A from D1 showing the top similarity to B from D2, might not be the top similar cluster to B from D2), we can select which dataset to plot in the Y-axis:

```
ClusterFoldSimilarity::similarityHeatmap(similarityTable=similarityTableHumanMouseAll, mainDataset="humanNA")
```

![](data:image/png;base64...)

Additionally, we can turn-off the highlight using `highlightTop=FALSE`

```
# Turn-off the highlighting:
ClusterFoldSimilarity::similarityHeatmap(similarityTable=similarityTableHumanMouseAll, mainDataset="humanNA", highlightTop=FALSE)
```

![](data:image/png;base64...)

# 5 Similarity score calculation

`ClusterFoldSimilarity` does not need to integrate the data, or apply any batch correction techniques across the datasets that we aim to analyze, which makes it less prone to data-loss or noise. The similarity value is based on the fold-changes between clusters/groups of cells defined by the user. These fold-changes from different independent datasets are first computed using a Bayesian approach, we calculate this fold-change distribution using a permutation analysis that shrink the fold-changes with no biological meaning. These differences in abundance are then combined using a pairwise dot product approach, after adding these feature contributions and applying a fold-change concordance weight, a similarity value is obtained for each of the clusters of each of the datasets present.

# Session information

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
##  [1] future_1.67.0               dplyr_1.1.4
##  [3] scRNAseq_2.23.1             SingleCellExperiment_1.32.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0         generics_0.1.4
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] Seurat_5.3.1                SeuratObject_5.2.0
## [17] sp_2.2-0                    ClusterFoldSimilarity_1.6.0
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] ProtGenerics_1.42.0      spatstat.sparse_3.1-0    bitops_1.0-9
##   [4] httr_1.4.7               RColorBrewer_1.1-3       tools_4.5.1
##   [7] sctransform_0.4.2        alabaster.base_1.10.0    R6_2.6.1
##  [10] HDF5Array_1.38.0         lazyeval_0.2.2           uwot_0.2.3
##  [13] rhdf5filters_1.22.0      withr_3.0.2              gridExtra_2.3
##  [16] progressr_0.17.0         cli_3.6.5                textshaping_1.0.4
##  [19] spatstat.explore_3.5-3   fastDummies_1.7.5        labeling_0.4.3
##  [22] alabaster.se_1.10.0      sass_0.4.10              S7_0.2.0
##  [25] spatstat.data_3.1-9      ggridges_0.5.7           pbapply_1.7-4
##  [28] Rsamtools_2.26.0         systemfonts_1.3.1        svglite_2.2.2
##  [31] dichromat_2.0-0.1        parallelly_1.45.1        rstudioapi_0.17.1
##  [34] RSQLite_2.4.3            BiocIO_1.20.0            ica_1.0-3
##  [37] spatstat.random_3.4-2    Matrix_1.7-4             abind_1.4-8
##  [40] lifecycle_1.0.4          yaml_2.3.10              rhdf5_2.54.0
##  [43] SparseArray_1.10.0       BiocFileCache_3.0.0      Rtsne_0.17
##  [46] grid_4.5.1               blob_1.2.4               promises_1.4.0
##  [49] ExperimentHub_3.0.0      crayon_1.5.3             miniUI_0.1.2
##  [52] lattice_0.22-7           cowplot_1.2.0            GenomicFeatures_1.62.0
##  [55] cigarillo_1.0.0          KEGGREST_1.50.0          magick_2.9.0
##  [58] pillar_1.11.1            knitr_1.50               rjson_0.2.23
##  [61] future.apply_1.20.0      codetools_0.2-20         glue_1.8.0
##  [64] spatstat.univar_3.1-4    data.table_1.17.8        vctrs_0.6.5
##  [67] png_0.1-8                gypsum_1.6.0             spam_2.11-1
##  [70] gtable_0.3.6             cachem_1.1.0             xfun_0.53
##  [73] S4Arrays_1.10.0          mime_0.13                survival_3.8-3
##  [76] tinytex_0.57             fitdistrplus_1.2-4       ROCR_1.0-11
##  [79] nlme_3.1-168             bit64_4.6.0-1            alabaster.ranges_1.10.0
##  [82] filelock_1.0.3           RcppAnnoy_0.0.22         GenomeInfoDb_1.46.0
##  [85] bslib_0.9.0              irlba_2.3.5.1            KernSmooth_2.23-26
##  [88] otel_0.2.0               DBI_1.2.3                tidyselect_1.2.1
##  [91] bit_4.6.0                compiler_4.5.1           curl_7.0.0
##  [94] httr2_1.2.1              h5mread_1.2.0            xml2_1.4.1
##  [97] ggdendro_0.2.0           DelayedArray_0.36.0      plotly_4.11.0
## [100] bookdown_0.45            rtracklayer_1.70.0       scales_1.4.0
## [103] lmtest_0.9-40            rappdirs_0.3.3           stringr_1.5.2
## [106] digest_0.6.37            goftest_1.2-3            spatstat.utils_3.2-0
## [109] alabaster.matrix_1.10.0  rmarkdown_2.30           XVector_0.50.0
## [112] htmltools_0.5.8.1        pkgconfig_2.0.3          dbplyr_2.5.1
## [115] fastmap_1.2.0            ensembldb_2.34.0         rlang_1.1.6
## [118] htmlwidgets_1.6.4        UCSC.utils_1.6.0         shiny_1.11.1
## [121] farver_2.1.2             jquerylib_0.1.4          zoo_1.8-14
## [124] jsonlite_2.0.0           BiocParallel_1.44.0      RCurl_1.98-1.17
## [127] magrittr_2.0.4           kableExtra_1.4.0         dotCall64_1.2
## [130] patchwork_1.3.2          Rhdf5lib_1.32.0          Rcpp_1.1.0
## [133] reticulate_1.44.0        stringi_1.8.7            alabaster.schemas_1.10.0
## [136] MASS_7.3-65              AnnotationHub_4.0.0      plyr_1.8.9
## [139] parallel_4.5.1           listenv_0.9.1            ggrepel_0.9.6
## [142] deldir_2.0-4             Biostrings_2.78.0        splines_4.5.1
## [145] tensor_1.5.1             igraph_2.2.1             spatstat.geom_3.6-0
## [148] RcppHNSW_0.6.0           reshape2_1.4.4           BiocVersion_3.22.0
## [151] XML_3.99-0.19            evaluate_1.0.5           BiocManager_1.30.26
## [154] httpuv_1.6.16            RANN_2.6.2               tidyr_1.3.1
## [157] purrr_1.1.0              polyclip_1.10-7          scattermore_1.2
## [160] alabaster.sce_1.10.0     ggplot2_4.0.0            xtable_1.8-4
## [163] restfulr_0.0.16          AnnotationFilter_1.34.0  RSpectra_0.16-2
## [166] later_1.4.4              viridisLite_0.4.2        tibble_3.3.0
## [169] memoise_2.0.1            AnnotationDbi_1.72.0     GenomicAlignments_1.46.0
## [172] cluster_2.1.8.1          globals_0.18.0
```