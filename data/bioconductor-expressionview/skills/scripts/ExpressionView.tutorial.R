# Code example from 'ExpressionView.tutorial' vignette. See references/ for full tutorial.

### R code from vignette source 'ExpressionView.tutorial.Rnw'

###################################################
### code chunk number 1: set width
###################################################
options(width=60)
options(continue=" ")


###################################################
### code chunk number 2: load the data
###################################################
library(ALL)
library(hgu95av2.db)
data(ALL)


###################################################
### code chunk number 3: load the packages
###################################################
library(eisa)


###################################################
### code chunk number 4: ISA (eval = FALSE)
###################################################
## set.seed(5) # initialize random number generator to get always the same results
## modules <- ISA(ALL)


###################################################
### code chunk number 5: fast ISA
###################################################
threshold.genes <- 2.7 
threshold.conditions <- 1.4 
set.seed(5)
modules <- ISA(ALL, thr.gene=threshold.genes, thr.cond=threshold.conditions)


###################################################
### code chunk number 6: ISAModules summary
###################################################
modules


###################################################
### code chunk number 7: biclust bcplaid
###################################################
library(biclust)
biclusters <- biclust(exprs(ALL), BCPlaid(), fit.model=~m+a+b, verbose=FALSE)


###################################################
### code chunk number 8: isa
###################################################
as(biclusters, "ISAModules")


###################################################
### code chunk number 9: random-modules
###################################################
modules.genes <- matrix(as.integer(runif(nrow(ALL) * length(modules)) > 0.8), 
                        nrow=nrow(ALL))
modules.conditions <- matrix(as.integer(runif(ncol(ALL) *
                                        length(modules))>0.8),
                        nrow=ncol(ALL))


###################################################
### code chunk number 10: toisa
###################################################
new("ISAModules",
    genes=modules.genes, conditions=modules.conditions,
    rundata=data.frame(), seeddata=data.frame())


###################################################
### code chunk number 11: expressionview
###################################################
library(ExpressionView)
optimalorder <- OrderEV(modules)


###################################################
### code chunk number 12: gene maps (eval = FALSE)
###################################################
## optimalorder$genes[i+1]
## optimalorder$samples[i+1]


###################################################
### code chunk number 13: status ordering
###################################################
optimalorder$status


###################################################
### code chunk number 14: status ordering (eval = FALSE)
###################################################
## optimalorderp <- OrderEV(modules, initialorder=optimalorder, maxtime=120)


###################################################
### code chunk number 15: export (eval = FALSE)
###################################################
## ExportEV(modules, ALL, optimalorder, filename="file.evf")


###################################################
### code chunk number 16: export (eval = FALSE)
###################################################
## LaunchEV()


###################################################
### code chunk number 17: in-silico
###################################################
library(ExpressionView)
# generate in-silico data with dimensions m x n 
# containing M overlapping modules
# and add some noise
m <- 50
n <- 500
M <- 10
data <- isa.in.silico(num.rows=m, num.cols=n, 
                      num.fact=M, noise=0.1, overlap.row=5)[[1]]
modules <- isa(data)


###################################################
### code chunk number 18: data set annotation
###################################################
rownames(data) <- paste("row", seq_len(nrow(data)))
colnames(data) <- paste("column", seq_len(ncol(data)))


###################################################
### code chunk number 19: rowdata annotation
###################################################
rowdata <- outer(1:nrow(data), 1:5, function(x, y) {
  paste("row description (", x, ", ", y, ")", sep="")
})             
rownames(rowdata) <- rownames(data)
colnames(rowdata) <- paste("row tag", seq_len(ncol(rowdata)))


###################################################
### code chunk number 20: coldata annotation
###################################################
coldata <- outer(1:ncol(data), 1:10, function(x, y) {
  paste("column description (", x, ", ", y, ")", sep="")
})
rownames(coldata) <- colnames(data)
colnames(coldata) <- paste("column tag", seq_len(ncol(coldata)))


###################################################
### code chunk number 21: in-silico data annotation
###################################################
description <- list(
experiment=list(
	title="Title", 
	xaxislabel="x-Axis Label",
	yaxislabel="y-Axis Label",
	name="Author", 
	lab="Address", 
	abstract="Abstract", 
	url="URL", 
	annotation="Annotation", 
	organism="Organism"),
coldata=coldata,
rowdata=rowdata
)


###################################################
### code chunk number 22: in-silico data export (eval = FALSE)
###################################################
## ExportEV(modules, data, filename="file.evf", 
##          description=description)


###################################################
### code chunk number 23: sessioninfo
###################################################
toLatex(sessionInfo())


