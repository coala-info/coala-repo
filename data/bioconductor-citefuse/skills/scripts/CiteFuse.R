# Code example from 'CiteFuse' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE, 
                       collapse = TRUE, comment = "#>",
                      fig.height = 5, fig.width = 5,
                      fig.retina = 1,
                      dpi = 60)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#  install.packages("BiocManager")
# }
# BiocManager::install("CiteFuse")

## -----------------------------------------------------------------------------
library(CiteFuse)
library(scater)
library(SingleCellExperiment)
library(DT)

## -----------------------------------------------------------------------------
data("CITEseq_example", package = "CiteFuse")
names(CITEseq_example)
lapply(CITEseq_example, dim)

## -----------------------------------------------------------------------------
sce_citeseq <- preprocessing(CITEseq_example)
sce_citeseq

## -----------------------------------------------------------------------------
sce_citeseq <- normaliseExprs(sce = sce_citeseq, 
                              altExp_name = "HTO", 
                              transform = "log")

## ----fig.height=6, fig.width=6------------------------------------------------

sce_citeseq <- scater::runTSNE(sce_citeseq, 
                               altexp = "HTO", 
                               name = "TSNE_HTO", 
                               pca = TRUE)


visualiseDim(sce_citeseq,
             dimNames = "TSNE_HTO") + labs(title = "tSNE (HTO)")

sce_citeseq <- scater::runUMAP(sce_citeseq, 
                               altexp = "HTO", 
                               name = "UMAP_HTO")


visualiseDim(sce_citeseq,
             dimNames = "UMAP_HTO") + labs(title = "UMAP (HTO)")

## -----------------------------------------------------------------------------
sce_citeseq <- crossSampleDoublets(sce_citeseq)

## -----------------------------------------------------------------------------
table(sce_citeseq$doubletClassify_between_label)
table(sce_citeseq$doubletClassify_between_class)

## ----fig.height=6, fig.width=6------------------------------------------------
visualiseDim(sce_citeseq, 
             dimNames = "TSNE_HTO", 
             colour_by = "doubletClassify_between_label")

## ----fig.height=8, fig.width=6------------------------------------------------
plotHTO(sce_citeseq, 1:4)

## -----------------------------------------------------------------------------
sce_citeseq <- withinSampleDoublets(sce_citeseq,
                                    minPts = 10)

## -----------------------------------------------------------------------------
table(sce_citeseq$doubletClassify_within_label)
table(sce_citeseq$doubletClassify_within_class)

## ----fig.height=6, fig.width=6------------------------------------------------
visualiseDim(sce_citeseq, 
             dimNames = "TSNE_HTO", 
             colour_by = "doubletClassify_within_label")

## -----------------------------------------------------------------------------
sce_citeseq <- sce_citeseq[, sce_citeseq$doubletClassify_within_class == "Singlet" & sce_citeseq$doubletClassify_between_class == "Singlet"]
sce_citeseq

## -----------------------------------------------------------------------------
sce_citeseq <- scater::logNormCounts(sce_citeseq)
sce_citeseq <- normaliseExprs(sce_citeseq, altExp_name = "ADT", transform = "log")
system.time(sce_citeseq <- CiteFuse(sce_citeseq))

## -----------------------------------------------------------------------------
SNF_W_clust <- spectralClustering(metadata(sce_citeseq)[["SNF_W"]], K = 20)
plot(SNF_W_clust$eigen_values)
which.max(abs(diff(SNF_W_clust$eigen_values)))

## -----------------------------------------------------------------------------
SNF_W_clust <- spectralClustering(metadata(sce_citeseq)[["SNF_W"]], K = 5)
sce_citeseq$SNF_W_clust <- as.factor(SNF_W_clust$labels)

SNF_W1_clust <- spectralClustering(metadata(sce_citeseq)[["ADT_W"]], K = 5)
sce_citeseq$ADT_clust <- as.factor(SNF_W1_clust$labels)

SNF_W2_clust <- spectralClustering(metadata(sce_citeseq)[["RNA_W"]], K = 5)
sce_citeseq$RNA_clust <- as.factor(SNF_W2_clust$labels)

## ----fig.height=8, fig.width=8------------------------------------------------

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

## ----fig.height=8-------------------------------------------------------------
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

