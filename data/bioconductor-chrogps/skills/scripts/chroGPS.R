# Code example from 'chroGPS' vignette. See references/ for full tutorial.

### R code from vignette source 'chroGPS.Rnw'

###################################################
### code chunk number 1: import1
###################################################
options(width=70)
par(mar=c(2,2,2,2))
library(chroGPS)
data(s2) # Loading Dmelanogaster S2 modEncode toy example
data(toydists) # Loading precomputed distGPS objects
s2


###################################################
### code chunk number 2: mds1
###################################################
# d <- distGPS(s2, metric='avgdist')
d
mds1 <- mds(d,k=2,type='isoMDS')
mds1
mds1.3d <- mds(d,k=3,type='isoMDS')
mds1.3d


###################################################
### code chunk number 3: figmds1
###################################################
cols <- as.character(s2names$Color)
plot(mds1,drawlabels=TRUE,point.pch=20,point.cex=8,text.cex=.7,
point.col=cols,text.col='black',labels=s2names$Factor,font=2)
legend('topleft',legend=sprintf('R2=%.3f / stress=%.3f',getR2(mds1),getStress(mds1)),
bty='n',cex=1)
#plot(mds1.3d,drawlabels=TRUE,type.3d='s',point.pch=20,point.cex=.1,text.cex=.7,
#point.col=cols,text.col='black',labels=s2names$Factor)


###################################################
### code chunk number 4: figmds1
###################################################
cols <- as.character(s2names$Color)
plot(mds1,drawlabels=TRUE,point.pch=20,point.cex=8,text.cex=.7,
point.col=cols,text.col='black',labels=s2names$Factor,font=2)
legend('topleft',legend=sprintf('R2=%.3f / stress=%.3f',getR2(mds1),getStress(mds1)),
bty='n',cex=1)
#plot(mds1.3d,drawlabels=TRUE,type.3d='s',point.pch=20,point.cex=.1,text.cex=.7,
#point.col=cols,text.col='black',labels=s2names$Factor)


###################################################
### code chunk number 5: figprocrustes0
###################################################
data(s2Seq)
s2Seq


###################################################
### code chunk number 6: figprocrustes1
###################################################
# d2 <- distGPS(c(reduce(s2),reduce(s2Seq)),metric='avgdist')
mds2 <- mds(d2,k=2,type='isoMDS')
cols <- c(as.character(s2names$Color),as.character(s2SeqNames$Color))
sampleid <- c(as.character(s2names$Factor),as.character(s2SeqNames$Factor))
pchs <- rep(c(20,17),c(length(s2),length(s2Seq)))
point.cex <- rep(c(8,5),c(length(s2),length(s2Seq)))
par(mar=c(2,2,2,2))
plot(mds2,drawlabels=TRUE,point.pch=pchs,point.cex=point.cex,text.cex=.7,
point.col=cols,text.col='black',labels=sampleid,font=2)
legend('topleft',legend=sprintf('R2=%.3f / stress=%.3f',getR2(mds2),getStress(mds2)),
bty='n',cex=1)
legend('topright',legend=c('ChIP-Chip','ChIP-Seq'),pch=c(20,17),pt.cex=c(1.5,1))


###################################################
### code chunk number 7: figprocrustes1
###################################################
# d2 <- distGPS(c(reduce(s2),reduce(s2Seq)),metric='avgdist')
mds2 <- mds(d2,k=2,type='isoMDS')
cols <- c(as.character(s2names$Color),as.character(s2SeqNames$Color))
sampleid <- c(as.character(s2names$Factor),as.character(s2SeqNames$Factor))
pchs <- rep(c(20,17),c(length(s2),length(s2Seq)))
point.cex <- rep(c(8,5),c(length(s2),length(s2Seq)))
par(mar=c(2,2,2,2))
plot(mds2,drawlabels=TRUE,point.pch=pchs,point.cex=point.cex,text.cex=.7,
point.col=cols,text.col='black',labels=sampleid,font=2)
legend('topleft',legend=sprintf('R2=%.3f / stress=%.3f',getR2(mds2),getStress(mds2)),
bty='n',cex=1)
legend('topright',legend=c('ChIP-Chip','ChIP-Seq'),pch=c(20,17),pt.cex=c(1.5,1))


