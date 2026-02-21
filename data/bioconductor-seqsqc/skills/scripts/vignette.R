# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----setup, eval=FALSE--------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("SeqSQC")

## ----load packages------------------------------------------------------------
library(SeqSQC)

## ----loadData, eval=TRUE------------------------------------------------------
infile <- system.file("extdata", "example_sub.vcf", package="SeqSQC")
sample.annot <- system.file("extdata", "sampleAnnotation.txt", package="SeqSQC")
cr <- system.file("extdata", "CCDS.Hs37.3.reduced_chr1.bed", package="SeqSQC")
outdir <- tempdir()
outfile <- file.path(outdir, "testWrapUp")

## ----wrapup_vcf, eval=FALSE---------------------------------------------------
# seqfile <- sampleQC(vfile = infile, output = outfile, capture.region = cr, sample.annot = sample.annot, format.data = "NGS", format.file = "vcf", QCreport = FALSE)
# save(seqfile, file="seqfile.RData")

## ----wrapup_seqfile, eval=FALSE-----------------------------------------------
# load(system.file("extdata", "example.seqfile.Rdata", package="SeqSQC"))
# gfile <- system.file("extdata", "example.gds", package="SeqSQC")
# seqfile <- SeqSQC(gdsfile = gfile, QCresult = QCresult(seqfile))
# 
# seqfile <- sampleQC(vfile = seqfile, output = "testWrapUp", QCreport = TRUE)
# save(seqfile, file="seqfile.Rdata")

## ----loadVfile, eval=TRUE, message=FALSE--------------------------------------
seqfile <- LoadVfile(vfile = infile, output = outfile, capture.region = cr, sample.annot = sample.annot)

## ----show---------------------------------------------------------------------
load(system.file("extdata", "example.seqfile.Rdata", package="SeqSQC"))
gfile <- system.file("extdata", "example.gds", package="SeqSQC")
seqfile <- SeqSQC(gdsfile = gfile, QCresult = QCresult(seqfile))
slotNames(seqfile)

## ----class--------------------------------------------------------------------
gdsfile(seqfile)

## ----class2-------------------------------------------------------------------
QCresult(seqfile)
head(QCresult(seqfile)$sample.annot)

## ----gds----------------------------------------------------------------------
showfile.gds(closeall=TRUE)
dat <- SeqOpen(seqfile)
dat
closefn.gds(dat)

## ----missingrate, eval=FALSE--------------------------------------------------
# seqfile <- MissingRate(seqfile, remove.samples=NULL)

## ----mrresult, eval=TRUE------------------------------------------------------
res.mr <- QCresult(seqfile)$MissingRate
tail(res.mr)

## ----plot.mr------------------------------------------------------------------
plotQC(seqfile, QCstep = "MissingRate")

## ----sexcheck, eval=FALSE-----------------------------------------------------
# seqfile <- SexCheck(seqfile, remove.samples=NULL)

## ----scresult, eval=TRUE------------------------------------------------------
res.sexc <- QCresult(seqfile)$SexCheck
tail(res.sexc)

## ----plot.sexc----------------------------------------------------------------
plotQC(seqfile, QCstep = "SexCheck")

## ----inbreeding, eval=FALSE---------------------------------------------------
# seqfile <- Inbreeding(seqfile, remove.samples=NULL)

## ----inbresult, eval=TRUE-----------------------------------------------------
res.inb <- QCresult(seqfile)$Inbreeding
tail(res.inb)

## ----plot.inb-----------------------------------------------------------------
plotQC(seqfile, QCstep = "Inbreeding")

## ----ibd, eval=FALSE----------------------------------------------------------
# seqfile <- IBD(seqfile, remove.samples=NULL)

## ----ibdresult, eval=TRUE-----------------------------------------------------
res.ibd <- QCresult(seqfile)$IBD
head(res.ibd)

## ----plot.ibd-----------------------------------------------------------------
plotQC(seqfile, QCstep = "IBD")

## ----pca, eval=FALSE----------------------------------------------------------
# seqfile <- PCA(seqfile, remove.samples=NULL)

## ----pcaresult, eval=TRUE-----------------------------------------------------
res.pca <- QCresult(seqfile)$PCA
tail(res.pca)

## ----plot.pca-----------------------------------------------------------------
plotQC(seqfile, QCstep = "PCA")

## ----plot.pca.inter, eval=TRUE, warning=FALSE---------------------------------
plotQC(seqfile, QCstep = "PCA", interactive=TRUE)

## ----problist-----------------------------------------------------------------
problemList(seqfile)
save(seqfile, file="seqfile.Rdata")

## ----report, eval=FALSE-------------------------------------------------------
# RenderReport(seqfile, output="report.html", interactive=TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

