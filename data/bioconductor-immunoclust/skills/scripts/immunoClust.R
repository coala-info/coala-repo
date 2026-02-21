# Code example from 'immunoClust' vignette. See references/ for full tutorial.

### R code from vignette source 'immunoClust.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: stage0
###################################################
library(immunoClust)


###################################################
### code chunk number 3: stage1data
###################################################
data(dat.fcs)
dat.fcs


###################################################
### code chunk number 4: stage1cluster
###################################################
pars=c("FSC-A","SSC-A","FITC-A","PE-A","APC-A","APC-Cy7-A","Pacific Blue-A")
res.fcs <- cell.process(dat.fcs, parameters=pars)


###################################################
### code chunk number 5: stage1summary
###################################################
summary(res.fcs)


###################################################
### code chunk number 6: stage1bias
###################################################
res2 <- cell.process(dat.fcs, bias=0.25)
summary(res2)


###################################################
### code chunk number 7: stage1trans
###################################################
dat.transformed <- trans.ApplyToData(res.fcs, dat.fcs)


###################################################
### code chunk number 8: stage1splom
###################################################
splom(res.fcs, dat.transformed, N=1000)


###################################################
### code chunk number 9: stage1plot
###################################################
plot(res.fcs, data=dat.transformed, subset=c(1,2))


###################################################
### code chunk number 10: stage2data
###################################################
data(dat.exp)
meta<-meta.process(dat.exp, meta.bias=0.3)


###################################################
### code chunk number 11: stage2plot1
###################################################
plot(meta, c(), plot.subset=c(1,2))


###################################################
### code chunk number 12: stage2scatter
###################################################
cls <- clusters(meta,c())
inc <- mu(meta,cls,1) > 20000 & mu(meta,cls,1) < 150000
addLevel(meta,c(1),"leucocytes") <- cls[inc]

cls <- clusters(meta,c(1))
sort(mu(meta,cls,2))
inc <- (mu(meta,cls,2)) < 40000
addLevel(meta,c(1,1), "ly") <- cls[inc]
addLevel(meta,c(1,2), "mo") <- c()
inc <- (mu(meta,cls,2)) > 100000
addLevel(meta,c(1,3), "gr") <- cls[inc]
move(meta,c(1,2)) <- unclassified(meta,c(1))


###################################################
### code chunk number 13: stage2plot2
###################################################
plot(meta, c(1))


###################################################
### code chunk number 14: stage2annotation
###################################################
cls <- clusters(meta,c(1,1))
sort(mu(meta,cls,7))   ## CD3 expression
sort(mu(meta,cls,6))   ## CD4 expression
inc <- mu(meta,cls,7) > 5 & mu(meta,cls,6) > 4
addLevel(meta,c(1,1,1), "CD3+CD4+") <- cls[inc]
inc <- mu(meta,cls,7) > 5 & mu(meta,cls,6) < 4
addLevel(meta,c(1,1,2), "CD3+CD4-") <- cls[inc]
cls <- unclassified(meta,c(1,1))
inc <- (mu(meta,cls,4)) > 3
addLevel(meta,c(1,1,3), "CD19+") <- cls[inc]

cls <- clusters(meta,c(1,2))
inc <- mu(meta,cls,3) > 5 & mu(meta,cls,7) < 5
addLevel(meta,c(1,2,1), "CD14+") <- cls[inc]

cls <- clusters(meta,c(1,3))
inc <- mu(meta,cls,5) > 3 & mu(meta,cls,7) < 5
addLevel(meta,c(1,3,1), "CD15+") <- cls[inc]


###################################################
### code chunk number 15: stage2export
###################################################
tbl <- meta.numEvents(meta, out.unclassified=FALSE)
tbl[,1:5]


###################################################
### code chunk number 16: stage2final
###################################################
plot(meta, c(1,2,1), plot.subset=c(1,2,3,4))


###################################################
### code chunk number 17: sessionInfo
###################################################
toLatex(sessionInfo())