###################################################
### code chunk number 8: figprocrustes2
###################################################
adjust <- rep(c('chip','seq'),c(length(s2),length(s2Seq)))
sampleid <- c(as.character(s2names$Factor),as.character(s2SeqNames$Factor))
mds3 <- procrustesAdj(mds2,d2,adjust=adjust,sampleid=sampleid)
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds3,drawlabels=TRUE,point.pch=pchs,point.cex=point.cex,text.cex=.7,
point.col=cols,text.col='black',labels=sampleid,font=2)
legend('topleft',legend=sprintf('R2=%.3f / stress=%.3f',getR2(mds3),getStress(mds3)),
bty='n',cex=1)
legend('topright',legend=c('ChIP-Chip','ChIP-Seq'),pch=c(20,17),pt.cex=c(1.5,1))


###################################################
### code chunk number 9: figpeakwidth1
###################################################
s2.pAdj <- adjustPeaks(c(reduce(s2),reduce(s2Seq)),adjust=adjust,sampleid=sampleid,logscale=TRUE)
# d3 <- distGPS(s2.pAdj,metric='avgdist')
mds4 <- mds(d3,k=2,type='isoMDS')
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds4,drawlabels=TRUE,point.pch=pchs,point.cex=point.cex,text.cex=.7,
point.col=cols,text.col='black',labels=sampleid,font=2)
legend('topleft',legend=sprintf('R2=%.3f / s=%.3f',getR2(mds4),getStress(mds4)),
bty='n',cex=1)
legend('topright',legend=c('ChIP-Chip','ChIP-Seq'),pch=c(20,17),pt.cex=c(1.5,1))


###################################################
### code chunk number 10: figprocrustes2
###################################################
adjust <- rep(c('chip','seq'),c(length(s2),length(s2Seq)))
sampleid <- c(as.character(s2names$Factor),as.character(s2SeqNames$Factor))
mds3 <- procrustesAdj(mds2,d2,adjust=adjust,sampleid=sampleid)
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds3,drawlabels=TRUE,point.pch=pchs,point.cex=point.cex,text.cex=.7,
point.col=cols,text.col='black',labels=sampleid,font=2)
legend('topleft',legend=sprintf('R2=%.3f / stress=%.3f',getR2(mds3),getStress(mds3)),
bty='n',cex=1)
legend('topright',legend=c('ChIP-Chip','ChIP-Seq'),pch=c(20,17),pt.cex=c(1.5,1))


###################################################
### code chunk number 11: figpeakwidth1
###################################################
s2.pAdj <- adjustPeaks(c(reduce(s2),reduce(s2Seq)),adjust=adjust,sampleid=sampleid,logscale=TRUE)
# d3 <- distGPS(s2.pAdj,metric='avgdist')
mds4 <- mds(d3,k=2,type='isoMDS')
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds4,drawlabels=TRUE,point.pch=pchs,point.cex=point.cex,text.cex=.7,
point.col=cols,text.col='black',labels=sampleid,font=2)
legend('topleft',legend=sprintf('R2=%.3f / s=%.3f',getR2(mds4),getStress(mds4)),
bty='n',cex=1)
legend('topright',legend=c('ChIP-Chip','ChIP-Seq'),pch=c(20,17),pt.cex=c(1.5,1))


###################################################
### code chunk number 12: import2
###################################################
s2.tab[1:10,1:4]


###################################################
### code chunk number 13: mds6
###################################################
d <- distGPS(s2.tab, metric='tanimoto', uniqueRows=TRUE)
d
mds1 <- mds(d,k=2,type='isoMDS')
mds1
mds2 <- mds(d,k=3,type='isoMDS')
mds2


