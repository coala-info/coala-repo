# Code example from 'motifRG' vignette. See references/ for full tutorial.

### R code from vignette source 'motifRG.Rnw'

###################################################
### code chunk number 1: motifRG.Rnw:66-70
###################################################
library(motifRG)
MD.motifs <- findMotifFasta(system.file("extdata", "MD.peak.fa",package="motifRG"), 
                            system.file("extdata", "MD.control.fa", package="motifRG"), 
                            max.motif=3,enriched=T)


###################################################
### code chunk number 2: motifRG.Rnw:74-75
###################################################
motifLatexTable(main="MyoD motifs", MD.motifs, prefix="myoD")


###################################################
### code chunk number 3: motifRG.Rnw:80-86
###################################################
data(YY1.peak)
data(YY1.control)
library(BSgenome.Hsapiens.UCSC.hg19)
YY1.peak.seq <- getSequence(YY1.peak, genome=Hsapiens)
YY1.control.seq <- getSequence(YY1.control, genome=Hsapiens)
YY1.motif.1 <- findMotifFgBg(YY1.peak.seq, YY1.control.seq, enriched=T)


###################################################
### code chunk number 4: motifRG.Rnw:91-92
###################################################
motifLatexTable(main="YY1 motifs", YY1.motif.1, prefix="YY1-1")


###################################################
### code chunk number 5: motifRG.Rnw:96-98
###################################################
summary(letterFrequency(YY1.peak.seq, "CG", as.prob=T))
summary(letterFrequency(YY1.control.seq, "CG", as.prob=T))


###################################################
### code chunk number 6: motifRG.Rnw:103-104
###################################################
summary(width(YY1.peak.seq))


###################################################
### code chunk number 7: motifRG.Rnw:112-119
###################################################
YY1.narrow.seq <- subseq(YY1.peak.seq, 
                         pmax(round((width(YY1.peak.seq) - 200)/2), 1), 
                         width=pmin(200, width(YY1.peak.seq)))
YY1.control.narrow.seq <- subseq(YY1.control.seq, 
                                 pmax(round((width(YY1.control.seq) - 200)/2),1), 
                                 width=pmin(200, width(YY1.control.seq)))
category=c(rep(1, length(YY1.narrow.seq)), rep(0, length(YY1.control.narrow.seq)))


###################################################
### code chunk number 8: motifRG.Rnw:123-126
###################################################
all.seq <- append(YY1.narrow.seq, YY1.control.narrow.seq)
gc <- as.integer(cut(letterFrequency(all.seq, "CG", as.prob=T),
                     c(-1, 0.4, 0.45, 0.5, 0.55, 0.6, 2)))


###################################################
### code chunk number 9: motifRG.Rnw:130-131
###################################################
all.weights = c(YY1.peak$weight, rep(1, length(YY1.control.seq)))


###################################################
### code chunk number 10: motifRG.Rnw:135-137
###################################################
YY1.motif.2 <- findMotif(all.seq,category, other.data=gc, 
                         max.motif=5,enriched=T, weights=all.weights)


###################################################
### code chunk number 11: motifRG.Rnw:140-141
###################################################
motifLatexTable(main="Refined YY1 motifs", YY1.motif.2,prefix="YY1-2")


###################################################
### code chunk number 12: motifRG.Rnw:145-145
###################################################



###################################################
### code chunk number 13: motifRG.Rnw:157-161
###################################################
data(ctcf.motifs)
ctcf.seq <- readDNAStringSet(system.file("extdata", "ctcf.fa",package="motifRG"))
pwm.match <- refinePWMMotif(ctcf.motifs$motifs[[1]]@match$pattern, ctcf.seq)
library(seqLogo)


###################################################
### code chunk number 14: motifRG.Rnw:166-167
###################################################
seqLogo(pwm.match$model$prob)


###################################################
### code chunk number 15: motifRG.Rnw:174-176
###################################################
pwm.match.extend <- 
    refinePWMMotifExtend(ctcf.motifs$motifs[[1]]@match$pattern, ctcf.seq)


###################################################
### code chunk number 16: motifRG.Rnw:181-182
###################################################
seqLogo(pwm.match.extend$model$prob)


###################################################
### code chunk number 17: motifRG.Rnw:189-190
###################################################
plotMotif(pwm.match.extend$match$pattern)


