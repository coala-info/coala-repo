# Code example from 'optimalFlow_vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----ej00, eval = FALSE-------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("optimalFLow")

## ----ej0, echo = TRUE, message = FALSE----------------------------------------
library(optimalFlowData)
library(optimalFlow)
library(ellipse)

## ----ej1, echo = TRUE---------------------------------------------------------
database <- buildDatabase(
 dataset_names = paste0('Cytometry', c(2:5, 7:9, 12:17, 19, 21)),
   population_ids = c('Monocytes', 'CD4+CD8-', 'Mature SIg Kappa', 'TCRgd-'))

## ----ej1110, eval = FALSE-----------------------------------------------------
# templates.optimalFlow <-
#   optimalFlowTemplates(
#     database = database
#     )

## ----ej111, echo = TRUE-------------------------------------------------------
templates.optimalFlow <-
  optimalFlowTemplates(
    database = database, templates.number = 5, cl.paral = 1
    )

## ----ej1112, echo = TRUE------------------------------------------------------
length(templates.optimalFlow$templates) # The number of clusters, and, hence, of templates 
length(templates.optimalFlow$templates[[1]]) # The number of elements of the first template, it contains four cell types
templates.optimalFlow$templates[[1]][[1]] # The first element of the first template

## ----ej1113, echo = TRUE------------------------------------------------------
templates.optimalFlow$clustering

## ----ej1114, echo = TRUE------------------------------------------------------
length(templates.optimalFlow$database.elliptical) # the number of elements in the database
length(templates.optimalFlow$database.elliptical[[1]]) # the number of cell types in the first element of the database
templates.optimalFlow$database.elliptical[[1]][[1]] # the parameters corresponding to the first cell type in the first cytometry of the database 

## ----ej2, echo = TRUE---------------------------------------------------------
cytoPlotDatabase(templates.optimalFlow$database.elliptical[which(templates.optimalFlow$clustering == 3)], dimensions = c(4,3), xlim = c(0, 8000), ylim = c(0, 8000), xlab = "", ylab = "")

## ----ej22, eval = FALSE-------------------------------------------------------
# cytoPlotDatabase3d(templates.optimalFlow$database.elliptical[which(templates.optimalFlow$clustering == 3)], dimensions = c(4, 3, 9), xlim = c(0, 8000), ylim = c(0, 8000), zlim = c(0, 8000))

## ----ej3, echo = TRUE---------------------------------------------------------
cytoPlot(templates.optimalFlow$templates[[3]], dimensions = c(4,3), xlim = c(0, 8000), ylim = c(0, 8000), xlab = "", ylab = "")

## ----ej32, eval = FALSE-------------------------------------------------------
# cytoPlot3d(templates.optimalFlow$templates[[3]], dimensions = c(4, 3, 9), xlim = c(0, 8000), ylim = c(0, 8000), zlim = c(0, 8000))

## ----ej4, echo = TRUE---------------------------------------------------------
cytoPlotDatabase(templates.optimalFlow$database.elliptical[which(templates.optimalFlow$clustering == 3)], dimensions = c(4,3), xlim = c(0, 8000), ylim = c(0, 8000), xlab = "", ylab = "", colour = FALSE)

## ----ej42, eval = FALSE-------------------------------------------------------
# cytoPlotDatabase3d(templates.optimalFlow$database.elliptical[which(templates.optimalFlow$clustering == 3)], dimensions = c(4, 3, 9), xlim = c(0, 8000), ylim = c(0, 8000), zlim = c(0, 8000), colour = FALSE)

## ----ej5, echo = TRUE---------------------------------------------------------
templates.optimalFlow.barycenter <- 
  optimalFlowTemplates(
    database = database, templates.number = 5, consensus.method = "k-barycenter",
    barycenters.number = 4, bar.repetitions = 10, alpha.bar = 0.05, cl.paral = 1
    )

## ----ej52, echo = TRUE--------------------------------------------------------
templates.optimalFlow.hdbscan <- 
  optimalFlowTemplates(
    database = database, templates.number = 5, consensus.method = "hierarchical",
    cl.paral = 1
    )

## ----ej6, echo = TRUE---------------------------------------------------------
cytoPlot(templates.optimalFlow.barycenter$templates[[3]], dimensions = c(4,3), xlim = c(0, 8000), ylim = c(0, 8000), xlab = "", ylab = "")

## ----ej62, eval = FALSE-------------------------------------------------------
# cytoPlot3d(templates.optimalFlow.barycenter$templates[[3]], dimensions = c(4, 3, 9), xlim = c(0, 8000), ylim = c(0, 8000), zlim = c(0, 8000))

## ----ej7, echo=TRUE-----------------------------------------------------------
cytoPlot(templates.optimalFlow.hdbscan$templates[[3]], dimensions = c(4,3), xlim = c(0, 8000), ylim = c(0, 8000), xlab = "", ylab = "")

## ----ej72, eval = FALSE-------------------------------------------------------
# cytoPlot3d(templates.optimalFlow.hdbscan$templates[[3]], dimensions = c(4, 3, 9), xlim = c(0, 8000), ylim = c(0, 8000), zlim = c(0, 8000))