###################################################
### code chunk number 14: figmds6
###################################################
par(mar=c(2,2,2,2))
plot(mds1,point.cex=1.5,point.col=densCols(getPoints(mds1)))
#plot(mds2,point.cex=1.5,type.3d='s',point.col=densCols(getPoints(mds2)))


###################################################
### code chunk number 15: uniqueCount
###################################################
dim(s2.tab)
dim(uniqueCount(s2.tab))


###################################################
### code chunk number 16: genomeGPS1
###################################################
system.time(mds3 <- mds(d,k=2,type='isoMDS'))
mds3


###################################################
### code chunk number 17: genomeGPS2
###################################################
system.time(mds3 <- mds(d,type='isoMDS',splitMDS=TRUE,split=.5,overlap=.05,mc.cores=1))
mds3
system.time(mds4 <- mds(d,mds3,type='boostMDS',scale=TRUE))
mds4


###################################################
### code chunk number 18: getxpr
###################################################
summary(s2.wt$epigene)
summary(s2.wt$gene)


###################################################
### code chunk number 19: figmds7
###################################################
plot(mds1,point.cex=1.5,scalecol=TRUE,scale=s2.wt$epigene,
     palette=rev(heat.colors(100)))


###################################################
### code chunk number 20: figmds7
###################################################
plot(mds1,point.cex=1.5,scalecol=TRUE,scale=s2.wt$epigene,
     palette=rev(heat.colors(100)))


###################################################
### code chunk number 21: figclus00
###################################################
h <- hclust(as.dist(as.matrix(d)),method='average')
set.seed(149) # Random seed for the MCMC process within density estimation
clus <- clusGPS(d,mds1,h,ngrid=1000,densgrid=FALSE,verbose=TRUE,
preMerge=TRUE,k=max(cutree(h,h=0.5)),minpoints=20,mc.cores=1)
clus


###################################################
### code chunk number 22: figclus0
###################################################
clus
clusNames(clus)
tabClusters(clus,125)
point.col <- rainbow(length(tabClusters(clus,125)))
names(point.col) <- names(tabClusters(clus,125))
point.col
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds1,point.col=point.col[as.character(clusterID(clus,125))],
point.pch=19)


###################################################
### code chunk number 23: figclus1
###################################################
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds1,point.cex=1.5,point.col='grey')
for (p in c(0.95, 0.50))
plot(clus,type='contours',k=max(cutree(h,h=0.5)),lwd=5,probContour=p,
drawlabels=TRUE,labcex=2,font=2)


###################################################
### code chunk number 24: figclus0
###################################################
clus
clusNames(clus)
tabClusters(clus,125)
point.col <- rainbow(length(tabClusters(clus,125)))
names(point.col) <- names(tabClusters(clus,125))
point.col
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds1,point.col=point.col[as.character(clusterID(clus,125))],
point.pch=19)


###################################################
### code chunk number 25: figclus1
###################################################
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds1,point.cex=1.5,point.col='grey')
for (p in c(0.95, 0.50))
plot(clus,type='contours',k=max(cutree(h,h=0.5)),lwd=5,probContour=p,
drawlabels=TRUE,labcex=2,font=2)


###################################################
### code chunk number 26: figclus2
###################################################
plot(clus,type='stats',k=max(cutree(h,h=0.5)),ylim=c(0,1),col=point.col,cex=2,pch=19,
lwd=2,ylab='CCR',xlab='Cluster ID',cut=0.75,cut.lty=3,axes=FALSE)
axis(1,at=1:length(tabClusters(clus,125)),labels=names(tabClusters(clus,125))); axis(2)
box()


###################################################
### code chunk number 27: figclus2
###################################################
plot(clus,type='stats',k=max(cutree(h,h=0.5)),ylim=c(0,1),col=point.col,cex=2,pch=19,
lwd=2,ylab='CCR',xlab='Cluster ID',cut=0.75,cut.lty=3,axes=FALSE)
axis(1,at=1:length(tabClusters(clus,125)),labels=names(tabClusters(clus,125))); axis(2)
box()


