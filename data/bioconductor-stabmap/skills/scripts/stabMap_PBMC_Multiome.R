# Code example from 'stabMap_PBMC_Multiome' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = FALSE
)

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(StabMap)
library(magrittr)

library(scater)
library(scran)
library(SingleCellMultiModal)
library(gridExtra)

## -----------------------------------------------------------------------------
set.seed(2024)

## ----message=FALSE, warning=FALSE---------------------------------------------
mae <- scMultiome(
  "pbmc_10x",
  mode = "*", dry.run = FALSE, format = "MTX", verbose = TRUE
)

## -----------------------------------------------------------------------------
mae

upsetSamples(mae)

head(colData(mae))

dim(experiments(mae)[["rna"]])

names(experiments(mae))

## -----------------------------------------------------------------------------
sce.rna <- experiments(mae)[["rna"]]

# Normalisation
sce.rna <- logNormCounts(sce.rna)

# Feature selection
decomp <- modelGeneVar(sce.rna)
hvgs <- rownames(decomp)[decomp$mean > 0.01 & decomp$p.value <= 0.05]

length(hvgs)

sce.rna <- sce.rna[hvgs, ]

## -----------------------------------------------------------------------------
dim(experiments(mae)[["atac"]])

sce.atac <- experiments(mae)[["atac"]]

# Normalise
sce.atac <- logNormCounts(sce.atac)

# Feature selection using highly variable peaks
# And adding matching peaks to genes
decomp <- modelGeneVar(sce.atac)
hvgs <- rownames(decomp)[decomp$mean > 0.25 &
  decomp$p.value <= 0.05]
length(hvgs)

sce.atac <- sce.atac[hvgs, ]

## -----------------------------------------------------------------------------
logcounts_all <- rbind(logcounts(sce.rna), logcounts(sce.atac))
dim(logcounts_all)

assayType <- ifelse(rownames(logcounts_all) %in% rownames(sce.rna),
  "rna", "atac"
)
table(assayType)

## -----------------------------------------------------------------------------
dataType <- setNames(
  sample(c("RNA", "Multiome"), ncol(logcounts_all),
    prob = c(0.5, 0.5), replace = TRUE
  ),
  colnames(logcounts_all)
)
table(dataType)

assay_list <- list(
  RNA = logcounts_all[assayType %in% c("rna"), dataType %in% c("RNA")],
  Multiome = logcounts_all[
    assayType %in% c("rna", "atac"), dataType %in% c("Multiome")
  ]
)

lapply(assay_list, dim)
lapply(assay_list, class)

## -----------------------------------------------------------------------------
mosaicDataUpSet(assay_list, plot = FALSE)

## -----------------------------------------------------------------------------
mdt <- mosaicDataTopology(assay_list)
mdt
plot(mdt)

## -----------------------------------------------------------------------------
stab <- stabMap(assay_list,
  reference_list = c("Multiome"),
  plot = FALSE
)
dim(stab)
stab[1:5, 1:5]

## -----------------------------------------------------------------------------
stab_umap <- calculateUMAP(t(stab))
dim(stab_umap)

plot(stab_umap, pch = 16, cex = 0.3, col = factor(dataType[rownames(stab)]))

## -----------------------------------------------------------------------------
imp <- imputeEmbedding(
  assay_list,
  stab,
  reference = colnames(assay_list[["Multiome"]]),
  query = colnames(assay_list[["RNA"]])
)

class(imp)
names(imp)
lapply(imp, dim)
lapply(assay_list, dim)
imp[["Multiome"]][1:5, 1:5]

## -----------------------------------------------------------------------------
annotation <- "celltype"
referenceLabels <- colData(
  experiments(mae)[["rna"]]
)[colnames(assay_list$Multiome), annotation]
names(referenceLabels) <- colnames(assay_list$Multiome)

table(referenceLabels)

## -----------------------------------------------------------------------------
knn_out <- classifyEmbedding(
  stab,
  referenceLabels,
)

## -----------------------------------------------------------------------------
# Extract query labels
queryLabels <- colData(
  experiments(mae)[["rna"]]
)[colnames(assay_list$RNA), annotation]
names(queryLabels) <- colnames(assay_list$RNA)

acc <- mean(queryLabels == knn_out[names(queryLabels), "predicted_labels"])
acc

## -----------------------------------------------------------------------------
# Extract reference and query cells from UMAP embedding
stab_umap_ref <- stab_umap[colnames(assay_list$Multiome), ]
stab_umap_query <- stab_umap[colnames(assay_list$RNA), ]

# Create UMAP for reference cells
df_umap_ref <- data.frame(
  x = stab_umap_ref[, 1],
  y = stab_umap_ref[, 2],
  cell_type = referenceLabels[rownames(stab_umap_ref)]
)

p_ref <- df_umap_ref %>%
  ggplot() +
  aes(x = x, y = y, colour = cell_type) +
  geom_point(size = 1) +
  ggtitle("Reference cell type annotation")

# Create UMAP for query cells
df_umap_query <- data.frame(
  x = stab_umap_query[, 1],
  y = stab_umap_query[, 2],
  cell_type = queryLabels[rownames(stab_umap_query)]
)

p_query <- df_umap_query %>%
  ggplot() +
  aes(x = x, y = y, colour = cell_type) +
  geom_point(size = 1) +
  ggtitle("Query predicted cell types")

grid.arrange(p_ref, p_query, ncol = 2)

## -----------------------------------------------------------------------------
dataTypeIndirect <- setNames(
  sample(c("RNA", "Multiome", "ATAC"), ncol(logcounts_all),
    prob = c(0.3, 0.3, 0.3), replace = TRUE
  ),
  colnames(logcounts_all)
)
table(dataTypeIndirect)

assay_list_indirect <- list(
  RNA = logcounts_all[assayType %in% c("rna"), dataTypeIndirect %in% c("RNA")],
  Multiome = logcounts_all[
    assayType %in% c("rna", "atac"), dataTypeIndirect %in% c("Multiome")
  ],
  ATAC = logcounts_all[
    assayType %in% c("atac"), dataTypeIndirect %in% c("ATAC")
  ]
)

lapply(assay_list_indirect, dim)
lapply(assay_list_indirect, class)

## -----------------------------------------------------------------------------
mosaicDataUpSet(assay_list_indirect, plot = FALSE)

## -----------------------------------------------------------------------------
mdt_indirect <- mosaicDataTopology(assay_list_indirect)
mdt_indirect
plot(mdt_indirect)

## -----------------------------------------------------------------------------
stab_indirect <- stabMap(assay_list_indirect,
  reference_list = c("Multiome"),
  plot = FALSE
)
dim(stab_indirect)
stab_indirect[1:5, 1:5]

## -----------------------------------------------------------------------------
stab_indirect_umap <- calculateUMAP(t(stab_indirect))
dim(stab_indirect_umap)

plot(stab_indirect_umap,
  pch = 16, cex = 0.3,
  col = factor(dataTypeIndirect[rownames(stab_indirect)])
)

## -----------------------------------------------------------------------------
cellType <- setNames(mae$celltype, colnames(mae[[1]]))

plot(stab_indirect_umap,
  pch = 16, cex = 0.3,
  col = factor(cellType[rownames(stab_indirect)])
)

## -----------------------------------------------------------------------------
sessionInfo()

