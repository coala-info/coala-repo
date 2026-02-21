# Code example from 'cepo' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(crop = NULL)

## ----load-example-data, message = FALSE---------------------------------------
library(Cepo)
library(SingleCellExperiment)
data("cellbench", package = "Cepo")
cellbench
cellbench = cellbench[!duplicated(rownames(cellbench)),]

## ----visualize colData--------------------------------------------------------
colData(cellbench)[1:5,]

## ----check_cell_types---------------------------------------------------------
unique(cellbench$celltype)

## ----differential-stability-analysis------------------------------------------
ds_res = Cepo(exprsMat = logcounts(cellbench),
              cellType = cellbench$celltype)

## -----------------------------------------------------------------------------
ds_res

## ----filtering-lowly-expressed-genes------------------------------------------
ds_res_zprop = Cepo::Cepo(exprsMat = logcounts(cellbench),
                          cellTypes = cellbench$celltype,
                          exprsPct = 0.5)

## ----filtering-logfc----------------------------------------------------------
ds_res_logfc = Cepo(exprsMat = logcounts(cellbench),
                    cellTypes = cellbench$celltype,
                    logfc = 1)

## -----------------------------------------------------------------------------
nrow(ds_res$stats)
nrow(ds_res_zprop$stats)
nrow(ds_res_logfc$stats)

## ----return-p-values1---------------------------------------------------------
ds_res_pvalues = Cepo(exprsMat = logcounts(cellbench),
                      cellType = cellbench$celltype, 
                      computePvalue = 200,
                      prefilter_pzero = 0.4)

## -----------------------------------------------------------------------------
idx = rownames(ds_res_pvalues$stats)

par(mfrow=c(1,3))
for (i in unique(cellbench$celltype)) {
  
  plot(rank(ds_res_pvalues$stats[[i]]),
       rank(-log10(ds_res_pvalues$pvalues[idx, i])),
       main = i,
       xlab = "rank Cepo statistics",
       ylab = "rank -log10 p-values")

}
par(mfrow=c(1,1))

## ----return-p-values2---------------------------------------------------------
ds_res_pvalues = Cepo(exprsMat = logcounts(cellbench),
                      cellType = cellbench$celltype, 
                      # we use a low value for demonstration purposes
                      computePvalue = 100,
                      computeFastPvalue = FALSE)
ds_res_pvalues

## ----upset-plot---------------------------------------------------------------
library(UpSetR)
res_name = topGenes(object = ds_res, n = 500)
upset(fromList(res_name), nsets = 3)

## ----plot-densities-----------------------------------------------------------
plotDensities(x = cellbench,
              cepoOutput = ds_res,
              nGenes = 2,
              assay = "logcounts",
              celltypeColumn = "celltype")

## ----plot-densities-genes-----------------------------------------------------
plotDensities(x = cellbench,
              cepoOutput = ds_res,
              genes = c("PLTP", "CPT1C", "MEG3", "SYCE1", "MICOS10P3", "HOXB7"),
              assay = "logcounts",
              celltypeColumn = "celltype")

## -----------------------------------------------------------------------------
data("sce_pancreas", package = "Cepo")
sce_pancreas

## ----fig.height=5, fig.width=5------------------------------------------------
library(scater)
sce = sce_pancreas
sce = scater::logNormCounts(sce)
sce = scater::runPCA(sce)

scater::plotPCA(
  sce, 
  colour_by = "cellTypes", 
  shape_by = "batch")

## -----------------------------------------------------------------------------
library(scMerge)
data("segList", package = "scMerge")
head(segList$human$human_scSEG)

corrected <- scMerge(
  sce_combine = sce,
  ctl = segList$human$human_scSEG,
  kmeansK = c(2, 2),
  assay_name = "scMerge",
  cell_type = sce$cellTypes)

## ----fig.height=5, fig.width=5------------------------------------------------
corrected = runPCA(corrected,
                            exprs_values = "scMerge")

