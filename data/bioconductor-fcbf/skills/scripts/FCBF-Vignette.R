# Code example from 'FCBF-Vignette' vignette. See references/ for full tutorial.

## ----setup, include = TRUE-----------------------------------------------
library(knitr)
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval = FALSE-------------------------------------------------------
#  BiocManager::install("FCBF")

## ------------------------------------------------------------------------
library("FCBF")
library(SummarizedExperiment)
# load expression data
data(scDengue)
exprs <- SummarizedExperiment::assay(scDengue,'logcounts')
head(exprs[,1:4])

## ------------------------------------------------------------------------

# discretize expression data
discrete_expression <- as.data.frame(discretize_exprs(exprs))

head(discrete_expression[,1:4])


## ------------------------------------------------------------------------

#load annotation data
infection <- SummarizedExperiment::colData(scDengue)


# get the class variable
#(note, the order of the samples is the same as in the exprs file)
target <- infection$infection

## ------------------------------------------------------------------------
# you only need to run that if you want to see the error for yourself
# fcbf_features <- fcbf(discrete_expression, target, verbose = TRUE)

## ------------------------------------------------------------------------
su_plot(discrete_expression,target)

## ------------------------------------------------------------------------

fcbf_features <- fcbf(discrete_expression, target, thresh = 0.05, verbose = TRUE)


## ------------------------------------------------------------------------
mini_single_cell_dengue_exprs <- exprs[fcbf_features$index,]

vars <- sort(apply(exprs, 1, var, na.rm = TRUE), decreasing = TRUE)
data_top_100_vars <- exprs[names(vars)[1:100], ]


## ------------------------------------------------------------------------

#first transpose the tables and make datasets as caret likes them

dataset_fcbf <- cbind(as.data.frame(t(mini_single_cell_dengue_exprs)),target_variable = target)
dataset_100_var <- cbind(as.data.frame(t(data_top_100_vars)),target_variable = target)

library('caret')
library('mlbench')

control <- trainControl(method="cv", number=5, classProbs=TRUE, summaryFunction=twoClassSummary)


## ------------------------------------------------------------------------

svm_fcbf <-
  train(target_variable ~ .,
        metric="ROC",
        data = dataset_fcbf,
        method = "svmRadial",
        trControl = control)

svm_top_100_var <-
  train(target_variable ~ .,
        metric="ROC",
        data = dataset_100_var,
        method = "svmRadial",
        trControl = control)

svm_fcbf_results <- svm_fcbf$results[svm_fcbf$results$ROC == max(svm_fcbf$results$ROC),]
svm_top_100_var_results <- svm_top_100_var$results[svm_top_100_var$results$ROC == max(svm_top_100_var$results$ROC),]

cat(paste0("For top 100 var: \n",
  "ROC = ",  svm_top_100_var_results$ROC, "\n",
             "Sensitivity  = ", svm_top_100_var_results$Sens, "\n",
             "Specificity  = ", svm_top_100_var_results$Spec, "\n\n",
  "For FCBF: \n",
  "ROC = ",  svm_fcbf_results$ROC, "\n",
             "Sensitivity  = ", svm_fcbf_results$Sens, "\n",
             "Specificity  = ", svm_fcbf_results$Spec))

cat(paste0("For top 100 var: \n",
  "ROC = ",  svm_top_100_var_results$ROC, "\n",
             "Sensitivity  = ", svm_top_100_var_results$Sens, "\n",
             "Specificity  = ", svm_top_100_var_results$Spec, "\n\n",
  "For FCBF: \n",
  "ROC = ",  svm_fcbf_results$ROC, "\n",
             "Sensitivity  = ", svm_fcbf_results$Sens, "\n",
             "Specificity  = ", svm_fcbf_results$Spec))



