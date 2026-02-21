# Code example from 'amaretto' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(progress = FALSE)

## ----setup1, message= FALSE,results='hide',eval=FALSE-------------------------
# #-------------------------------------------------------------------------------
# 
# install.packages("BiocManager",repos = "http://cran.us.r-project.org")
# BiocManager::install("gevaertlab/AMARETTO")
# 
# #-------------------------------------------------------------------------------

## ----AMARETTO_Download1, message= FALSE,results='hide',eval=FALSE-------------
# #-------------------------------------------------------------------------------
# 
# library(AMARETTO)
# TargetDirectory <- tempfile()# data download directory
# CancerSite <- "LIHC"
# DataSetDirectories <- AMARETTO_Download(CancerSite = CancerSite,
#                                         TargetDirectory = TargetDirectory)
# 
# #-------------------------------------------------------------------------------

## ----AMARETTO_Preprocess, message= FALSE,results='hide',eval=FALSE------------
# #-------------------------------------------------------------------------------
# load("../inst/extdata/MethylStates.rda")
# ProcessedData <- AMARETTO_Preprocess(DataSetDirectories = DataSetDirectories,
#                                     BatchData = BatchData)
# 
# #-------------------------------------------------------------------------------

## ----ProcessedDataLIHC, message= FALSE,results='hide', echo=FALSE-------------
library(AMARETTO)
data(ProcessedDataLIHC)

## ----AMARETTO_Initialize, message= FALSE,results='hide'-----------------------
#-------------------------------------------------------------------------------

AMARETTOinit <- AMARETTO_Initialize(ProcessedData = ProcessedDataLIHC,
                                    NrModules = 2, VarPercentage = 50)

#-------------------------------------------------------------------------------

## ----AMARETTO_Run, message= FALSE,warning=FALSE,results='hide'----------------
#-------------------------------------------------------------------------------

AMARETTOresults <- AMARETTO_Run(AMARETTOinit = AMARETTOinit)

#-------------------------------------------------------------------------------

## ----AMARETTO_EvaluateTestSet, message= FALSE,results='hide'------------------
#-------------------------------------------------------------------------------

AMARETTOtestReport <- AMARETTO_EvaluateTestSet(
                      AMARETTOresults = AMARETTOresults,
                      MA_Data_TestSet = AMARETTOinit$MA_matrix_Var,
                      RegulatorData_TestSet = AMARETTOinit$RegulatorData
                      )

#-------------------------------------------------------------------------------

## ----AMARETTO_VisualizeModule, message= FALSE, fig.height=5, fig.width=7, retina=1----
#-------------------------------------------------------------------------------
ModuleNr <- 1 #define the module number to visualize

AMARETTO_VisualizeModule(AMARETTOinit = AMARETTOinit, 
                         AMARETTOresults = AMARETTOresults,
                         ProcessedData = ProcessedDataLIHC, 
                         ModuleNr = ModuleNr)




## ----AMARETTO_HTMLreport, message= FALSE,results='hide', eval=FALSE,eval=FALSE----
# #-------------------------------------------------------------------------------
# 
# gmt_file<-system.file("templates/H.C2CP.genesets.gmt",package="AMARETTO")
# AMARETTO_HTMLreport(AMARETTOinit = AMARETTOinit,,
#                     AMARETTOresults = AMARETTOresults,
#                     ProcessedData = ProcessedDataLIHC,
#                     hyper_geo_test_bool = TRUE,
#                     hyper_geo_reference = gmt_file,
#                     MSIGDB=TRUE)
# 
# #-------------------------------------------------------------------------------

## ----eval = TRUE, echo = FALSE,size = 8---------------------------------------
TCGA_codes <- c("BLCA BRCA CESC CHOL COAD ESCA GBM HNSC KIRC KIRP LAML LGG LIHC LUAD LUSC OV PAAD PCPG READ SARC STAD THCA THYM UCEC")
TCGA_codes <- strsplit(TCGA_codes,split = " ")[[1]]
TCGA_cancers <- c("bladder urothelial carcinoma","breast invasive carcinoma", "cervical squamous cell carcinoma and endocervical adenocarcinoma",
                  "cholangiocarcinoma","colon adenocarcinoma","esophageal carcinoma", "glioblastoma multiforme",
                  "head and neck squamous cell carcinoma","kidney renal clear cell carcinoma",
                  "kidney renal papillary cell carcinoma", "acute myeloid leukemia",
                  "brain lower grade glioma","liver hepatocellular carcinoma",
                  "lung adenocarcinoma","lung squamous cell carcinoma", 
                  "arian serous cystadenocarcinoma ", "pancreatic adenocarcinoma",
                  "pheochromocytoma and paraganglioma","rectum adenocarcinoma",
                  "sarcoma","stomach adenocarcinoma","thyroid carcinoma",
                  "thymoma","endometrial carcinoma")

tcga_table <- data.frame(TCGA_codes=TCGA_codes,TCGA_cancers=TCGA_cancers)
knitr::kable(tcga_table)


## ----sessionInfo--------------------------------------------------------------
sessionInfo()

