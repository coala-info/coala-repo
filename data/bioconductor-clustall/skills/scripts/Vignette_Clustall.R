# Code example from 'Vignette_Clustall' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', include=FALSE---------------------
BiocStyle::markdown()
knitr::opts_chunk$set(
  collapse = TRUE,
  cache = FALSE,
  comment = "#>"
)

## ----echo=FALSE---------------------------------------------------------------
table <- data.frame(Nomenclature=c("a","b","c","d"), 
                    `Distance Metric`=rep(c("Correlation", "Gower"), each=2), 
                    `Clustering Method`=c("K-means", "Hierarchical Clustering", 
                                          "K-medoids", "Hierarchical-Clustering"))

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(table, align = c("l", "l", "l"), caption = "ClustAll Stratification Output Interpretation")

## ----installation, eval=FALSE-------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager ")
# 
# BiocManager::install("ClustAll")

## ----load package-------------------------------------------------------------
library(ClustAll)

## ----load data----------------------------------------------------------------
data("BreastCancerWisconsin", package = "ClustAll") 

data_use <- subset(wdbc, select=-ID)

## ----check missing values-----------------------------------------------------
sum(is.na(data_use)) 
dim(data_use)

## ----create ClustAllObject----------------------------------------------------
obj_noNA <- createClustAll(data = data_use, nImputation = NULL, 
                           dataImputed = NULL, colValidation = "Diagnosis")

## ----run ClustAll, results=FALSE----------------------------------------------
obj_noNA1 <- runClustAll(Object = obj_noNA, threads = 2, simplify = FALSE)

## ----check result-------------------------------------------------------------
obj_noNA1

## ----plot1, fig.height=12, fig.width=12, warning=FALSE, fig.cap = "Correlation matrix heatmap. It depcits the similarity between population-robust stratifications. The discontinuous red rectangles highlight alternative stratifications solutions based on those stratifications that exhibit certain level of similarity. The heatmap row annotation describes the combination of parameters —distance metric, clustering method, and embedding number— from which each stratification is derived."----

plotJACCARD(Object = obj_noNA1, stratification_similarity = 0.9, paint = TRUE)

## ----explore representative clusters------------------------------------------
resStratification(Object = obj_noNA1, population = 0.05, 
                  stratification_similarity = 0.9, all = FALSE)

## ----plot2, fig.cap = "Flow and distribution of patients across clusters. Patient transitions between representative stratifications cuts_c_3 and cuts_a_9.", echo = FALSE----
plotSANKEY(Object = obj_noNA1, clusters = c("cuts_c_9","cuts_a_28"), 
           validationData = FALSE)

## ----plot3, fig.cap = "Flow and distribution of patients across clusters. Patient transitions between representative stratifications cuts_c_9 and the ground truth.", echo = FALSE----
plotSANKEY(Object = obj_noNA1, clusters = c("cuts_c_9"), 
           validationData = TRUE)

## ----export stratifications---------------------------------------------------
df <- cluster2data(Object = obj_noNA1,
                   stratificationName = c("cuts_c_9","cuts_a_28","cuts_c_4"))
head(df,3)

## ----validate stratifications-------------------------------------------------
# STRATIFICATION 1
validateStratification(obj_noNA1, "cuts_a_28")
# STRATIFICATION 2
validateStratification(obj_noNA1, "cuts_c_9")
# STRATIFICATION 3
validateStratification(obj_noNA1, "cuts_c_4")

## ----session info-------------------------------------------------------------
sessionInfo()

