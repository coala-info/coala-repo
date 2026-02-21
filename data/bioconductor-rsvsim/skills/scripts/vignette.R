# Code example from 'vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette.Rnw'

###################################################
### code chunk number 1: vignette.Rnw:35-37
###################################################
options(width=90)
options(continue=" ")


###################################################
### code chunk number 2: preliminaries
###################################################
library(RSVSim)


###################################################
### code chunk number 3: toyExample
###################################################
genome = DNAStringSet(
c("AAAAAAAAAAAAAAAAAAAATTTTTTTTTTTTTTTTTTTT", 
"GGGGGGGGGGGGGGGGGGGGCCCCCCCCCCCCCCCCCCCC"))
names(genome) = c("chr1","chr2")
genome


###################################################
### code chunk number 4: genomeEcoli (eval = FALSE)
###################################################
## library(BSgenome.Ecoli.NCBI.20080805)
## genome = DNAStringSet(Ecoli[["NC_008253"]])
## names(genome) = "NC_008253"


###################################################
### code chunk number 5: deletionExample
###################################################
sim = simulateSV(output=NA, genome=genome, dels=3, sizeDels=10,
bpSeqSize=6, seed=456, verbose=FALSE)
sim
metadata(sim)


###################################################
### code chunk number 6: insertionExample
###################################################
sim = simulateSV(output=NA, genome=genome, ins=3, sizeIns=5, bpSeqSize=6,
seed=246, verbose=FALSE)
sim
metadata(sim)


###################################################
### code chunk number 7: insertionExample
###################################################
sim = simulateSV(output=NA, genome=genome, ins=3, sizeIns=5, percCopiedIns=0.66, 
bpSeqSize=6, seed=246, verbose=FALSE)
sim
metadata(sim)


###################################################
### code chunk number 8: inversionExample
###################################################
sim = simulateSV(output=NA, genome=genome, invs=3, sizeInvs=c(2,4,6),
bpSeqSize=6, seed=456, verbose=FALSE)
sim
metadata(sim)


###################################################
### code chunk number 9: tandemDupExample
###################################################
sim = simulateSV(output=NA, genome=genome, dups=1, sizeDups=6, maxDups=3,
bpSeqSize=6, seed=3456, verbose=FALSE)
sim
metadata(sim)


###################################################
### code chunk number 10: translocationExample1
###################################################
sim = simulateSV(output=NA, genome=genome,trans=1, bpSeqSize=6, seed=123, verbose=FALSE)
sim
metadata(sim)


###################################################
### code chunk number 11: translocationExample1
###################################################
sim = simulateSV(output=NA, genome=genome,trans=1, percBalancedTrans=0,
bpSeqSize=6, seed=123, verbose=FALSE)
sim
metadata(sim)


###################################################
### code chunk number 12: weightsMechanisms
###################################################
data(weightsMechanisms, package="RSVSim")
show(weightsMechanisms)


###################################################
### code chunk number 13: weightsRepeats
###################################################
data(weightsRepeats, package="RSVSim")
show(weightsRepeats)


###################################################
### code chunk number 14: weightsExample (eval = FALSE)
###################################################
## weightsRepeats = data.frame(
##   NAHR = c(0,0,3,1,0,0,0),
##   NHR = c(1.04,0.62,1.16,0,2.06,0,0),
##   TEI = c(1.66,0.25,0,0,0,0,0),
##   VNTR = c(0,0,0,0,0,1,0),
##   Other = c(0,0,0,0,0,0,1)
## )
## rownames(weightsRepeats) = c("L1","L2","Alu","MIR","SD","TR","Random")
## sim = simulateSV(output=NA, dels=10, repeatBias=TRUE, weightsRepeats=weightsRepeats,
## verbose=FALSE)


###################################################
### code chunk number 15: bpMutationsExample
###################################################
sim = simulateSV(output=NA, genome=genome, dels=1, sizeDels=5, bpFlankSize=10, 
percSNPs=0.25, indelProb=1, maxIndelSize=3, bpSeqSize=10, seed=123, verbose=FALSE)
sim
metadata(sim)


###################################################
### code chunk number 16: regionsExample1
###################################################
regions = GRanges(IRanges(c(21,1),c(40,20)), seqnames=c("chr1","chr2"))
regions
sim = simulateSV(output=NA, genome=genome, invs=4, sizeInvs=5, 
regionsInvs=regions, bpSeqSize=6, seed=2345, verbose=FALSE)
sim
metadata(sim)


###################################################
### code chunk number 17: regionsExample2 (eval = FALSE)
###################################################
## transcriptDB = makeTxDbFromUCSC(genome = "hg19",tablename = "knownGene")
## exons = exonsBy(transcriptDB)
## exons = unlist(exons)
## exons = GRanges(IRanges(start=start(exons), end=end(exons)), seqnames=seqnames(exons))
## simulateSV(output=NA, dels=100, regionsDels=exons, sizeDels=1000, bpSeqSize=50)


