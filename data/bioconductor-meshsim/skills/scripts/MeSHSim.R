# Code example from 'MeSHSim' vignette. See references/ for full tutorial.

### R code from vignette source 'MeSHSim.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=72)


###################################################
### code chunk number 2: main1
###################################################
library(RCurl)
library(XML)
library(MeSHSim)
nodeSim("B03.440.400.425.340", "B03.440.400.425.117.800")


###################################################
### code chunk number 3: main2
###################################################
nodeSim("B03.440.400.425.340", "B03.440.400.425.117.800", method="LC")
nodeSim("B03.440.400.425.340", "B03.440.400.425.117.800", method="Lin")


###################################################
### code chunk number 4: main3
###################################################
nodeList1<-c("B03.440.450.425.800.200", "B03.440.450.900.859.225")
nodeList2<-c("B03.440.400.425.340", "B03.440.400.425.117.800", "B03.440.400.425.127.100")
mnodeSim(nodeList1,nodeList2)


###################################################
### code chunk number 5: main4
###################################################
nodeList1<-c("B03.440.450.425.800.200", "B03.440.450.900.859.225")
nodeList2<-c("B03.440.400.425.340", "B03.440.400.425.117.800", "B03.440.400.425.127.100")
mnodeSim(nodeList1,nodeList2,method="Lord")
mnodeSim(nodeList1,nodeList2,method="Resnik")


###################################################
### code chunk number 6: main5
###################################################
headingSim("Lumbosacral Region", "Body Regions")


###################################################
### code chunk number 7: main6
###################################################
headingSim("Lumbosacral Region", "Body Regions", method="LC")
headingSim("Lumbosacral Region", "Body Regions", method="Lin")


###################################################
### code chunk number 8: main7
###################################################
headingSim("Lumbosacral Region", "Body Regions", method="JC", frame="node")
headingSim("Lumbosacral Region", "Body Regions", method="JC", frame="heading")


###################################################
### code chunk number 9: main8
###################################################
headingList1<-c("Body Regions", "Abdomen", "Abdominal Cavity")
headingList2<-c("Lumbosacral Region", "Body Regions")
mheadingSim(headingList1, headingList2)


###################################################
### code chunk number 10: main9
###################################################
headingList1<-c("Body Regions", "Abdomen", "Abdominal Cavity")
headingList2<-c("Lumbosacral Region", "Body Regions")
mheadingSim(headingList1, headingList2, method="Lord")
mheadingSim(headingList1, headingList2, method="Resnik")


###################################################
### code chunk number 11: main10
###################################################
headingList1<-c("Body Regions", "Abdomen", "Abdominal Cavity")
headingList2<-c("Lumbosacral Region", "Body Regions")
mheadingSim(headingList1, headingList2, method="JC", frame="node")
mheadingSim(headingList1, headingList2, method="JC", frame="heading")


###################################################
### code chunk number 12: main11
###################################################
headingSet1<-c("Body Regions", "Abdomen", "Abdominal Cavity")
headingSet2<-c("Lumbosacral Region", "Body Regions")
headingSetSim(headingSet1, headingSet2)


###################################################
### code chunk number 13: main12
###################################################
headingSet1<-c("Body Regions", "Abdomen", "Abdominal Cavity")
headingSet2<-c("Lumbosacral Region", "Body Regions")
headingSetSim(headingSet1, headingSet2, method="Lord")
headingSetSim(headingSet1, headingSet2, method="Resnik")


###################################################
### code chunk number 14: main13
###################################################
headingSet1<-c("Body Regions", "Abdomen", "Abdominal Cavity")
headingSet2<-c("Lumbosacral Region", "Body Regions")
headingSetSim(headingSet1, headingSet2, method="JC", frame="node")
headingSetSim(headingSet1, headingSet2, method="JC", frame="heading")


###################################################
### code chunk number 15: main14
###################################################
docSim("1111113","1111111")


###################################################
### code chunk number 16: main15
###################################################
docSim("1111113","1111111", method="LC")
docSim("1111113","1111111", method="Lin")


###################################################
### code chunk number 17: main16
###################################################
docSim("1111113","1111111", method="JC", frame="node")
docSim("1111113","1111111", method="JC", frame="heading")


###################################################
### code chunk number 18: main17
###################################################
docSim("1111113","1111111", method="JC", frame="node", major=TRUE)
docSim("1111113","1111111", method="JC", frame="node", major=FALSE)


###################################################
### code chunk number 19: main18
###################################################
library(RCurl)
library(XML)
library(MeSHSim)
docInfo("1111111")


###################################################
### code chunk number 20: main19
###################################################
docInfo("1111111", verbose=TRUE)
docInfo("1111111", verbose=FALSE)


###################################################
### code chunk number 21: main20
###################################################
docInfo("1111111", verbose=FALSE, major=TRUE)
docInfo("1111111", verbose=FALSE, major=FALSE)


###################################################
### code chunk number 22: main21
###################################################
nodeInfo("B03.440.400.425.127.100")


###################################################
### code chunk number 23: main22
###################################################
nodeInfo("B03.440.400",brief=FALSE)


###################################################
### code chunk number 24: main23
###################################################
termInfo("Rhode Island")


###################################################
### code chunk number 25: main24
###################################################
termInfo("Rhode Island",brief=FALSE)


