# Code example from 'spliceSites' vignette. See references/ for full tutorial.

### R code from vignette source 'spliceSites.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: spliceSites.Rnw:308-315
###################################################
library(spliceSites)
bam<-character(2)
bam[1]<-system.file("extdata","rna_fem.bam",package="spliceSites")
bam[2]<-system.file("extdata","rna_mal.bam",package="spliceSites")
reader<-bamReader(bam[1],idx=TRUE)
gs<-getGapSites(reader,seqid=1)
gs


###################################################
### code chunk number 2: spliceSites.Rnw:321-323
###################################################
ga<-alignGapList(reader)
ga


###################################################
### code chunk number 3: spliceSites.Rnw:336-338
###################################################
mbg<-readMergedBamGaps(bam)
mbg


###################################################
### code chunk number 4: spliceSites.Rnw:352-356
###################################################
prof<-data.frame(gender=c("f","m"))
rtbg<-readTabledBamGaps(bam,prof=prof,rpmg=TRUE)
rtbg
getProfile(rtbg)


###################################################
### code chunk number 5: spliceSites.Rnw:410-423
###################################################
ljp<-lJunc(ga,featlen=6,gaplen=6,strand='+')
ljp
ljm<-lJunc(ga,featlen=6,gaplen=6,strand='-')
ljm
rjp<-rJunc(ga,featlen=6,gaplen=6,strand='+')
rjp
rjm<-rJunc(ga,featlen=6,gaplen=6,strand='-')
rjm

lrjp<-lrJunc(ga,lfeatlen=6,rfeatlen=6,strand='+')
lrjp
lrjm<-lrJunc(ga,lfeatlen=6,rfeatlen=6,strand='-')
lrjm


###################################################
### code chunk number 6: spliceSites.Rnw:450-455
###################################################
ljp1<-lCodons(ljp,frame=1)
ljp1
ljp2<-lCodons(ljp,frame=2)
rjm1<-rCodons(ljm,frame=1)
rjm2<-rCodons(ljm,frame=2)


###################################################
### code chunk number 7: spliceSites.Rnw:468-471
###################################################
lr1<-lrCodons(lrjp,frame=1,strand='+')
lr2<-lrCodons(lrjp,frame=2,strand='+')
lr3<-lrCodons(lrjp,frame=3,strand='+')


###################################################
### code chunk number 8: spliceSites.Rnw:480-483
###################################################
ljpc<-c(ljp1,ljp2)
rjmc<-c(rjm1,rjm2)
lrj<-c(lr1,lr2,lr3)


###################################################
### code chunk number 9: spliceSites.Rnw:488-491
###################################################
ljpc<-sortTable(ljpc)
rjmc<-sortTable(rjmc)
lrj<-sortTable(lrj)


###################################################
### code chunk number 10: spliceSites.Rnw:502-506
###################################################
trim_left(lrj,3)
trim_right(lrj,3)
resize_left(lrj,8)
resize_right(lrj,8)


###################################################
### code chunk number 11: spliceSites.Rnw:523-527
###################################################
ucf<-system.file("extdata","uc_small.RData",package="spliceSites")
uc<-loadGenome(ucf)
juc <- getSpliceTable(uc)
annotation(ga)<-annotate(ga, juc)


###################################################
### code chunk number 12: spliceSites.Rnw:534-535
###################################################
annotation(rtbg)<-annotate(rtbg, juc)


###################################################
### code chunk number 13: spliceSites.Rnw:547-548
###################################################
strand(ga)<-getAnnStrand(ga)


###################################################
### code chunk number 14: spliceSites.Rnw:553-555
###################################################
gap<-addGeneAligns(ga)
gap


###################################################
### code chunk number 15: spliceSites.Rnw:569-572
###################################################
dnafile<-system.file("extdata","dna_small.RData",package="spliceSites")
load(dnafile)
dna_small


###################################################
### code chunk number 16: spliceSites.Rnw:577-579
###################################################
ljpcd<-dnaRanges(ljpc,dna_small)
seqlogo(ljpcd)


###################################################
### code chunk number 17: spliceSites.Rnw:588-589
###################################################
ljpca<-translate(ljpcd)


###################################################
### code chunk number 18: spliceSites.Rnw:603-608
###################################################
# A) For gapSites
extractRange(ga,seqid="chr1",start=14000,end=30000)
# B) For cRanges
lj<-lJunc(ga,featlen=3,gaplen=6,strand='+')
extractRange(lj,seqid="chr1",start=14000,end=30000)


