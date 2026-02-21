# Code example from 'muscle-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'muscle-vignette.Rnw'

###################################################
### code chunk number 1: muscle-vignette.Rnw:64-65
###################################################
library(muscle)


###################################################
### code chunk number 2: muscle-vignette.Rnw:70-71
###################################################
umax


###################################################
### code chunk number 3: muscle-vignette.Rnw:76-77
###################################################
aln <- muscle(umax)


###################################################
### code chunk number 4: muscle-vignette.Rnw:82-83
###################################################
aln


###################################################
### code chunk number 5: muscle-vignette.Rnw:88-90
###################################################
file.path <- system.file("extdata", "someORF.fa", package = "Biostrings")
orf <- readDNAStringSet(file.path, format = "fasta")


###################################################
### code chunk number 6: muscle-vignette.Rnw:95-96
###################################################
orf


###################################################
### code chunk number 7: muscle-vignette.Rnw:109-110
###################################################
aln <- muscle(umax, diags = TRUE)


###################################################
### code chunk number 8: muscle-vignette.Rnw:115-116
###################################################
aln <- muscle(umax, gapopen = -30)


###################################################
### code chunk number 9: muscle-vignette.Rnw:121-122
###################################################
aln <- muscle(umax, quiet = TRUE)


###################################################
### code chunk number 10: muscle-vignette.Rnw:127-128
###################################################
aln <- muscle(umax, maxhours = 24.0)


###################################################
### code chunk number 11: muscle-vignette.Rnw:139-140
###################################################
sessionInfo()


