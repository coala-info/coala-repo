# Code example from 'GEOsubmission' vignette. See references/ for full tutorial.

### R code from vignette source 'GEOsubmission.Rnw'

###################################################
### code chunk number 1: loadGEOsubmission
###################################################
library(GEOsubmission)


###################################################
### code chunk number 2: sampleSerieslabels
###################################################
sampleID<-c('1','2')
seriesName<-'neuronalCultures'


###################################################
### code chunk number 3: exampleWcel (eval = FALSE)
###################################################
## microarray2soft(sampleID,'sampleInfo.txt',seriesName,'seriesInfo.txt',
## softname='mydata.soft')
## 


###################################################
### code chunk number 4: dataDirectory
###################################################
dataDirectory<-system.file('extdata',package='GEOsubmission')


###################################################
### code chunk number 5: showInfoFiles (eval = FALSE)
###################################################
## read.delim(file.path(dataDirectory,'sampleInfo.txt'))
## read.delim(file.path(dataDirectory,'seriesInfo.txt'))


###################################################
### code chunk number 6: softFilename
###################################################
soft_example_fullpath<-tempfile(pattern='soft_example')
soft_example_name<-basename(soft_example_fullpath)
soft_example_dir<-dirname(soft_example_fullpath)


###################################################
### code chunk number 7: exampleWexpressionmatrix
###################################################
microarray2soft(sampleID,'sampleInfo.txt',seriesName,'seriesInfo.txt',
datadir=dataDirectory,writedir=soft_example_dir,
softname=soft_example_name,expressionmatrix='expressionNormalized.txt')



###################################################
### code chunk number 8: softContent
###################################################
readLines(soft_example_fullpath)


###################################################
### code chunk number 9: deleteSoft
###################################################
## Clean-up
unlink(soft_example_fullpath)


###################################################
### code chunk number 10: showExpressionmatrix (eval = FALSE)
###################################################
## read.delim(file.path(dataDirectory,'expressionNormalized.txt'))


###################################################
### code chunk number 11: exampleWstdOutput (eval = FALSE)
###################################################
## microarray2soft(c('1','2'),'sampleInfo.txt',seriesName,'seriesInfo.txt',
## datadir=dataDirectory,softname='',expressionmatrix='expressionNormalized.txt',
## verbose=FALSE)
## 


###################################################
### code chunk number 12: sessionInfo
###################################################
sessionInfo()


