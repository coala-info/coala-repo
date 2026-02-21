# Code example from 'mastR_Demo' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 8,
  fig.height = 5
)

## ----installation, eval=FALSE-------------------------------------------------
# # if (!requireNamespace("devtools", quietly = TRUE)) {
# #   install.packages("devtools")
# # }
# # if (!requireNamespace("mastR", quietly = TRUE)) {
# #   devtools::install_github("DavisLaboratory/mastR")
# # }
# 
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# if (!requireNamespace("mastR", quietly = TRUE)) {
#   BiocManager::install("mastR")
# }
# packages <- c(
#   "BiocStyle",
#   "clusterProfiler",
#   "ComplexHeatmap",
#   "depmap",
#   "enrichplot",
#   "ggrepel",
#   "gridExtra",
#   "jsonlite",
#   "knitr",
#   "rmarkdown",
#   "RobustRankAggreg",
#   "rvest",
#   "singscore",
#   "UpSetR"
# )
# for (i in packages) {
#   if (!requireNamespace(i, quietly = TRUE)) {
#     install.packages(i)
#   }
#   if (!requireNamespace(i, quietly = TRUE)) {
#     BiocManager::install(i)
#   }
# }

## ----lib, message=FALSE-------------------------------------------------------
library(mastR)
library(edgeR)
library(ggplot2)
library(GSEABase)

## ----LM markers---------------------------------------------------------------
data("lm7", "lm22")

## collect both LM7 and LM22
LM <- get_lm_sig(lm7.pattern = "^NK", lm22.pattern = "NK cells")
LM

## ----gsc plot-----------------------------------------------------------------
## show upset diagram
gsc_plot(LM)

## ----MSigDB gene sets, warning=FALSE------------------------------------------
data("msigdb_gobp_nk")
MSig <- get_gsc_sig(
  gsc = msigdb_gobp_nk,
  pattern = "NATURAL_KILLER_CELL_MEDIATED"
)
MSig

## ----show overlap, warning=FALSE----------------------------------------------
## cut gene set name within 11 characters
gsn <- setNames(names(MSig), LETTERS[seq_along(MSig)])
for (i in seq_along(MSig)) {
  setName(MSig[[i]]) <- LETTERS[i]
}

## show upset diagram of collected gene-sets
gsc_plot(MSig)
gsn[c("A", "M", "D")] ## show gene-set names of top 3

## ----merge MSigDB-------------------------------------------------------------
## merge all gene sets into one
MSig <- merge_markers(MSig)
setName(MSig) <- "MSigDB"

## ----PanglaoDB markers, eval=FALSE--------------------------------------------
# ## show available organs on PanglaoDB
# list_panglao_organs()
# 
# ## show available cell types of interest organ on PanglaoDB
# list_panglao_types(organ = "Immune system")
# 
# ## collect all "NK cells" markers from PanglaoDB website
# Panglao <- get_panglao_sig(type = "NK cells")
# 
# Panglao

## ----nk_markers---------------------------------------------------------------
## show what nk_markers looks like:
data("nk_markers")
nk_markers

## convert NK markers into `GeneSet` object
nk_m <- GeneSet(nk_markers$HGNC_Symbol,
  geneIdType = SymbolIdentifier(),
  setName = "NK_markers"
)

## ----integrate markers--------------------------------------------------------
gsc <- GeneSetCollection(c(nk_m, LM, MSig)) ## add Panglao if you run it
Markers <- merge_markers(gsc)

## upset plot
gsc_plot(gsc)

Markers

## ----source table-------------------------------------------------------------
## to show the table summary of merged list
head(jsonlite::fromJSON(GSEABase::longDescription(Markers)))

## ----im_data_6----------------------------------------------------------------
data("im_data_6")
im_data_6

## ----type names---------------------------------------------------------------
table(im_data_6$`celltype:ch1`)

## ----process data-------------------------------------------------------------
proc_data <- process_data(
  data = im_data_6,
  group_col = "celltype:ch1",
  target_group = "NK",
  markers = geneIds(Markers),
  gene_id = "ENSEMBL" ## rownames of im_data_6 is ENSEMBL ID
)

attributes(proc_data)

## ----save voom E--------------------------------------------------------------
## add voom fitted expression as a new list of proc_data for use
proc_data$voomE <- proc_data$vfit$E