###################################################
### code chunk number 28: figloc1
###################################################
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds1,point.cex=1.5,point.col='grey')
for (p in c(0.5,0.95)) plot(clus,type='contours',k=max(cutree(h,h=0.5)),lwd=5,probContour=p,
drawlabels=TRUE,labcex=2,font=2)
fgenes <- uniqueCount(s2.tab)[,'HP1a_wa184.S2']==1
set.seed(149)
c1 <- contour2dDP(getPoints(mds1)[fgenes,],ngrid=1000,contour.type='none')
for (p in seq(0.1,0.9,0.1)) plotContour(c1,probContour=p,col='black')
legend('topleft',lwd=1,lty=1,col='black',legend='HP1a contours (10 to 90 percent)',bty='n')


###################################################
### code chunk number 29: figloc1
###################################################
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds1,point.cex=1.5,point.col='grey')
for (p in c(0.5,0.95)) plot(clus,type='contours',k=max(cutree(h,h=0.5)),lwd=5,probContour=p,
drawlabels=TRUE,labcex=2,font=2)
fgenes <- uniqueCount(s2.tab)[,'HP1a_wa184.S2']==1
set.seed(149)
c1 <- contour2dDP(getPoints(mds1)[fgenes,],ngrid=1000,contour.type='none')
for (p in seq(0.1,0.9,0.1)) plotContour(c1,probContour=p,col='black')
legend('topleft',lwd=1,lty=1,col='black',legend='HP1a contours (10 to 90 percent)',bty='n')


###################################################
### code chunk number 30: figloc2
###################################################
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds1,point.cex=1.5,point.col='grey')
for (p in c(0.5,0.95)) plot(clus,type='contours',k=max(cutree(h,h=0.5)),lwd=5,probContour=p,
drawlabels=TRUE,labcex=2,font=2)
set.seed(149) # Random seed for random gene sampling
geneset <- sample(rownames(s2.tab),10,rep=FALSE)
mds2 <- geneSetGPS(s2.tab,mds1,geneset,uniqueCount=TRUE)
points(getPoints(mds2),col='black',cex=5,lwd=4,pch=20)
points(getPoints(mds2),col='white',cex=4,lwd=4,pch=20)
text(getPoints(mds2)[,1],getPoints(mds2)[,2],1:nrow(getPoints(mds2)),cex=1.5)
legend('bottomright',col='black',legend=paste(1:nrow(getPoints(mds2)),
geneset,sep=': '),cex=1,bty='n')


###################################################
### code chunk number 31: figloc2
###################################################
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds1,point.cex=1.5,point.col='grey')
for (p in c(0.5,0.95)) plot(clus,type='contours',k=max(cutree(h,h=0.5)),lwd=5,probContour=p,
drawlabels=TRUE,labcex=2,font=2)
set.seed(149) # Random seed for random gene sampling
geneset <- sample(rownames(s2.tab),10,rep=FALSE)
mds2 <- geneSetGPS(s2.tab,mds1,geneset,uniqueCount=TRUE)
points(getPoints(mds2),col='black',cex=5,lwd=4,pch=20)
points(getPoints(mds2),col='white',cex=4,lwd=4,pch=20)
text(getPoints(mds2)[,1],getPoints(mds2)[,2],1:nrow(getPoints(mds2)),cex=1.5)
legend('bottomright',col='black',legend=paste(1:nrow(getPoints(mds2)),
geneset,sep=': '),cex=1,bty='n')


###################################################
### code chunk number 32: figmerge0
###################################################
set.seed(149) # Random seed for MCMC within the density estimate process
clus2 <- clusGPS(d,mds1,h,ngrid=1000,densgrid=FALSE,verbose=TRUE,
preMerge=TRUE,k=max(cutree(h,h=0.2)),minpoints=20,mc.cores=1)


###################################################
### code chunk number 33: figmerge1
###################################################
par(mar=c(2,2,2,2))
clus3 <- mergeClusters(clus2,brake=0,mc.cores=1)
clus3
tabClusters(clus3,330)