## ----fig.height=8, fig.width=8------------------------------------------------
SNF_W_louvain <- igraphClustering(sce_citeseq, method = "louvain")
table(SNF_W_louvain)

sce_citeseq$SNF_W_louvain <- as.factor(SNF_W_louvain)

visualiseDim(sce_citeseq, dimNames = "tSNE_joint", colour_by = "SNF_W_louvain") +
  labs(title = "tSNE (SNF louvain clustering)")

## ----fig.height = 6, fig.width = 6--------------------------------------------
visualiseKNN(sce_citeseq, colour_by = "SNF_W_louvain")

## ----fig.height = 4, fig.width = 8--------------------------------------------
visualiseExprs(sce_citeseq, 
               plot = "boxplot", 
               group_by = "SNF_W_louvain",
               feature_subset = c("hg19_CD2", "hg19_CD4", "hg19_CD8A", "hg19_CD19"))
visualiseExprs(sce_citeseq, 
               plot = "violin", 
               group_by = "SNF_W_louvain",
               feature_subset = c("hg19_CD2", "hg19_CD4", "hg19_CD8A", "hg19_CD19"))
visualiseExprs(sce_citeseq, 
               plot = "jitter", 
               group_by = "SNF_W_louvain",
               feature_subset = c("hg19_CD2", "hg19_CD4", "hg19_CD8A", "hg19_CD19"))
visualiseExprs(sce_citeseq, 
               plot = "density", 
               group_by = "SNF_W_louvain",
               feature_subset = c("hg19_CD2", "hg19_CD4", "hg19_CD8A", "hg19_CD19"))



## ----fig.height = 4, fig.width = 6--------------------------------------------
visualiseExprs(sce_citeseq, 
               altExp_name = "ADT", 
               group_by = "SNF_W_louvain",
               plot = "violin", n = 5)
visualiseExprs(sce_citeseq, altExp_name = "ADT", 
               plot = "jitter", 
               group_by = "SNF_W_louvain", 
               feature_subset = c("CD2", "CD8", "CD4", "CD19"))
visualiseExprs(sce_citeseq, altExp_name = "ADT", 
               plot = "density", 
               group_by = "SNF_W_louvain",
               feature_subset = c("CD2", "CD8", "CD4", "CD19"))


## ----fig.height = 4, fig.width = 8--------------------------------------------
visualiseExprs(sce_citeseq, altExp_name = "ADT", 
               plot = "pairwise", 
               feature_subset = c("CD4", "CD8"))

visualiseExprs(sce_citeseq, altExp_name = "ADT", 
               plot = "pairwise", 
               feature_subset = c("CD45RA", "CD4", "CD8"), 
               threshold = rep(4, 3))

## -----------------------------------------------------------------------------
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

## -----------------------------------------------------------------------------
sce_citeseq <- DEgenes(sce_citeseq,
                       altExp_name = "ADT", 
                       group = sce_citeseq$SNF_W_louvain,
                       return_all = TRUE,
                       exprs_pct = 0.5)


sce_citeseq <- selectDEgenes(sce_citeseq,
                             altExp_name = "ADT")
datatable(format(do.call(rbind, metadata(sce_citeseq)[["DE_res_ADT_filter"]]), 
                 digits = 2))

## ----fig.height = 10, fig.width = 10------------------------------------------
rna_DEgenes <- metadata(sce_citeseq)[["DE_res_RNA_filter"]]
adt_DEgenes <- metadata(sce_citeseq)[["DE_res_ADT_filter"]]

rna_DEgenes <- lapply(rna_DEgenes, function(x){
  x$name <- gsub("hg19_", "", x$name)
  x})
DEbubblePlot(list(RNA = rna_DEgenes, ADT = adt_DEgenes))

## ----fig.height = 8, fig.width = 8--------------------------------------------
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

## ----fig.height = 8, fig.width = 8--------------------------------------------
set.seed(2020)
sce_citeseq <- importanceADT(sce_citeseq, 
                             group = sce_citeseq$SNF_W_louvain,
                             subsample = TRUE)

visImportance(sce_citeseq, plot = "boxplot")
visImportance(sce_citeseq, plot = "heatmap")

sort(metadata(sce_citeseq)[["importanceADT"]], decreasing = TRUE)[1:20]

## -----------------------------------------------------------------------------
subset_adt <- names(which(metadata(sce_citeseq)[["importanceADT"]] > 5))
subset_adt

