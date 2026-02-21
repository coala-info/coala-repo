# The PIUMA package - Phenotypes Identification Using Mapper from topological data Analysis

Laura Ballarini1,2, Alessia Gerbasi2, Giuseppe Albi2, Arianna Dagliati2, Carlo Leonardi3, Luca Piacentini1 and Mattia Chiesa1,4\*

1Bioinformatics and Aritificial Intelligence facility, Centro Cardiologico Monzino, IRCCS, Milan, Italy
2Dipartimento di Ingegneria Industrale e dell Informazione, Universita' degli studi di Pavia, Pavia, Italy
3Wellcome Sanger Institute, Cambridge, UK
4Department of Electronics, Information and Biomedical Engineering, Politecnico di Milano, Milan, Italy

\*mattia.chiesa@cardiologicomonzino.it

#### 5 February 2026

#### Package

PIUMA 1.6.1

![](data:image/svg+xml;base64...)

# 1 Introduction

This guide provides an overview of the PIUMA111 PIUMA is the Italian word for feather package, a comprehensive R
package for performing Topological Data Analysis on high-dimensional datasets,
such as -omics data. As of version 1.6 of PIUMA, we provided two
tutorials for TDA in R using PIUMA, one as a basic end-to-end pipeline to do
community mining, and the other one to showcase the application
of TDA using Seurat objects, making a specific case for single-cell data
processing.

## 1.1 Motivation

