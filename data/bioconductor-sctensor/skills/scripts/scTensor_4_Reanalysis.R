# Code example from 'scTensor_4_Reanalysis' vignette. See references/ for full tutorial.

## ----reanalysis.RData, eval=FALSE---------------------------------------------
# library("scTensor")
# load("reanalysis.RData")

## ----Reanalysis, eval=FALSE---------------------------------------------------
# library("AnnotationHub")
# library("LRBaseDbi")
# 
# # Create LRBase object
# ah <- AnnotationHub()
# dbfile <- query(ah, c("LRBaseDb", "Homo sapiens"))[[1]]
# LRBase.Hsa.eg.db <- LRBaseDbi::LRBaseDb(dbfile)
# 
# # Register the file pass of user's LRBase
# metadata(sce)$lrbase <- dbfile(LRBase.Hsa.eg.db)
# 
# # CCI Tensor Decomposition
# cellCellDecomp(sce, ranks=c(6,5), assayNames="normcounts")
# 
# # HTML Report
# cellCellReport(sce, reducedDimNames="TSNE", assayNames="normcounts",
#     title="Cell-cell interaction within Germline_Male, GSE86146",
#     author="Koki Tsuyuzaki", html.open=TRUE,
#     goenrich=TRUE, meshenrich=FALSE, reactomeenrich=FALSE,
#     doenrich=FALSE, ncgenrich=FALSE, dgnenrich=FALSE)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

