# Code example from 'MBttest' vignette. See references/ for full tutorial.

### R code from vignette source 'MBttest.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex(use.unsrturl=FALSE)


###################################################
### code chunk number 2: options
###################################################
options(width=72)
options(showHeadLines=3)
options(showTailLines=3)


###################################################
### code chunk number 3: MBttest.Rnw:57-59
###################################################
set.seed(102)
options(width = 90)


###################################################
### code chunk number 4: MBttest.Rnw:62-63
###################################################
library(MBttest)


###################################################
### code chunk number 5: MBttest.Rnw:68-70
###################################################
data(jkttcell)
jkttcell[1:10,]


###################################################
### code chunk number 6: MBttest.Rnw:75-76
###################################################
head(jkttcell)


###################################################
### code chunk number 7: MBttest.Rnw:99-100
###################################################
sjknull1<-simulat(yy=jkttcell[1:500,], nci=7,r1=3,r2=3,p=0, q=0.2)


###################################################
### code chunk number 8: MBttest.Rnw:115-116
###################################################
mysim1<-smbetattest(X=sjknull1,na=3,nb=3,alpha=0.05)


###################################################
### code chunk number 9: MBttest.Rnw:172-173
###################################################
res<-mbetattest(X=jkttcell[1:1000,],na=3,nb=3,W=1,alpha=0.05,file="jurkat_NS_48h_tag_mbetattest.csv")


###################################################
### code chunk number 10: MBttest.Rnw:177-179
###################################################
data(dat)
head(dat)


###################################################
### code chunk number 11: MAplot
###################################################
maplot(dat=dat,r1=3,r2=3,TT=350,matitle="MA plot")


###################################################
### code chunk number 12: figMAplot
###################################################
maplot(dat=dat,r1=3,r2=3,TT=350,matitle="MA plot")


###################################################
### code chunk number 13: MAplot50
###################################################
maplot(dat=dat,r1=3,r2=3,TT=50,matitle="MA plot")


###################################################
### code chunk number 14: figMAplot50
###################################################
maplot(dat=dat,r1=3,r2=3,TT=50,matitle="MA plot")


###################################################
### code chunk number 15: heatmapwithtree
###################################################
myheatmap(dat=dat,r1=3,r2=3,maptitle="Jurkat T-cell heatmap2")


###################################################
### code chunk number 16: figheatmapwithtree
###################################################
myheatmap(dat=dat,r1=3,r2=3,maptitle="Jurkat T-cell heatmap2")


###################################################
### code chunk number 17: heatmapwithouttree
###################################################
myheatmap(dat=dat,r1=3,r2=3,tree="none",maptitle="Jurkat T-cell heatmap3")


###################################################
### code chunk number 18: figheatmapwithouttree
###################################################
myheatmap(dat=dat,r1=3,r2=3,tree="none",maptitle="Jurkat T-cell heatmap3")


###################################################
### code chunk number 19: heatmapwithcoltree
###################################################
myheatmap(dat=dat,r1=3,r2=3,colrs="redblue", tree="column",
method="pearson", maptitle="Jurkat T-cell heatmap")


###################################################
### code chunk number 20: figheatmapwithcoltree
###################################################
myheatmap(dat=dat,r1=3,r2=3,colrs="redblue", tree="column",
method="pearson", maptitle="Jurkat T-cell heatmap")


###################################################
### code chunk number 21: MBttest.Rnw:261-262
###################################################
sessionInfo()