###################################################
### code chunk number 34: figmerge1
###################################################
par(mar=c(2,2,2,2))
clus3 <- mergeClusters(clus2,brake=0,mc.cores=1)
clus3
tabClusters(clus3,330)


###################################################
### code chunk number 35: figmerge21
###################################################
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds1,point.cex=1.5,point.col='grey')
for (p in c(0.95, 0.50)) plot(clus2,type='contours',k=max(cutree(h,h=0.2)),
lwd=5,probContour=p,drawlabels=TRUE,labcex=2,font=2)


###################################################
### code chunk number 36: figmerge22
###################################################
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds1,point.cex=1.5,point.col='grey')
for (p in c(0.95, 0.50)) plot(clus3,type='contours',k=max(cutree(h,h=0.2)),
lwd=5,probContour=p)


###################################################
### code chunk number 37: figmerge21
###################################################
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds1,point.cex=1.5,point.col='grey')
for (p in c(0.95, 0.50)) plot(clus2,type='contours',k=max(cutree(h,h=0.2)),
lwd=5,probContour=p,drawlabels=TRUE,labcex=2,font=2)


###################################################
### code chunk number 38: figmerge22
###################################################
par(mar=c(0,0,0,0),xaxt='n',yaxt='n')
plot(mds1,point.cex=1.5,point.col='grey')
for (p in c(0.95, 0.50)) plot(clus3,type='contours',k=max(cutree(h,h=0.2)),
lwd=5,probContour=p)


###################################################
### code chunk number 39: figmerge31
###################################################
plot(clus2,type='stats',k=max(cutree(h,h=0.2)),ylim=c(0,1),lwd=2,
ylab='CCR',xlab='Cluster ID')


###################################################
### code chunk number 40: figmerge32
###################################################
plot(clus3,type='stats',k=max(cutree(h,h=0.2)),ylim=c(0,1),lwd=2,
ylab='CCR',xlab='Cluster ID')


###################################################
### code chunk number 41: figmerge31
###################################################
plot(clus2,type='stats',k=max(cutree(h,h=0.2)),ylim=c(0,1),lwd=2,
ylab='CCR',xlab='Cluster ID')


###################################################
### code chunk number 42: figmerge32
###################################################
plot(clus3,type='stats',k=max(cutree(h,h=0.2)),ylim=c(0,1),lwd=2,
ylab='CCR',xlab='Cluster ID')


###################################################
### code chunk number 43: figprofile1
###################################################
p1 <- profileClusters(s2.tab, uniqueCount = TRUE, clus=clus3, i=max(cutree(h,h=0.2)), 
log2 = TRUE, plt = FALSE, minpoints=0)
# Requires gplots library
library(gplots)
heatmap.2(p1[,1:20],trace='none',col=bluered(100),margins=c(10,12),symbreaks=TRUE,
Rowv=FALSE,Colv=FALSE,dendrogram='none')


###################################################
### code chunk number 44: figprofile1
###################################################
p1 <- profileClusters(s2.tab, uniqueCount = TRUE, clus=clus3, i=max(cutree(h,h=0.2)), 
log2 = TRUE, plt = FALSE, minpoints=0)
# Requires gplots library
library(gplots)
heatmap.2(p1[,1:20],trace='none',col=bluered(100),margins=c(10,12),symbreaks=TRUE,
Rowv=FALSE,Colv=FALSE,dendrogram='none')


###################################################
### code chunk number 45: figmergeReplicates1>>
###################################################
library(caTools)
library(gplots)
library(chroGPS)
data(s2)
data(bg3)
s2
bg3

# Unify replicates
mnames <- sort(unique(intersect(s2names$Factor,bg3names$Factor)))
sel <- s2names$Factor %in% mnames
s2.repset <- mergeReplicates(s2[sel],id=s2names$Factor[sel],mergeBy='any')
sel <- bg3names$Factor %in% mnames
bg3.repset <- mergeReplicates(bg3[sel],id=bg3names$Factor[sel],mergeBy='any')

