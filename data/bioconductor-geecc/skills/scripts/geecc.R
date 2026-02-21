# Code example from 'geecc' vignette. See references/ for full tutorial.

### R code from vignette source 'geecc.Rnw'

###################################################
### code chunk number 1: prepare_deg
###################################################
library(geecc)
#load marioni data set
data(marioni)
marioni <- marioni[1:15000, ]
# adjust for multiple testing and get probe sets which are 
# at least two-fold regulated and fdr smaller than 5 %
fdr <- p.adjust(marioni[, "Pvalue"], "fdr")
deg.diff <- rownames(marioni)[ which(fdr < 0.05) ]
deg.up <- rownames(marioni)[ which(fdr < 0.05 & marioni[, "logFC"] > 0) ]
deg.down <- rownames(marioni)[ which(fdr < 0.05 & marioni[, "logFC"] < 0) ]
sapply(list(deg.diff, deg.up, deg.down), length)


###################################################
### code chunk number 2: workflow_step1
###################################################
library(GO.db)
library(hgu133plus2.db)

## divide sequence lengths into 33 percent quantiles
seqlen <- setNames(marioni[, "End"] - marioni[, "Start"] + 1, rownames(marioni))
step <- 33; QNTL <- seq(0, 100, step)
qntl <- cbind(quantile(seqlen, prob=QNTL/100), QNTL)
cc <- cut(seqlen, breaks=qntl[,1], labels=qntl[-length(QNTL),2], include.lowest=TRUE)
seqlen.qntl <- cbind(seqlen, cc )

#check if there are three groups of same size
table(seqlen.qntl[,2])

## prepare a list of levels for each category
## restrict to GO category 'cellular component' (CC)
category1 <- list( diff=deg.diff, up=deg.up, down=deg.down )
category2 <- GO2list(db=hgu133plus2GO2PROBE, go.cat="CC")
category3 <- split(rownames(seqlen.qntl), factor(seqlen.qntl[,2]))
names(category3) <- as.character(c(QNTL[1:(length(QNTL)-1)]))

## check content of each category list
lapply(category1[1:3], head)
lapply(category2[1:3], head)
lapply(category3[1:3], head)
CatList <- list(deg=category1, go=category2, len=category3)


###################################################
### code chunk number 3: workflow_step2
###################################################
## run a simple two-way analysis on 'deg' and 'go'
## create a ConCubFilter-object
CCF.obj <- new("concubfilter", names=names(CatList)[1:2], p.value=0.5, 
  test.direction="two.sided", skip.min.obs=2)
## create a ConCub-object
CC.obj <- new("concub", categories=CatList[1:2], population=rownames(marioni), 
  approx=5, null.model=~deg+go)


###################################################
### code chunk number 4: workflow_step3
###################################################
gorange <- names(category2)[1:400]
CC.obj2 <- runConCub( obj=CC.obj, filter=CCF.obj, nthreads=2, subset=list(go=gorange) )


###################################################
### code chunk number 5: workflow_step3a
###################################################
## check current filter settings and change some filters
CCF.obj
drop.insignif.layer(CCF.obj) <- setNames(c(FALSE, TRUE), names(CatList)[1:2])
p.value(CCF.obj) <- 0.01
CCF.obj
CC.obj3 <- filterConCub(obj=CC.obj2, filter=CCF.obj, p.adjust.method="BH")


###################################################
### code chunk number 6: workflow_step4
###################################################
## interpretation of raw GO ids is difficult, use term description
translation <- list( go=setNames(sapply(names(category2), function(v){t <- Term(v); if(is.na(t)){return(v)}else{return(t)}}), names(category2)) )
## pdf("output.2w.pdf")
plotConCub( obj=CC.obj3, filter=CCF.obj, col=list(range=c(-5,5)) 
  , alt.names=translation, t=TRUE, dontshow=list(deg=c("diff"))
  , args_heatmap.2=list(Rowv=TRUE, dendrogram="row", margins=c(3,12))
)
## dev.off()
res2w <- getTable(obj=CC.obj3, na.rm=TRUE)


###################################################
### code chunk number 7: p_adjust (eval = FALSE)
###################################################
## res2wa <- getTable(CC.obj3, na.rm=TRUE, dontshow=list(deg=c("up", "down")))
## res2wa[, 'p.value.bh'] <- p.adjust(res2wa[, 'p.value'], method="BH")
## res2wa <- res2wa[ res2wa[, 'p.value.bh'] <= 0.05, ]


