# CiteFuse: getting started

Yingxin Lin1 and Hani Jieun Kim1,2,3

1School of Mathematics and Statistics, The University of Sydney, Australia
2Charles Perkins Centre, The University of Sydney, Australia
3Computational Systems Biology Group, Children’s Medical Research Institute, Faculty of Medicine and Health, The University of Sydney, Australia

#### 29 October 2025

# 1 Introduction

`CiteFuse` is a computational framework that implements a suite of methods and tools for CITE-seq data from pre-processing through to integrative analytics. This includes doublet detection, network-based modality integration, cell type clustering, differential RNA and protein expression analysis, ADT evaluation, ligand-receptor interaction analysis, and interactive web-based visualisation of the analyses. This vignette demonstrates the usage of `CiteFuse` on a subset data of CITE-seq data from human PBMCs as an example (Mimitou et al., 2019).

First, install `CiteFuse` using `BiocManager`.

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
 install.packages("BiocManager")
}
BiocManager::install("CiteFuse")
```

```
library(CiteFuse)
library(scater)
library(SingleCellExperiment)
library(DT)
```

```
data("CITEseq_example", package = "CiteFuse")
names(CITEseq_example)
#> [1] "RNA" "ADT" "HTO"
lapply(CITEseq_example, dim)
#> $RNA
#> [1] 19521   500
#>
#> $ADT
#> [1]  49 500
#>
#> $HTO
#> [1]   4 500
```

Here, we start from a list of three matrices of unique molecular identifier (UMI), antibody derived tags (ADT) and hashtag oligonucleotide (HTO) count, which have common cell names. There are 500 cells in our subsetted dataset. And characteristically of CITE-seq data, the matrices are matched, meaning that for any given cell we know the expression level of their RNA transcripts (genome-wide) and its corresponding cell surface protein expression. The `preprocessing` function will utilise the three matrices and its common cell names to create a `SingleCellExperiment` object, which stores RNA data in an `assay` and `ADT` and `HTO` data within in the `altExp` slot.

```
sce_citeseq <- preprocessing(CITEseq_example)
sce_citeseq
#> class: SingleCellExperiment
#> dim: 19521 500
#> metadata(0):
#> assays(1): counts
#> rownames(19521): hg19_AL627309.1 hg19_AL669831.5 ... hg19_MT-ND6
#>   hg19_MT-CYB
#> rowData names(0):
#> colnames(500): AAGCCGCGTTGTCTTT GATCGCGGTTATCGGT ... TTGGCAACACTAGTAC
#>   GCTGCGAGTTGTGGCC
#> colData names(0):
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(2): ADT HTO
```

# 2 Detecting both cross- and within-sample doublets using `CiteFuse`

## 2.1 HTO Normalisation and Visualisation

The function `normaliseExprs` is used to scale the alternative expression. Here, we used it to perform log-transformation of the `HTO` count, by setting `transform = "log"`.

```
sce_citeseq <- normaliseExprs(sce = sce_citeseq,
                              altExp_name = "HTO",
                              transform = "log")
```

Then we can perform dimension reduction on the `HTO` count by using `runTSNE` or `runUMAP`, then use `visualiseDim` function to visualise the reduced dimension plot. Our CITE-seq dataset contain data from four samples that were pooled before sequencing. The samples were multiplexed through cell hashing (Stoekius et al., 2018). The four clusters observed on reduced dimension plots equate to the four different samples.

```
sce_citeseq <- scater::runTSNE(sce_citeseq,
                               altexp = "HTO",
                               name = "TSNE_HTO",
                               pca = TRUE)

visualiseDim(sce_citeseq,
             dimNames = "TSNE_HTO") + labs(title = "tSNE (HTO)")
```

![](data:image/png;base64...)

```
sce_citeseq <- scater::runUMAP(sce_citeseq,
                               altexp = "HTO",
                               name = "UMAP_HTO")

visualiseDim(sce_citeseq,
             dimNames = "UMAP_HTO") + labs(title = "UMAP (HTO)")
```

![](data:image/png;base64...)

## 2.2 Doublet identification step 1: cross-sample doublet detection

An important step in single cell data analysis is the removal of doublets. Doublets form as a result of co-encapsulation of cells within a droplet, leading to a hybrid transcriptome from two or more cells. In CiteFuse, we implement a step-wise doublet detection approach to remove doublets. We first identify the cross-sample doublets via the `crossSampleDoublets` function.

```
sce_citeseq <- crossSampleDoublets(sce_citeseq)
#> number of iterations= 20
#> number of iterations= 24
#> number of iterations= 46
#> number of iterations= 50
```

The results of the cross sample doublets are then saved in `colData` as `doubletClassify_between_label` and `doubletClassify_between_class`.

```
table(sce_citeseq$doubletClassify_between_label)
#>
#>                 1                 2                 3                 4
#>               115               121                92               129
#> doublet/multiplet
#>                43
table(sce_citeseq$doubletClassify_between_class)
#>
#>           Singlet doublet/multiplet
#>               457                43
```

We can then highlight the cross-sample doublets in our tSNE plot of HTO count.

```
visualiseDim(sce_citeseq,
             dimNames = "TSNE_HTO",
             colour_by = "doubletClassify_between_label")
