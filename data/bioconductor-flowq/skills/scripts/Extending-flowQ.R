# Code example from 'Extending-flowQ' vignette. See references/ for full tutorial.

### R code from vignette source 'Extending-flowQ.Rnw'

###################################################
### code chunk number 1: loadPackage
###################################################
library(flowQ)
options(width=70)


###################################################
### code chunk number 2: createAggrs
###################################################
binaryAggregator()
discreteAggregator(2)
factorAggregator(factor("a", levels=letters[1:3]))
stringAggregator("test", passed=FALSE)
numericAggregator(20)
rangeAggregator(10, 0, 100)


###################################################
### code chunk number 3: aggrList
###################################################
aggregatorList(bin=binaryAggregator(FALSE), disc=discreteAggregator(1))


###################################################
### code chunk number 4: qaGraph
###################################################
tmp <- tempdir()
fn <- file.path(tmp, "test.jpg") 
jpeg(file=fn)
plot(1:3)
dev.off()
idir <- file.path(tmp, "images")
g <- qaGraph(fn, imageDir=idir)
g
qaGraph(imageDir=idir, empty=TRUE)


###################################################
### code chunk number 5: celnum1 (eval = FALSE)
###################################################
## ## Detect unusually low cell counts
## cellnumber <- function(set, threshold=5000, outdir, name="cellnumber")
## {
## }


###################################################
### code chunk number 6: celnum2 (eval = FALSE)
###################################################
## cellnumber <- function(set, threshold=5000, outdir, name="cellnumber")
## {
##     ## create the output directory in case it doesn't exist
##     if(!file.exists(outdir))
##         dir.create(outdir, recursive=TRUE)
##     ## get number of counts for each frame
##     cellNumbers <- as.numeric(fsApply(set, nrow))
##     ## produce a barplot from these numbers
##     sfile <- file.path(outdir, "summary.pdf")
##     pdf(file=sfile)
##     col <- "gray"
##     par(mar=c(10.1, 4.1, 4.1, 2.1), las=2)
##     barplot(cellNumbers, col=col, border=NA, names.arg=sampleNames(set),
##             cex.names=0.8, cex.axis=0.8)
##     abline(h=mean(cellNumbers), lty=3, lwd=2)
##     dev.off()
##     ## create a qaGraph object using the image
##     sgraph <- qaGraph(fileName=sfile, imageDir=outdir)
## }


###################################################
### code chunk number 7: celnum3 (eval = FALSE)
###################################################
## cellnumber <- function(set, threshold=5000, outdir, name="cellnumber")
## {
##     ## create the output directory in case it doesn't exist
##     if(!file.exists(outdir))
##         dir.create(outdir, recursive=TRUE)
##     ## get number of counts for each frame
##     cellNumbers <- as.numeric(fsApply(set, nrow))
##     ## produce a barplot from these numbers
##     sfile <- file.path(outdir, "summary.pdf")
##     pdf(file=sfile)
##     col <- "gray"
##     par(mar=c(10.1, 4.1, 4.1, 2.1), las=2)
##     barplot(cellNumbers, col=col, border=NA, names.arg=sampleNames(set),
##             cex.names=0.8, cex.axis=0.8)
##     dev.off()
##     ## create a qaGraph object using the image
##     sgraph <- qaGraph(fileName=sfile, imageDir=outdir)
##     ## create numericAggregators for each frame and store in list
##     frameIDs <- sampleNames(set)
##     frameProcesses <- vector(mode="list", length=length(frameIDs))
##     for(i in seq_along(frameIDs)){
##         agg <- new("numericAggregator", x=cellNumbers[i], passed=cellNumbers[i]>threshold)
##         frameProcesses[[i]] <- qaProcessFrame(frameIDs[i], agg)
##     }
##     ## create qaProcess object
##     return(qaProcess(id="cellnumprocess", name=name, type="cell number",
##                      summaryGraph=sgraph, frameProcesses=frameProcesses))
## }   


###################################################
### code chunk number 8: margin1 (eval = FALSE)
###################################################
## marginevents <- function(set, threshold=10, channels=colnames(set), outdir,
##                                    name="margin events")
## {
## }


