# Code example from 'genomationData-knitr' vignette. See references/ for full tutorial.

## ----eval=FALSE, tidy=TRUE----------------------------------------------------
# library(genomationData)

## ----listFiles, eval=FALSE, tidy=TRUE-----------------------------------------
# list.files(system.file('extdata',package='genomationData'))

## ----readSampInfo, eval=FALSE, tidy=FALSE-------------------------------------
# samp.file = system.file('extdata/SamplesInfo.txt',
#                         package='genomationData')
# samp.info = read.table(samp.file, header=TRUE, sep='\t')
# head(samp.info)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

