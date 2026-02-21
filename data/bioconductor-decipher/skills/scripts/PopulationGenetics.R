# Code example from 'PopulationGenetics' vignette. See references/ for full tutorial.

### R code from vignette source 'PopulationGenetics.Rnw'

###################################################
### code chunk number 1: PopulationGenetics.Rnw:51-53
###################################################
options(continue=" ")
options(width=80)


###################################################
### code chunk number 2: startup
###################################################
library(DECIPHER)


###################################################
### code chunk number 3: expr1
###################################################
# specify the path to your file of sequences:
fas1 <- "<<path to FASTA file>>"
# OR use the example protein coding sequences:
fas <- system.file("extdata",
	"50S_ribosomal_protein_L2.fas",
	package="DECIPHER")
# read the sequences into memory
dna <- readDNAStringSet(fas)
dna


###################################################
### code chunk number 4: expr2
###################################################
dna <- dna[startsWith(names(dna), "Helicobacter pylori")]
dna


###################################################
### code chunk number 5: expr3
###################################################
dna <- AlignTranslation(dna, verbose=FALSE)
dna # all sequences have the same width


###################################################
### code chunk number 6: expr4
###################################################
getOption("SweaveHooks")[["fig"]]()
x <- InferDemography(dna, readingFrame=1, mu=1e-9, ploidy=1, show=TRUE)
head(x, 20)


###################################################
### code chunk number 7: expr5
###################################################
getOption("SweaveHooks")[["fig"]]()
y <- InferRecombination(dna, readingFrame=1, showPlot=TRUE)
head(y, 10)


###################################################
### code chunk number 8: expr6
###################################################
getOption("SweaveHooks")[["fig"]]()
z <- InferSelection(dna, windowSize=3, showPlot=TRUE)
head(z, 5)

# fraction of windows under significant positive selection (> 2)
mean(z[startsWith(names(z), "omega")] > 2 &
	z[startsWith(names(z), "pvalue")] < 0.05)
# fraction of windows under significant negative selection (< 1/2)
mean(z[startsWith(names(z), "omega")] < 1/2 &
	z[startsWith(names(z), "pvalue")] < 0.05)


###################################################
### code chunk number 9: sessinfo
###################################################
toLatex(sessionInfo(), locale=FALSE)


