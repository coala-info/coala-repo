# Code example from 'LVSmiRNA' vignette. See references/ for full tutorial.

### R code from vignette source 'LVSmiRNA.Rnw'

###################################################
### code chunk number 1: load.lib
###################################################

library(LVSmiRNA)



###################################################
### code chunk number 2: import
###################################################

dir.files <- system.file("extdata", package="LVSmiRNA")
taqman.data <- read.table(file.path(dir.files,"Comparison_Array.txt"),header=TRUE,as.is=TRUE)



###################################################
### code chunk number 3: read.mir (eval = FALSE)
###################################################
## 
## here.files <- "some/path/to/files"
## ## NOT RUN
## MIR <- read.mir(taqman.data,path=here.files)
## 


###################################################
### code chunk number 4: load
###################################################

data("MIR-spike-in")



###################################################
### code chunk number 5: estVC
###################################################

MIR.RA <- estVC(MIR)



###################################################
### code chunk number 6: MIR.RA
###################################################

data("MIR_RA")



###################################################
### code chunk number 7: plot
###################################################

plot(MIR.RA)



###################################################
### code chunk number 8: lvs
###################################################

MIR.lvs <- lvs(MIR,RA=MIR.RA)



###################################################
### code chunk number 9: boxplot
###################################################

boxplot(MIR.lvs)



###################################################
### code chunk number 10: summarize
###################################################

ex.1 <- summarize(MIR,RA=MIR.RA,method="rlm")
ex.2 <- summarize(MIR,method="medianpolish")



###################################################
### code chunk number 11: multicore (eval = FALSE)
###################################################
## 
## require(multicore)
## options(cores=8)
## 
## MIR.RA <- estVC(MIR)
## 


###################################################
### code chunk number 12: snow (eval = FALSE)
###################################################
## 
## require(snow)
## cl <- makeCluster(8,"SOCK")
## 
## MIR.RA <- estVC(MIR,clName=cl)
## 
## stopCluster(cl)
## 


###################################################
### code chunk number 13: mpi (eval = FALSE)
###################################################
## 
## cl <- makeCluster(8,"MPI")
## 
## MIR.RA <- estVC(MIR,clName=cl)
## 
## stopCluster(cl)
## 


