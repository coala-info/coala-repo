# Code example from 'scanMiRApp' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(scanMiRApp)
# anno <- ScanMiRAnno("Rnor_6")
# for this vignette, we'll work with a lightweight fake annotation:
anno <- ScanMiRAnno("fake")
anno

## -----------------------------------------------------------------------------
seq <- getTranscriptSequence("ENSTFAKE0000056456", anno)
seq

## -----------------------------------------------------------------------------
plotSitesOnUTR(tx="ENSTFAKE0000056456", annotation=anno, miRNA="hsa-miR-155-5p")

## -----------------------------------------------------------------------------
m <- runFullScan(anno)
m

## ----eval=FALSE---------------------------------------------------------------
# scanMiRApp( list( nameOfAnnotation=anno ) )

## ----eval=FALSE---------------------------------------------------------------
# # not run
# anno <- ScanMiRAnno("Rnor_6")
# saveIndexedFst(readRDS("scan.rds"), "seqnames", file.prefix="out_path/scan")
# saveIndexedFst(readRDS("aggregated.rds"), "miRNA",
#                file.prefix="out_path/aggregated")
# anno$scan <- loadIndexedFst("out_path/scan")
# anno$aggregated <- loadIndexedFst("out_path/aggregated")
# # then launch the app
# scanMiRApp(list(Rnor_6=anno))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

