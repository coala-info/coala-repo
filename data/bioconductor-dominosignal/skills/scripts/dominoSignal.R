# Code example from 'dominoSignal' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    echo = TRUE,
    message = FALSE,
    warning = FALSE,
    fig.cap = "",
    tidy = TRUE
)
options(timeout = 300)

## ----libraries----------------------------------------------------------------
set.seed(42)

library(dominoSignal)
library(SingleCellExperiment)
library(plyr)
library(circlize)
library(ComplexHeatmap)
library(knitr)

## ----files--------------------------------------------------------------------
# BiocFileCache helps with managing files across sessions
bfc <- BiocFileCache::BiocFileCache(ask = FALSE)
data_url <- "https://zenodo.org/records/10951634/files"

# download the reduced pbmc files
# preprocessed PBMC 3K scRNAseq data set as a Seurat object
pbmc_url <- paste0(data_url, "/pbmc3k_sce.rds")
pbmc <- BiocFileCache::bfcrpath(bfc, pbmc_url)

# download scenic results
scenic_auc_url <- paste0(data_url, "/auc_pbmc_3k.csv")
scenic_auc <- BiocFileCache::bfcrpath(bfc, scenic_auc_url)

scenic_regulon_url <- paste0(data_url, "/regulons_pbmc_3k.csv")
scenic_regulon <- BiocFileCache::bfcrpath(bfc, scenic_regulon_url)

# download CellPhoneDB files
cellphone_url <- "https://github.com/ventolab/cellphonedb-data/archive/refs/tags/v4.0.0.tar.gz"
cellphone_tar <- BiocFileCache::bfcrpath(bfc, cellphone_url)
cellphone_dir <- paste0(tempdir(), "/cellphone")
untar(tarfile = cellphone_tar, exdir = cellphone_dir)
cellphone_data <- paste0(cellphone_dir, "/cellphonedb-data-4.0.0/data")


# directory for created inputs to pySCENIC and dominoSignal
input_dir <- paste0(tempdir(), "/inputs")
if (!dir.exists(input_dir)) {
    dir.create(input_dir)
}

