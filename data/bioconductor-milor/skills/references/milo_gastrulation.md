# Differential abundance testing with Milo - Mouse gastrulation example

Emma Dann and Mike Morgan

#### 30 October 2025

#### Package

miloR 2.6.0

```
library(miloR)
library(SingleCellExperiment)
library(scater)
library(scran)
library(dplyr)
library(patchwork)
library(MouseGastrulationData)
```

# 1 Load data

For this vignette we will use the mouse gastrulation single-cell data from [Pijuan-Sala et al. 2019](https://www.nature.com/articles/s41586-019-0933-9). The dataset can be downloaded as a `SingleCellExperiment` object from the [`MouseGastrulationData`](https://bioconductor.org/packages/3.12/data/experiment/html/MouseGastrulationData.html) package on Bioconductor. To make computations faster, here we will download just a subset of samples, 4 samples at stage E7 and 4 samples at stage E7.5.

This dataset has already been pre-processed and contains a `pca.corrected` dimensionality reduction, which was built after batch correction using [`fastMNN`](https://bioconductor.org/packages/release/bioc/vignettes/batchelor/inst/doc/correction.html).

```
select_samples <- c(2,  3,  6, 4, #15,
                    # 19,
                    10, 14#, 20 #30
                    #31, 32
                    )
embryo_data = EmbryoAtlasData(samples = select_samples)
embryo_data
```

```
## class: SingleCellExperiment
## dim: 29452 7558
## metadata(0):
## assays(1): counts
## rownames(29452): ENSMUSG00000051951 ENSMUSG00000089699 ...
##   ENSMUSG00000096730 ENSMUSG00000095742
## rowData names(2): ENSEMBL SYMBOL
## colnames(7558): cell_361 cell_362 ... cell_29013 cell_29014
## colData names(17): cell barcode ... colour sizeFactor
## reducedDimNames(2): pca.corrected umap
## mainExpName: NULL
## altExpNames(0):
```

# 2 Visualize the data

We recompute the UMAP embedding for this subset of cells to visualize the data.

```
embryo_data <- embryo_data[,apply(reducedDim(embryo_data, "pca.corrected"), 1, function(x) !all(is.na(x)))]
embryo_data <- runUMAP(embryo_data, dimred = "pca.corrected", name = 'umap')

plotReducedDim(embryo_data, colour_by="stage", dimred = "umap")
```

![](data:image/jpeg;base64...)

We will test for significant differences in abundance of cells between these stages of development, and the associated gene signatures.

# 3 Differential abundance testing

## 3.1 Create a Milo object

For differential abundance analysis on graph neighbourhoods we first construct a `Milo` object. This extends the [`SingleCellExperiment`](https://bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html) class to store information about neighbourhoods on the KNN graph.

```
embryo_milo <- Milo(embryo_data)
embryo_milo
```

```
## class: Milo
## dim: 29452 6875
## metadata(0):
## assays(1): counts
## rownames(29452): ENSMUSG00000051951 ENSMUSG00000089699 ...
##   ENSMUSG00000096730 ENSMUSG00000095742
## rowData names(2): ENSEMBL SYMBOL
## colnames(6875): cell_361 cell_362 ... cell_29013 cell_29014
## colData names(17): cell barcode ... colour sizeFactor
## reducedDimNames(2): pca.corrected umap
## mainExpName: NULL
## altExpNames(0):
## nhoods dimensions(2): 1 1
## nhoodCounts dimensions(2): 1 1
## nhoodDistances dimension(1): 0
## graph names(0):
## nhoodIndex names(1): 0
## nhoodExpression dimension(2): 1 1
## nhoodReducedDim names(0):
## nhoodGraph names(0):
## nhoodAdjacency dimension(2): 1 1
```

## 3.2 Construct KNN graph

We need to add the KNN graph to the Milo object. This is stored in the `graph` slot, in [`igraph`](https://igraph.org/r/) format. The `miloR` package includes functionality to build and store the graph from the PCA dimensions stored in the `reducedDim` slot. In this case, we specify that we want to build the graph from the MNN corrected PCA dimensions.

For graph building you need to define a few parameters:

* `d`: the number of reduced dimensions to use for KNN refinement. We recommend using the same \(d\) used for KNN graph building, or to select PCs by inspecting the [scree plot](http://bioconductor.org/books/release/OSCA/dimensionality-reduction.html#choosing-the-number-of-pcs).
* `k`: this affects the power of DA testing, since we need to have enough cells from each sample represented in a neighbourhood to estimate the variance between replicates. On the other side, increasing \(k\) too much might lead to over-smoothing. We suggest to start by using the same value for \(k\) used for KNN graph building for clustering and UMAP visualization. We will later use some heuristics to evaluate whether the value of \(k\) should be increased.

```
embryo_milo <- buildGraph(embryo_milo, k = 30, d = 30, reduced.dim = "pca.corrected")
```

Alternatively, one can add a precomputed KNN graph (for example constructed with Seurat or scanpy) to the `graph` slot using the adjacency matrix, through the helper function `buildFromAdjacency`.

## 3.3 Defining representative neighbourhoods on the KNN graph

We define the neighbourhood of a cell, the index, as the group of cells connected by an edge in the KNN graph to the index cell. For efficiency, we don’t test for DA in the neighbourhood of every cell, but we sample as indices a subset of representative cells, using a KNN sampling algorithm used by [Gut et al. 2015](https://www.nature.com/articles/nmeth.3545).

As well as \(d\) and \(k\), for sampling we need to define a few additional parameters:

* `prop`: the proportion of cells to randomly sample to start with. We suggest using `prop=0.1` for datasets of less than 30k cells. For bigger datasets using `prop=0.05` should be sufficient (and makes computation faster).
* `refined`: indicates whether you want to use the sampling refinement algorithm, or just pick cells at random. The default and recommended way to go is to use refinement. The only situation in which you might consider using `random` instead, is if you have batch corrected your data with a graph based correction algorithm, such as [BBKNN](https://github.com/Teichlab/bbknn), but the results of DA testing will be suboptimal.

```
embryo_milo <- makeNhoods(embryo_milo, prop = 0.1, k = 30, d=30, refined = TRUE, reduced_dims = "pca.corrected")
```

Once we have defined neighbourhoods, we plot the distribution of neighbourhood sizes (i.e. how many cells form each neighbourhood) to evaluate whether the value of \(k\) used for graph building was appropriate. We can check this out using the `plotNhoodSizeHist` function.

As a rule of thumb we want to have an average neighbourhood size over 5 x N\_samples. If the mean is lower, or if the distribution is

```
plotNhoodSizeHist(embryo_milo)
```

![](data:image/png;base64...)

## 3.4 Counting cells in neighbourhoods

*Milo* leverages the variation in cell numbers between replicates for the same experimental condition to test for differential abundance. Therefore we have to count how many cells from each sample are in each neighbourhood. We need to use the cell metadata and specify which column contains the sample information.

```
embryo_milo <- countCells(embryo_milo, meta.data = as.data.frame(colData(embryo_milo)), sample="sample")
```

This adds to the `Milo` object a \(n \times m\) matrix, where \(n\) is the number of neighbourhoods and \(m\) is the number of experimental samples. Values indicate the number of cells from each sample counted in a neighbourhood. This count matrix will be used for DA testing.

```
head(nhoodCounts(embryo_milo))
```

```
## 6 x 6 sparse Matrix of class "dgCMatrix"
##    2  3  6 4 10 14
## 1  .  .  9 . 64 32
## 2  6  4 26 3 24 15
## 3  9  9 31 2  .  1
## 4  4  4 36 8  4  5
## 5  .  .  5 . 90 19
## 6 16 10 48 2  .  .
```

## 3.5 Defining experimental design

Now we are all set to test for differential abundance in neighbourhoods. We implement this hypothesis testing in a generalized linear model (GLM) framework, specifically using the Negative Binomial GLM implementation in [`edgeR`](https://bioconductor.org/packages/release/bioc/html/edgeR.html).

We first need to think about our experimental design. The design matrix should match each sample to the experimental condition of interest for DA testing. In this case, we want to detect DA between embryonic stages, stored in the `stage` column of the dataset `colData`. We also include the `sequencing.batch` column in the design matrix. This represents a known technical covariate that we want to account for in DA testing.

```
embryo_design <- data.frame(colData(embryo_milo))[,c("sample", "stage", "sequencing.batch")]

## Convert batch info from integer to factor
embryo_design$sequencing.batch <- as.factor(embryo_design$sequencing.batch)
embryo_design <- distinct(embryo_design)
rownames(embryo_design) <- embryo_design$sample

embryo_design
```

```
##    sample stage sequencing.batch
## 2       2  E7.5                1
## 3       3  E7.5                1
## 6       6  E7.5                1
## 4       4  E7.5                1
## 10     10  E7.0                1
## 14     14  E7.0                2
```

## 3.6 Computing neighbourhood connectivity

Milo uses an adaptation of the Spatial FDR correction introduced by [cydar](https://bioconductor.org/packages/release/bioc/html/cydar.html), where we correct p-values accounting for the amount of overlap between neighbourhoods. Specifically, each hypothesis test P-value is weighted by the reciprocal of the kth nearest neighbour distance. To use this statistic we first need to store the distances between nearest neighbors in the Milo object. This is done by the `calcNhoodDistance` function
(N.B. this step is the most time consuming of the analysis workflow and might take a couple of minutes for large datasets).

```
embryo_milo <- calcNhoodDistance(embryo_milo, d=30, reduced.dim = "pca.corrected")
```

## 3.7 Testing

Now we can do the DA test, explicitly defining our experimental design. In this case, we want to test for differences between experimental stages, while accounting for the variability between technical batches (You can find more info on how to use formulas to define a testing design in R [here](https://r4ds.had.co.nz/model-basics.html#formulas-and-model-families))

```
da_results <- testNhoods(embryo_milo, design = ~ sequencing.batch + stage, design.df = embryo_design, reduced.dim="pca.corrected")
head(da_results)
```

```
##        logFC   logCPM          F       PValue          FDR Nhood   SpatialFDR
## 1 -4.7974011 12.10264 27.1557001 2.172565e-07 1.540211e-06     1 1.316986e-06
## 2 -0.8286147 11.72678  0.9634258 3.265031e-01 3.803505e-01     2 3.818461e-01
## 3  6.9795804 11.17203 11.3528214 7.748242e-04 1.856602e-03     3 1.802668e-03
## 4  2.1028256 11.30211  3.0663357 8.015910e-02 1.111240e-01     4 1.131791e-01
## 5 -5.9747766 12.08922 38.3678347 7.787317e-10 2.964625e-08     5 2.375822e-08
## 6  7.5247573 11.61604 16.3800802 5.480179e-05 1.950944e-04     6 1.754109e-04
```

This calculates a Fold-change and corrected P-value for each neighbourhood, which indicates whether there is significant differential abundance between developmental stages. The main statistics we consider here are:

* `logFC`: indicates the log-Fold change in cell numbers between samples from E7.5 and samples from E7.0
* `PValue`: reports P-values before FDR correction
* `SpatialFDR`: reports P-values corrected for multiple testing accounting for overlap between neighbourhoods

```
da_results %>%
  arrange(SpatialFDR) %>%
  head()
```

```
##         logFC   logCPM        F       PValue          FDR Nhood   SpatialFDR
## 334 -8.756086 11.79849 49.63519 2.957630e-12 1.316145e-09   334 1.039474e-09
## 27  -6.101607 12.04010 42.83166 8.482977e-11 1.592452e-08    27 1.238707e-08
## 198 -6.350692 11.83080 42.35629 1.073563e-10 1.592452e-08   198 1.238707e-08
## 67  -5.894956 11.92812 41.26669 1.842855e-10 1.668443e-08    67 1.289327e-08
## 182 -6.541153 11.47949 41.23221 1.874655e-10 1.668443e-08   182 1.289327e-08
## 204 -6.094857 11.54061 40.30686 2.968044e-10 1.802210e-08   204 1.436191e-08
```

# 4 Inspecting DA testing results

We can start inspecting the results of our DA analysis from a couple of standard diagnostic plots.
We first inspect the distribution of uncorrected P values, to verify that the test was balanced.

```
ggplot(da_results, aes(PValue)) + geom_histogram(bins=50)
```

![](data:image/png;base64...)

Then we visualize the test results with a volcano plot (remember that each point here represents a neighbourhood, *not* a cell).

```
ggplot(da_results, aes(logFC, -log10(SpatialFDR))) +
  geom_point() +
  geom_hline(yintercept = 1) ## Mark significance threshold (10% FDR)
```

![](data:image/jpeg;base64...)

Looks like we have detected several neighbourhoods were there is a significant difference in cell abundances between developmental stages.

To visualize DA results relating them to the embedding of single cells, we can build an abstracted graph of neighbourhoods that we can superimpose on the single-cell embedding. Here each node represents a neighbourhood, while edges indicate how many cells two neighbourhoods have in common. Here the layout of nodes is determined by the position of the index cell in the UMAP embedding of all single-cells. The neighbourhoods displaying significant DA are colored by their log-Fold Change.

```
embryo_milo <- buildNhoodGraph(embryo_milo)

## Plot single-cell UMAP
umap_pl <- plotReducedDim(embryo_milo, dimred = "umap", colour_by="stage", text_by = "celltype",
                          text_size = 3, point_size=0.5) +
  guides(fill="none")

## Plot neighbourhood graph
nh_graph_pl <- plotNhoodGraphDA(embryo_milo, da_results, layout="umap",alpha=0.1)

umap_pl + nh_graph_pl +
  plot_layout(guides="collect")
```

```
## Warning: ggrepel: 5 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

![](data:image/jpeg;base64...)

We might also be interested in visualizing whether DA is particularly evident in certain cell types. To do this, we assign a cell type label to each neighbourhood by finding the most abundant cell type within cells in each neighbourhood. We can label neighbourhoods in the results `data.frame` using the function `annotateNhoods`. This also saves the fraction of cells harbouring the label.

```
da_results <- annotateNhoods(embryo_milo, da_results, coldata_col = "celltype")
head(da_results)
```

```
##        logFC   logCPM          F       PValue          FDR Nhood   SpatialFDR
## 1 -4.7974011 12.10264 27.1557001 2.172565e-07 1.540211e-06     1 1.316986e-06
## 2 -0.8286147 11.72678  0.9634258 3.265031e-01 3.803505e-01     2 3.818461e-01
## 3  6.9795804 11.17203 11.3528214 7.748242e-04 1.856602e-03     3 1.802668e-03
## 4  2.1028256 11.30211  3.0663357 8.015910e-02 1.111240e-01     4 1.131791e-01
## 5 -5.9747766 12.08922 38.3678347 7.787317e-10 2.964625e-08     5 2.375822e-08
## 6  7.5247573 11.61604 16.3800802 5.480179e-05 1.950944e-04     6 1.754109e-04
##               celltype celltype_fraction
## 1     Primitive Streak         0.9904762
## 2         ExE endoderm         1.0000000
## 3 Rostral neurectoderm         0.6346154
## 4       Mixed mesoderm         0.8524590
## 5             Epiblast         0.7543860
## 6       Mixed mesoderm         0.4868421
```

While neighbourhoods tend to be homogeneous, we can define a threshold for `celltype_fraction` to exclude neighbourhoods that are a mix of cell types.

```
ggplot(da_results, aes(celltype_fraction)) + geom_histogram(bins=50)
```

![](data:image/png;base64...)

```
da_results$celltype <- ifelse(da_results$celltype_fraction < 0.7, "Mixed", da_results$celltype)
```

Now we can visualize the distribution of DA Fold Changes in different cell types

```
plotDAbeeswarm(da_results, group.by = "celltype")
```

![](data:image/jpeg;base64...)

This is already quite informative: we can see that certain early development cell types, such as epiblast and primitive streak, are enriched in the earliest time stage, while others are enriched later in development, such as ectoderm cells. Interestingly, we also see plenty of DA neighbourhood with a mixed label. This could indicate that transitional states show changes in abundance in time.

# 5 Finding markers of DA populations

Once you have found your neighbourhoods showindg significant DA between conditions, you might want to find gene signatures specific to the cells in those neighbourhoods. The function `findNhoodGroupMarkers` runs a one-VS-all differential gene expression test to identify marker genes for a group of neighbourhoods of interest. Before running this function you will need to define your neighbourhood groups depending on your biological question, that need to be stored as a `NhoodGroup` column in the `da_results` data.frame.

### 5.0.1 Custom grouping

In a case where all the DA neighbourhoods seem to belong to the same region of the graph, you might just want to test the significant DA neighbourhoods with the same logFC against all the rest (N.B. for illustration purposes, here I am testing on a randomly selected set of 10 genes).

```
## Add log normalized count to Milo object
embryo_milo <- logNormCounts(embryo_milo)

da_results$NhoodGroup <- as.numeric(da_results$SpatialFDR < 0.1 & da_results$logFC < 0)
da_nhood_markers <- findNhoodGroupMarkers(embryo_milo, da_results, subset.row = rownames(embryo_milo)[1:10])
```

```
## Warning: Zero sample variances detected, have been offset away from zero
## Warning: Zero sample variances detected, have been offset away from zero
```

```
head(da_nhood_markers)
```

```
##               GeneID       logFC_1  adj.P.Val_1       logFC_0  adj.P.Val_0
## 1 ENSMUSG00000025900 -0.0001046701 1.0000000000  0.0001046701 1.0000000000
## 2 ENSMUSG00000025902 -0.0954830029 0.0002924265  0.0954830029 0.0002924265
## 3 ENSMUSG00000025903  0.0799324365 0.0002924265 -0.0799324365 0.0002924265
## 4 ENSMUSG00000033813  0.0396852973 0.1312400689 -0.0396852973 0.1312400689
## 5 ENSMUSG00000033845  0.0651886020 0.0113467960 -0.0651886020 0.0113467960
## 6 ENSMUSG00000051951  0.0000000000 1.0000000000  0.0000000000 1.0000000000
```

For this analysis we recommend aggregating the neighbourhood expression profiles by experimental samples (the same used for DA testing), by setting `aggregate.samples=TRUE`. This way single-cells will not be considered as “replicates” during DGE testing, and dispersion will be estimated between true biological replicates. Like so:

```
da_nhood_markers <- findNhoodGroupMarkers(embryo_milo, da_results, subset.row = rownames(embryo_milo)[1:10],
                                          aggregate.samples = TRUE, sample_col = "sample")
```

```
## Warning: Zero sample variances detected, have been offset away from zero
## Warning: Zero sample variances detected, have been offset away from zero
```

```
head(da_nhood_markers)
```

```
##               GeneID      logFC_1 adj.P.Val_1      logFC_0 adj.P.Val_0
## 1 ENSMUSG00000025900 -0.001862979           1  0.001862979           1
## 2 ENSMUSG00000025902  0.151781135           1 -0.151781135           1
## 3 ENSMUSG00000025903  0.005123884           1 -0.005123884           1
## 4 ENSMUSG00000033813 -0.064504569           1  0.064504569           1
## 5 ENSMUSG00000033845  0.079003329           1 -0.079003329           1
## 6 ENSMUSG00000051951  0.000000000           1  0.000000000           1
```

(Notice the difference in p values)

## 5.1 Automatic grouping of neighbourhoods

In many cases, such as this example, DA neighbourhoods are found in different areas of the KNN graph, and grouping together all significant DA populations might not be ideal, as they might include cells of very different celltypes. For this kind of scenario, we have implemented a neighbourhood function that uses community detection to partition neighbourhoods into groups on the basis of (1) the number of shared cells between 2 neighbourhoods; (2) the direction of fold-change for DA neighbourhoods; (3) the difference in fold change.

```
## Run buildNhoodGraph to store nhood adjacency matrix
embryo_milo <- buildNhoodGraph(embryo_milo)

## Find groups
da_results <- groupNhoods(embryo_milo, da_results, max.lfc.delta = 10)
head(da_results)
```

```
##        logFC   logCPM          F       PValue          FDR Nhood   SpatialFDR
## 1 -4.7974011 12.10264 27.1557001 2.172565e-07 1.540211e-06     1 1.316986e-06
## 2 -0.8286147 11.72678  0.9634258 3.265031e-01 3.803505e-01     2 3.818461e-01
## 3  6.9795804 11.17203 11.3528214 7.748242e-04 1.856602e-03     3 1.802668e-03
## 4  2.1028256 11.30211  3.0663357 8.015910e-02 1.111240e-01     4 1.131791e-01
## 5 -5.9747766 12.08922 38.3678347 7.787317e-10 2.964625e-08     5 2.375822e-08
## 6  7.5247573 11.61604 16.3800802 5.480179e-05 1.950944e-04     6 1.754109e-04
##           celltype celltype_fraction NhoodGroup
## 1 Primitive Streak         0.9904762          1
## 2     ExE endoderm         1.0000000          2
## 3            Mixed         0.6346154          3
## 4   Mixed mesoderm         0.8524590          4
## 5         Epiblast         0.7543860          5
## 6            Mixed         0.4868421          4
```

Let’s have a look at the detected groups

```
plotNhoodGroups(embryo_milo, da_results, layout="umap")
```

![](data:image/jpeg;base64...)

```
plotDAbeeswarm(da_results, "NhoodGroup")
```

![](data:image/jpeg;base64...)

We can easily check how changing the grouping parameters changes the groups we obtain, starting with the LFC delta by plotting with different values of `max.lfc.delta`
(not executed here).

```
# code not run - uncomment to run.
# plotDAbeeswarm(groupNhoods(embryo_milo, da_results, max.lfc.delta = 1) , group.by = "NhoodGroup") + ggtitle("max LFC delta=1")
# plotDAbeeswarm(groupNhoods(embryo_milo, da_results, max.lfc.delta = 2)   , group.by = "NhoodGroup") + ggtitle("max LFC delta=2")
# plotDAbeeswarm(groupNhoods(embryo_milo, da_results, max.lfc.delta = 3)   , group.by = "NhoodGroup") + ggtitle("max LFC delta=3")
```

…and we can do the same for the minimum overlap between neighbourhoods… (code not executed).

```
# code not run - uncomment to run.
# plotDAbeeswarm(groupNhoods(embryo_milo, da_results, max.lfc.delta = 5, overlap=1) , group.by = "NhoodGroup") + ggtitle("overlap=5")
# plotDAbeeswarm(groupNhoods(embryo_milo, da_results, max.lfc.delta = 5, overlap=5)   , group.by = "NhoodGroup") + ggtitle("overlap=10")
# plotDAbeeswarm(groupNhoods(embryo_milo, da_results, max.lfc.delta = 5, overlap=10)   , group.by = "NhoodGroup") + ggtitle("overlap=20")
```

In these examples we settle for `overlap=5` and `max.lfc.delta=5`, as we need at least 2 neighbourhoods assigned to each group.

```
set.seed(42)
da_results <- groupNhoods(embryo_milo, da_results, max.lfc.delta = 10, overlap=1)
plotNhoodGroups(embryo_milo, da_results, layout="umap")
```

![](data:image/jpeg;base64...)

```
plotDAbeeswarm(da_results, group.by = "NhoodGroup")
```

![](data:image/jpeg;base64...)

## 5.2 Finding gene signatures for neighbourhoods

Once we have grouped neighbourhoods using `groupNhoods` we are now all set to identifying gene signatures between neighbourhood groups.

Let’s restrict the testing to highly variable genes in this case

```
## Exclude zero counts genes
keep.rows <- rowSums(logcounts(embryo_milo)) != 0
embryo_milo <- embryo_milo[keep.rows, ]

## Find HVGs
set.seed(101)
dec <- modelGeneVar(embryo_milo)
hvgs <- getTopHVGs(dec, n=2000)

# this vignette randomly fails to identify HVGs for some reason
if(!length(hvgs)){
    set.seed(42)
    dec <- modelGeneVar(embryo_milo)
    hvgs <- getTopHVGs(dec, n=2000)
}

head(hvgs)
```

```
## [1] "ENSMUSG00000032083" "ENSMUSG00000095180" "ENSMUSG00000061808"
## [4] "ENSMUSG00000002985" "ENSMUSG00000024990" "ENSMUSG00000024391"
```

We run `findNhoodGroupMarkers` to test for one-vs-all differential gene expression for each neighbourhood group

```
set.seed(42)
nhood_markers <- findNhoodGroupMarkers(embryo_milo, da_results, subset.row = hvgs,
                                       aggregate.samples = TRUE, sample_col = "sample")

head(nhood_markers)
```

```
##               GeneID     logFC_1 adj.P.Val_1     logFC_2  adj.P.Val_2
## 1 ENSMUSG00000000031 -1.47562233   0.1568701  3.11114670 5.602399e-08
## 2 ENSMUSG00000000078 -0.14885805   0.6568551  0.14556355 4.401459e-01
## 3 ENSMUSG00000000088 -0.30775228   0.5459875  0.76824911 6.855264e-04
## 4 ENSMUSG00000000125  0.03803629   0.8232731 -0.03411262 7.299034e-01
## 5 ENSMUSG00000000149  0.02052349   0.9146685  0.28189986 6.673622e-04
## 6 ENSMUSG00000000184  0.35073577   0.6770996 -1.16729955 8.219255e-03
##       logFC_3 adj.P.Val_3     logFC_4  adj.P.Val_4     logFC_5 adj.P.Val_5
## 1 -1.43041218  0.12513323 -0.44799417 0.6971683355 -1.37127264   0.2144882
## 2 -0.04408916  0.86413218  0.06845682 0.8203791486 -0.33810245   0.2299135
## 3 -0.25600585  0.44367625 -0.26171585 0.4876463132 -0.27686004   0.4465324
## 4  0.18310579  0.12513323  0.13196140 0.3507159919 -0.04670761   0.7142323
## 5 -0.16954421  0.15824631 -0.05563199 0.7058695991 -0.11004302   0.4169442
## 6  1.08901487  0.07688163  1.62569728 0.0005953455 -0.43347555   0.4956145
##      logFC_6 adj.P.Val_6    logFC_7  adj.P.Val_7
## 1  1.4303047  0.07407546  0.3096065 0.8933199785
## 2 -0.1256368  0.57155365  1.1434082 0.0000402451
## 3 -0.1242456  0.68980497  1.2238353 0.0040319394
## 4 -0.1817538  0.07437834 -0.2542043 0.1603940742
## 5 -0.1142467  0.29658357  0.3911711 0.0184450144
## 6 -1.1343523  0.02214472 -0.9527329 0.3289370539
```

Let’s check out the markers for group 5 for example

```
gr5_markers <- nhood_markers[c("logFC_5", "adj.P.Val_5")]
colnames(gr5_markers) <- c("logFC", "adj.P.Val")

head(gr5_markers[order(gr5_markers$adj.P.Val), ])
```

```
##          logFC    adj.P.Val
## 1064 1.9932313 1.254246e-11
## 51   0.5666959 5.989730e-07
## 1856 0.4715809 5.989730e-07
## 1051 2.0797909 8.964494e-06
## 798  2.5497261 2.095848e-05
## 908  0.3063202 3.140910e-05
```

If you already know you are interested only in the markers for group 2, you might want to test just 8-VS-all using the `subset.groups` parameter:

```
nhood_markers <- findNhoodGroupMarkers(embryo_milo, da_results, subset.row = hvgs,
                                       aggregate.samples = TRUE, sample_col = "sample",
                                       subset.groups = c("5")
                                       )

head(nhood_markers)
```

```
##                      logFC_5  adj.P.Val_5             GeneID
## ENSMUSG00000031297 1.9932313 1.254246e-11 ENSMUSG00000031297
## ENSMUSG00000068923 0.4715809 5.989730e-07 ENSMUSG00000068923
## ENSMUSG00000002006 0.5666959 5.989730e-07 ENSMUSG00000002006
## ENSMUSG00000031155 2.0797909 8.964494e-06 ENSMUSG00000031155
## ENSMUSG00000027478 2.5497261 2.095848e-05 ENSMUSG00000027478
## ENSMUSG00000028807 0.3063202 3.140910e-05 ENSMUSG00000028807
```

You might also want to compare a subset of neighbourhoods between each other. You can specify the neighbourhoods to use for testing by setting the parameter `subset.nhoods`.

For example, you might want to compare just one pair of neighbourhood groups against each other:

```
nhood_markers <- findNhoodGroupMarkers(embryo_milo, da_results, subset.row = hvgs,
                                       subset.nhoods = da_results$NhoodGroup %in% c('5','6'),
                                       aggregate.samples = TRUE, sample_col = "sample")

head(nhood_markers)
```

```
##               GeneID     logFC_5  adj.P.Val_5     logFC_6  adj.P.Val_6
## 1 ENSMUSG00000000031 -2.55759887 6.122844e-08  2.55759887 6.122844e-08
## 2 ENSMUSG00000000078  0.07590159 6.393453e-01 -0.07590159 6.393453e-01
## 3 ENSMUSG00000000088 -0.11447360 5.447348e-01  0.11447360 5.447348e-01
## 4 ENSMUSG00000000125  0.05992260 1.014942e-02 -0.05992260 1.014942e-02
## 5 ENSMUSG00000000149  0.03805574 3.958598e-01 -0.03805574 3.958598e-01
## 6 ENSMUSG00000000184  0.90772395 1.920559e-04 -0.90772395 1.920559e-04
```

or you might use `subset.nhoods` to exclude singleton neighbourhoods, or to subset to the neighbourhoods that show significant DA.

## 5.3 Visualize detected markers

Lets select marker genes for group 10 at FDR 1% and log-fold-Change > 1.

```
ggplot(nhood_markers, aes(logFC_5, -log10(adj.P.Val_5 ))) +
  geom_point(alpha=0.5, size=0.5) +
  geom_hline(yintercept = 3)
```

![](data:image/jpeg;base64...)

```
markers <- nhood_markers$GeneID[nhood_markers$adj.P.Val_5 < 0.01 & nhood_markers$logFC_5 > 0]
```

We can visualize the expression in neighbourhoods using `plotNhoodExpressionGroups`.

```
set.seed(42)
plotNhoodExpressionGroups(embryo_milo, da_results, features=intersect(rownames(embryo_milo), markers[1:10]),
                          subset.nhoods = da_results$NhoodGroup %in% c('6','5'),
                          scale=TRUE,
                          grid.space = "fixed")
```

```
## Warning in plotNhoodExpressionGroups(embryo_milo, da_results, features =
## intersect(rownames(embryo_milo), : Nothing in nhoodExpression(x): computing for
## requested features...
```

![](data:image/jpeg;base64...)

## 5.4 DGE testing *within* a group

In some cases you might want to test for differential expression between cells in different conditions *within* the same neighbourhood group. You can do that using `testDiffExp`:

```
dge_6 <- testDiffExp(embryo_milo, da_results, design = ~ stage, meta.data = data.frame(colData(embryo_milo)),
                     subset.row = rownames(embryo_milo)[1:5], subset.nhoods=da_results$NhoodGroup=="6")

dge_6
```

```
## $`6`
##                          logFC     AveExpr         t     P.Value  adj.P.Val
## ENSMUSG00000025902 -0.01133747 0.008518247 -2.826035 0.004772973 0.02386486
## ENSMUSG00000033845  0.03381836 2.455795130  1.091922 0.275036210 0.68759052
## ENSMUSG00000051951  0.00000000 0.000000000  0.000000 1.000000000 1.00000000
## ENSMUSG00000102343  0.00000000 0.000000000  0.000000 1.000000000 1.00000000
## ENSMUSG00000025900  0.00000000 0.000000000  0.000000 1.000000000 1.00000000
##                             B Nhood.Group
## ENSMUSG00000025902  -7.248125           6
## ENSMUSG00000033845 -10.637408           6
## ENSMUSG00000051951 -11.233708           6
## ENSMUSG00000102343 -11.233708           6
## ENSMUSG00000025900 -11.233708           6
```

**Session Info**

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
##  [1] MouseGastrulationData_1.23.0 SpatialExperiment_1.20.0
##  [3] MouseThymusAgeing_1.17.0     patchwork_1.3.2
##  [5] dplyr_1.1.4                  scran_1.38.0
##  [7] scater_1.38.0                ggplot2_4.0.0
##  [9] scuttle_1.20.0               SingleCellExperiment_1.32.0
## [11] SummarizedExperiment_1.40.0  Biobase_2.70.0
## [13] GenomicRanges_1.62.0         Seqinfo_1.0.0
## [15] IRanges_2.44.0               S4Vectors_0.48.0
## [17] BiocGenerics_0.56.0          generics_0.1.4
## [19] MatrixGenerics_1.22.0        matrixStats_1.5.0
## [21] miloR_2.6.0                  edgeR_4.8.0
## [23] limma_3.66.0                 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3   jsonlite_2.0.0       magrittr_2.0.4
##   [4] ggbeeswarm_0.7.2     magick_2.9.0         farver_2.1.2
##   [7] rmarkdown_2.30       vctrs_0.6.5          memoise_2.0.1
##  [10] tinytex_0.57         htmltools_0.5.8.1    S4Arrays_1.10.0
##  [13] AnnotationHub_4.0.0  curl_7.0.0           BiocNeighbors_2.4.0
##  [16] SparseArray_1.10.0   sass_0.4.10          pracma_2.4.6
##  [19] bslib_0.9.0          httr2_1.2.1          cachem_1.1.0
##  [22] igraph_2.2.1         lifecycle_1.0.4      pkgconfig_2.0.3
##  [25] rsvd_1.0.5           Matrix_1.7-4         R6_2.6.1
##  [28] fastmap_1.2.0        digest_0.6.37        numDeriv_2016.8-1.1
##  [31] AnnotationDbi_1.72.0 dqrng_0.4.1          irlba_2.3.5.1
##  [34] ExperimentHub_3.0.0  RSQLite_2.4.3        beachmat_2.26.0
##  [37] filelock_1.0.3       labeling_0.4.3       httr_1.4.7
##  [40] polyclip_1.10-7      abind_1.4-8          compiler_4.5.1
##  [43] bit64_4.6.0-1        withr_3.0.2          S7_0.2.0
##  [46] BiocParallel_1.44.0  viridis_0.6.5        DBI_1.2.3
##  [49] ggforce_0.5.0        MASS_7.3-65          rappdirs_0.3.3
##  [52] DelayedArray_0.36.0  rjson_0.2.23         bluster_1.20.0
##  [55] gtools_3.9.5         tools_4.5.1          vipor_0.4.7
##  [58] beeswarm_0.4.0       glue_1.8.0           grid_4.5.1
##  [61] cluster_2.1.8.1      gtable_0.3.6         tidyr_1.3.1
##  [64] BiocSingular_1.26.0  tidygraph_1.3.1      ScaledMatrix_1.18.0
##  [67] metapod_1.18.0       XVector_0.50.0       RcppAnnoy_0.0.22
##  [70] ggrepel_0.9.6        BiocVersion_3.22.0   pillar_1.11.1
##  [73] stringr_1.5.2        BumpyMatrix_1.18.0   splines_4.5.1
##  [76] tweenr_2.0.3         BiocFileCache_3.0.0  lattice_0.22-7
##  [79] FNN_1.1.4.1          bit_4.6.0            tidyselect_1.2.1
##  [82] locfit_1.5-9.12      Biostrings_2.78.0    knitr_1.50
##  [85] gridExtra_2.3        bookdown_0.45        xfun_0.53
##  [88] graphlayouts_1.2.2   statmod_1.5.1        stringi_1.8.7
##  [91] yaml_2.3.10          evaluate_1.0.5       codetools_0.2-20
##  [94] ggraph_2.2.2         tibble_3.3.0         BiocManager_1.30.26
##  [97] cli_3.6.5            uwot_0.2.3           jquerylib_0.1.4
## [100] dichromat_2.0-0.1    Rcpp_1.1.0           dbplyr_2.5.1
## [103] png_0.1-8            parallel_4.5.1       blob_1.2.4
## [106] viridisLite_0.4.2    scales_1.4.0         purrr_1.1.0
## [109] crayon_1.5.3         rlang_1.1.6          cowplot_1.2.0
## [112] KEGGREST_1.50.0
```