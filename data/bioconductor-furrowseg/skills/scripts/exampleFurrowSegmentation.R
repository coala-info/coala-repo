# Code example from 'exampleFurrowSegmentation' vignette. See references/ for full tutorial.

## ----style, eval=TRUE, echo=FALSE, results="asis"--------------------------
BiocStyle::latex()

## ----setup, include=FALSE--------------------------------------------------
library(knitr)
opts_chunk$set(fig.path="figExampleSegmentation/", fig.show="hold",
    fig.align="center", out.width="0.35\\linewidth")

## ----eval=TRUE, include=FALSE----------------------------------------------
library(furrowSeg)

## ----message=FALSE---------------------------------------------------------
data("exampleFurrowMovie")
img <- exampleFurrowMovie
rm(exampleFurrowMovie)

## ----segParm---------------------------------------------------------------
threshOffset <- 0.0005
px <- 0.293
filterSize <- makeOdd(round(microns2px(1, px=px)))
L <- makeOdd(round(microns2px(5, px=px)))
minObjectSize <- area2px(4, px=px)
maxObjectSize <- area2px(400, px=px)

## ----gaussianSmoothing-----------------------------------------------------
z <- makeBrush(size=filterSize, shape="gaussian", sigma=filterSize/2)
display(normalize(img[, , 1, 100]), method="raster")
img2 <- filter2(img, z)
display(normalize(img2[, , 1, 100]), method="raster")

## ----adaptiveThresholding--------------------------------------------------
mask <- thresh(x=img2[, , 1, ], w=L/2, h=L/2, offset=threshOffset)
display(mask[, , 100], method="raster")

## ----maskSmoothing---------------------------------------------------------
brush <- makeBrush(size=filterSize, shape="disc")
mask <- closing(mask, brush)
mask <- bwlabel(mask)
mask <- furrowSeg:::filterObjects(mask, minObjectSize, Inf)
display(mask[, , 100], method="raster")

## ----maskInversion---------------------------------------------------------
mask <- furrowSeg:::invertMask(mask)
mask <- fillHull(mask)
mask <- furrowSeg:::filterObjects(mask, 0, maxObjectSize)
display(mask[, , 100], method="raster")

## ----propagateSegmentation-------------------------------------------------
mask <- reenumerate(mask)
mask <- propagate(img2[, , 1, ], seeds=mask)
mask <- furrowSeg:::filterObjects(mask, minObjectSize, maxObjectSize)
hs <- paintObjects(x=mask, tgt=normalize(img), col="yellow")
display(hs[, , 1, 100], method="raster")

## ----comparisonToPackageFunction-------------------------------------------
x <- segmentFurrowAllStacks(x=img, L=L, filterSize=filterSize,
    threshOffset=threshOffset, closingSize=filterSize,
    minObjectSize=minObjectSize, maxObjectSize=maxObjectSize)
all(mask == x$mask[[1]])

## ----featureExtraction-----------------------------------------------------
nt <- dim(mask)[3]
getEBImageFeatures <- function(mask, ref) {
    xbw <- reenumerate(mask)
    fts <- computeFeatures(x=xbw, ref=ref,
        methods.noref=c("computeFeatures.moment", "computeFeatures.shape"))
    return(fts)
}
ftList <- lapply(1:nt, function(t) {
    df <- getEBImageFeatures(mask[, , t], img[, , 1, t])
    df <- as.data.frame(df, stringsAsFactors=FALSE)
    df$t <- t
    return(df)
})
fts <- do.call("rbind", ftList)

## ----APanisotropy----------------------------------------------------------
fts$e.x <- cos(fts$x.0.m.theta)*fts$x.0.m.eccentricity

## ----plotFeatures, out.width="0.5\\linewidth"------------------------------
box <- c("xleft"=64, "xright"=448, "ybottom"=128, "ytop"=384)
fts <- isolateBoxCells(fts, box)
plotFeatureEvolution(fts, tMax=10, dt=4.22/60, px=0.293)

