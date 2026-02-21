# Code example from 'eudysbiome' vignette. See references/ for full tutorial.

### R code from vignette source 'eudysbiome.Rnw'

###################################################
### code chunk number 1: eudysbiome.Rnw:88-93 (eval = FALSE)
###################################################
## library("eudysbiome")
## input.fasta = "Unclassified.fasta"
## # using the extracted fasta and taxonomy as template
## assignTax(fasta = input.fasta,ksize = 8, iters = 100,
##                        cutoff = 80, processors=1, dir.out = "assignTax_out")


###################################################
### code chunk number 2: eudysbiome.Rnw:103-105
###################################################
genera = c("Lactobacillus","Bacteroides")
#species = tableSpecies(tax.file = "*.taxonomy", microbe = genera)


###################################################
### code chunk number 3: eudysbiome.Rnw:113-119
###################################################
library("eudysbiome")
data(diffGenera)
head(diffGenera)

data(harmGenera)
annotation = microAnnotate(diffGenera, annotated.micro = harmGenera)


###################################################
### code chunk number 4: Cartesian
###################################################
data(microDiff)
microDiff
attach(microDiff)

par(mar = c(5,4.1,5.1,5))
Cartesian(data ,micro.anno = micro.anno,comp.anno= comp.anno,
                unknown=TRUE,point.col = c("blue","purple","orange"))


###################################################
### code chunk number 5: microCount
###################################################
microCount = contingencyCount(data ,micro.anno = micro.anno,
                              comp.anno= comp.anno)


###################################################
### code chunk number 6: test
###################################################
microTest = contingencyTest(microCount,alternative ="greater")
microTest["Chisq.p"]
microTest["Fisher.p"]


###################################################
### code chunk number 7: sessionInfo
###################################################
toLatex(sessionInfo())