# Show
names(s2.repset)
names(bg3.repset)

# Generate unified domain names
color2domain <- c('Active','Active','HP1a','Polycomb','Boundaries')
names(color2domain) <- c('lightgreen','purple','lightblue','yellow','grey')
domains <- unique(s2names[s2names$Factor %in% mnames,c('Factor','Color')])
domains$Domain <- color2domain[domains$Color]
rownames(domains) <- domains$Factor

# Compute distances
mc.cores <- ifelse(.Platform$OS.type=='unix',8,1)
d.s2 <- distGPS(GRangesList(s2.repset),metric='avgdist',mc.cores=mc.cores)
d.bg3 <- distGPS(GRangesList(bg3.repset),metric='avgdist',mc.cores=mc.cores)


###################################################
### code chunk number 46: figrep21>>
###################################################
# Compute inter-domain distances
dd.s2 <- domainDist(as.matrix(d.s2),gps='factors',domain=domains$Color,type='inter',plot=FALSE)
dd.bg3 <- domainDist(as.matrix(d.bg3),gps='factors',domain=domains$Color,type='inter',plot=FALSE)
# Random seed
set.seed(149)
# Alterate s2
s2.alt <- s2.repset
df1 <- as.data.frame(s2.repset[['GAF']])[sample(1:(length(s2.repset[['GAF']])/2)),]
df2 <- as.data.frame(s2.repset[['HP1B']])[sample(1:(length(s2.repset[['HP1B']])/2)),]
s2.alt[['EZ']] <- GRanges(rbind(df1,df2))
d.s2.alt <- distGPS(GRangesList(s2.alt),metric='avgdist',mc.cores=mc.cores)
# Plot S2 vs BG3
par(las=1,mar=c(4,8,4,4))
mycors1 <- rev(diag(cor(as.matrix(d.s2),as.matrix(d.bg3))))
barplot(mycors1,horiz=TRUE,xlim=c(0,1),main='S2 / BG3',col=domains[names(mycors1),'Color'],font=2)
for (i in 1:length(summary(mycors1))) abline(v=summary(mycors1)[i],col=i,lwd=2,lty=3)


###################################################
### code chunk number 47: figrep22>>
###################################################
# Plot S2 Altered vs BG3
par(las=1,mar=c(4,8,4,4))
mycors2 <- rev(diag(cor(as.matrix(d.s2.alt),as.matrix(d.bg3))))
barplot(mycors2,horiz=TRUE,xlim=c(0,1),main='S2 Altered / BG3',col=domains[names(mycors2),'Color'],font=2)
for (i in 1:length(summary(mycors2))) abline(v=summary(mycors2)[i],col=i,lwd=2,lty=3)


###################################################
### code chunk number 48: figrankFactorsbyDomain1>>
###################################################
## Rank Factors by Domain, using intra/inter domain distance

data(s2)
data(toydists)
#d <- distGPS(s2,metric='avgdist',mc.cores=mc.cores) # Compute distances
rownames(s2names) <- s2names$ExperimentName

# Known domains
# Call rankFactorsbyDomain for HP1a repression domain, select a combination of 4 factors
library(caTools)
rank.factors.4 <- rankFactorsbyDomain(d,s2names,ranktype='domainDist',selName='Color',selValue='lightblue',k=3,mc.cores=mc.cores) # Test HP1a repression
ddd <- as.data.frame(do.call(rbind,lapply(rank.factors.4,unlist)))
ddd <- ddd[order(ddd$intra,decreasing=FALSE),]
head(ddd)


###################################################
### code chunk number 49: figrankFactorsbyDomain2>>
###################################################
# Using logistic regression to see how well some factors can be predicted by others
glm.rank <- rankFactorsbyProfile(s2.tab,ranktype='glm',glm.threshold=0.75,mc.cores=mc.cores)

# List of results indicating which factor is removed (best predicted by the rest) at each iteration
names(glm.rank)