## -----------------------------------------------------------------------------
pbmc <- readRDS(pbmc)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)){
#   install.packages("BiocManager")
# }
# 
# BiocManager::install("dominoSignal")

## ----Load SCENIC Results------------------------------------------------------
regulons <- read.csv(scenic_regulon)
auc <- read.table(scenic_auc,
    header = TRUE, row.names = 1,
    stringsAsFactors = FALSE, sep = ","
)

## ----Create Regulon List------------------------------------------------------
regulons <- regulons[-1:-2, ]
colnames(regulons) <- c(
    "TF", "MotifID", "AUC", "NES", "MotifSimilarityQvalue", "OrthologousIdentity",
    "Annotation", "Context", "TargetGenes", "RankAtMax"
)
regulon_list <- create_regulon_list_scenic(regulons = regulons)

## ----Orient AUC Matrix--------------------------------------------------------
auc_in <- as.data.frame(t(auc))
# Remove pattern "..." from the end of all rownames:
rownames(auc_in) <- gsub("\\.\\.\\.$", "", rownames(auc_in))

## ----Load CellPhoneDB Database------------------------------------------------
complexes <- read.csv(
    paste0(
        cellphone_data, "/complex_input.csv"
    ),
    stringsAsFactors = FALSE
)
genes <- read.csv(
    paste0(
        cellphone_data, "/gene_input.csv"
    ),
    stringsAsFactors = FALSE
)
interactions <- read.csv(
    paste0(
        cellphone_data, "/interaction_input.csv"
    ),
    stringsAsFactors = FALSE
)
proteins <- read.csv(
    paste0(
        cellphone_data, "/protein_input.csv"
    ),
    stringsAsFactors = FALSE
)

rl_map <- create_rl_map_cellphonedb(
    genes = genes,
    proteins = proteins,
    interactions = interactions,
    complexes = complexes,
    database_name = "CellPhoneDB_v4.0" # database version used
)

knitr::kable(head(rl_map))

## ----Appending interactions---------------------------------------------------
# Integrin complexes are not annotated as receptors in CellPhoneDB_v4.0
# collagen-integrin interactions between cells may be missed unless tables
# from the CellPhoneDB reference are edited or the interactions are manually added

col_int_df <- data.frame(
    "int_pair" = "a11b1 complex & COLA1_HUMAN",
    "name_A" = "a11b1 complex", "uniprot_A" = "P05556,Q9UKX5", "gene_A" = "ITB1,ITA11", "type_A" = "R",
    "name_B" = "COLA1_HUMAN", "uniprot_B" = "P02452,P08123", "gene_B" = "COL1A1,COL1A2", "type_B" = "L",
    "annotation_strategy" = "manual", "source" = "manual", "database_name" = "manual"
)
rl_map_append <- rbind(col_int_df, rl_map)
knitr::kable(head(rl_map_append))

## ----load cell features-------------------------------------------------------
counts = assay(pbmc, "counts")
logcounts = assay(pbmc, "logcounts")
logcounts = logcounts[rowSums(logcounts) > 0, ]
z_scores = t(scale(t(logcounts)))
clusters = factor(pbmc$cell_type)
names(clusters) = colnames(pbmc)

## ----Create Domino, results='hide', warning=FALSE-----------------------------
pbmc_dom <- create_domino(
    rl_map = rl_map,
    features = auc_in,
    counts = counts,
    z_scores = z_scores,
    clusters = clusters,
    tf_targets = regulon_list,
    use_clusters = TRUE,
    use_complexes = TRUE,
    remove_rec_dropout = FALSE
)
# rl_map: receptor - ligand map data frame
# features: TF activation scores (AUC matrix)
# counts: counts matrix
# z_scores: scaled expression data
# clusters: named vector of cell cluster assignments
# tf_targets: list of TFs and their regulons
# use_clusters: assess receptor activation and ligand expression on a per-cluster basis
# use_complexes: include receptors and genes that function as a complex in results
# remove_rec_dropout: whether to remove zeroes from correlation calculations

## ----Build Domino-------------------------------------------------------------
pbmc_dom <- build_domino(
    dom = pbmc_dom,
    min_tf_pval = .001,
    max_tf_per_clust = 25,
    max_rec_per_tf = 25,
    rec_tf_cor_threshold = .25,
    min_rec_percentage = 0.1
)
# min_tf_pval: Threshold for p-value of DE for TFs
# rec_tf_cor_threshold: Minimum correlation between receptor and TF
# min_rec_percentage: Minimum percent of cells that must express receptor

## ----Build Domino All Significant Interactions, eval=FALSE--------------------
# pbmc_dom_all <- build_domino(
#     dom = pbmc_dom,
#     min_tf_pval = .001,
#     max_tf_per_clust = Inf,
#     max_rec_per_tf = Inf,
#     rec_tf_cor_threshold = .25,
#     min_rec_percentage = 0.1
# )

## -----------------------------------------------------------------------------
feat_heatmap(pbmc_dom,
    norm = TRUE, bool = FALSE, use_raster = FALSE,
    row_names_gp = grid::gpar(fontsize = 4)
)

## -----------------------------------------------------------------------------
signaling_network(pbmc_dom, edge_weight = 0.5, max_thresh = 3)

## -----------------------------------------------------------------------------
gene_network(pbmc_dom, clust = "dendritic_cell", layout = "grid")

## -----------------------------------------------------------------------------
gene_network(pbmc_dom,
    clust = "dendritic_cell", OutgoingSignalingClust = "CD14_monocyte",
    layout = "grid"
)

## ----out.width = "95%"--------------------------------------------------------
incoming_signaling_heatmap(pbmc_dom, rec_clust = "dendritic_cell", max_thresh = 2.5, use_raster = FALSE)

## ----fig.asp = 0.6, out.width = "90%"-----------------------------------------
circos_ligand_receptor(pbmc_dom, receptor = "CD74")

## -----------------------------------------------------------------------------
Sys.Date()
sessionInfo()