```

![](data:image/png;base64...)

Furthermore, `plotHTO` function allows us to plot the pairwise scatter HTO count. Any cells that show co-expression of orthologocal HTOs (red) are considered as doublets.

```
plotHTO(sce_citeseq, 1:4)
```

![](data:image/png;base64...)

## 2.3 Doublet identification step 1: within-sample doublet detection

We then identify the within-sample doublets via the `withinSampleDoublets` function.

```
sce_citeseq <- withinSampleDoublets(sce_citeseq,
                                    minPts = 10)
```

The results of the cross sample doublets are then saved in the `colData` as `doubletClassify_within_label` and `doubletClassify_within_class`.

```
table(sce_citeseq$doubletClassify_within_label)
#>
#>  Doublets(Within)_1  Doublets(Within)_2  Doublets(Within)_3  Doublets(Within)_4
#>                   3                   7                   4                   6
#> NotDoublets(Within)
#>                 480
table(sce_citeseq$doubletClassify_within_class)
#>
#> Doublet Singlet
#>      20     480
```

Again, we can visualise the within-sample doublets in our tSNE plot.

```
visualiseDim(sce_citeseq,
             dimNames = "TSNE_HTO",
             colour_by = "doubletClassify_within_label")
```

![](data:image/png;base64...)

Finally, we can filter out the doublet cells (both within and between batches) for the downstream analysis.

```
sce_citeseq <- sce_citeseq[, sce_citeseq$doubletClassify_within_class == "Singlet" & sce_citeseq$doubletClassify_between_class == "Singlet"]
sce_citeseq
#> class: SingleCellExperiment
#> dim: 19521 437
#> metadata(3): doubletClassify_between_threshold
#>   doubletClassify_between_resultsMat doubletClassify_within_resultsMat
#> assays(1): counts
#> rownames(19521): hg19_AL627309.1 hg19_AL669831.5 ... hg19_MT-ND6
#>   hg19_MT-CYB
#> rowData names(0):
#> colnames(437): GATCGCGGTTATCGGT GGCTGGTAGAGGTTAT ... TTGGCAACACTAGTAC
#>   GCTGCGAGTTGTGGCC
#> colData names(5): doubletClassify_between_label
#>   doubletClassify_between_class nUMI doubletClassify_within_label
#>   doubletClassify_within_class
#> reducedDimNames(2): TSNE_HTO UMAP_HTO
#> mainExpName: NULL
#> altExpNames(2): ADT HTO
```

# 3 Clustering

## 3.1 Performing SNF

The first step of analysis is to integrate the RNA and ADT matrix. We use a popular integration algorithm called similarity network fusion (SNF) to integrate the multiomic data.

```
sce_citeseq <- scater::logNormCounts(sce_citeseq)
sce_citeseq <- normaliseExprs(sce_citeseq, altExp_name = "ADT", transform = "log")
system.time(sce_citeseq <- CiteFuse(sce_citeseq))
#> Calculating affinity matrix
#> Performing SNF
#>    user  system elapsed
#>   3.645   0.068   3.713
```

We now proceed with the fused matrix, which is stored as `SNF_W` in our `sce_citeseq` object.

## 3.2 Performing spectral clustering

CiteFuse implements two different clustering algorithms on the fused matrix, spectral clustering and Louvain clustering. First, we perform spectral clustering with sufficient numbers of `K` and use the eigen values to determine the optimal number of clusters.

```
SNF_W_clust <- spectralClustering(metadata(sce_citeseq)[["SNF_W"]], K = 20)
#> Computing Spectral Clustering
plot(SNF_W_clust$eigen_values)
```

![](data:image/png;base64...)

```
which.max(abs(diff(SNF_W_clust$eigen_values)))
#> [1] 5
```

Using the optimal cluster number defined from the previous step, we can now use the `spectralClutering` function to cluster the single cells by specifying the number of clusters in `K`. The function takes a cell-to-cell similarity matrix as an input. We have already created the fused similarity matrix from `CiteFuse`. Since the `CiteFuse` function creates and stores the similarity matries from ADT and RNA expression, as well the fused matrix, we can use these two to compare the clustering outcomes by data modality.

```
SNF_W_clust <- spectralClustering(metadata(sce_citeseq)[["SNF_W"]], K = 5)
#> Computing Spectral Clustering
sce_citeseq$SNF_W_clust <- as.factor(SNF_W_clust$labels)

