# Code example from 'msmsTests-Vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'msmsTests-Vignette.Rnw'

###################################################
### code chunk number 1: msmsTests-Vignette.Rnw:68-69
###################################################
options(continue=" ")


###################################################
### code chunk number 2: setup.chunk
###################################################
library(msmsTests)
data(msms.spk)
msms.spk
dim(msms.spk)
head(pData(msms.spk))
table(pData(msms.spk)$treat)


###################################################
### code chunk number 3: SpC.dist.chunk
###################################################
msms.spc <- exprs(msms.spk)
treat <- pData(msms.spk)
idx <- grep("HUMAN",rownames(msms.spc)) 
mSpC <- t( apply(msms.spc[idx,],1,function(x) tapply(x,treat,mean)) )
apply(mSpC,2,summary)


###################################################
### code chunk number 4: Chunk1.Poiss
###################################################
### Subset to the 200 and 600fm spikings
fl <- treat=="U200" | treat=="U600"
e <- msms.spk[,fl]
table(pData(e))
### Remove all zero rows
e <- pp.msms.data(e)
dim(e)

### Null and alternative model
null.f <- "y~1"
alt.f <- "y~treat"
### Normalizing condition
div <- apply(exprs(e),2,sum)
### Poisson GLM
pois.res <- msms.glm.pois(e,alt.f,null.f,div=div)
str(pois.res)

### DEPs on unadjusted p-values
sum(pois.res$p.value<=0.01)
### DEPs on multitest adjusted p-values
adjp <- p.adjust(pois.res$p.value,method="BH")
sum(adjp<=0.01)

### The top features
o <- order(pois.res$p.value)
head(pois.res[o,],20)

### How the UPS1 proteins get ordered in the list
grep("HUMAN",rownames(pois.res[o,])) 

###  Truth table
nh <- length(grep("HUMAN",featureNames(e)))
ny <- length(grep("HUMAN",featureNames(e),invert=TRUE))
tp <- length(grep("HUMAN",rownames(pois.res)[adjp<=0.01]))
fp <- sum(adjp<=0.01)-tp
(tt.pois1 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp))


###################################################
### code chunk number 5: Chunk2.QL
###################################################
### Quasi-likelihood GLM
ql.res <- msms.glm.qlll(e,alt.f,null.f,div=div)
str(ql.res)

### DEPs on unadjusted p-values
sum(ql.res$p.value<=0.01)
### DEPs on multitest adjusted p-values
adjp <- p.adjust(ql.res$p.value,method="BH")
sum(adjp<=0.01)

### The top features
o <- order(ql.res$p.value)
head(ql.res[o,],20)

### How the UPS1 proteins get ordered in the list
grep("HUMAN",rownames(ql.res[o,]))

###  Truth table
tp <- length(grep("HUMAN",rownames(ql.res)[adjp<=0.01]))
fp <- sum(adjp<=0.01)-tp
(tt.ql1 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp))


###################################################
### code chunk number 6: Chunk3.edgeR
###################################################
### Negative-binomial
nb.res <- msms.edgeR(e,alt.f,null.f,div=div,fnm="treat")
str(nb.res)

### DEPs on unadjusted p-values
sum(nb.res$p.value<=0.01)
### DEPs on multitest adjusted p-values
adjp <- p.adjust(nb.res$p.value,method="BH")
sum(adjp<=0.01)

### The top features
o <- order(nb.res$p.value)
head(nb.res[o,],20)

### How the UPS1 proteins get ordered in the list
grep("HUMAN",rownames(nb.res[o,])) 

###  Truth table
tp <- length(grep("HUMAN",rownames(nb.res)[adjp<=0.01]))
fp <- sum(adjp<=0.01)-tp
(tt.nb1 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp))


###################################################
### code chunk number 7: Chunk4.repro
###################################################
###  Cut-off values for a relevant protein as biomarker
alpha.cut <- 0.05
SpC.cut <- 2
lFC.cut <- 1

###  Relevant proteins according to the Poisson GLM
pois.tbl <- test.results(pois.res,e,pData(e)$treat,"U600","U200",div,
                         alpha=alpha.cut,minSpC=SpC.cut,minLFC=lFC.cut,
                         method="BH")$tres
