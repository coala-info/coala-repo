# Code example from 'cosmiq' vignette. See references/ for full tutorial.

### R code from vignette source 'cosmiq.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: cosmiq.Rnw:43-57 (eval = FALSE)
###################################################
## library(cosmiq)
## cdfpath <- file.path(find.package("faahKO"), "cdf")
## 
## my.input.files <- dir(c(paste(cdfpath, "WT", sep='/'), 
## 	paste(cdfpath, "KO", sep='/')), full.names=TRUE)
## 
## # run cosmiq wrapper function
## #
## x <- cosmiq(files=my.input.files, mzbin=0.25, SNR.Th=0, linear=TRUE)
## # 
## 
## # graph result
## image(t(x$eicmatrix), main='mz versus RT map')
## head(x$xs@peaks)


###################################################
### code chunk number 3: cosmiq.Rnw:78-79
###################################################
options(width=80)


###################################################
### code chunk number 4: cosmiq.Rnw:87-97
###################################################
library(cosmiq)
cdfpath <- file.path(find.package("faahKO"), "cdf")
my.input.files <- dir(c(paste(cdfpath, "WT", sep='/'), 
	paste(cdfpath, "KO", sep='/')), full.names=TRUE)

#
# create xcmsSet object
# todo
xs <- new("xcmsSet")
xs@filepaths <- my.input.files


###################################################
### code chunk number 5: cosmiq.Rnw:103-106
###################################################
class <- as.data.frame(c(rep("KO",6),rep("WT", 6)))
rownames(class) <- basename(my.input.files)
xs@phenoData <- class


###################################################
### code chunk number 6: cosmiq.Rnw:111-112
###################################################
attributes(xs)


###################################################
### code chunk number 7: cosmiq.Rnw:127-135
###################################################

x <- combine_spectra(xs=xs, mzbin=0.25, 
	linear=TRUE, continuum=FALSE)

plot(x$mz, x$intensity, type='l',
	main='combined spectra',
	xlab='m/Z', ylab='ion intensity')



###################################################
### code chunk number 8: cosmiq.Rnw:151-170
###################################################

xy <- peakdetection(x=x$mz, y=x$intensity, 
    scales=1:10, 
    SNR.Th=1.0, 
    SNR.area=20, mintr=0.5)

id.peakcenter<-xy[,4]

filter.mz <- 400 < x$mz & x$mz < 450
plot(x$mz[filter.mz], x$intensity[filter.mz], 
    main='Detection of relevant masses',
    type='l',
    xlab='m/Z', 
    ylab='ion intensity')

points(x$mz[id.peakcenter], 
    x$intensity[id.peakcenter], 
    col='red', type='h')



###################################################
### code chunk number 9: cosmiq.Rnw:188-199
###################################################

# create dummy object
xs@peaks <- matrix(c(rep(1, length(my.input.files) * 6), 
	1:length(my.input.files)), ncol=7)

colnames(xs@peaks) <- c("mz", "mzmin", "mzmax", "rt", 
	"rtmin", "rtmax", "sample")

xs <- xcms::retcor(xs, method="obiwarp", profStep=1, 
	distFunc="cor", center=1)



###################################################
### code chunk number 10: cosmiq.Rnw:217-257
###################################################

eicmat <- eicmatrix(xs=xs, xy=xy, center=1)

#
#  process a reduced mz range for a better package build performance
(eicmat.mz.range <- range(which(475 < xy[,1] & xy[,1] < 485)))

eicmat.filter <- eicmat[eicmat.mz.range[1]:eicmat.mz.range[2],]
xy.filter <- xy[eicmat.mz.range[1]:eicmat.mz.range[2],]

#
# determine the new range and plot the mz versus RT map
(rt.range <- range(as.double(colnames(eicmat.filter))))
(mz.range<-range(as.double(row.names(eicmat.filter))))

image(log(t(eicmat.filter))/log(2), 
    main='overlay of 12 samples using faahKO',
    col=rev(gray(1:20/20)),
    xlab='rt [in seconds]', 
    ylab='m/z', axes=FALSE)

axis(1, seq(0,1, length=6), 
    round(seq(rt.range[1], rt.range[2], length=6)))

axis(2, seq(0,1, length=4), 
    round(seq(mz.range[1], mz.range[2], length=4), 2))

#
# determine the chromatographic peaks
rxy <- retention_time(xs=xs, 
    RTscales=c(1:10, seq(12,32, by=2)), 
    xy=xy.filter, 
    eicmatrix=eicmat.filter, 
    RTSNR.Th=120, RTSNR.area=20)

rxy.rt <- (rxy[,4] - rt.range[1]) / diff(rt.range)
rxy.mz <- (rxy[,1] - mz.range[1]) / diff(mz.range)

points(rxy.rt, rxy.mz, pch="X", lwd=2, col="red")



###################################################
### code chunk number 11: cosmiq.Rnw:274-275
###################################################
xs <- create_datamatrix(xs=xs, rxy=rxy)


###################################################
### code chunk number 12: cosmiq.Rnw:284-289
###################################################
peaktable <- xcms::peakTable(xs)

idx <- order(rowSums(peaktable[,8:19]), decreasing=TRUE)
head(peaktable[idx,])



###################################################
### code chunk number 13: sessioninfo
###################################################
toLatex(sessionInfo())


