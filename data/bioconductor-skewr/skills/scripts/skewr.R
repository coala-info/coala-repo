# Code example from 'skewr' vignette. See references/ for full tutorial.

## ----knitr, include=FALSE, echo=FALSE-----------------------------------------
library(knitr)
opts_chunk$set(tidy=FALSE,size='scriptsize', cache=FALSE, cache.comments=FALSE)

## ----options,eval=TRUE,echo=FALSE,results='hide'--------------------
options(width=70)

## ----install, eval=FALSE--------------------------------------------
# packages.install('mixsmsn')
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install(c('skewr', 'methylumi', 'minfi', 'wateRmelon',
#            'IlluminaHumanMethylation450kmanifest', 'IRanges'))

## ----minfiData, eval=FALSE------------------------------------------
# BiocManager::install('minfiData')

## ----load, message=FALSE, warning=FALSE-----------------------------
library(skewr)
library(minfiData)

## ----getIDATs, eval=TRUE, warning=FALSE, message=FALSE--------------
baseDir <- system.file("extdata/5723646052", package = "minfiData")
barcodes <- getBarcodes(path = baseDir)
barcodes

## ----getMethyLumi, eval=FALSE, warning=FALSE, message=FALSE---------
# methylumiset.raw <- getMethyLumiSet(path = baseDir, barcodes =  barcodes[1:2])
# methylumiset.illumina <- preprocess(methylumiset.raw, norm = 'illumina',
#                                     bg.corr = FALSE)

## ----getMelon, eval=TRUE--------------------------------------------
data(melon)
melon.raw <- melon[,11]

## ----getMethyLumiNormEx, eval=FALSE---------------------------------
# melon.illumina <- preprocess(melon.raw, norm = 'illumina', bg.corr = TRUE)
# melon.SWAN <- preprocess(melon.raw, norm = 'SWAN')
# melon.dasen <- preprocess(melon.raw, norm = 'dasen')

## ----mixes, eval=TRUE-----------------------------------------------
sn.raw.meth.I.red <- getSNparams(melon.raw, 'M', 'I-red')
sn.raw.unmeth.I.red <- getSNparams(melon.raw, 'U', 'I-red')
sn.raw.meth.I.green <- getSNparams(melon.raw, 'M', 'I-green')
sn.raw.unmeth.I.green <- getSNparams(melon.raw, 'U', 'I-green')
sn.raw.meth.II <- getSNparams(melon.raw, 'M', 'II')
sn.raw.unmeth.II <- getSNparams(melon.raw, 'U', 'II')

## ----mixesdasen, eval=FALSE-----------------------------------------
# sn.dasen.meth.I.red <- getSNparams(melon.dasen, 'M', 'I-red')
# sn.dasen.unmeth.I.red <- getSNparams(melon.dasen, 'U', 'I-red')
# sn.dasen.meth.I.green <- getSNparams(melon.dasen, 'M', 'I-green')
# sn.dasen.unmeth.I.green <- getSNparams(melon.dasen, 'U', 'I-green')
# sn.dasen.meth.II <- getSNparams(melon.dasen, 'M', 'II')
# sn.dasen.unmeth.II <- getSNparams(melon.dasen, 'U', 'II')

## ----list, eval=TRUE------------------------------------------------
raw.I.red.mixes <- list(sn.raw.meth.I.red, sn.raw.unmeth.I.red)
raw.I.green.mixes <- list(sn.raw.meth.I.green, sn.raw.unmeth.I.green)
raw.II.mixes <- list(sn.raw.meth.II, sn.raw.unmeth.II)

## ----panelPlot1, eval=TRUE, echo=TRUE, dev='png', dpi=300, fig.cap='Panel Plot for One Sample'----
panelPlots(melon.raw, raw.I.red.mixes, raw.I.green.mixes,
           raw.II.mixes, norm = 'Raw')

## ----panelPlot2, eval=FALSE, echo=TRUE, dev='png', dpi=600----------
# panelPlots(melon.dasen,
#            list(sn.dasen.meth.I.red, sn.dasen.unmeth.I.red),
#            list(sn.dasen.meth.I.green, sn.dasen.unmeth.I.green),
#            list(sn.dasen.meth.II, sn.dasen.unmeth.II), norm = 'dasen')

## ----listAccess, eval=TRUE------------------------------------------
class(sn.raw.meth.I.red[[1]])
names(sn.raw.meth.I.red[[1]])
sn.raw.meth.I.red[[1]]$means
sn.raw.meth.I.red[[1]]$modes

## ----singlePlots, eval=TRUE, echo=TRUE, dev='png', dpi=300, fig.cap=c('Single Frame Showing Skew-normal Components', 'Single Frame Showing Beta Distribution for Type I Red')----
panelPlots(melon.raw, raw.I.red.mixes, raw.I.green.mixes,
           raw.II.mixes, plot='frames', frame.nums=c(1,3), norm='Raw')

## ----sessionInfo, results='asis', echo=FALSE------------------------
toLatex(sessionInfo())

