# Code example from 'PLLPanalysis' vignette. See references/ for full tutorial.

### R code from vignette source 'PLLPanalysis.Rnw'

###################################################
### code chunk number 1: installPackages (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install(c("EBImage", "parallel"))


###################################################
### code chunk number 2: loadPackages
###################################################
library("DonaPLLP2013")


###################################################
### code chunk number 3: loadImages
###################################################
xGFP <- readImage(system.file("extdata/cxcr4b_02C1.tif", package="DonaPLLP2013")) 
xRFP <- readImage(system.file("extdata/cxcr4b_02C2.tif", package="DonaPLLP2013")) 


###################################################
### code chunk number 4: displayImages
###################################################
dim(xGFP)
xGFP.proj <- apply(xGFP, c(1, 2), max)
writeImage(normalize(xGFP.proj), "PLLPanalysis-displayImages.jpeg")


###################################################
### code chunk number 5: setUnits
###################################################
Lpx <- c(x=0.1318, y=0.1318, z=1)
Lbox <- Lpx*dim(xGFP)  
Lbox
Leff <- round(5/Lpx["x"])           
Leff


###################################################
### code chunk number 6: backgroundSubtraction
###################################################
xbckGFP <- readImage(system.file("extdata/bgC1.tif", package="DonaPLLP2013"))
xbckRFP <- readImage(system.file("extdata/bgC2.tif", package="DonaPLLP2013"))
xGFP <- xGFP-mean(xbckGFP, na.rm=TRUE)
xRFP <- xRFP-mean(xbckRFP, na.rm=TRUE)


###################################################
### code chunk number 7: gaussianSmoothing
###################################################
Lpsf <- round(0.5/Lpx["x"])     
Lpsfodd <- ifelse(Lpsf%%2 == 0, Lpsf+1, Lpsf)
z <- makeBrush(size=Lpsfodd, shape="gaussian", sigma=Lpsfodd/2)
x2GFP <- filter2(xGFP, filter=z)
x2RFP <- filter2(xRFP, filter=z)
x2GFP.proj <- apply(x2GFP, c(1, 2), max)
writeImage(normalize(x2GFP.proj), "PLLPanalysis-gaussianSmoothing.jpeg")


###################################################
### code chunk number 8: adaptiveThresholding
###################################################
mk <- function(size) makeBrush(size, shape="disc")
mask <- thresh(x2GFP, w=Leff, h=Leff, offset=0.01)
mask <- erode(closing(mask, mk(Lpsfodd)), mk(Lpsfodd-2))
maskSlice <- mask[, , 20]
writeImage(maskSlice, "PLLPanalysis-maskSlice.jpeg")
maskDensity.proj <- apply(mask, c(1, 2), mean)
writeImage(normalize(maskDensity.proj), "PLLPanalysis-maskDensity.jpeg")


###################################################
### code chunk number 9: obtainOrganMask
###################################################
organ.mask <- apply(fillHull(mask), c(1, 2), max) 
organ.mask <- opening(closing(organ.mask, mk(Leff/2)), mk(Leff/2))
organ.labels <- bwlabel(organ.mask)
I <- which(table(organ.labels)[-1] < max(table(organ.labels)[-1])) 
organ.mask <- rmObjects(organ.labels, I)
organ.mask[organ.mask > 0] <- 1
organ.mask <- fillHull(organ.mask)
writeImage(organ.mask, "PLLPanalysis-organMask.jpeg")


###################################################
### code chunk number 10: principalComponentAnalysis
###################################################
organ.coord <- as.data.frame(which(organ.mask == 1, arr.ind=TRUE),
                             stringsAsFactors=FALSE) 
colnames(organ.coord) <- c("x", "y")
organ.coord$x <- (organ.coord$x-1)*Lpx["x"]
organ.coord$y <- -(organ.coord$y-1)*Lpx["y"]
organ.pca <- prcomp(organ.coord)
pc1 <- organ.pca$rotation[, 1]
pc1.theta <- atan(pc1["y"]/pc1["x"])*(180/pi)
pc1.theta


