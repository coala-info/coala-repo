# Code example from 'tweeDEseq' vignette. See references/ for full tutorial.

### R code from vignette source 'tweeDEseq.Rnw'

###################################################
### code chunk number 1: tweeDEseq.Rnw:57-59
###################################################
library(tweeDEseq)
library(tweeDEseqCountData)


###################################################
### code chunk number 2: tweeDEseq.Rnw:63-70
###################################################
data(pickrell)
countsNigerian <- exprs(pickrell.eset)
dim(countsNigerian)
countsNigerian[1:5, 1:5]
genderNigerian <- pData(pickrell.eset)[,"gender"]
head(genderNigerian)
table(genderNigerian)


###################################################
### code chunk number 3: tweeDEseq.Rnw:80-81 (eval = FALSE)
###################################################
## countsNigerianNorm <- normalizeCounts(countsNigerian, genderNigerian)


###################################################
### code chunk number 4: tweeDEseq.Rnw:83-85
###################################################
data(pickrellNorm)
countsNigerianNorm <- exprs(pickrellNorm.eset)


###################################################
### code chunk number 5: tweeDEseq.Rnw:87-88
###################################################
dim(countsNigerianNorm)


###################################################
### code chunk number 6: tweeDEseq.Rnw:92-94
###################################################
countsNigerianNorm <- filterCounts(countsNigerianNorm)
dim(countsNigerianNorm)


###################################################
### code chunk number 7: tweeDEseq.Rnw:114-118
###################################################
set.seed(123)
y <- rnbinom(1000, mu=8, size=1/0.2)
thetahat <- mlePoissonTweedie(y)
getParam(thetahat)


###################################################
### code chunk number 8: tweeDEseq.Rnw:126-127
###################################################
testShapePT(thetahat, a=0)


###################################################
### code chunk number 9: tweeDEseq.Rnw:131-137
###################################################
data(genderGenes)
data(hkGenes)

length(XiEgenes)
length(msYgenes)
length(hkGenes)


###################################################
### code chunk number 10: tweeDEseq.Rnw:141-147
###################################################
set.seed(123)
someHKgenes <- sample(hkGenes, size=25)
geneSubset <- unique(c("ENSG00000070031",
                       intersect(rownames(countsNigerianNorm),
                                 c(someHKgenes, msYgenes, XiEgenes))))
length(geneSubset)


###################################################
### code chunk number 11: tweeDEseq.Rnw:151-152
###################################################
chi2gof <- gofTest(countsNigerianNorm[geneSubset, ], a=0)


###################################################
### code chunk number 12: gof
###################################################
par(mfrow=c(1,2), mar=c(4, 5, 3, 4))
qq <- qqchisq(chi2gof, main="Chi2 Q-Q Plot", ylim = c(0, 60))
qq <- qqchisq(chi2gof, normal=TRUE, ylim = c(-5, 7))


###################################################
### code chunk number 13: secretin
###################################################
par(mfrow=c(1,2), mar=c(4, 5, 3, 2))
xf <- unlist(countsNigerianNorm["ENSG00000070031", genderNigerian=="female"])
compareCountDist(xf, main="Female samples")
xm <- unlist(countsNigerianNorm["ENSG00000070031", genderNigerian=="male"])
compareCountDist(xm, main="Male samples")


###################################################
### code chunk number 14: tweeDEseq.Rnw:192-194
###################################################
sort(xf)
sort(xm)


###################################################
### code chunk number 15: tweeDEseq.Rnw:198-201
###################################################
xf[which.max(xf)]
2^{log2(mean(xf))-log2(mean(xm))}
2^{log2(mean(xf[-which.max(xf)])) - log2(mean(xm))}


###################################################
### code chunk number 16: tweeDEseq.Rnw:213-214
###################################################
resPT <- tweeDE(countsNigerianNorm[geneSubset, ], group = genderNigerian)


