# Code example from 'ASURAT' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message = FALSE, warning = FALSE-----------------------------------------
library(ASURAT)
library(SingleCellExperiment)
library(SummarizedExperiment)

## ----eval = FALSE-------------------------------------------------------------
# mat <- as.matrix(assay(sce, "logcounts"))
# assay(sce, "centered") <- sweep(mat, 1, apply(mat, 1, mean), FUN = "-")

## ----message = FALSE----------------------------------------------------------
sce <- TENxPBMCData::TENxPBMCData(dataset = c("pbmc4k"))
pbmc_counts <- as.matrix(assay(sce, "counts"))
rownames(pbmc_counts) <- make.unique(rowData(sce)$Symbol_TENx)
colnames(pbmc_counts) <- make.unique(colData(sce)$Barcode)

## -----------------------------------------------------------------------------
pbmc_counts[1:5, 1:3]

## -----------------------------------------------------------------------------
pbmc <- SingleCellExperiment(assays = list(counts = pbmc_counts),
                             rowData = data.frame(gene = rownames(pbmc_counts)),
                             colData = data.frame(cell = colnames(pbmc_counts)))

## -----------------------------------------------------------------------------
dim(pbmc)

## -----------------------------------------------------------------------------
pbmc <- add_metadata(sce = pbmc, mitochondria_symbol = "^MT-")

## -----------------------------------------------------------------------------
pbmc <- remove_variables(sce = pbmc, min_nsamples = 10)

## -----------------------------------------------------------------------------
df <- data.frame(x = colData(pbmc)$nReads, y = colData(pbmc)$nGenes)
ggplot2::ggplot() +
  ggplot2::geom_point(ggplot2::aes(x = df$x, y = df$y), size = 1, alpha = 1) +
  ggplot2::labs(x = "Number of reads", y = "Number of genes") +
  ggplot2::theme_classic(base_size = 20)

## -----------------------------------------------------------------------------
df <- data.frame(x = colData(pbmc)$nReads, y = colData(pbmc)$percMT)
ggplot2::ggplot() +
  ggplot2::geom_point(ggplot2::aes(x = df$x, y = df$y), size = 1, alpha = 1) +
  ggplot2::labs(x = "Number of reads", y = "Perc of MT reads") +
  ggplot2::theme_classic(base_size = 20)

## -----------------------------------------------------------------------------
pbmc <- remove_samples(sce = pbmc, min_nReads = 5000, max_nReads = 20000,
                       min_nGenes = 100, max_nGenes = 1e+10,
                       min_percMT = 0, max_percMT = 10)

## -----------------------------------------------------------------------------
df <- data.frame(x = 1:nrow(rowData(pbmc)),
                 y = sort(rowData(pbmc)$nSamples, decreasing = TRUE))
ggplot2::ggplot() + ggplot2::scale_y_log10() +
  ggplot2::geom_point(ggplot2::aes(x = df$x, y = df$y), size = 1, alpha = 1) +
  ggplot2::labs(x = "Rank of genes", y = "Mean read counts") +
  ggplot2::theme_classic(base_size = 20)

## -----------------------------------------------------------------------------
pbmc <- remove_variables_second(sce = pbmc, min_meannReads = 0.05)

## -----------------------------------------------------------------------------
assay(pbmc, "logcounts") <- log(assay(pbmc, "counts") + 1)

## -----------------------------------------------------------------------------
mat <- assay(pbmc, "logcounts")
assay(pbmc, "centered") <- sweep(mat, 1, apply(mat, 1, mean), FUN = "-")

## -----------------------------------------------------------------------------
sname <- "logcounts"
altExp(pbmc, sname) <- SummarizedExperiment(list(counts = assay(pbmc, sname)))

## ----message = FALSE----------------------------------------------------------
dictionary <- AnnotationDbi::select(org.Hs.eg.db::org.Hs.eg.db,
                                    key = rownames(pbmc),
                                    columns = "ENTREZID", keytype = "SYMBOL")