## ----select sig---------------------------------------------------------------
## get the same result as there's permutation test for rank product
set.seed(123)
sig_ct <- select_sig(proc_data, feature_selection = "auto")

head(sig_ct)

## ----markers for cell type, fig.width=8, fig.height=6-------------------------
## convert ensembl IDs into symbols to match markers pool
deg_up <- mapIds(
  org.Hs.eg.db::org.Hs.eg.db,
  geneIds(sig_ct[["UP"]]),
  "SYMBOL", "ENSEMBL"
)
deg_up <- na.omit(deg_up)
## markers specific for NK cells
m_ct <- intersect(geneIds(Markers), deg_up)
names(m_ct) <- names(deg_up)[match(m_ct, deg_up)] ## set ensembl ID as names for downstream visualization

head(m_ct)

## ----PCA on sig---------------------------------------------------------------
## PCA shows clear separation of NK cells
## after intersection
pca_matrix_plot(proc_data,
  features = m_ct,
  group_by = "celltype.ch1",
  slot = "voomE",
  n = 3,
  gene_id = "ENSEMBL"
) +
  patchwork::plot_annotation("Intersected UP DEGs")
## before intersection
pca_matrix_plot(proc_data,
  features = as.vector(deg_up),
  group_by = "celltype.ch1",
  slot = "voomE",
  n = 3,
  gene_id = "ENSEMBL"
) +
  patchwork::plot_annotation("All UP DEGs")

## ----subset customized bg data------------------------------------------------
data("ccle_crc_5")

## subset CRC cell lines of bg data
bg_mat <- ccle_crc_5$counts[, ccle_crc_5$samples$cancer == "CRC"]
## subset all NK cells of sig data
sig_mat <- proc_data$voomE[, proc_data$samples$celltype.ch1 == "NK"]

## ----bg data filtration-------------------------------------------------------
keep <- rowSums(bg_mat > 1, na.rm = TRUE) > 2
bg_mat <- bg_mat[keep, ]

## ----remove bg in customized--------------------------------------------------
m_ccl <- remove_bg_exp_mat(
  sig_mat = sig_mat,
  bg_mat = bg_mat,
  markers = geneIds(Markers),
  gene_id = c("ENSEMBL", "SYMBOL")
)

head(m_ccl)

## ----ccle construction--------------------------------------------------------
ccle <- data.frame(ccle_crc_5$counts,
  gene_name = rownames(ccle_crc_5),
  primary_disease = "CRC"
) |>
  tidyr::pivot_longer(-c(gene_name, primary_disease),
    names_to = "depmap_id",
    values_to = "rna_expression"
  )

ccle

## ----subset sig and bg data---------------------------------------------------
## subset CRC cell lines of bg data
ccle <- ccle[ccle$primary_disease == "CRC", ]

## ----ccle to wide mat---------------------------------------------------------
ccle <- ccle_2_wide(ccle = ccle)

ccle[1:3, 1:3]

## ----ccle filtration----------------------------------------------------------
keep <- rowSums(ccle > 1, na.rm = TRUE) > 2
ccle <- ccle[keep, ]

## ----remove bg in ccle--------------------------------------------------------
m_ccl <- remove_bg_exp_mat(
  sig_mat = sig_mat,
  bg_mat = ccle,
  markers = geneIds(Markers),
  gene_id = c("ENSEMBL", "SYMBOL")
)

head(m_ccl)

## ----final signatures---------------------------------------------------------
sig_NK_CRC <- intersect(m_ct, m_ccl)
head(sig_NK_CRC)

## ----heatmap, warning=FALSE, fig.width=10, fig.height=7-----------------------
sig_heatmap(
  data = proc_data,
  sigs = sig_NK_CRC,
  group_col = "celltype.ch1",
  markers = geneIds(Markers),
  gene_id = "ENSEMBL",
  slot = "voomE",
  scale = "row",
  show_column_den = FALSE,
  show_row_den = FALSE,
  show_column_names = FALSE,
  show_row_names = FALSE
)

## ----score boxplot, warning=FALSE---------------------------------------------
sig_boxplot(
  data = proc_data,
  sigs = sig_NK_CRC,
  group_col = "celltype.ch1",
  target_group = "NK",
  gene_id = "ENSEMBL",
  slot = "voomE"
)

