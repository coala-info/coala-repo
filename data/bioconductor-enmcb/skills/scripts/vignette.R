# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----echo=TRUE,warning=FALSE,results='hide'-----------------------------------
#if(!requireNamespace("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#BiocManager::install("EnMCB")

## ----echo=TRUE,warning=FALSE,results='hide'-----------------------------------

suppressPackageStartupMessages(library(EnMCB))

methylation_dataset<-create_demo()

res<-IdentifyMCB(methylation_dataset)


## ----echo=TRUE,warning=FALSE,results='hide'-----------------------------------

MCB<-res$MCBinformation


## ----echo=TRUE,warning=FALSE,results='hide'-----------------------------------

MCB<-MCB[MCB[,"CpGs_num"]>=5,]


## ----echo=TRUE,warning=FALSE,results='hide'-----------------------------------
#simulation for the group data
groups = c(rep("control",200),rep("dis",255))

DiffMCB_resutls<-DiffMCB(methylation_dataset,
                         groups,
                         MCB)$tab


## ----echo=TRUE,warning=FALSE,results='hide'-----------------------------------
# sample the dataset into training set and testing set
trainingset<-colnames(methylation_dataset) %in% sample(colnames(methylation_dataset),0.6*length(colnames(methylation_dataset)))

testingset<-!trainingset

#build the models
library(survival)
data(demo_survival_data)

models<-metricMCB(MCB,
                    training_set = methylation_dataset[,trainingset],
                    Surv = demo_survival_data[trainingset],
                    Method = "cox",ci = TRUE)

#select the best
onemodel<-models$best_cox_model$cox_model


## ----echo=TRUE,warning=FALSE,results='hide'-----------------------------------
newcgdata<-data.frame(t(methylation_dataset[,testingset]))
           
prediction_results<-predict(onemodel, newcgdata)

## ----echo=TRUE,warning=FALSE,results='hide'-----------------------------------
# You can choose one of MCBs:
select_single_one=1

em<-ensemble_model(t(MCB[select_single_one,]),
                    training_set=methylation_dataset[,trainingset],
                    Surv_training=demo_survival_data[trainingset])
                    

## ----echo=TRUE,warning=FALSE,results='hide'-----------------------------------
em_prediction_results<-ensemble_prediction(ensemble_model = em,
                    prediction_data = methylation_dataset[,testingset])

## ----echo=TRUE----------------------------------------------------------------
sessionInfo()