###################################################
### code chunk number 19: spliceSites.Rnw:619-624
###################################################
lj<-lJunc(ga,featlen=6,gaplen=3,strand='+')
ljw<-extractByGeneName(ljp,geneNames="POLR3K",src=uc)
ljw
ljw<-extractByGeneName(ljpcd,geneNames="POLR3K",src=uc)
ljw


###################################################
### code chunk number 20: spliceSites.Rnw:632-640
###################################################
l<-12
lj<-lJunc(mbg,featlen=l,gaplen=l,strand='+')
ljc<-c(lCodons(lj,1),lCodons(lj,2),lCodons(lj,3))

lrj<-lrJunc(mbg,lfeatlen=l,rfeatlen=l,strand='+')
lrjc<-c(lrCodons(lrj,1),lrCodons(lrj,2),lrCodons(lrj,3))

jlrd<-dnaRanges(ljc,dna_small)


###################################################
### code chunk number 21: spliceSites.Rnw:645-647
###################################################
jlrt<-translate(jlrd)
jlrt


###################################################
### code chunk number 22: spliceSites.Rnw:659-661
###################################################
jlrtt<-truncateSeq(jlrt)
jlrtt


###################################################
### code chunk number 23: spliceSites.Rnw:671-673
###################################################
jtry<-trypsinCleave(jlrtt)
jtry<-sortTable(jtry)


###################################################
### code chunk number 24: spliceSites.Rnw:684-686 (eval = FALSE)
###################################################
## annotation(rtbg)<-annotate(rtbg, juc)
## write.annDNA.tables(rtbg, dna_small, "gapSites.csv", featlen=3, gaplen=8)


###################################################
### code chunk number 25: spliceSites.Rnw:737-738 (eval = FALSE)
###################################################
## write.files(jtry,path=getwd(),filename="proteomic",quote=FALSE)


###################################################
### code chunk number 26: spliceSites.Rnw:777-778
###################################################
al<-alt_left_ranks(ga)


###################################################
### code chunk number 27: spliceSites.Rnw:785-786
###################################################
ar<-alt_ranks(ga)


###################################################
### code chunk number 28: spliceSites.Rnw:790-791
###################################################
plot_diff_ranks(ga)


###################################################
### code chunk number 29: spliceSites.Rnw:797-799
###################################################
aga<-annotation(ga)
plot_diff(aga)


###################################################
### code chunk number 30: spliceSites.Rnw:816-828
###################################################
mes<-load.maxEnt()
score5(mes,"CCGGGTAAGAA",4)
score3(mes,"CTCTACTACTATCTATCTAGATC",pos=20)

sq5<-scoreSeq5(mes,seq="ACGGTAAGTCAGGTAAGT")
sq3<-scoreSeq3(mes,seq="TTTATTTTTCTCACTTTTAGAGACTTCATTCTTTCTCAAATAGGTT")

gae<-addMaxEnt(ga,dna_small,mes)
gae
table(getMeStrand(gae))
sae<-setMeStrand(gae)
sae


###################################################
### code chunk number 31: spliceSites.Rnw:836-840
###################################################
# 
hb<-load.hbond()
seq<-c("CAGGTGAGTTC", "ATGCTGGAGAA", "AGGGTGCGGGC", "AAGGTAACGTC", "AAGGTGAGTTC")
hbond(hb,seq,3)


###################################################
### code chunk number 32: spliceSites.Rnw:843-848
###################################################
gab<-addHbond(ga,dna_small)
# D) cdRanges
lj<-lJunc(ga, featlen=3, gaplen=8, strand='+')
ljd<-dnaRanges(lj,dna_small)
ljdh<-addHbond(ljd)


###################################################
### code chunk number 33: spliceSites.Rnw:894-901
###################################################
prof<-data.frame(gender=c("f", "m"))
rtbg<-readTabledBamGaps(bam, prof=prof, rpmg=TRUE)
getProfile(rtbg)

meta<-data.frame(labelDescription=names(prof),row.names=names(prof))
pd<-new("AnnotatedDataFrame",data=prof,varMetadata=meta)
es<-readExpSet(bam,phenoData=pd)


