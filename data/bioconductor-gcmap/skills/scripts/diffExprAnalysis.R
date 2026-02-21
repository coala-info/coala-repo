# Code example from 'diffExprAnalysis' vignette. See references/ for full tutorial.

### R code from vignette source 'diffExprAnalysis.Rnw'

###################################################
### code chunk number 1: diffExprAnalysis.Rnw:35-36
###################################################
options(warn=-1)


###################################################
### code chunk number 2: makeExampleCountDataSet
###################################################
library(gCMAP)
library(DESeq)

set.seed( 123 )
cds.list <- lapply( 1:3, function(n) {
   cds <- makeExampleCountDataSet()
   featureNames(cds) <- paste("gene",1:10000, sep="_")
   cds
})
names(cds.list) <- paste("Instance", 1:3, sep="")

sapply(cds.list, dim)

sapply(cds.list, function(n) pData(n)$condition )


###################################################
### code chunk number 3: generate_gCMAP_NChannelSet
###################################################
## this step takes a little time
cde <- generate_gCMAP_NChannelSet(cds.list,
                           uids=1:3,
                           sample.annotation=NULL,
                           platform.annotation="Entrez",
                           control_perturb_col="condition",
                           control="A",
                           perturb="B")
channelNames(cde)


###################################################
### code chunk number 4: big.matrix
###################################################
## list of ExpressionSets
if (require(bigmemory)) {
  data("sample.ExpressionSet") ## from Biobase
  
  es.list <- list( sample.ExpressionSet[,1:4],
                   sample.ExpressionSet[,5:8],
                   sample.ExpressionSet[,9:12])
  
  ## three instances
  names(es.list) <- paste( "Instance", 1:3, sep=".")
  
  storage.file <- tempfile()
  storage.file ## filename prefix for BigMatrices
  
  de <- generate_gCMAP_NChannelSet(
    es.list,
    1:3,
    platform.annotation = annotation(es.list[[1]]),
    control_perturb_col="type",
    control="Control",
    perturb="Case",
    big.matrix=storage.file) 
  
  channelNames(de)
  head( assayDataElement(de, "z") ) 
  
  dir(dirname( storage.file ))
}


###################################################
### code chunk number 5: subsettingBigMatrices
###################################################
if (require(bigmemory)) {
  ## remove de object from R session and reload
  rm( de )
  
  de <-get( load( paste( storage.file, "rdata", sep=".")) )
  class( assayDataElement(de, "z") )
  assayDataElement(de, "z")[1:10,] ## load subset
}


###################################################
### code chunk number 6: memorize
###################################################
if (require(bigmemory)) {
  ## read z-score channel into memory
  dem <- memorize( de, name="z" )
  channelNames(dem)
  
  class( assayDataElement(dem, "z") ) ## matrix
  ## remove tempfiles
  unlink(paste(storage.file,"*", sep=""))  
}


###################################################
### code chunk number 7: sessionInfo
###################################################
  sessionInfo()


