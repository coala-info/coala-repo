# Code example from 'vulcandata' vignette. See references/ for full tutorial.

### R code from vignette source 'vulcandata.Rnw'

###################################################
### code chunk number 1: vulcandata.Rnw:35-36
###################################################
set.seed(1)


###################################################
### code chunk number 2: vulcandata.Rnw:39-42 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("vulcandata")


###################################################
### code chunk number 3: vulcandata.Rnw:48-49
###################################################
library(vulcandata)


###################################################
### code chunk number 4: vulcandata.Rnw:55-60
###################################################
# Generate an annotation file from the dummy ChIP-Seq dataset
vfile<-"deleteme.csv"
vulcansheet(vfile)
read.csv(vfile)
unlink(vfile)


###################################################
### code chunk number 5: vulcandata.Rnw:65-75
###################################################
# Example regulon object
library(viper)
load(system.file('extdata','network.rda',package='vulcandata',mustWork=TRUE))
network

# Example regulon object
library(viper)
load(system.file('extdata','network.rda',package='vulcandata',mustWork=TRUE))
network



