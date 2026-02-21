# Code example from 'methylumi450k' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------
library(knitr)
opts_chunk$set(tidy=FALSE,cache=TRUE,size='scriptsize')

## ----setup,eval=TRUE,hide=TRUE,echo=FALSE-------
options('width'=50)

## ----loadLibraries, eval=TRUE-------------------
suppressPackageStartupMessages(require('methylumi'))
suppressPackageStartupMessages(require('TCGAMethylation450k'))
suppressPackageStartupMessages(require('FDb.InfiniumMethylation.hg19'))

## ----loadData, eval=TRUE------------------------
## read in 10 BRCA IDATs 
idatPath <- system.file('extdata/idat',package='TCGAMethylation450k')
mset450k <- methylumIDAT(getBarcodes(path=idatPath), idatPath=idatPath)
sampleNames(mset450k) <- paste0('TCGA', seq_along(sampleNames(mset450k)))
show(mset450k)

## ----controls, fig.width=5, fig.height=7, quiet=TRUE, echo=TRUE, cache=FALSE----
library(ggplot2)
## for larger datasets, the by.type argument be set to FALSE 
## positional effects will manifest as a wave-like pattern
p <- qc.probe.plot(mset450k, by.type=TRUE)
print(p)

## ----preprocess, eval=TRUE----------------------
mset450k.proc <- stripOOB(normalizeMethyLumiSet(methylumi.bgcorr(mset450k)))

## ----controls2, fig.width=5, fig.height=7, quiet=TRUE, echo=TRUE, cache=FALSE----
library(ggplot2)
p2 <- qc.probe.plot(mset450k.proc, by.type=TRUE)
print(p2)

## ----coerceLumi, eval=TRUE----------------------
suppressPackageStartupMessages(require(lumi))
mset450k.lumi <- as(mset450k.proc, 'MethyLumiM')
show(mset450k.lumi)

## ----coerceBack, eval=TRUE----------------------
mset450k.andBack <- as(mset450k.lumi, 'MethyLumiSet')
show(mset450k.andBack)

## ----coerceMinfi, eval=TRUE---------------------
suppressPackageStartupMessages(require(FDb.InfiniumMethylation.hg19))
rgSet450k <- as(mset450k, 'RGChannelSet')
show(rgSet450k)

## ----coerceMinfi2, eval=TRUE--------------------
suppressPackageStartupMessages(require(minfi))
suppressPackageStartupMessages(require(IlluminaHumanMethylation450kanno.ilmn12.hg19))
grSet450k <- mapToGenome(mset450k.andBack)

sexChroms <- GRanges( seqnames=c('chrX','chrY'),
                      IRanges(start=c(1, 1), 
                              end=c(155270560, 59373566)),
                      strand=c('*','*') )
summary(subsetByOverlaps(grSet450k, sexChroms))
dim(subsetByOverlaps(grSet450k, sexChroms))

## ----subsetMinfi, eval=TRUE---------------------
## perhaps more topical:
suppressPackageStartupMessages(require(TxDb.Hsapiens.UCSC.hg19.knownGene))
suppressPackageStartupMessages(require(Homo.sapiens))
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

KDM6AEntrezID=org.Hs.egSYMBOL2EG[['KDM6A']]
txs.KDM6A <- transcriptsBy(txdb, 'gene')[[KDM6AEntrezID]]
tss.KDM6A <- unique(resize(txs.KDM6A, 1, fix='start')) ## two start sites
promoters.KDM6A <- flank(tss.KDM6A, 100) ## an arbitrary distance upstream
show( subsetByOverlaps(grSet450k, promoters.KDM6A) ) ## probes in this window


## ----results='asis'-----------------------------
toLatex(sessionInfo())

