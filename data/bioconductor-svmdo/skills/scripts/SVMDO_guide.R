# Code example from 'SVMDO_guide' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  comment = "#>",
  cache = TRUE
)


is_windows <- identical(.Platform$OS.type, "windows")

## ----install, eval=FALSE------------------------------------------------------
# # From Github
# if (!requireNamespace("devtools", quietly=TRUE))
#   install.packages("devtools")
# devtools::install_github("robogeno/SVMDO")

## ----eval = FALSE-------------------------------------------------------------
# # From Biocodunctor
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("SVMDO")

## ----eval = FALSE-------------------------------------------------------------
# #library(SVMDO)
# #Main screen of GUI
# #runGUI()
# # OR
# #SVMDO::runGUI()

## ----echo=FALSE---------------------------------------------------------------
id<-c("TCGA-AA-3662","TCGA-AA-3514","TCGA-D5-6541","...")
tissue_type<-c("Normal","Normal","Tumour","...")
AB1G<-c("Exp_1","Exp_2","Exp_3","...")
A2M<-c("Exp_1","Exp_2","Exp_3","...")
table_prep_1<-data.frame(id,tissue_type,AB1G,A2M)

## ----echo=FALSE---------------------------------------------------------------
id<-c("TCGA-AA-3662","TCGA-AA-3514","TCGA-D5-6541","...")
days_to_death<-c(49,1331,225,"...")
vital_status<-c("Alive","Dead","Dead","...")
table_prep_2<-data.frame(id,days_to_death,vital_status)

## ----,echo=FALSE,  width = 200, height = 50,fig.align = "center",fig.show='hold'----
# two figs side by side
knitr::include_graphics("svmdo_fig_1.png")

## ----,echo=FALSE,  width = 200, height = 50,fig.align = "center",fig.show='hold',fig.cap='Figure-1 SVMDO GUI Sections'----
# two figs side by side
knitr::include_graphics("svmdo_fig_2.png")

## ----SessionInfo, eval=TRUE, message=FALSE, echo=FALSE------------------------
sessionInfo()

