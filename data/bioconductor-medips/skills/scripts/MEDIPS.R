# Code example from 'MEDIPS' vignette. See references/ for full tutorial.

### R code from vignette source 'MEDIPS.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: MEDIPS.Rnw:65-68 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("MEDIPS")


###################################################
### code chunk number 3: MEDIPS.Rnw:74-75 (eval = FALSE)
###################################################
## library("BSgenome")


###################################################
### code chunk number 4: MEDIPS.Rnw:78-79 (eval = FALSE)
###################################################
## available.genomes()


###################################################
### code chunk number 5: MEDIPS.Rnw:85-88 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")


###################################################
### code chunk number 6: MEDIPS.Rnw:94-97 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("MEDIPSData")


###################################################
### code chunk number 7: MEDIPS.Rnw:107-108
###################################################
library(MEDIPS)


###################################################
### code chunk number 8: MEDIPS.Rnw:114-115
###################################################
library(BSgenome.Hsapiens.UCSC.hg19)


###################################################
### code chunk number 9: MEDIPS.Rnw:125-126
###################################################
library("MEDIPSData")


###################################################
### code chunk number 10: MEDIPS.Rnw:148-151
###################################################
bam.file.hESCs.Rep1.MeDIP = system.file("extdata", "hESCs.MeDIP.Rep1.chr22.bam", package="MEDIPSData")
bam.file.hESCs.Input = system.file("extdata", "hESCs.Input.chr22.bam", package="MEDIPSData")
bam.file.DE.Input = system.file("extdata", "DE.Input.chr22.bam", package="MEDIPSData")


###################################################
### code chunk number 11: MEDIPS.Rnw:161-162
###################################################
BSgenome="BSgenome.Hsapiens.UCSC.hg19"


###################################################
### code chunk number 12: MEDIPS.Rnw:165-166
###################################################
uniq=1e-3


###################################################
### code chunk number 13: MEDIPS.Rnw:173-174
###################################################
extend=300


###################################################
### code chunk number 14: MEDIPS.Rnw:179-180
###################################################
shift=0


###################################################
### code chunk number 15: MEDIPS.Rnw:183-184
###################################################
ws=100


###################################################
### code chunk number 16: MEDIPS.Rnw:192-193
###################################################
chr.select="chr22"


###################################################
### code chunk number 17: MEDIPS.Rnw:209-210 (eval = FALSE)
###################################################
## hESCs_MeDIP = MEDIPS.createSet(file=bam.file.hESCs.Rep1.MeDIP, BSgenome=BSgenome, extend=extend, shift=shift, uniq=uniq, window_size=ws, chr.select=chr.select)


###################################################
### code chunk number 18: MEDIPS.Rnw:216-218 (eval = FALSE)
###################################################
## bam.file.hESCs.Rep2.MeDIP = system.file("extdata", "hESCs.MeDIP.Rep2.chr22.bam", package="MEDIPSData")
## hESCs_MeDIP = c(hESCs_MeDIP, MEDIPS.createSet(file=bam.file.hESCs.Rep2.MeDIP, BSgenome=BSgenome, extend=extend, shift=shift, uniq=uniq, window_size=ws, chr.select=chr.select))


###################################################
### code chunk number 19: MEDIPS.Rnw:224-226
###################################################
data(hESCs_MeDIP)
data(DE_MeDIP)


###################################################
### code chunk number 20: MEDIPS.Rnw:231-233
###################################################
hESCs_Input = MEDIPS.createSet(file=bam.file.hESCs.Input, BSgenome=BSgenome, extend=extend, shift=shift, uniq=uniq, window_size=ws, chr.select=chr.select)
DE_Input = MEDIPS.createSet(file=bam.file.DE.Input, BSgenome=BSgenome, extend=extend, shift=shift, uniq=uniq, window_size=ws, chr.select=chr.select)


###################################################
### code chunk number 21: MEDIPS.Rnw:246-247
###################################################
CS = MEDIPS.couplingVector(pattern="CG", refObj=hESCs_MeDIP[[1]])


###################################################
### code chunk number 22: MEDIPS.Rnw:256-257
###################################################
mr.edgeR = MEDIPS.meth(MSet1=DE_MeDIP, MSet2=hESCs_MeDIP, CSet=CS, ISet1=DE_Input, ISet2=hESCs_Input, p.adj="bonferroni", diff.method="edgeR", MeDIP=T, CNV=F, minRowSum=10)


###################################################
### code chunk number 23: MEDIPS.Rnw:318-319
###################################################
mr.edgeR.s = MEDIPS.selectSig(results=mr.edgeR, p.value=0.1, adj=T, ratio=NULL, bg.counts=NULL, CNV=F)