###################################################
### code chunk number 18: regionsExample3
###################################################
knownDeletion = GRanges(IRanges(16,25), seqnames="chr2")
names(knownDeletion) = "myDeletion"
knownDeletion
sim = simulateSV(output=NA, genome=genome, regionsDels=knownDeletion,
bpSeqSize=10, random=FALSE, verbose=FALSE)
sim
metadata(sim)


###################################################
### code chunk number 19: regionsExample4
###################################################
knownInsertion = GRanges(IRanges(16,25),seqnames="chr1", chrB="chr2", startB=26)
names(knownInsertion) = "myInsertion"
knownInsertion
sim = simulateSV(output=NA, genome=genome, regionsIns=knownInsertion,
bpSeqSize=10, random=FALSE, verbose=FALSE)
sim
metadata(sim)


###################################################
### code chunk number 20: regionsExample5a
###################################################
trans_BCR_ABL = GRanges(IRanges(133000000,141213431), seqnames="chr9", 
chrB="chr22", startB=23000000, endB=51304566, balanced=TRUE)
names(trans_BCR_ABL) = "BCR_ABL"
trans_BCR_ABL


###################################################
### code chunk number 21: regionsExample5b (eval = FALSE)
###################################################
## sim = simulateSV(output=NA, chrs=c("chr9", "chr22"), regionsTrans=trans_BCR_ABL,
## bpSeqSize=50, random=FALSE)


###################################################
### code chunk number 22: comparisonExample1
###################################################
sim = simulateSV(output=NA, genome=genome, dels=5, sizeDels=5,
bpSeqSize=10, seed=2345, verbose=FALSE)
simSVs = metadata(sim)$deletions
simSVs


###################################################
### code chunk number 23: comparisonExample2
###################################################
querySVs = data.frame(
  chr=c("chr1","chr1","chr1","chr2","chr2"),
  start=c(12,17,32,2,16), 
  end=c(15,24,36,6,20), 
  bpSeq=c("AAAAAAAAAA", "AAAAAAATTT", "TTTTTTTTTT", 
    "GGGGGGGGGG", "GGGGGGCCCC")
)
querySVs


###################################################
### code chunk number 24: comparisonExample3
###################################################
compareSV(querySVs, simSVs, tol=0)


###################################################
### code chunk number 25: comparisonExample4
###################################################
compareSV(querySVs, simSVs, tol=3)


###################################################
### code chunk number 26: comparisonExample5
###################################################
sim = simulateSV(output=NA, genome=genome, trans=2, percBalancedTrans=0.5, 
bpSeqSize=10, seed=246, verbose=FALSE)
simSVs = metadata(sim)$translocations
simSVs


###################################################
### code chunk number 27: comparisonExample6
###################################################
querySVs = data.frame(
  chr=c("chr1", "chr1", "chr2"), 
  start1=c(15,32,32), 
  end1=c(18,36,33), 
  chr2=c("chr2","chr2","chr1"),
  start2=c(10,31,32),
  end2=c(12,33,36)
)
querySVs


###################################################
### code chunk number 28: comparisonExample7
###################################################
compareSV(querySVs, simSVs, tol=0)


###################################################
### code chunk number 29: vignette.Rnw:341-342
###################################################
set.seed(246)


###################################################
### code chunk number 30: sizesExample1
###################################################
sizes = sample(2:5, 5, replace=TRUE)
sizes
sim = simulateSV(output=NA, genome=genome, dels=5, sizeDels=sizes,
bpSeqSize=6, seed=246, verbose=FALSE)
sim
metadata(sim)


###################################################
### code chunk number 31: sizesExample2
###################################################
svSizes = c(10,20,30,40,60,80,100,150,200,250,300,400,500,750,1000)
simSizes = estimateSVSizes(n=1000, svSizes=svSizes, minSize=10, maxSize=1000, hist=TRUE) 
head(simSizes, n=20)


###################################################
### code chunk number 32: sizesExample3
###################################################
delSizes = estimateSVSizes(n=10000, minSize=500, maxSize=10000, 
default="deletions", hist=TRUE)
head(delSizes, n=15)


###################################################
### code chunk number 33: sizesExample4
###################################################
delSizes = estimateSVSizes(n=10000, minSize=500, maxSize=10000, 
default="insertions", hist=TRUE)
head(delSizes, n=15)


###################################################
### code chunk number 34: sizesExample5
###################################################
invSizes = estimateSVSizes(n=10000, minSize=500, maxSize=10000, 
default="inversions", hist=TRUE)
head(invSizes, n=15)


###################################################
### code chunk number 35: sizesExample6
###################################################
delSizes = estimateSVSizes(n=10000, minSize=500, maxSize=10000, 
default="tandemDuplications", hist=TRUE)
head(delSizes, n=15)


###################################################
### code chunk number 36: runtime1 (eval = FALSE)
###################################################
## simulateSV(output=NA, dels=10, ins=10, inv=10, dups=10, trans=10, 
## sizeDels=10000, sizeIns=10000, sizeInvs=10000, sizeDups=10000, 
## repeatBias=FALSE, bpFlankSize=50, percSNPs=0.25, indelProb=0.5, maxIndelSize=10)


###################################################
### code chunk number 37: sessionInfo
###################################################
sessionInfo()


