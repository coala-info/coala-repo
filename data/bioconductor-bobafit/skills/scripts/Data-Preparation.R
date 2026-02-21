# Code example from 'Data-Preparation' vignette. See references/ for full tutorial.

## ----style, eval=TRUE, echo = FALSE, results = 'asis'----------------------
BiocStyle::latex()

## ----TCGA download, eval=FALSE---------------------------------------------
# BiocManager::install("TCGAbiolinks")
# library(TCGAbiolinks)
# 
# query <- GDCquery(project = "TCGA-BRCA",
#                   data.category = "Copy Number Variation",
#                   data.type = "Copy Number Segment",
#                   sample.type = "Primary Tumor"
#                   )
# 
# #Selecting first 100 samples using the TCGA barcode
# subset <- query[[1]][[1]]
# barcode <- subset$cases[1:100]
# 
# TCGA_BRCA_CN_segments <- GDCquery(project = "TCGA-BRCA",
#                   data.category = "Copy Number Variation",
#                   data.type = "Copy Number Segment",
#                   sample.type = "Primary Tumor",
#                   barcode = barcode
# )
# 
# GDCdownload(TCGA_BRCA_CN_segments, method = "api", files.per.chunk = 50)
# 
# #prepare a data.frame where working
# data <- GDCprepare(TCGA_BRCA_CN_segments, save = TRUE,
# 		   save.filename= "TCGA_BRCA_CN_segments.txt")
# 

## ----Column preparation, eval=FALSE----------------------------------------
# names(data)
# BOBaFIT_names <- c("ID", "chr", "start", "end", "Num_Probes",
# 		   "Segment_Mean","Sample")
# names(data)<- BOBaFIT_names
# names(data)

## ----tcga load, include=FALSE----------------------------------------------
library(BOBaFIT)
data("TCGA_BRCA_CN_segments")
data <- TCGA_BRCA_CN_segments[1:9]


## ----Popeye, echo=TRUE, message=FALSE--------------------------------------
library(BOBaFIT)
segments <- Popeye(data)

## ----Popeye table, echo=FALSE----------------------------------------------
knitr::kable(head(segments))

## ----CN, echo=TRUE---------------------------------------------------------
#When data coming from SNParray platform are used, the user have to apply the
#compression factor in the formula (0.55). In case of WGS/WES data, the
#correction factor is equal to 1.  
compression_factor <- 0.55
segments$CN <- 2^(segments$Segment_Mean/compression_factor + 1)


## ----CN table, echo=FALSE--------------------------------------------------
knitr::kable(head(segments))

## ----sessionInfo,echo=FALSE------------------------------------------------
sessionInfo()