###################################################
### code chunk number 24: MEDIPS.Rnw:355-356
###################################################
mr.edgeR.s.gain = mr.edgeR.s[which(mr.edgeR.s[,grep("logFC", colnames(mr.edgeR.s))]>0),]


###################################################
### code chunk number 25: MEDIPS.Rnw:361-362
###################################################
mr.edgeR.s.gain.m = MEDIPS.mergeFrames(frames=mr.edgeR.s.gain, distance=1)


###################################################
### code chunk number 26: MEDIPS.Rnw:376-378 (eval = FALSE)
###################################################
## columns=names(mr.edgeR)[grep("counts",names(mr.edgeR))]
## rois=MEDIPS.selectROIs(results=mr.edgeR, rois=mr.edgeR.s.gain.m, columns=columns, summarize=NULL)


###################################################
### code chunk number 27: MEDIPS.Rnw:389-390 (eval = FALSE)
###################################################
## rois.s=MEDIPS.selectROIs(results=mr.edgeR, rois=mr.edgeR.s.gain.m, columns=columns, summarize="avg")


###################################################
### code chunk number 28: MEDIPS.Rnw:407-408
###################################################
sr=MEDIPS.saturation(file=bam.file.hESCs.Rep1.MeDIP, BSgenome=BSgenome, uniq=uniq, extend=extend, shift=shift, window_size=ws, chr.select=chr.select, nit=10, nrit=1, empty_bins=TRUE, rank=FALSE)


###################################################
### code chunk number 29: MEDIPS.Rnw:426-427
###################################################
sr


###################################################
### code chunk number 30: saturationplot
###################################################
MEDIPS.plotSaturation(sr)


###################################################
### code chunk number 31: MEDIPS.Rnw:465-466 (eval = FALSE)
###################################################
## cor.matrix=MEDIPS.correlation(MSets=c(hESCs_MeDIP, DE_MeDIP, hESCs_Input, DE_Input), plot=T, method="pearson")


###################################################
### code chunk number 32: MEDIPS.Rnw:475-476
###################################################
cr=MEDIPS.seqCoverage(file=bam.file.hESCs.Rep1.MeDIP, pattern="CG", BSgenome=BSgenome, chr.select=chr.select, extend=extend, shift=shift, uniq=uniq)


###################################################
### code chunk number 33: coverageplot
###################################################
MEDIPS.plotSeqCoverage(seqCoverageObj=cr, type="pie", cov.level = c(0,1, 2, 3, 4, 5))


###################################################
### code chunk number 34: coverageplothist
###################################################
MEDIPS.plotSeqCoverage(seqCoverageObj=cr, type="hist", t = 15, main="Sequence pattern coverage, histogram")


###################################################
### code chunk number 35: MEDIPS.Rnw:518-519 (eval = FALSE)
###################################################
## er=MEDIPS.CpGenrich(file=bam.file.hESCs.Rep1.MeDIP, BSgenome=BSgenome, chr.select=chr.select, extend=extend, shift=shift, uniq=uniq)


###################################################
### code chunk number 36: MEDIPS.Rnw:544-545 (eval = FALSE)
###################################################
## MEDIPS.exportWIG(Set=hESCs_MeDIP[[1]], file="hESC.MeDIP.rep1.wig", format="rpkm", descr="")


###################################################
### code chunk number 37: MEDIPS.Rnw:567-568 (eval = FALSE)
###################################################
## Input.merged=MEDIPS.mergeSets(MSet1=hESCs_Input, MSet2=DE_Input, name="Input.hESCs.DE")


###################################################
### code chunk number 38: MEDIPS.Rnw:583-584 (eval = FALSE)
###################################################
## anno.mart.gene = MEDIPS.getAnnotation(dataset=c("hsapiens_gene_ensembl"), annotation=c("GENE"), chr="chr22")


###################################################
### code chunk number 39: MEDIPS.Rnw:590-591 (eval = FALSE)
###################################################
## mr.edgeR.s = MEDIPS.setAnnotation(regions=mr.edgeR.s, annotation=anno.mart.gene)


###################################################
### code chunk number 40: MEDIPS.Rnw:604-605 (eval = FALSE)
###################################################
## mr.edgeR=MEDIPS.addCNV(cnv.Frame=10000, ISet1=hESCs_Input, ISet2=DE_Input, results=mr.edgeR)


###################################################
### code chunk number 41: MEDIPS.Rnw:613-614 (eval = FALSE)
###################################################
## MEDIPS.plotCalibrationPlot(CSet=CS, main="Calibration Plot", MSet=hESCs_MeDIP[[1]], plot_chr="chr22",  rpkm=TRUE,  xrange=TRUE)


