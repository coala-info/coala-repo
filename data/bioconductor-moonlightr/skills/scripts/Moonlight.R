# Code example from 'Moonlight' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(dpi = 300)
knitr::opts_chunk$set(cache=FALSE)

## ----echo = FALSE,hide=TRUE, message=FALSE,warning=FALSE----------------------
library(dbplyr)
devtools::load_all(".")

## ----fig.width=6, fig.height=4, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
library(png)
library(grid)
img <- readPNG("Moonlight_Pipeline.png")
grid.raster(img)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("MoonlightR")

## ----eval = FALSE-------------------------------------------------------------
# dataFilt <- getDataTCGA(cancerType = "LUAD",
#                           dataType = "Gene expression",
#                           directory = "data",
#                           nSample = 4)

## ----eval = FALSE-------------------------------------------------------------
# dataFilt <- getDataTCGA(cancerType = "BRCA",
#                           dataType = "Methylation",
#                           directory = "data",nSample = 4)

## ----eval = TRUE, echo = TRUE-------------------------------------------------
knitr::kable(GEO_TCGAtab, digits = 2, 
             caption = "Table with GEO data set matched to one 
             of the 18 given TCGA cancer types ",
             row.names = TRUE)

## ----eval = FALSE , echo = TRUE, results='hide', warning = FALSE, message = FALSE----
# dataFilt <- getDataGEO(GEOobject = "GSE20347",platform = "GPL571")

## ----eval = FALSE, echo = TRUE, results='hide', warning = FALSE, message = FALSE----
# dataFilt <- getDataGEO(TCGAtumor = "ESCA")

## ----eval = FALSE, message=FALSE, results='hide', warning=FALSE---------------
# dataDEGs <- DPA(dataFilt = dataFilt,
#                 dataType = "Gene expression")

## ----eval = FALSE, echo = TRUE, hide=TRUE, results='hide', warning = FALSE, message = FALSE----
# data(GEO_TCGAtab)
# DataAnalysisGEO<- "../GEO_dataset/"
# i<-5
# 
# cancer <- GEO_TCGAtab$Cancer[i]
# cancerGEO <- GEO_TCGAtab$Dataset[i]
# cancerPLT <-GEO_TCGAtab$Platform[i]
# fileCancerGEO <- paste0(cancer,"_GEO_",cancerGEO,"_",cancerPLT, ".RData")
# 
# dataFilt <- getDataGEO(TCGAtumor = cancer)
# xContrast <- c("G1-G0")
# GEOdegs <- DPA(dataConsortium = "GEO",
#                gset = dataFilt ,
#                colDescription = "title",
#                samplesType  = c(GEO_TCGAtab$GEO_Normal[i],
#                                 GEO_TCGAtab$GEO_Tumor[i]),
#                fdr.cut = 0.01,
#                logFC.cut = 1,
#                gsetFile = paste0(DataAnalysisGEO,fileCancerGEO))

## ----eval = TRUE, echo = TRUE-------------------------------------------------
library(TCGAbiolinks)
TCGAVisualize_volcano(DEGsmatrix$logFC, DEGsmatrix$FDR,
                      filename = "DEGs_volcano.png",
                      x.cut = 1,
                      y.cut = 0.05,
                      names = rownames(DEGsmatrix),
                      color = c("black","red","dodgerblue3"),
                      names.size = 2,
                      show.names = "highlighted",
                      highlight = c("gene1","gene2"),
                      xlab = " Gene expression fold change (Log2)",
                      legend = "State",
                      title = "Volcano plot (Normal NT vs Tumor TP)",
                      width = 10)

## ----fig.width=6, fig.height=4, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
img <- readPNG("DEGs_volcano.png")
grid.raster(img)

## ----eval = TRUE, echo = TRUE, results='hide'---------------------------------
data(DEGsmatrix)
dataFEA <- FEA(DEGsmatrix = DEGsmatrix)

## ----eval = TRUE, echo = TRUE, message=FALSE, results='hide', warning=FALSE----
plotFEA(dataFEA = dataFEA, additionalFilename = "_exampleVignette", height = 20, width = 10)

## ----fig.width=6, fig.height=4, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
img <- readPNG("FEAplot.png")
grid.raster(img)

## ----eval = TRUE--------------------------------------------------------------
dataGRN <- GRN(TFs = rownames(DEGsmatrix)[1:100], normCounts = dataFilt,
	               nGenesPerm = 10,kNearest = 3,nBoot = 10)

## ----eval = FALSE, echo = TRUE, results='hide'--------------------------------
# data(dataGRN)
# data(DEGsmatrix)
# 
# dataFEA <- FEA(DEGsmatrix = DEGsmatrix)
# 
# BPselected <- dataFEA$Diseases.or.Functions.Annotation[1:5]
# dataURA <- URA(dataGRN = dataGRN,
#                DEGsmatrix = DEGsmatrix,
#                BPname = BPselected,
#                nCores=1)

## ----eval = TRUE--------------------------------------------------------------
data(dataURA)
dataDual <- PRA(dataURA = dataURA,
                          BPname = c("apoptosis","proliferation of cells"),
                          thres.role = 0)

## ----eval = TRUE, echo = TRUE, results='hide', warning = FALSE, message = FALSE----
data(knownDriverGenes)
data(dataGRN)
plotNetworkHive(dataGRN, knownDriverGenes, 0.55)