SNF_W1_clust <- spectralClustering(metadata(sce_citeseq)[["ADT_W"]], K = 5)
#> Computing Spectral Clustering
sce_citeseq$ADT_clust <- as.factor(SNF_W1_clust$labels)

SNF_W2_clust <- spectralClustering(metadata(sce_citeseq)[["RNA_W"]], K = 5)
#> Computing Spectral Clustering
sce_citeseq$RNA_clust <- as.factor(SNF_W2_clust$labels)
```

## 3.3 Visualisation

The outcome of the clustering can be easily visualised on a reduced dimensions plot by highlighting the points by cluster label.

```
sce_citeseq <- reducedDimSNF(sce_citeseq,
                             method = "tSNE",
                             dimNames = "tSNE_joint")

g1 <- visualiseDim(sce_citeseq, dimNames = "tSNE_joint", colour_by = "SNF_W_clust") +
  labs(title = "tSNE (SNF clustering)")
g2 <- visualiseDim(sce_citeseq, dimNames = "tSNE_joint",  colour_by = "ADT_clust") +
  labs(title = "tSNE (ADT clustering)")
g3 <- visualiseDim(sce_citeseq, dimNames = "tSNE_joint",  colour_by = "RNA_clust") +
  labs(title = "tSNE (RNA clustering)")

library(gridExtra)
grid.arrange(g3, g2, g1, ncol = 2)
```

![](data:image/png;base64...)

The expression of genes and proteins can be visualised by changing the `colour_by` parameter to assess the clusters. As an example, we highlight the plot by the RNA and ADT expression level of CD8.

```
g1 <- visualiseDim(sce_citeseq, dimNames = "tSNE_joint",
                   colour_by = "hg19_CD8A",
                   data_from = "assay",
                   assay_name = "logcounts") +
  labs(title = "tSNE: hg19_CD8A (RNA expression)")
g2 <- visualiseDim(sce_citeseq,dimNames = "tSNE_joint",
                   colour_by = "CD8",
                   data_from = "altExp",
                   altExp_assay_name = "logcounts") +
  labs(title = "tSNE: CD8 (ADT expression)")

grid.arrange(g1, g2, ncol = 2)
```

![](data:image/png;base64...)

## 3.4 Louvain clustering

As well as spectral clustering, CiteFuse can implement Louvain clustering if users wish to use another clustering method. We use the `igraph` package, and any community detection algorithms available in their package can be selected by changing the `method` parameter.

```
SNF_W_louvain <- igraphClustering(sce_citeseq, method = "louvain")
table(SNF_W_louvain)
#> SNF_W_louvain
#>   1   2   3   4   5   6   7
#>  88 138  63  32  51  29  36

sce_citeseq$SNF_W_louvain <- as.factor(SNF_W_louvain)

visualiseDim(sce_citeseq, dimNames = "tSNE_joint", colour_by = "SNF_W_louvain") +
  labs(title = "tSNE (SNF louvain clustering)")
```

![](data:image/png;base64...)

```
visualiseKNN(sce_citeseq, colour_by = "SNF_W_louvain")
```

![](data:image/png;base64...)

# 4 Differential Expression Analysis

## 4.1 Exploration of feature expression

CiteFuse has a wide range of visualisation tools to facilitate exploratory analysis of CITE-seq data. The `visualiseExprs` function is an easy-to-use function to generate boxplots, violinplots, jitter plots, density plots, and pairwise scatter/density plots of genes and proteins expressed in the data. The plots can be grouped by using the cluster labels stored in the `sce_citeseq` object.

```
visualiseExprs(sce_citeseq,
               plot = "boxplot",
               group_by = "SNF_W_louvain",
               feature_subset = c("hg19_CD2", "hg19_CD4", "hg19_CD8A", "hg19_CD19"))
```

![](data:image/png;base64...)

```
visualiseExprs(sce_citeseq,
               plot = "violin",
               group_by = "SNF_W_louvain",
               feature_subset = c("hg19_CD2", "hg19_CD4", "hg19_CD8A", "hg19_CD19"))
```

![](data:image/png;base64...)

```
visualiseExprs(sce_citeseq,
               plot = "jitter",
               group_by = "SNF_W_louvain",
               feature_subset = c("hg19_CD2", "hg19_CD4", "hg19_CD8A", "hg19_CD19"))
```

![](data:image/png;base64...)

```
visualiseExprs(sce_citeseq,
               plot = "density",
               group_by = "SNF_W_louvain",
               feature_subset = c("hg19_CD2", "hg19_CD4", "hg19_CD8A", "hg19_CD19"))
```

![](data:image/png;base64...)

```
visualiseExprs(sce_citeseq,
               altExp_name = "ADT",
               group_by = "SNF_W_louvain",
               plot = "violin", n = 5)
