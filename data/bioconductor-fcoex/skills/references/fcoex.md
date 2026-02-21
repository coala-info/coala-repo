# fcoex: co-expression for single-cell data

#### Tiago Lubiana

Computational Systems Biology Laboratory, University of São Paulo, Brazil

* [Introduction and basic pipeline](#introduction-and-basic-pipeline)

# Introduction and basic pipeline

The goal of fcoex is to provide a simple and intuitive way to generate co-expression nets and modules for single cell data. It is based in 3 steps:

* Pre-processing and label assignement (prior to fcoex)
* Discretization of gene expression
* Correlation and module detection via the FCBF algorithm (Fast Correlation-Based Filter)

First of all, we will a already preprocessed single cell dataset from 10XGenomics ( preprocessed according to <https://osca.bioconductor.org/a-basic-analysis.html#preprocessing-import-to-r>, 14/08/2019). It contains peripheral blood mononuclear cells and the most variable genes.

```
library(fcoex, quietly = TRUE)
library(SingleCellExperiment, quietly = TRUE)
data("mini_pbmc3k")

cat("This is the single cell object we will explore:")
```

```
## This is the single cell object we will explore:
```

```
mini_pbmc3k
```

```
## class: SingleCellExperiment
## dim: 1700 600
## metadata(0):
## assays(2): counts logcounts
## rownames(1700): LYZ S100A9 ... ALG10 LLGL1
## rowData names(3): ENSEMBL_ID Symbol_TENx Symbol
## colnames(600): V1 V2 ... V599 V600
## colData names(14): Sample Barcode ... mod_FCER1G mod_CD3D
## reducedDimNames(2): PCA UMAP
## spikeNames(0):
## altExpNames(0):
```

Now let’s use the normalized data and the cluster labels to build the co-expresison networks. The labels were obtained by louvain clustering on a graph build from nearest neighbours. That means that these labels are a posteriori, and this depends on the choice of the analyst.

The fcoex object is created from 2 different pieces: a previously normalized expression table (genes in rows) and a target factor with classes for the cells.

```
target <- colData(mini_pbmc3k)
target <- target$clusters
exprs <- as.data.frame(assay(mini_pbmc3k, 'logcounts'))

fc <- new_fcoex(data.frame(exprs),target)
```

The first step is the conversion of the count matrix into a discretized dataframe. The standar of fcoex is a simple binarization that works as follows:

For each gene, the maximum and minimum values are stored. This range is divided in n bins of equal width (parameter to be set). The first bin is assigned to the class “low” and all the others to the class “high”.

```
fc <- discretize(fc, number_of_bins = 8)
```

Note that many other discretizations are avaible, from the implementations in the FCBF Bioconductor package. This step affects the final results in many ways. However, we found empirically that the default parameter often yields interesting results.

After the discretization, we proceed to constructing a network and extracting modules. The co-expression adjacency matriz generated is modular in its inception. All correlations used are calculated via Symmetrical Uncertainty. Three steps are present:

1 - Selection of n genes to be considered, ranked by correlation to the target variable.

2 - Detection of predominantly correlated genes, a feature selection approach defined in the FCBF algorithm

3 - Building of modules around selected genes. Correlations between two genes are kept if they are more correlated to each other than to the target lables

You can choose either to have a non-parallel processing, with a progress bar, or a faster parallel processing without progress bar. Up to you.

```
fc <- find_cbf_modules(fc,n_genes = 200, verbose = FALSE, is_parallel = FALSE)
```

```
## [1] "Number of prospective features =  199"
```

#’

There are two functions that do the same: both get\_nets and plot\_interactions take the modules and plot networks. You can pick the name you like better. These visualizations were heavily inspired by the CEMiTool package, as much of the code in fcoex.

We will take a look at the first two networks

```
fc <- get_nets(fc)

# Taking a look at the first two networks:
show_net(fc)[["CD79A"]]
```

![](data:image/png;base64...)

```
show_net(fc)[["HLA-DRB1"]]
```

![](data:image/png;base64...)

To save the plots, you can run the save plots function, which will create a “./Plots” directory and store plots there.

```
save_plots(name = "fcoex_vignette", fc,force = TRUE, , directory = "./Plots")
```

You can also run over-representation analysis to see if the modules correspond to any known biological pathway. For this, we will use the reactome groups available in the CEMiTool package:

```
gmt_fname <- system.file("extdata", "pathways.gmt", package = "CEMiTool")
gmt_in <- pathwayPCA::read_gmt(gmt_fname)
fc <- mod_ora(fc, gmt_in)
```

```
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
```

```
## --> No gene can be mapped....
```

```
## --> Expected input gene ID: RPL9,GNG5,DCN,PEX3,ABCC6,RPS14
```

```
## --> return NULL...
```

```
## `universe` is not in character and will be ignored...
```

```
## --> No gene can be mapped....
```

```
## --> Expected input gene ID: EIF3I,RPS19,RPL36,ABCA3,RPL8,RPL26
```

```
## --> return NULL...
```

```
fc <- plot_ora(fc)
```

Now we can save the plots again. Note that we have to set the force parameter equal to TRUE now, as the “./Plots” directory was already created in the previous step.

```
save_plots(name = "fcoex_vignette", fc, force = TRUE, directory = "./Plots")
```

There is now a folder with the correlations, to explore the data.

We will use the module assignments to subdivide the cells in populations of interest. This is a way to explore the data and look for possible novel groupings ignored in the previous clustering step.

```
fc <- recluster(fc)
```

```
## [1] "FCER1G"
## [1] "CD3D"
## [1] "HLA-DRB1"
## [1] "AIF1"
## [1] "CST3"
## [1] "CD79A"
## [1] "CST7"
## [1] "CTSS"
## [1] "FCGR3A"
## [1] "CD7"
## [1] "SAT1"
## [1] "S100A6"
```

We generated new labels based on each fcoex module. Now we will visualize them using UMAP. Let’s see the population represented in the modules CD79A and HLA-DRB1. Notably, the patterns are largely influenced by the patterns of header genes. It is interesting to see that two groups are present, header-positive (HP) and header negative (HN) clusters.

The stratification and exploration of different clustering points of view is one of the core

```
colData(mini_pbmc3k) <- cbind(colData(mini_pbmc3k), `mod_HLA-DRB1` = idents(fc)$`HLA-DRB1`)
colData(mini_pbmc3k) <- cbind(colData(mini_pbmc3k), mod_CD79A = idents(fc)$CD79A)

library(scater)
```

```
## Loading required package: ggplot2
```

```
# Let's see the original clusters
plotReducedDim(mini_pbmc3k, dimred="UMAP", colour_by="clusters")
```

![](data:image/png;base64...)

```
library(gridExtra)
```

```
##
## Attaching package: 'gridExtra'
```

```
## The following object is masked from 'package:Biobase':
##
##     combine
```

```
## The following object is masked from 'package:BiocGenerics':
##
##     combine
```

```
p1 <- plotReducedDim(mini_pbmc3k, dimred="UMAP", colour_by="mod_HLA-DRB1")
p2 <- plotReducedDim(mini_pbmc3k, dimred="UMAP", colour_by="HLA-DRB1")
p3 <- plotReducedDim(mini_pbmc3k, dimred="UMAP", colour_by="mod_CD79A")
p4 <- plotReducedDim(mini_pbmc3k, dimred="UMAP", colour_by="CD79A")

grid.arrange(p1, p2, p3, p4, nrow=2)
```

![](data:image/png;base64...)

#Integration to Seurat

Another popular framework for single-cell analysis is Seurat. Let’s see how to integrate it with fcoex.

```
library(Seurat)
```

```
## Registered S3 method overwritten by 'R.oo':
##   method        from
##   throw.default R.methodsS3
```

```
##
## Attaching package: 'Seurat'
```

```
## The following object is masked from 'package:SummarizedExperiment':
##
##     Assays
```

```
library(fcoex)
library(ggplot2)
data(pbmc_small)

exprs <- data.frame(GetAssayData(pbmc_small))
target <- Idents(pbmc_small)

fc <- new_fcoex(data.frame(exprs),target)
```

```
## Created new fcoex object.
```

```
fc <- discretize(fc)
fc <- find_cbf_modules(fc,n_genes = 70, verbose = FALSE, is_parallel = FALSE)
```

```
## Getting SU scores
```

```
## Running FCBF to find module headers
```

```
## [1] "Number of prospective features =  69"
```

```
## Calculating adjacency matrix
```

```
## Getting modules from adjacency matrix
```

```
fc <- get_nets(fc)

gmt_fname <- system.file("extdata", "pathways.gmt", package = "CEMiTool")
gmt_in <- pathwayPCA::read_gmt(gmt_fname)
fc <- mod_ora(fc, gmt_in)
```

```
## `universe` is not in character and will be ignored...
```

```
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
## `universe` is not in character and will be ignored...
```

```
# In Seurat's sample data, pbmc small, no enrichments are found.
# That is way plot_ora is commented out.

#fc <- plot_ora(fc)
```

```
save_plots(name = "fcoex_vignette_Seurat", fc, force = TRUE, directory = "./Plots")
```

Now let’s recluster fcoex and visualize the new clusters via the UMAP saved in the Seurat object.

```
fc <- recluster(fc)

file_name <- "pbmc3k_recluster_plots.pdf"
directory <- "./Plots/"

pbmc_small <- RunUMAP(pbmc_small, dims = 1:10)

pdf(paste0(directory,file_name), width = 3, height = 3)

print(DimPlot(pbmc_small))

for (i in names(module_genes(fc))){
  Idents(pbmc_small ) <-   idents(fc)[[i]]
  mod_name <- paste0("M", which(names(idents(fc)) == i), " (", i,")")

  plot2 <- DimPlot(pbmc_small, reduction = 'umap', cols = c("darkgreen", "dodgerblue3")) +
    ggtitle(mod_name)
    print(plot2)
}
dev.off()
```

The clusters generate by fcoex match possible matches different Seurat clusters. Looking at the HN clusters: M1 matches cluster 1 (likely monocytes), M2 matches clusters 0 and 1 (likely APCs, B + monocytes), M5 matches cluster 0 (likeky B) M7 maches a subset of cluster 2, and as it includes granzymes and granulolysins, this subset of 2 is likely cytotoxic cells (either NK or CD8)