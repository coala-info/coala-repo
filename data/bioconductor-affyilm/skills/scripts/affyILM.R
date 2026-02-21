# Code example from 'affyILM' vignette. See references/ for full tutorial.

### R code from vignette source 'affyILM.Rnw'

###################################################
### code chunk number 1: affyILM.Rnw:60-63
###################################################
library(affy)
library(gcrma)
require(AffymetrixDataTestFiles)


###################################################
### code chunk number 2: affyILM.Rnw:68-69
###################################################
require(AffymetrixDataTestFiles)


###################################################
### code chunk number 3: affyILM.Rnw:73-74
###################################################
library(affyILM)


###################################################
### code chunk number 4: affyILM.Rnw:77-80
###################################################
path <- system.file("rawData", "FusionSDK_HG-Focus", "HG-Focus", "2.Calvin", 
    package="AffymetrixDataTestFiles")
file1 <- file.path(path,"HG-Focus-1-121502.CEL")


###################################################
### code chunk number 5: affyILM.Rnw:84-85
###################################################
result <- ilm(file1); 


###################################################
### code chunk number 6: affyILM.Rnw:95-96
###################################################
getIntens(result,"AFFX-r2-Ec-bioD-5_at")


###################################################
### code chunk number 7: affyILM.Rnw:102-103
###################################################
plotIntens(result,"AFFX-r2-Ec-bioD-5_at","HG-Focus-1-121502.CEL")


###################################################
### code chunk number 8: affyILM.Rnw:114-116
###################################################
file2 <- file.path(path,"HG-Focus-2-121502.CEL")
result2files <- ilm(c(file1,file2),satLim=12000) 


###################################################
### code chunk number 9: affyILM.Rnw:121-122
###################################################
getIntens(result2files,"AFFX-r2-Ec-bioD-5_at")


###################################################
### code chunk number 10: affyILM.Rnw:132-133
###################################################
getProbeConcs(result2files,"AFFX-r2-Ec-bioD-5_at")


###################################################
### code chunk number 11: affyILM.Rnw:137-141
###################################################
res_1 <- result["AFFX-r2-Ec-bioD-5_at"]
res_1
res_2 <- result[c("AFFX-r2-Ec-bioD-5_at","207218_at")]
res_2


###################################################
### code chunk number 12: affyILM.Rnw:144-148
###################################################
res2_1 <- result2files["AFFX-r2-Ec-bioD-5_at"]
res2_1
res2_2 <- result2files[c("AFFX-r2-Ec-bioD-5_at","207218_at")]
res2_2


###################################################
### code chunk number 13: affyILM.Rnw:156-157
###################################################
pILM<-plotILM(result2files,"AFFX-r2-Ec-bioD-5_at","HG-Focus-1-121502.CEL")


###################################################
### code chunk number 14: affyILM.Rnw:166-167
###################################################
print(str(pILM))