## ----abundance scatter plot, warning=FALSE, fig.width=8, fig.height=5---------
## before refinement
sig_scatter_plot(
  data = proc_data,
  sigs = geneIds(Markers),
  group_col = "celltype.ch1",
  target_group = "NK",
  gene_id = "ENSEMBL",
  slot = "voomE"
) + ggtitle("Before Refinement")

## after refinement
sig_scatter_plot(
  data = proc_data,
  sigs = sig_NK_CRC,
  group_col = "celltype.ch1",
  target_group = "NK",
  gene_id = "ENSEMBL",
  slot = "voomE"
) + ggtitle("After Refinement")

## ----gseaplot, warning=FALSE, message=FALSE, fig.width=10, fig.height=7-------
## gseaplot
sig_gseaplot(
  data = proc_data,
  sigs = list(sig = sig_NK_CRC, markers = geneIds(Markers)),
  group_col = "celltype.ch1",
  target_group = "NK",
  gene_id = "ENSEMBL",
  slot = "voomE",
  method = "gseaplot"
)

## ----refine multiple datasets, eval=TRUE--------------------------------------
## In the demo, we just repeatedly use im_data_6 as a show case
set.seed(123)
m_ct_m <- filter_subset_sig(
  data = list(A = im_data_6, B = im_data_6),
  markers = geneIds(Markers),
  group_col = "celltype:ch1",
  target_group = "NK",
  feature_selection = "auto",
  dir = "UP", ## specify to keep "UP" or "DOWN" regulated genes
  gene_id = "ENSEMBL",
  comb = union,
  summary = FALSE
)

## ----union sig, eval=TRUE-----------------------------------------------------
## we will get exactly the same list
## if we choose 'union' or 'intersect' as combination
setequal(m_ct_m, m_ct)

## ----rra sig, eval=TRUE-------------------------------------------------------
## but we will only get the genes appear at top rank across gene lists
## if we choose 'RRA', s_thres is to determine the threshold for ranking score
set.seed(123)
m_ct_m <- filter_subset_sig(
  data = list(A = im_data_6, B = im_data_6),
  markers = geneIds(Markers),
  group_col = "celltype:ch1",
  target_group = "NK",
  feature_selection = "auto",
  dir = "UP", ## specify to keep "UP" or "DOWN" regulated genes
  gene_id = "ENSEMBL",
  comb = "RRA", ## change this to use different strategy, default is "union"
  s_thres = 0.5, ## only work when comb = "RRA", set a threshold for ranking score
  summary = FALSE
)

## fewer signature genes this time
m_ct_m

## ----pseudo-bulk, eval=TRUE---------------------------------------------------
## create a test scRNA object of 100 genes x 100 cells
counts <- matrix(abs(rpois(10000, 10)), 100)
rownames(counts) <- 1:100
colnames(counts) <- 1:100
meta <- data.frame(
  subset = rep(c("A", "B"), 50),
  level = rep(1:4, each = 25)
)
rownames(meta) <- 1:100
pb <- pseudo_samples(counts, by = meta)

pb <- edgeR::DGEList(counts = pb, group = gsub("\\..*", "", colnames(pb)))

filter_subset_sig(pb, group_col = "group", target_group = "A")

## Seurat or SCE object are also accepted
# scRNA <- SeuratObject::CreateSeuratObject(counts = counts, meta.data = meta)
# pseudo_samples(scRNA, by = c("subset","level"))

## ----simulation, include=FALSE, eval=TRUE-------------------------------------
if (!requireNamespace("splatter", quietly = TRUE)) {
  # BiocManager::install("splatter")
  stop("Install 'splatter'!")
}

library(splatter)
## set seed for reproduce as there's permutation inside
set.seed(123)

sim_params <- newSplatParams(
  nGenes = 1e3,
  batchCells = 3000,
  group.prob = seq(0.1, 0.4, length.out = 4),
  de.prob = 0.02,
  # de.downProb = 0,  ## only set up-regulated genes for each group
  de.facLoc = 0.5,
  de.facScale = 0.4
)

data_sim <- splatSimulate(sim_params, method = "groups")

## ----get markers list, eval=TRUE----------------------------------------------
markers_list <- lapply(
  rowData(data_sim)[, paste0("DEFacGroup", 1:4)],
  \(x) rownames(data_sim[x > 1])
)

