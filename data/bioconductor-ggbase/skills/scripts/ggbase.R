# Code example from 'ggbase' vignette. See references/ for full tutorial.

### R code from vignette source 'ggbase.Rnw'

###################################################
### code chunk number 1: lkc
###################################################
library(GGBase)
getClass("smlSet")
showMethods(class="smlSet", where="package:GGBase")


###################################################
### code chunk number 2: lkd
###################################################
if ("GGtools" %in% installed.packages()[,1]) {
 library(GGtools)
 s20 = getSS("GGtools", "20")
 s20
}


###################################################
### code chunk number 3: lkf
###################################################
if (exists("s20")) {
 plot_EvG(genesym("CPNE1"), rsid("rs6060535"), s20)
} else plot(1) # pdf must exist....


###################################################
### code chunk number 4: lkgt
###################################################
if (exists("s20")) {
# raw bytes
 as(smList(s20)[[1]], "matrix")[1:5,1:5]
# generic calls
 as(smList(s20)[[1]], "character")[1:5,1:5]
# risk allele (alphabetically later nucleotide) counts
 as(smList(s20)[[1]], "numeric")[1:5,1:5]
}