###################################################
### code chunk number 34: spliceSites.Rnw:908-911
###################################################
ann<-annotate(es, juc)
ucj<-getSpliceTable(uc)
uja<-uniqueJuncAnn(es, ucj)


###################################################
### code chunk number 35: spliceSites.Rnw:917-923 (eval = FALSE)
###################################################
## library(DESeq2)
## cds <- DESeqDataSetFromMatrix(exprs(es), colData=prof, design=~gender)
## des <- DESeq(cds)
## binom.res<-results(des)
## br <- na.omit(binom.res)
## bro <- br[order(br$padj, decreasing=TRUE),]


###################################################
### code chunk number 36: spliceSites.Rnw:932-944
###################################################
n <- 10
cuff <- system.file("extdata","cuff_files",
            paste(1:n, "genes", "fpkm_tracking", sep="."), 
            package="spliceSites")

gr <- system.file("extdata", "cuff_files", "groups.csv", package="spliceSites")
groups <- read.table(gr, sep="\t", header=TRUE)
meta <- data.frame(labelDescription=c("gender", "age-group", "location"), 
                row.names=c("gen", "agg", "loc"))

phenoData <- new("AnnotatedDataFrame", data=groups, varMetadata=meta)
exset <- readCuffGeneFpkm(cuff, phenoData)


###################################################
### code chunk number 37: spliceSites.Rnw:955-960
###################################################
bam <- system.file("extdata","rna_fem.bam",package="spliceSites")
reader <- bamReader(bam, idx=TRUE)
# Load annotation data
ucf <- system.file("extdata", "uc_small.RData", package="spliceSites")
uc <- loadGenome(ucf)


###################################################
### code chunk number 38: spliceSites.Rnw:965-968
###################################################
plotGeneAlignDepth(reader, uc, gene="WASH7P", transcript="uc001aac.4",
                    col="slategray3", fill="slategray1",
                    box.col="snow3", box.border="snow4")


###################################################
### code chunk number 39: spliceSites.Rnw:986-990
###################################################
prof<-data.frame(gen=factor(c("w","m","w","w"),levels=c("m","w")),
                 loc=factor(c("thx","thx","abd","abd"),levels=c("thx","abd")),
                 ag =factor(c("y","y","m","o"),levels=c("y","m","o")))
prof


###################################################
### code chunk number 40: spliceSites.Rnw:996-1020
###################################################
key1<-data.frame(id=1:5,
                 seqid=c(1,1,2,2,3),
                 lend=c(10,20,10,30,10),
                 rstart=c(20,30,20,40,20),
                 nAligns=c(11,21,31,41,51))

key2<-data.frame(id=1:5,
                 seqid=c(1,1,2,2,4),
                 lend=c(10,20,10,30,50),
                 rstart=c(20,30,20,40,70),
                 nAligns=c(21,22,23,24,25))

key3<-data.frame(id=1:5,
                 seqid=c(1,2,4,5,5),
                 lend=c(10,10,60,10,20),
                 rstart=c(20,20,80,20,30),
                 nAligns=c(31,32,33,34,35))

key<-rbind(key1,key2,key3)

# Group positions
ku<-aggregate(data.frame(nAligns=key$nAligns),
              by=list(seqid=key$seqid,lend=key$lend,rstart=key$rstart),
              FUN=sum)


###################################################
### code chunk number 41: spliceSites.Rnw:1029-1034
###################################################
# Count probes
kpc<-new("keyProfiler",keyTable=key1[,c("seqid","lend","rstart")],prof=prof)
addKeyTable(kpc,keyTable=key2[,c("seqid","lend","rstart")],index=2)
addKeyTable(kpc,keyTable=key3[,c("seqid","lend","rstart")],index=4)



###################################################
### code chunk number 42: spliceSites.Rnw:1038-1040
###################################################
cp<-appendKeyTable(kpc,ku,prefix="c.")
cp


###################################################
### code chunk number 43: spliceSites.Rnw:1044-1051
###################################################
# Count aligns
kpa<-new("keyProfiler",keyTable=key1[,c("seqid","lend","rstart")],prof=prof,values=key1$nAligns)
kpa@ev$dtb
addKeyTable(kpa,keyTable=key2[,c("seqid","lend","rstart")],index=2,values=key2$nAligns)
addKeyTable(kpa,keyTable=key3[,c("seqid","lend","rstart")],index=4,values=key3$nAligns)
ca<-appendKeyTable(kpa,ku,prefix="aln.")
ca


