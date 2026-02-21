# Code example from 'Rtreemix' vignette. See references/ for full tutorial.

### R code from vignette source 'Rtreemix.Rnw'

###################################################
### code chunk number 1: Rtreemix.Rnw:33-34
###################################################
options(width = 70)


###################################################
### code chunk number 2: Rtreemix.Rnw:76-77
###################################################
library(Rtreemix)


###################################################
### code chunk number 3: Rtreemix.Rnw:87-89
###################################################
data(hiv.data)
show(hiv.data) ## show the RtreemixData object


###################################################
### code chunk number 4: Rtreemix.Rnw:94-96
###################################################
ex.data <- new("RtreemixData", File = paste(path.package(package = "Rtreemix"), "/examples/treemix.pat", sep = ""))
show(ex.data) ## show the RtreemixData object


###################################################
### code chunk number 5: Rtreemix.Rnw:99-102
###################################################
bin.mat <- cbind(c(1, 0, 0, 1, 1), c(0, 1, 0, 0, 1), c(1, 1, 0, 1, 0))
toy.data <- new("RtreemixData", Sample = bin.mat)
show(toy.data)


###################################################
### code chunk number 6: Rtreemix.Rnw:105-110
###################################################
Sample(hiv.data)
Events(hiv.data)
Patients(hiv.data)
eventsNum(hiv.data)
sampleSize(hiv.data)


###################################################
### code chunk number 7: Rtreemix.Rnw:116-118
###################################################
mod <- fit(data = hiv.data, K = 2, equal.edgeweights = TRUE, noise = TRUE)
show(mod)


###################################################
### code chunk number 8: Rtreemix.Rnw:124-125
###################################################
plot(mod, fontSize = 15)


###################################################
### code chunk number 9: Rtreemix.Rnw:132-133
###################################################
plot(mod, k=2, fontSize = 14)


###################################################
### code chunk number 10: Rtreemix.Rnw:137-143
###################################################
Weights(mod)
Trees(mod)
getTree(object = mod, k = 2) ## Get a specific tree component k
edgeData(getTree(object = mod, k = 2), attr = "weight") ## Conditional probabilities assigned to edges of the 2nd tree component
numTrees(mod)
getData(mod)


###################################################
### code chunk number 11: Rtreemix.Rnw:146-149
###################################################
Star(mod)
Resp(mod)
CompleteMat(mod)


###################################################
### code chunk number 12: Rtreemix.Rnw:152-154
###################################################
distr <- distribution(model = mod)
distr$probability


###################################################
### code chunk number 13: Rtreemix.Rnw:157-159
###################################################
rand.mod <- generate(K = 3, no.events = 9, noise.tree = TRUE, prob = c(0.2, 0.8))
show(rand.mod)


###################################################
### code chunk number 14: Rtreemix.Rnw:170-175
###################################################
mod.stat <- likelihoods(model = mod, data = hiv.data)
Model(mod.stat)
getData(mod.stat)
LogLikelihoods(mod.stat)
WLikelihoods(mod.stat)


###################################################
### code chunk number 15: Rtreemix.Rnw:179-180
###################################################
getResp(mod.stat)


###################################################
### code chunk number 16: Rtreemix.Rnw:186-188
###################################################
data <- sim(model = rand.mod, no.draws = 300)
show(data)