###################################################
### code chunk number 8: example3dmi
###################################################
CCF.obj.3wmi <- new("concubfilter", names=names(CatList), p.value=0.5, 
  test.direction="two.sided", skip.min.obs=2)
CC.obj.3wmi <- new("concub", categories=CatList, population=rownames(marioni), 
  null.model=~deg+go+len)
gorange <- as.character(unique(res2w$go))
CC.obj2.3wmi <- runConCub( obj=CC.obj.3wmi, filter=CCF.obj.3wmi, 
  nthreads=4, subset=list(go=gorange) )
drop.insignif.layer(CCF.obj.3wmi) <- setNames(c(FALSE, TRUE, FALSE), names(CatList))
p.value(CCF.obj.3wmi) <- 0.01
CC.obj3.3wmi <- filterConCub( obj=CC.obj2.3wmi, filter=CCF.obj.3wmi, 
  p.adjust.method="BH")


###################################################
### code chunk number 9: example3dmi_plot
###################################################
## pdf("output.3w.pdf")
plotConCub( obj=CC.obj3.3wmi, filter=CCF.obj.3wmi, col=list(range=c(-5,5)) 
  , alt.names=translation, t=FALSE, dontshow=list(deg=c("diff"))
  , args_heatmap.2=list(Rowv=TRUE, dendrogram="row", margins=c(3,12))
)
## dev.off()
res3wmi <- getTable(obj=CC.obj3.3wmi, na.rm=TRUE)


###################################################
### code chunk number 10: example3wsp1
###################################################
CCF.obj.3wsp1 <- new("concubfilter", names=names(CatList), p.value=0.5, 
  test.direction="two.sided", skip.min.obs=2)
CC.obj.3wsp1 <- new("concub", categories=CatList, population=rownames(marioni), 
  null.model=~deg+go*len)
gorange <- as.character(unique(res3wmi$go))
CC.obj2.3wsp1 <- runConCub( obj=CC.obj.3wsp1, filter=CCF.obj.3wsp1, nthreads=2, 
  subset=list(go=gorange) )
drop.insignif.layer(CCF.obj.3wsp1) <- setNames(c(FALSE, TRUE, FALSE), names(CatList))
p.value(CCF.obj.3wsp1) <- 0.05
CC.obj3.3wsp1 <- filterConCub( obj=CC.obj2.3wsp1, filter=CCF.obj.3wsp1, 
  p.adjust.method="BH")


###################################################
### code chunk number 11: example3wsp1_plot
###################################################
## pdf("output.3w.ji.pdf")
plotConCub( obj=CC.obj3.3wsp1, filter=CCF.obj.3wsp1, col=list(range=c(-5,5))
  , alt.names=translation, t=FALSE, dontshow=list(deg=c("diff"))
  , args_heatmap.2=list(Rowv=TRUE, dendrogram="row", margins=c(3,12))
)
## dev.off()


###################################################
### code chunk number 12: miandsp1
###################################################
res3wsp1 <- getTable(obj=CC.obj3.3wsp1, na.rm=TRUE)
res3wmi_sig <- res3wmi[res3wmi$p.value < 0.05, ]
res3wsp1_sig <- res3wsp1[res3wsp1$p.value < 0.05, ]

head(res3wmi_sig[ !(do.call("paste", res3wmi_sig[,names(CatList)]) 
  %in% do.call("paste", res3wsp1_sig[,names(CatList)])), 1:8])


###################################################
### code chunk number 13: example3wnti
###################################################
CCF.obj.3wnti <- new("concubfilter", names=names(CatList), p.value=0.5, 
  test.direction="two.sided", skip.min.obs=2)
CC.obj.3wnti <- new("concub", categories=CatList, population=rownames(marioni),
  null.model=~len*go+deg*go+deg*len)
gorange <- as.character(unique(res3wmi$go))
CC.obj2.3wnti <- runConCub( obj=CC.obj.3wnti, filter=CCF.obj.3wnti, 
  nthreads=4, subset=list(go=gorange) )
CC.obj3.3wnti <- filterConCub( obj=CC.obj2.3wnti, filter=CCF.obj.3wnti, 
  p.adjust.method="BH")


###################################################
### code chunk number 14: example3wnti_plot
###################################################
## pdf("output.3w.ha.pdf")
plotConCub( obj=CC.obj3.3wnti, filter=CCF.obj.3wnti, col=list(range=c(-5,5))
  , alt.names=translation, t=FALSE, dontshow=list(deg=c("diff"))
  , args_heatmap.2=list(Rowv=TRUE, dendrogram="row", margins=c(3,12))
)
## dev.off()


