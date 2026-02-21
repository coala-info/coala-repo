# Code example from 'DMRScan_vignette' vignette. See references/ for full tutorial.

## ----data, cache=TRUE---------------------------------------------------------
library(DMRScan)
data(DMRScan.methylationData) ## Load methylation data from chromosome 22, with 52018 CpGs measured
data(DMRScan.phenotypes) ## Load phenotype (end-point for methylation data)

## ----obs, cache = TRUE, depenson='data'---------------------------------------
#observations <- apply(DMRScan.methylationData,1,function(x,y){
#                        summary(glm(y ~ x, 
#                        family = binomial(link = "logit")))$coefficients[2,3]}, 
#                                            y = DMRScan.phenotypes)

observations <- apply(DMRScan.methylationData,1,function(x,y){
                        summary(lm(x ~ y))$coefficients[2,3]}, 
                                           y = DMRScan.phenotypes)
head(observations)

## ----pos, cache = TRUE, depenson = 'obs'--------------------------------------
pos <- matrix(as.integer(unlist(strsplit(names(observations),split="chr|[.]"))), 
                                                ncol = 3, byrow = TRUE)[,-1] 
head(pos)

## ----cache = TRUE, depenson = pos---------------------------------------------
## Minimum number of CpGs in a tested cluster 
min.cpg <- 3  

## Maxium distance (in base-pairs) within a cluster 
## before it is broken up into two seperate cluster
max.gap <- 750  


## ----reg, cache = TRUE, depenson = 'pos'--------------------------------------
regions <- makeCpGregions(observations  = observations, chr = pos[,1], pos = pos[,2], 
                                              maxGap = 750, minCpG = 3)

## ----thres, cache = TRUE, depenson = 'reg'------------------------------------

window.sizes <- 3:7 ## Number of CpGs in the sliding windows 
## (can be either a single number or a sequence)
n.CpG        <- sum(sapply(regions, length)) ## Number of CpGs to be tested
## Estimate the window threshold, based on the number of CpGs and window sizes 
## using important sampling
window.thresholds.importancSampling <- estimateWindowThreshold(nProbe = n.CpG, windowSize = window.sizes, 
                                                                    method = "sampling", mcmc = 10000)

## Estimating the window threshold using the closed form expression
window.thresholds.siegmund <- estimateWindowThreshold(nProbe = n.CpG, windowSize = window.sizes, 
                                                          method = "siegmund")

## ----res, cache = TRUE, depenson = 'thres'------------------------------------
window.thresholds.importancSampling <- estimateWindowThreshold(nProbe = n.CpG, windowSize = window.sizes,
method = "sampling", mcmc = 10000)
dmrscan.results   <- dmrscan(observations = regions, windowSize = window.sizes, 
                                     windowThreshold = window.thresholds.importancSampling)
## Print the result
print(dmrscan.results)

## ----res2, cache = TRUE, depenson = 'thres'-----------------------------------
dmrscan.results   <- dmrscan(observations = regions, windowSize = window.sizes, 
                                windowThreshold = window.thresholds.siegmund)
## Print the result
print(dmrscan.results)

## ----eval = FALSE-------------------------------------------------------------
# # Not run due to time constraints.
#  window.threshold.mcmc <- estimateWindowThreshold(nProbe = n.CpG, windowSize = window.sizes,
#                                 method = "mcmc", mcmc = 1000, nCPU = 1, submethod = "arima",
#                                 model = list(ar = c(0.1,0.03), ma = c(0.04), order = c(2,0,1)))
# 
#  dmrscan.results  <- dmrscan(observations = regions, windowSize = window.sizes,
#                                 windowThreshold = window.thresholds.mcmc)
# # Print the result
# print(dmrscan.results)

## -----------------------------------------------------------------------------
sessionInfo()

