# Code example from 'chimera' vignette. See references/ for full tutorial.

### R code from vignette source 'chimera.Rnw'

###################################################
### code chunk number 1: chimera.Rnw:50-51
###################################################
dir(paste(find.package(package="chimera"),"/examples/", sep=""))


###################################################
### code chunk number 2: chimera.Rnw:85-102
###################################################
#creating a fusion report from output of fusionMap
library(chimera)
tmp <- importFusionData("fusionmap", paste(find.package(package="chimera"),
"/examples/mcf7.FMFusionReport", sep=""), org="hg19")
#extracting the fSet object for one of the fusions
myset <- tmp[[13]]
#constructing the fused sequence(s)
trs <- chimeraSeqs(myset, type="transcripts")
#adding the sequences to the fSet object
myset <- addRNA(myset , trs)
#extracting sequences from an fSet object
tmp.seq <- fusionRNA(myset)
#adding reads mapped on the fusion generated using tophatRun function
myset <- addGA(myset, paste(path.package(package="chimera"),
"/examples/mcf7_trs_accepted_hits.bam",sep=""))
#extracting the GAlignments from an fSet object
ga <- fusionGA(myset)


###################################################
### code chunk number 3: chimera.Rnw:109-111
###################################################
supporting.reads <- supportingReads(tmp, fusion.reads="encompassing")
supporting.reads


###################################################
### code chunk number 4: chimera.Rnw:115-117
###################################################
fusion.names <- fusionName(tmp)
fusion.names


###################################################
### code chunk number 5: chimera.Rnw:121-123
###################################################
myset <- tmp[[13]]
trs <- chimeraSeqs(myset, type="transcripts")


###################################################
### code chunk number 6: chimera.Rnw:131-140
###################################################
#the DNAStringSet of transcript fusions sequences is saved as fast file
#write.XStringSet(trs, paste("SULF2_ARFGEF2.fa",sep=""), format="fasta")
if (require(Rsubread))
{
    subreadRun(ebwt=paste(find.package(package="chimera"),"/examples/SULF2_ARFGEF2.fa",sep=""),  
    input1=paste(find.package(package="chimera"),"/examples/mcf7_sample_1.fq",sep=""), 
    input2=paste(find.package(package="chimera"),"/examples/mcf7_sample_2.fq",sep=""),  
    outfile.prefix="accepted_hits", alignment="se", cores=1)
}


###################################################
### code chunk number 7: chimera.Rnw:145-150
###################################################
tmp1 <- filterList(tmp, type="fusion.names", fusion.names[c(1,3,7)])
tmp2 <- filterList(tmp, type="spanning.reads", 2)
#tmp3 <- filterList(tmp, type="intronic")
tmp4 <- filterList(tmp, type="annotated.genes")
tmp5 <- filterList(tmp, type="read.through")


###################################################
### code chunk number 8: chimera.Rnw:156-178
###################################################
tmp <- importFusionData("fusionmap", paste(find.package(package="chimera"),
"/examples/mcf7.FMFusionReport", sep=""), org="hg19")
fusion.names <- fusionName(tmp)
myset <- tmp[[13]]
trs <- chimeraSeqs(myset, type="transcripts")
myset <- addRNA(myset , trs)
tmp.seq <- fusionRNA(myset)
myset <- addGA(myset, paste(path.package(package="chimera"),
"/examples/mcf7_trs_accepted_hits.bam",sep=""))
	
pdf("coverage1.pdf")
plotCoverage(myset, plot.type="exons", col.box1="red", 
col.box2="green", ybox.lim=c(-4,-1))
dev.off()
pdf("coverage2.pdf")
plotCoverage(myset, plot.type="junctions", col.box1="red", 
col.box2="yellow", ybox.lim=c(-4,-1))
dev.off()
pdf("coverage3.pdf")
plotCoverage(myset, junction.spanning=100, fusion.only=TRUE, col.box1="red", 
col.box2="yellow", ybox.lim=c(-4,-1))
dev.off()


###################################################
### code chunk number 9: chimera.Rnw:207-209
###################################################
mypeps <- fusionPeptides(chimeraSeq.output=trs)
mypeps


###################################################
### code chunk number 10: chimera.Rnw:342-346
###################################################
library(xtable)
tp <- read.table(paste(find.package(package="chimera"),"/examples/edgren.stat.detection.txt",sep=""), sep="\t", header=T)
my.table <- xtable(tp, caption = 'Edgren validated fusions discovered by tools supported by chimera')
print(my.table)


###################################################
### code chunk number 11: chimera.Rnw:360-361
###################################################
sessionInfo()