```

![](data:image/png;base64...)

```
visualiseExprs(sce_citeseq, altExp_name = "ADT",
               plot = "jitter",
               group_by = "SNF_W_louvain",
               feature_subset = c("CD2", "CD8", "CD4", "CD19"))
```

![](data:image/png;base64...)

```
visualiseExprs(sce_citeseq, altExp_name = "ADT",
               plot = "density",
               group_by = "SNF_W_louvain",
               feature_subset = c("CD2", "CD8", "CD4", "CD19"))
```

![](data:image/png;base64...)

```
visualiseExprs(sce_citeseq, altExp_name = "ADT",
               plot = "pairwise",
               feature_subset = c("CD4", "CD8"))
#> number of iterations= 14
#> number of iterations= 19
```

![](data:image/png;base64...)

```
visualiseExprs(sce_citeseq, altExp_name = "ADT",
               plot = "pairwise",
               feature_subset = c("CD45RA", "CD4", "CD8"),
               threshold = rep(4, 3))
```

![](data:image/png;base64...)

## 4.2 Perform DE Analysis with Wilcoxon Rank Sum test

CiteFuse also calculates differentially expressed (DE) genes through the `DEgenes` function. The cluster grouping to use must be specified in the `group` parameter. If `altExp_name` is not specified, RNA expression will be used as the default expression matrix.

Results form the DE analysis is stored in `sce_citeseq` as `DE_res_RNA_filter` and `DE_res_ADT_filter` for RNA and ADT expression, respectively.

### 4.2.1 For RNA expression

```
# DE will be performed for RNA if altExp_name = "none"
sce_citeseq <- DEgenes(sce_citeseq,
                       altExp_name = "none",
                       group = sce_citeseq$SNF_W_louvain,
                       return_all = TRUE,
                       exprs_pct = 0.5)

sce_citeseq <- selectDEgenes(sce_citeseq,
                             altExp_name = "none")
datatable(format(do.call(rbind, metadata(sce_citeseq)[["DE_res_RNA_filter"]]),
                 digits = 2))
```

### 4.2.2 For ADT count

```
sce_citeseq <- DEgenes(sce_citeseq,
                       altExp_name = "ADT",
                       group = sce_citeseq$SNF_W_louvain,
                       return_all = TRUE,
                       exprs_pct = 0.5)

sce_citeseq <- selectDEgenes(sce_citeseq,
                             altExp_name = "ADT")
datatable(format(do.call(rbind, metadata(sce_citeseq)[["DE_res_ADT_filter"]]),
                 digits = 2))
```

## 4.3 Visualising DE Results

The DE genes can be visualised with the `DEbubblePlot` and `DEcomparisonPlot`. In each case, the gene names must first be extracted from the DE result objects.

### 4.3.1 circlepackPlot

The `circlepackPlot` takes a list of all DE genes from RNA and ADT DE analysis and will plot only the top most significant DE genes to plot.

```
rna_DEgenes <- metadata(sce_citeseq)[["DE_res_RNA_filter"]]
adt_DEgenes <- metadata(sce_citeseq)[["DE_res_ADT_filter"]]

rna_DEgenes <- lapply(rna_DEgenes, function(x){
  x$name <- gsub("hg19_", "", x$name)
  x})
DEbubblePlot(list(RNA = rna_DEgenes, ADT = adt_DEgenes))
```

![](data:image/png;base64...)

### 4.3.2 DEcomparisonPlot

For the `DEcomparisonPlot`, as well as a list containing the DE genes for RNA and ADT, a `feature_list` specifying the genes and proteins of interest is required.

```
rna_list <- c("hg19_CD4",
              "hg19_CD8A",
              "hg19_HLA-DRB1",
              "hg19_ITGAX",
              "hg19_NCAM1",
              "hg19_CD27",
              "hg19_CD19")

adt_list <- c("CD4", "CD8", "MHCII (HLA-DR)", "CD11c", "CD56", "CD27", "CD19")

rna_DEgenes_all <- metadata(sce_citeseq)[["DE_res_RNA"]]
adt_DEgenes_all <- metadata(sce_citeseq)[["DE_res_ADT"]]

feature_list <- list(RNA = rna_list, ADT = adt_list)
de_list <- list(RNA = rna_DEgenes_all, ADT = adt_DEgenes_all)

DEcomparisonPlot(de_list = de_list,
                 feature_list = feature_list)
```

![](data:image/png;base64...)

# 5 ADT Importance Evaluation

An important evaluation in CITE-seq data analysis is to assess the quality of each ADT and to evaluate the contribution of ADTs towards clustering outcome. CiteFuse calculates the relative importance of ADT towards clustering outcome by using a random forest model. The higher the score of an ADT, the greater its importance towards the final clustering outcome.

```
set.seed(2020)
sce_citeseq <- importanceADT(sce_citeseq,
                             group = sce_citeseq$SNF_W_louvain,
                             subsample = TRUE)