###################################################
### code chunk number 50: figdiffFactors1>>
###################################################
# Intersect s2 with repliSeq, filter peaks by overlap with origin set
# Assuming the 'orig' objects is a RangedDataList with modEncode S2 origins of Replication for Early to Late timepoints
# Assuming S2 has the 'full' S2 dataset used in Font-Burgada et al. 2014
#s2.origs <- lapply(orig,function(o) GRangesList(mclapply(as.list(s2),function(x) x[x %over% o,],mc.cores=mc.cores)))

# Make distance sets
#d.origs <- lapply(s2.origs,function(x) distGPS(x,metric='avgdist',mc.cores=mc.cores))
#m.origs <- lapply(d.origs,mds,type='isoMDS')

# Now load precomputed data
data(s2)
data(repliSeq)
library(gplots)

# Modify colors and add some transparency
fnames <- s2names$Factor
s2names$Color[s2names$Color=='grey'] <- 'orange'
fcolors <- paste(col2hex(s2names$Color),'BB',sep='')
bcolors <- paste(col2hex(s2names$Color),'FF',sep='')


###################################################
### code chunk number 51: figx0>>
###################################################
# Select time points to compare
m1 <- m.origs[['Early.Mid']]
m2 <- m.origs[['Late']]
## Perform differential Procrustes analysis
df <- diffFactors(m1,m2)
## Plot both maps before and after adjustment
m3 <- df$mds3
par(mfrow=c(1,2))
plot(0,xlim=c(-1,1),ylim=c(-1,1),xlab='',ylab='',xaxt='n',yaxt='n',col='NA')
segments(m1@points[,1],m1@points[,2],m3@points[,1],m3@points[,2],col='red')
par(new=TRUE)
plot(m1,drawlabels=TRUE,labels=s2names$Factor,point.pch=19,point.cex=4,text.cex=0.75,point.col=s2names$Color,main=sprintf('S2@Origins, adjusted (Avgdist-isoMDS)'),font=2,xlim=c(-1,1),ylim=c(-1,1))
par(new=TRUE)
plot(m3,drawlabels=TRUE,labels=s2names$Factor,point.pch=19,point.cex=4,text.cex=0.75,point.col=s2names$Darkcolor,text.col='grey',main='',xaxt='n',yaxt='n',font=2,xlim=c(-1,1),ylim=c(-1,1))


###################################################
### code chunk number 52: figx1
###################################################
## Plot summary of errors by point
par(las=1,mar=c(4,12,4,4)); 
pp <- df$procrustes
barplot(sort(residuals(pp),decreasing=TRUE),horiz=TRUE,xlim=c(0,max(residuals(pp))+.1),col=heat.colors(length(residuals(pp))),main='Procrustes errors')


###################################################
### code chunk number 53: figdiffGenes1>>
###################################################
# Summarize factor replicates with method 'any' so that 1 replicate having the mark is enough
# Assuming s2.tab and bg3.tab contain the full datasets for dm3 genome and all factors used in 
# Font-Burgada et al.# See https://github.com/singlecoated/chroGPS2 for available full datasets 
# to download

# Not run
# s2.tab <- mergeReplicates(s2.tab,s2names$Factor,'any')
# bg3.tab <- mergeReplicates(bg3.tab,bg3names$Factor,'any')

# Join, use common factors. Then use common genes only from those that have at least one mark in both s2 and bg3
# x <- combineGenesMatrix(s2.tab,bg3.tab,'S2','BG3')

# Build map and cluster as always
# d <- distGPS(x,metric='tanimoto',uniqueRows=TRUE)

# m <- mds(d,type='classic',splitMDS=TRUE,split=0.16,mc.cores=mc.cores)
# mm <- mds(d,m,type='boostMDS',samplesize=0.005,mc.cores=mc.cores)

