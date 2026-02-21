# Code example from 'ADAMgui' vignette. See references/ for full tutorial.

## ----BiocManagerGetADAMgui, eval=FALSE----------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)){
#     install.packages("BiocManager")
#     BiocManager::install("ADAMgui")}

## ----GitHubGetADAMgui, eval = FALSE-------------------------------------------
# BiocManager::install('jrybarczyk/ADAMgui')

## ----LoadADAMgui, eval=TRUE, message=FALSE------------------------------------
library(ADAMgui)

## ----eval=TRUE, fig.height=6, fig.width=6-------------------------------------
library(ADAMgui)
data("ResultAnalysisAedes")

## ----eval=TRUE, fig.height=6, fig.width=6-------------------------------------
library(ADAMgui)
data("ResultAnalysisAedes")
dt<-ResultAnalysisAedes[1:10,]

## ----eval=FALSE, fig.height=6, fig.width=6------------------------------------
# write.table(dt,'ResultAnalysisAedes.txt',sep='\t',quote = F,
#     row.names = F,col.names = T)

## ----eval=TRUE, fig.height=6, fig.width=6-------------------------------------
library(ADAMgui)

## ----eval=FALSE, fig.height=6, fig.width=6------------------------------------
#  GFAGpathUi(TRUE)  #Run the app in your default browser.
#  GFAGpathUi(FALSE) #Run the app in R (your local machine).

## ----eval=TRUE, fig.height=6, fig.width=6-------------------------------------
library(ADAM)
library(ADAMgui)

## ----eval=TRUE, fig.height=6, fig.width=6-------------------------------------
data("ResultAnalysisAedes") # GFAG Output data

## ----eval=TRUE, fig.height=6, fig.width=6-------------------------------------
data("ExpressionAedes") # target expression data

## ----eval=TRUE, fig.height=6, fig.width=6-------------------------------------
data("GeneFunctionAedes") # Path-to-Target relationship data

## ----eval=TRUE, fig.height=6, fig.width=6-------------------------------------
data("DiffAedes") # target differential expression

## ----eval=FALSE, fig.height=6, fig.width=6------------------------------------
# 
# # save the GFAG output file
# write.table(dt,'ResultAnalysisAedes.txt',sep='\t',quote = F,
#     row.names = F,col.names = T)
# 
# # save the target expression file
# write.table(dt,'ExpressionAedes.txt',sep='\t',quote = F,
#     row.names = F,col.names = T)
# 
# # save the Path-to-Target relationship file
# write.table(dt,'GeneFunctionAedes.txt',sep='\t',quote = F,
#     row.names = F,col.names = T)
# 
# # save the target differential expression file
# write.table(dt,'DiffAedes.txt',sep='\t',quote = F,
#     row.names = F,col.names = T)

## ----eval=TRUE, fig.height=6, fig.width=6-------------------------------------
library(ADAM)
library(ADAMgui)

## ----eval=FALSE, fig.height=6, fig.width=6------------------------------------
# GFAGtargetUi(TRUE)  #Run the app in your default browser.
# GFAGtargetUi(FALSE) #Run the app in R (your local machine).

## ----SessionInfo, eval=TRUE, message=FALSE, echo=FALSE------------------------
sessionInfo()