visImportance(sce_citeseq, plot = "boxplot")
```

![](data:image/png;base64...)

```
visImportance(sce_citeseq, plot = "heatmap")
```

![](data:image/png;base64...)

```
sort(metadata(sce_citeseq)[["importanceADT"]], decreasing = TRUE)[1:20]
#>              CD27               CD8               CD4              CD28
#>         39.047401         35.192218         33.018168         12.577467
#>               CD5      PECAM (CD31)               CD7             CD11b
#>         12.416952         12.228626         11.503414         10.960520
#> IL7Ralpha (CD127)    MHCII (HLA-DR)               CD2              CD44
#>         10.472265          9.079666          8.902120          8.156478
#>      CD366 (tim3)         HLA-A,B,C             CD11c               CD3
#>          6.046384          5.556082          5.392126          4.613563
#>            CD45RA              CD69      PD-1 (CD279)              CD19
#>          4.106313          3.770635          3.728414          3.695720
```

The importance scores can be visualised in a boxplot and heatmap. Our evaluation of ADT importance show that unsurprisingly CD4 and CD8 are the top two discriminating proteins in PBMCs.

Let us try clustering with only ADTs with a score greater than 5.

```
subset_adt <- names(which(metadata(sce_citeseq)[["importanceADT"]] > 5))
subset_adt
#>  [1] "CD11b"             "CD11c"             "CD2"
#>  [4] "CD27"              "CD28"              "CD366 (tim3)"
#>  [7] "CD4"               "CD44"              "CD5"
#> [10] "CD7"               "CD8"               "HLA-A,B,C"
#> [13] "IL7Ralpha (CD127)" "MHCII (HLA-DR)"    "PECAM (CD31)"

system.time(sce_citeseq <- CiteFuse(sce_citeseq,
                                    ADT_subset = subset_adt,
                                    metadata_names = c("W_SNF_adtSubset1",
                                                       "W_ADT_adtSubset1",
                                                       "W_RNA")))
#> Calculating affinity matrix
#> Performing SNF
#>    user  system elapsed
#>   3.599   0.014   3.613

SNF_W_clust_adtSubset1 <- spectralClustering(metadata(sce_citeseq)[["W_SNF_adtSubset1"]], K = 5)
#> Computing Spectral Clustering
sce_citeseq$SNF_W_clust_adtSubset1 <- as.factor(SNF_W_clust_adtSubset1$labels)

library(mclust)
adjustedRandIndex(sce_citeseq$SNF_W_clust_adtSubset1, sce_citeseq$SNF_W_clust)
#> [1] 0.8646855
```

When we compare between the two clustering outcomes, we find that the adjusted rand index is approximately 0.93, where a value of 1 denotes complete concordance.

# 6 Gene - ADT network

The `geneADTnetwork` function plots an interaction network between genes identified from the DE analysis. The nodes denote proteins and RNA whilst the edges denote positive and negative correlation in expression.

```
RNA_feature_subset <- unique(as.character(unlist(lapply(rna_DEgenes_all, "[[", "name"))))
ADT_feature_subset <- unique(as.character(unlist(lapply(adt_DEgenes_all, "[[", "name"))))

geneADTnetwork(sce_citeseq,
               RNA_feature_subset = RNA_feature_subset,
               ADT_feature_subset = ADT_feature_subset,
               cor_method = "pearson",
               network_layout = igraph::layout_with_fr)
```

![](data:image/png;base64...)

```
#> IGRAPH fed3cf2 UN-B 72 134 --
#> + attr: name (v/c), label (v/c), class (v/c), type (v/l), shape (v/c),
#> | color (v/c), size (v/n), label.cex (v/n), label.color (v/c), value
#> | (e/n), color (e/c), weights (e/n)
#> + edges from fed3cf2 (vertex names):
#>  [1] RNA_hg19_CD8A --ADT_CD4  RNA_hg19_CCL5 --ADT_CD4  RNA_hg19_GNLY --ADT_CD4
#>  [4] RNA_hg19_CST7 --ADT_CD4  RNA_hg19_KLRD1--ADT_CD4  RNA_hg19_NKG7 --ADT_CD4
#>  [7] RNA_hg19_GZMB --ADT_CD4  RNA_hg19_CTSW --ADT_CD4  RNA_hg19_LTB  --ADT_CD27
#> [10] RNA_hg19_TCF7 --ADT_CD27 RNA_hg19_RPL32--ADT_CD27 RNA_hg19_IL7R --ADT_CD27
#> [13] RNA_hg19_RPL13--ADT_CD27 RNA_hg19_RPL37--ADT_CD27 RNA_hg19_RPS8 --ADT_CD27
#> [16] RNA_hg19_RPL11--ADT_CD27 RNA_hg19_CD27 --ADT_CD27 RNA_hg19_RPS12--ADT_CD27
#> + ... omitted several edges
```

# 7 RNA Ligand - ADT Receptor Analysis

With the advent of CITE-seq, we can now predict ligand-receptor interactions by using cell surface protein expression. CiteFuse implements a `ligandReceptorTest` to find ligand receptor interactions between sender and receiver cells. Importantly, the ADT count is used to predict receptor expression within receiver cells. Note that the setting `altExp_name = "RNA"` would enable users to predict ligand-receptor interaction from RNA expression only.

```
data("lr_pair_subset", package = "CiteFuse")
head(lr_pair_subset)
#>      [,1]          [,2]
#> [1,] "hg19_IL17RA" "CD45"
#> [2,] "hg19_FAS"    "CD11b"
#> [3,] "hg19_GZMK"   "CD62L"
#> [4,] "hg19_CD40LG" "CD11b"
#> [5,] "hg19_FLT3LG" "CD62L"
#> [6,] "hg19_GZMA"   "CD19"

