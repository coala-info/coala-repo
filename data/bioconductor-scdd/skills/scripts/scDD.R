# Code example from 'scDD' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----patternPlot, echo=FALSE, fig.show="hide", fig.width=7, fig.height=5----
### Note that the following code can be ignored for the purposes of
# analysis with scDD; it is simply used to generate the cartoon of 
# interesting DD patterns (illustration purposes only)
par(mfrow=c(2,2), tcl=-0.5, mai=c(0.4,0.4,0.5,0.3))
x <- seq(0, 6, by=0.05)

## traditional de 
# mu1 is 2 
# mu2 is 4
cord.x <- c(0,x,6) 
cord.y <- c(0,dnorm(x, 2, 0.75),0) 
curve(dnorm(x, 2 , 0.75),xlim=c(0,6),main="Traditional DE",
      xaxt="n", xlab="", ylab="", yaxt="n") 
polygon(cord.x,cord.y,col=rgb(0,0,1,1/4))
cord.x <- c(0,x,6) 
cord.y <- c(0,dnorm(x, 4, 0.75),0) 
lines(x, dnorm(x, 4 , 0.75))
polygon(cord.x,cord.y,col=rgb(1,0,0,1/4))
axis(side=1, at=c(2,4), labels=c(expression(mu[1]), expression(mu[2])),
     pos=0, cex.axis=1.5)
mtext("(A)", side = 3, line=0.5, adj=-0.1, cex=1.2, font=2)

x <- seq(0, 10, by=0.05)
## differential proportion
cord.x <- c(0,x,10) 
cord.y <- c(0,0.3*dnorm(x, 7, 1) + 0.7*dnorm(x, 3, 1),0) 
curve(0.3*dnorm(x, 7, 1) + 0.7*dnorm(x, 3, 1),xlim=c(0,10),main="DP",
      xaxt="n", xlab="", ylab="", yaxt="n") 
polygon(cord.x,cord.y,col=rgb(0,0,1,1/4))
cord.x <- c(0,x,10) 
cord.y <- c(0,0.3*dnorm(x, 3, 1) + 0.7*dnorm(x, 7, 1),0) 
lines(x, 0.3*dnorm(x, 3, 1) + 0.7*dnorm(x, 7, 1))
polygon(cord.x,cord.y,col=rgb(1,0,0,1/4))
axis(side=1, at=c(3,7), labels=c(expression(mu[1]), 
                                 expression(mu[2])), pos=0, cex.axis=1.5)
mtext("(B)", side = 3, line=0.5, adj=-0.1, cex=1.2, font=2)

## differential modes (DM)
cord.x <- c(0,x,6) 
cord.y <- c(0,dnorm(x, 2, 0.75),0) 
curve(dnorm(x, 2 , 0.75),xlim=c(0,6),main="DM", xaxt="n", 
      xlab="", ylab="", yaxt="n") 
polygon(cord.x,cord.y,col=rgb(0,0,1,1/4))
cord.x <- c(0,x,6) 
cord.y <- c(0,0.3*dnorm(x, 2, 0.6) + 0.7*dnorm(x, 4, 0.6),0) 
lines(x, 0.3*dnorm(x, 2, 0.6) + 0.7*dnorm(x, 4, 0.6))
polygon(cord.x,cord.y,col=rgb(1,0,0,1/4))
axis(side=1, at=c(2,4), labels=c(expression(mu[1]), 
                                 expression(mu[2])), pos=0, cex.axis=1.5)
mtext("(C)", side = 3, line=0.5, adj=-0.1, cex=1.2, font=2)

## Both DM and DP
cord.x <- c(0,x,10) 
cord.y <- c(0,0.5*dnorm(x, 2.5, 1) + 0.5*dnorm(x, 7.5, 1),0) 
curve(0.5*dnorm(x, 2.5, 1) + 0.5*dnorm(x, 7.5, 1),
      xlim=c(0,10),main="DB", xaxt="n", xlab="", ylab="", yaxt="n",
      ylim=c(0,max(0.5*dnorm(x, 2.5, 1) + 0.5*dnorm(x, 7.5, 1)))) 
polygon(cord.x,cord.y,col=rgb(0,0,1,1/4))
cord.x <- c(0,x,10) 
cord.y <- c(0,0.8*dnorm(x, 5, 2),0) 
lines(x, 0.8*dnorm(x, 5, 2))
polygon(cord.x,cord.y,col=rgb(1,0,0,1/4))
axis(side=1, at=c(2.5, 5, 7.5), labels=c(expression(mu[1]), 
                                         expression(mu[3]), 
                                         expression(mu[2])), 
     pos=0, cex.axis=1.5)
mtext("(D)", side = 3, line=0.5, adj=-0.1, cex=1.2, font=2)

