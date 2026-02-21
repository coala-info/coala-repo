# Examples and use cases

Lukas M. Weber1,2 and Charlotte Soneson3,4

1Institute of Molecular Life Sciences, University of Zurich, Zurich, Switzerland
2SIB Swiss Institute of Bioinformatics, Zurich, Switzerland
3Friedrich Miescher Institute for Biomedical Research, Basel, Switzerland
4SIB Swiss Institute of Bioinformatics, Basel, Switzerland

#### 4 November 2025

#### Package

HDCytoData 1.30.0

# Contents

* [1 Examples and use cases](#examples-and-use-cases)
* [2 Dimension reduction](#dimension-reduction)
* [3 Clustering](#clustering)
* [4 Differential analysis](#differential-analysis)
  + [4.1 Differential abundance (DA)](#differential-abundance-da)
  + [4.2 Differential states (DS)](#differential-states-ds)

# 1 Examples and use cases

This vignette demonstrates several examples and use cases for the datasets in the `HDCytoData` package.

# 2 Dimension reduction

Using the clustering datasets, we can generate dimension reduction plots with colors indicating the ground truth cell population labels. This provides a visual representation of the cell population structure in these datasets, which is useful during exploratory data analysis and for representing the output of clustering or other downstream analysis algorithms.

Below, we compare three different dimension reduction algorithms (principal component analysis [PCA], t-distributed stochastic neighbor embedding [tSNE], and uniform manifold approximation and projection [UMAP]), for one of the datasets (`Levine_32dim`). This dataset contains ground truth cell population labels for 14 immune cell populations.

```
suppressPackageStartupMessages(library(HDCytoData))
suppressPackageStartupMessages(library(SummarizedExperiment))
suppressPackageStartupMessages(library(Rtsne))
suppressPackageStartupMessages(library(umap))
suppressPackageStartupMessages(library(ggplot2))
```

```
# ---------
# Load data
# ---------

d_SE <- Levine_32dim_SE()
```

```
## see ?HDCytoData and browseVignettes('HDCytoData') for documentation
```

```
## loading from cache
```

```
# -------------
# Preprocessing
# -------------

# select 'cell type' marker columns for defining clusters
d_sub <- assay(d_SE[, colData(d_SE)$marker_class == "type"])

# extract cell population labels
population <- rowData(d_SE)$population_id

dim(d_sub)
```

```
## [1] 265627     32
```

```
stopifnot(nrow(d_sub) == length(population))

# transform data using asinh with cofactor 5
cofactor <- 5
d_sub <- asinh(d_sub / cofactor)

summary(d_sub)
```

```
##      CD45RA             CD133               CD19               CD22
##  Min.   :-0.05731   Min.   :-0.05808   Min.   :-0.05809   Min.   :-0.05734
##  1st Qu.: 0.20463   1st Qu.:-0.02293   1st Qu.:-0.01884   1st Qu.:-0.02069
##  Median : 0.54939   Median : 0.02535   Median : 0.07521   Median : 0.05879
##  Mean   : 0.68813   Mean   : 0.14596   Mean   : 0.50930   Mean   : 0.39732
##  3rd Qu.: 1.03120   3rd Qu.: 0.22430   3rd Qu.: 0.54839   3rd Qu.: 0.38648
##  Max.   : 6.69120   Max.   : 5.52749   Max.   : 4.99008   Max.   : 5.16048
##      CD11b                 CD4                CD8                CD34
##  Min.   :-0.0582357   Min.   :-0.05775   Min.   :-0.05800   Min.   :-0.05801
##  1st Qu.:-0.0002944   1st Qu.:-0.01259   1st Qu.:-0.01732   1st Qu.:-0.01117
##  Median : 0.2579234   Median : 0.13122   Median : 0.07363   Median : 0.11071
##  Mean   : 0.7103186   Mean   : 0.36760   Mean   : 0.56522   Mean   : 0.33989
##  3rd Qu.: 0.9235173   3rd Qu.: 0.57812   3rd Qu.: 0.48642   3rd Qu.: 0.39281
##  Max.   : 5.2607892   Max.   : 6.58176   Max.   : 4.69369   Max.   : 5.14800
##       Flt3                CD20              CXCR4             CD235ab
##  Min.   :-0.057884   Min.   :-0.05813   Min.   :-0.05704   Min.   :-0.05761
##  1st Qu.:-0.007793   1st Qu.:-0.02207   1st Qu.: 0.25291   1st Qu.: 0.23100
##  Median : 0.110317   Median : 0.03382   Median : 0.66539   Median : 0.54043
##  Mean   : 0.229768   Mean   : 0.38441   Mean   : 0.79247   Mean   : 0.63189
##  3rd Qu.: 0.336117   3rd Qu.: 0.32551   3rd Qu.: 1.20168   3rd Qu.: 0.92358
##  Max.   : 7.117323   Max.   : 6.05141   Max.   : 5.69667   Max.   : 6.64670
##       CD45           CD123              CD321               CD14
##  Min.   :2.040   Min.   :-0.05800   Min.   :-0.05355   Min.   :-0.057954
##  1st Qu.:5.116   1st Qu.:-0.01162   1st Qu.: 1.32346   1st Qu.:-0.026326
##  Median :5.645   Median : 0.09602   Median : 1.90479   Median :-0.005379
##  Mean   :5.408   Mean   : 0.37241   Mean   : 1.93542   Mean   : 0.077030
##  3rd Qu.:5.939   3rd Qu.: 0.41311   3rd Qu.: 2.51781   3rd Qu.: 0.089789
##  Max.   :7.238   Max.   : 6.64063   Max.   : 6.86739   Max.   : 5.006121
##       CD33               CD47              CD11c                CD7
##  Min.   :-0.05808   Min.   :-0.05509   Min.   :-0.058053   Min.   :-0.05816
##  1st Qu.:-0.01813   1st Qu.: 2.08788   1st Qu.:-0.002711   1st Qu.:-0.01567
##  Median : 0.06106   Median : 2.71442   Median : 0.212063   Median : 0.13002
##  Mean   : 0.30792   Mean   : 2.65608   Mean   : 0.703504   Mean   : 0.81384
##  3rd Qu.: 0.34147   3rd Qu.: 3.27654   3rd Qu.: 0.861448   3rd Qu.: 1.37083
##  Max.   : 5.61247   Max.   : 6.40249   Max.   : 6.520939   Max.   : 6.31922
##       CD15               CD16               CD44              CD38
##  Min.   :-0.05808   Min.   :-0.05778   Min.   :0.02606   Min.   :-0.05719
##  1st Qu.:-0.01502   1st Qu.:-0.02255   1st Qu.:3.12712   1st Qu.: 0.40198
##  Median : 0.09355   Median : 0.01424   Median :3.87967   Median : 1.02032
##  Mean   : 0.23136   Mean   : 0.16123   Mean   :3.76018   Mean   : 1.47781
##  3rd Qu.: 0.38331   3rd Qu.: 0.16077   3rd Qu.:4.47392   3rd Qu.: 2.19146
##  Max.   : 1.53415   Max.   : 5.33830   Max.   :7.40456   Max.   : 7.29309
##       CD13               CD3                CD61              CD117
##  Min.   :-0.05773   Min.   :-0.05824   Min.   :-0.05764   Min.   :-0.0576679
##  1st Qu.: 0.02110   1st Qu.: 0.08495   1st Qu.:-0.01285   1st Qu.:-0.0239568
##  Median : 0.18706   Median : 0.60376   Median : 0.09569   Median :-0.0004102
##  Mean   : 0.36856   Mean   : 2.16576   Mean   : 0.34446   Mean   : 0.1311986
##  3rd Qu.: 0.53550   3rd Qu.: 4.66522   3rd Qu.: 0.41579   3rd Qu.: 0.1547364
##  Max.   : 6.98119   Max.   : 6.74836   Max.   : 7.74850   Max.   : 5.5021247
##      CD49d              HLA-DR              CD64               CD41
##  Min.   :-0.05806   Min.   :-0.05797   Min.   :-0.05820   Min.   :-0.05824
##  1st Qu.: 0.28301   1st Qu.: 0.05771   1st Qu.:-0.01058   1st Qu.:-0.02017
##  Median : 0.67721   Median : 0.61133   Median : 0.12249   Median : 0.05223
##  Mean   : 0.79494   Mean   : 1.52181   Mean   : 0.55151   Mean   : 0.26175
##  3rd Qu.: 1.19079   3rd Qu.: 2.88824   3rd Qu.: 0.60413   3rd Qu.: 0.30559
##  Max.   : 5.15344   Max.   : 7.05251   Max.   : 4.51784   Max.   : 7.71829
```

```
# subsample cells for faster runtimes in vignette
n <- 2000

set.seed(123)
ix <- sample(seq_len(nrow(d_sub)), n)

d_sub <- d_sub[ix, ]
population <- population[ix]

dim(d_sub)
```

```
## [1] 2000   32
```

```
stopifnot(nrow(d_sub) == length(population))

# remove any near-duplicate rows (required by Rtsne)
dups <- duplicated(d_sub)
d_sub <- d_sub[!dups, ]
population <- population[!dups]

dim(d_sub)
```

```
## [1] 1998   32
```

```
stopifnot(nrow(d_sub) == length(population))
```

```
# ------------------------
# Dimension reduction: PCA
# ------------------------

n_dims <- 2

# run PCA
# (note: no scaling, since asinh-transformed dimensions are already comparable)
out_PCA <- prcomp(d_sub, center = TRUE, scale. = FALSE)
dims_PCA <- out_PCA$x[, seq_len(n_dims)]
colnames(dims_PCA) <- c("PC_1", "PC_2")
head(dims_PCA)
```

```
##           PC_1       PC_2
## [1,]  1.450702  3.1573053
## [2,]  2.453109 -0.9381139
## [3,] -2.705226  0.7090551
## [4,]  2.718284 -2.2801305
## [5,] -2.714230 -0.1954170
## [6,] -3.003650 -0.1938087
```

```
stopifnot(nrow(dims_PCA) == length(population))

colnames(dims_PCA) <- c("dimension_x", "dimension_y")
dims_PCA <- cbind(as.data.frame(dims_PCA), population, type = "PCA")

head(dims_PCA)
```

```
##   dimension_x dimension_y population type
## 1    1.450702   3.1573053 unassigned  PCA
## 2    2.453109  -0.9381139 unassigned  PCA
## 3   -2.705226   0.7090551 unassigned  PCA
## 4    2.718284  -2.2801305 unassigned  PCA
## 5   -2.714230  -0.1954170 unassigned  PCA
## 6   -3.003650  -0.1938087 unassigned  PCA
```

```
str(dims_PCA)
```

```
## 'data.frame':    1998 obs. of  4 variables:
##  $ dimension_x: num  1.45 2.45 -2.71 2.72 -2.71 ...
##  $ dimension_y: num  3.157 -0.938 0.709 -2.28 -0.195 ...
##  $ population : Factor w/ 15 levels "Basophils","CD16-_NK_cells",..: 15 15 15 15 15 15 15 9 10 10 ...
##  $ type       : chr  "PCA" "PCA" "PCA" "PCA" ...
```

```
# generate plot
d_plot <- dims_PCA
str(d_plot)
```

```
## 'data.frame':    1998 obs. of  4 variables:
##  $ dimension_x: num  1.45 2.45 -2.71 2.72 -2.71 ...
##  $ dimension_y: num  3.157 -0.938 0.709 -2.28 -0.195 ...
##  $ population : Factor w/ 15 levels "Basophils","CD16-_NK_cells",..: 15 15 15 15 15 15 15 9 10 10 ...
##  $ type       : chr  "PCA" "PCA" "PCA" "PCA" ...
```

```
colors <- c(rainbow(14), "gray75")

ggplot(d_plot, aes(x = dimension_x, y = dimension_y, color = population)) +
  facet_wrap(~ type, scales = "free") +
  geom_point(size = 0.7, alpha = 0.5) +
  scale_color_manual(values = colors) +
  labs(x = "dimension x", y = "dimension y") +
  theme_bw() +
  theme(aspect.ratio = 1,
        legend.key.height = unit(4, "mm"))
```

![](data:image/png;base64...)

```
# -------------------------
# Dimension reduction: tSNE
# -------------------------

# run Rtsne
set.seed(123)
out_Rtsne <- Rtsne(as.matrix(d_sub), dims = n_dims)
dims_Rtsne <- out_Rtsne$Y
colnames(dims_Rtsne) <- c("tSNE_1", "tSNE_2")
head(dims_Rtsne)
```

```
##          tSNE_1     tSNE_2
## [1,]  21.799109  -9.736767
## [2,]  -7.836659  27.059184
## [3,]  -3.133309 -21.538688
## [4,]  -2.389187  21.983433
## [5,] -18.860111 -13.411392
## [6,]  -7.068444 -13.667141
```

```
stopifnot(nrow(dims_Rtsne) == length(population))

colnames(dims_Rtsne) <- c("dimension_x", "dimension_y")
dims_Rtsne <- cbind(as.data.frame(dims_Rtsne), population, type = "tSNE")

head(dims_Rtsne)
```

```
##   dimension_x dimension_y population type
## 1   21.799109   -9.736767 unassigned tSNE
## 2   -7.836659   27.059184 unassigned tSNE
## 3   -3.133309  -21.538688 unassigned tSNE
## 4   -2.389187   21.983433 unassigned tSNE
## 5  -18.860111  -13.411392 unassigned tSNE
## 6   -7.068444  -13.667141 unassigned tSNE
```

```
str(dims_Rtsne)
```

```
## 'data.frame':    1998 obs. of  4 variables:
##  $ dimension_x: num  21.8 -7.84 -3.13 -2.39 -18.86 ...
##  $ dimension_y: num  -9.74 27.06 -21.54 21.98 -13.41 ...
##  $ population : Factor w/ 15 levels "Basophils","CD16-_NK_cells",..: 15 15 15 15 15 15 15 9 10 10 ...
##  $ type       : chr  "tSNE" "tSNE" "tSNE" "tSNE" ...
```

```
# generate plot
d_plot <- dims_Rtsne

ggplot(d_plot, aes(x = dimension_x, y = dimension_y, color = population)) +
  facet_wrap(~ type, scales = "free") +
  geom_point(size = 0.7, alpha = 0.5) +
  scale_color_manual(values = colors) +
  labs(x = "dimension x", y = "dimension y") +
  theme_bw() +
  theme(aspect.ratio = 1,
        legend.key.height = unit(4, "mm"))
```

![](data:image/png;base64...)

```
# -------------------------
# Dimension reduction: UMAP
# -------------------------

# run umap
set.seed(123)
out_umap <- umap(d_sub)
dims_umap <- out_umap$layout
colnames(dims_umap) <- c("UMAP_1", "UMAP_2")
head(dims_umap)
```

```
##          UMAP_1    UMAP_2
## [1,]  6.7865099  2.589704
## [2,] -7.8532333  7.235170
## [3,]  1.1778011 -6.849296
## [4,] -7.2999900  7.149020
## [5,] -0.8245606 -5.375058
## [6,] -0.2026901 -7.548703
```

```
stopifnot(nrow(dims_umap) == length(population))

colnames(dims_umap) <- c("dimension_x", "dimension_y")
dims_umap <- cbind(as.data.frame(dims_umap), population, type = "UMAP")

head(dims_umap)
```

```
##   dimension_x dimension_y population type
## 1   6.7865099    2.589704 unassigned UMAP
## 2  -7.8532333    7.235170 unassigned UMAP
## 3   1.1778011   -6.849296 unassigned UMAP
## 4  -7.2999900    7.149020 unassigned UMAP
## 5  -0.8245606   -5.375058 unassigned UMAP
## 6  -0.2026901   -7.548703 unassigned UMAP
```

```
str(dims_umap)
```

```
## 'data.frame':    1998 obs. of  4 variables:
##  $ dimension_x: num  6.787 -7.853 1.178 -7.3 -0.825 ...
##  $ dimension_y: num  2.59 7.24 -6.85 7.15 -5.38 ...
##  $ population : Factor w/ 15 levels "Basophils","CD16-_NK_cells",..: 15 15 15 15 15 15 15 9 10 10 ...
##  $ type       : chr  "UMAP" "UMAP" "UMAP" "UMAP" ...
```

```
# generate plot
d_plot <- dims_umap

ggplot(d_plot, aes(x = dimension_x, y = dimension_y, color = population)) +
  facet_wrap(~ type, scales = "free") +
  geom_point(size = 0.7, alpha = 0.5) +
  scale_color_manual(values = colors) +
  labs(x = "dimension x", y = "dimension y") +
  theme_bw() +
  theme(aspect.ratio = 1,
        legend.key.height = unit(4, "mm"))
```

![](data:image/png;base64...)

# 3 Clustering

We can also use the clustering datasets to calculate a new clustering using an algorithm of our choice, and then evaluate the performance of the clustering by comparing against the ground truth cell population labels. Common metrics for evaluating clustering performance include the mean F1 score and adjusted Rand index.

Below, we use the FlowSOM clustering algorithm (Van Gassen et al. 2015) to calculate a new clustering on the `Samusik_01` dataset, and then calculate clustering performance using the ground truth labels.

Note that for simplicity in this vignette, we only calculate the adjusted Rand index. This calculation does not take into account the number of cells per cluster, so could potentially be dominated by one or two large clusters. For more sophisticated evaluations based on the mean F1 score, where we (i) weight clusters equally (instead of weighting cells equally), and (ii) check for multi-mapping populations (i.e. prevent multiple clusters mapping to the same ground truth population), see the code in our GitHub repository from our previous publication (Weber and Robinson, 2016), available at <https://github.com/lmweber/cytometry-clustering-comparison>.

```
suppressPackageStartupMessages(library(HDCytoData))
suppressPackageStartupMessages(library(FlowSOM))
suppressPackageStartupMessages(library(flowCore))
suppressPackageStartupMessages(library(mclust))
suppressPackageStartupMessages(library(umap))
suppressPackageStartupMessages(library(ggplot2))
```

```
# ---------
# Load data
# ---------

d_SE <- Samusik_01_SE()
```

```
## see ?HDCytoData and browseVignettes('HDCytoData') for documentation
```

```
## loading from cache
```

```
dim(d_SE)
```

```
## [1] 86864    51
```

```
# -------------
# Preprocessing
# -------------

# select 'cell type' marker columns for defining clusters
d_sub <- assay(d_SE[, colData(d_SE)$marker_class == "type"])

# extract cell population labels
population <- rowData(d_SE)$population_id

dim(d_sub)
```

```
## [1] 86864    39
```

```
stopifnot(nrow(d_sub) == length(population))

# transform data using asinh with cofactor 5
cofactor <- 5
d_sub <- asinh(d_sub / cofactor)

# create flowFrame object (required input format for FlowSOM)
d_FlowSOM <- flowFrame(d_sub)
```

```
# -----------
# Run FlowSOM
# -----------

# set seed for reproducibility
set.seed(123)

# run FlowSOM (initial steps prior to meta-clustering)
out <- ReadInput(d_FlowSOM, transform = FALSE, scale = FALSE)
out <- BuildSOM(out)
```

```
## Building SOM
```

```
## Mapping data to SOM
```

```
out <- BuildMST(out)
```

```
## Building MST
```

```
# optional FlowSOM visualization
#PlotStars(out)

# extract cluster labels (pre meta-clustering) from output object
labels_pre <- out$map$mapping[, 1]

# specify final number of clusters for meta-clustering
k <- 40

# run meta-clustering
seed <- 123
out <- metaClustering_consensus(out$map$codes, k = k, seed = seed)

# extract cluster labels from output object
labels <- out[labels_pre]

# summary of cluster sizes and number of clusters
table(labels)
```

```
## labels
##     1     2     3     4     5     6     7     8     9    10    11    12    13
##  1257 15597 20715   387  5248  3912   287  1499  1035   497  1984   292   322
##    14    15    16    17    18    19    20    21    22    23    24    25    26
##   620   469   909   303   105   369   555   542  1603   260   341   698  9767
##    27    28    29    30    31    32    33    34    35    36    37    38    39
##   477  5913   757   815   231   721  2876   595   293  1469   434   787   739
##    40
##  1184
```

```
length(table(labels))
```

```
## [1] 40
```

```
# -------------------------------
# Evaluate clustering performance
# -------------------------------

# calculate adjusted Rand index
# note: this calculation weights all cells equally, which may not be
# appropriate for some datasets (see above)

stopifnot(nrow(d_sub) == length(labels))
stopifnot(length(population) == length(labels))

# remove "unassigned" cells from cluster evaluation (but note these were
# included for clustering)
ix_unassigned <- population == "unassigned"
d_sub_eval <- d_sub[!ix_unassigned, ]
population_eval <- population[!ix_unassigned]
labels_eval <- labels[!ix_unassigned]

stopifnot(nrow(d_sub_eval) == length(labels_eval))
stopifnot(length(population_eval) == length(labels_eval))

# calculate adjusted Rand index
adjustedRandIndex(population_eval, labels_eval)
```

```
## [1] 0.8935566
```

```
# ------------
# Plot results
# ------------

# subsample cells for faster runtimes in vignette
n <- 4000

set.seed(1004)
ix <- sample(seq_len(nrow(d_sub)), n)

d_sub <- d_sub[ix, ]
population <- population[ix]
labels <- labels[ix]

dim(d_sub)
```

```
## [1] 4000   39
```

```
stopifnot(nrow(d_sub) == length(population))
stopifnot(nrow(population) == length(labels))

# run umap
set.seed(1234)
out_umap <- umap(d_sub)
dims_umap <- out_umap$layout
colnames(dims_umap) <- c("UMAP_1", "UMAP_2")

stopifnot(nrow(dims_umap) == length(population))
stopifnot(nrow(population) == length(labels))

d_plot <- cbind(
  as.data.frame(dims_umap),
  population,
  labels = as.factor(labels),
  type = "UMAP"
)

# generate plots
colors <- c(rainbow(24), "gray75")

ggplot(d_plot, aes(x = UMAP_1, y = UMAP_2, color = population)) +
  geom_point(size = 0.7, alpha = 0.5) +
  scale_color_manual(values = colors) +
  ggtitle("Ground truth population labels") +
  theme_bw() +
  theme(aspect.ratio = 1,
        legend.key.height = unit(4, "mm"))
```

![](data:image/png;base64...)

```
ggplot(d_plot, aes(x = UMAP_1, y = UMAP_2, color = labels)) +
  geom_point(size = 0.7, alpha = 0.5) +
  ggtitle("FlowSOM cluster labels") +
  theme_bw() +
  theme(aspect.ratio = 1,
        legend.key.height = unit(4, "mm"))
```

![](data:image/png;base64...)

# 4 Differential analysis

In this section, we use the semi-simulated differential analysis datasets (`Weber_AML_sim` and `Weber_BCR_XL_sim`) to demonstrate how to perform differential analyses using the `diffcyt` package (Weber et al. 2019).

For more more details on how to use the `diffcyt` package, see the [Bioconductor vignette](http://bioconductor.org/packages/diffcyt).

For a complete workflow for performing differential discovery analyses in high-dimensional cytometry data, including exploratory analyses, differential testing, and visualizations, see Nowicka et al. (2017, 2019) (also available as a [Bioconductor workflow package](http://bioconductor.org/packages/cytofWorkflow)).

We perform two sets of differential analyses: testing for differential abundance (DA) of cell populations (using the `Weber_AML_sim` dataset), and testing for differential states (DS) within cell populations (using the `Weber_BCR_XL_sim` dataset). In both cases, clusters are defined using “cell type” markers, while for DS testing we also use additional “cell state” markers to test for differential expression within clusters. See our paper introducing the `diffcyt` framework (Weber et al. 2019) for more details. For extended evaluations showing how to calculate performance using the ground truth labels (spike-in cells), see the code in our GitHub repository accompanying our previous publication (Weber et al. 2019), available at <https://github.com/lmweber/diffcyt-evaluations>.

## 4.1 Differential abundance (DA)

```
# suppressPackageStartupMessages(library(diffcyt))
suppressPackageStartupMessages(library(SummarizedExperiment))
```

```
# ---------
# Load data
# ---------

d_SE <- Weber_AML_sim_main_5pc_SE()
```

```
## see ?HDCytoData and browseVignettes('HDCytoData') for documentation
```

```
## loading from cache
```

```
# ---------------
# Set up metadata
# ---------------

# set column names
colnames(d_SE) <- colData(d_SE)$marker_name

# split input data into one matrix per sample
d_input <- split(as.data.frame(assay(d_SE)), rowData(d_SE)$sample_id)

# extract sample information
experiment_info <- metadata(d_SE)$experiment_info
experiment_info
```

```
##    group_id patient_id  sample_id
## 1   healthy         H1 healthy_H1
## 2   healthy         H2 healthy_H2
## 3   healthy         H3 healthy_H3
## 4   healthy         H4 healthy_H4
## 5   healthy         H5 healthy_H5
## 6        CN         H1      CN_H1
## 7        CN         H2      CN_H2
## 8        CN         H3      CN_H3
## 9        CN         H4      CN_H4
## 10       CN         H5      CN_H5
## 11      CBF         H1     CBF_H1
## 12      CBF         H2     CBF_H2
## 13      CBF         H3     CBF_H3
## 14      CBF         H4     CBF_H4
## 15      CBF         H5     CBF_H5
```

```
# extract marker information
marker_info <- colData(d_SE)
marker_info
```

```
## DataFrame with 45 rows and 3 columns
##                    channel_name  marker_name marker_class
##                     <character>  <character>     <factor>
## Time                       Time         Time         none
## Cell_length         Cell_length  Cell_length         none
## DNA1              DNA1(Ir191)Di         DNA1         none
## DNA2              DNA2(Ir193)Di         DNA2         none
## BC1                BC1(Pd104)Di          BC1         none
## ...                         ...          ...          ...
## CD41              CD41(Lu175)Di         CD41         type
## Viability    Viability(Pt195)Di    Viability         none
## file_number         file_number  file_number         none
## event_number       event_number event_number         none
## barcode                 barcode      barcode         none
```

```
# # -----------------------------------
# # Differential abundance (DA) testing
# # -----------------------------------
#
# # create design matrix
# design <- createDesignMatrix(
#   experiment_info, cols_design = c("group_id", "patient_id")
# )
# design
#
# # create contrast matrix
# # note: testing condition CN vs. healthy
# contrast <- createContrast(c(0, 1, 0, 0, 0, 0, 0))
# contrast
#
# # test for differential abundance (DA) of clusters
# out_DA <- diffcyt(
#   d_input,
#   experiment_info,
#   marker_info,
#   design = design,
#   contrast = contrast,
#   analysis_type = "DA",
#   seed_clustering = 1234
# )
#
# # display results for top DA clusters
# topTable(out_DA, format_vals = TRUE)
```

## 4.2 Differential states (DS)

```
# ---------
# Load data
# ---------

d_SE <- Weber_BCR_XL_sim_main_SE()
```

```
## see ?HDCytoData and browseVignettes('HDCytoData') for documentation
```

```
## loading from cache
```

```
# ---------------
# Set up metadata
# ---------------

# set column names
colnames(d_SE) <- colData(d_SE)$marker_name

# split input data into one matrix per sample
d_input <- split(as.data.frame(assay(d_SE)), rowData(d_SE)$sample_id)

# extract sample information
experiment_info <- metadata(d_SE)$experiment_info
experiment_info
```

```
##    group_id patient_id      sample_id
## 1      base   patient1  patient1_base
## 2      base   patient2  patient2_base
## 3      base   patient3  patient3_base
## 4      base   patient4  patient4_base
## 5      base   patient5  patient5_base
## 6      base   patient6  patient6_base
## 7      base   patient7  patient7_base
## 8      base   patient8  patient8_base
## 9     spike   patient1 patient1_spike
## 10    spike   patient2 patient2_spike
## 11    spike   patient3 patient3_spike
## 12    spike   patient4 patient4_spike
## 13    spike   patient5 patient5_spike
## 14    spike   patient6 patient6_spike
## 15    spike   patient7 patient7_spike
## 16    spike   patient8 patient8_spike
```

```
# extract marker information
marker_info <- colData(d_SE)
marker_info
```

```
## DataFrame with 35 rows and 3 columns
##                channel_name marker_name marker_class
##                 <character> <character>     <factor>
## Time                   Time        Time         none
## Cell_length     Cell_length Cell_length         none
## CD3          CD3(110:114)Dd         CD3         type
## CD45          CD45(In115)Dd        CD45         type
## BC1            BC1(La139)Dd         BC1         none
## ...                     ...         ...          ...
## HLA-DR      HLA-DR(Yb174)Dd      HLA-DR         type
## BC7            BC7(Lu175)Dd         BC7         none
## CD7            CD7(Yb176)Dd         CD7         type
## DNA-1        DNA-1(Ir191)Dd       DNA-1         none
## DNA-2        DNA-2(Ir193)Dd       DNA-2         none
```

```
# # -------------------------------
# # Differential state (DS) testing
# # -------------------------------
#
# # create design matrix
# design <- createDesignMatrix(
#   experiment_info, cols_design = c("group_id", "patient_id")
# )
# design
#
# # create contrast matrix
# # note: testing condition spike vs. base
# contrast <- createContrast(c(0, 1, 0, 0, 0, 0, 0, 0, 0))
# contrast
#
# # test for differential abundance (DA) of clusters
# out_DS <- diffcyt(
#   d_input,
#   experiment_info,
#   marker_info,
#   design = design,
#   contrast = contrast,
#   analysis_type = "DS",
#   seed_clustering = 1234
# )
#
# # display results for top DA clusters
# topTable(out_DS, format_vals = TRUE)
```