# Code example from 'ArrayTV' vignette. See references/ for full tutorial.

### R code from vignette source 'ArrayTV.Rnw'

###################################################
### code chunk number 1: setup
###################################################
library(ArrayTV)
options(width=70)


###################################################
### code chunk number 2: loaddata
###################################################
library(ArrayTV)
### parallelization will be discussed later but for now we provide the following
### command to avoid warnings
if(require(doParallel)){
cl <- makeCluster(1)
registerDoParallel(cl)
}

path <- system.file("extdata", package="ArrayTV")
load(file.path(path, "array_logratios.rda"))
head(agilent)
head(affymetrix)
head(nimblegen)
agilent[, "M"] <- agilent[, "M"]/1000
affymetrix[, "M"] <- affymetrix[, "M"]/1000
nimblegen[, "M"] <- nimblegen[, "M"]/1000


###################################################
### code chunk number 3: windows
###################################################
max.window <- c(100,10e3,1e6)
increms <- c(20, 2000, 200e3)


###################################################
### code chunk number 4: tvscoresNim (eval = FALSE)
###################################################
## nimcM1List <- gcCorrect(object=nimblegen[, "M", drop=FALSE],
## 			chr=rep("chr15", nrow(nimblegen)),
##                         starts=nimblegen[, "position"],
##                         increms=increms,
##                         maxwins=max.window,
##                         build='hg18')
## afcM1List <- gcCorrect(affymetrix[, "M", drop=FALSE],
##                        chr=rep("chr15", nrow(affymetrix)),
##                        starts=affymetrix[, "position"],
##                        increms=increms,
##                        maxwins=max.window,
##                        build="hg18")


###################################################
### code chunk number 5: tvscores
###################################################
## We load the corrected NimbleGen values computed during unit-testing and Affy
## values, pre-computed, to save time
load(file=file.path(path,"nimcM1List.rda"))
load(file=file.path(path,"afcM1List.rda"))
agcM1List <- gcCorrect(agilent[, "M", drop=FALSE],
                       chr=rep("chr15", nrow(agilent)),
                       starts=agilent[, "position"],
                       increms=increms,
                       maxwins=max.window,
                       build="hg18")
if(require(doParallel))
    stopCluster(cl)


###################################################
### code chunk number 6: tvscorefig
###################################################
results <- list(nimcM1List,agcM1List,afcM1List)
tvscores <- do.call("rbind", lapply(results, "[[", "tvScore"))[, 1]
tv.df <- data.frame(tv=tvscores, platform=rep(c("NimbleGen", "Agilent", "Affy 2.7M"), each=15),
		    window=c(seq(20, 100, 20),
		    seq(2000, 10e3, 2e3), seq(2e5, 1e6, 2e5))*2)
op <- par(no.readonly = TRUE)
par(las=1, mar=c(6, 4, 3, 2)+0.1)
with(tv.df, plot(log10(window), tv, pch=20, col=tv.df$platform,
		 xaxt="n", xlab="window (bp)", ylab="TV score", cex=1.2))
invisible(lapply(split(tv.df, tv.df$platform), function(x)
                  points(log10(x$window),x$tv, type="l",col=x$platform, lwd=1.5)))
axis(1, at=log10(tv.df$window), labels=FALSE) #labels=FALSE, tick=TRUE)a
text(x=log10(tv.df$window), par("usr")[3]-0.005,
     labels=tv.df$window,
     srt=45, xpd=TRUE, cex=0.7, adj=1)
legend("bottomright", legend=unique(tv.df$platform),
       pch=20, col=unique(tv.df$platform), lwd=1.2)
par(op)