dictionary <- dictionary[!duplicated(dictionary$SYMBOL), ]
rowData(pbmc)$geneID <- dictionary$ENTREZID

## -----------------------------------------------------------------------------
set.seed(1)
nrand_samples <- 1000
mat <- t(as.matrix(assay(pbmc, "centered")))
ids <- sample(rownames(mat), nrand_samples, prob = NULL)
cormat <- cor(mat[ids, ], method = "spearman")

## -----------------------------------------------------------------------------
urlpath <- "https://github.com/keita-iida/ASURATDB/blob/main/genes2bioterm/"
load(url(paste0(urlpath, "20201213_human_CO.rda?raw=TRUE")))         # CO
load(url(paste0(urlpath, "20220308_human_MSigDB.rda?raw=TRUE")))     # MSigDB
load(url(paste0(urlpath, "20201213_human_GO_red.rda?raw=TRUE")))     # GO
load(url(paste0(urlpath, "20201213_human_KEGG.rda?raw=TRUE")))       # KEGG

## -----------------------------------------------------------------------------
d <- list(human_CO[["cell"]], human_MSigDB[["cell"]])
res <- do.call("rbind", d)
human_CB <- list(cell = res)

## -----------------------------------------------------------------------------
pbmcs <- list(CB = pbmc, GO = pbmc, KG = pbmc)
metadata(pbmcs$CB) <- list(sign = human_CB[["cell"]])
metadata(pbmcs$GO) <- list(sign = human_GO[["BP"]])
metadata(pbmcs$KG) <- list(sign = human_KEGG[["pathway"]])

## -----------------------------------------------------------------------------
pbmcs$CB <- remove_signs(sce = pbmcs$CB, min_ngenes = 2, max_ngenes = 1000)
pbmcs$GO <- remove_signs(sce = pbmcs$GO, min_ngenes = 2, max_ngenes = 1000)
pbmcs$KG <- remove_signs(sce = pbmcs$KG, min_ngenes = 2, max_ngenes = 1000)

## -----------------------------------------------------------------------------
set.seed(1)
pbmcs$CB <- cluster_genesets(sce = pbmcs$CB, cormat = cormat,
                             th_posi = 0.30, th_nega = -0.30)
set.seed(1)
pbmcs$GO <- cluster_genesets(sce = pbmcs$GO, cormat = cormat,
                             th_posi = 0.30, th_nega = -0.30)
set.seed(1)
pbmcs$KG <- cluster_genesets(sce = pbmcs$KG, cormat = cormat,
                             th_posi = 0.20, th_nega = -0.20)

## -----------------------------------------------------------------------------
pbmcs$CB <- create_signs(sce = pbmcs$CB, min_cnt_strg = 2, min_cnt_vari = 2)
pbmcs$GO <- create_signs(sce = pbmcs$GO, min_cnt_strg = 4, min_cnt_vari = 4)
pbmcs$KG <- create_signs(sce = pbmcs$KG, min_cnt_strg = 3, min_cnt_vari = 3)

## -----------------------------------------------------------------------------
pbmcs$GO <- remove_signs_redundant(sce = pbmcs$GO,
                                   similarity_matrix = human_GO$similarity_matrix$BP,
                                   threshold = 0.70, keep_rareID = TRUE)

## -----------------------------------------------------------------------------
keywords <- "Covid|COVID"
pbmcs$KG <- remove_signs_manually(sce = pbmcs$KG, keywords = keywords)

## ----eval = FALSE-------------------------------------------------------------
# keywords <- "cell|cyte"
# test <- select_signs_manually(sce = pbmcs$CB, keywords = keywords)

## -----------------------------------------------------------------------------
pbmcs$CB <- makeSignMatrix(sce = pbmcs$CB, weight_strg = 0.5, weight_vari = 0.5)
pbmcs$GO <- makeSignMatrix(sce = pbmcs$GO, weight_strg = 0.5, weight_vari = 0.5)
pbmcs$KG <- makeSignMatrix(sce = pbmcs$KG, weight_strg = 0.5, weight_vari = 0.5)

