# Code example from 'reconsiVignette' vignette. See references/ for full tutorial.

## ----installBioConductor, eval = FALSE----------------------------------------
# library(BiocManager)
# BiocManager::install("reconsi")

## ----installAndLoadGitHub, eval = FALSE---------------------------------------
# library(devtools)
# install_github("CenterForStatistics-UGent/reconsi")

## ----loadReconsi--------------------------------------------------------------
suppressPackageStartupMessages(library(reconsi))
cat("reconsi package version", as.character(packageVersion("reconsi")), "\n")

## ----syntData-----------------------------------------------------------------
#Create some synthetic data with 90% true null hypothesis
 p = 200; n = 50
x = rep(c(0,1), each = n/2)
 mat = cbind(
 matrix(rnorm(n*p/10, mean = 5+x),n,p/10), #DA
 matrix(rnorm(n*p*9/10, mean = 5),n,p*9/10) #Non DA
 )
 #Provide just the matrix and grouping factor, and test using the collapsed null
 fdrRes = reconsi(mat, x)
  #The estimated tail-area false discovery rates.
  estFdr = fdrRes$Fdr

## ----p0-----------------------------------------------------------------------
fdrRes$p0

## ----plotNull-----------------------------------------------------------------
plotNull(fdrRes)

## ----plotApproxCovar----------------------------------------------------------
plotApproxCovar(fdrRes)

## ----plotCovar----------------------------------------------------------------
matBlock = mat
matBlock[x==0,] = matBlock[x==0,] + rep(c(-1,2), each = n*p/4)
fdrResBlock = reconsi(matBlock, x)
plotCovar(fdrResBlock)

## ----customFunction-----------------------------------------------------------
 #With a custom function, here linear regression
fdrResLm = reconsi(mat, x, B = 5e1,
                      test = function(x, y){
fit = lm(y~x)
c(summary(fit)$coef["x","t value"], fit$df.residual)},
distFun = function(q){pt(q = q[1], df = q[2])})

## ----customFunction2----------------------------------------------------------
 #3 groups
 p = 100; n = 60
x = rep(c(0,1,2), each = n/3)
mu0 = 5
 mat = cbind(
 matrix(rnorm(n*p/10, mean = mu0+x),n,p/10), #DA
 matrix(rnorm(n*p*9/10, mean = mu0),n,p*9/10) #Non DA
 )
 #Provide an additional covariate through the 'argList' argument
 z = rpois(n , lambda = 2)
 fdrResLmZ = reconsi(mat, x, B = 5e1,
 test = function(x, y, z){
 fit = lm(y~x+z)
 c(summary(fit)$coef["x","t value"], fit$df.residual)},
distFun = function(q){pt(q = q[1], df = q[2])},
 argList = list(z = z))

## ----kruskal------------------------------------------------------------------
fdrResKruskal = reconsi(mat, x, B = 5e1,
test = function(x, y){kruskal.test(y~x)$statistic}, zValues = FALSE)

## ----resamZvals---------------------------------------------------------------
fdrResKruskalPerm = reconsi(mat, x, B = 5e1,
test = function(x, y){
 kruskal.test(y~x)$statistic}, resamZvals = TRUE)

## ----bootstrap----------------------------------------------------------------
fdrResBootstrap = reconsi(Y = mat, B = 5e1, test = function(y, x, mu){
                                      testRes = t.test(y, mu = mu)
                                      c(testRes$statistic, testRes$parameter)}, argList = list(mu = mu0),
                                  distFun = function(q){pt(q = q[1],
                                                           df = q[2])})

## ----Vandeputte---------------------------------------------------------------
#The grouping and flow cytometry variables are present in the phyloseq object, they only need to be called by their name.
data("VandeputteData")
testVanDePutte = testDAA(Vandeputte, groupName = "Health.status", FCname = "absCountFrozen", B = 1e2L)

## ----vandeputteFdr------------------------------------------------------------
FdrVDP = testVanDePutte$Fdr
quantile(FdrVDP)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

