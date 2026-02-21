# Code example from 'gDNAx' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE--------------------------------------------------------
library(knitr)

options(width=80)

knitr::opts_chunk$set(
    collapse=TRUE,
    comment="")

## ----message=FALSE------------------------------------------------------------
library(gDNAinRNAseqData)

# Retrieve BAM files
bamfiles <- LiYu22subsetBAMfiles()
bamfiles

# Retrieve information on the gDNA concentrations of each BAM file
pdat <- LiYu22phenoData(bamfiles)
pdat

## ----message=FALSE------------------------------------------------------------
library(TxDb.Hsapiens.UCSC.hg38.knownGene)

txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene
txdb

## ----message=FALSE------------------------------------------------------------
library(gDNAx)

gdnax <- gDNAdx(bamfiles, txdb)
class(gdnax)
gdnax

## ----defdiag, height=12, width=8, out.width="800px", fig.cap="Diagnostics. Default diagnostics obtained with the function `plot()` on a `gDNAx` object."----
par(mar=c(4, 5, 2, 1))
plot(gdnax, group=pdat$gDNA, pch=19)

## -----------------------------------------------------------------------------
dx <- getDx(gdnax)
dx

## ----frglen, height=3, width=8, out.width="800px", fig.cap="Fragments length distributions. Density and location of the estimated fragments length distribution, by the origin of the alignments."----
plotFrgLength(gdnax)

## ----alnorigins, height=4, width=8, out.width="800px", fig.cap="Alignment origins."----
plotAlnOrigins(gdnax, group=pdat$gDNA)

## -----------------------------------------------------------------------------
igcann <- getIgc(gdnax)
igcann
intann <- getInt(gdnax)
intann

## ----message=FALSE------------------------------------------------------------
strandedness(gdnax)

## -----------------------------------------------------------------------------
classifyStrandMode(strandedness(gdnax))

## ----eval=FALSE---------------------------------------------------------------
# ## fbf <- filterBAMtxFlag(isSpliceCompatibleJunction=TRUE,
# ##                        isSpliceCompatibleExonic=TRUE)
# ## fstats <- filterBAMtx(gdnax, path=tmpdir, txflag=fbf)
# ## fstats
# tmpdir <- tempdir()
# fstats <- gDNAtx(gdnax, path=tmpdir)
# fstats

## ----echo=FALSE---------------------------------------------------------------
fstats_f <- file.path(system.file("extdata", package="gDNAx"),
                      "cached_gDNAtx_fstats.rds")
fstats <- readRDS(fstats_f)
fstats

## ----session_info, cache=FALSE------------------------------------------------
sessionInfo()