## -----------------------------------------------------------------------------
rbind(head(assay(pbmcs$CB, "counts")[, 1:3], n = 4),
      tail(assay(pbmcs$CB, "counts")[, 1:3], n = 4))

## -----------------------------------------------------------------------------
pca_dims <- c(30, 30, 50)
tsne_dims <- c(2, 2, 3)
for(i in seq_along(pbmcs)){
  set.seed(1)
  mat <- t(as.matrix(assay(pbmcs[[i]], "counts")))
  res <- Rtsne::Rtsne(mat, dim = tsne_dims[i], pca = TRUE,
                      initial_dims = pca_dims[i])
  reducedDim(pbmcs[[i]], "TSNE") <- res[["Y"]]
}

## -----------------------------------------------------------------------------
df <- as.data.frame(reducedDim(pbmcs$CB, "TSNE"))
ggplot2::ggplot() + ggplot2::geom_point(ggplot2::aes(x = df[, 1], y = df[, 2]),
                                        color = "black", size = 1, alpha = 1) +
  ggplot2::labs(title = "PBMC (cell type)", x = "tSNE_1", y = "tSNE_2") +
  ggplot2::theme_classic(base_size = 15)

## -----------------------------------------------------------------------------
df <- as.data.frame(reducedDim(pbmcs$GO, "TSNE"))
ggplot2::ggplot() + ggplot2::geom_point(ggplot2::aes(x = df[, 1], y = df[, 2]),
                                        color = "black", size = 1, alpha = 1) +
  ggplot2::labs(title = "PBMC (function)", x = "tSNE_1", y = "tSNE_2") +
  ggplot2::theme_classic(base_size = 15)

## -----------------------------------------------------------------------------
df <- as.data.frame(reducedDim(pbmcs$KG, "TSNE"))
plot_dataframe3D(dataframe3D = df, theta = 45, phi = 30, title = "PBMC (pathway)",
                 xlabel = "tSNE_1", ylabel = "tSNE_2", zlabel = "tSNE_3")

## ----message = FALSE, warning = FALSE, results = "hide"-----------------------
resolutions <- c(0.20, 0.20, 0.10)
ds <- list(seq_len(20), seq_len(20), seq_len(20))
for(i in seq_along(pbmcs)){
  surt <- Seurat::as.Seurat(pbmcs[[i]], counts = "counts", data = "counts")
  mat <- as.matrix(assay(pbmcs[[i]], "counts"))
  surt[["SSM"]] <- Seurat::CreateAssayObject(counts = mat)
  Seurat::DefaultAssay(surt) <- "SSM"
  surt <- Seurat::ScaleData(surt, features = rownames(surt))
  surt <- Seurat::RunPCA(surt, features = rownames(surt))
  surt <- Seurat::FindNeighbors(surt, reduction = "pca", dims = ds[[i]])
  surt <- Seurat::FindClusters(surt, resolution = resolutions[i])
  temp <- Seurat::as.SingleCellExperiment(surt)
  colData(pbmcs[[i]])$seurat_clusters <- colData(temp)$seurat_clusters
}

## -----------------------------------------------------------------------------
labels <- colData(pbmcs$CB)$seurat_clusters
df <- as.data.frame(reducedDim(pbmcs$CB, "TSNE"))
ggplot2::ggplot() +
  ggplot2::geom_point(ggplot2::aes(x = df[, 1], y = df[, 2], color = labels),
                      size = 1, alpha = 1) +
  ggplot2::labs(title = "PBMC (cell type)", x = "tSNE_1", y = "tSNE_2", color = "") +
  ggplot2::theme_classic(base_size = 15) + ggplot2::scale_colour_hue() +
  ggplot2::guides(colour = ggplot2::guide_legend(override.aes = list(size = 4)))

