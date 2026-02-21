# Code example from 'qrqc' vignette. See references/ for full tutorial.

### R code from vignette source 'qrqc.Rnw'

###################################################
### code chunk number 1: qrqc.Rnw:50-52
###################################################
library(qrqc)
s.fastq <- readSeqFile(system.file('extdata', 'test.fastq', package='qrqc'))


###################################################
### code chunk number 2: qrqc.Rnw:54-55
###################################################
s.fastq@filename <- 'test.fastq' # otherwise a long temp dir will be here


###################################################
### code chunk number 3: qrqc.Rnw:69-70
###################################################
s.fastq


###################################################
### code chunk number 4: figQualPlot
###################################################
qualPlot(s.fastq)


###################################################
### code chunk number 5: figQualPlot-list
###################################################
s.trimmed.fastq <- readSeqFile(system.file('extdata', 'test-trimmed.fastq', package='qrqc'))
qualPlot(list("trimmed"=s.trimmed.fastq, "untrimmed"=s.fastq))


###################################################
### code chunk number 6: figBasePlot-freqs
###################################################
basePlot(s.fastq)


###################################################
### code chunk number 7: figBasePlot-prop
###################################################
basePlot(s.fastq, bases=c("G", "C"), geom="bar", type="proportion")


###################################################
### code chunk number 8: figSeqlenPlot
###################################################
seqlenPlot(s.trimmed.fastq)


###################################################
### code chunk number 9: figGcPlot
###################################################
gcPlot(s.fastq) + geom_hline(yintercept=0.5, color="purple")


###################################################
### code chunk number 10: figEntropy
###################################################
s.rand <- readSeqFile(system.file('extdata', 'random.fasta', package='qrqc'), type="fasta")
kmerEntropyPlot(list("contaminated"=s.fastq, "random"=s.rand))


###################################################
### code chunk number 11: figKmerKL
###################################################
kmerKLPlot(s.fastq)


###################################################
### code chunk number 12: figKmerKLRand
###################################################
contam.file <- system.file('extdata', 'test-contam.fastq', package='qrqc')
s.contam <- readSeqFile(contam.file, kmer=TRUE, k=5)

kmerKLPlot(list("contaminated"=s.fastq, "random"=s.rand,
  "highly contaminated"=s.contam))


###################################################
### code chunk number 13: figCoord
###################################################
basePlot(s.fastq, geom="bar") + coord_flip()


###################################################
### code chunk number 14: figZoom
###################################################
qualPlot(s.fastq) + scale_x_continuous(limits=c(60, 85)) + theme_bw()


###################################################
### code chunk number 15: figAltqual
###################################################
ggplot(getQual(s.fastq)) + geom_linerange(aes(x=position, ymin=lower,
      ymax=upper, color=mean)) + scale_color_gradient("mean quality",
      low="red", high="green") + scale_y_continuous("quality")


###################################################
### code chunk number 16: qrqc.Rnw:404-405
###################################################
sessionInfo()


