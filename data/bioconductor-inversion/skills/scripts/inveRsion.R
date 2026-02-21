# Code example from 'inveRsion' vignette. See references/ for full tutorial.

### R code from vignette source 'inveRsion.Rnw'

###################################################
### code chunk number 1: inveRsion.Rnw:42-43
###################################################
library(inveRsion)


###################################################
### code chunk number 2: inveRsion.Rnw:49-50
###################################################
hap <- system.file("extdata", "haplotypesROI.txt", package = "inveRsion")


###################################################
### code chunk number 3: inveRsion.Rnw:56-58
###################################################
hapCode<-codeHaplo(blockSize=5,file=hap,
                                        minAllele=0.3,saveRes=TRUE)


###################################################
### code chunk number 4: inveRsion.Rnw:68-71
###################################################
window<-0.5
scanRes<-scanInv(hapCode,window=window,saveRes=TRUE)
scanRes


###################################################
### code chunk number 5: inveRsion.Rnw:76-77
###################################################
plot(scanRes,which="b",thBic=-Inf)


###################################################
### code chunk number 6: inveRsion.Rnw:85-87
###################################################
invList<-listInv(scanRes,hapCode=hapCode,geno=FALSE,all=FALSE,thBic=0)
invList


###################################################
### code chunk number 7: inveRsion.Rnw:91-93
###################################################
r<-getClassif(invList,thBic=0, wROI=1,bin=FALSE,geno=FALSE)
r[1:10]


###################################################
### code chunk number 8: inveRsion.Rnw:98-99
###################################################
plot(invList,wROI=1)


###################################################
### code chunk number 9: inveRsion.Rnw:106-108
###################################################
r<-getClassif(invList,thBic=0, wROI=1,geno=TRUE)
r[1:10,]


###################################################
### code chunk number 10: inveRsion.Rnw:112-115
###################################################
mem <- system.file("extdata", "mem.txt", package = "inveRsion")
ac<-accBic(invList,classFile=mem,nsub=1000,npoints=10)
ac


###################################################
### code chunk number 11: inveRsion.Rnw:118-120
###################################################
r<-getClassif(invList,thBic=2000, wROI=1,geno=TRUE)
r[1:10,]


