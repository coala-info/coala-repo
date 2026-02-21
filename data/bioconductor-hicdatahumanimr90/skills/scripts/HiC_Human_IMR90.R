# Code example from 'HiC_Human_IMR90' vignette. See references/ for full tutorial.

### R code from vignette source 'HiC_Human_IMR90.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex(use.unsrturl=FALSE)


###################################################
### code chunk number 2: describe
###################################################
require(HiCDataHumanIMR90)
require(HiTC)
data(Dixon2012_IMR90)
## Show data
show(hic_imr90_40)
## Is my data complete (i.e. composed of intra + inter chromosomal maps)
isComplete(hic_imr90_40)
## Note that a complete object is not necessarily pairwise 
## (is both chr1-chr2 and chr2-chr1 stored ?)
isPairwise(hic_imr90_40)
## Which chromosomes ?
seqlevels(hic_imr90_40)
## Details about a given map
detail(hic_imr90_40$chrXchrX)
## Descriptive statistics
head(summary(hic_imr90_40))


###################################################
### code chunk number 3: tads
###################################################
show(tads_imr90)


###################################################
### code chunk number 4: tads_plot
###################################################
## Extract region
regx <- extractRegion(hic_imr90_40$chrXchrX, 
                      chr="chrX", from=95000000, to=105000000)
## Plot Hi-C data with TADs
plot(regx, tracks=list(tads_imr90), maxrange=20)


###################################################
### code chunk number 5: sessionInfo
###################################################
toLatex(sessionInfo(), locale=FALSE)


