# Code example from 'introduction' vignette. See references/ for full tutorial.

## ----import_libraries, message=FALSE, warning=FALSE---------------------------
library("Nebulosa")
library("scater")
library("scran")
library("DropletUtils")
library("BiocFileCache")

## ----download_and_untar_file--------------------------------------------------
bfc <- BiocFileCache(ask = FALSE)
data_file <- bfcrpath(bfc, file.path(
  "https://s3-us-west-2.amazonaws.com/10x.files/samples/cell",
  "pbmc3k",
  "pbmc3k_filtered_gene_bc_matrices.tar.gz"
))

untar(data_file, exdir = tempdir())
pbmc <- read10xCounts(file.path(tempdir(),
  "filtered_gene_bc_matrices",
  "hg19"
))

## ----rename_rows--------------------------------------------------------------
rownames(pbmc) <- uniquifyFeatureNames(rowData(pbmc)[["ID"]],
                                       rowData(pbmc)[["Symbol"]])

## ----filter_features----------------------------------------------------------
i <- rowSums(counts(pbmc) > 0)
is_expressed <- i > 3
pbmc <- pbmc[is_expressed, ]

## ----filter_cells-------------------------------------------------------------
i <- colSums(counts(pbmc) > 0)
is_expressed <- i > 200
pbmc <- pbmc[,is_expressed]

## ----qc, warning=FALSE--------------------------------------------------------
is_mito <- grepl("^MT-", rownames(pbmc))
qcstats <- perCellQCMetrics(pbmc, subsets = list(Mito = is_mito))
qcfilter <- quickPerCellQC(qcstats, percent_subsets = c("subsets_Mito_percent"))

## ----norm---------------------------------------------------------------------
logcounts(pbmc) <- log1p(counts(pbmc) / colSums(counts(pbmc)) * 1e4)

## ----modelgenevar-------------------------------------------------------------
dec <- modelGeneVar(pbmc)
top_hvgs <- getTopHVGs(dec, n = 3000)

## ----dim_red------------------------------------------------------------------
set.seed(66)
pbmc <- runPCA(pbmc, scale = TRUE, subset_row = top_hvgs)

## ----umap---------------------------------------------------------------------
pbmc <- runUMAP(pbmc, dimred = "PCA")

## ----clustering---------------------------------------------------------------
g <- buildSNNGraph(pbmc, k = 10, use.dimred = "PCA")
clust <- igraph::cluster_louvain(g)$membership
colLabels(pbmc) <- factor(clust)

## ----plot_cd4-----------------------------------------------------------------
plot_density(pbmc, "CD4")

## ----cd4_comparison-----------------------------------------------------------
plotUMAP(pbmc, colour_by = "CD4")

## ----fig.height=10------------------------------------------------------------
p3 <- plot_density(pbmc, c("CD8A", "CCR7"))
p3 + plot_layout(ncol = 1)

## ----fig.height=14------------------------------------------------------------
p4 <- plot_density(pbmc, c("CD8A", "CCR7"), joint = TRUE)
p4 + plot_layout(ncol = 1)

## ----clusters-----------------------------------------------------------------
plotUMAP(pbmc, colour_by = "label", text_by = "label")

## ----combine_param------------------------------------------------------------
p_list <- plot_density(pbmc, c("CD8A", "CCR7"), joint = TRUE, combine = FALSE)
p_list[[length(p_list)]]

## ----joint, fig.height=14-----------------------------------------------------
p4 <- plot_density(pbmc, c("CD4", "CCR7"), joint = TRUE)
p4 + plot_layout(ncol = 1)