## ----load lib, message=FALSE-----------------------------------------------
library(scDD)

## ----load exDat------------------------------------------------------------
data(scDatExSim)

## ----check class-----------------------------------------------------------
class(scDatExSim)
dim(scDatExSim)

## ----prior-----------------------------------------------------------------
prior_param=list(alpha=0.01, mu0=0, s0=0.01, a0=0.01, b0=0.01)

## ----main engine-----------------------------------------------------------
scDatExSim <- scDD(scDatExSim, prior_param=prior_param, testZeroes=FALSE)

## ----main results----------------------------------------------------------
RES <- results(scDatExSim)
head(RES)

## ----partition results-----------------------------------------------------
PARTITION.C1 <- results(scDatExSim, type="Zhat.c1")
PARTITION.C1[1:5,1:5]

## ----main engine perm------------------------------------------------------
scDatExSim <- scDD(scDatExSim, prior_param=prior_param, 
                 testZeroes=FALSE, permutations=100)

## ----load exdat2-----------------------------------------------------------
data(scDatEx)

## ----check class2----------------------------------------------------------
class(scDatEx)
dim(scDatEx)

## ----set num---------------------------------------------------------------
nDE <- 5
nDP <- 5
nDM <- 5
nDB <- 5
nEE <- 5
nEP <- 5
numSamples <- 100
seed <- 816

## ----simset----------------------------------------------------------------
SD <- simulateSet(scDatEx, numSamples=numSamples, 
                  nDE=nDE, nDP=nDP, nDM=nDM, nDB=nDB, 
                  nEE=nEE, nEP=nEP, sd.range=c(2,2), modeFC=4, plots=FALSE, 
                  random.seed=seed)

# load the SingleCellExperiment package to use rowData method
library(SingleCellExperiment)
head(rowData(SD))

## ----load summarizedexp, message=FALSE-------------------------------------
library(SingleCellExperiment)

## ----load exdatlist--------------------------------------------------------
data(scDatExList)

## ----create condition------------------------------------------------------
condition <- c(rep(1, ncol(scDatExList$C1)), rep(2,  ncol(scDatExList$C2)))

## ----rownames--------------------------------------------------------------
# Example of row and column names
head(rownames(scDatExList$C1))
head(colnames(scDatExList$C2))

names(condition) <- c(colnames(scDatExList$C1), colnames(scDatExList$C2))

## ----create sce------------------------------------------------------------
sce <- SingleCellExperiment(assays=list(normcounts=cbind(scDatExList$C1, 
                                                         scDatExList$C2)),
                                colData=data.frame(condition))
show(sce)

## ----load exdat3e----------------------------------------------------------
data(scDatEx)
show(scDatEx)

## ----preprocess------------------------------------------------------------
scDatEx <- preprocess(scDatEx, zero.thresh=0.9)
show(scDatEx)

## ----threshe---------------------------------------------------------------
scDatEx.scran <- preprocess(scDatEx, zero.thresh=0.5, scran_norm=TRUE)
show(scDatEx.scran)

## ----load exdat4-----------------------------------------------------------
data(scDatExSim)

## ----load sumExp, message=FALSE--------------------------------------------
library(SingleCellExperiment)

## ----plot DE, eval=TRUE, message=FALSE-------------------------------------
de <- sideViolin(normcounts(scDatExSim)[1,], scDatExSim$condition, 
           title.gene=rownames(scDatExSim)[1])

## ----plot DP, eval=TRUE, message=FALSE-------------------------------------
dp <- sideViolin(normcounts(scDatExSim)[6,], scDatExSim$condition, 
           title.gene=rownames(scDatExSim)[6])

## ----plot DM, eval=TRUE, message=FALSE-------------------------------------
dm <- sideViolin(normcounts(scDatExSim)[11,], scDatExSim$condition, 
           title.gene=rownames(scDatExSim)[11])

## ----plot DB, eval=TRUE, message=FALSE-------------------------------------
db <- sideViolin(normcounts(scDatExSim)[16,], scDatExSim$condition, 
           title.gene=rownames(scDatExSim)[16])

## ----plot EP, eval=TRUE, message=FALSE-------------------------------------
ep <- sideViolin(normcounts(scDatExSim)[21,], scDatExSim$condition, 
           title.gene=rownames(scDatExSim)[21])

## ----plot EE, eval=TRUE, message=FALSE-------------------------------------
ee <- sideViolin(normcounts(scDatExSim)[26,], scDatExSim$condition, 
           title.gene=rownames(scDatExSim)[26])

## ----plotGrid, fig.show='hide', fig.width=8.5, fig.height=11, message=FALSE----
library(gridExtra)
grid.arrange(de, dp, dm, db, ep, ee, ncol=2)

## ----sessionInfo, eval=TRUE------------------------------------------------
sessionInfo()

