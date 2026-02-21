# Code example from 'cydar' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## ----setup, echo=FALSE, message=FALSE-----------------------------------------
library(cydar)
library(BiocParallel)
register(SerialParam())
set.seed(100)

## -----------------------------------------------------------------------------
ncells <- 20000
nda <- 200
nmarkers <- 31
down.pos <- 1.8
up.pos <- 1.2
conditions <- rep(c("A", "B"), each=3)
combined <- rbind(matrix(rnorm(ncells*nmarkers, 1.5, 0.6), ncol=nmarkers),
                  matrix(rnorm(nda*nmarkers, down.pos, 0.3), ncol=nmarkers),
                  matrix(rnorm(nda*nmarkers, up.pos, 0.3), ncol=nmarkers))
combined[,31] <- rnorm(nrow(combined), 1, 0.5) # last marker is a QC marker. 
combined <- 10^combined # raw intensity values                  
sample.id <- c(sample(length(conditions), ncells, replace=TRUE), 
               sample(which(conditions=="A"), nda, replace=TRUE), 
               sample(which(conditions=="B"), nda, replace=TRUE))
colnames(combined) <- paste0("Marker", seq_len(nmarkers))

## -----------------------------------------------------------------------------
library(ncdfFlow)
collected.exprs <- list()
for (i in seq_along(conditions)) {
    stuff <- list(combined[sample.id==i,,drop=FALSE])
    names(stuff) <- paste0("Sample", i)
    collected.exprs[[i]] <- poolCells(stuff)
}
names(collected.exprs) <- paste0("Sample", seq_along(conditions))
collected.exprs <- ncdfFlowSet(as(collected.exprs, "flowSet"))

## -----------------------------------------------------------------------------
pool.ff <- poolCells(collected.exprs)

## -----------------------------------------------------------------------------
library(flowCore)
trans <- estimateLogicle(pool.ff, colnames(pool.ff))
proc.ff <- transform(pool.ff, trans)

## -----------------------------------------------------------------------------
gate.31 <- outlierGate(proc.ff, "Marker31", type="upper")
gate.31
filter.31 <- filter(proc.ff, gate.31)
summary(filter.31@subSet)

## -----------------------------------------------------------------------------
processed.exprs <- transform(collected.exprs, trans)

## -----------------------------------------------------------------------------
processed.exprs <- Subset(processed.exprs, gate.31)

## -----------------------------------------------------------------------------
processed.exprs <- processed.exprs[,1:30]

## -----------------------------------------------------------------------------
cd <- prepareCellData(processed.exprs)

## -----------------------------------------------------------------------------
cd <- countCells(cd, tol=0.5)

## -----------------------------------------------------------------------------
head(assay(cd))

## -----------------------------------------------------------------------------
head(intensities(cd))

## -----------------------------------------------------------------------------
library(edgeR)
y <- DGEList(assay(cd), lib.size=cd$totals)

## -----------------------------------------------------------------------------
keep <- aveLogCPM(y) >= aveLogCPM(5, mean(cd$totals))
cd <- cd[keep,]
y <- y[keep,]

## -----------------------------------------------------------------------------
design <- model.matrix(~factor(conditions))
y <- estimateDisp(y, design)
fit <- glmQLFit(y, design, robust=TRUE)
res <- glmQLFTest(fit, coef=2)

## -----------------------------------------------------------------------------
qvals <- spatialFDR(intensities(cd), res$table$PValue)

## -----------------------------------------------------------------------------
is.sig <- qvals <= 0.05
summary(is.sig)

## -----------------------------------------------------------------------------
sig.coords <- intensities(cd)[is.sig,]
sig.res <- res$table[is.sig,]
coords <- prcomp(sig.coords)

## -----------------------------------------------------------------------------
plotSphereLogFC(coords$x[,1], coords$x[,2], sig.res$logFC)

## ----fig.width=10,fig.height=12-----------------------------------------------
par(mfrow=c(6,5), mar=c(2.1, 1.1, 3.1, 1.1))
limits <- intensityRanges(cd, p=0.05)
all.markers <- markernames(cd)
for (i in order(all.markers)) { 
    plotSphereIntensity(coords$x[,1], coords$x[,2], sig.coords[,i],
        irange=limits[,i], main=all.markers[i])
}

## -----------------------------------------------------------------------------
nonred <- findFirstSphere(intensities(cd), res$table$PValue)
summary(nonred)

## -----------------------------------------------------------------------------
all.coords <- prcomp(intensities(cd))
app <- interpretSpheres(cd, select=nonred, metrics=res$table, run=FALSE,
                        red.coords=all.coords$x[,1:2], red.highlight=is.sig) 
# Set run=TRUE if you want the app to run automatically.

## -----------------------------------------------------------------------------
sessionInfo()

