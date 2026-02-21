# Code example from 'msgbsR_Vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'msgbsR_Vignette.Rnw'

###################################################
### code chunk number 1: load the example data
###################################################
library(msgbsR)
library(GenomicRanges)
library(SummarizedExperiment)

my_path <- system.file("extdata", package = "msgbsR")
se <- rawCounts(bamFilepath = my_path)
dim(assay(se))


###################################################
### code chunk number 2: insert metadata
###################################################
colData(se) <- DataFrame(Group = c(rep("Control", 3), rep("Experimental", 3)),
                         row.names = colnames(assay(se)))


###################################################
### code chunk number 3: extract cut sites
###################################################
cutSites <- rowRanges(se)

# # Adjust the cut sites to overlap recognition site on each strand
start(cutSites) <- ifelse(test = strand(cutSites) == '+',
                          yes = start(cutSites) - 1, no = start(cutSites) - 2)
end(cutSites) <- ifelse(test = strand(cutSites) == '+',
                          yes = end(cutSites) + 2, no = end(cutSites) + 1)


###################################################
### code chunk number 4: run checkCuts with BSgenome
###################################################
library(BSgenome.Rnorvegicus.UCSC.rn6)
correctCuts <- checkCuts(cutSites = cutSites, genome = "rn6", seq = "CCGG")


###################################################
### code chunk number 5: filter out incorrect cuts
###################################################
se <- subsetByOverlaps(se, correctCuts)
dim(assay(se))


###################################################
### code chunk number 6: plot counts per cut sites
###################################################
plotCounts(se = se, cateogory = "Group")


###################################################
### code chunk number 7: fig1
###################################################
plotCounts(se = se, cateogory = "Group")


###################################################
### code chunk number 8: differential methylation
###################################################
top <- diffMeth(se = se, cateogory = "Group",
                condition1 = "Control", condition2 = "Experimental",
                cpmThreshold = 1, thresholdSamples = 1)


###################################################
### code chunk number 9: chr20 length
###################################################
ratChr <- seqlengths(BSgenome.Rnorvegicus.UCSC.rn6)["chr20"]


###################################################
### code chunk number 10: top sites
###################################################
my_cuts <- GRanges(top$site[which(top$FDR < 0.05)])


###################################################
### code chunk number 11: circos plot
###################################################
plotCircos(cutSites = my_cuts, seqlengths = ratChr,
           cutSite.colour = "red", seqlengths.colour = "blue")


###################################################
### code chunk number 12: fig2
###################################################
plotCircos(cutSites = my_cuts, seqlengths = ratChr,
           cutSite.colour = "red", seqlengths.colour = "blue")


###################################################
### code chunk number 13: annotation
###################################################
sessionInfo()


