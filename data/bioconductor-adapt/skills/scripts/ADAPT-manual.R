# Code example from 'ADAPT-manual' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=FALSE, out.width='70%', fig.align = "center", fig.cap="Workflow of ADAPT"----
knitr::include_graphics('./flowchart.png')

## ----eval=FALSE---------------------------------------------------------------
# # install through GitHub
# if(!require("ADAPT")) BiocManager::install("mkbwang/ADAPT", build_vignettes = TRUE)
# 
# # install through Bioconductor
# if(!require("ADAPT")) BiocManager::install("ADAPT", version="devel",
#                                            build_vignettes = TRUE)
# 

## ----load data----------------------------------------------------------------
library(ADAPT)
data(ecc_saliva)

## ----adapt--------------------------------------------------------------------
saliva_output_noadjust <- adapt(input_data=ecc_saliva, cond.var="CaseStatus", base.cond="Control")
saliva_output_adjust <- adapt(input_data=ecc_saliva, cond.var="CaseStatus", base.cond="Control", adj.var="Site")

## ----getsummary---------------------------------------------------------------
DAtaxa_result <- summary(saliva_output_noadjust, select="da")

## ----printtable---------------------------------------------------------------
head(DAtaxa_result)

## ----volcano, fig.width=5, fig.height=3, fig.align = "center", fig.cap="Volcano plot for differential abundance analysis between saliva samples of children who developed early childhood dental caries and those who didn't"----
plot(saliva_output_noadjust, n.label=5)

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

