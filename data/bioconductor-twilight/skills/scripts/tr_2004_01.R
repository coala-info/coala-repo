# Code example from 'tr_2004_01' vignette. See references/ for full tutorial.

### R code from vignette source 'tr_2004_01.Rnw'

###################################################
### code chunk number 1: tr_2004_01.Rnw:46-48 (eval = FALSE)
###################################################
## q(save="no")
## 


###################################################
### code chunk number 2: tr_2004_01.Rnw:49-56
###################################################
library(stats)
library(splines)
library(golubEsets)
library(vsn)
oldopt <- options(digits=3)
on.exit( {options(oldopt)} )
options(width=75)


###################################################
### code chunk number 3: tr_2004_01.Rnw:111-114
###################################################
data(Golub_Train)
golubNorm <- justvsn(Golub_Train)
id <- as.numeric(Golub_Train$ALL.AML) #$


###################################################
### code chunk number 4: tr_2004_01.Rnw:118-120
###################################################
Golub_Train$ALL.AML #$
id


###################################################
### code chunk number 5: tr_2004_01.Rnw:130-132
###################################################
library(twilight)
pval <- twilight.pval(golubNorm, id, B=100)


###################################################
### code chunk number 6: tr_2004_01.Rnw:137-139
###################################################
data(expval)
expval


###################################################
### code chunk number 7: tr_2004_01.Rnw:143-145
###################################################
class(expval)
names(expval)


###################################################
### code chunk number 8: tr_2004_01.Rnw:149-150
###################################################
names(expval$result) #$


###################################################
### code chunk number 9: tr_2004_01.Rnw:155-156
###################################################
expval$result[1:7,1:5] #$


###################################################
### code chunk number 10: tr_2004_01.Rnw:160-166
###################################################
bitmap(file="tr_2004_01-scores.png",width=6,height=4.5,pointsize=10)
plot(expval,which="scores",grayscale=F,legend=F)
dev.off()
bitmap(file="tr_2004_01-qvalues.png",width=6,height=4.5,pointsize=10)
plot(expval,which="qvalues")
dev.off()


###################################################
### code chunk number 11: tr_2004_01.Rnw:178-179
###################################################
expval$pi0 #$


###################################################
### code chunk number 12: tr_2004_01.Rnw:212-215
###################################################
gene <- exprs(golubNorm)[pval$result$index[1],]
corr <- twilight.pval(golubNorm,gene,method="spearman",quant.ci=0.99,B=100)
corr


###################################################
### code chunk number 13: tr_2004_01.Rnw:221-222
###################################################
corr$result[1:10,1:5] #$


###################################################
### code chunk number 14: tr_2004_01.Rnw:227-230
###################################################
bitmap(file="tr_2004_01-corr.png",width=6,height=4.5,pointsize=10)
plot(corr,which="scores",grayscale=F,legend=F)
dev.off()


###################################################
### code chunk number 15: tr_2004_01.Rnw:268-270
###################################################
yperm <- twilight.filtering(golubNorm,id,method="fc",num.perm=50,num.take=10)
dim(yperm)


###################################################
### code chunk number 16: tr_2004_01.Rnw:275-278
###################################################
yperm <- yperm[-1,]
b <- twilight.pval(golubNorm,yperm[1,],method="fc",yperm=yperm)
hist(b$result$pvalue,col="gray",br=20)


###################################################
### code chunk number 17: tr_2004_01.Rnw:281-284
###################################################
bitmap(file="tr_2004_01-hist.png",width=6,height=4.5,pointsize=10)
hist(b$result$pvalue,col="gray",br=20,main="",xlab="P-value")
dev.off()


###################################################
### code chunk number 18: tr_2004_01.Rnw:324-327
###################################################
data(exfdr)
exfdr



###################################################
### code chunk number 19: tr_2004_01.Rnw:328-329
###################################################
exfdr$result[1:5,6:9] #$


###################################################
### code chunk number 20: tr_2004_01.Rnw:334-343
###################################################
bitmap(file="tr_2004_01-fdr.png",width=6,height=4.5,pointsize=10)
plot(exfdr,which="fdr",grayscale=F,legend=T)
dev.off()
bitmap(file="tr_2004_01-volcano.png",width=6,height=4.5,pointsize=10)
plot(exfdr,which="volcano")
dev.off()
bitmap(file="tr_2004_01-effectsize.png",width=6,height=4.5,pointsize=10)
plot(exfdr,which="effectsize",legend=T)
dev.off()


###################################################
### code chunk number 21: tr_2004_01.Rnw:367-369
###################################################
tab <- plot(exfdr,which="table")
tab[1:8,]


###################################################
### code chunk number 22: tr_2004_01.Rnw:394-396
###################################################
x <- c(rep(0,2),rep(1,3))
x


###################################################
### code chunk number 23: tr_2004_01.Rnw:399-400
###################################################
twilight.combi(x,pin=FALSE,bin=FALSE)


###################################################
### code chunk number 24: tr_2004_01.Rnw:407-408
###################################################
twilight.combi(x,pin=FALSE,bin=TRUE)


###################################################
### code chunk number 25: tr_2004_01.Rnw:416-418
###################################################
y <- c(rep(0,4),rep(1,4))
y


###################################################
### code chunk number 26: tr_2004_01.Rnw:421-422
###################################################
twilight.combi(y,pin=TRUE,bin=FALSE)


###################################################
### code chunk number 27: tr_2004_01.Rnw:429-430
###################################################
twilight.combi(y,pin=TRUE,bin=TRUE)


###################################################
### code chunk number 28: tr_2004_01.Rnw:435-436
###################################################
twilight.permute.pair(y,7,bal=TRUE)


###################################################
### code chunk number 29: tr_2004_01.Rnw:439-440
###################################################
Sys.sleep(30)


