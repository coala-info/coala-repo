# Code example from 'Roleswitch' vignette. See references/ for full tutorial.

### R code from vignette source 'Roleswitch.Rnw'

###################################################
### code chunk number 1: simulation
###################################################
library(Roleswitch)

# simulated example
N <- 10
M <- 4

x.o <- matrix(abs(rnorm(N, mean=3)))

rownames(x.o) <- paste("mRNA", 1:nrow(x.o))
colnames(x.o) <- "mRNA expression"

# miRNA expression
z.o <- matrix(abs(rnorm(M, mean=3)))

rownames(z.o) <- paste("miRNA", 1:nrow(z.o))
colnames(z.o) <- "miRNA expression"

# simulate target sites
c <- matrix(rpois(nrow(z.o)*nrow(x.o), 0.2), nrow=nrow(x.o))

# ensure each miRNA (mRNA) has at least one 
# seed (seed match) to a mRNA (miRNA)
c[apply(c,1,sum)==0, sample(1:ncol(c),1)] <- 1

c[sample(1:nrow(c),1),apply(c,2,sum)==0] <- 1

dimnames(c) <- list(rownames(x.o), rownames(z.o))
      
# simulate true labels	
rs.pred <- roleswitch(x.o, z.o, c)


###################################################
### code chunk number 2: toy
###################################################
diagnosticPlot(rs.pred)


###################################################
### code chunk number 3: testdata
###################################################
data(tcga_gbm_testdata)

# rescale to non-negative values (if any)
if(any(x<0)) x <- rescale(as.matrix(x), to=c(0, max(x)))

if(any(z<0)) z <- rescale(as.matrix(z), to=c(0, max(z)))


###################################################
### code chunk number 4: seedmatrix
###################################################
seedMatrix <- getSeedMatrix(species="human")

seedMatrix <- seedMatrix[match(rownames(x), 
  	rownames(seedMatrix), nomatch=F),
		match(rownames(z), colnames(seedMatrix), nomatch=F)]
		
x <- x[match(rownames(seedMatrix),rownames(x), nomatch=F),,drop=F]

z <- z[match(colnames(seedMatrix),rownames(z), nomatch=F),,drop=F]


###################################################
### code chunk number 5: rs_on_testdata
###################################################
rs.pred <- roleswitch(x,z,seedMatrix)


###################################################
### code chunk number 6: valid
###################################################
# reorder valdiated taregts to match with seedMatrix
validated <- lapply(colnames(seedMatrix), function(j) {
  
	as.matrix(rownames(seedMatrix)) %in%
		as.matrix(subset(mirtarbase, miRNA==j)$`Target Gene`)	
})

validated <- do.call("cbind", validated)

dimnames(validated) <- dimnames(seedMatrix)


###################################################
### code chunk number 7: toprank
###################################################
toprank <- seq(from=100,to=1000,by=100)

toprank_eval <- function(pred, decreasing=T, mirna.expr) {
  				
	expressed.miRNA <- rownames(mirna.expr)[mirna.expr > 0]
	
	tmp <- validated
					
	tmp[, !colnames(tmp) %in% expressed.miRNA] <- FALSE

	valid <- which(as.numeric(tmp)==1)
	
	tp <- sapply(toprank, function(n) 
		sum(head(order(pred, decreasing=decreasing), n) %in% valid))
	
	data.frame(rank=toprank, validated=tp)
}

rs.toprank <- data.frame(toprank_eval(as.numeric(rs.pred$p.xz), 
		mirna.expr=z), type="GBM", method="Roleswitch")

seed.toprank <- data.frame(toprank_eval(as.numeric(seedMatrix), 
		mirna.expr=z), type="GBM", method="Seed Matrix")


###################################################
### code chunk number 8: toprank_plot
###################################################
require(ggplot2)

df <- rbind(rs.toprank, seed.toprank)

gg <- ggplot(data=df, aes(x=factor(rank), y=validated, fill=method)) + 
  
	theme_bw() + geom_bar(stat="identity", position="dodge") +
	
	scale_x_discrete("Top rank") + 
	
	scale_y_continuous("Validated targets of expressed miRNAs")


###################################################
### code chunk number 9: gg
###################################################
print(gg)


###################################################
### code chunk number 10: eset
###################################################
# mRNA expression from eSet
dataDirectory <- system.file("extdata", package="Biobase")

exprsFile <- file.path(dataDirectory, "exprsData.txt")

exprs <- as.matrix(read.table(exprsFile, header=TRUE, sep="\t",
  		row.names=1, as.is=TRUE))

eset <- ExpressionSet(assayData=exprs[,1,drop=F], annotation="hgu95av2")

annotation.db <- sprintf("%s.db", annotation(eset))

# miRNA expression
mirna.expr <- matrix(
	c(1.23, 3.52, 2.42, 5.2, 2.2, 1.42, 1.23, 1.20, 1.37),
	dimnames=list(	
	c("hsa-miR-148b", "hsa-miR-27b", "hsa-miR-25",
      "hsa-miR-181a", "hsa-miR-27a", "hsa-miR-7",
      "hsa-miR-32", "hsa-miR-32", "hsa-miR-7"), "miRNA Expression")
)

rs <- roleswitch(eset, mirna.expr)

promise <- rs$p.xz[apply(rs$p.xz,1,sum)>0, apply(rs$p.xz,2,sum)>0]


###################################################
### code chunk number 11: promise
###################################################
color2D.matplot(promise, extremes=c("white", "red"),
  main=sprintf("ProMISe"), axes=FALSE, xlab="", ylab="", show.values=T)

axis(1,at=0.5:(ncol(promise)-0.5),las=3,labels=sub("hsa-","", colnames(promise)))

axis(2,at=0.5:(nrow(promise)-0.5),las=2,labels=rownames(promise))


###################################################
### code chunk number 12: sessi
###################################################
sessionInfo()


