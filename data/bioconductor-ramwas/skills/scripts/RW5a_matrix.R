# Code example from 'RW5a_matrix' vignette. See references/ for full tutorial.

## ----loadPackages, echo=FALSE, warning=FALSE, message=FALSE-------------------
library(knitr)
# library(pander)
# suppressPackageStartupMessages(library(ramwas))
# panderOptions("digits", 3)
# opts_chunk$set(fig.width = 6, fig.height = 6)
opts_chunk$set(eval=FALSE)
# setwd('F:/meth')

## ----prereq, eval=FALSE-------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install(c(
#     "minfi",
#     "IlluminaHumanMethylation450kmanifest",
#     "IlluminaHumanMethylationEPICmanifest",
#     "wateRmelon",
#     "readxl",
#     "RPMM",
#     "FlowSorted.Blood.450k",
#     "FlowSorted.Blood.EPIC"),
#     update = TRUE, ask = FALSE, quiet = TRUE)

## ----downloadUnTAR------------------------------------------------------------
# download.file(
#     url = 'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE42861&format=file',
#     destfile = 'GSE42861_RAW.tar',
#     quiet = TRUE,
#     mode = 'wb')
# untar('GSE42861_RAW.tar')

## ----load---------------------------------------------------------------------
# library(minfi)
# download.file(  url = "http://shabal.in/RaMWAS/GSE42861_sampleSheet.csv",
#                 destfile = "GSE42861_sampleSheet.csv",
#                 destfilemode = "wb")
# targets = read.csv( file = "GSE42861_sampleSheet.csv",
#                     stringsAsFactors = FALSE)
# rgSet = read.metharray.exp(
#                     targets = targets,
#                     extended = TRUE,
#                     verbose = TRUE)

## ----probes-------------------------------------------------------------------
# if( "IlluminaHumanMethylation450k" %in% rgSet@annotation ){
#     host = "http://www.sickkids.ca/MS-Office-Files/Research/Weksberg%20Lab/"
#     files = c(
#         i450k_ns.xlsx = "48639-non-specific-probes-Illumina450k.xlsx",
#         i450k_pl.xlsx = "48640-polymorphic-CpGs-Illumina450k.xlsx")
# 
#     for( i in seq_along(files) )
#         download.file(
#             url = paste0(host, files[i]),
#             destfile = names(files)[i],
#             mode = "wb",
#             quiet = TRUE)
# 
#     library(readxl)
#     ex1 = read_excel("i450k_ns.xlsx", sheet = 1)
#     ex2 = read_excel("i450k_pl.xlsx", sheet = 1)
#     ex3 = read_excel("i450k_pl.xlsx", sheet = 2)
# 
#     exclude.snp = unique(c(
#                 ex1$TargetID,
#                 ex2$PROBE,
#                 ex3$PROBE[ (ex3$BASE_FROM_SBE < 10) & (ex3$AF > 0.01)]))
#     rm(host, files, i, ex1, ex2, ex3)
# } else {
#     host = "https://static-content.springer.com/esm/art%3A10.1186%2Fs13059-016-1066-1/MediaObjects/"
#     files = c(
#         S1_cross_reactive.csv     = '13059_2016_1066_MOESM1_ESM.csv',
#         S4_snp_cpg.csv            = '13059_2016_1066_MOESM4_ESM.csv',
#         S5_snp_base_extension.csv = '13059_2016_1066_MOESM5_ESM.csv',
#         S6_snp_body.csv           = '13059_2016_1066_MOESM6_ESM.csv')
# 
#     for( i in seq_along(files) )
#         download.file(
#             url = paste0(host, files[i]),
#             destfile = names(files)[i],
#             mode = "wb",
#             quiet = TRUE)
# 
#     snpcpgs1 = read.csv('S1_cross_reactive.csv', stringsAsFactors = FALSE)
#     snpcpgs4 = read.csv('S4_snp_cpg.csv', stringsAsFactors = FALSE)
#     snpcpgs5 = read.csv('S5_snp_base_extension.csv', stringsAsFactors = FALSE)
#     snpcpgs6 = read.csv('S6_snp_body.csv', stringsAsFactors = FALSE)
# 
#     exclude.snp = unique(c(
#         snpcpgs1$X,
#         snpcpgs4$PROBE,
#         snpcpgs5$PROBE,
#         snpcpgs6$PROBE[
#             pmax(snpcpgs6$VARIANT_START - snpcpgs6$MAPINFO,
#                  snpcpgs6$MAPINFO - snpcpgs6$VARIANT_END) < 10]))
#     rm(host, files, i, snpcpgs1, snpcpgs4, snpcpgs5, snpcpgs6)
# }

## -----------------------------------------------------------------------------
# lb = getNBeads(rgSet) < 3
# pi1 = getProbeInfo(rgSet, type = "I")
# pi2 = getProbeInfo(rgSet, type = "II")
# ex1 = pi1$Name[rowMeans(lb[pi1$AddressA,] | lb[pi1$AddressB,]) > 0.01]
# ex2 = pi2$Name[rowMeans(lb[pi2$AddressA,]) > 0.01]
# exclude.bds = unique(c(ex1, ex2))
# rm(lb, pi1, pi2, ex1, ex2)

## ----pv-----------------------------------------------------------------------
# hp = detectionP(rgSet) > 0.01
# exclude.hpv = rownames(hp)[rowMeans(hp) > 0.01]
# keep.samples = colMeans(hp) < 0.01
# rm(hp)

