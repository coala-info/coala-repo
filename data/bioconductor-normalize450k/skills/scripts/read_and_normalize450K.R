# Code example from 'read_and_normalize450K' vignette. See references/ for full tutorial.

### R code from vignette source 'read_and_normalize450K.Rnw'

###################################################
### code chunk number 1: read_and_normalize450K.Rnw:17-31 (eval = FALSE)
###################################################
##  library(normalize450K)
##  library(minfiData) ## this package includes some .idat files
##  library(data.table)
## 
##  path <- system.file("extdata",package="minfiData")
##  samples = fread(file.path(path, 'SampleSheet.csv'),integer64='character')
## 
##  samples[,file:=file.path(path,Sentrix_ID,paste0(Sentrix_ID,'_',Sentrix_Position))]
##  ## samples$file is a character vector containing the location of the
##  ## .idat files, but without the suffixes "_Red.idat" or "_Grn.idat"
## 
##  raw = read450K(samples$file)
##  none = dont_normalize450K(raw) ## no normalization
##  norm = normalize450K(raw)