sce_citeseq <- normaliseExprs(sce = sce_citeseq,
                              altExp_name = "ADT",
                              transform = "zi_minMax")

sce_citeseq <- normaliseExprs(sce = sce_citeseq,
                              altExp_name = "none",
                              exprs_value = "logcounts",
                              transform = "minMax")

sce_citeseq <- ligandReceptorTest(sce = sce_citeseq,
                                  ligandReceptor_list = lr_pair_subset,
                                  cluster = sce_citeseq$SNF_W_louvain,
                                  RNA_exprs_value = "minMax",
                                  use_alt_exp = TRUE,
                                  altExp_name = "ADT",
                                  altExp_exprs_value = "zi_minMax",
                                  num_permute = 1000)
#> 100 ......200 ......300 ......400 ......500 ......600 ......700 ......800 ......900 ......1000 ......
```

```
visLigandReceptor(sce_citeseq,
                  type = "pval_heatmap",
                  receptor_type = "ADT")
```

![](data:image/png;base64...)

```
visLigandReceptor(sce_citeseq,
                  type = "pval_dotplot",
                  receptor_type = "ADT")
```

![](data:image/png;base64...)

```
visLigandReceptor(sce_citeseq,
                  type = "group_network",
                  receptor_type = "ADT")
```

![](data:image/png;base64...)

```
visLigandReceptor(sce_citeseq,
                  type = "group_heatmap",
                  receptor_type = "ADT")
```

![](data:image/png;base64...)

```
visLigandReceptor(sce_citeseq,
                  type = "lr_network",
                  receptor_type = "ADT")
```

![](data:image/png;base64...)

# 8 Between-sample analysis

Lastly, we will jointly analyse the current PBMC CITE-seq data, taken from healthy human donors, and another subset of CITE-seq data from patients with cutaneous T-cell lymphoma (CTCL), again from Mimitou et al. (2019). The data `sce_ctcl_subset` provided in our `CiteFuse` package already contains the clustering information.

```
data("sce_ctcl_subset", package = "CiteFuse")
```

To visualise and compare gene or protein expression data, we can use `visualiseExprsList` function.

```
visualiseExprsList(sce_list = list(control = sce_citeseq,
                                   ctcl = sce_ctcl_subset),
                   plot = "boxplot",
                   altExp_name = "none",
                   exprs_value = "logcounts",
                   feature_subset = c("hg19_S100A10", "hg19_CD8A"),
                   group_by = c("SNF_W_louvain", "SNF_W_louvain"))
```

![](data:image/png;base64...)

```
visualiseExprsList(sce_list = list(control = sce_citeseq,
                                   ctcl = sce_ctcl_subset),
                   plot = "boxplot",
                   altExp_name = "ADT",
                   feature_subset = c("CD19", "CD8"),
                   group_by = c("SNF_W_louvain", "SNF_W_louvain"))
```

![](data:image/png;base64...)

We can then perform differential expression analysis of the RNA expression level across the two clusters that have high CD19 expression in ADT.

```
de_res <- DEgenesCross(sce_list = list(control = sce_citeseq,
                                       ctcl = sce_ctcl_subset),
                       colData_name = c("SNF_W_louvain", "SNF_W_louvain"),
                       group_to_test = c("2", "6"))
