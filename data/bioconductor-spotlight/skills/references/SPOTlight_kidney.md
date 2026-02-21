# Spatial Transcriptomics Deconvolution with `SPOTlight`

Marc Elosua-Bayes1,2\*, Helena L. Crowell3,4\*\* and Zach DeBruine5\*\*\*

1National Center for Genomic Analysis - Center for Genomic Regulation
2University Pompeu Fabra
3Institute for Molecular Life Sciences, University of Zurich, Switzerland
4SIB Swiss Institute of Bioinformatics, University of Zurich, Switzerland
5Van Andel Institue

\*marc.elosua@cnag.crg.eu
\*\*helena.crowell@uzh.ch
\*\*\*Zach.DeBruine@vai.edu

#### 30 October 2025

#### Abstract

Spatially resolved gene expression profiles are key to understand tissue organization and function. However, novel spatial transcriptomics (ST) profiling techniques lack single-cell resolution and require a combination with single-cell RNA sequencing (scRNA-seq) information to deconvolute the spatially indexed datasets. Leveraging the strengths of both data types, we developed SPOTlight, a computational tool that enables the integration of ST with scRNA-seq data to infer the location of cell types and states within a complex tissue. SPOTlight is centered around a seeded non-negative matrix factorization (NMF) regression, initialized using cell-type marker genes and non-negative least squares (NNLS) to subsequently deconvolute ST capture locations (spots).

#### Package

SPOTlight 1.14.0

# Contents

