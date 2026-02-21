# Code example from 'msmsTests-Vignette2' vignette. See references/ for full tutorial.

### R code from vignette source 'msmsTests-Vignette2.Rnw'

###################################################
### code chunk number 1: msmsTests-Vignette2.Rnw:49-50
###################################################
options(continue=" ")


###################################################
### code chunk number 2: SetupChunk
###################################################
library(msmsTests)
data(msms.dataset)
msms.dataset
msms.counts <- exprs(msms.dataset)
dim(msms.counts)
table(pData(msms.dataset)$treat,pData(msms.dataset)$batch)


###################################################
### code chunk number 3: DistChunk
###################################################
idx <- grep("HUMAN",featureNames(msms.dataset)) 
mSpC <- t( apply(msms.counts[idx,],1,function(x) 
                   tapply(x,pData(msms.dataset)$treat,mean)) )
apply(mSpC,2,summary)


###################################################
### code chunk number 4: PCAChunk
###################################################
snms <- substr(as.character(pData(msms.dataset)$treat),1,2)
snms <- paste(snms,as.integer(pData(msms.dataset)$batch),sep=".")
smpl.pca <- counts.pca(msms.dataset,snms=snms)$pca


###################################################
### code chunk number 5: msmsTests-Vignette2.Rnw:95-98
###################################################
par(mar=c(4,4,0.5,2)+0.1)
facs <- data.frame(batch=pData(msms.dataset)$batch)
counts.pca(msms.dataset,facs=facs,snms=snms)


###################################################
### code chunk number 6: SubsetChunk
###################################################
###  Subset and pre-process dataset
fl <- pData(msms.dataset)$batch=="2502"
e <- msms.dataset[,fl]
e <- pp.msms.data(e)
### Null and alternative model
null.f <- "y~1"
alt.f <- "y~treat"
### Normalizing condition
counts <- exprs(e)
div <- apply(counts,2,sum)
### Quasi-likelihood GLM
ql.res <- msms.glm.qlll(e,alt.f,null.f,div=div)
### Adjust p-values with FDR control.
adjp <- p.adjust(ql.res$p.value,method="BH")
###  Truth table
nh <- length(grep("HUMAN",featureNames(e)))
ny <- length(grep("HUMAN",featureNames(e),invert=TRUE))
tp <- length(grep("HUMAN",rownames(ql.res)[adjp<=0.05]))
fp <- sum(adjp<=0.05)-tp
(tt.ql1 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp))


###################################################
### code chunk number 7: SubsetFChunk
###################################################
###  Post-test filter
ql.tbl <- test.results(ql.res,e,pData(e)$treat,"U600","U200",div,
                    alpha=0.05,minSpC=2,minLFC=1,method="BH")$tres
ql.nms <- rownames(ql.tbl)[ql.tbl$DEP]
###  Truth table
ridx <- grep("HUMAN",ql.nms)
tp <- length(ridx)
fp <- length(ql.nms)-length(ridx)
(tt.ql11 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp))


###################################################
### code chunk number 8: GlobalChunk
###################################################
###  Pre-process dataset
gble <- pp.msms.data(msms.dataset)
### Null and alternative model
null.f <- "y~1"
alt.f <- "y~treat"
### Normalizing condition
div <- apply(exprs(gble),2,sum)
### Quasi-likelihood GLM
ql.res <- msms.glm.qlll(gble,alt.f,null.f,div=div)
### Adjust p-values with FDR control.
adjp <- p.adjust(ql.res$p.value,method="BH")
###  Truth table
nh <- length(grep("HUMAN",featureNames(gble)))
ny <- length(grep("HUMAN",featureNames(gble),invert=TRUE))
tp <- length(grep("HUMAN",rownames(ql.res)[adjp<=0.05]))
fp <- sum(adjp<=0.05)-tp
(tt.ql2 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp))


###################################################
### code chunk number 9: GlobalFChunk
###################################################
###  Post-test filter
ql.tbl <- test.results(ql.res,gble,pData(gble)$treat,"U600","U200",div,
                    alpha=0.05,minSpC=2,minLFC=1,method="BH")$tres
ql.nms <- rownames(ql.tbl)[ql.tbl$DEP]
###  Truth table
ridx <- grep("HUMAN",ql.nms)
tp <- length(ridx)
fp <- length(ql.nms)-length(ridx)
(tt.ql22 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp))


###################################################
### code chunk number 10: BlockChunk
###################################################
### Null and alternative model
null.f <- "y~batch"
alt.f <- "y~treat+batch"
### Quasi-likelihood GLM
ql.res <- msms.glm.qlll(gble,alt.f,null.f,div=div)
### Adjust p-values with FDR control.
adjp <- p.adjust(ql.res$p.value,method="BH")
###  Truth table
nh <- length(grep("HUMAN",featureNames(gble)))
ny <- length(grep("HUMAN",featureNames(gble),invert=TRUE))
tp <- length(grep("HUMAN",rownames(ql.res)[adjp<=0.05]))
fp <- sum(adjp<=0.05)-tp
(tt.ql3 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp))


###################################################
### code chunk number 11: BlockFChunk
###################################################
###  Post-test filter
ql.tbl <- test.results(ql.res,gble,pData(gble)$treat,"U600","U200",div,
                    alpha=0.05,minSpC=2,minLFC=1,method="BH")$tres
ql.nms <- rownames(ql.tbl)[ql.tbl$DEP]
###  Truth table
ridx <- grep("HUMAN",ql.nms)
tp <- length(ridx)
fp <- length(ql.nms)-length(ridx)
(tt.ql33 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp))


###################################################
### code chunk number 12: CompChunk
###################################################
gbl.tt <- rbind(tt.ql1,tt.ql11,tt.ql2,tt.ql22,tt.ql3,tt.ql33)
rownames(gbl.tt) <- c("subset","subset filtered",
                      "global","global filtered",
                      "blocking","blocking filtered")		  
library(xtable)
print(xtable(gbl.tt,align=c("r","r","r","r","r"),
             caption=c("Truth tables"),
             display=c("s","d","d","d","d")),
      type="latex",hline.after=c(-1,0,2,4,6),include.rownames=TRUE)


###################################################
### code chunk number 13: msmsTests-Vignette2.Rnw:256-263
###################################################
par(mar=c(5, 3, 2, 2) + 0.1)
par(cex.axis=0.8,cex.lab=0.8)
rownames(gbl.tt) <- c("subset","subset\nfiltered",
                      "global","global\nfiltered",
                      "blocking","blocking\nfiltered")		  
barplot(t(data.matrix(gbl.tt[,1:2])),beside=TRUE,las=2,space=c(0,0.25),
        legend.text=c("TP","FP"),args.legend=list(x="topleft",cex=0.8,bty="n"))