de_res_filter <- selectDEgenes(de_res = de_res)
de_res_filter
#> $control
#>             stats.W         pval     p.adjust meanExprs.1 meanExprs.2
#> hg19_GNLY      28.0 6.121764e-23 6.121764e-23  0.07220401    4.583998
#> hg19_CST7     151.5 4.216822e-21 4.216822e-21  0.22512314    2.633825
#> hg19_NKG7     166.0 8.253545e-21 8.253545e-21  0.51066894    3.816459
#> hg19_GZMH     301.0 1.762877e-19 1.762877e-19  0.00000000    1.973423
#> hg19_GZMB     497.0 6.098286e-17 6.098286e-17  0.11667246    2.002400
#> hg19_CCL5     476.0 9.136098e-17 9.136098e-17  1.04348029    3.772632
#> hg19_FGFBP2   570.0 2.424321e-16 2.424321e-16  0.03101677    1.654845
#> hg19_KLRD1    598.0 7.209043e-16 7.209043e-16  0.09327555    1.557201
#> hg19_EFHD2    794.0 4.350012e-14 4.350012e-14  0.02064028    1.211050
#> hg19_PRF1     802.5 7.826681e-14 7.826681e-14  0.06473009    1.464342
#>              meanPct.1 meanPct.2 meanDiff   pctDiff        name   group
#> hg19_GNLY   0.02325581 0.9927536 4.511794 0.9694978   hg19_GNLY control
#> hg19_CST7   0.13953488 0.9927536 2.408702 0.8532187   hg19_CST7 control
#> hg19_NKG7   0.30232558 1.0000000 3.305790 0.6976744   hg19_NKG7 control
#> hg19_GZMH   0.00000000 0.8985507 1.973423 0.8985507   hg19_GZMH control
#> hg19_GZMB   0.06976744 0.8768116 1.885728 0.8070442   hg19_GZMB control
#> hg19_CCL5   0.37209302 1.0000000 2.729152 0.6279070   hg19_CCL5 control
#> hg19_FGFBP2 0.02325581 0.8188406 1.623828 0.7955848 hg19_FGFBP2 control
#> hg19_KLRD1  0.09302326 0.8260870 1.463925 0.7330637  hg19_KLRD1 control
#> hg19_EFHD2  0.02325581 0.7391304 1.190410 0.7158746  hg19_EFHD2 control
#> hg19_PRF1   0.04651163 0.7608696 1.399612 0.7143579   hg19_PRF1 control
#>
#> $ctcl
#>               stats.W         pval     p.adjust meanExprs.1 meanExprs.2
#> hg19_LTB        370.0 4.560215e-28 4.560215e-28  0.10418197    1.978730
#> hg19_RPS26        0.0 4.545638e-23 4.545638e-23  1.62945133    5.072471
#> hg19_IL7R       751.0 3.762479e-21 3.762479e-21  0.15858976    1.651591
#> hg19_SELL      1012.5 2.370367e-20 2.370367e-20  0.06551529    1.152572
#> hg19_LEPROTL1   701.0 1.394669e-18 1.394669e-18  0.23646395    1.300745
#> hg19_EEF1B2     513.5 2.786431e-16 2.786431e-16  1.71154056    3.043623
#> hg19_HBB       1725.0 1.596238e-15 1.596238e-15  0.00000000    0.431026
#> hg19_NOSIP     1039.0 1.686441e-14 1.686441e-14  0.19996257    1.157235
#> hg19_FOS       1286.0 9.816510e-14 9.816510e-14  0.14817914    1.125337
#> hg19_NPM1       943.0 1.210003e-11 1.210003e-11  1.17905161    2.202268
#>                meanPct.1 meanPct.2  meanDiff   pctDiff          name group
#> hg19_LTB      0.07971014 0.9069767 1.8745482 0.8272666      hg19_LTB  ctcl
#> hg19_RPS26    0.89130435 1.0000000 3.4430192 0.1086957    hg19_RPS26  ctcl
#> hg19_IL7R     0.10144928 0.8139535 1.4930007 0.7125042     hg19_IL7R  ctcl
#> hg19_SELL     0.05072464 0.6976744 1.0870562 0.6469498     hg19_SELL  ctcl
#> hg19_LEPROTL1 0.18840580 0.9069767 1.0642815 0.7185709 hg19_LEPROTL1  ctcl
#> hg19_EEF1B2   0.86231884 0.9767442 1.3320828 0.1144253   hg19_EEF1B2  ctcl
#> hg19_HBB      0.00000000 0.4186047 0.4310260 0.4186047      hg19_HBB  ctcl
#> hg19_NOSIP    0.19565217 0.7674419 0.9572728 0.5717897    hg19_NOSIP  ctcl
#> hg19_FOS      0.11594203 0.6511628 0.9771583 0.5352208      hg19_FOS  ctcl
#> hg19_NPM1     0.73188406 0.9534884 1.0232164 0.2216043     hg19_NPM1  ctcl
```

# 9 Read data from 10X Genomics

Readers unfamiliar with the workflow of converting a count matrix into a `SingleCellExperiment` object may use the `readFrom10X` function to convert count matrix from a 10X experiment into an object that can be used for all functions in CiteFuse.

```
tmpdir <- tempdir()
download.file("http://cf.10xgenomics.com/samples/cell-exp/3.1.0/connect_5k_pbmc_NGSC3_ch1/connect_5k_pbmc_NGSC3_ch1_filtered_feature_bc_matrix.tar.gz", file.path(tmpdir, "/5k_pbmc_NGSC3_ch1_filtered_feature_bc_matrix.tar.gz"))
untar(file.path(tmpdir, "5k_pbmc_NGSC3_ch1_filtered_feature_bc_matrix.tar.gz"),
      exdir = tmpdir)