## ----exclude------------------------------------------------------------------
# rgSet = subsetByLoci(
#             rgSet = rgSet[,keep.samples],
#             excludeLoci = c(exclude.snp, exclude.bds, exclude.hpv))

## ----beta---------------------------------------------------------------------
# rgSetRaw = fixMethOutliers(preprocessRaw(rgSet))
# # beta = BMIQ(rgSetRaw)
# beta = getBeta(rgSetRaw)

## ----save---------------------------------------------------------------------
# dir.create('rw', showWarnings = FALSE)
# 
# rng = granges(mapToGenome(rgSet))
# chr = seqnames(rng)
# 
# # Save CpG locations
# library(filematrix)
# locs = cbind(chr = as.integer(chr), position = start(rng))
# fmloc = fm.create.from.matrix(
#         filenamebase = paste0("rw/CpG_locations"),
#         mat = locs,
#         size = 4)
# close(fmloc)
# writeLines(con = 'rw/CpG_chromosome_names.txt', text = levels(chr))
# 
# # Save estimates
# fm = fm.create.from.matrix(
#         filenamebase = paste0("rw/Coverage"),
#         mat = t(beta))
# close(fm)

## ----pca1---------------------------------------------------------------------
# controlType = unique(getManifest(rgSet)@data$TypeControl$Type)
# controlSet = getControlAddress(rgSet, controlType = controlType)
# probeData = rbind(getRed(rgSet)[controlSet,], getGreen(rgSet)[controlSet,])

## ----pca2---------------------------------------------------------------------
# data = probeData - rowMeans(probeData)
# covmat = crossprod(data)
# eig = eigen(covmat)

## ----val----------------------------------------------------------------------
# library(ramwas)
# plotPCvalues(eig$values, n = 20)
# plotPCvectors(eig$vectors[,1], i = 1, col = 'blue')

## ----pplotpc, echo=FALSE------------------------------------------------------
# png('PCval.png', 800, 800, pointsize = 28)
# plotPCvalues(eig$values, n = 20)
# dev.off()
# png('PCvec.png', 800, 800, pointsize = 28)
# plotPCvectors(eig$vectors[,1], i = 1, col = 'blue')
# dev.off()

## ----cov.pca------------------------------------------------------------------
# nPCs = 2
# covariates.pca = eig$vectors[,seq_len(nPCs)]
# colnames(covariates.pca) = paste0('PC',seq_len(nPCs))
# rm(probeData, data, covmat, eig, nPCs)

## ----cell---------------------------------------------------------------------
# covariates.cel = estimateCellCounts(
#                     rgSet = rgSet,
#                     compositeCellType = "Blood",
#                     cellTypes = c("CD8T", "CD4T", "NK",
#                                   "Bcell", "Mono", "Gran"),
#                     meanPlot = FALSE)

## ----umm----------------------------------------------------------------------
# covariates.umm = getQC(rgSetRaw)

## ----pheno--------------------------------------------------------------------
# rownames(targets) = targets$Basename;
# targets$xSlide = paste0('x',targets$Slide) # Force Slide to be categorical
# covariates.phe = targets[
#             rownames(covariates.umm),
#             c("xSlide", "Array", "caseStatus", "age", "sex", "smokingStatus")]

## ----param1-------------------------------------------------------------------
# covariates = data.frame(
#                 samples = rownames(covariates.umm),
#                 covariates.umm,
#                 covariates.pca,
#                 covariates.cel,
#                 covariates.phe)
# 
# library(ramwas)
# param = ramwasParameters(
#     dircoveragenorm = 'rw',
#     covariates = covariates,
#     modelcovariates = NULL,
#     modeloutcome = "caseStatus",
#     modelPCs = 0)

## ----pcaNULL------------------------------------------------------------------
# param$modelcovariates = NULL
# param$modelPCs = 0
# ramwas4PCA(param)
# ramwas5MWAS(param)
# qqPlotFast(getMWAS(param)$`p-value`)
# title('QQ-plot\nNo covariates, no PCs')

## ----pcaFULL------------------------------------------------------------------
# param$modelcovariates = c(
#     "age", "sex", "Array", "xSlide",
#     "mMed", "uMed",
#     "PC1", "PC2",
#     "CD8T", "CD4T", "NK", "Bcell", "Mono", "Gran")
# param$modelPCs = 2
# ramwas4PCA(param)
# ramwas5MWAS(param)
# qqPlotFast(getMWAS(param)$`p-value`)
# title('QQ-plot\n13 covariates and 2 PC')

## ----plotmwas, echo=FALSE-----------------------------------------------------
# png('QQnull.png', 800, 800, pointsize = 28)
# param$modelcovariates = NULL
# param$modelPCs = 0
# mwas = getMWAS(param)
# qqPlotFast(mwas$`p-value`)
# title('QQ-plot\nNo covariates, no PCs')
# dev.off()
# 
# png('QQfull.png', 800, 800, pointsize = 28)
# param$modelcovariates = c(
#     "age", "sex", "Array", "xSlide",
#     "mMed", "uMed",
#     "PC1", "PC2",
#     "CD8T", "CD4T", "NK", "Bcell", "Mono", "Gran")
# param$modelPCs = 2
# mwas = getMWAS(param)
# qqPlotFast(mwas$`p-value`)
# title('QQ-plot\n13 covariates and 2 PCs')
# dev.off()

