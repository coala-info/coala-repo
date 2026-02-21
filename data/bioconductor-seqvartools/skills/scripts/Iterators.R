# Code example from 'Iterators' vignette. See references/ for full tutorial.

### R code from vignette source 'Iterators.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: Iterators.Rnw:30-42
###################################################
library(SeqVarTools)
gds <- seqOpen(seqExampleFileName("gds"))
seqData <- SeqVarData(gds)
iterator <- SeqVarBlockIterator(seqData, variantBlock=500)
var.info <- list(variantInfo(iterator))
i <- 2
while(iterateFilter(iterator)) {
    var.info[[i]] <- variantInfo(iterator)
    i <- i + 1
}
lapply(var.info, head)
seqResetFilter(seqData)


###################################################
### code chunk number 3: Iterators.Rnw:48-54
###################################################
seqSetFilter(seqData, variant.sel=1:100)
iterator <- SeqVarBlockIterator(seqData, variantBlock=500)
var.info <- variantInfo(iterator)
nrow(var.info)
iterateFilter(iterator)
seqResetFilter(seqData)


###################################################
### code chunk number 4: Iterators.Rnw:64-76
###################################################
library(GenomicRanges)
gr <- GRanges(seqnames=rep(1,3), 
              ranges=IRanges(start=c(1e6, 2e6, 3e6), width=1e6))
iterator <- SeqVarRangeIterator(seqData, variantRanges=gr)
var.info <- list(variantInfo(iterator))
i <- 2
while(iterateFilter(iterator)) {
    var.info[[i]] <- variantInfo(iterator)
    i <- i + 1
}
lapply(var.info, head)
seqResetFilter(seqData)


###################################################
### code chunk number 5: Iterators.Rnw:86-97
###################################################
seqSetFilterChrom(seqData, include="22")
iterator <- SeqVarWindowIterator(seqData, windowSize=10000, 
                                 windowShift=5000)
var.info <- list(variantInfo(iterator))
i <- 2
while(iterateFilter(iterator)) {
    var.info[[i]] <- variantInfo(iterator)
    i <- i + 1
}
lapply(var.info, head)
seqResetFilter(seqData)


###################################################
### code chunk number 6: Iterators.Rnw:107-120
###################################################
gr <- GRangesList(
  GRanges(seqnames=rep(22,2), 
          ranges=IRanges(start=c(16e6, 17e6), width=1e6)),
  GRanges(seqnames=rep(22,2), 
          ranges=IRanges(start=c(18e6, 20e6), width=1e6)))
iterator <- SeqVarListIterator(seqData, variantRanges=gr)
var.info <- list(variantInfo(iterator))
i <- 2
while(iterateFilter(iterator)) {
    var.info[[i]] <- variantInfo(iterator)
    i <- i + 1
}
lapply(var.info, head)


###################################################
### code chunk number 7: Iterators.Rnw:127-130
###################################################
variantInfo(iterator)
resetIterator(iterator)
variantInfo(iterator)


###################################################
### code chunk number 8: Iterators.Rnw:133-134
###################################################
seqClose(gds)


