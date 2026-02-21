# Code example from 'kimod-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'kimod-vignette.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Package
###################################################

library("kimod")


###################################################
### code chunk number 2: Data
###################################################
data(NCI60Selec_ESet)


###################################################
### code chunk number 3: Data
###################################################
class(NCI60Selec_ESet)


###################################################
### code chunk number 4: Head
###################################################
lapply(NCI60Selec_ESet,dim)


###################################################
### code chunk number 5: Head
###################################################
Tissues<-c(rep("Breast",5),rep("CNS",6),rep("Colon",7),
rep("Leukemia",6),rep("Melanoma",10),rep("Lung",9),
rep("Ovarian",7),rep("Prostate",2),rep("Renal",8))


###################################################
### code chunk number 6: Head
###################################################
Names<-sapply(NCI60Selec_ESet,rownames)


###################################################
### code chunk number 7: Head
###################################################
unique(apply(Names[,-1],2,function(y)identical(y,Names[,1])))


###################################################
### code chunk number 8: Head
###################################################
Z1<-DiStatis(NCI60Selec_ESet)


###################################################
### code chunk number 9: Head
###################################################
class(Z1)


###################################################
### code chunk number 10: code
###################################################
RVPlot(Z1)


###################################################
### code chunk number 11: kimod-vignette.Rnw:181-182
###################################################
RVPlot(Z1,barPlot=FALSE)


###################################################
### code chunk number 12: Head
###################################################
Tissues<-c(rep("Breast",5),rep("CNS",6),rep("Colon",7),
rep("Leukemia",6),rep("Melanoma",10),rep("Lung",9),
rep("Ovarian",7),rep("Prostate",2),rep("Renal",8))


###################################################
### code chunk number 13: Head
###################################################
Colours<-c(rep(colors()[657],5),rep(colors()[637],6),
 rep(colors()[537],7),rep(colors()[552],6),rep(colors()[57],10),
 rep(colors()[300],9),rep(colors()[461],7),rep(colors()[450],2),
 rep(colors()[432],8))


###################################################
### code chunk number 14: Code2
###################################################
CompPlot(Z1,xlabBar="",colObs=Colours,pch=15,las=1,
 cex=2,legend=FALSE,barPlot=FALSE,cex.main=0.6,cex.lab=0.6,
 cex.axis=0.6,las=1)
 legend("topleft",unique(Tissues),col=unique(Colours),
 bty="n",pch=16,cex=1)


###################################################
### code chunk number 15: kimod-vignette.Rnw:216-221
###################################################
CompPlot(Z1,xlabBar="",colObs=Colours,pch=15,las=1,
 cex=2,legend=FALSE,barPlot=FALSE,cex.main=0.6,cex.lab=0.6,
 cex.axis=0.6,las=1)
 legend("topleft",unique(Tissues),col=unique(Colours),
 bty="n",pch=16,cex=1)


###################################################
### code chunk number 16: Code3
###################################################
B<-Bootstrap(Z1)
BootPlot(B,Points=FALSE,cex.lab=0.7,cex.axis=0.7,
 las=1,xlimi=c(-0.003,0.002),ylimi=c(-0.005,0.007)
 ,legend=FALSE,col=Colours)
 legend("topleft",unique(Tissues),col=unique(Colours),
 bty="n",pch=16,cex=1)
Comparisions.Boot(B)



###################################################
### code chunk number 17: kimod-vignette.Rnw:247-252
###################################################
BootPlot(B,Points=FALSE,cex.lab=0.7,cex.axis=0.7,
 las=1,xlimi=c(-0.003,0.002),ylimi=c(-0.005,0.007)
 ,legend=FALSE,col=Colours)
 legend("topleft",unique(Tissues),col=unique(Colours),
 bty="n",pch=16,cex=1)


###################################################
### code chunk number 18: Code4
###################################################
M1<-SelectVar(Z1,Crit="R2-Adj",perc=0.95)
layout(matrix(c(1,1,1,1,1,1,2,2),c(1,1,1,1,1,1,2,2),byrow=TRUE))
Biplot(M1,labelObs = FALSE,labelVars=FALSE,
       colObs=Colours,Type="SQRT",las=1,cex.axis=0.8,
       cex.lab=0.8,xlimi=c(-3,3),ylimi=c(-3,3))

plot(0,type='n',axes=FALSE,ann=FALSE)
legend("topright",unique(Tissues),col=unique(Colours),
       bty="n",pch=15,cex=1)


###################################################
### code chunk number 19: kimod-vignette.Rnw:276-284
###################################################
layout(matrix(c(1,1,1,1,1,1,2,2),c(1,1,1,1,1,1,2,2),byrow=TRUE))
Biplot(M1,labelObs = FALSE,labelVars=FALSE,
       colObs=Colours,Type="SQRT",las=1,cex.axis=0.8,
       cex.lab=0.8,xlimi=c(-3,3),ylimi=c(-3,3))

plot(0,type='n',axes=FALSE,ann=FALSE)
legend("topright",unique(Tissues),col=unique(Colours),
       bty="n",pch=15,cex=1)


###################################################
### code chunk number 20: kimod-vignette.Rnw:296-304
###################################################
layout(matrix(c(1,1,1,1,1,1,2,2),c(1,1,1,1,1,1,2,2),byrow=TRUE))
Biplot(M1,labelObs = FALSE,labelVars=FALSE,
       colObs=Colours,Type="SQRT",las=1,cex.axis=0.8,
       cex.lab=0.8,xlimi=c(-3,3),ylimi=c(-3,3),Groups=TRUE,NGroups=4)

plot(0,type='n',axes=FALSE,ann=FALSE)
legend("topright",unique(Tissues),col=unique(Colours),
       bty="n",pch=15,cex=1)


###################################################
### code chunk number 21: Code6
###################################################

A1<-GroupProj(M1,method="ward",metric="euclidean",NGroups=4)
head(SortList(A1)[[1]])



###################################################
### code chunk number 22: Code7
###################################################

A1<-GroupProj(M1,method="ward",metric="euclidean",NGroups=4)
Groups(A1)


###################################################
### code chunk number 23: Session Info
###################################################
sessionInfo()