###################################################
### code chunk number 7: corrected_dataframe
###################################################
wave.df <- data.frame(position=c(rep(nimblegen[, "position"]/1e6, 2),
                      rep(agilent[, "position"]/1e6, 2),
                      rep(affymetrix[, "position"]/1e6,2)),
		      r=c(nimblegen[, "M"],
		      nimcM1List[['correctedVals']],
                      agilent[,"M"],
		      agcM1List[['correctedVals']],
                      affymetrix[,"M"], afcM1List[['correctedVals']]),
		      platform=rep(c(rep("Nimblegen", 2),
		      rep("Agilent", 2),
		      rep("Affymetrix", 2)), c(rep(length(nimblegen[, "M"]),2),
					       rep(length(agilent[,"M"]),2),
                                               rep(length(affymetrix[,"M"]),2))),
		      wave.corr=c(rep("raw", length(nimblegen[, "M"])),
		      rep("ArrayTV", length(nimblegen[, "M"])),
		      rep("raw", length(agilent[,"M"])),
		      rep("ArrayTV", length(agilent[,"M"])),
		      rep("raw", length(affymetrix[,"M"])),
		      rep("ArrayTV",length(affymetrix[,"M"]))))
wave.df$platform <- factor(wave.df$platform, levels=c("Nimblegen",
					      "Agilent", "Affymetrix"))
wave.df$wave.corr <- factor(wave.df$wave.corr, levels=c("raw", "ArrayTV"))
## remove some points to make subsequent figure smaller
wave.df <- wave.df[seq(1,nrow(wave.df),4),]


###################################################
### code chunk number 8: makewavefig
###################################################
    ## For each of the 3 example platforms, the uncorrected signal appears immediately above the
    ## corrected signal, across chromosome 15. A smoothed loess line may be drawn through each
    ## by uncommenting the commented line in the xyplot function
require("lattice") && require("latticeExtra")
p <- xyplot(r~position|platform+wave.corr, wave.df, pch=".", col="gray",
	    ylim=c(-2,1.5), xlim=range(nimblegen[, "position"]/1e6),
	    ylab="M", xlab="position (Mb) on chr15",
	    scales=list(y=list(tick.number=8)),
	    panel=function(x,y,subscripts,...){
                    panel.grid(lty=2)
                    panel.xyplot(x, y, ...)
                    panel.abline(h=0)
                    ## panel.loess(x, y, span=1/20, lwd=2, col="black")
	    }, par.strip.text=list(cex=0.9),
	    layout=c(2,3),
	    as.table=TRUE)


###################################################
### code chunk number 9: crossplatform
###################################################
p2 <- useOuterStrips(p)
print(p2)


###################################################
### code chunk number 10: cbs (eval = FALSE)
###################################################
## if(require("DNAcopy")){
## 	cbs.segs <- list()
## 	platforms <- c("Nimblegen", "Agilent", "Affymetrix")
## 	correction <- c("raw", "ArrayTV")
## 	Ms <- list(nimblegen[, "M"], nimcM1List[['correctedVals']],
## 		   agilent[, "M"], agcM1List[['correctedVals']],
## 		   affymetrix[, "M"], afcM1List[['correctedVals']])
## 	starts <- list(nimblegen[, "position"],
## 		       agilent[, "position"],
## 		       affymetrix[, "position"])
## 	k <- 0
## 	for(i in 1:3){
## 		for(j in 1:2){
## 			k <- k+1
## 			MsUse <- Ms[[k]]
## 			chrUse <- rep("chr15", length(MsUse))
## 			startsUse <- starts[[i]]
## 			toUse <- !(duplicated(startsUse))
## 			cna1 <- CNA(as.matrix(MsUse[toUse]),
## 				    chrUse[toUse],
## 				    startsUse[toUse],
## 				    data.type="logratio",
## 				    paste(platforms[i], correction[j], sep="_"))
##                         smooth.cna1 <- smooth.CNA(cna1)
## 			cbs.segs[[k]] <- segment(smooth.cna1, verbose=1,min.width = 5)
## 		}
##             }
## 	cbs.out <- do.call("rbind", lapply(cbs.segs, "[[", "output"))
##     }


###################################################
### code chunk number 11: saveCBSsegs (eval = FALSE)
###################################################
## save(cbs.out, file=file.path(path,"cbs_out.rda"))


###################################################
### code chunk number 12: loadCBSsegs
###################################################
load(file.path(path, "cbs_out.rda"))