sce_citeseq_10X <- readFrom10X(file.path(tmpdir, "filtered_feature_bc_matrix/"))
sce_citeseq_10X
```

# 10 SessionInfo

```
sessionInfo()
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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] mclust_6.1.1                gridExtra_2.3
#>  [3] DT_0.34.0                   scater_1.38.0
#>  [5] ggplot2_4.0.0               scuttle_1.20.0
#>  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [9] Biobase_2.70.0              GenomicRanges_1.62.0
#> [11] Seqinfo_1.0.0               IRanges_2.44.0
#> [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [15] generics_0.1.4              MatrixGenerics_1.22.0
#> [17] matrixStats_1.5.0           CiteFuse_1.22.0
#> [19] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] rlang_1.1.6          magrittr_2.0.4       ggridges_0.5.7
#>   [4] compiler_4.5.1       vctrs_0.6.5          reshape2_1.4.4
#>   [7] stringr_1.5.2        pkgconfig_2.0.3      fastmap_1.2.0
#>  [10] magick_2.9.0         XVector_0.50.0       labeling_0.4.3
#>  [13] ggraph_2.2.2         rmarkdown_2.30       ggbeeswarm_0.7.2
#>  [16] tinytex_0.57         purrr_1.1.0          bluster_1.20.0
#>  [19] xfun_0.53            beachmat_2.26.0      randomForest_4.7-1.2
#>  [22] cachem_1.1.0         jsonlite_2.0.0       rhdf5filters_1.22.0
#>  [25] DelayedArray_0.36.0  Rhdf5lib_1.32.0      BiocParallel_1.44.0
#>  [28] tweenr_2.0.3         cluster_2.1.8.1      irlba_2.3.5.1
#>  [31] parallel_4.5.1       R6_2.6.1             bslib_0.9.0
#>  [34] stringi_1.8.7        RColorBrewer_1.1-3   limma_3.66.0
#>  [37] compositions_2.0-9   jquerylib_0.1.4      Rcpp_1.1.0
#>  [40] bookdown_0.45        knitr_1.50           mixtools_2.0.0.1
#>  [43] FNN_1.1.4.1          Matrix_1.7-4         splines_4.5.1
#>  [46] igraph_2.2.1         tidyselect_1.2.1     dichromat_2.0-0.1
#>  [49] abind_1.4-8          yaml_2.3.10          viridis_0.6.5
#>  [52] codetools_0.2-20     lattice_0.22-7       tibble_3.3.0
#>  [55] plyr_1.8.9           withr_3.0.2          S7_0.2.0
#>  [58] evaluate_1.0.5       Rtsne_0.17           survival_3.8-3
#>  [61] bayesm_3.1-6         polyclip_1.10-7      kernlab_0.9-33
#>  [64] pillar_1.11.1        BiocManager_1.30.26  tensorA_0.36.2.1
#>  [67] plotly_4.11.0        dbscan_1.2.3         scales_1.4.0
#>  [70] glue_1.8.0           metapod_1.18.0       pheatmap_1.0.13
#>  [73] lazyeval_0.2.2       tools_4.5.1          BiocNeighbors_2.4.0
#>  [76] robustbase_0.99-6    data.table_1.17.8    ScaledMatrix_1.18.0
#>  [79] locfit_1.5-9.12      scran_1.38.0         graphlayouts_1.2.2
#>  [82] tidygraph_1.3.1      cowplot_1.2.0        rhdf5_2.54.0
#>  [85] grid_4.5.1           tidyr_1.3.1          crosstalk_1.2.2
#>  [88] edgeR_4.8.0          nlme_3.1-168         beeswarm_0.4.0
#>  [91] BiocSingular_1.26.0  ggforce_0.5.0        vipor_0.4.7
#>  [94] rsvd_1.0.5           cli_3.6.5            segmented_2.1-4
#>  [97] S4Arrays_1.10.0      viridisLite_0.4.2    dplyr_1.1.4
#> [100] uwot_0.2.3           gtable_0.3.6         DEoptimR_1.1-4
#> [103] sass_0.4.10          digest_0.6.37        dqrng_0.4.1
#> [106] SparseArray_1.10.0   ggrepel_0.9.6        htmlwidgets_1.6.4
#> [109] farver_2.1.2         memoise_2.0.1        htmltools_0.5.8.1
#> [112] lifecycle_1.0.4      httr_1.4.7           statmod_1.5.1
#> [115] MASS_7.3-65
```