###################################################
### code chunk number 11: rotateImages
###################################################
xGFP <- rotate(xGFP, angle=pc1.theta)
xRFP <- rotate(xRFP, angle=pc1.theta)
x2GFP <- rotate(x2GFP, angle=pc1.theta)
x2RFP <- rotate(x2RFP, angle=pc1.theta)
mask <- rotate(mask, angle=pc1.theta)
organ.mask <- rotate(organ.mask, angle=pc1.theta)


###################################################
### code chunk number 12: excludeExteriorPixels
###################################################
organ.mask.rep <- replicate(dim(xGFP)[3], organ.mask)
I1 <- which(organ.mask.rep == 1)
I2 <- which(mask == 1)
I <- intersect(I1, I2)
mask <- array(0, dim=dim(organ.mask.rep))
mask[I] <- 1


###################################################
### code chunk number 13: cropImages
###################################################
I <- which(organ.mask.rep == 1, arr.ind=TRUE)
intRange <- function(x) {rg=range(x); seq(rg[1], rg[2], by=1)}
x.range <- intRange(I[, 1])
y.range <- intRange(I[, 2])
xGFP <- xGFP[x.range, y.range, ]
xRFP <- xRFP[x.range, y.range, ]
x2GFP <- x2GFP[x.range, y.range, ]
x2RFP <- x2RFP[x.range, y.range, ]
mask <- mask[x.range, y.range, ]
organ.mask <- organ.mask[x.range, y.range]
writeImage(organ.mask, "PLLPanalysis-cropImages.jpeg")


###################################################
### code chunk number 14: cropCoordinates
###################################################
Lbox <- Lpx*dim(xGFP)
Lbox


###################################################
### code chunk number 15: runningMedianFunctions
###################################################
getCoordinates <-
function(s, xrange, yrange, zrange) {
    Ix=which(s$x >= min(xrange) & s$x <= max(xrange))
    Iy=which(s$y >= min(yrange) & s$y <= max(yrange))
    Iz=which(s$z >= min(zrange) & s$z <= max(zrange))
    return(list(x=Ix, y=Iy, z=Iz))
}

getCubeIntensity <-
function(x0, x, y, z, spatial, Lcube) {
    crd <- getCoordinates(spatial,
                          xrange=c(x-Lcube/2, x+Lcube/2),
                          yrange=c(y-Lcube/2, y+Lcube/2),
                          zrange=c(z-Lcube/2, z+Lcube/2))
    cube.median <- median(imageData(x0)[crd$x, crd$y, crd$z], na.rm=TRUE)
    return(list(median=cube.median))
}

runningMedian <-
function(x, grid.x, grid.y, grid.z, Lx, Ly, Lz, nCores=2, Lcube) {
    grid <- as.list(data.frame(t(expand.grid(grid.x, grid.y, grid.z))))
    spatial <- list(x=(1:dim(x)[1]-1)*Lx, 
                    y=(1:dim(x)[2]-1)*Ly,
                    z=(1:dim(x)[3]-1)*Lz)
    chooseCores <- function(numCoresWanted) {
        if(.Platform$OS.type == "windows") return(1)
        return(numCoresWanted)
    }
    dataIntensities <-
        mclapply(grid, function(s) getCubeIntensity(x0=x, x=s[1], y=s[2], z=s[3],
                                                    spatial=spatial, Lcube=Lcube), 
                 mc.cores=chooseCores(nCores), 
                 mc.preschedule=FALSE)
    dataIntensities=unlist(dataIntensities)
    result.median=array(dataIntensities,
                        dim=c(length(grid.x), length(grid.y), length(grid.z)))
    return(result.median)
}


###################################################
### code chunk number 16: runningMedianGrid
###################################################
Ljump <- 5
Lcube <- 10
grid.x <- seq(from=0, to=Lbox["x"], by=Ljump)
grid.y <- seq(from=0, to=Lbox["y"], by=Ljump)
grid.z <- seq(from=0, to=Lbox["z"], by=Ljump)


###################################################
### code chunk number 17: runningMedian
###################################################
I <- which(mask == 0)
xGFP.maskOnly <- xGFP
xRFP.maskOnly <- xRFP
xGFP.maskOnly[I] <- NA
xRFP.maskOnly[I] <- NA
resultGFP <- runningMedian(x=xGFP.maskOnly, 
                           grid.x=grid.x, grid.y=grid.y, grid.z=grid.z, 
                           Lx=Lpx["x"], Ly=Lpx["y"], Lz=Lpx["z"], 
                           nCores=4, Lcube=Lcube)
