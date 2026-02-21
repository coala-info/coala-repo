# Code example from 'girafe' vignette. See references/ for full tutorial.

### R code from vignette source 'girafe.Rnw'

###################################################
### code chunk number 1: prepare
###################################################
options(length=60, stringsAsFactors=FALSE)
set.seed(123)
options(SweaveHooks=list(
   along=function() par(mar=c(2.5,4.2,4,1.5), font.lab=2),
   pie=function() par(mar=c(0, 0, 0, 3.7), font=2)))


###################################################
### code chunk number 2: loadpackage
###################################################
library("girafe")
library("RColorBrewer")


###################################################
### code chunk number 3: setUp
###################################################
exDir <- system.file("extdata", package="girafe")
### load object describing annotated mouse genome features:
load(file.path(exDir, "mgi_gi.RData"))


###################################################
### code chunk number 4: loadReads
###################################################
ra23.wa  <- readFastq(dirPath=exDir, pattern=
                      "aravinSRNA_23_plus_adapter_excerpt.fastq")


###################################################
### code chunk number 5: showReads
###################################################
show(ra23.wa)


###################################################
### code chunk number 6: trimAdapter
###################################################
adapter <- "CTGTAGGCACCATCAAT"
ra23.na  <- trimAdapter(ra23.wa, adapter)
show(ra23.na)


###################################################
### code chunk number 7: readAligned
###################################################
exA   <- readAligned(dirPath=exDir, type="Bowtie", 
   pattern="aravinSRNA_23_no_adapter_excerpt_mm9_unmasked.bwtmap")
show(exA)


###################################################
### code chunk number 8: convertAligned
###################################################
exAI <- as(exA, "AlignedGenomeIntervals")
organism(exAI) <- "Mm"


###################################################
### code chunk number 9: showExAI
###################################################
show(exAI)


###################################################
### code chunk number 10: tabChromosomes
###################################################
table(seqnames(exAI))


###################################################
### code chunk number 11: showSubset
###################################################
detail(exAI[seqnames(exAI)=="chrMT"])


###################################################
### code chunk number 12: showSummary
###################################################
summary(exAI)


###################################################
### code chunk number 13: setupToy
###################################################
D <- AlignedGenomeIntervals(
     start=c(1,3,4,5,8,10,11), end=c(5,5,6,8,9,11,13),
     chromosome=rep(c("chr1","chr2","chr3"), c(2,2,3)),
     strand=c("-","-","+","+","+","+","+"),
     sequence=c("ACATT","ACA","CGT","GTAA","AG","CT","TTT"),
     reads=rep(1,7), matches=c(rep(1,6),3))

detail(D)


###################################################
### code chunk number 14: showReduceToy
###################################################
detail(reduce(D))


###################################################
### code chunk number 15: showReduceData
###################################################
S <- exAI[seqnames(exAI)=="chrX" & matches(exAI)==1L & exAI[,1]>1e8]
detail(S)


###################################################
### code chunk number 16: showReduceData2
###################################################
detail(reduce(S))


###################################################
### code chunk number 17: reduceExample3
###################################################
S2 <- exAI[seqnames(exAI)=="chr11" & matches(exAI)==1L & exAI[,1]>8e7]
detail(S2)
detail(reduce(S2, method="exact"))


###################################################
### code chunk number 18: plotAI
###################################################
plot(exAI, mgi.gi, chr="chrX", start=50400000, 
     end=50410000, show="minus")


###################################################
### code chunk number 19: examplePerWindow
###################################################
exPX  <- perWindow(exAI, chr="chrX", winsize=1e5, step=0.5e5)
head(exPX[order(exPX$n.overlap, decreasing=TRUE),])


###################################################
### code chunk number 20: exportBed (eval = FALSE)
###################################################
## export(exAI, con="export.bed",
##        format="bed", name="example_reads",
##        description="Example reads",
##        color="100,100,255", visibility="pack")


###################################################
### code chunk number 21: getIntervalOverlap
###################################################
exOv <- interval_overlap(exAI, mgi.gi)


###################################################
### code chunk number 22: tableOverlap
###################################################
table(listLen(exOv))


###################################################
### code chunk number 23: show12Elements
###################################################
mgi.gi$ID[exOv[[which.max(listLen(exOv))]]]


###################################################
### code chunk number 24: computeTabOv
###################################################
(tabOv <- table(as.character(mgi.gi$type)[unlist(exOv)]))


###################################################
### code chunk number 25: displayPie
###################################################
getOption("SweaveHooks")[["pie"]]()
my.cols <- brewer.pal(length(tabOv), "Set3")
pie(tabOv, col=my.cols, radius=0.88)


###################################################
### code chunk number 26: multicoreShow (eval = FALSE)
###################################################
## library("parallel")
## options("mc.cores"=4) # adjust to your machine
## exAI.R <- reduce(exAI, mem.friendly=TRUE)


###################################################
### code chunk number 27: sessionInfo
###################################################
toLatex(sessionInfo(), locale=FALSE)