# Cluster
# h <- hclust(as.dist(d@d),method='average')
# clus <- clusGPS(d,mm,h,k=max(cutree(h,h=0.5)),ngrid=10000,mc.cores=mc.cores,recalcDist=FALSE,verbose=FALSE)
# clus.merged <- mergeClusters(clus,brake=0,mc.cores=mc.cores)
# clus
# clus.merged

# Epigenetic cluster profiles
# pc <- profileClusters(x,clus.merged,normalize=TRUE)
# pheatmap(pc,trace='none',scale='none',col=bluered(100))


###################################################
### code chunk number 54: figdiffGenes2>>
###################################################
# Perform differential analysis
# x.diff <- diffGenes(x,mm,clus.merged,label.x='S2',label.y='BG3',clusName=clusNames(clus.merged)[1],fdr=TRUE,mc.cores=mc.cores)

# Select genes changing clusters with FDR 0.05
# xx.diff <- x.diff[x.diff$ClusID.S2!=x.diff$ClusID.BG3 & x.diff$FDR.S2<0.25 & x.diff$FDR.BG3<0.25,]
# xx.diff$CC <- paste(xx.diff$ClusID.S2,xx.diff$ClusID.BG3,sep='.')
# head(sort(table(xx.diff$CC),decreasing=TRUE))


# Perform enrichment test using getEnrichedGO from chippeakanno package for cluster transitions 2.9 and 5.2
# library(ChIPpeakAnno)
# library(org.Dm.eg.db)

# enriched.GO <- lapply(c('2.9','5.2'),function(cc) {
#        fbid <- as.character(xx.diff$geneid[xx.diff$CC==cc])
#            if (length(fbid)>=25)
#                        ans <- getEnrichedGO(annotatedPeak=fbid,orgAnn='org.Dm.eg.db',maxP=0.05,multiAdjMethod='BH')
#            else ans <- NULL
#            return(ans)
#    })

# names(enriched.GO) <- c('2.9','5.2')
# enriched.GO <- enriched.GO[unlist(lapply(enriched.GO,length))>0]
# enriched.GO <- lapply(enriched.GO,function(x) lapply(x,function(y) unique(y[,-ncol(y)])))
# lapply(enriched.GO,head)

# Plot results with diffGPS.plot function
# res.sel <- res[res$ClusID.S2!=res$ClusID.BG3,]

# Plot
# diffGenes.plot(x,mm,clus.merged,res.sel,transitions='10.2',label.x='S2',label.y='BG3',fdr1=0.25,fdr2=0.25)


###################################################
### code chunk number 55: cyto1
###################################################
# For instance if mds1 contains a valid chroGPS$^{factors}$ map.
# gps2xgmml(mds1, fname='chroGPS_factors.xgmml', fontSize=4,
# col=s2names$Color, cex=8)
# And use Cytoscape -> File -> Import -> Network (Multiple File Types) 
# to load the generated .xgmml file


###################################################
### code chunk number 56: plotly1
###################################################
# Not run
# Requires Pandoc
# library(plotly)
# library(gplots)
# For instance if mds1.3d contains a valid 3 dimensional chroGPS$^{factors}$ map from our S2 example data.
# color2domain <- c('Active','RNAPol2','HP1a','Polycomb','Boundaries')
# names(color2domain) <- c('lightgreen','purple','lightblue','yellow','grey')
# xx <- as.data.frame(getPoints(mds1.3d))
# colnames(xx) <- c('x','y','z')
# xx$color <- s2names$Color
# xx$domain <- as.factor(color2domain[xx$color])
# ids <- as.character(s2names$Factor)
# p <- plot <- ly(xx,x=~x,y=~y,z=~z,color=~domain,colors=col2hex(unique(xx$color)),text=ids) %>%
#     add <- markers() %>%
#     layout(title='S2 3D plotLy example',
#              scene = list(xaxis = list(title = 'X'),
#                    yaxis = list(title = 'Y'),
#                    zaxis = list(title = 'Z')))
#htmlwidgets::saveWidget(as <- widget(p), "../reports/chrogps_3d_plotly.html") # export for offline use, requires pandoc