system.time(sce_citeseq <- CiteFuse(sce_citeseq,
                                    ADT_subset = subset_adt,
                                    metadata_names = c("W_SNF_adtSubset1",
                                                       "W_ADT_adtSubset1",
                                                       "W_RNA")))

SNF_W_clust_adtSubset1 <- spectralClustering(metadata(sce_citeseq)[["W_SNF_adtSubset1"]], K = 5)
sce_citeseq$SNF_W_clust_adtSubset1 <- as.factor(SNF_W_clust_adtSubset1$labels)


library(mclust)
adjustedRandIndex(sce_citeseq$SNF_W_clust_adtSubset1, sce_citeseq$SNF_W_clust)

## ----fig.height = 8, fig.width = 8--------------------------------------------
RNA_feature_subset <- unique(as.character(unlist(lapply(rna_DEgenes_all, "[[", "name"))))
ADT_feature_subset <- unique(as.character(unlist(lapply(adt_DEgenes_all, "[[", "name"))))

geneADTnetwork(sce_citeseq,
               RNA_feature_subset = RNA_feature_subset,
               ADT_feature_subset = ADT_feature_subset,
               cor_method = "pearson",
               network_layout = igraph::layout_with_fr)

## -----------------------------------------------------------------------------
data("lr_pair_subset", package = "CiteFuse")
head(lr_pair_subset)

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

## ----fig.height=10, fig.width=8-----------------------------------------------
visLigandReceptor(sce_citeseq, 
                  type = "pval_heatmap",
                  receptor_type = "ADT")

## ----fig.height=12, fig.width=6-----------------------------------------------
visLigandReceptor(sce_citeseq, 
                  type = "pval_dotplot",
                  receptor_type = "ADT")

## ----fig.height=8, fig.width=8------------------------------------------------
visLigandReceptor(sce_citeseq, 
                  type = "group_network",
                  receptor_type = "ADT")

## ----fig.height=8, fig.width=8------------------------------------------------
visLigandReceptor(sce_citeseq, 
                  type = "group_heatmap",
                  receptor_type = "ADT")

## ----fig.height=8, fig.width=8------------------------------------------------
visLigandReceptor(sce_citeseq,
                  type = "lr_network",
                  receptor_type = "ADT")

## -----------------------------------------------------------------------------
data("sce_ctcl_subset", package = "CiteFuse")

## -----------------------------------------------------------------------------

visualiseExprsList(sce_list = list(control = sce_citeseq,
                                   ctcl = sce_ctcl_subset),
                   plot = "boxplot",
                   altExp_name = "none",
                   exprs_value = "logcounts",
                   feature_subset = c("hg19_S100A10", "hg19_CD8A"),
                   group_by = c("SNF_W_louvain", "SNF_W_louvain"))

visualiseExprsList(sce_list = list(control = sce_citeseq,
                                   ctcl = sce_ctcl_subset),
                   plot = "boxplot",
                   altExp_name = "ADT", 
                   feature_subset = c("CD19", "CD8"),
                   group_by = c("SNF_W_louvain", "SNF_W_louvain"))

## -----------------------------------------------------------------------------
de_res <- DEgenesCross(sce_list = list(control = sce_citeseq,
                                       ctcl = sce_ctcl_subset),
                       colData_name = c("SNF_W_louvain", "SNF_W_louvain"),
                       group_to_test = c("2", "6"))
de_res_filter <- selectDEgenes(de_res = de_res)
de_res_filter

## ----eval = FALSE-------------------------------------------------------------
# tmpdir <- tempdir()
# download.file("http://cf.10xgenomics.com/samples/cell-exp/3.1.0/connect_5k_pbmc_NGSC3_ch1/connect_5k_pbmc_NGSC3_ch1_filtered_feature_bc_matrix.tar.gz", file.path(tmpdir, "/5k_pbmc_NGSC3_ch1_filtered_feature_bc_matrix.tar.gz"))
# untar(file.path(tmpdir, "5k_pbmc_NGSC3_ch1_filtered_feature_bc_matrix.tar.gz"),
#       exdir = tmpdir)
# sce_citeseq_10X <- readFrom10X(file.path(tmpdir, "filtered_feature_bc_matrix/"))
# sce_citeseq_10X

## -----------------------------------------------------------------------------
sessionInfo()