###################################################
### code chunk number 13: cbsResults
###################################################
ids <- cbs.out$ID
## create vectors indicating corrected/uncorrected and platform for each cbs segment
platforms <- gsub("_raw", "", ids)
platforms <- gsub("_ArrayTV", "", platforms)
correction <- gsub("Nimblegen_", "", ids)
correction <- gsub("Affymetrix_", "", correction)
correction <- gsub("Agilent_", "", correction)
## store cbs segments in a GRanges object with designations for corrected/uncorrected
## and platform
cbs.segs <- GRanges(rep("chr14", nrow(cbs.out)),
		    IRanges(cbs.out$loc.start, cbs.out$loc.end),
		    numMarkers=cbs.out$num.mark,
		    seg.mean = cbs.out$seg.mean,
		    platform = platforms,
		    correction=correction)
## separate corrected and uncorrected cbs segments int separate objects
cbs.segs.raw <- cbs.segs[cbs.segs$correction=="raw", ]
cbs.segs.arrayTV <- cbs.segs[cbs.segs$correction=="ArrayTV", ]

## create GRanges objects with M values, platform, and
## corrected/uncorrected designation
marker.data <- GRanges(rep("chr14", nrow(wave.df)),
		    IRanges(wave.df$position*1e6, width=1),
		    numMarkers=1,
		    seg.mean = wave.df$r,
		    platform=wave.df$platform,
		    correction=wave.df$wave.corr)
marker.raw <- marker.data[marker.data$correction=="raw",]
marker.arrayTV <- marker.data[marker.data$correction=="ArrayTV",]

## populate cbs.seg metadata column by joining M values with CBS segments by location
olaps1 <- findOverlaps(marker.raw, cbs.segs.raw, select="first")
marker.raw$cbs.seg <- cbs.segs.raw$seg.mean[olaps1]
olaps2 <- findOverlaps(marker.arrayTV, cbs.segs.arrayTV, select="first")
marker.arrayTV$cbs.seg <- cbs.segs.arrayTV$seg.mean[olaps2]

## populate SpikeIn metadata column if a marker falls within the Spiked-in region
spikeIn <- IRanges(start=45396506,end=45537976)
spikeinStart <- 45396506; spikeinEnd <- 45537976
marker.raw$spikeIn <- marker.raw$cbs.seg
marker.arrayTV$spikeIn <- marker.arrayTV$cbs.seg
index1 <- which(!overlapsAny(unlist(as(ranges(marker.raw), "IntegerList")),
                             spikeIn))
index2 <- which(!overlapsAny(unlist(as(ranges(marker.arrayTV), "IntegerList")),
                             spikeIn))
marker.raw$spikeIn[index1] <- NA
marker.arrayTV$spikeIn[index2] <- NA

## put GRanges objects into a dataframe ahead of plotting
rawd <- as.data.frame(marker.raw)
atvd <- as.data.frame(marker.arrayTV)
rawd <- rbind(rawd, atvd)
rawd$platform <- factor(rawd$platform, levels=c("Nimblegen",
				       "Agilent", "Affymetrix"))
rawd$correction <- factor(rawd$correction, levels=c("raw", "ArrayTV"))
## remove some points to make subsequent figure smaller
rawd <- rawd[seq(1,nrow(rawd),2),]


###################################################
### code chunk number 14: cbs2
###################################################
p2 <- xyplot(seg.mean+cbs.seg+spikeIn~start/1e6|platform+correction, rawd,
	     ylim=c(-1.5, 1.5),
	     pch=".",
	     xlim=c(spikeinStart/1e6-1.5,spikeinEnd/1e6+1.5),
	     ylab="M",
             xlab="position (Mb)",##pch=c(".", NA,NA),
             col=c('gray','black','red'),
             distribute.type=TRUE,
             type=c('p','l','l'),lwd=c(NA,2,3),
             scales=list(y=list(tick.number=8)),
             par.strip.text=list(cex=0.9), layout=c(2,3), as.table=TRUE)
p3 <- useOuterStrips(p2)


###################################################
### code chunk number 15: spikein
###################################################
print(p3)


###################################################
### code chunk number 16: enablePar (eval = FALSE)
###################################################
## if(require(doParallel)){
## cl <- makeCluster(8)
## registerDoParallel(cl)
## }
## ## ... execute gcCorrect
## if(require(doParallel))
##     stopCluster(cl)


###################################################
### code chunk number 17: sessionInfo
###################################################
    toLatex(sessionInfo())