scater::plotPCA(
  corrected,
  colour_by = "cellTypes",
  shape_by = "batch")

## -----------------------------------------------------------------------------
ds_res = Cepo::Cepo(exprsMat = assay(corrected, "scMerge"),
              cellType = corrected$cellTypes)

## -----------------------------------------------------------------------------
ds_res_batches = Cepo::Cepo(exprsMat = logcounts(sce),
                            cellTypes = sce$cellTypes,
                            block = sce$batch,
                            minCelltype = 2)

## -----------------------------------------------------------------------------
names(ds_res_batches)

## ----fig.height=10, fig.width=10----------------------------------------------
idx = Reduce(intersect, lapply(ds_res_batches, function(x) names(x$stats[, 1])))

combinedRes = as.data.frame(do.call(cbind, lapply(ds_res_batches, function(x) 
  x$stats[idx,]
)))

batches = rep(names(ds_res_batches), sapply(ds_res_batches, function(x) length(x$stats)))
cty = unlist(lapply(ds_res_batches, function(x) names(x$stats)), use.name = FALSE)
colnames(combinedRes) = gsub("[.]", "_", colnames(combinedRes))
  
annot = data.frame(
  batch = batches,
  celltype = cty
)
rownames(annot) = colnames(combinedRes)

pheatmap::pheatmap(cor(combinedRes),
                   annotation = annot)

## ----marker-genes, fig.height=10, fig.width=15--------------------------------
cepo_genes = Cepo::topGenes(ds_res_batches$average, n = 3)

markersPlot = lapply(cepo_genes, function(x) {
  pp = lapply(x, function(gene) {
  p = scater::plotPCA(
  corrected,
  colour_by = gene,
  shape_by = "cellTypes")
  return(p)
  })
  pp = patchwork::wrap_plots(pp, ncol = 3) + patchwork::plot_layout(guides = "auto")
  return(pp)
})
patchwork::wrap_plots(markersPlot, nrow = 2)

## ----gsea, message = FALSE----------------------------------------------------
library(escape)
library(fgsea)
hallmarkList <- getGeneSets(species = "Homo sapiens", 
                           library = "H")

fgseaRes <- fgsea(pathways = hallmarkList, 
                  stats    = sort(ds_res_batches[4]$average$stats[,"beta"]),
                  minSize = 15,
                  maxSize = 500)

enriched_beta <- -log10(fgseaRes[order(pval), "padj"][[1]])
names(enriched_beta) <- fgseaRes[order(pval), "pathway"][[1]]

## -----------------------------------------------------------------------------
enriched_beta[1:5]

## ----fig.height=5, fig.width=5------------------------------------------------
plotEnrichment(hallmarkList[["HALLMARK-PANCREAS-BETA-CELLS"]],
               sort(ds_res_batches$average$stats[, "beta"])) + labs(title="HALLMARK-PANCREAS-BETA-CELLS")

## ----cepo-delayed-------------------------------------------------------------
library(DelayedArray)
library(HDF5Array)
da_matrix = DelayedArray(realize(logcounts(cellbench), "HDF5Array"))
class(da_matrix)
class(seed(da_matrix))

da_output = Cepo(exprsMat = da_matrix, cellType = cellbench$celltype)

## ----cepo-parallel------------------------------------------------------------
library(BiocParallel)

BPPARAM = if (.Platform$OS.type == "windows") {
  BiocParallel::SnowParam(workers = 2)
} else {
  BiocParallel::MulticoreParam(workers = 2)
}

DelayedArray::setAutoBPPARAM(BPPARAM = BPPARAM) ## Setting two cores for computation

da_output_parallel = Cepo(exprsMat = da_matrix, cellTypes = cellbench$celltype)

DelayedArray::setAutoBPPARAM(BPPARAM = SerialParam()) ## Revert back to only one core

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