## -----------------------------------------------------------------------------
labels <- colData(pbmcs$GO)$seurat_clusters
df <- as.data.frame(reducedDim(pbmcs$GO, "TSNE"))
ggplot2::ggplot() +
  ggplot2::geom_point(ggplot2::aes(x = df[, 1], y = df[, 2], color = labels),
                      size = 1, alpha = 1) +
  ggplot2::labs(title = "PBMC (function)", x = "tSNE_1", y = "tSNE_2", color = "") +
  ggplot2::theme_classic(base_size = 15) +
  ggplot2::scale_colour_brewer(palette = "Set1") +
  ggplot2::guides(colour = ggplot2::guide_legend(override.aes = list(size = 4)))

## -----------------------------------------------------------------------------
labels <- colData(pbmcs$KG)$seurat_clusters
colors <- scales::brewer_pal(palette = "Set2")(length(unique(labels)))[labels]
df <- as.data.frame(reducedDim(pbmcs$KG, "TSNE")[, seq_len(3)])
plot_dataframe3D(dataframe3D = df, labels = labels, colors = colors,
                 theta = 45, phi = 30, title = "PBMC (pathway)",
                 xlabel = "tSNE_1", ylabel = "tSNE_2", zlabel = "tSNE_3")

## ----message = FALSE, warning = FALSE-----------------------------------------
surt <- Seurat::as.Seurat(pbmcs$CB, counts = "counts", data = "counts")
mat <- as.matrix(assay(altExp(pbmcs$CB), "counts"))
surt[["GEM"]] <- Seurat::CreateAssayObject(counts = mat)
Seurat::DefaultAssay(surt) <- "GEM"
surt <- Seurat::ScaleData(surt, features = rownames(surt))
surt <- Seurat::RunPCA(surt, features = rownames(surt))
surt <- Seurat::CellCycleScoring(surt, s.features = Seurat::cc.genes$s.genes,
                                 g2m.features = Seurat::cc.genes$g2m.genes)
temp <- Seurat::as.SingleCellExperiment(surt)
colData(pbmcs$CB)$Phase <- colData(temp)$Phase

## ----message = FALSE, results = "hide"----------------------------------------
for(i in seq_along(pbmcs)){
  set.seed(1)
  labels <- colData(pbmcs[[i]])$seurat_clusters
  pbmcs[[i]] <- compute_sepI_all(sce = pbmcs[[i]], labels = labels,
                                 nrand_samples = 200)
}

## ----message = FALSE----------------------------------------------------------
set.seed(1)
surt <- Seurat::as.Seurat(pbmcs$CB, counts = "counts", data = "counts")
mat <- as.matrix(assay(altExp(pbmcs$CB), "counts"))
surt[["GEM"]] <- Seurat::CreateAssayObject(counts = mat)
Seurat::DefaultAssay(surt) <- "GEM"
surt <- Seurat::SetIdent(surt, value = "seurat_clusters")
res <- Seurat::FindAllMarkers(surt, only.pos = TRUE,
                              min.pct = 0.50, logfc.threshold = 0.50)
metadata(pbmcs$CB)$marker_genes$all <- res

## -----------------------------------------------------------------------------
# Significant signs
marker_signs <- list()
keywords <- "MESENCHYMAL|LIMB|PANCREAS"
for(i in seq_along(pbmcs)){
  marker_signs[[i]] <- metadata(pbmcs[[i]])$marker_signs$all
  marker_signs[[i]] <-
    marker_signs[[i]][!grepl(keywords, marker_signs[[i]]$Description), ]
  marker_signs[[i]] <- dplyr::group_by(marker_signs[[i]], Ident_1)
  marker_signs[[i]] <- dplyr::slice_max(marker_signs[[i]], sepI, n = 2)
  marker_signs[[i]] <- dplyr::slice_min(marker_signs[[i]], Rank, n = 1)
}
# Significant genes
marker_genes_CB <- metadata(pbmcs$CB)$marker_genes$all
marker_genes_CB <- dplyr::group_by(marker_genes_CB, cluster)
marker_genes_CB <- dplyr::slice_min(marker_genes_CB, p_val_adj, n = 2)
marker_genes_CB <- dplyr::slice_max(marker_genes_CB, avg_log2FC, n = 1)

