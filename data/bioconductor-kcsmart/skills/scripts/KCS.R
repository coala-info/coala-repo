# Code example from 'KCS' vignette. See references/ for full tutorial.

### R code from vignette source 'KCS.Rnw'

###################################################
### code chunk number 1: KCS.Rnw:22-23
###################################################
library(KCsmart)


###################################################
### code chunk number 2: KCS.Rnw:26-27
###################################################
data(hsSampleData)


###################################################
### code chunk number 3: KCS.Rnw:30-31
###################################################
str(hsSampleData)


###################################################
### code chunk number 4: KCS.Rnw:38-39
###################################################
data(hsMirrorLocs)


###################################################
### code chunk number 5: KCS.Rnw:42-44
###################################################
spm1mb <- calcSpm(hsSampleData, hsMirrorLocs)
spm4mb <- calcSpm(hsSampleData, hsMirrorLocs, sigma=4000000)


###################################################
### code chunk number 6: KCS.Rnw:49-50
###################################################
plot(spm1mb)


###################################################
### code chunk number 7: KCS.Rnw:56-57
###################################################
plot(spm1mb, chromosomes=c(1, 12, "X"), type="g")


###################################################
### code chunk number 8: KCS.Rnw:63-64
###################################################
sigLevel4mb <- findSigLevelTrad(hsSampleData, spm4mb, n=10, p=0.05)


###################################################
### code chunk number 9: KCS.Rnw:70-71
###################################################
plot(spm4mb, sigLevels=sigLevel4mb, type=1)


###################################################
### code chunk number 10: KCS.Rnw:78-79
###################################################
plot(spm4mb, chromosomes=c(1, 12, "X"), type="g", sigLevels=sigLevel4mb)


###################################################
### code chunk number 11: KCS.Rnw:87-88
###################################################
sigRegions4mb <- getSigSegments(spm4mb,sigLevel4mb)


###################################################
### code chunk number 12: KCS.Rnw:93-94
###################################################
sigRegions4mb


###################################################
### code chunk number 13: KCS.Rnw:99-100
###################################################
sigRegions4mb@gains[[1]]$probes


###################################################
### code chunk number 14: KCS.Rnw:109-110
###################################################
sigLevel1mb <- findSigLevelTrad(hsSampleData, spm1mb, n=10)


###################################################
### code chunk number 15: KCS.Rnw:116-117
###################################################
plotScaleSpace(list(spm1mb, spm4mb), list(sigLevel1mb, sigLevel4mb), type='g')


###################################################
### code chunk number 16: KCS.Rnw:131-132
###################################################
spmc1mb <- calcSpmCollection(hsSampleData, hsMirrorLocs, cl=c(rep(0,10),rep(1,10)), sigma=1000000)


###################################################
### code chunk number 17: KCS.Rnw:137-139
###################################################
spmc1mb.sig <- compareSpmCollection(spmc1mb, nperms=3, method=c("siggenes"))
spmc1mb.sig


###################################################
### code chunk number 18: KCS.Rnw:144-146
###################################################
spmc1mb.sig.regions <- getSigRegionsCompKC(spmc1mb.sig)
spmc1mb.sig.regions


###################################################
### code chunk number 19: KCS.Rnw:152-153
###################################################
plot(spmc1mb.sig, sigRegions=spmc1mb.sig.regions)