## ----ej77, echo = TRUE--------------------------------------------------------
templates.optimalFlow.unsup <-
  optimalFlowTemplates(
    database = database, hclust.method = "hdbscan", cl.paral = 1, consensus.method = "hierarchical"
    )
print(templates.optimalFlow.unsup$clustering)
print(templates.optimalFlow$clustering)
cytoPlot(templates.optimalFlow.unsup$templates[[5]], dimensions = c(4,3), xlim = c(0, 8000), ylim = c(0, 8000), xlab = "", ylab = "")

## ----ej80, echo = TRUE--------------------------------------------------------
test.cytometry <- Cytometry1[which(match(Cytometry1$`Population ID (name)`, c("Monocytes", "CD4+CD8-", "Mature SIg Kappa", "TCRgd-"), nomatch = 0) > 0), ]

## ----ej8, echo = TRUE---------------------------------------------------------
classification.optimalFlow <- 
  optimalFlowClassification(
    test.cytometry[, 1:10], database, templates.optimalFlow, 
    consensus.method = "pooling", cl.paral = 1
    )

## ----ej82, echo = TRUE--------------------------------------------------------
head(classification.optimalFlow$cluster)
table(classification.optimalFlow$cluster)

## ----ej83, echo = TRUE--------------------------------------------------------
length(classification.optimalFlow$clusterings)
table(classification.optimalFlow$clusterings[[1]]$cluster)

## ----ej84, echo = TRUE--------------------------------------------------------
classification.optimalFlow$assigned.template.index
templates.optimalFlow$clustering

## ----ej85, echo = TRUE--------------------------------------------------------
scoreF1.optimalFlow <- optimalFlow::f1Score(classification.optimalFlow$cluster,
                                            test.cytometry, noise.types)
print(scoreF1.optimalFlow)

## ----ej9, echo = TRUE---------------------------------------------------------
classification.optimalFlow.barycenter <-
  optimalFlowClassification(
    test.cytometry[, 1:10],
    database, templates.optimalFlow.barycenter, consensus.method = "k-barycenter", cl.paral = 1
    )

## ----ej92, echo = TRUE--------------------------------------------------------
table(classification.optimalFlow.barycenter$cluster)
classification.optimalFlow.barycenter$cluster.vote

## ----ej922, echo = TRUE-------------------------------------------------------
classification.optimalFlow.barycenter$assigned.template.index
templates.optimalFlow.barycenter$clustering

## ----ej93, echo = TRUE--------------------------------------------------------
scoreF1.optimalFlow.barycenter <- 
  f1ScoreVoting(
    classification.optimalFlow.barycenter$cluster.vote, classification.optimalFlow.barycenter$cluster,
    test.cytometry,
    1.01, noise.types
    )
print(scoreF1.optimalFlow.barycenter$F1_score)

## ----ej10, echo = TRUE--------------------------------------------------------
classification.optimalFlow.hdbscan <-
  optimalFlowClassification(
    test.cytometry[, 1:10],
    database, templates.optimalFlow.hdbscan, consensus.method = "hierarchical", cl.paral = 1
    )
table(classification.optimalFlow.hdbscan$cluster)
classification.optimalFlow.hdbscan$cluster.vote
classification.optimalFlow.hdbscan$assigned.template.index
templates.optimalFlow.hdbscan$clustering
scoreF1.optimalFlow.hdbscan <-
  f1ScoreVoting(
    classification.optimalFlow.hdbscan$cluster.vote, classification.optimalFlow.hdbscan$cluster,
   test.cytometry,
    1.01, noise.types
  )
print(scoreF1.optimalFlow.hdbscan$F1_score)

## ----ej11, echo = TRUE--------------------------------------------------------
classification.optimalFlow.2 <-
  optimalFlowClassification(
    test.cytometry[, 1:10],
    database, templates.optimalFlow, consensus.method = "pooling", classif.method = "matching",
    cost.function = "ellipses", cl.paral = 1
    )
table(classification.optimalFlow.2$cluster)
table(classification.optimalFlow.2$clusterings[[1]]$cluster)
classification.optimalFlow.2$cluster.vote
classification.optimalFlow.2$assigned.template.index
templates.optimalFlow$clustering
scoreF1.optimalFlow.2 <-
  f1ScoreVoting(
    classification.optimalFlow.2$cluster.vote, classification.optimalFlow.2$cluster,
    test.cytometry,
    1.01, noise.types
    )
print(scoreF1.optimalFlow.2$F1_score)

## ----ej12, echo = TRUE--------------------------------------------------------
classification.optimalFlow.3 <-
  optimalFlowClassification(
    test.cytometry[, 1:10],
    database, templates.optimalFlow, consensus.method = "pooling",
    classif.method = "random forest", cl.paral = 1
    )
table(classification.optimalFlow.3$cluster)
classification.optimalFlow.3$assigned.template.index # the cytometry used for learning belongs to the cluster labelled as 1 and is the first of the cytometries in that cluster, hence it is the first cytometry in the database.
templates.optimalFlow$clustering
scoreF1.optimalFlow.3 <-
  optimalFlow::f1Score(classification.optimalFlow.3$cluster,
    test.cytometry,
    noise.types
    )
print(scoreF1.optimalFlow.3)