(pois.nms <- rownames(pois.tbl)[pois.tbl$DEP])

###  Truth table
ridx <- grep("HUMAN",pois.nms)
tp <- length(ridx)
fp <- length(pois.nms)-length(ridx)
(tt.pois2 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp))

###  Relevant proteins according to the quasi-likelihood GLM
ql.tbl <- test.results(ql.res,e,pData(e)$treat,"U600","U200",div,
                    alpha=0.05,minSpC=2,minLFC=1,method="BH")$tres
(ql.nms <- rownames(ql.tbl)[ql.tbl$DEP])

###  Truth table
ridx <- grep("HUMAN",ql.nms)
tp <- length(ridx)
fp <- length(ql.nms)-length(ridx)
(tt.ql2 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp))

###  Relevant proteins according to the negative-binomial GLM
nb.tbl <- test.results(nb.res,e,pData(e)$treat,"U600","U200",div,
                    alpha=0.05,minSpC=2,minLFC=1,method="BH")$tres
(nb.nms <- rownames(nb.tbl)[nb.tbl$DEP])

###  Truth table
ridx <- grep("HUMAN",nb.nms)
tp <- length(ridx)
fp <- length(nb.nms)-length(ridx)
(tt.nb2 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp))


###################################################
### code chunk number 8: Chunk5.summary
###################################################
fl <- pois.tbl$adjp <= 0.05
sig <- sum(fl)
tp <- length(grep("HUMAN",rownames(pois.tbl)[fl]))
fp <- sig-tp
tt.pois0 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp)

fl <- ql.tbl$adjp <= 0.05
sig <- sum(fl)
tp <- length(grep("HUMAN",rownames(ql.tbl)[fl]))
fp <- sig-tp
tt.ql0 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp)

fl <- nb.tbl$adjp <= 0.05
sig <- sum(fl)
tp <- length(grep("HUMAN",rownames(nb.tbl)[fl]))
fp <- sig-tp
tt.nb0 <- data.frame(TP=tp,FP=fp,TN=ny-fp,FN=nh-tp)

library(xtable)
df <- data.frame(Test=character(9),Significance=numeric(9),
                 Filtered=character(9),
                 TP=integer(9),FP=integer(9),TN=integer(9),FN=integer(9),
                 stringsAsFactors=FALSE)
df$Test[1] <- df$Test[4] <- df$Test[7] <- "Poisson"
df$Test[2] <- df$Test[5] <- df$Test[8] <- "Quasi-likelihood"
df$Test[3] <- df$Test[6] <- df$Test[9] <- "Negative-binomial"
df$Significance[1:3] <- 0.05
df$Significance[4:6] <- 0.01
df$Significance[7:9] <- 0.05
df$Filtered[1:6] <- "No"
df$Filtered[7:9] <- "Yes"
df[1,4:7] <- tt.pois0
df[2,4:7] <- tt.ql0
df[3,4:7] <- tt.nb0
df[4,4:7] <- tt.pois1
df[5,4:7] <- tt.ql1
df[6,4:7] <- tt.nb1
df[7,4:7] <- tt.pois2
df[8,4:7] <- tt.ql2
df[9,4:7] <- tt.nb2
print(xtable(df,align=c("r","r","c","c","c","c","c","c"),
             caption=c("Truth tables"),
             display=c("d","s","f","s","d","d","d","d")),
      type="latex",hline.after=c(-1,0,3,6,9),include.rownames=FALSE)


###################################################
### code chunk number 9: Chunk6.other
###################################################
### All features
pval.by.fc(ql.tbl$adjp,ql.tbl$LogFC)

### Filtering by minimal signal
fl <- ql.tbl$U600 > 2
pval.by.fc(ql.tbl$adjp[fl],ql.tbl$LogFC[fl])


###################################################
### code chunk number 10: msmsTests-Vignette.Rnw:355-358
###################################################
par(mar=c(5,4,0.5,2)+0.1)
res.volcanoplot(ql.tbl,max.pval=0.05,min.LFC=1,maxx=3,maxy=NULL,
                            ylbls=3)