## ----pseudo bulking, eval=TRUE------------------------------------------------
## aggregate into pseudo-bulk samples
pb <- pseudo_samples(data_sim,
  by = c("Batch", "Group"),
  min.cells = 50, max.cells = 100
)
dge <- edgeR::DGEList(
  counts = pb,
  samples = data.frame(
    group = gsub(".*\\.(.*)_.*", "\\1", colnames(pb)),
    Batch = gsub("(.*)\\..*", "\\1", colnames(pb)),
    sampleID = gsub("(.*)_.*", "\\1", colnames(pb))
  )
)

## ----get sigs, eval=TRUE------------------------------------------------------
set.seed(123)
sig_ls <- lapply(paste0("Group", 1:4), \(x) {
  filter_subset_sig(
    data = dge,
    markers = NULL,
    group_col = "group",
    target_group = x
  )
})
names(sig_ls) <- paste0("Group", 1:4)

## ----venn plot, eval=TRUE-----------------------------------------------------
if (!requireNamespace("ggvenn", quietly = TRUE)) {
  # install.packages("ggvenn")
  stop("Install 'ggvenn'!")
}

## venn plot
p <- lapply(1:4, \(i) ggvenn::ggvenn(
  list(
    sig = sig_ls[[i]],
    marker = markers_list[[i]]
  ),
  show_percentage = FALSE
) +
  ggtitle(names(sig_ls)[i]))
patchwork::wrap_plots(p)

## ----app heatmap, eval=TRUE---------------------------------------------------
## heatmap
sig_heatmap(
  edgeR::cpm(dge, log = TRUE),
  sigs = c(sig_ls, list("TP53")), ## add a real gene to pass gene check
  group_col = dge$samples$group,
  scale = "row",
  show_column_den = FALSE,
  show_row_den = FALSE,
  cluster_column_slices = FALSE,
  cluster_row_slices = FALSE
)

## ----random pseudo-bulk, include=FALSE, eval=TRUE-----------------------------
library(dplyr)
## randomly generate aggregating idx
set.seed(123)
data_sim$rand_idx <- sample.int(30, ncol(data_sim), replace = TRUE)

## aggregate into pseudo-bulk samples based on rand_idx
pb_r <- pseudo_samples(data_sim, by = c("Batch", "rand_idx"))
dge_r <- edgeR::DGEList(
  counts = pb_r,
  samples = data.frame(
    group = gsub(".*\\.(.*)_.*", "\\1", colnames(pb_r)),
    Batch = gsub("(.*)\\..*", "\\1", colnames(pb_r)),
    sampleID = gsub("(.*)_.*", "\\1", colnames(pb_r))
  )
)

## ----add cellular prop, include=FALSE, eval=TRUE------------------------------
library(tidyr)
## append cellular composition
tmp <- as.data.frame(colData(data_sim)) |>
  group_by(rand_idx, Group) |>
  summarise(count = n()) |>
  pivot_wider(names_from = Group, values_from = count) |>
  mutate(rand_idx = factor(rand_idx))
tmp[, -1] <- signif(tmp[, -1] / rowSums(tmp[, -1]), 2)
dge_r$samples <- left_join(dge_r$samples, tmp, by = c("group" = "rand_idx"))

## data process
keep <- filterByExpr(dge_r)
dge_r <- dge_r[keep, , keep.lib.sizes = FALSE]
dge_r <- calcNormFactors(dge_r, method = "TMM")

## ----score on signatures, eval=TRUE-------------------------------------------
library(singscore)

rank_data <- rankGenes(edgeR::cpm(dge_r, log = TRUE))

## score based on sig_ls
scores <- multiScore(rank_data, upSetColc = gls2gsc(sig_ls))

tmp <- pivot_longer(cbind(Sample = colnames(dge_r), dge_r$samples[, 6:9]),
  -Sample,
  names_to = "Group", values_to = "Prop"
)

tmp <- t(scores$Scores) |>
  data.frame(Sample = colnames(scores$Scores)) |>
  pivot_longer(-Sample, names_to = "Group", values_to = "Score") |>
  left_join(tmp)

ggplot(tmp, aes(x = Prop, y = Score, col = Group)) +
  geom_point() +
  facet_wrap(~Group, scales = "free") +
  ggpubr::stat_cor() +
  theme_classic()

## ----score on markers, eval=TRUE----------------------------------------------
## score based on markers_list
scores <- multiScore(rank_data, upSetColc = gls2gsc(markers_list))

