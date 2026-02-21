# Code example from 'flowType' vignette. See references/ for full tutorial.

### R code from vignette source 'flowType.Rnw'

###################################################
### code chunk number 1: loadlibs
###################################################
library(flowType)
data(DLBCLExample)


###################################################
### code chunk number 2: PropMarkers
###################################################
PropMarkers <- 3:5
MFIMarkers <- PropMarkers
MarkerNames <- c('FS', 'SS','CD3','CD5','CD19')
Res <- flowType(DLBCLExample, PropMarkers, MFIMarkers, 'kmeans', MarkerNames);


###################################################
### code chunk number 3: SingleDPartitions
###################################################
plot(Res, DLBCLExample);


###################################################
### code chunk number 4: PlotPop
###################################################
  plot(Res, "CD3+CD5-CD19+", Frame=DLBCLExample);


###################################################
### code chunk number 5: BarPlot
###################################################
MFIs=Res@MFIs;
Proportions=Res@CellFreqs;
Proportions <- Proportions / max(Proportions)
names(Proportions) <- unlist(lapply(Res@PhenoCodes, 
                      function(x){return(decodePhenotype(
                      x,Res@MarkerNames[PropMarkers],
                      Res@PartitionsPerMarker))}))
rownames(MFIs)=names(Proportions)
index=order(Proportions,decreasing=TRUE)[1:20]
bp=barplot(Proportions[index], axes=FALSE, names.arg=FALSE)
text(bp+0.2, par("usr")[3]+0.02, srt = 90, adj = 0,
     labels = names(Proportions[index]), xpd = TRUE, cex=0.8)
axis(2);
axis(1, at=bp, labels=FALSE);
title(xlab='Phenotype Names', ylab='Cell Proportion')


###################################################
### code chunk number 6: calcNumPops
###################################################
calcNumPops(rep(2,34), 10)


###################################################
### code chunk number 7: calcNumPopsFig
###################################################
plot(log10(sapply(1:10, function(x){calcNumPops(rep(2,34), x)})), ylab='Cell types (log10)', xlab='Cutoff')


###################################################
### code chunk number 8: loadmetadata
###################################################
library(flowType)
data(HIVMetaData)
HIVMetaData <- HIVMetaData[which(HIVMetaData[,'Tube']==2),];


###################################################
### code chunk number 9: readlabels
###################################################
Labels=(HIVMetaData[,2]=='+')+1;


###################################################
### code chunk number 10: loadrawdata
###################################################
library(sfsmisc);
library(flowCore);
data(HIVData)
PropMarkers <- 5:10
MFIMarkers <- PropMarkers
MarkerNames <- c('Time', 'FSC-A','FSC-H','SSC-A','IgG','CD38','CD19','CD3',
                 'CD27','CD20', 'NA', 'NA')
ResList <- fsApply(HIVData, 'flowType', PropMarkers, MFIMarkers, 'kmeans', MarkerNames);


###################################################
### code chunk number 11: CalcProps
###################################################
All.Proportions <- matrix(0,3^length(PropMarkers),length(HIVMetaData[,1]))
rownames(All.Proportions) <- unlist(lapply(ResList[[1]]@PhenoCodes, 
                      function(x){return(decodePhenotype(
                      x,ResList[[1]]@MarkerNames[PropMarkers],
                      ResList[[1]]@PartitionsPerMarker))}))
for (i in 1:length(ResList)){
  All.Proportions[,i] = ResList[[i]]@CellFreqs / ResList[[i]]@CellFreqs[
                   which(rownames(All.Proportions)=='')]
}


###################################################
### code chunk number 12: All.Proportions
###################################################
Pvals <- vector();
EffectSize <- vector();
for (i in 1:dim(All.Proportions)[1]){
  if (length(which(All.Proportions[i,]!=1))==0){
    Pvals[i]=1;
    EffectSize[i]=0;
    next;
  }
  temp=t.test(All.Proportions[i, Labels==1], All.Proportions[i, Labels==2])
  Pvals[i] <- temp$p.value
  EffectSize[i] <- abs(temp$statistic)  
}
Selected <- which(Pvals<0.05);
print(length(Selected))


###################################################
### code chunk number 13: xtabout
###################################################
Selected <- which(p.adjust(Pvals)<0.05);
library(xtable)
MyTable=cbind(rownames(All.Proportions)[Selected], format(Pvals[Selected],
  digits=2), format(p.adjust(Pvals)[Selected],digits=3), 
  format(rowMeans(All.Proportions[Selected,]), digits=3))
colnames(MyTable)=c('Phenotype', 'p-value', 'adjusted p-value', 'cell frequency')
print(xtable(MyTable, caption='The selected phenotypes, their p-values, adjusted p-values, and cell frequencies'), include.rownames=TRUE,
caption.placement = "top");