resultRFP <- runningMedian(x=xRFP.maskOnly, 
                           grid.x=grid.x, grid.y=grid.y, grid.z=grid.z, 
                           Lx=Lpx["x"], Ly=Lpx["y"], Lz=Lpx["z"], 
                           nCores=4, Lcube=Lcube)


###################################################
### code chunk number 18: plotFluorescenceChannels
###################################################
GFP.profile=apply(resultGFP, 1, median, na.rm=TRUE)
RFP.profile=apply(resultRFP, 1, median, na.rm=TRUE)
plot(-grid.x, rev(GFP.profile), 
     xlab="Distance from leading edge (microns)", 
     ylab="Fluorescence intensity (a.u.)", 
     type="b", 
     axes="F", 
     pch=1, 
     ylim=c(0, range(GFP.profile, RFP.profile, na.rm=TRUE)[2]), 
     col="darkgreen")
points(-grid.x, rev(RFP.profile), type="b", pch=2, col="red")
axis.at.x <- seq(-200 ,0 , by=25)
axis(1, at=axis.at.x, labels=-axis.at.x)
axis(2)
legend("topright", legend=c("GFP", "RFP"), pch=1:2, col=c("darkgreen", "red"))


###################################################
### code chunk number 19: plotRatio
###################################################
resultRatio <- resultRFP/resultGFP
ratio.profile <- apply(resultRatio, 1, median, na.rm=TRUE)
plot(-grid.x, rev(ratio.profile), 
     xlab="Distance from leading edge (microns)", 
     ylab="RFP/GFP fluorescence intensity ratio (-)", 
     type="b", 
     axes="F")
axis.at.x <- seq(-200, 0, by=25)
axis(1, at=axis.at.x, labels=-axis.at.x)
axis(2)


###################################################
### code chunk number 20: solutionBackgroundSubtraction
###################################################
solGFP <- readImage(system.file("extdata/1_100_mCherryC1.tif",
                    package="DonaPLLP2013"))
solGFPbck <- readImage(system.file("extdata/PBSC1.tif", package="DonaPLLP2013"))
solRFP <- readImage(system.file("extdata/1_100_mCherryC2.tif",
                    package="DonaPLLP2013"))
solRFPbck <- readImage(system.file("extdata/PBSC2.tif", package="DonaPLLP2013"))
solRFP <- solRFP-mean(solRFPbck)
solGFP <- solGFP-mean(solGFPbck)


###################################################
### code chunk number 21: correctSampleRatioByControlRatio
###################################################
solRatio <- mean(solRFP)/mean(solGFP)
resultRatioCorrected <- resultRatio/solRatio


###################################################
### code chunk number 22: wholeSampleRatio
###################################################
print(median(resultRatioCorrected, na.rm=TRUE))


###################################################
### code chunk number 23: varyMembraneThickness
###################################################
membraneRatio <- array(dim=5)
I <- which(mask == 1)
membraneRatio[3] <- median(xRFP[I])/median(xGFP[I])

calcRatioOnModifiedMembrane <- function(xGFP, xRFP, mask, morph=erode, steps=1) {
 for (i in seq_len(steps)) mask <- morph(mask, mk(2))
 I <- which(mask == 1)
 return(median(xRFP[I])/median(xGFP[I]))
}

membraneRatio[1] <- calcRatioOnModifiedMembrane(xGFP, xRFP, mask, erode, 2)
membraneRatio[2] <- calcRatioOnModifiedMembrane(xGFP, xRFP, mask, erode, 1)
membraneRatio[4] <- calcRatioOnModifiedMembrane(xGFP, xRFP, mask, dilate, 1)
membraneRatio[5] <- calcRatioOnModifiedMembrane(xGFP, xRFP, mask, dilate, 2)
plot(1:5, membraneRatio, xlab="Mask ID", 
     ylab="RFP/GFP fluorescence intensity ratio (-)", 
     ylim=c(0, max(membraneRatio)))


