# Code example from 'compch12' vignette. See references/ for full tutorial.

## ----getsoft, message=FALSE---------------------------------------------------
library(SingleCellExperiment)
library(scater)
library(scviR)

## ----getdat, message=FALSE----------------------------------------------------
ch12sce = getCh12Sce(clear_cache=FALSE)
ch12sce

## ----getdat2, message=FALSE---------------------------------------------------
options(timeout=3600)
fullvi = getTotalVI5k10kAdata()
fullvi

## ----basicvecs----------------------------------------------------------------
totvi_cellids = rownames(fullvi$obs)
totvi_batch = fullvi$obs$batch

## ----latent-------------------------------------------------------------------
totvi_latent = fullvi$obsm$get("X_totalVI")
totvi_umap = fullvi$obsm$get("X_umap")
totvi_denoised_rna = fullvi$layers$get("denoised_rna")
totvi_denoised_protein = fullvi$obsm$get("denoised_protein")
totvi_leiden = fullvi$obs$leiden_totalVI

## ----remove5k-----------------------------------------------------------------
is5k = which(totvi_batch == "PBMC5k")
totvi_cellids = totvi_cellids[-is5k]
totvi_latent = totvi_latent[-is5k,]
totvi_umap = totvi_umap[-is5k,]
totvi_denoised_rna = totvi_denoised_rna[-is5k,]
totvi_denoised_protein = totvi_denoised_protein[-is5k,]
totvi_leiden = totvi_leiden[-is5k]

## ----rown---------------------------------------------------------------------
rownames(totvi_latent) = totvi_cellids
rownames(totvi_umap) = totvi_cellids
rownames(totvi_denoised_rna) = totvi_cellids
rownames(totvi_denoised_protein) = totvi_cellids
names(totvi_leiden) = totvi_cellids

## ----findcomm-----------------------------------------------------------------
comm = intersect(totvi_cellids, ch12sce$Barcode)

## ----dosce--------------------------------------------------------------------
# select and order
totvi_latent = totvi_latent[comm,]
totvi_umap = totvi_umap[comm,]
totvi_denoised_rna = totvi_denoised_rna[comm,]
totvi_denoised_protein = totvi_denoised_protein[comm,]
totvi_leiden = totvi_leiden[comm]
 
# organize the totalVI into SCE with altExp

totsce = SingleCellExperiment(SimpleList(logcounts=t(totvi_denoised_rna))) # FALSE name
rowData(totsce) = S4Vectors::DataFrame(fullvi$var)
rownames(totsce) = rownames(fullvi$var)
rowData(totsce)$Symbol = rownames(totsce)
nn = SingleCellExperiment(SimpleList(logcounts=t(totvi_denoised_protein))) # FALSE name
reducedDims(nn) = list(UMAP=totvi_umap)
altExp(totsce) = nn
altExpNames(totsce) = "denoised_protein"
totsce$leiden = totvi_leiden
altExp(totsce)$leiden = totvi_leiden
altExp(totsce)$ch12.clusters = altExp(ch12sce[,comm])$label

# add average ADT abundance to metadata, for adt_profiles

tot.se.averaged <- sumCountsAcrossCells(altExp(totsce), altExp(totsce)$leiden,
    exprs_values="logcounts", average=TRUE)
rownames(tot.se.averaged) = gsub("_TotalSeqB", "", rownames(tot.se.averaged))
metadata(totsce)$se.averaged = tot.se.averaged

## ----trim12-------------------------------------------------------------------
colnames(ch12sce) = ch12sce$Barcode
ch12sce_matched = ch12sce[, comm]

## ----lkkey--------------------------------------------------------------------
plotTSNE(altExp(ch12sce_matched), color_by="label", text_by="label")

## ----lkadt--------------------------------------------------------------------
adtProfiles(ch12sce_matched)

## ----dosubcl------------------------------------------------------------------
ch12_allsce = getCh12AllSce() 
ch12_allsce = lapply(ch12_allsce, function(x) {
   colnames(x)= x$Barcode; 
   cn = colnames(x); 
   x = x[,intersect(cn,comm)]; x})
of.interest <- "3"
markers <- c("GZMH", "IL7R", "KLRB1")
plotExpression(ch12_allsce[[of.interest]], x="subcluster",
    features=markers, swap_rownames="Symbol", ncol=3)

## ----lkgra--------------------------------------------------------------------
plotExpression(ch12_allsce[["3"]], x="CD127", show_smooth=TRUE, show_se=FALSE, 
    features=c("IL7R", "TPT1", "KLRB1", "GZMH"), swap_rownames="Symbol")

## ----lktotumap----------------------------------------------------------------
plotUMAP(altExp(totsce), color_by="leiden", text_by="leiden")

## ----domattot-----------------------------------------------------------------
tav = S4Vectors::metadata(totsce)$se.averaged
ata = assay(tav)
uscale = function(x) (x-min(x))/max(x)
scmat = t(apply(ata,1,uscale))
pheatmap::pheatmap(scmat, cluster_rows=FALSE)

## ----lkconc-------------------------------------------------------------------
atot = altExp(totsce)
ach12 = altExp(ch12sce_matched)
tt = table(ch12=ach12$label, VI=atot$leiden)
pheatmap::pheatmap(log(tt+1))

## ----lkcomm-------------------------------------------------------------------
lit = tt[c("9", "12", "5", "3"), c("0", "1", "2", "8", "6", "5")]
rownames(lit) = sQuote(rownames(lit))
colnames(lit) = sQuote(colnames(lit))
lit

## ----lksubsss-----------------------------------------------------------------
tsub = totsce[,which(altExp(totsce)$leiden %in% c("5", "6", "8"))]
markers <- c("GZMH", "IL7R", "KLRB1")
altExp(tsub)$leiden = factor(altExp(tsub)$leiden) # squelch unused levels
tsub$leiden = factor(tsub$leiden) # squelch unused levels
plotExpression(tsub, x="leiden",
    features=markers, swap_rownames="Symbol", ncol=3)

## ----lkgradvi-----------------------------------------------------------------
rn = rownames(altExp(tsub))
rn = gsub("_TotalSeqB", "", rn)
rownames(altExp(tsub)) = rn
rowData(altExp(tsub)) = DataFrame(Symbol=rn)
plotExpression(tsub, x="CD127", show_smooth=TRUE, show_se=FALSE,
   features=c("IL7R", "KLRB1", "GZMH"), swap_rownames="Symbol")

## ----lksess-------------------------------------------------------------------
sessionInfo()

