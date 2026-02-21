# Code example from 'inferences' vignette. See references/ for full tutorial.

## ----inf1, echo=FALSE, message=FALSE, warning=FALSE---------------------------
library(sesame)
sesameDataCache()
sdf = sesameDataGet('EPIC.1.SigDF')

## ----inf2, message=FALSE------------------------------------------------------
betas = openSesame(sesameDataGet("EPICv2.8.SigDF")[[1]])
inferSex(betas)

## ----nh16, message=FALSE------------------------------------------------------
betas = openSesame(sesameDataGet("MM285.1.SigDF"))
inferSex(betas)

## ----inf4, eval=FALSE---------------------------------------------------------
# betas <- sesameDataGet('HM450.1.TCGA.PAAD')$betas
# ## download clock file from http://zwdzwd.github.io/InfiniumAnnotation
# model <- readRDS("~/Downloads/Clock_Horvath353.rds")
# predictAge(betas, model)

## ----inf18, message=FALSE, eval=FALSE-----------------------------------------
# library(SummarizedExperiment)
# betas <- assay(sesameDataGet("MM285.10.SE.tissue"))[,1]
# ## download clock file from http://zwdzwd.github.io/InfiniumAnnotation
# model <- readRDS("~/Downloads/Clock_Zhou347.rds")
# predictAge(betas, model)

## ----inf7, message=FALSE------------------------------------------------------
betas.tissue <- sesameDataGet('HM450.1.TCGA.PAAD')$betas
estimateLeukocyte(betas.tissue)

## ----inf8, message=FALSE, warning=FALSE, include=FALSE------------------------
library(sesame)
sesameDataCacheAll()

## ----inf10, eval=FALSE--------------------------------------------------------
# 
# deIdentify("~/Downloads/3999492009_R01C01_Grn.idat",
#     "~/Downloads/deidentified_Grn.idat")
# deIdentify("~/Downloads/3999492009_R01C01_Red.idat",
#     "~/Downloads/deidentified_Red.idat")
# 
# betas1 = getBetas(readIDATpair("~/Downloads/3999492009_R01C01"))
# betas2 = getBetas(readIDATpair("~/Downloads/deidentified"))
# 
# head(betas1[grep('rs',names(betas1))])
# head(betas2[grep('rs',names(betas2))])

## ----inf11, eval=FALSE--------------------------------------------------------
# 
# my_secret <- 13412084
# set.seed(my_secret)
# 
# deIdentify("~/Downloads/3999492009_R01C01_Grn.idat",
#     "~/Downloads/deidentified_Grn.idat", randomize=TRUE)
# 
# my_secret <- 13412084
# set.seed(my_secret)
# deIdentify("~/Downloads/3999492009_R01C01_Red.idat",
#     "~/Downloads/deidentified_Red.idat", randomize=TRUE)
# 
# betas1 = getBetas(readIDATpair("~/Downloads/3999492009_R01C01"))
# betas2 = getBetas(readIDATpair("~/Downloads/deidentified"))
# 
# head(betas1[grep('rs',names(betas1))])
# head(betas2[grep('rs',names(betas2))])
# 

## ----inf12, eval=FALSE--------------------------------------------------------
# 
# my_secret <- 13412084
# set.seed(my_secret)
# 
# reIdentify(sprintf("%s/deidentified_Grn.idat", tmp),
#     sprintf("%s/reidentified_Grn.idat", tmp))
# 
# my_secret <- 13412084
# set.seed(my_secret)
# reIdentify("~/Downloads/deidentified_Red.idat",
#     "~/Downloads/reidentified_Red.idat")
# 
# betas1 = getBetas(readIDATpair("~/Downloads/3999492009_R01C01"))
# betas2 = getBetas(readIDATpair("~/Downloads/reidentified"))
# 
# head(betas1[grep('rs',names(betas1))])
# head(betas2[grep('rs',names(betas2))])

## -----------------------------------------------------------------------------
sessionInfo()

