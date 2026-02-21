# Code example from 'penglsVignette' vignette. See references/ for full tutorial.

## ----install, eval = FALSE----------------------------------------------------
# library(BiocManager)
# install("pengls")

## ----loadRCMpackage-----------------------------------------------------------
suppressPackageStartupMessages(library(pengls))
cat("pengls package version", as.character(packageVersion("pengls")), "\n")

## ----spatialToy---------------------------------------------------------------
library(nlme)
n <- 25 #Sample size
p <- 50 #Number of features
g <- 15 #Size of the grid
#Generate grid
Grid <- expand.grid("x" = seq_len(g), "y" = seq_len(g))
# Sample points from grid without replacement
GridSample <- Grid[sample(nrow(Grid), n, replace = FALSE),]
#Generate outcome and regressors
b <- matrix(rnorm(p*n), n , p)
a <- rnorm(n, mean = b %*% rbinom(p, size = 1, p = 0.25), sd = 0.1) #25% signal
#Compile to a matrix
df <- data.frame("a" = a, "b" = b, GridSample)

## ----spatialCorrelation-------------------------------------------------------
# Define the correlation structure (see ?nlme::gls), with initial nugget 0.5 and range 5
corStruct <- corGaus(form = ~ x + y, nugget = TRUE, value = c("range" = 5, "nugget" = 0.5))

## ----spatialFit---------------------------------------------------------------
#Fit the pengls model, for simplicity for a simple lambda
penglsFit <- pengls(data = df, outVar = "a", xNames = grep(names(df), pattern = "b", value =TRUE), glsSt = corStruct, lambda = 0.2, verbose = TRUE)

## ----standardExtract----------------------------------------------------------
penglsFit
penglsCoef <- coef(penglsFit)
penglsPred <- predict(penglsFit)

## ----timeSetup----------------------------------------------------------------
set.seed(354509)
n <- 100 #Sample size
p <- 10 #Number of features
#Generate outcome and regressors
b <- matrix(rnorm(p*n), n , p)
a <- rnorm(n, mean = b %*% rbinom(p, size = 1, p = 0.25), sd = 0.1) #25% signal
#Compile to a matrix
dfTime <- data.frame("a" = a, "b" = b, "t" = seq_len(n))
corStructTime <- corAR1(form = ~ t, value = 0.5)

## ----timeFit------------------------------------------------------------------
penglsFitTime <- pengls(data = dfTime, outVar = "a", verbose = TRUE,
xNames = grep(names(dfTime), pattern = "b", value =TRUE),
glsSt = corStructTime, nfolds = 5, alpha = 0.5)

## -----------------------------------------------------------------------------
penglsFitTime

## ----registerMulticores-------------------------------------------------------
library(BiocParallel)
register(MulticoreParam(2)) #Prepare multithereading

## ----nfolds-------------------------------------------------------------------
nfolds <- 3 #Number of cross-validation folds

## ----cvpengls-----------------------------------------------------------------
penglsFitCV <- cv.pengls(data = df, outVar = "a", xNames = grep(names(df), pattern = "b", value =TRUE), glsSt = corStruct, nfolds = nfolds)

## ----printCV------------------------------------------------------------------
penglsFitCV

## ----1se----------------------------------------------------------------------
penglsFitCV$lambda.1se #Lambda for 1 standard error rule
penglsFitCV$cvOpt #Corresponding R2

## ----extractCv----------------------------------------------------------------
head(coef(penglsFitCV))
penglsFitCV$foldid #The folds used

## ----illustrFolds, fig.width = 8, fig.height = 7------------------------------
set.seed(5657)
randomFolds <- makeFolds(nfolds = nfolds, dfTime, "random", "t")
blockedFolds <- makeFolds(nfolds = nfolds, dfTime, "blocked", "t")
plot(dfTime$t, randomFolds, xlab ="Time", ylab ="Fold")
points(dfTime$t, blockedFolds, col = "red")
legend("topleft", legend = c("random", "blocked"), pch = 1, col = c("black", "red"))

## ----cvpenglsTimeCourse-------------------------------------------------------
penglsFitCVtime <- cv.pengls(data = dfTime, outVar = "a", xNames = grep(names(dfTime), pattern = "b", value =TRUE), glsSt = corStructTime, nfolds = nfolds, cvType = "random")

## ----timeCourseScale----------------------------------------------------------
penglsFitCVtimeCenter <- cv.pengls(data = dfTime, outVar = "a", xNames = grep(names(dfTime), pattern = "b", value =TRUE), glsSt = corStructTime, nfolds = nfolds, cvType = "blocked", transFun = function(x) x-mean(x))
penglsFitCVtimeCenter$cvOpt #Better performance

## ----spatialFitMSE------------------------------------------------------------
penglsFitCVtime <- cv.pengls(data = dfTime, outVar = "a", xNames = grep(names(dfTime), pattern = "b", value =TRUE), glsSt = corStructTime, nfolds = nfolds, loss =  "MSE")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