tmp <- pivot_longer(cbind(Sample = colnames(dge_r), dge_r$samples[, 6:9]),
  -Sample,
  names_to = "Group", values_to = "Prop"
)
tmp$Group <- paste0("DEFac", tmp$Group)

tmp <- t(scores$Scores) |>
  data.frame(Sample = colnames(scores$Scores)) |>
  pivot_longer(-Sample, names_to = "Group", values_to = "Score") |>
  left_join(tmp)

ggplot(tmp, aes(x = Prop, y = Score, col = Group)) +
  geom_point() +
  facet_wrap(~Group, scales = "free") +
  ggpubr::stat_cor() +
  theme_classic()

## ----deconv, eval=FALSE-------------------------------------------------------
# if (!requireNamespace("BisqueRNA", quietly = TRUE)) {
#   # install.packages("BisqueRNA")
#   stop("Install 'BisqueRNA'!")
# }
# 
# bulk_eset <- ExpressionSet(edgeR::cpm(dge_r, log = TRUE))
# 
# ## deconv on sig_ls
# mark_d <- stack(sig_ls)
# colnames(mark_d) <- c("gene", "cluster")
# 
# res_sig <- BisqueRNA::MarkerBasedDecomposition(
#   bulk.eset = bulk_eset,
#   markers = mark_d
# )
# 
# ## deconv on markers_ls
# mark_d <- stack(markers_list)
# colnames(mark_d) <- c("gene", "cluster")
# 
# res_mar <- BisqueRNA::MarkerBasedDecomposition(
#   bulk.eset = bulk_eset,
#   markers = mark_d
# )
# rownames(res_mar$bulk.props) <- gsub("DEFac", "", rownames(res_mar$bulk.props))

## ----vis deconv sigs, eval=FALSE----------------------------------------------
# tmp <- pivot_longer(cbind(Sample = colnames(dge_r), dge_r$samples[, 6:9]),
#   -Sample,
#   names_to = "Group", values_to = "Prop"
# )
# 
# tmp <- t(res_sig$bulk.props) |>
#   data.frame(Sample = colnames(res_sig$bulk.props)) |>
#   pivot_longer(-Sample, names_to = "Group", values_to = "Estimate") |>
#   left_join(tmp)
# 
# ggplot(tmp, aes(x = Prop, y = Estimate, col = Group)) +
#   geom_point() +
#   facet_wrap(~Group, scales = "free") +
#   ggpubr::stat_cor() +
#   theme_classic()

## ----vis deconv markers, eval=FALSE-------------------------------------------
# tmp <- pivot_longer(cbind(Sample = colnames(dge_r), dge_r$samples[, 6:9]),
#   -Sample,
#   names_to = "Group", values_to = "Prop"
# )
# 
# tmp <- t(res_mar$bulk.props) |>
#   data.frame(Sample = colnames(res_mar$bulk.props)) |>
#   pivot_longer(-Sample, names_to = "Group", values_to = "Estimate") |>
#   left_join(tmp)
# 
# ggplot(tmp, aes(x = Prop, y = Estimate, col = Group)) +
#   geom_point() +
#   facet_wrap(~Group, scales = "free") +
#   ggpubr::stat_cor() +
#   theme_classic()

## ----sig annotation, eval=TRUE------------------------------------------------
if (!requireNamespace("scuttle", quietly = TRUE)) {
  # BiocManager::install("scuttle")
  stop("Install 'scuttle'!")
}
library(singscore)
## normalization
data_sim <- scuttle::computePooledFactors(data_sim, clusters = data_sim$Group)
data_sim <- scuttle::logNormCounts(data_sim)
## use singscore for annotation
rank_data <- rankGenes(logcounts(data_sim))

## score using sig_ls
scores <- multiScore(rank_data, upSetColc = gls2gsc(sig_ls))
data_sim$Pred <- paste0("Group", apply(scores$Scores, 2, which.max))
table(data_sim$Pred == data_sim$Group)

## ----markers annotation, eval=TRUE--------------------------------------------
## score using markers_list
scores <- multiScore(rank_data, upSetColc = gls2gsc(markers_list))
data_sim$Pred <- paste0("Group", apply(scores$Scores, 2, which.max))
table(data_sim$Pred == data_sim$Group)

## ----session info-------------------------------------------------------------
sessionInfo()

