# Code example from 'nuCpos-intro' vignette. See references/ for full tutorial.

### R code from vignette source 'nuCpos-intro.Rnw'

###################################################
### code chunk number 1: nuCpos-intro.Rnw:86-87
###################################################
library(nuCpos)


###################################################
### code chunk number 2: nuCpos-intro.Rnw:99-107
###################################################
load(system.file("extdata", "inseq.RData", package = "nuCpos"))
HBA(inseq = inseq, species = "sc")
for(i in 1:3) cat(substr(inseq, start = (i-1)*60+1, 
    stop = (i-1)*60+60), "\n")
load(system.file("extdata", "INSEQ_DNAString.RData", 
    package = "nuCpos"))
INSEQ
HBA(inseq = INSEQ, species = "sc")


###################################################
### code chunk number 3: nuCpos-intro.Rnw:135-139
###################################################
localHBA(inseq = inseq, species = "sc")
barplot(localHBA(inseq = inseq, species = "sc"), 
    names.arg = LETTERS[1:13], xlab = "Nucleosomal subsegments", 
    ylab = "local HBA", main = "Local HBA scores for inseq")