###################################################
### code chunk number 9: margin2 (eval = FALSE)
###################################################
## mevents <- function(set, channels)
## {
##     ## count events on the margins using an boundaryFilter
##     sapply(channels, function(x) 
##        {
##            ff <- filter(set, boundaryFilter(x))
##            sapply(ff, function(y) summary(y)$p)
##        })
## }


###################################################
### code chunk number 10: margin3 (eval = FALSE)
###################################################
## marginevents <- function(set, threshold=10, channels=colnames(set), outdir,
##                                    name="margin events")
## {
##     ## count margin events
##     perc <- mevents(set, channels)
##     ## create summary plot
##     require("lattice")
##     tmp <- tempdir()
##     sfile <- file.path(tmp, "summary.pdf")
##     pdf(file=sfile)
##     col.regions=colorRampPalette(c("white",  "darkblue"))(256)
##     print(levelplot(t(perc)*100, scales = list(x = list(rot = 90)),
##                     xlab="", ylab="", main="% margin events",
##                     col.regions=col.regions))
##     dev.off()
##     sgraph <- qaGraph(fileName=sfile, imageDir=outdir)
## }


###################################################
### code chunk number 11: mevents4 (eval = FALSE)
###################################################
## marginevents <- function(set, threshold=10, channels=colnames(set), outdir,
##                                    name="margin events")
## {
##     ## count margin events
##     perc <- mevents(set, channels)
##     ## create summary plot
##     require("lattice")
##     tmp <- tempdir()
##     sfile <- file.path(tmp, "summary.pdf")
##     pdf(file=sfile)
##     col.regions=colorRampPalette(c("white",  "darkblue"))(256)
##     print(levelplot(perc*100, scales = list(x = list(rot = 90)),
##                     xlab="", ylab="", main="% margin events",
##                     col.regions=col.regions))
##     dev.off()
##     sgraph <- qaGraph(fileName=sfile, imageDir=outdir)
##     frameIDs <- sampleNames(set)
##     frameProcesses <- list()
##     ## create graphs and aggregators for each frame (and each channel)
##     for(i in 1:length(set)){
##         fnames <- NULL
##         ## this will hold the aggregators for all channels
##         agTmp <- aggregatorList()
##         for(j in 1:length(channels)){
##             ## the frame and parameter specific density plots
##             tfile <- file.path(tmp, paste("frame_", sprintf("%0.2d", i), "_",
##                                           gsub("\\..*$", "", channels[j]), ".pdf",
##                                           sep=""))
##             pdf(file=tfile, height=3)
##             par(mar=c(1,0,1,0))
##             plot(density(exprs(set[[i]][,channels[j]])), main=NULL)
##             dev.off()
##             fnames <- c(fnames, tfile)
##             ## test whether the particular frame and channel passes the check
##             ## and use a rangeAggregator to store that information
##             passed <- perc[i,j] < threshold/100
##             agTmp[[j]] <- new("rangeAggregator", passed=passed,
##                               x=perc[i,j], min=0, max=1)
##         }
##         ## summarize the results for individual subprocesses
##         names(agTmp) <- channels
##         nfail <- !sapply(agTmp, slot, "passed")
##         val <- if(sum(nfail)==1) factor(2) else if(sum(nfail)==0) factor(1) else factor(0)
##         ba <- new("discreteAggregator", x=val)
##         ## bundle up the graphs for all channels for this particular frame
##         fGraphs <- qaGraphList(imageFiles=fnames, imageDir=outdir)
##         ## create the qaProcessFrame objects for this sample
##         frameProcesses[[frameIDs[i]]] <- qaProcessFrame(frameID=frameIDs[i],
##                                                         summaryAggregator=ba,
##                                                         frameAggregators=agTmp,
##                                                         frameGraphs=fGraphs)
##     }
##     ## finally create the qaProcess object
##     return(qaProcess(id="processmarginevents", name=name,
##                type="margin events", summaryGraph=sgraph,
##                frameProcesses=frameProcesses))
## }    


