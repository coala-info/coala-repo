# Code example from 'RLassoCox' vignette. See references/ for full tutorial.

## ----setup, include=FALSE, cache=FALSE--------------------------------------------------
library(knitr)
# set global chunk options
opts_chunk$set(fig.path='figure/minimal-', fig.align='center', fig.show='hold')
options(formatR.arrow=TRUE,width=90)

## ----Installation-----------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("RLassoCox")

## ----load package-----------------------------------------------------------------------
library("RLassoCox")

## ----load data--------------------------------------------------------------------------
data(mRNA_matrix) # gene expression profiles
data(survData)    # survival information
data(dGMMirGraph) # gene interaction network

## ----survData---------------------------------------------------------------------------
head(survData)

## ----Split data set---------------------------------------------------------------------
set.seed(20150122)
train.Idx <- sample(1:dim(mRNA_matrix)[1], floor(2/3*dim(mRNA_matrix)[1]))
test.Idx <- setdiff(1:dim(mRNA_matrix)[1], train.Idx)
x.train <- mRNA_matrix[train.Idx ,]
x.test <- mRNA_matrix[test.Idx ,]
y.train <- survData[train.Idx,]
y.test <- survData[test.Idx,]

## ----Train model------------------------------------------------------------------------
mod <- RLassoCox(x=x.train, y=y.train, globalGraph=dGMMirGraph)

## ----PT---------------------------------------------------------------------------------
head(mod$PT)

## ----Plot-------------------------------------------------------------------------------
plot(mod$glmnetRes)

## ----Print------------------------------------------------------------------------------
print(mod$glmnetRes)

## ----coef-------------------------------------------------------------------------------
head(coef(mod$glmnetRes, s = 0.2))

## ----predict.RLassoCox------------------------------------------------------------------
lp <- predict(object = mod, newx = x.test, s = c(0.1, 0.2))
head(lp)

## ----cv.RLassoCox-----------------------------------------------------------------------
cv.mod <- cvRLassoCox(x=x.train, y=y.train,
                        globalGraph=dGMMirGraph, nfolds = 5)

## ----plot-------------------------------------------------------------------------------
plot(cv.mod$glmnetRes, xlab = "log(lambda)")

## ----optimal lambda---------------------------------------------------------------------
cv.mod$glmnetRes$lambda.min
cv.mod$glmnetRes$lambda.1se

## ----coef.min---------------------------------------------------------------------------
coef.min <- coef(cv.mod$glmnetRes, s = "lambda.min")
coef.min

## ----features---------------------------------------------------------------------------
nonZeroIdx <- which(coef.min[,1] != 0)
features <- rownames(coef.min)[nonZeroIdx]
features
features.coef <- coef.min[nonZeroIdx]
names(features.coef) <- features
features.coef

## ----prediction-------------------------------------------------------------------------
lp <- predict.cvRLassoCox(object = cv.mod, newx = x.test, 
                        s = "lambda.min")
lp

## ----SessionInfo------------------------------------------------------------------------
sessionInfo()

