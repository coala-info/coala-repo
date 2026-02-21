# Code example from 'BADER' vignette. See references/ for full tutorial.

### R code from vignette source 'BADER.Rnw'

###################################################
### code chunk number 1: loaddata
###################################################
library(BADER)
datafile <- system.file( "extdata/pasilla_gene_counts.tsv", package="pasilla" )
pasillaCountTable <- read.table( datafile, header=TRUE, row.names=1 )
head(pasillaCountTable)


###################################################
### code chunk number 2: splitup
###################################################
genetable <- pasillaCountTable[,c(3,4,6,7)]
genetable <- genetable[rowSums(genetable) > 0,]
genetable <- genetable[1:500,]
design <- factor(c("A","A","B","B"))


###################################################
### code chunk number 3: runMCMC
###################################################
set.seed(21)
results <- BADER(genetable,design,burn=1e3,reps=1e3,printEvery=1e3)


###################################################
### code chunk number 4: printResults
###################################################
names(results)
rownames(genetable)[order(results$diffProb,decreasing=TRUE)[1:10]]


###################################################
### code chunk number 5: toyDataset
###################################################
set.seed(21)
gam <- c(rnorm(50,0,2),rep(0,450))
muA <- rnorm(500,3,1)
muB <- muA + gam
kA <- t(matrix(rnbinom(2*500,mu=exp(muA),size=exp(1)),nrow=2,byrow=TRUE))
kB <- t(matrix(rnbinom(2*500,mu=exp(muB),size=exp(1)),nrow=2,byrow=TRUE))
genetable <- cbind(kA,kB)
design <- factor(c("A","A","B","B"))

results <- BADER(genetable,design,mode="full",burn=1e3,reps=3e3,printEvery=1e3)


###################################################
### code chunk number 6: postPlot
###################################################
par(mfrow=c(1,2))
temp <- hist(results$logFoldChangeDist[,18],breaks=seq(-10.125,10.125,by=0.25),plot=FALSE)
temp$density <- temp$density/sum(temp$density)
plot(temp, freq=FALSE,ylab="probability",xlab="log fold change",main="gene no. 18",xlim=c(-1,5))
abline(v=gam[18],col="#4DAF4A", lwd=2)
abline(v=results$logFoldChange[18],col="#377EB8",lwd=2)
temp <- hist(results$logFoldChangeDist[,142],breaks=seq(-10.125,10.125,by=0.25),plot=FALSE)
temp$density <- temp$density/sum(temp$density)
plot(temp, freq=FALSE,ylab="probability",xlab="log fold change",main="gene no. 142",xlim=c(-4,1))
abline(v=gam[142],col="#4DAF4A", lwd=2)
abline(v=results$logFoldChange[142],col="#377EB8",lwd=2)


###################################################
### code chunk number 7: gse
###################################################
S <- c(1,2,3,51,52,53)
T <- c(54,55,56)

f <- function(sample,set)
    mean(sample[set] != 0) > mean(sample[-set] != 0)

mean(apply(results$logFoldChangeDist,1,f,set=S))
mean(apply(results$logFoldChangeDist,1,f,set=T))


