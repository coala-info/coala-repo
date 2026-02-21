# Code example from 'pvca' vignette. See references/ for full tutorial.

### R code from vignette source 'pvca.Rnw'

###################################################
### code chunk number 1: install (eval = FALSE)
###################################################
##   if (!requireNamespace("BiocManager", quietly=TRUE))
##       install.packages("BiocManager")
##   BiocManager::install("pvca")


###################################################
### code chunk number 2: example
###################################################
library(golubEsets)
library(pvca)

data(Golub_Merge)
pct_threshold <- 0.6
batch.factors <- c("ALL.AML", "BM.PB", "Source")

pvcaObj <- pvcaBatchAssess (Golub_Merge, batch.factors, pct_threshold) 



###################################################
### code chunk number 3: plot (eval = FALSE)
###################################################
## bp <- barplot(pvcaObj$dat,  xlab = "Effects", 
## 	ylab = "Weighted average proportion variance", 
## 	ylim= c(0,1.1),col = c("blue"), las=2, 
## 	main="PVCA estimation bar chart")
## axis(1, at = bp, labels = pvcaObj$label, xlab = "Effects", cex.axis = 0.5, las=2)
## values = pvcaObj$dat
## new_values = round(values , 3)
## text(bp,pvcaObj$dat,labels = new_values, pos=3, cex = 0.8) 
## 


###################################################
### code chunk number 4: <
###################################################
  print(sessionInfo())


