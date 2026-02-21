# Code example from 'MethTargetedNGS' vignette. See references/ for full tutorial.

### R code from vignette source 'MethTargetedNGS.Rnw'

###################################################
### code chunk number 1: Loading files in R
###################################################
library(MethTargetedNGS)
healthy = system.file("extdata", "Healthy.fasta", package = "MethTargetedNGS")
tumor = system.file("extdata", "Tumor.fasta", package = "MethTargetedNGS")
reference = system.file("extdata", "Reference.fasta", package = "MethTargetedNGS")


###################################################
### code chunk number 2: Aligning samples to reference sequence
###################################################
hAlign = methAlign(healthy,reference)
tAlign = methAlign(tumor,reference)


###################################################
### code chunk number 3: :Heatmap
###################################################
hHeatmap = methHeatmap(hAlign,plot=TRUE)


###################################################
### code chunk number 4: MethTargetedNGS.Rnw:54-55
###################################################
hHeatmap = methHeatmap(hAlign,plot=TRUE)


###################################################
### code chunk number 5: Calculating Methylation Average
###################################################
hAvg = methAvg(hAlign,plot=FALSE)
hAvg


###################################################
### code chunk number 6: Calculating methylation entropy
###################################################
hEnt <- methEntropy(hAlign)
hEnt


###################################################
### code chunk number 7: Calculate statistically significant CpG sites in samples
###################################################
SigCpGsites = fishertest_cpg(hAlign,tAlign,plot=FALSE)
SigCpGsites


###################################################
### code chunk number 8: Odd Ratio
###################################################
odSamps = odd_ratio(hAlign,tAlign,plot=FALSE)
odSamps


###################################################
### code chunk number 9: MethTargetedNGS.Rnw:101-102
###################################################
compare_samples(hAlign,tAlign)


###################################################
### code chunk number 10: Complete Methylation Analysis Comparison
###################################################
compare_samples(hAlign,tAlign)


###################################################
### code chunk number 11: Creating Profile Hidden Markov Model from Multiple Sequence Alignment
###################################################
msa = system.file("extdata", "msa.fasta", package = "MethTargetedNGS")
if (file.exists("/usr/bin/hmmbuild"))
hmmbuild(file_seq=msa,file_out="hmm",pathHMMER = "/usr/bin/")


###################################################
### code chunk number 12: Calculate likelihood of sequences against HMM
###################################################
if (file.exists("/usr/bin/nhmmer")){
res <- nhmmer("hmm",tumor,pathHMMER = "/usr/bin/")
res$Total.Likelihood.Score
}