## -----------------------------------------------------------------------------
# ssm_list
sces_sub <- list() ; ssm_list <- list()
for(i in seq_along(pbmcs)){
  sces_sub[[i]] <- pbmcs[[i]][rownames(pbmcs[[i]]) %in% marker_signs[[i]]$SignID, ]
  ssm_list[[i]] <- assay(sces_sub[[i]], "counts")
}
names(ssm_list) <- c("SSM_cell", "SSM_function", "SSM_pathway")
# gem_list
expr_sub <- altExp(pbmcs$CB, "logcounts")
expr_sub <- expr_sub[rownames(expr_sub) %in% marker_genes_CB$gene]
gem_list <- list(GeneExpr = assay(expr_sub, "counts"))
# ssmlabel_list
labels <- list() ; ssmlabel_list <- list()
for(i in seq_along(pbmcs)){
  tmp <- colData(sces_sub[[i]])$seurat_clusters
  labels[[i]] <- data.frame(label = tmp)
  n_groups <- length(unique(tmp))
  if(i == 1){
    labels[[i]]$color <- scales::hue_pal()(n_groups)[tmp]
  }else if(i == 2){
    labels[[i]]$color <- scales::brewer_pal(palette = "Set1")(n_groups)[tmp]
  }else if(i == 3){
    labels[[i]]$color <- scales::brewer_pal(palette = "Set2")(n_groups)[tmp]
  }
  ssmlabel_list[[i]] <- labels[[i]]
}
names(ssmlabel_list) <- c("Label_cell", "Label_function", "Label_pathway")
# gemlabel_list
label_CC <- data.frame(label = colData(pbmcs$CB)$Phase, color = NA)
gemlabel_list <- list(CellCycle = label_CC)

## ----message = FALSE, warning = FALSE-----------------------------------------
set.seed(1)
plot_multiheatmaps(ssm_list = ssm_list, gem_list = gem_list,
                   ssmlabel_list = ssmlabel_list, gemlabel_list = gemlabel_list,
                   nrand_samples = 100, show_row_names = TRUE, title = "PBMC")

## -----------------------------------------------------------------------------
labels <- colData(pbmcs$CB)$seurat_clusters
variable <- "GO:0042100-V"
description <- "B cell proliferation"
subsce <- pbmcs$GO[which(rownames(pbmcs$GO) == variable), ]
df <- as.data.frame(t(as.matrix(assay(subsce, "counts"))))
ggplot2::ggplot() +
  ggplot2::geom_violin(ggplot2::aes(x = as.factor(labels), y = df[, 1],
                                    fill = labels), trim = FALSE, size = 0.5) +
  ggplot2::geom_boxplot(ggplot2::aes(x = as.factor(labels), y = df[, 1]),
                        width = 0.15, alpha = 0.6) +
  ggplot2::labs(title = paste0(variable, "\n", description),
                x = "Cluster (cell type)", y = "Sign score") +
  ggplot2::theme_classic(base_size = 20) +
  ggplot2::theme(legend.position = "none") + ggplot2::scale_fill_hue()

## -----------------------------------------------------------------------------
vname <- "CD79A"
sub <- altExp(pbmcs$CB, "logcounts")
sub <- sub[rownames(sub) == vname, ]
labels <- colData(pbmcs$CB)$seurat_clusters
df <- as.data.frame(t(assay(sub, "counts")))
ggplot2::ggplot() +
  ggplot2::geom_violin(ggplot2::aes(x = as.factor(labels), y = df[, 1],
                                    fill = labels), trim = FALSE, size = 0.5) +
  ggplot2::geom_boxplot(ggplot2::aes(x = as.factor(labels), y = df[, 1]),
                        width = 0.15, alpha = 0.6) +
  ggplot2::labs(title = vname, x = "Cluster (cell type)",
                y = "Normalized expression") +
  ggplot2::theme_classic(base_size = 20) +
  ggplot2::theme(legend.position = "none") + ggplot2::scale_fill_hue()

## -----------------------------------------------------------------------------
sessionInfo()