###################################################
### code chunk number 17: tweeDEseq.Rnw:218-219
###################################################
print(resPT)


###################################################
### code chunk number 18: tweeDEseq.Rnw:225-227
###################################################
deGenes <- print(resPT, n=Inf, log2fc=log2(1.5), pval.adjust=0.05, print=FALSE)
dim(deGenes)


###################################################
### code chunk number 19: tweeDEseq.Rnw:231-234
###################################################
data(annotEnsembl63)
head(annotEnsembl63)
deGenes <- merge(deGenes, annotEnsembl63, by="row.names", sort=FALSE)


###################################################
### code chunk number 20: tabDEgenes
###################################################
library(xtable)
deGenes$Description <- gsub(" \\[.+$", "", deGenes$Description)
xtab <- xtable(deGenes[, c("Symbol", "Chr", "log2fc", "pval.adjust", "Description")],
               caption="Differentially expressed genes between female and male Nigerian individuals found by tweeDEseq.",
               label="tab:deGenes", align="|l|c|c|r|l|p{7cm}|", digits=c(0, 0, 0, 2, -2, 0))
print(xtab, floating=TRUE, sanitize.text.function=function(x) x, caption.placement="top", include.rownames=FALSE)


###################################################
### code chunk number 21: tweeDEseq.Rnw:253-255
###################################################
deGenes <- rownames(print(resPT, n=Inf, log2fc=log2(1.5), pval.adjust=0.05, print=FALSE))
length(deGenes)


###################################################
### code chunk number 22: MAnVplots
###################################################
hl <- list(list(genes=msYgenes, pch=21, col="blue", bg="blue", cex=0.7),
           list(genes=XiEgenes, pch=21, col="skyblue", bg="skyblue", cex=0.7),
           list(genes=deGenes, pch=1, col="red", lwd=2, cex=1.5)
          )
par(mfrow=c(1,2), mar=c(4, 5, 3, 2))
MAplot(resPT, cex=0.7, log2fc.cutoff=log2(1.5), highlight=hl, main="MA-plot")
Vplot(resPT, cex=0.7, highlight=hl, log2fc.cutoff=log2(1.5),
      pval.adjust.cutoff=0.05, main="Volcano plot")


###################################################
### code chunk number 23: tweeDEseq.Rnw:294-303
###################################################
genderGenes <- c(msYgenes[msYgenes %in% rownames(resPT)],
                 XiEgenes[XiEgenes %in% rownames(resPT)])
N <- nrow(resPT)
m <- length(genderGenes)
n <- length(deGenes)
k <- length(intersect(deGenes, genderGenes))
t <- array(c(k,n-k,m-k,N+k-n-m), dim=c(2,2), dimnames=list(SEX=c("in","out"),DE=c("yes","no")))
t
fisher.test(t, alternative="greater")


###################################################
### code chunk number 24: tweeDEseq.Rnw:310-313
###################################################
mod <- glmPT(countsNigerianNorm["ENSG00000070031",] ~ genderNigerian)
mod
summary(mod)


###################################################
### code chunk number 25: tweeDEseq.Rnw:318-319
###################################################
anova(mod)


###################################################
### code chunk number 26: tweeDEseq.Rnw:324-325
###################################################
resPTglm <- tweeDEglm( ~ genderNigerian, counts = countsNigerianNorm[geneSubset,])


###################################################
### code chunk number 27: tweeDEseq.Rnw:330-331
###################################################
head(resPTglm[sort(resPTglm$pval.adjust, index.return = TRUE)$ix,])


###################################################
### code chunk number 28: tweeDEseq.Rnw:342-344 (eval = FALSE)
###################################################
## tweeDEglm(~ genderNigerian, counts = countsNigerianNorm[geneSubset,],
##  offset = cqn.subset$offset)


###################################################
### code chunk number 29: tweeDEseq.Rnw:349-350
###################################################
sessionInfo()


