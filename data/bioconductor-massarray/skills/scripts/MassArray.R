# Code example from 'MassArray' vignette. See references/ for full tutorial.

### R code from vignette source 'MassArray.Rnw'

###################################################
### code chunk number 1: MassArray.Rnw:46-47
###################################################
library(MassArray)


###################################################
### code chunk number 2: MassArray.Rnw:49-51
###################################################
data.path <- system.file("extdata", package="MassArray")
initial.path <- getwd()


###################################################
### code chunk number 3: fig1
###################################################
results <- ampliconPrediction("AAAATTTTCCCCTCTGCGTGAGAGAGTTGTCCGACAAAA")
results


###################################################
### code chunk number 4: fig2
###################################################
ampliconPrediction("AAAA>TTTTCCCCTCTGCGTGAGAGAGTTGTC(CG)AC<AAAA")


###################################################
### code chunk number 5: fig3
###################################################
ampliconPrediction("AAAATTTTCCCCTCTGCGTGAGAGAGTTGTC(CG)ACTTCCCCTCTGCGTGAGAGAGTTGTCCGACAAAA")


###################################################
### code chunk number 6: fig4
###################################################
ampliconPrediction("CCTGTCCAGGGGCACTCCATATTTTCCTACCTGTCCCTCTTTGCTTGTAAAAACAAATTAAACAGGGATCCCAGCAACTTCG")


###################################################
### code chunk number 7: MassArray.Rnw:186-187
###################################################
setwd(data.path)


###################################################
### code chunk number 8: MassArray.Rnw:189-199
###################################################
sequence <- "CCAGGTCCAAAGGTTCAGACCAGTCTGAA>CCTGTCCAGGGGCACTCCATATTTTCC"
sequence <- paste(sequence, "TACCTGTCCCTCTTTGCTTGTAAAAACAAATTAAACAGGGA", sep="")
sequence <- paste(sequence, "TCCCAGCAACTTCGGGGCATGTGTGTAACTGTGCAAGGAGC", sep="")
sequence <- paste(sequence, "GCGAAGCCCAGAGCATCGCCCTAGAGTTCGGGCCGCAGCTG", sep="")
sequence <- paste(sequence, "CAGAGGCACATCTGGAAAAGGGGGAGGGGTCGAAGCGGAGG", sep="")
sequence <- paste(sequence, "GGACAAGAAGCCCCCAAACGACTAGCTTCTGGGTGCAGAGT", sep="")
sequence <- paste(sequence, "CTGTGTCAC(CG)GGGGTTAGTTACCTGTCCTACGTTGATG", sep="")
sequence <- paste(sequence, "AATCCGTACTTGCTGGCTATGCGGTCTGCCTCCGCGAATCC", sep="")
sequence <- paste(sequence, "GC(CG)GC<GATCTTCACTGCCCAGTGGTTGGTGTA", sep="")
data <- new("MassArrayData", sequence, file="Example.txt")


###################################################
### code chunk number 9: MassArray.Rnw:201-202
###################################################
setwd(initial.path)


###################################################
### code chunk number 10: fig5
###################################################
plot(data, collapse=FALSE, bars=FALSE, scale=FALSE)


###################################################
### code chunk number 11: fig6
###################################################
plot(data, collapse=TRUE, bars=TRUE, scale=FALSE)


###################################################
### code chunk number 12: fig7
###################################################
plot(data, collapse=TRUE, bars=FALSE, scale=TRUE)


###################################################
### code chunk number 13: fig8
###################################################
SNP.results <- evaluateSNPs(data)


###################################################
### code chunk number 14: MassArray.Rnw:292-294
###################################################
length(SNP.results)
SNP.results[[2]]


