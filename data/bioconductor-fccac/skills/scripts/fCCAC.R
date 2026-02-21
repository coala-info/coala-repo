# Code example from 'fCCAC' vignette. See references/ for full tutorial.

### R code from vignette source 'fCCAC.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: setup
###################################################
options(width=200)
options(continue=" ")
options(prompt="R> ")


###################################################
### code chunk number 3: fCCACexample
###################################################
options(width=50);
if (.Platform$OS.type == "windows") { print("...rtracklayer is unable to read bigWig format files in Windows...") }

if (.Platform$OS.type == "unix") {
    ## hg19. chr21:40000000-48129895 H3K4me3 data from Bertero et al. (2015)
    owd <- setwd(tempdir());

    library(fCCAC)

    bigwig1 <- "chr21_H3K4me3_1.bw"
    bigwig2 <- "chr21_H3K4me3_2.bw"
    bigwig3 <- "chr21_H3K4me3_3.bw"
    peakFile <- "chr21_merged_ACT_K4.bed"
    labels <- c( "H3K4me3", "H3K4me3","H3K4me3" )

    r1 <- system.file("extdata", bigwig1,  package="fCCAC",mustWork = TRUE)
    r2 <- system.file("extdata", bigwig2,  package="fCCAC",mustWork = TRUE)
    r3 <- system.file("extdata", bigwig3,  package="fCCAC",mustWork = TRUE)
    r4 <- system.file("extdata", peakFile, package="fCCAC",mustWork = TRUE)
    ti <- "H3K4me3 peaks (chr21)"

    fc <- fccac(bar=NULL, main=ti, peaks=r4, bigwigs=c(r1,r2,r3), labels=labels, splines=15, nbins=100, ncan=15)

    head(fc)

    setwd(owd)
}


###################################################
### code chunk number 4: heatmapPlot
###################################################
options(width=50)
if (.Platform$OS.type == "windows") { print("...rtracklayer is unable to read bigWig format files in Windows...") }

if (.Platform$OS.type == "unix" ){ heatmapfCCAC(fc) }



###################################################
### code chunk number 5: sessionInfo
###################################################
sessionInfo()