* [Load packages](#load-packages)
* [1 Introduction](#introduction)
  + [1.1 What is `SPOTlight`?](#what-is-spotlight)
  + [1.2 Starting point](#starting-point)
* [2 Getting started](#getting-started)
  + [2.1 Data description](#data-description)
  + [2.2 Loading the data](#loading-the-data)
* [3 Workflow](#workflow)
  + [3.1 Preprocessing](#preprocessing)
    - [3.1.1 Feature selection](#feature-selection)
    - [3.1.2 Variance modelling](#variance-modelling)
    - [3.1.3 Cell Downsampling](#cell-downsampling)
  + [3.2 Deconvolution](#deconvolution)
* [4 Visualization](#visualization)
  + [4.1 Topic profiles](#topic-profiles)
  + [4.2 Spatial Correlation Matrix](#spatial-correlation-matrix)
  + [4.3 Co-localization](#co-localization)
  + [4.4 Scatterpie](#scatterpie)
  + [4.5 Residuals](#residuals)
* [5 Session information](#session-information)

For a more detailed explanation of `SPOTlight` consider looking at our
manuscript:
> Elosua-Bayes M, Nieto P, Mereu E, Gut I, Heyn H.

# Load packages

```
library(ggplot2)
library(SPOTlight)
library(SingleCellExperiment)
library(SpatialExperiment)
library(scater)
library(scran)
```

# 1 Introduction

## 1.1 What is `SPOTlight`?

`SPOTlight` is a tool that enables the deconvolution of cell types and cell type
proportions present within each capture location comprising mixtures of cells.
Originally developed for 10X’s Visium - spatial transcriptomics - technology, it
can be used for all technologies returning mixtures of cells.

`SPOTlight` is based on learning topic profile signatures, by means of an NMFreg
model, for each cell type and finding which combination of cell types fits best
the spot we want to deconvolute. Find below a graphical abstract visually
summarizing the key steps.

![](data:image/png;base64...)

## 1.2 Starting point

The minimal unit of data required to run `SPOTlight` are:

* ST (sparse) matrix with the expression, raw or normalized, where rows = genes
  and columns = capture locations.
* Single cell (sparse) matrix with the expression, raw or normalized,
* Vector indicating the cell identity for each column in the single cell
  expression matrix.

Data inputs can also be objects of class *[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)* (SE),
*[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* (SCE) objects from
which the minimal data will be extracted.

# 2 Getting started

## 2.1 Data description

For this vignette, we will use a SE put out by *10X Genomics* containing a
Visium kidney slide. The raw data can be accessed
[here](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.1.0/V1_Mouse_Kidney).

SCE data comes from the [*The Tabula Muris
Consortium*](https://www.nature.com/articles/s41586-020-2496-1) which contains
>350,000 cells from from male and female mice belonging to six age groups,
ranging from 1 to 30 months. From this dataset we will only load the kidney
subset to map it to the Visium slide.

## 2.2 Loading the data

Both datasets are available through Biocondcutor packages and can be loaded into R as follows.
`
Load the spatial data:

```
library(TENxVisiumData)
spe <- MouseKidneyCoronal()
# Use symbols instead of Ensembl IDs as feature names
rownames(spe) <- rowData(spe)$symbol
```

Load the single cell data. Since our data comes from the
[Tabula Muris Sensis](https://www.nature.com/articles/s41586-020-2496-1)
dataset, we can directly load the SCE object as follows:

```
library(TabulaMurisSenisData)
sce <- TabulaMurisSenisDroplet(tissues = "Kidney")$Kidney
```

Quick data exploration:

```
table(sce$free_annotation, sce$age)
```

```
##
##                                                                1m   3m  18m
##   CD45                                                         11   32   76
##   CD45    B cell                                                7    5   45
##   CD45    NK cell                                               1    4    8
##   CD45    T cell                                                8   18   48
##   CD45    macrophage                                           59  132  254
##   CD45    plasma cell                                           0    0    9
##   Epcam     kidney distal convoluted tubule epithelial cell    78  126  169
##   Epcam    brush cell                                          52   15   78
##   Epcam    kidney collecting duct principal cell               77  110  132
##   Epcam    kidney proximal convoluted tubule epithelial cell  945  684 1120
##   Epcam    podocyte                                            92   94   64
##   Epcam    proximal tube epithelial cell                       25  195  296
##   Epcam    thick ascending tube S epithelial cell             465  312  248
##   Pecam    Kidney cortex artery cell                           75   78   91
##   Pecam    fenestrated capillary endothelial                  164  182  164
##   Pecam    kidney capillary endothelial cell                   49   38   25
##   Stroma    fibroblast                                         15   16   37
##   Stroma    kidney mesangial cell                              80   51   18
##   nan                                                         285  238  256
##
##                                                               21m  24m  30m
##   CD45                                                         54 1010  106
##   CD45    B cell                                               54 2322   62
##   CD45    NK cell                                               2   47    4
##   CD45    T cell                                               42  846  177
##   CD45    macrophage                                          101  259  514
##   CD45    plasma cell                                          12  169   42
##   Epcam     kidney distal convoluted tubule epithelial cell   153    0  131
##   Epcam    brush cell                                         169    0   31
##   Epcam    kidney collecting duct principal cell               58    0  370
##   Epcam    kidney proximal convoluted tubule epithelial cell  868    0  817
##   Epcam    podocyte                                            66    0  170
##   Epcam    proximal tube epithelial cell                        5    0 1977
##   Epcam    thick ascending tube S epithelial cell             228    0  313
##   Pecam    Kidney cortex artery cell                           69    0  115
##   Pecam    fenestrated capillary endothelial                  134    0  211
##   Pecam    kidney capillary endothelial cell                   18    0    7
##   Stroma    fibroblast                                         13    0   80
##   Stroma    kidney mesangial cell                              22    0    7
##   nan                                                         189 1068  579
```

We see how there is a good representation of all the cell types across ages
except at 24m. In order to reduce the potential noise introduced by age and
batch effects we are going to select cells all coming from the same age.

```
# Keep cells from 18m mice
sce <- sce[, sce$age == "18m"]
# Keep cells with clear cell type annotations
sce <- sce[, !sce$free_annotation %in% c("nan", "CD45")]
```

# 3 Workflow

## 3.1 Preprocessing

If the dataset is very large we want to downsample it to train the model, both
in of number of cells and number of genes. To do this, we want to keep a
representative amount of cells per cluster and the most biologically relevant
genes.

In the paper we show how downsampling the number of cells per cell identity to
~100 doesn’t affect the performance of the model. Including >100 cells per
cell identity provides marginal improvement while greatly increasing
computational time and resources. Furthermore, restricting the gene set to the
marker genes for each cell type along with up to 3.000 highly variable genes
further optimizes performance and computational resources. You can find a more
detailed explanation in the original
[paper](https://academic.oup.com/nar/article/49/9/e50/6129341).

### 3.1.1 Feature selection

Our first step is to get the marker genes for each cell type. We follow the
Normalization procedure as described in
[OSCA](http://bioconductor.org/books/3.14/OSCA.basic/normalization.html). We
first carry out library size normalization to correct for cell-specific biases:

```
sce <- logNormCounts(sce)
```

### 3.1.2 Variance modelling

We aim to identify highly variable genes that drive biological heterogeneity.
By feeding these genes to the model we improve the resolution of the biological structure and reduce the technical noise.

```
# Get vector indicating which genes are neither ribosomal or mitochondrial
genes <- !grepl(pattern = "^Rp[l|s]|Mt", x = rownames(sce))

dec <- modelGeneVar(sce, subset.row = genes)
plot(dec$mean, dec$total, xlab = "Mean log-expression", ylab = "Variance")
curve(metadata(dec)$trend(x), col = "blue", add = TRUE)
```

![](data:image/png;base64...)

```
# Get the top 3000 genes.
hvg <- getTopHVGs(dec, n = 3000)
```

Next we obtain the marker genes for each cell identity. You can use whichever
method you want as long as it returns a weight indicating the importance of that
gene for that cell type. Examples include `avgLogFC`, `AUC`, `pct.expressed`,
`p-value`…

```
colLabels(sce) <- colData(sce)$free_annotation

# Compute marker genes
mgs <- scoreMarkers(sce, subset.row = genes)
```

Then we want to keep only those genes that are relevant for each cell identity:

```
mgs_fil <- lapply(names(mgs), function(i) {
    x <- mgs[[i]]
    # Filter and keep relevant marker genes, those with AUC > 0.8
    x <- x[x$mean.AUC > 0.8, ]
    # Sort the genes from highest to lowest weight
    x <- x[order(x$mean.AUC, decreasing = TRUE), ]
    # Add gene and cluster id to the dataframe
    x$gene <- rownames(x)
    x$cluster <- i
    data.frame(x)
})
mgs_df <- do.call(rbind, mgs_fil)
```

### 3.1.3 Cell Downsampling

Next, we randomly select at most 100 cells per cell identity. If a cell type is
comprised of <100 cells, all the cells will be used. If we have very
biologically different cell identities (B cells vs. T cells vs. Macrophages vs.
Epithelial) we can use fewer cells since their transcriptional profiles will be
very different. In cases when we have more transcriptionally similar cell
identities we need to increase our N to capture the biological heterogeneity
between them.

In our experience we have found that for this step it is better to select the
cells from each cell type from the same batch if you have a joint dataset from
multiple runs. This will ensure that the model removes as much signal from the
batch as possible and actually learns the biological signal.

For the purpose of this vignette and to speed up the analysis, we are going to
use 20 cells per cell identity:

```
# split cell indices by identity
idx <- split(seq(ncol(sce)), sce$free_annotation)
# downsample to at most 20 per identity & subset
# We are using 5 here to speed up the process but set to 75-100 for your real
# life analysis
n_cells <- 50
cs_keep <- lapply(idx, function(i) {
    n <- length(i)
    if (n < n_cells)
        n_cells <- n
    sample(i, n_cells)
})
sce <- sce[, unlist(cs_keep)]
```

## 3.2 Deconvolution

You are now set to run `SPOTlight` to deconvolute the spots!

Briefly, here is how it works:

1. NMF is used to factorize a matrix into two lower dimensionality matrices
   without negative elements. We first have an initial matrix V (SCE count matrix),
   which is factored into W and H. Unit variance normalization by gene is performed
   in V and in order to standardize discretized gene expression levels,
   ‘counts-umi’. Factorization is then carried out using the non-smooth NMF method,
   implemented in the R package NMF *[NMF](https://CRAN.R-project.org/package%3DNMF)* (14). This method is
   intended to return sparser results during the factorization in W and H, thus
   promoting cell-type-specific topic profile and reducing overfitting during
   training. Before running factorization, we initialize each topic, column,
   of W with the unique marker genes for each cell type with weights. In turn, each
   topic of H in `SPOTlight` is initialized with the corresponding membership of each
   cell for each topic, 1 or 0. This way, we seed the model with prior information,
   thus guiding it towards a biologically relevant result. This initialization also
   aims at reducing variability and improving the consistency between runs.
2. NNLS regression is used to map each capture location’s transcriptome in V’
   (SE count matrix) to H’ using W as the basis. We obtain a topic profile
   distribution over each capture location which we can use to determine its
   composition.
3. we obtain Q, cell-type specific topic profiles, from H. We select all cells
   from the same cell type and compute the median of each topic for a consensus
   cell-type-specific topic signature. We then use NNLS to find the weights of each
   cell type that best fit H’ minimizing the residuals.

You can visualize the above explanation in the following workflow scheme:

![](data:image/png;base64...)

```
res <- SPOTlight(
    x = sce,
    y = spe,
    groups = as.character(sce$free_annotation),
    mgs = mgs_df,
    hvg = hvg,
    weight_id = "mean.AUC",
    group_id = "cluster",
    gene_id = "gene")
```

```
## Scaling count matrix
```

```
## Seeding NMF model...
```

```
## Training NMF model...
```

```
##
## iter |      tol
## ---------------
##    1 | 3.57e-01
##    2 | 1.65e-02
##    3 | 5.59e-03
##    4 | 3.72e-03
##    5 | 4.22e-03
##    6 | 5.73e-03
##    7 | 3.56e-03
##    8 | 1.18e-03
##    9 | 4.58e-04
##   10 | 2.58e-04
##   11 | 1.58e-04
##   12 | 1.07e-04
##   13 | 9.21e-05
##   14 | 8.93e-05
##   15 | 9.51e-05
##   16 | 1.05e-04
##   17 | 1.17e-04
##   18 | 1.34e-04
##   19 | 1.53e-04
##   20 | 1.69e-04
##   21 | 1.70e-04
##   22 | 1.48e-04
##   23 | 1.11e-04
##   24 | 7.32e-05
##   25 | 4.32e-05
##   26 | 2.44e-05
##   27 | 1.37e-05
##   28 | 7.58e-06
```

```
## Time for training: 0.01min
```

```
## Removing genes in mixture matrix that are all 0s
```

```
## Keep intersection of genes between W and mixture matrix
```

```
## Deconvoluting mixture data...
```

Alternatively you can run `SPOTlight` in two steps so that you can have the trained model. Having the trained model allows you to reuse with other datasets you also want to deconvolute with the same reference. This allows you to skip the training step, the most time consuming and computationally expensive.

```
mod_ls <- trainNMF(
    x = sce,
    groups = sce$free_annotation,
    mgs = mgs_df,
    hvg = hvg,
    weight_id = "mean.AUC",
    group_id = "cluster",
    gene_id = "gene")

 # Run deconvolution
res <- runDeconvolution(
    x = spe,
    mod = mod_ls[["mod"]],
    ref = mod_ls[["topic"]])
```

Extract data from `SPOTlight`:

```
# Extract deconvolution matrix
head(mat <- res$mat)[, seq_len(3)]
```

```
##                    CD45    B cell CD45    NK cell CD45    T cell
## AAACCGTTCGTCCAGG-1    0.000000000    5.442976e-02              0
## AAACCTAAGCAGCCGG-1    0.000000000    8.916665e-05              0
## AAACGAGACGGTTGAT-1    0.000000000    2.593332e-03              0
## AAACGGTTGCGAACTG-1    0.000000000    2.300782e-02              0
## AAACTCGGTTCGCAAT-1    0.000000000    2.193200e-01              0
## AAACTGCTGGCTCCAA-1    0.003903817    2.291095e-02              0
```

```
# Extract NMF model fit
mod <- res$NMF
```

# 4 Visualization

In the next section we show how to visualize the data and interpret
`SPOTlight`’s results.

## 4.1 Topic profiles

We first take a look at the Topic profiles. By setting `facet = FALSE` we want to
evaluate how specific each topic signature is for each cell identity.
Ideally each cell identity will have a unique topic profile associated to it as
seen below.

```
plotTopicProfiles(
    x = mod,
    y = sce$free_annotation,
    facet = FALSE,
    min_prop = 0.01,
    ncol = 1) +
    theme(aspect.ratio = 1)
```

![](data:image/png;base64...)

Next we also want to ensure that all the cells from the same cell identity share
a similar topic profile since this will mean that `SPOTlight` has learned a
consistent signature for all the cells from the same cell identity.

```
plotTopicProfiles(
    x = mod,
    y = sce$free_annotation,
    facet = TRUE,
    min_prop = 0.01,
    ncol = 6)
```

![](data:image/png;base64...)

Lastly we can take a look at which genes the model learned for each topic.
Higher values indicate that the gene is more relevant for that topic.
In the below table we can see how the top genes for `Topic1` are characteristic
for B cells (i.e. *Cd79a*, *Cd79b*, *Ms4a1*…).

```
# library(NMF)
sign <- mod$w
# colnames(sign) <- paste0("Topic", seq_len(ncol(sign)))
head(sign)
```

```
##            topic_1      topic_2      topic_3     topic_4      topic_5
## Cd79a 0.0000000000 0.0000000000 0.0000000000 0.000000000 0.000000e+00
## Ly6d  0.0000000000 0.0000000000 0.0000000000 0.000000000 0.000000e+00
## Fau   0.0005736117 0.0007544909 0.0007013649 0.001071949 6.748701e-04
## Cd37  0.0000000000 0.0000000000 0.0000000000 0.000000000 0.000000e+00
## Cd79b 0.0000000000 0.0000131989 0.0000000000 0.000000000 0.000000e+00
## Cd74  0.0000000000 0.0000000000 0.0000000000 0.000000000 7.662344e-06
##            topic_6      topic_7      topic_8      topic_9     topic_10
## Cd79a 0.000000e+00 0.0000000000 0.0000000000 0.0000000000 0.0000000000
## Ly6d  0.000000e+00 0.0000000000 0.0000000000 0.0000000000 0.0000000000
## Fau   7.238935e-04 0.0008133968 0.0006032006 0.0018740607 0.0006900952
## Cd37  0.000000e+00 0.0000000000 0.0000000000 0.0003209505 0.0000000000
## Cd79b 0.000000e+00 0.0000000000 0.0000000000 0.0000000000 0.0000000000
## Cd74  4.871342e-06 0.0000000000 0.0000000000 0.0036773213 0.0000000000
##           topic_11    topic_12     topic_13    topic_14     topic_15
## Cd79a 0.000000e+00 0.000000000 0.0000000000 0.006390614 0.0000000000
## Ly6d  6.528134e-05 0.000000000 0.0000000000 0.006161581 0.0000000000
## Fau   8.337511e-04 0.002015652 0.0003680164 0.004227919 0.0004368525
## Cd37  0.000000e+00 0.001885559 0.0000000000 0.006459240 0.0000000000
## Cd79b 0.000000e+00 0.000000000 0.0000000000 0.006811482 0.0000000000
## Cd74  0.000000e+00 0.000000000 0.0000000000 0.001514668 0.0000000000
##           topic_16     topic_17
## Cd79a 0.0026289569 0.000000e+00
## Ly6d  0.0007243711 3.655839e-06
## Fau   0.0012600539 1.069516e-03
## Cd37  0.0007031711 1.989092e-04
## Cd79b 0.0005948144 0.000000e+00
## Cd74  0.0006908739 0.000000e+00
```

```
# This can be dynamically visualized with DT as shown below
# DT::datatable(sign, fillContainer = TRUE, filter = "top")
```

## 4.2 Spatial Correlation Matrix

See [here](http://www.sthda.com/english/wiki/ggcorrplot-visualization-of-a-correlation-matrix-using-ggplot2)
for additional graphical parameters.

```
plotCorrelationMatrix(mat)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the ggcorrplot package.
##   Please report the issue at <https://github.com/kassambara/ggcorrplot/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

## 4.3 Co-localization

Now that we know which cell types are found within each spot we can make a graph
representing spatial interactions where cell types will have stronger edges
between them the more often we find them within the same spot.

See [here](https://www.r-graph-gallery.com/network.html) for additional
graphical parameters.

```
plotInteractions(mat, which = "heatmap", metric = "prop")
```

![](data:image/png;base64...)

```
plotInteractions(mat, which = "heatmap", metric = "jaccard")
```

![](data:image/png;base64...)

```
plotInteractions(mat, which = "network")
```

![](data:image/png;base64...)

## 4.4 Scatterpie

We can also visualize the cell type proportions as sections of a pie chart for
each spot. You can modify the colors as you would a standard *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)*.

```
ct <- colnames(mat)
mat[mat < 0.1] <- 0

# Define color palette
# (here we use 'paletteMartin' from the 'colorBlindness' package)
paletteMartin <- c(
    "#000000", "#004949", "#009292", "#ff6db6", "#ffb6db",
    "#490092", "#006ddb", "#b66dff", "#6db6ff", "#b6dbff",
    "#920000", "#924900", "#db6d00", "#24ff24", "#ffff6d")

pal <- colorRampPalette(paletteMartin)(length(ct))
names(pal) <- ct

plotSpatialScatterpie(
    x = spe,
    y = mat,
    cell_types = colnames(mat),
    img = FALSE,
    scatterpie_alpha = 1,
    pie_scale = 0.4) +
    scale_fill_manual(
        values = pal,
        breaks = names(pal))
```

![](data:image/png;base64...)

With the image underneath - we are rotating it 90 degrees counterclockwise and mirroring across the horizontal axis to show how to align if the spots don’t overlay the image.

```
plotSpatialScatterpie(
    x = spe,
    y = mat,
    cell_types = colnames(mat),
    img = FALSE,
    scatterpie_alpha = 1,
    pie_scale = 0.4,
    # Rotate the image 90 degrees counterclockwise
    degrees = -90,
    # Pivot the image on its x axis
    axis = "h") +
    scale_fill_manual(
        values = pal,
        breaks = names(pal))
```

![](data:image/png;base64...)

## 4.5 Residuals

Lastly we can also take a look at how well the model predicted the proportions
for each spot. We do this by looking at the residuals of the sum of squares for
each spot which indicates the amount of biological signal not explained by the model.

```
spe$res_ss <- res[[2]][colnames(spe)]
xy <- spatialCoords(spe)
spe$x <- xy[, 1]
spe$y <- xy[, 2]
ggcells(spe, aes(x, y, color = res_ss)) +
    geom_point() +
    scale_color_viridis_c() +
    coord_fixed() +
    theme_bw()
```

![](data:image/png;base64...)

# 5 Session information

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
##  [1] rhdf5_2.54.0                TabulaMurisSenisData_1.15.1
##  [3] TENxVisiumData_1.17.0       ExperimentHub_3.0.0
##  [5] AnnotationHub_4.0.0         BiocFileCache_3.0.0
##  [7] dbplyr_2.5.1                scran_1.38.0
##  [9] scater_1.38.0               scuttle_1.20.0
## [11] SpatialExperiment_1.20.0    SingleCellExperiment_1.32.0
## [13] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [15] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [17] IRanges_2.44.0              S4Vectors_0.48.0
## [19] BiocGenerics_0.56.0         generics_0.1.4
## [21] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [23] SPOTlight_1.14.0            ggplot2_4.0.0
## [25] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       jsonlite_2.0.0           magrittr_2.0.4
##   [4] ggbeeswarm_0.7.2         magick_2.9.0             farver_2.1.2
##   [7] rmarkdown_2.30           fs_1.6.6                 vctrs_0.6.5
##  [10] memoise_2.0.1            tinytex_0.57             htmltools_0.5.8.1
##  [13] S4Arrays_1.10.0          curl_7.0.0               BiocNeighbors_2.4.0
##  [16] Rhdf5lib_1.32.0          SparseArray_1.10.0       sass_0.4.10
##  [19] bslib_0.9.0              plyr_1.8.9               httr2_1.2.1
##  [22] cachem_1.1.0             igraph_2.2.1             lifecycle_1.0.4
##  [25] pkgconfig_2.0.3          rsvd_1.0.5               Matrix_1.7-4
##  [28] R6_2.6.1                 fastmap_1.2.0            digest_0.6.37
##  [31] AnnotationDbi_1.72.0     dqrng_0.4.1              irlba_2.3.5.1
##  [34] RSQLite_2.4.3            beachmat_2.26.0          filelock_1.0.3
##  [37] labeling_0.4.3           gdata_3.0.1              polyclip_1.10-7
##  [40] httr_1.4.7               abind_1.4-8              compiler_4.5.1
##  [43] bit64_4.6.0-1            withr_3.0.2              S7_0.2.0
##  [46] ggcorrplot_0.1.4.1       BiocParallel_1.44.0      viridis_0.6.5
##  [49] DBI_1.2.3                ggforce_0.5.0            HDF5Array_1.38.0
##  [52] MASS_7.3-65              rappdirs_0.3.3           DelayedArray_0.36.0
##  [55] rjson_0.2.23             bluster_1.20.0           gtools_3.9.5
##  [58] tools_4.5.1              vipor_0.4.7              scatterpie_0.2.6
##  [61] beeswarm_0.4.0           glue_1.8.0               h5mread_1.2.0
##  [64] rhdf5filters_1.22.0      grid_4.5.1               cluster_2.1.8.1
##  [67] reshape2_1.4.4           gtable_0.3.6             tidyr_1.3.1
##  [70] BiocSingular_1.26.0      ScaledMatrix_1.18.0      metapod_1.18.0
##  [73] XVector_0.50.0           ggrepel_0.9.6            BiocVersion_3.22.0
##  [76] pillar_1.11.1            stringr_1.5.2            yulab.utils_0.2.1
##  [79] limma_3.66.0             tweenr_2.0.3             dplyr_1.1.4
##  [82] lattice_0.22-7           bit_4.6.0                tidyselect_1.2.1
##  [85] locfit_1.5-9.12          Biostrings_2.78.0        knitr_1.50
##  [88] gridExtra_2.3            bookdown_0.45            edgeR_4.8.0
##  [91] xfun_0.53                statmod_1.5.1            stringi_1.8.7
##  [94] ggfun_0.2.0              yaml_2.3.10              evaluate_1.0.5
##  [97] codetools_0.2-20         tibble_3.3.0             BiocManager_1.30.26
## [100] cli_3.6.5                jquerylib_0.1.4          dichromat_2.0-0.1
## [103] Rcpp_1.1.0               png_0.1-8                parallel_4.5.1
## [106] blob_1.2.4               sparseMatrixStats_1.22.0 viridisLite_0.4.2
## [109] scales_1.4.0             purrr_1.1.0              crayon_1.5.3
## [112] rlang_1.1.6              KEGGREST_1.50.0
```