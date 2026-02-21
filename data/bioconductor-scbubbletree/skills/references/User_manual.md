# Exploring scRNA-seq data from 5 cancer cell lines with scBubbletree

Simo Kitanovski (simo.kitanovski@uni-due.de)

#### 30 October 2025

# Contents

* [1 Background](#background)
* [2 Data](#data1)
* [3 Data processing](#data-processing)
* [4 scBubbletree workflow](#scbubbletree-workflow)
  + [4.1 Determine the clustering resolution (**step 1**)](#determine-the-clustering-resolution-step-1)
  + [4.2 Determining the resolution parameter \(r\) for Louvain clustering](#determining-the-resolution-parameter-r-for-louvain-clustering)
  + [4.3 Determining the number of clusters \(k\) for k-means clustering [**alternative**]](#determining-the-number-of-clusters-k-for-k-means-clustering-alternative)
* [5 Clustering (**step 2**) and hierarchical grouping (**step 3**) of bubbles](#clustering-step-2-and-hierarchical-grouping-step-3-of-bubbles)
  + [5.1 Clustering with Louvain](#clustering-with-louvain)
  + [5.2 Clustering with k-means (**[alternative]**)](#clustering-with-k-means-alternative)
  + [5.3 Comparison of bubbletree based on Louvain and k-means clustering](#comparison-of-bubbletree-based-on-louvain-and-k-means-clustering)
  + [5.4 Visual comparison of two bubbletrees](#visual-comparison-of-two-bubbletrees)
* [6 Visualization (**step 4**)](#visualization-step-4)
  + [6.1 Attaching categorical features](#attaching-categorical-features)
  + [6.2 Gini impurity index](#gini-impurity-index)
  + [6.3 Attaching numeric features](#attaching-numeric-features)
  + [6.4 Quality control with *scBubbletree*](#quality-control-with-scbubbletree)
* [7 scBubbletree can incorporate results from other clustering approaches](#scbubbletree-can-incorporate-results-from-other-clustering-approaches)
* [8 Adding custom visuals: cell-cell communication](#adding-custom-visuals-cell-cell-communication)
* [9 Visualizing features of individual cells](#visualizing-features-of-individual-cells)
* [10 Summary](#summary)
* [11 Session Info](#session-info)

# 1 Background

Over the last decade, the size of scRNA-seq datasets has exploded to millions
of cells sequenced in a single study. This allows us profile the transcriptomes
of various cell types across tissues. The rapid growth of scRNA-seq data has
also created an unique set of challenges, for instance, there is a pressing
need for scalable approaches for scRNA-seq data visualization.

This vignette introduces *[scBubbletree](https://bioconductor.org/packages/3.22/scBubbletree)*111 <https://doi.org/10.1186/s12859-024-05927-y>, a transparent workflow
for quantitative exploration of single cell RNA-seq data.

In short, the algorithm of *[scBubbletree](https://bioconductor.org/packages/3.22/scBubbletree)* performs clustering
to identify clusters (“bubbles”) of transcriptionally similar cells, and then
visualizes these clusters as leafs in a hierarchical dendrogram (“bubbletree”)
which describes their relationships. The workflow comprises four steps: 1.
determining the clustering resolution, 2. clustering, 3. hierarchical cluster
grouping and 4. visualization. We explain each step in the following using
scRNA-seq dataset of five cancer cell lines.

To run this vignette we need to load a few packages:

```
library(scBubbletree)
library(ggplot2)
library(ggtree)
library(patchwork)
```

# 2 Data222 <https://doi.org/10.1038/s41592-019-0425-8>

Here we will analyze a scRNA-seq data333 <https://doi.org/10.1038/s41592-019-0425-8> containing a mixture of 3,918 cells
from five human lung adenocarcinoma cell lines (HCC827, H1975, A549, H838 and
H2228). The dataset is available here444 <https://github.com/LuyiTian/sc_mixology/blob/master/data/>
sincell\_with\_class\_5cl.RData.

The library has been prepared with 10x Chromium platform and sequenced with
Illumina NextSeq 500 platform. Raw data has been processed with cellranger.
The tool demuxlet has been used to predict the identity of each cell based on
known genetic differences between the different cell lines.

# 3 Data processing

Data processing was performed with the R-package *[Seurat](https://CRAN.R-project.org/package%3DSeurat)*. Gene
expressions were normalized with the function *[SCTransform](https://CRAN.R-project.org/package%3DSCTransform)*
using default parameters, and principal component analysis (PCA) was performed
with function *RunPCA* based on the 5,000 most variable genes in the dataset
identified with the function *FindVariableFeatures*.

In the data we saw that the first 15 principal components capture most of
the variance in the data, and the proportion of variance explained by each
subsequent principal component was negligible. Thus, we used the single cell
projections (embeddings) in 15-dimensional feature space, \(A^{3,918\times 15}\).

```
# # This script can be used to generate data("d_ccl", package = "scBubbletree")
#
# # create directory
# dir.create(path = "case_study/")
#
# # download the data from:
# https://github.com/LuyiTian/sc_mixology/raw/master/data/
#   sincell_with_class_5cl.RData
#
# # load the data
# load(file = "case_study/sincell_with_class_5cl.RData")
#
# # we are only interested in the 10x data object 'sce_sc_10x_5cl_qc'
# d <- sce_sc_10x_5cl_qc
#
# # remove the remaining objects (cleanup)
# rm(sc_Celseq2_5cl_p1, sc_Celseq2_5cl_p2, sc_Celseq2_5cl_p3, sce_sc_10x_5cl_qc)
#
# # get the meta data for each cell
# meta <- colData(d)[,c("cell_line_demuxlet","non_mt_percent","total_features")]
#
# # create Seurat object from the raw counts and append the meta data to it
# d <- Seurat::CreateSeuratObject(counts = d@assays$data$counts,
#                                 project = '')
#
# # check if all cells are matched between d and meta
# # table(rownames(d@meta.data) == meta@rownames)
# d@meta.data <- cbind(d@meta.data, meta@listData)
#
# # cell type predictions are provided as part of the meta data
# table(d@meta.data$cell_line)
#
# # select 5,000 most variable genes
# d <- Seurat::FindVariableFeatures(object = d,
#                                   selection.method = "vst",
#                                   nfeatures = 5000)
#
# # Preprocessing with Seurat: SCT transformation + PCA
# d <- SCTransform(object = d,
#                  variable.features.n = 5000)
# d <- RunPCA(object = d,
#             npcs = 50,
#             features = VariableFeatures(object = d))
#
# # perform UMAP + t-SNE
# d <- RunUMAP(d, dims = 1:15)
# d <- RunTSNE(d, dims = 1:15)
#
# # save the preprocessed data
# save(d, file = "case_study/d.RData")
#
# # save the PCA matrix 'A', meta data 'm' and
# # marker genes matrix 'e'
# d <- get(load(file ="case_study/d.RData"))
# A <- d@reductions$pca@cell.embeddings[, 1:15]
# m <- d@meta.data
# e <- t(as.matrix(d@assays$SCT@data[
#   rownames(d@assays$SCT@data) %in%
#     c("ALDH1A1",
#       "PIP4K2C",
#       "SLPI",
#       "CT45A2",
#       "CD74"), ]))
#
# d_ccl <- list(A = A, m = m, e = e)
# save(d_ccl, file = "data/d_ccl.RData")
```

Load the processed PCA matrix and the meta data

```
# Load the data
data("d_ccl", package = "scBubbletree")
```

```
# Extract the 15-dimensional PCA matrix A
# A has n=cells as rows, f=15 features as columns (e.g. from PCA)
A <- d_ccl$A
dim(A)
```

```
#> [1] 3918   15
```

```
# Extract the meta-data. For each cell this data contains some
# additional information. Inspect this data now!
m <- d_ccl$m
colnames(m)
```

```
#> [1] "orig.ident"         "nCount_RNA"         "nFeature_RNA"
#> [4] "cell_line_demuxlet" "non_mt_percent"     "total_features"
#> [7] "nCount_SCT"         "nFeature_SCT"
```

```
# Extract the normalized expressions of five marker genes. Rows
# are cells.
e <- d_ccl$e
colnames(e)
```

```
#> [1] "ALDH1A1" "SLPI"    "CD74"    "PIP4K2C" "CT45A2"
```

# 4 scBubbletree workflow

We will analyze this data with *[scBubbletree](https://bioconductor.org/packages/3.22/scBubbletree)*.

As main input *[scBubbletree](https://bioconductor.org/packages/3.22/scBubbletree)* uses matrix \(A^{n\times f}\) which
represents a low-dimensional projection of the original scRNA-seq data, with
\(n\) rows as cells and \(f\) columns as low-dimension features. Here we use
\(A^{3,918\times 15}\) as input.

**Important remark about \(A\)**: the *[scBubbletree](https://bioconductor.org/packages/3.22/scBubbletree)* workflow
works directly with the numeric matrix \(A^{n\times f}\) and is agnostic to
the initial data processing protocol. This enables seamless integration
of *[scBubbletree](https://bioconductor.org/packages/3.22/scBubbletree)* with computational pipelines using objects
generated by the R-packages *[Seurat](https://CRAN.R-project.org/package%3DSeurat)* and
*[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*. The users simply have to extract \(A\)
from the corresponding *[Seurat](https://CRAN.R-project.org/package%3DSeurat)* or
*[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* objects.

The *[scBubbletree](https://bioconductor.org/packages/3.22/scBubbletree)* workflow performs the following steps:

1. determine the clustering resolution (resolution \(r\) or clusters \(k\))
2. graph-based community detection (e.g. with Louvain) or k-means clustering
3. hierarchical organization of clusters (bubbles)
4. visualization

## 4.1 Determine the clustering resolution (**step 1**)

How many clusters (cell types) are there are in the data?

Before we apply clustering, we must first find appropriate value for the
resolution parameter \(k\) (if we intend to use k-means) or \(r\) (if we intend
to use graph based community detection approaches such as Louvain). In the
next we will first perform Louvain clustering and then k-means clustering.

## 4.2 Determining the resolution parameter \(r\) for Louvain clustering

How many clusters (cell types) are there are in the data?

For Louvain clustering we need to select a clustering resolution \(r\). Higher
resolutions lead to more communities (\(k'\)) and lower resolutions lead to fewer
communities.

To find a reasonable value of \(r\) we can study the literature or databases
such as the human protein atlas database (HPA). We can also use the function
`get_r` for data-driven inference of \(r\) based on the Gap statistic.

Lets use the function `get_r` for data-driven estimation of \(r\) based on
the Gap statistic and WCSS. As input we need to provide the matrix \(A\) and
a vector of \(r\)s to inspect. See the help function `?get_r` to learn more
about the remaining input parameters. The output of `get_r` is the Gap
statistic and WCSS estimate for each \(r\) (or the number of communities \(k'\)
detected at resolution \(r\)).

Lets run `get_r` now [this might take a minute]:

```
b_r <- get_r(B_gap = 5,
             rs = 10^seq(from = -4, to = 0.5, by = 0.5),
             x = A,
             n_start = 10,
             iter_max = 50,
             algorithm = "original",
             knn_k = 50,
             cores = 1)
```

The Gap curve has noticeable knee (elbow) at \(r \approx 0.003\) (dashed gray
line). Means (points) and 95% confidence intervals are shown for the Gap
statistic at each \(r\) using `B_gap`=5 MCMC simulations.

```
ggplot(data = b_r$gap_stats_summary)+
  geom_line(aes(x = r, y = gap_mean))+
  geom_point(aes(x = r, y = gap_mean), size = 1)+
  geom_errorbar(aes(x = r, y = gap_mean, ymin = L95, ymax = H95), width = 0.1)+
  ylab(label = "Gap")+
  xlab(label = "r")+
  geom_vline(xintercept = 0.003, col = "gray", linetype = "dashed")+
  scale_x_log10()+
  annotation_logticks(base = 10, sides = "b")
```

![](data:image/png;base64...)

The resolutions \(r\) are difficult to interpret. Lets map \(r\) to the number of
detected communities \(k'\) (analogous to clusters \(k\) in k-means clustering),
and show the Gap curve as a function of \(k'\).

```
ggplot(data = b_r$gap_stats_summary)+
  geom_line(aes(x = k, y = gap_mean))+
  geom_point(aes(x = k, y = gap_mean), size = 1)+
  geom_errorbar(aes(x = k, y = gap_mean, ymin = L95, ymax = H95), width = 0.1)+
  geom_vline(xintercept = 5, col = "gray", linetype = "dashed")+
  ylab(label = "Gap")+
  xlab(label = "k'")
```

![](data:image/png;base64...)

A range of resolutions yield \(k'\)=5 number of communities, i.e. among the
tested \(r\)s, we saw \(k'\)=5 communities for \(r\) = 0.003, 0.01, 0.03 and 0.1.
We can e.g. use \(r\)=0.1 for our clustering.

```
ggplot(data = b_r$gap_stats_summary)+
  geom_point(aes(x = r, y = k), size = 1)+
  xlab(label = "r")+
  ylab(label = "k'")+
  scale_x_log10()+
  annotation_logticks(base = 10, sides = "b")+
  theme_bw()
```

![](data:image/png;base64...)

Table with \(r\)s that match to \(k'\)=5:

```
knitr::kable(x = b_r$gap_stats_summary[b_r$gap_stats_summary$k == 5, ],
             digits = 4, row.names = FALSE)
```

| gap\_mean | r | k | gap\_SE | L95 | H95 |
| --- | --- | --- | --- | --- | --- |
| 2.1664 | 0.0032 | 5 | 0.0026 | 2.1613 | 2.1715 |
| 2.1660 | 0.0100 | 5 | 0.0045 | 2.1572 | 2.1748 |
| 2.1623 | 0.0316 | 5 | 0.0040 | 2.1544 | 2.1702 |
| 2.1659 | 0.1000 | 5 | 0.0033 | 2.1594 | 2.1723 |

## 4.3 Determining the number of clusters \(k\) for k-means clustering [**alternative**]

If we want to use k-means for clustering, then we need to find a reasonable
value of \(k\), e.g. by applying once again a data-driven search for \(k\) using
`get_k`.

Here `get_k` will inspect the Gap and WCSS at \(k\) = 1, 2, …, 10.

```
b_k <- get_k(B_gap = 5,
             ks = 1:10,
             x = A,
             n_start = 50,
             iter_max = 200,
             kmeans_algorithm = "MacQueen",
             cores = 1)
```

Notice the similar Gap curve with noticeable knee (elbow) at \(k = 5\) (dashed
gray line). Means (points) and 95% confidence intervals are shown for the Gap
statistic at each \(k\) using `B_gap`=5 MCMC simulations.

```
ggplot(data = b_k$gap_stats_summary)+
  geom_line(aes(x = k, y = gap_mean))+
  geom_point(aes(x = k, y = gap_mean), size = 1)+
  geom_errorbar(aes(x = k, y = gap_mean, ymin = L95, ymax = H95), width = 0.1)+
  ylab(label = "Gap")+
  geom_vline(xintercept = 5, col = "gray", linetype = "dashed")
```

![](data:image/png;base64...)

# 5 Clustering (**step 2**) and hierarchical grouping (**step 3**) of bubbles

## 5.1 Clustering with Louvain

Now that we found out that \(r=0.1\) (\(k'=5\)) is a reasonable choice based on
the data, we will perform Louvain clustering with \(r=0.1\) and \(A\) as inputs.
For this we will use the function `get_bubbletree_graph`.

After the clustering is complete we will organize the bubbles by hierarchical
clustering. For this we perform \(B\) bootstrap iterations. In iteration \(b\)
the algorithm draws a random subset of \(N\_{\text{eff}}\) (default
\(N\_{\text{eff}}=200\)) cells with replacement from each cluster and compute
the average inter-cluster Euclidean distances. This data is used to populate
the distance matrix (\(D^{k'\times k'}\_{b}\)), which is provided as input for
hierarchical clustering with average linkage to generate a hierarchical
clustering dendrogram \(H\_b\).

The collection of distance matrices that are computed during \(B\) iterations are
used to compute a consensus (average) distance matrix (\(\hat{D}^{k' \times k'}\))
and from this a corresponding consensus hierarchical dendrogram (bubbletree;
\(\hat{H}\)) is constructed. The collection of dendrograms are used to quantify
the robustness of the bubbletree topology, i.e. to count the number of times
each branch in the bubbletree is found among the topologies of the bootstrap
dendrograms. Branches can have has variable degrees of support ranging between
0 (no support) and \(B\) (complete support). Distances between bubbles (inter-
bubble relationships) are described quantitatively in the bubbletree as sums
of branch lengths.

Steps 2. (clustering) and 3. (hierarchical grouping) are performed now:

```
l <- get_bubbletree_graph(x = A,
                          r = 0.1,
                          algorithm = "original",
                          n_start = 20,
                          iter_max = 100,
                          knn_k = 50,
                          cores = 1,
                          B = 300,
                          N_eff = 200,
                          round_digits = 1,
                          show_simple_count = FALSE)

#  See the help `?get_bubbletree_graph` to learn about the input parameters.
```

… and plot the bubbletree

```
l$tree
```

![](data:image/png;base64...)

Lets describe the bubbletree:

**bubbles**: The bubbletree has `k'=5` bubbles (clusters) shown as leaves. The
absolute and relative cell frequencies in each bubble and the bubble IDs are
shown as labels. Bubble radii scale linearly with absolute cell count in each
bubble, i.e. large bubbles have many cells and small bubbles contain few cells.

Bubble 0 is the largest one in the dendrogram and contains 1,253 cells
(\(\approx\) 32% of all cells in the dataset). Bubble 4 is the smallest one
and contains only 437 cells (\(\approx\) 11% of all cells in the dataset).

We can access the bubble data shown in the bubbletree

```
knitr::kable(l$tree_meta, digits = 2, row.names = FALSE)
```

| label | Cells | n | p | pct | lab\_short | lab\_long | tree\_order |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 4 | 437 | 3918 | 0.11 | 11.2 | 4 (0.4K, 11.2%) | 4 (437, 11.2%) | 5 |
| 3 | 590 | 3918 | 0.15 | 15.1 | 3 (0.6K, 15.1%) | 3 (590, 15.1%) | 4 |
| 0 | 1253 | 3918 | 0.32 | 32.0 | 0 (1.3K, 32%) | 0 (1253, 32%) | 3 |
| 2 | 761 | 3918 | 0.19 | 19.4 | 2 (0.8K, 19.4%) | 2 (761, 19.4%) | 2 |
| 1 | 877 | 3918 | 0.22 | 22.4 | 1 (0.9K, 22.4%) | 1 (877, 22.4%) | 1 |

**topology**: inter-bubble distances are represented by sums of branch
lengths in the dendrogram. Branches of the bubbletree are annotated with
their bootstrap support values (red branch labels). The branch support
value tells us how many times a given branch from the bubbletree was found
among the \(B\) bootstrap dendrograms. We ran `get_bubbletree_graph` with
\(B=300\). All but one branch have complete (300 out of 300) support, and
one branch has lower support of 270 (90%). This tells us that the branch
between bubbles (3, 4) and 0 is not as robust.

## 5.2 Clustering with k-means (**[alternative]**)

To perform clustering with the k-means method we can use the function
`get_bubbletree_kmeans`.

```
k <- get_bubbletree_kmeans(x = A,
                           k = 5,
                           cores = 1,
                           B = 300,
                           N_eff = 200,
                           round_digits = 1,
                           show_simple_count = FALSE,
                           kmeans_algorithm = "MacQueen")
```

## 5.3 Comparison of bubbletree based on Louvain and k-means clustering

The two dendrograms are shown side-by-side.

```
l$tree|k$tree
```

![](data:image/png;base64...)

## 5.4 Visual comparison of two bubbletrees

To compare a pair of bubbletrees generated based on the same data but with
different inputs we can use the function `compare_bubbletrees`.

The function generates two bubbletrees and a heatmap, where the tiles of the
heatmap are color coded according to the jaccard distances (\(J\_D\)s) between the
pairs of bubbles from the two bubbletrees, and the tile labels show the numbers
of cells in common between the bubbles.

**Reminder of the Jaccard index (\(J\)) and the Jaccard distance (\(J\_{D}\))**:

For clusters \(A\) and \(B\) we compute the Jaccard index
\(J(A,B)=\dfrac{|A \cap B|}{|A \cup B|}\) and distance \(J\_{D}(A,B) = 1-J(A,B)\).
If \(A\) and \(B\) contain the same set of cells \(J\_{D}(A,B)\)=0, and if they have
no cells in common \(J\_{D}(A,B)\)=1.

The heatmap hints at nearly identical clusterings between the bubbletrees.
Only 3 cells (red tiles with label = 1) are classified differently by the
two bubbletrees.

```
cp <- compare_bubbletrees(btd_1 = l,
                          btd_2 = k,
                          ratio_heatmap = 0.6,
                          tile_bw = F,
                          tile_text_size = 3)
cp$comparison
```

![](data:image/png;base64...)

# 6 Visualization (**step 4**)

To extract biologically useful information from the bubbletree (and also for
2D UMAP or t-SNE plots) we need to adorn it with biologically relevant cell
features. This includes both **numeric** and **categorical** cell features.

Numeric cell features:

* gene expression
* % of mitochondrial transcripts
* number of UMIs, genes detected
* …

Categorical cell features:

* cell type label (e.g. B-cells, T-cells, moncytes, …)
* cell cycle phase (e.g. S, M, G1, …)
* sample name (e.g. S1, S2, S3, …)
* treatment group (e.g. cancer vs. control cell)
* multiplet status (e.g. singlet, doublet or multiplet)
* …

In the next two paragraph we will explain how to ‘attach’ numeric and
categorical features to the bubbletree using *[scBubbletree](https://bioconductor.org/packages/3.22/scBubbletree)*.

## 6.1 Attaching categorical features

Categorical cell features can be ‘attached’ to the bubbletree using the function
`get_cat_tiles`. Here we will show the relative frequency of cell type labels
across the bubbles (parameter `integrate_vertical=TRUE`).

Interpretation of the figure below:

* we see high degree of co-occurrence between cell lines and bubbles, i.e.
  each bubble is made up of cells from a distinct cell line
* for instance, 99.8% of cells that have feature HCC827 are found in bubble 3
* columns in the tile plot integrate to 100%

```
w1 <- get_cat_tiles(btd = l,
                    f = m$cell_line_demuxlet,
                    integrate_vertical = TRUE,
                    round_digits = 1,
                    x_axis_name = 'Cell line',
                    rotate_x_axis_labels = TRUE,
                    tile_text_size = 2.75)

(l$tree|w1$plot)+
  patchwork::plot_layout(widths = c(1, 1))
```

![](data:image/png;base64...)

We can also show the inter-bubble cell type composition, i.e. the relative
frequencies of different cell types in a specific bubble (with parameter
`integrate_vertical=FALSE`).

Interpretation of the figure below:

* the bubbles appear to be “pure” \(\rightarrow\) made up of cells from
  distinct cell lines
* the cell line composition of bubble 2 is: 0.1% H838, 99.6% H2228, 0.1%
  A549, 0.1% H1975 and 0% HCC827 cells
* rows integrate to 100% (here the numbers in the heatmap tiles are rounded
  to the nearest tenth, hence they integrate approximately to 100%)

```
w2 <- get_cat_tiles(btd = l,
                    f = m$cell_line_demuxlet,
                    integrate_vertical = FALSE,
                    round_digits = 1,
                    x_axis_name = 'Cell line',
                    rotate_x_axis_labels = TRUE,
                    tile_text_size = 2.75)

(l$tree|w2$plot)+patchwork::plot_layout(widths = c(1, 1))
```

![](data:image/png;base64...)

*[scBubbletree](https://bioconductor.org/packages/3.22/scBubbletree)* uses R-package *[ggtree](https://bioconductor.org/packages/3.22/ggtree)* to
visualize the bubbletree, and *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* to visualize
annotations. Furthermore, R-package *[patchwork](https://CRAN.R-project.org/package%3Dpatchwork)* is used to
combine plots.

```
(l$tree|w1$plot|w2$plot)+
  patchwork::plot_layout(widths = c(1, 2, 2))+
  patchwork::plot_annotation(tag_levels = "A")
```

![](data:image/png;base64...)

## 6.2 Gini impurity index

To quantify the purity of a cluster (or bubble) \(i\) with \(n\_i\) number of cells,
each of which carries one of \(L\) possible labels (e.g. cell lines), we can
compute the Gini impurity index:

\(\textit{GI}\_i=\sum\_{j=1}^{L} \pi\_{ij}(1-\pi\_{ij})\),

with \(\pi\_{ij}\) as the relative frequency of label \(j\) in cluster \(i\). In
homogeneous (`pure`) clusters most cells carry a distinct label. Hence, the
\(\pi\)’s are close to either 1 or 0, and *GI* takes on a small value close to
zero. In `impure` clusters cells carry a mixture of different labels. In
this case most \(\pi\) are far from either 1 or 0, and *GI* diverges from 0
and approaches 1. If the relative frequencies of the different labels in
cluster \(i\) are equal to the (background) relative frequencies of the labels
in the sample, then cluster \(i\) is completely `impure`.

To compute the overall Gini impurity of a bubbletree, which represents a
clustering solution with \(k\) bubbles, we estimated the weighted Gini impurity
(*WGI*) by computing the weighted (by the cluster size) average of the

\(\textit{WGI}=\sum\_{i=1}^{k} \textit{GI}\_i \dfrac{n\_i}{n}\),

with \(n\_i\) as the number of cells in cluster \(i\) and \(n=\sum\_i n\_i\).

The Gini impurity results are shown below:

```
# gini
get_gini(labels = m$cell_line_demuxlet,
         clusters = l$cluster)$gi
```

```
#>   cluster          GI
#> 1       3 0.010129273
#> 2       1 0.004553202
#> 3       4 0.000000000
#> 4       2 0.007863642
#> 5       0 0.000000000
```

All cluster-specific *GI*s are close to 0 and hence also *WGI* is close to 0.
This indicates nearly perfect mapping of cell lines to bubbles. This analysis
performed for different values of \(r\) with function `get_gini_r`, which takes
as main input the output of `get_k` or `get_r`

```
gini_boot <- get_gini_k(labels = m$cell_line_demuxlet, obj = b_r)
```

From the figure we can conclude that WGI drops to 0 at `k=5`, and all labels
are nearly perfectly split across the bubbles with each bubble containing cells
exclusively from one cell type.

```
g1 <- ggplot(data = gini_boot$wgi_summary)+
  geom_point(aes(x = k, y = wgi), size = 1)+
  ylab(label = "WGI")+
  ylim(c(0, 1))

g1
```

![](data:image/png;base64...)

## 6.3 Attaching numeric features

We can also “attach” numeric cell features to the bubbletree. We will “attach”
the expression of five marker genes, i.e. one marker gene for each of the five
cancer cell lines.

We can visualize numeric features in *two* ways.

First, we can show numeric feature aggregates (e.g. “mean”, “median”, “sum”,
“pct nonzero” or “pct zero”) in the different bubbles with `get_num_tiles`

```
w3 <- get_num_tiles(btd = l,
                    fs = e,
                    summary_function = "mean",
                    x_axis_name = 'Gene expression',
                    rotate_x_axis_labels = TRUE,
                    round_digits = 1,
                    tile_text_size = 2.75)

(l$tree|w3$plot)+patchwork::plot_layout(widths = c(1, 1))
```

![](data:image/png;base64...)

Second, we can visualize the distributions of the numeric cell features in each
bubble as violins with `get_num_violins`

```
w4 <- get_num_violins(btd = l,
                      fs = e,
                      x_axis_name = 'Gene expression',
                      rotate_x_axis_labels = TRUE)

(l$tree|w3$plot|w4$plot)+
  patchwork::plot_layout(widths = c(1.5, 2, 2.5))+
  patchwork::plot_annotation(tag_levels = 'A')
```

![](data:image/png;base64...)

## 6.4 Quality control with *[scBubbletree](https://bioconductor.org/packages/3.22/scBubbletree)*

What is the percent of UMIs coming from mitochondrial genes in each bubble?

```
w_mt_dist <- get_num_violins(btd = l,
                             fs = 1-m$non_mt_percent,
                             x_axis_name = 'MT [%]',
                             rotate_x_axis_labels = TRUE)

w_umi_dist <- get_num_violins(btd = l,
                              fs = m$nCount_RNA/1000,
                              x_axis_name = 'RNA count (in thousands)',
                              rotate_x_axis_labels = TRUE)

w_gene_dist <- get_num_violins(btd = l,
                               fs = m$nFeature_RNA,
                               x_axis_name = 'Gene count',
                               rotate_x_axis_labels = TRUE)

(l$tree|w_mt_dist$plot|w_umi_dist$plot|w_gene_dist$plot)+
  patchwork::plot_layout(widths = c(1, 1, 1, 1))+
  patchwork::plot_annotation(tag_levels = 'A')
```

![](data:image/png;base64...)

# 7 scBubbletree can incorporate results from other clustering approaches

Numerous approaches exist for clustering of scRNA-seq data, and
*[scBubbletree](https://bioconductor.org/packages/3.22/scBubbletree)* implements the function `get_bubbletree_dummy`
to allow users to incorporate results from various clustering approaches
together with our workflow. With this function we skip the clustering
portion of the workflow and proceed with computing distances between the
clusters and generation of the bubbletree.

Lets try `get_bubbletree_dummy`. First, will perform k-medoids clustering
with R-package *[cluster](https://CRAN.R-project.org/package%3Dcluster)* and then generate the bubbletree:

```
pam_k5 <- cluster::pam(x = A, k = 5, metric = "euclidean")

dummy_k5_pam <- get_bubbletree_dummy(x = A,
                                     cs = pam_k5$clustering,
                                     B = 200,
                                     N_eff = 200,
                                     cores = 2,
                                     round_digits = 1)

dummy_k5_pam$tree|
  get_cat_tiles(btd = dummy_k5_pam,
                f = m$cell_line_demuxlet,
                integrate_vertical = TRUE,
                round_digits = 1,
                tile_text_size = 2.75,
                x_axis_name = 'Cell line',
                rotate_x_axis_labels = TRUE)$plot
```

![](data:image/png;base64...)

# 8 Adding custom visuals: cell-cell communication

```
# e.g. matrix from CellChat
cc_mat <- matrix(data = runif(n = 25, min = 0, max = 0.5),
                 nrow = 5, ncol = 5)
colnames(cc_mat) <- 0:4
rownames(cc_mat) <- 0:4
diag(cc_mat) <- 1

cc <- reshape2::melt(cc_mat)
cc$Var1 <- factor(x = cc$Var1, levels = rev(l$tree_meta$label))
cc$Var2 <- factor(x = cc$Var2, levels = rev(l$tree_meta$label))
colnames(cc) <- c("x", "y", "cc")

g_cc <- ggplot()+
  geom_tile(data = cc, aes(x = x, y = y, fill = cc), col = "white")+
  scale_fill_distiller(palette = "Spectral")+
  xlab(label = "Cluster x")+
  ylab(label = "Cluster y")
```

```
l$tree|g_cc
```

![](data:image/png;base64...)

# 9 Visualizing features of individual cells

```
g_cell_feature_1 <- get_num_cell_tiles(btd = l,
                   f = e[,1],
                   tile_bw = FALSE,
                   x_axis_name = "ALDH1A1 gene expr.",
                   rotate_x_axis_labels = FALSE)

g_cell_feature_2 <- get_num_cell_tiles(btd = l,
                   f = e[,2],
                   tile_bw = FALSE,
                   x_axis_name = "SLPI gene expr.",
                   rotate_x_axis_labels = FALSE)

l$tree|g_cell_feature_1$plot|g_cell_feature_2$plot
```

![](data:image/png;base64...)

# 10 Summary

*[scBubbletree](https://bioconductor.org/packages/3.22/scBubbletree)* promotes simple and transparent visual exploration
of scRNA-seq. It is **not a black-box approach** and the user is encouraged to
explore the data with different values of \(k\) and \(r\) or custom clustering
solutions. Attaching of cell features to the bubbletree is necessary for
biological interpretation of the individual bubbles and their relationships
which are described by the bubbletree.

# 11 Session Info

```
sessionInfo()
```

```
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
#> [1] future_1.67.0       patchwork_1.3.2     ggtree_4.0.1
#> [4] ggplot2_4.0.0       scBubbletree_1.12.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3      jsonlite_2.0.0          magrittr_2.0.4
#>   [4] magick_2.9.0            spatstat.utils_3.2-0    farver_2.1.2
#>   [7] rmarkdown_2.30          fs_1.6.6                vctrs_0.6.5
#>  [10] ROCR_1.0-11             spatstat.explore_3.5-3  tinytex_0.57
#>  [13] htmltools_0.5.8.1       gridGraphics_0.5-1      sass_0.4.10
#>  [16] sctransform_0.4.2       parallelly_1.45.1       KernSmooth_2.23-26
#>  [19] bslib_0.9.0             htmlwidgets_1.6.4       ica_1.0-3
#>  [22] plyr_1.8.9              plotly_4.11.0           zoo_1.8-14
#>  [25] cachem_1.1.0            igraph_2.2.1            mime_0.13
#>  [28] lifecycle_1.0.4         pkgconfig_2.0.3         Matrix_1.7-4
#>  [31] R6_2.6.1                fastmap_1.2.0           fitdistrplus_1.2-4
#>  [34] shiny_1.11.1            digest_0.6.37           aplot_0.2.9
#>  [37] Seurat_5.3.1            tensor_1.5.1            RSpectra_0.16-2
#>  [40] irlba_2.3.5.1           labeling_0.4.3          progressr_0.17.0
#>  [43] spatstat.sparse_3.1-0   httr_1.4.7              polyclip_1.10-7
#>  [46] abind_1.4-8             compiler_4.5.1          proxy_0.4-27
#>  [49] fontquiver_0.2.1        withr_3.0.2             S7_0.2.0
#>  [52] BiocParallel_1.44.0     fastDummies_1.7.5       MASS_7.3-65
#>  [55] rappdirs_0.3.3          tools_4.5.1             lmtest_0.9-40
#>  [58] otel_0.2.0              ape_5.8-1               httpuv_1.6.16
#>  [61] future.apply_1.20.0     goftest_1.2-3           glue_1.8.0
#>  [64] nlme_3.1-168            promises_1.4.0          grid_4.5.1
#>  [67] Rtsne_0.17              cluster_2.1.8.1         reshape2_1.4.4
#>  [70] generics_0.1.4          gtable_0.3.6            spatstat.data_3.1-9
#>  [73] tidyr_1.3.1             data.table_1.17.8       sp_2.2-0
#>  [76] spatstat.geom_3.6-0     RcppAnnoy_0.0.22        ggrepel_0.9.6
#>  [79] RANN_2.6.2              pillar_1.11.1           stringr_1.5.2
#>  [82] yulab.utils_0.2.1       spam_2.11-1             RcppHNSW_0.6.0
#>  [85] later_1.4.4             splines_4.5.1           dplyr_1.1.4
#>  [88] treeio_1.34.0           lattice_0.22-7          survival_3.8-3
#>  [91] deldir_2.0-4            tidyselect_1.2.1        fontLiberation_0.1.0
#>  [94] miniUI_0.1.2            pbapply_1.7-4           knitr_1.50
#>  [97] fontBitstreamVera_0.1.1 gridExtra_2.3           bookdown_0.45
#> [100] scattermore_1.2         xfun_0.54               matrixStats_1.5.0
#> [103] stringi_1.8.7           lazyeval_0.2.2          ggfun_0.2.0
#> [106] yaml_2.3.10             evaluate_1.0.5          codetools_0.2-20
#> [109] gdtools_0.4.4           tibble_3.3.0            BiocManager_1.30.26
#> [112] ggplotify_0.1.3         cli_3.6.5               uwot_0.2.3
#> [115] xtable_1.8-4            reticulate_1.44.0       systemfonts_1.3.1
#> [118] jquerylib_0.1.4         dichromat_2.0-0.1       Rcpp_1.1.0
#> [121] globals_0.18.0          spatstat.random_3.4-2   png_0.1-8
#> [124] spatstat.univar_3.1-4   parallel_4.5.1          dotCall64_1.2
#> [127] listenv_0.9.1           viridisLite_0.4.2       tidytree_0.4.6
#> [130] ggiraph_0.9.2           scales_1.4.0            ggridges_0.5.7
#> [133] SeuratObject_5.2.0      purrr_1.1.0             rlang_1.1.6
#> [136] cowplot_1.2.0
```