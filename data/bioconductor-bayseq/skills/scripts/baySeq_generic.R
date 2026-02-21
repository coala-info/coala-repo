# Code example from 'baySeq_generic' vignette. See references/ for full tutorial.

### R code from vignette source 'baySeq_generic.Rnw'

###################################################
### code chunk number 1: <style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: baySeq_generic.Rnw:31-33
###################################################
set.seed(102)
options(width = 90)


###################################################
### code chunk number 3: baySeq_generic.Rnw:38-39
###################################################
if(require("parallel")) cl <- makeCluster(4) else cl <- NULL


###################################################
### code chunk number 4: baySeq_generic.Rnw:42-53
###################################################
library(baySeq)

normDensityFunction <- function(x, observables, parameters) {
  if(any(sapply(parameters, function(x) any(x < 0)))) return(rep(NA, length(x)))
  dnorm(x, mean = parameters[[2]] * observables$libsizes, sd = parameters[[1]], log = TRUE)
}

normDensity <- new("densityFunction", density = normDensityFunction, initiatingValues = c(0.1, 1),
                equalOverReplicates = c(TRUE, FALSE),
                lower = function(x) 0, upper = function(x) 1 + max(x) * 2,
                stratifyFunction = rowMeans, stratifyBreaks = 10)


###################################################
### code chunk number 5: baySeq_generic.Rnw:58-67
###################################################
data(simData)
CD <- new("countData", data = simData, 
          replicates = c("simA", "simA", "simA", "simA", "simA",
            "simB", "simB", "simB", "simB", "simB"),
          groups = list(NDE = c(1,1,1,1,1,1,1,1,1,1),
                         DE = c(1,1,1,1,1,2,2,2,2,2))
          )
libsizes(CD) <- getLibsizes(CD)
densityFunction(CD) <- normDensity


###################################################
### code chunk number 6: baySeq_generic.Rnw:72-74
###################################################
normCD <- getPriors(CD, cl = cl)
normCD <- getLikelihoods(normCD, cl = cl)


###################################################
### code chunk number 7: baySeq_generic.Rnw:78-90
###################################################
nbinomDensityFunction <- function(x, observables, parameters) {
  if(any(sapply(parameters, function(x) any(x < 0)))) return(NA)
  dnbinom(x, mu = parameters[[1]] * observables$libsizes * observables$seglens, size = 1 / parameters[[2]], log = TRUE)
}

densityFunction(CD) <- new("densityFunction", density = nbinomDensityFunction, initiatingValues = c(0.1, 1),
                          equalOverReplicates = c(FALSE, TRUE),
                          lower = function(x) 0, upper = function(x) 1 + max(x) * 2,
                          stratifyFunction = rowMeans, stratifyBreaks = 10)

nbCD <- getPriors(CD, cl = cl)
nbCD <- getLikelihoods(nbCD, cl = cl)


###################################################
### code chunk number 8: baySeq_generic.Rnw:94-96
###################################################
CD <- getPriors.NB(CD, cl = cl)
CD <- getLikelihoods(CD, cl = cl)


###################################################
### code chunk number 9: plotCompPostLikes
###################################################
plot(exp(CD@posteriors[,2]), exp(nbCD@posteriors[,2]), ylab = "Standard baySeq", xlab = "Generic (NB-distribution) baySeq")


###################################################
### code chunk number 10: plotCompROC
###################################################
TPs <- cumsum(order(CD@posteriors[,2], decreasing = TRUE) %in% 1:100); FPs <- 1:1000 - TPs
nbTPs <- cumsum(order(nbCD@posteriors[,2], decreasing = TRUE) %in% 1:100); nbFPs <- 1:1000 - nbTPs
plot(x = FPs, y = TPs, type = "l")
lines(x = nbFPs, y = nbTPs, col = "red")
legend(x = "bottomright", legend = c("standard baySeq", "Generic (NB-distribution) baySeq"), lty = 1, col = c("black", "red"))


###################################################
### code chunk number 11: figCompPostLikes
###################################################
plot(exp(CD@posteriors[,2]), exp(nbCD@posteriors[,2]), ylab = "Standard baySeq", xlab = "Generic (NB-distribution) baySeq")


###################################################
### code chunk number 12: figCompRoc
###################################################
TPs <- cumsum(order(CD@posteriors[,2], decreasing = TRUE) %in% 1:100); FPs <- 1:1000 - TPs
nbTPs <- cumsum(order(nbCD@posteriors[,2], decreasing = TRUE) %in% 1:100); nbFPs <- 1:1000 - nbTPs
plot(x = FPs, y = TPs, type = "l")
lines(x = nbFPs, y = nbTPs, col = "red")
legend(x = "bottomright", legend = c("standard baySeq", "Generic (NB-distribution) baySeq"), lty = 1, col = c("black", "red"))


###################################################
### code chunk number 13: baySeq_generic.Rnw:139-140
###################################################
  data(pairData)  


###################################################
### code chunk number 14: baySeq_generic.Rnw:144-148
###################################################
pairCD <- new("countData", data = array(c(pairData[,1:4], pairData[,5:8]), dim = c(nrow(pairData), 4, 2)),
                 replicates = c(1,1,2,2),
                 groups = list(NDE = c(1,1,1,1), DE = c(1,1,2,2)),
              densityFunction = bbDensity)


###################################################
### code chunk number 15: baySeq_generic.Rnw:152-153
###################################################
libsizes(pairCD) <- getLibsizes(pairCD)


###################################################
### code chunk number 16: baySeq_generic.Rnw:158-159
###################################################
pairCD <- getPriors(pairCD, samplesize = 1000, cl = cl)


