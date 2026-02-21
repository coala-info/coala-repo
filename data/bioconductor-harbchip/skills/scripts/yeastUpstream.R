# Code example from 'yeastUpstream' vignette. See references/ for full tutorial.

### R code from vignette source 'yeastUpstream.Rnw'

###################################################
### code chunk number 1: introChunk
###################################################
library(harbChIP)
data(sceUpstr)
sceUpstr
getUpstream("YAL001C", sceUpstr)


###################################################
### code chunk number 2: buildUpstream500 (eval = FALSE)
###################################################
## fname = system.file("extdata/utr5_sc_500_20040206.fasta", package="sceUpstr")
## utr5 = readFASTA(fname)
## sceUpstr = buildUpstreamSeqs2(utr5)
## save(sceUpstr, file="sceUpstr.rda")