## ----eval = FALSE,echo=TRUE,message=FALSE,warning=FALSE, results='hide'-------
# dataDEGs <- DPA(dataFilt = dataFilt,
#                 dataType = "Gene expression")
# 
# dataFEA <- FEA(DEGsmatrix = dataDEGs)
# 
# dataGRN <- GRN(TFs = rownames(dataDEGs)[1:100],
#                DEGsmatrix = dataDEGs,
#                DiffGenes = TRUE,
#                normCounts = dataFilt)
# 
# dataURA <- URA(dataGRN = dataGRN,
#               DEGsmatrix = dataDEGs,
#               BPname = c("apoptosis",
#                          "proliferation of cells"))
# 
# dataDual <- PRA(dataURA = dataURA,
#                BPname = c("apoptosis",
#                           "proliferation of cells"),
#                thres.role = 0)
# 
# CancerGenes <- list("TSG"=names(dataDual$TSG), "OCG"=names(dataDual$OCG))
# 

## ----eval = TRUE,message=FALSE,warning=FALSE, results='hide'------------------
 plotURA(dataURA = dataURA[c(names(dataDual$TSG), names(dataDual$OCG)),, drop = FALSE], additionalFilename = "_exampleVignette")

## ----fig.width=6, fig.height=4, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
img <- readPNG("URAplot.png")
grid.raster(img)

## ----eval = FALSE,echo=TRUE,message=FALSE,warning=FALSE-----------------------
# cancerList <- c("BLCA","COAD","ESCA","HNSC","STAD")
# 
# listMoonlight <- moonlight(cancerType = cancerList,
#                       dataType = "Gene expression",
#                       directory = "data",
#                       nSample = 10,
#                       nTF = 100,
#                       DiffGenes = TRUE,
#                       BPname = c("apoptosis","proliferation of cells"))
# save(listMoonlight, file = paste0("listMoonlight_ncancer4.Rdata"))
# 

## ----eval = TRUE, echo = TRUE, results='hide', warning = FALSE, message = FALSE----
plotCircos(listMoonlight = listMoonlight, additionalFilename = "_ncancer5")

## ----fig.width=6, fig.height=4, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
img <- readPNG("circos_ocg_tsg_ncancer5.png")
grid.raster(img)

## ----eval = FALSE,echo=TRUE,message=FALSE,warning=FALSE-----------------------
# 
# listMoonlight <- NULL
# for (i in 1:4){
#     dataDual <- moonlight(cancerType = "BRCA",
#                       dataType = "Gene expression",
#                       directory = "data",
#                       nSample = 10,
#                       nTF = 5,
#                       DiffGenes = TRUE,
#                       BPname = c("apoptosis","proliferation of cells"),
#                       stage = i)
#     listMoonlight <- c(listMoonlight, list(dataDual))
#     save(dataDual, file = paste0("dataDual_stage",as.roman(i), ".Rdata"))
# }
# names(listMoonlight) <- c("stage1", "stage2", "stage3", "stage4")
# 
# # Prepare mutation data for stages
# 
# mutation <- GDCquery_Maf(tumor = "BRCA")
# 
# res.mutation <- NULL
# for(stage in 1:4){
# 
#   curStage <- paste0("Stage ", as.roman(stage))
#                 dataClin$tumor_stage <- toupper(dataClin$tumor_stage)
#                 dataClin$tumor_stage <- gsub("[ABCDEFGH]","",dataClin$tumor_stage)
#                 dataClin$tumor_stage <- gsub("ST","Stage",dataClin$tumor_stage)
# 
#                 dataStg <- dataClin[dataClin$tumor_stage %in% curStage,]
#                 message(paste(curStage, "with", nrow(dataStg), "samples"))
# dataSmTP <- mutation$Tumor_Sample_Barcode
# 
#                 dataStgC <- dataSmTP[substr(dataSmTP,1,12) %in% dataStg$bcr_patient_barcode]
#                 dataSmTP <- dataStgC
# 
#                 info.mutation <- mutation[mutation$Tumor_Sample_Barcode %in% dataSmTP,]
# 
#      ind <- which(info.mutation[,"Consequence"]=="inframe_deletion")
#      ind2 <- which(info.mutation[,"Consequence"]=="inframe_insertion")
#      ind3 <- which(info.mutation[,"Consequence"]=="missense_variant")
#     res.mutation <- c(res.mutation, list(info.mutation[c(ind, ind2, ind3),c(1,51)]))
# 	}
# names(res.mutation) <- c("stage1", "stage2", "stage3", "stage4")
# 
# 
# tmp <- NULL
# tmp <- c(tmp, list(listMoonlight[[1]][[1]]))
# tmp <- c(tmp, list(listMoonlight[[2]][[1]]))
# tmp <- c(tmp, list(listMoonlight[[3]][[1]]))
# tmp <- c(tmp, list(listMoonlight[[4]][[1]]))
# names(tmp) <- names(listMoonlight)
# 
#  mutation <- GDCquery_Maf(tumor = "BRCA")
# 
#  plotCircos(listMoonlight=listMoonlight,listMutation=res.mutation, additionalFilename="proc2_wmutation", intensityColDual=0.2,fontSize = 2)

## ----fig.width=6, fig.height=4, echo = FALSE, fig.align="center",hide=TRUE, message=FALSE,warning=FALSE----
img <- readPNG("circos_ocg_tsg_stages.png")
grid.raster(img)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