###################################################
### code chunk number 17: baySeq_generic.Rnw:164-165
###################################################
  pairCD <- getLikelihoods(pairCD, pET = 'BIC', nullData = TRUE, cl = cl)


###################################################
### code chunk number 18: baySeq_generic.Rnw:170-171
###################################################
  topCounts(pairCD, group = 2)


###################################################
### code chunk number 19: baySeq_generic.Rnw:174-175
###################################################
  topCounts(pairCD, group = 1)


###################################################
### code chunk number 20: baySeq_generic.Rnw:185-187 (eval = FALSE)
###################################################
## # FAILS Bioc 3.17
## CDv <- getLikelihoods(nbCD, modelPriorSets = list(A = 1:100, B = 101:1000), cl = cl)


###################################################
### code chunk number 21: baySeq_generic.Rnw:191-192 (eval = FALSE)
###################################################
## CDv@priorModels


###################################################
### code chunk number 22: plotCompVROC (eval = FALSE)
###################################################
## TPs <- cumsum(order(CD@posteriors[,2], decreasing = TRUE) %in% 1:100); FPs <- 1:1000 - TPs
## nbTPs <- cumsum(order(nbCD@posteriors[,2], decreasing = TRUE) %in% 1:100); nbFPs <- 1:1000 - nbTPs
## vTPs <- cumsum(order(CDv@posteriors[,2], decreasing = TRUE) %in% 1:100); vFPs <- 1:1000 - vTPs
## plot(x = FPs, y = TPs, type = "l")
## lines(x = nbFPs, y = nbTPs, col = "red")
## lines(x = vFPs, y = vTPs, col = "blue")
## legend(x = "bottomright", legend = c("standard", "Generic (NB-distribution)", "Variable model priors"), lty = 1, col = c("black", "red", "blue"))


###################################################
### code chunk number 23: figCompVRoc (eval = FALSE)
###################################################
## TPs <- cumsum(order(CD@posteriors[,2], decreasing = TRUE) %in% 1:100); FPs <- 1:1000 - TPs
## nbTPs <- cumsum(order(nbCD@posteriors[,2], decreasing = TRUE) %in% 1:100); nbFPs <- 1:1000 - nbTPs
## vTPs <- cumsum(order(CDv@posteriors[,2], decreasing = TRUE) %in% 1:100); vFPs <- 1:1000 - vTPs
## plot(x = FPs, y = TPs, type = "l")
## lines(x = nbFPs, y = nbTPs, col = "red")
## lines(x = vFPs, y = vTPs, col = "blue")
## legend(x = "bottomright", legend = c("standard", "Generic (NB-distribution)", "Variable model priors"), lty = 1, col = c("black", "red", "blue"))


###################################################
### code chunk number 24: baySeq_generic.Rnw:219-236
###################################################
data(zimData)
CD <- new("countData", data = zimData, 
          replicates = c("simA", "simA", "simA", "simA", "simA",
            "simB", "simB", "simB", "simB", "simB"),
          groups = list(NDE = c(1,1,1,1,1,1,1,1,1,1),
                         DE = c(1,1,1,1,1,2,2,2,2,2))
          )
libsizes(CD) <- getLibsizes(CD)
densityFunction(CD) <- nbinomDensity

CD <- getPriors(CD, cl = cl)
CD <- getLikelihoods(CD, cl = cl)

CDz <- CD
densityFunction(CDz) <- ZINBDensity
CDz <- getPriors(CDz, cl = cl)
CDz <- getLikelihoods(CDz, cl = cl)


###################################################
### code chunk number 25: baySeq_generic.Rnw:241-242
###################################################
if(!is.null(cl)) stopCluster(cl)


###################################################
### code chunk number 26: baySeq_generic.Rnw:247-248
###################################################
sessionInfo()


###################################################
### code chunk number 27: baySeq_generic.Rnw:255-281 (eval = FALSE)
###################################################
## data(pairData)  
## 
## 
## multCD <- new("countData", data = list(pairData[,1:4], pairData[,5:8], 
##                              matrix(round(abs(rnorm(n = prod(dim(pairData[,5:8])), mean = pairData[,5:8] * 4, sd = 3))), ncol = 4),
##                              matrix(round(abs(rnorm(n = prod(dim(pairData[,5:8])), mean = pairData[,5:8] * 20, sd = 3))), ncol = 4),
## matrix(round(abs(rnorm(n = prod(dim(pairData[,5:8])), mean = pairData[,5:8] * 10, sd = 3))), ncol = 4)),
## replicates = c(1,1,2,2),
## groups = list(NDE = c(1,1,1,1), DE = c(1,1,2,2)))
## 
## libsizes(multCD) <- matrix(round(runif(4*5, 30000, 90000)), nrow = 4)
## 
## mdDensity@initiatingValues <- c(0.01, rep(1/dim(multCD@data)[3], dim(multCD@data)[3] - 1))
## mdDensity@equalOverReplicates <- c(TRUE, rep(FALSE, dim(multCD@data)[3] - 1))
## 
## densityFunction(multCD) = mdDensity
## 
## 
## multCD <- getPriors(multCD, samplesize = 1000, cl = cl)
## multCD <- getLikelihoods(multCD, subset = 1:1000, cl = cl)
## 
## TPs <- cumsum(order(multCD@posteriors[,2], decreasing = TRUE) %in% 1:100)
## FPs <- 1:nrow(multCD) - TPs
## 
## plot(FPs / max(FPs), TPs / max(TPs))
## 