Phenotyping is a process of characterizing and classifying individuals based on
observable traits or phenotypic characteristics. In the context of medicine and
biology, phenotyping involves the systematic analysis and measurement of various
physical, physiological, and behavioral features of individuals, such as height,
weight, blood pressure, biochemical markers, imaging data, and more. Phenotyping
plays a crucial role in precision medicine as it provides essential knowledge for
understanding individual health characteristics and disease manifestations, by
combining data from different sources to gain comprehensive insights into an
individual’s health status and disease risk. This integrated approach allows for
more accurate disease diagnosis, prognosis, and treatment selection. The same
considerations could be also be extended in omics research, in which the
expression values of thousands of genes and proteins, or the incidence of
somatic and germline polymorphic variants are usually assessed to link molecular
activities with the onset or the progression of diseases. In this field,
phenotyping is needed to identify patterns and associations between phenotypic
traits and a huge amount of available features. These analyses can uncover novel
disease subtypes, identify predictive markers, and facilitate the development of
personalized treatment strategies. In this context, the application of
unsupervised learning methodologies could help the identification of specific
phenotypes in huge heterogeneous cohorts, such as clinical or -omics data. Among
them, the Topological Data Analysis (TDA) is a rapidly growing field that
combines concepts from algebraic topology and computational geometry to analyze
and extract meaningful information from complex and high-dimensional data sets
(Carlsson [2009](#ref-carlsson2009topology)). Moreover, TDA is a robust and effective methodology
that preserves the intrinsic characteristics of data and the mutual
relationships among observations, by presenting complex data in a graph-based
representation. Indeed, building topological models as networks, TDA allows
complex diseases to be inspected in a continuous space, where subjects can
‘fluctuate’ over the graph, sharing, at the same time, more than one adjacent
node of the network (Dagliati et al. [2020](#ref-dagliati2020using)).
Overall, TDA offers a powerful set of tools to capture the underlying
topological features of data, revealing essential patterns and relationships
that might be hidden from traditional statistical techniques
(Casaclang-Verzosa et al. [2019](#ref-casaclang2019network)).

# 2 News in Version PIUMA 1.6

PIUMA 1.6 is a major release that brings true end-to-end TDA workflows to R.
The headline feature is embedded, TDA-guided, geometry-informed community
mining: new functions operate directly on the TDAobj class so you can run
Mapper-based community detection entirely in R, with special emphasis on
TDA-driven clustering for scRNA-seq atlases.

You can check out the integrative vignette for seamless use with Seurat.

# 3 Installation

PIUMA can be installed by:

```
if (!require("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("PIUMA")
```

# 4 Scope of this Vignette

This vignette is intended to offer to the user the basic pipeline and usage of
PIUMA, using a scRNAseq dataset as an example. Mapper() output will be taken
using reasonable but arbitrary hyperparameters.

## 4.1 The testing dataset

We tested PIUMA on a subset of the single-cell RNA Sequencing dataset
([GSE:GSE193346](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE193346)
generated and published by *Feng et al. (2022)* to demonstrate that distinct
transcriptional profiles are present in specific cell types of each heart
chambers, which were attributed to have roles in cardiac development
(Feng et al. [2022](#ref-feng2022single)). In this tutorial, our aim will be to exploit PIUMA for
identifying sub-population of vascular endothelial cells, which can be
associated with specific heart developmental stages. The original dataset
consisted of three layers of heterogeneity: cell type, stage and zone (*i.e.*,
heart chamber). Our test dataset was obtained by subsetting vascular endothelial
cells (cell type) by *[Seurat](https://CRAN.R-project.org/package%3DSeurat)* object, extracting raw counts and
metadata. Thus, we filtered low expressed genes and normalized data by
*[DaMiRseq](https://bioconductor.org/packages/3.22/DaMiRseq)* :

```
#############################################
############# NOT TO EXECUTE ################
########## please skip this chunk ###########
#############################################

dataset_seu <- readRDS("./GSE193346_CD1_seurat_object.rds")

# subset vascular endothelial cells
vascularEC_seuobj <- subset(x = dataset_seu,
                            subset = markFinal == "vascular_ec")
df_data_counts <- vascularEC_seuobj@assays$RNA@counts
df_cl <- as.data.frame(df_data_counts)
meta_cl <- vascularEC_seuobj@meta.data[, c(10,13,14,15)]
meta_cl[sapply(meta_cl, is.character)] <- lapply(meta_cl[sapply(meta_cl,
                                                                is.character)],
                                                 as.factor)

## Filtering and normalization
colnames(meta_cl)[4] <- "class"
SE <- DaMiR.makeSE(df_cl, meta_cl)
data_norm <- DaMiR.normalization(SE,
                                 type = "vst",
                                 minCounts = 3,
                                 fSample = 0.4,
                                 hyper = "no")
vascEC_norm <- round(t(assay(data_norm)), 2)
vascEC_meta <- meta_cl[, c(3,4), drop=FALSE]
df_TDA <- cbind(vascEC_meta, vascEC_norm)
```

At the end, the dataset was composed of 1180 cells (observations) and 838
expressed genes (features). Moreover, 2 additional features are present in the
metadata: ‘stage’ and ‘zone’. The first one describes the stage of heart
development, while the second one refers to the heart chamber.

Users can directly import the testing dataset by:

```
library(PIUMA)
library(ggplot2)
data(vascEC_norm)
data(vascEC_meta)

df_TDA <- cbind(vascEC_meta, vascEC_norm)

dim(df_TDA)
#> [1] 1180  840
head(df_TDA[1:5, 1:7])
#>                       stage zone Rpl7  Dst Cox5b Eif5b Rpl31
#> AACCAACGTGGTACAG-a5k1 E15.5   RV 5.08 2.95  2.51  2.20  3.42
#> AACCATGAGGAAGTCC-a5k1    P3   LV 4.84 2.40  3.40  1.68  3.40
#> AACGAAAAGACCATAA-a5k1    P0   RV 4.42 2.43  2.61  2.33  2.61
#> AAGCGAGGTAGGAGGG-a5k1    P0   LV 3.74 2.52  2.52  2.01  2.52
#> AAGCGTTGTCTCGGAC-a5k1 E16.5   LV 4.99 3.31  2.33  2.33  3.62
```

## 4.2 The TDA object

The PIUMA package comes with a dedicated data structure to easily store the
information gathered from all the steps performed by a Topological Data
Analysis. As in the version 1.6 of PIUMA, this object, called `TDAobj`, is an S4
class containing 11 slots:

* `orig_data`: `data.frame` with the original data (**without** outcomes)
* `scaled_data`: `data.frame` with re-scaled data (**without** outcomes)
* `outcomeFact`: `data.frame` with the original outcomes
* `outcome`: `data.frame` with original outcomes converted as numeric
* `comp`: `data.frame` containing the components of projected data
* `dist_mat`: `data.frame` containing the computed distance matrix
* `dfMapper`: `data.frame` containing the nodes, with their elements,
* `jacc`: `matrix` of Jaccard indexes between each pair of `dfMapper` nodes
* `node_data_mat`: `data.frame` with the node size and the average value
* `graph` : `list` containing the Jaccard matrix transformed in igraph object
* `clustering` : `list` containing two essential data.frames with topological
  clustering information per nodes and per observation

![](data:image/svg+xml;base64...)

The `makeTDAobj` function allows users to 1) generate the TDAobj from a
`data.frame`, 2) select one or more variables to be considered as outcome, and
3) perform the 0-1 scaling on the remaining dataset:

```
TDA_obj <- makeTDAobj(df_TDA, c("stage","zone"))
```

For genomic data, such as RNA-Seq or scRNA-Seq, we have also developed a custom
function to import a *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* object into PIUMA:

```
data("vascEC_meta")
data("vascEC_norm")
library(SummarizedExperiment)

dataSE <- SummarizedExperiment(assays=as.matrix(t(vascEC_norm)),
                               colData=as.data.frame(vascEC_meta))
TDA_obj <- makeTDAobjFromSE(dataSE, c("stage","zone"))
```

## 4.3 Preparing data for Mapper

To perform TDA, some preliminary preprocessing steps have to be carried out;
specifically, the scaled data stored in `TDA_obj@scaled_data`, called
*point-cloud* in TDA jargon, has to be projected in a low dimensional space and
transformed in distance matrix, exploiting the `dfToProjection` and
`dfToDistance` functions, respectively. In this example, we will use the
**umap** as projection strategy, to obtain the first 2 reduced dimensions
(`nComp = 2`) and the Euclidean distance (`distMethod = "euclidean"`) as
distance metrics. PIUMA allows setting 6 different projection strategies with
their specific arguments: `UMAP`, `TSNE`, `PCA`, `MDS`, `KPCA`, and `ISOMAP` and
3 types of well-known distance metrics are available: Euclidean, Pearson’s
correlation and the Gower’s distance (to be preferred in case of categorical
features are present). Users can also use standard external functions both to
implement the low-dimensional reduction (*e.g.*, the built-in `princomp`
function) and to calculate distances (*e.g.*, the built-in `dist` function).

```
set.seed(1)

# calculate the distance matrix
TDA_obj <- dfToDistance(TDA_obj, distMethod = "euclidean")

# calculate the projections (lenses)
TDA_obj <- dfToProjection(TDA_obj,
                      "UMAP",
                      nComp = 2,
                      umapNNeigh = 25,
                      umapMinDist = 0.3,
                      showPlot = FALSE)

# plot point-cloud based on stage and zone
df_plot <- as.data.frame(cbind(getOutcomeFact(TDA_obj),
                                getComp(TDA_obj)),
                         stringAsFactor = TRUE)

ggplot(data= df_plot, aes(x=comp1, y=comp2, color=stage))+
  geom_point(size=3)+
  facet_wrap(~zone)
```

![Scatterplot from UMAP. Four scatter plots are drawn, using the first 2 components identified by UMAP. Each panel represents cells belonging to a specific heart chamber, while colors refer to the development stage.](data:image/png;base64...)

Figure 1: Scatterplot from UMAP
Four scatter plots are drawn, using the first 2 components identified by UMAP. Each panel represents cells belonging to a specific heart chamber, while colors refer to the development stage.

As shown in Figure [1](#fig:chunk-4), the most of vascular endothelial cells
are located in ventricles where, in turn, it is possible to more easily
appreciate cell groups based on developmental stages.

## 4.4 TDA Mapper

One of the core algorithms in TDA is the **TDA Mapper**, which is designed to
provide a simplified representation of the data’s topological structure, making
it easier to interpret and analyze. The fundamental idea behind TDA Mapper is to
divide the data into overlapping subsets called ‘clusters’ and, then, build a
simplicial complex that captures the relationships between these clusters. This
simplicial complex can be thought of as a network of points, edges, triangles,
and higher-dimensional shapes that approximate the underlying topology of the
data. The TDA Mapper algorithm proceeds through several consecutive steps:

* **Data Partitioning**: the data is partitioned into overlapping subsets,
  called **‘bins’**, where each bin corresponds to a neighborhood of points;
* **Lensing**: a filter function, called **‘lens’**, is chosen to assign a
  value to each data point;
* **Clustering**: the overlapping bins are clustered based on the values
  assigned by the filter function. Clusters are formed by grouping together
  data points with similar filter function values;
* **Simplicial Complex**: a simplicial complex is constructed to represent the
  relationships between the clusters. Each cluster corresponds to a vertex in
  the complex, and edges are created to connect overlapping clusters;
* **Visualization**: the resulting simplicial complex can be visualized, and
  the topological features of interest can be easily identified and studied.

TDA Mapper has been successfully applied to various domains, including biology,
neuroscience, materials science, and more. Its ability to capture the underlying
topological structure of data while being robust to noise and dimensionality
makes it a valuable tool for gaining insights from complex datasets. PIUMA is
thought to implement a 2-dimensional lens function and then apply one of the 4
well-known clustering algorithm: ‘*k-means*’, ‘*hierarchical clustering*’,
*DBSCAN* or *OPTICS*.

```
TDA_obj <- mapperCore(TDA_obj,
                       nBins = 15,
                       overlap = 0.3,
                       clustMeth = "kmeans")

# number of clusters (nodes)
dim(getDfMapper(TDA_obj))
#> [1] 367   1

# content of two overlapping clusters
getDfMapper(TDA_obj)["node_102_cl_1", 1]
#> [1] "GCGGAAACAGAGTTGG-a5k1 GTGCAGCAGCTGGAGT-a25k TCAGTGACAGCTTTGA-a25k TGTTCTATCAAGCCGC-a25k"
getDfMapper(TDA_obj)["node_117_cl_1", 1]
#> [1] "CCACCATGTTGAGTCT-a5k1 GCCCAGAGTTGCTCAA-a5k1 GCGGAAACAGAGTTGG-a5k1 TCCAGAAGTGTTCCTC-a5k1 GTCCTCATCGGCTGAC-a25k TGCTCGTAGCCTGTGC-a25k"
```

Here, we decided to generated **15 bins** (for each dimension), each one
overlapping by **30%** with the adjacent ones. The **k-means** algorithm is,
then, applied on the sample belonging to each ‘squared’ bin. In this example,
the Mapper aggregated samples in 369 partially overlapping clusters. Indeed, as
shown in the previous code chunk, the nodes `node_102_cl_1` and `node_117_cl_1`
shared 2 out of 4 cells.

## 4.5 Nodes Similarity and Enrichment

Once chosen the hyperparameters, the output of mapper is a `data.frame`,
stored in the `dfMapper` slot, in which each row represents a group of samples
(here, a group of cells), called ’**node’** in network theory jargon.
PIUMA allows the users to also generate a matrix that specifies the similarity
between nodes **‘edge’** allowing to represent the data as a network.
Since the similarity, in this context, consists of the number of samples,
shared by nodes, PIUMA implements a function (`jaccardMatrix`) to calculate the
Jaccard’s index between each pairs of nodes.

```
# Jaccard Matrix
TDA_obj <- jaccardMatrix(TDA_obj)
head(round(getJacc(TDA_obj)[1:5,1:5],3))
#>             node_3_cl_1 node_4_cl_1 node_4_cl_2 node_5_cl_1 node_5_cl_2
#> node_3_cl_1          NA          NA       0.167          NA          NA
#> node_4_cl_1          NA          NA          NA          NA          NA
#> node_4_cl_2       0.167          NA          NA          NA       0.308
#> node_5_cl_1          NA          NA          NA          NA          NA
#> node_5_cl_2          NA          NA       0.308          NA          NA
round(getJacc(TDA_obj)["node_102_cl_1","node_117_cl_1"],3)
#> [1] 0.111
```

Regarding the similarity matrix, we obtained a Jaccard matrix where each
clusters’ pair was compared; looking, for example, at the Jaccard Index for
nodes `node_102_cl_1` and `node_117_cl_1`, we correctly got 0.5 (2/4 cells).
Moreover, the `tdaDfEnrichment` function allows inferring the features values
for the generated nodes, by returning the averaged variables values of samples
belonging to specific nodes. Generally, this step is called ‘Node Enrichment’.
In addition the size of each node is also appended to the output `data.frame`
(the last column name is ‘size’).

```
TDA_obj <- tdaDfEnrichment(TDA_obj,
                           cbind(getScaledData(TDA_obj),
                                 getOutcome(TDA_obj)))
head(getNodeDataMat(TDA_obj)[1:5, tail(names(getNodeDataMat(TDA_obj)), 5)])
#>             mt.Nd5 mt.Cytb  stage  zone size
#> node_3_cl_1  0.195   0.536 11.000 3.000    1
#> node_4_cl_1  0.240   0.720 13.000 1.000    1
#> node_4_cl_2  0.257   0.634 14.167 1.667    6
#> node_5_cl_1  0.988   0.999 13.000 1.000    1
#> node_5_cl_2  0.279   0.654 15.273 1.545   11
```

Printing the last 5 columns of the `data.frame` returned by `tdaDfEnrichment`
(`node_data_mat` slot), we can show the averaged expression values of each nodes
for 4 mitochondrial genes as well as the number of samples belonging to the
nodes.

## 4.6 Network Assessment

The geometry of the resulting TDA output graph may reveal hints on data organisation.
Inferring the geometry of a graph from a TDA output and applying an appropriate clustering method,
which is the main core and objective of PIUMA, might revel interesting communities.
In particular, not all geometries are the same: biological datasets sometimes harbor scale-free hubs,
so PIUMA also provides
complementary strategies to reassess your network from a scale-free perspective.
In particular, PIUMA implements two different strategies:

* `supervised approach`, usually called **‘anchoring’**, in which the entropy
  of the network generated by TDA is calculated averaging the entropies of
  each node using one single outcome as class (*i.e.*, ‘anchor’). The lower
  the entropy, the better the network.
* `unsupervised approach` that exploits a topological measurement to force the
  network to be scale-free. Scale-free networks are characterized by few
  highly connected nodes (hub nodes) and many poorly connected nodes (leaf
  nodes). Scale-free networks follows a power-law degree distribution in which
  the probability that a node has k links follows \[P(k) \sim k^{-\gamma}\],
  where \(k\) is a node degree (*i.e.*, the number of its connections), \(\gamma\)
  is a degree exponent, and \(P(k)\) is the frequency of nodes with a specific
  degree. Degree exponents between \(2 < \gamma < 3\) have been observed in most
  biological and social networks. Forcing our network to be scale-free ensures
  to unveil communities in our data. The higher the correlation between P(k)
  and k, in log-log scale, the better the network. We also introduced a
  measure of connectivity of the Mapper() output as well as a ‘Product Score’
  defined as (|corlogklogpk| × Connectivity) that simultaneously rewards
  scale-free behavior and overall graph cohesion. We introduced this
  correction since very sparse networks with many isolated nodes may appear
  scale-free but are not useful for data representation.

```
# Anchoring (supervised)
entropy <-  checkNetEntropy(getNodeDataMat(TDA_obj)[, "zone"])
entropy
#> [1] 1.316

# Scale free network (unsupervised)
netModel <- checkScaleFreeModel(TDA_obj, showPlot = TRUE)
#> Scale for x is already present.
#> Adding another scale for x, which will replace the existing scale.
#> `geom_smooth()` using formula = 'y ~ x'
#> `geom_smooth()` using formula = 'y ~ x'
```

![Power-law degree distribution. The correlation between P(k) (y-axis) and k (x-axis) is represented in linear scale (on the left) and in log-log scale (on the right). The regression line (orange line) is also provided.](data:image/png;base64...)

Figure 2: Power-law degree distribution
The correlation between P(k) (y-axis) and k (x-axis) is represented in linear scale (on the left) and in log-log scale (on the right). The regression line (orange line) is also provided.

```
netModel
#> $Connectivity
#> [1] 0.893733
#>
#> $gamma
#> [1] 1.804252
#>
#> $corkpk
#> [1] -0.7102301
#>
#> $pValkpk
#> [1] 0.009647595
#>
#> $corlogklogpk
#> [1] -0.5955781
#>
#> $pVallogklogpk
#> [1] 0.04101903
#>
#> $ProductScore
#> [1] 0.5322878
```

Although the anchoring metric can be valuable when you already know class
labels, the unsupervised power-law fit is often preferable because it requires
no prior knowledge In our example, we obtained a
global entropy of 1.3, Pearson correlations of –0.75 (linear) and –0.58
(log–log), and an estimated \(\gamma\) of 2.09, confirming scale-free structure
(a typical scale-free network has (\(2 < \gamma < 3\))).
By comparing entropy, correlation or exponent,by using `checkNetEntropy` and
`checkScaleFreeModel`, across different parameters you can select the
configuration that most faithfully uncovers community structure in your data.
Moreover, the connectivity of the network is 0.89, while the ProductScore is
0.53. A connectivity below 1.0 tells us that the graph is not fully unified but
comprises more than one substantial subgraph, hinting that it is only partially
fragmented. At the same time, a moderate ‘Product Score’ suggests a meaningful
power-law signature among those connected nodes.
Taken together, these metrics point to a scale-free topology, marked by
prominent hub nodes. To assign a predicted geometry quickly, with sensible
thresholds and fallbacks for non-SF cases, we implemented the
`predict_mapper_class()` function:

```
# quick inference of geometry, metrics-based
TDA_obj <- jaccardMatrix(TDA_obj)
TDA_obj <- setGraph(TDA_obj)
TDA_obj <- predict_mapper_class(TDA_obj, verbose = TRUE)
#> predict_mapper_class: SF
```

This function simply uses heuristics to propose the most likely network topology

## 4.7 Cluster assignment

Once the structure of network has been assessed, the last key point is to properly
identify a clusters in the network, and, thus, to assign cluster categories to each network node and each observation. PIUMA implements its own algorithm to detect clusters (Paragraph 4.7.1), while offers an easy way to perform clustering outside the package, for example using Cytoscape, a well-known tools for handling graphs (Paragraph 4.7.2)

### 4.7.1 Geometry-guided Community Mining of TDA Mapper() Graph

Once the Mapper pipeline has produced a fully populated TDA\_obj, complete with
its graph structure, Jaccard similarity matrix, and igraph representation, you
can invoke our geometry-aware clustering routine with a single call to
`autoClusterMapper`. This function selects the most appropriate
community-finding algorithm based on the predicted graph geometry,
while still allowing you to override its choice if you prefer a different method.
Under the hood, we map each canonical geometry to the algorithm best
suited to its topological signature:

* **Scale-free** or **configuration models** (`SF/CM`) are handled by
  fast-greedy modularity optimization, which excels at revealing
  hub-centric structures.
* **Small-world** graphs (`WS`) leverage the walktrap algorithm’s ability to
  follow short random walks and uncover locally dense regions.
* **Random geometric** graphs (`RGG`) employ edge-betweenness community
  detection to separate spatial clusters by cutting the highest-traffic
  links.
* **Stochastic block models** (`SBM`) use optimal modularity to isolate
  block-structured communities.
* **Erdős–Rényi** graphs (`ER`) fall back on label-propagation, which
  naturally diffuses labels across a uniformly random network.

This principled pairing of geometry and algorithm not only speeds up community
discovery but also ensures that the resulting clusters respect the intrinsic
shape of the data, yielding biologically meaningful modules that might be
overlooked by generic clustering approaches.

In practice, if the automatic geometry mapping underperforms, **walktrap** is a
solid fallback that works well across many Mapper graphs.

```
TDA_obj <- autoClusterMapper(TDA_obj,method = 'automatic')
```

We then merge the resulting cluster assignments with our UMAP coordinates and
plot each heart chamber in a faceted scatterplot, labeling only the
non-singleton clusters:

```
library(ggrepel)
library(dplyr)
#>
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#>
#>     filter, lag
#> The following objects are masked from 'package:base':
#>
#>     intersect, setdiff, setequal, union

# plot point-cloud based on stage and zone
df_plot <- as.data.frame(cbind(getOutcomeFact(TDA_obj),
                                getComp(TDA_obj)),
                         stringAsFactor = TRUE)

df_plot$cell_id <- rownames(df_plot)
df_plot <- merge(df_plot, TDA_obj@clustering$obs_cluster,
                 by.x = "cell_id", by.y = "obs", all.x = TRUE)

centroids <- df_plot %>%
  group_by(zone, cluster) %>%
  summarize(
    n_cells = dplyr::n(),
    comp1 = mean(comp1, na.rm = TRUE),
    comp2 = mean(comp2, na.rm = TRUE),
    .groups = 'drop'
  ) %>%
  filter(!grepl("^Singleton", as.character(cluster)))  # Exclude singleton clusters

ggplot(df_plot, aes(x = comp1, y = comp2, color = factor(cluster))) +
  geom_point(size = 3, alpha = 0.7) +
  geom_label_repel(
    data = centroids,
    aes(label = cluster, fill = factor(cluster)),
    color = "white",
    fontface = "bold",
    box.padding = 0.5,
    segment.color = NA,
    min.segment.length = 0
  ) +
  facet_wrap(~ zone) +
  labs(color = "Cluster",
       title = "Geometry-Guided Community Detection",
       subtitle = "Cluster centroids labeled (singletons excluded)",
       caption = "Singleton clusters shown without labels") +
  theme_minimal() +
  scale_color_viridis_d(option = "D") +
  scale_fill_viridis_d(option = "D", guide = "none")
```

![Geometry-guided Clustering on Mapper()'s Graph. Four scatter plots are drawn, using the first 2 components identified by UMAP, faceting for each specific heart chamber. Cells are colored for the topological clusters identified with PIUMA. Topological clusters are also labelled on the graph, while Singletons are excluded.](data:image/png;base64...)

Figure 3: Geometry-guided Clustering on Mapper()’s Graph
Four scatter plots are drawn, using the first 2 components identified by UMAP, faceting for each specific heart chamber. Cells are colored for the topological clusters identified with PIUMA. Topological clusters are also labelled on the graph, while Singletons are excluded.

```
#for more inspection: obs X clusters
head(TDA_obj@clustering$obs_cluster)
#>                      obs cluster
#> 1 AAACGAACATCGGTTA-E18P1       2
#> 2 AAACGCTTCATAGACC-E18P1       1
#> 3  AAAGGGCAGTCTGTAC-a10k       1
#> 4  AAAGGGCCATGACTTG-a25k       1
#> 5 AAATGGACAGCAAGAC-P9CD1       9
#> 6 AAATGGAGTCGAAACG-P9CD1       1

# nodes X obs X clusters
head(TDA_obj@clustering$nodes_cluster)
#>          node                    obs      cluster
#> 1 node_3_cl_1 ACTCTCGAGATCCAAA-P9CD1            9
#> 2 node_4_cl_1 TCGCTCATCTCGTCAC-P9CD1 Singleton_19
#> 3 node_4_cl_2 ACTCTCGAGATCCAAA-P9CD1            9
#> 4 node_4_cl_2 CTCCCTCGTATGCGGA-P9CD1            9
#> 5 node_4_cl_2 GTCTTTACAAGAAATC-P9CD1            9
#> 6 node_4_cl_2 TCGACGGTCTGCTAGA-P9CD1            9
```

We can see that clusters appear distinctly in defined zones of the UMAP in this
faceted view per anatomical region. Our geometry-guided approach prioritizes
communities formed by connected graph components, excluding disconnected
singletons that lack structural relevance to the underlying geometry.
We observe well-defined cluster boundaries in the embedding space, indicating
that identified communities represent biologically meaningful cellular groupings
rather than scattered artifacts.

Two key outputs let you explore the results in detail:

-`obs_cluster`: A table mapping each observation (cell) to its assigned cluster,
using a k-nearest-neighbor-enhanced discriminator to resolve ambiguous node
memberships.

-`nodes_clusters`: A node-centric mapping that preserves the full relationship
between the original graph topology and the clusters.

Both they are available in:

```
str(TDA_obj@clustering)
#> List of 2
#>  $ nodes_cluster:'data.frame':   2366 obs. of  3 variables:
#>   ..$ node   : chr [1:2366] "node_3_cl_1" "node_4_cl_1" "node_4_cl_2" "node_4_cl_2" ...
#>   ..$ obs    : chr [1:2366] "ACTCTCGAGATCCAAA-P9CD1" "TCGCTCATCTCGTCAC-P9CD1" "ACTCTCGAGATCCAAA-P9CD1" "CTCCCTCGTATGCGGA-P9CD1" ...
#>   ..$ cluster: chr [1:2366] "9" "Singleton_19" "9" "9" ...
#>  $ obs_cluster  :'data.frame':   1178 obs. of  2 variables:
#>   ..$ obs    : chr [1:1178] "AAACGAACATCGGTTA-E18P1" "AAACGCTTCATAGACC-E18P1" "AAAGGGCAGTCTGTAC-a10k" "AAAGGGCCATGACTTG-a25k" ...
#>   ..$ cluster: chr [1:1178] "2" "1" "1" "1" ...
```

### 4.7.2 Export data for Cytoscape

Cytoscape is a well-known tool to handle, process and analyze networks
(Shannon et al. [2003](#ref-shannon2003cytoscape)). Two files are needed to generate and enrich network in
Cytoscape: the jaccard Matrix (`TDA_obj@jacc`), to generate the structure of the
network (nodes and edges) and a `data.frame` with additional nodes information
to enrich the network (`TDA_obj@node_data_mat`):

```
write.table(x = round(getJacc(TDA_obj),3),
            file = "./jaccard.matrix.txt",
            sep = "\t",
            quote = FALSE,
            na = "",
            col.names = NA)

write.table(x = getNodeDataMat(TDA_obj),
            file = "./nodeEnrichment.txt",
            sep = "\t",
            quote = FALSE,
            col.names = NA)
```

To explore the network resulted following the PIUMA framework, we imported
`jaccard.matrix.txt` in Cytoscape by the *aMatReader* plugin
(Settle et al. [2018](#ref-settle2018amatreader)) (*PlugIn -> aMatReader -> Import Matrix file*) while
`nodeEnrichment.txt` by *File -> Import -> Table from File*. Then, we
identified network communities by the GLay cluster function from the
‘*clustermaker2*’ plugin (Utriainen and Morris [2023](#ref-utriainen2023clustermaker2)).

![](data:image/svg+xml;base64...)

As shown in Figure 3, using the transcriptome of vascular endothelial cells, it
is possible to identify 11 communities of cells (top-right). Interestingly, some
of them are in the same developmental stage (top-left). Moreover, there are
clusters showing similar expression for some genes but different expression for
other genes, suggesting that the sub-population could have a different
biological function.For example, orange and yellow clusters have a similar
average expression of Igfpb7 (bottom-right) but different expression level of
Aprt (bottom-left).

# Session Info

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#> [1] dplyr_1.2.0      ggrepel_0.9.6    ggplot2_4.0.2    PIUMA_1.6.1
#> [5] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1            viridisLite_0.4.3
#>  [3] farver_2.1.2                S7_0.2.1
#>  [5] fastmap_1.2.0               digest_0.6.39
#>  [7] rpart_4.1.24                lifecycle_1.0.5
#>  [9] cluster_2.1.8.2             magrittr_2.0.4
#> [11] kernlab_0.9-33              dbscan_1.2.4
#> [13] compiler_4.5.2              rlang_1.1.7
#> [15] Hmisc_5.2-5                 sass_0.4.10
#> [17] tools_4.5.2                 igraph_2.2.1
#> [19] yaml_2.3.12                 data.table_1.18.2.1
#> [21] knitr_1.51                  htmlwidgets_1.6.4
#> [23] askpass_1.2.1               S4Arrays_1.10.1
#> [25] labeling_0.4.3              reticulate_1.44.1
#> [27] DelayedArray_0.36.0         RColorBrewer_1.1-3
#> [29] abind_1.4-8                 withr_3.0.2
#> [31] foreign_0.8-91              BiocGenerics_0.56.0
#> [33] nnet_7.3-20                 grid_4.5.2
#> [35] stats4_4.5.2                colorspace_2.1-2
#> [37] scales_1.4.0                MASS_7.3-65
#> [39] dichromat_2.0-0.1           tinytex_0.58
#> [41] SummarizedExperiment_1.40.0 cli_3.6.5
#> [43] rmarkdown_2.30              vegan_2.7-2
#> [45] generics_0.1.4              umap_0.2.10.0
#> [47] otel_0.2.0                  rstudioapi_0.18.0
#> [49] RSpectra_0.16-2             cachem_1.1.0
#> [51] stringr_1.6.0               splines_4.5.2
#> [53] parallel_4.5.2              BiocManager_1.30.27
#> [55] XVector_0.50.0              matrixStats_1.5.0
#> [57] base64enc_0.1-6             vctrs_0.7.1
#> [59] Matrix_1.7-4                jsonlite_2.0.0
#> [61] bookdown_0.46               patchwork_1.3.2
#> [63] IRanges_2.44.0              S4Vectors_0.48.0
#> [65] htmlTable_2.4.3             Formula_1.2-5
#> [67] magick_2.9.0                jquerylib_0.1.4
#> [69] glue_1.8.0                  stringi_1.8.7
#> [71] tsne_0.1-3.1                gtable_0.3.6
#> [73] GenomicRanges_1.62.1        tibble_3.3.1
#> [75] pillar_1.11.1               htmltools_0.5.9
#> [77] Seqinfo_1.0.0               openssl_2.3.4
#> [79] R6_2.6.1                    evaluate_1.0.5
#> [81] lattice_0.22-7              Biobase_2.70.0
#> [83] backports_1.5.0             png_0.1-8
#> [85] bslib_0.10.0                Rcpp_1.1.1
#> [87] checkmate_2.3.4             gridExtra_2.3
#> [89] SparseArray_1.10.8          nlme_3.1-168
#> [91] permute_0.9-8               mgcv_1.9-4
#> [93] xfun_0.56                   MatrixGenerics_1.22.0
#> [95] pkgconfig_2.0.3
```

# References

Carlsson, Gunnar. 2009. “Topology and Data.” *Bulletin of the American Mathematical Society* 46 (2): 255–308.

Casaclang-Verzosa, Grace, Sirish Shrestha, Muhammad Jahanzeb Khalil, Jung Sun Cho, Márton Tokodi, Sudarshan Balla, Mohamad Alkhouli, et al. 2019. “Network Tomography for Understanding Phenotypic Presentations in Aortic Stenosis.” *JACC: Cardiovascular Imaging* 12 (2): 236–48.

Dagliati, Arianna, Nophar Geifman, Niels Peek, John H Holmes, Lucia Sacchi, Riccardo Bellazzi, Seyed Erfan Sajjadi, and Allan Tucker. 2020. “Using Topological Data Analysis and Pseudo Time Series to Infer Temporal Phenotypes from Electronic Health Records.” *Artificial Intelligence in Medicine* 108: 101930.

Feng, Wei, Abha Bais, Haoting He, Cassandra Rios, Shan Jiang, Juan Xu, Cindy Chang, Dennis Kostka, and Guang Li. 2022. “Single-Cell Transcriptomic Analysis Identifies Murine Heart Molecular Features at Embryonic and Neonatal Stages.” *Nature Communications* 13 (1): 7960.

Settle, Brett, David Otasek, John H Morris, and Barry Demchak. 2018. “AMatReader: Importing Adjacency Matrices via Cytoscape Automation.” *F1000Research* 7.

Shannon, Paul, Andrew Markiel, Owen Ozier, Nitin S Baliga, Jonathan T Wang, Daniel Ramage, Nada Amin, Benno Schwikowski, and Trey Ideker. 2003. “Cytoscape: A Software Environment for Integrated Models of Biomolecular Interaction Networks.” *Genome Research* 13 (11): 2498–2504.

Utriainen, Maija, and John H Morris. 2023. “ClusterMaker2: A Major Update to clusterMaker, a Multi-Algorithm Clustering App for Cytoscape.” *BMC Bioinformatics* 24 (1): 134.