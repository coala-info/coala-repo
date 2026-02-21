# Code example from 'contiBAIT' vignette. See references/ for full tutorial.

### R code from vignette source 'contiBAIT.Rnw'

###################################################
### code chunk number 1: strandSeqFreqTableExamplea
###################################################
# Read in BAM files. Path denotes location of the BAM files.
# Returns a vector of file locations

library(contiBAIT)
bamFileList <- list.files(
path=file.path(system.file(package='contiBAIT'), 'extdata'),
pattern=".bam$",
full.names=TRUE)


###################################################
### code chunk number 2: makeChrTableExample
###################################################
# build chr table from BAM file in bamFileList

exampleChrTable <- makeChrTable(bamFileList[1]) 

exampleChrTable


###################################################
### code chunk number 3: makeChrTableExampleb
###################################################

exampleDividedChr <- makeChrTable(bamFileList[1], splitBy=1000000)
exampleDividedChr


###################################################
### code chunk number 4: mapGapOverlapExampleb
###################################################

library(rtracklayer)
# Download GRCh38/hg38 gap track from UCSC
gapFile <- import.bed("http://genome.ucsc.edu/cgi-bin/hgTables?hgsid=465319523_SLOtFPExny48YZFaXBh4sSTzuMcA&boolshad.hgta_printCustomTrackHeaders=0&hgta_ctName=tb_gap&hgta_ctDesc=table+browser+query+on+gap&hgta_ctVis=pack&hgta_ctUrl=&fbQual=whole&fbUpBases=200&fbDownBases=200&hgta_doGetBed=get+BED")
# Create fake SCE file with four regions that overlap a gap
sceFile <- GRanges(rep('chr4',4), 
IRanges(c(1410000, 1415000, 1420000, 1425000), 
c(1430000, 1435000, 1430000, 1435000)))
overlappingFragments <- mapGapFromOverlap(sceFile,
 gapFile, 
 exampleChrTable, 
 overlapNum=4)
show(overlappingFragments)


###################################################
### code chunk number 5: strandSeqFreqTableExamplea
###################################################
# Create a strandFreqTable instance 

strandFrequencyList <- strandSeqFreqTable(bamFileList, 
filter=exampleDividedChr,
qual=10, 
pairedEnd=FALSE,
BAITtables=TRUE)


###################################################
### code chunk number 6: strandSeqFreqTableExampleb
###################################################
# Returned list consisting of two data.frames
strandFrequencyList

# Exclude frequencies calculated from
# contigs with less than 10 reads

exampleStrandFreq <- strandFrequencyList[[1]]
exampleReadCounts <- strandFrequencyList[[2]]
exampleStrandFreq[which(exampleReadCounts < 10)] <- NA 


###################################################
### code chunk number 7: strandSeqFreqTableExamplec
###################################################

# Assess the quality of the libraries being analysed
plotWCdistribution(exampleStrandFreq)


###################################################
### code chunk number 8: preprocessStrandTableExamplea
###################################################
# Convert strand frequencies to strand calls.

exampleStrandStateMatrix <- preprocessStrandTable(
exampleStrandFreq, 
lowQualThreshold=0.8)

exampleStrandStateMatrix[[1]]


###################################################
### code chunk number 9: clusterContigsExamplea
###################################################
exampleWCMatrix <- exampleStrandStateMatrix[[1]]

clusteredContigs <- clusterContigs(exampleWCMatrix, randomise=FALSE)

reorientedMatrix <- reorientAndMergeLGs(clusteredContigs,
 exampleWCMatrix)

exampleLGList <- reorientedMatrix[[3]]

exampleLGList
exampleLGList[[1]]


###################################################
### code chunk number 10: clusterContigsExampleb
###################################################
plotLGDistances(exampleLGList, exampleWCMatrix)


###################################################
### code chunk number 11: clustercontigsExamplec
###################################################

plotLGDistances(exampleLGList, exampleWCMatrix, lg=1)


###################################################
### code chunk number 12: orderAllLinkageGroupsExample
###################################################
contigOrder <- orderAllLinkageGroups(exampleLGList,
exampleWCMatrix,
exampleStrandFreq,
exampleReadCounts,
whichLG=1,
saveOrdered=TRUE)

contigOrder[[1]]


###################################################
### code chunk number 13: orderAllLinkageGroupsExampleb
###################################################

plotContigOrder(contigOrder[[1]])


###################################################
### code chunk number 14: orderAllLinkageGroupsExamplec
###################################################
contigOrderAll <- orderAllLinkageGroups(exampleLGList,
exampleWCMatrix,
exampleStrandFreq,
exampleReadCounts)

contigOrderAll[[1]]


###################################################
### code chunk number 15: ideogramExample
###################################################
# extract elements from strandSeqFreqTable list
WatsonFreqList <- strandFrequencyList[[3]]
CrickFreqList <- strandFrequencyList[[4]]

# subset elements to only analyze one library
singleWatsonLibrary <- StrandReadMatrix(WatsonFreqList[,2, drop=FALSE])
singleCrickLibrary <- StrandReadMatrix(CrickFreqList[,2, drop=FALSE]) 

# Run ideogram plotter
ideogramPlot(singleWatsonLibrary,
singleCrickLibrary,
exampleDividedChr)


###################################################
### code chunk number 16: ideogramExampleb
###################################################

ideogramPlot(singleWatsonLibrary,
singleCrickLibrary,
exampleDividedChr,
orderFrame=contigOrderAll[[1]])


###################################################
### code chunk number 17: ideogramExamplec
###################################################
ideogramPlot(WatsonFreqList,
CrickFreqList,
exampleDividedChr,
orderFrame=contigOrder[[1]],
plotBy='chr',
showPage=1)


###################################################
### code chunk number 18: writeBedExample
###################################################

writeBed(exampleDividedChr,
reorientedMatrix[[2]],
contigOrder[[1]])


###################################################
### code chunk number 19: makeChrTableExamplec
###################################################
makeBoxPlot(exampleDividedChr, exampleLGList)


###################################################
### code chunk number 20: makeChrTableExampled
###################################################
barplotLinkageGroupCalls(exampleLGList, exampleDividedChr)


###################################################
### code chunk number 21: fig1plot
###################################################
library(diagram)

par(mar = c(1, 1, 1, 1))
 openplotmat()
# elpos <- coordinates (c(5, 5, 5, 5, 5, 5, 5, 5))
 elpos <- coordinates (rep(4,7))

fromto <- matrix(ncol = 2, byrow = TRUE, data = c(
	    3, 6,
 	    3, 8,
 	    6, 5,
 	    6, 7,
 	    6,9,
 	    6,10,
 	    8,7,
 	    8,11,
 	    8,20,
 	    10,14,
 	    14,18,
 	    18,19,
 	    10,11,
 	    10,15,
 	    19,15,
 	    19,20,
 	    19,23,
 	    23,27,
 	    9,17,
 	    14,13,
 	    17,22,
 	    22,23,
 	    18,23,
 	    23,24


))

 nr <- nrow(fromto)
 arrpos <- matrix(ncol = 2, nrow = nr)
 for (i in 1:nr)
arrpos[i, ] <- straightarrow (to = elpos[fromto[i, 2], ], from = elpos[fromto[i, 1], ], lwd = 2, arr.pos = 0.6, arr.width=0.15, arr.length = 0.5)

textround(elpos[3,], 0.04, lab = "BAMFILE", box.col = "grey70", shadow.col = "grey10", shadow.size = 0.005, cex = 0.8)
textrect(elpos[8,], 0.09, 0.04,lab = "make\nChrTable", box.col = "white", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
textrect(elpos[6,], 0.09, 0.04,lab = "strandSeq\nFreqTable", box.col = "white", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
textrect(elpos[10,], 0.09, 0.04,lab = "preprocess\nStrandTable", box.col = "white", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
textrect(elpos[14,], 0.09, 0.04,lab = "cluster\nContigs", box.col = "white", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
textrect(elpos[18,], 0.09, 0.04,lab = "reorient\nLinkageGroups", box.col = "white", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
textrect(elpos[19,], 0.09, 0.04,lab = "merge\nLinkageGroup", box.col = "white", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
textrect(elpos[23,], 0.09, 0.04,lab = "orderAll\nLinkageGroups", box.col = "white", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
textround(elpos[27,], 0.04, lab = "writeBed", box.col = "grey70", shadow.col = "grey10", shadow.size = 0.005, cex = 0.8)

texthexa(elpos[7,], 0.09, 0.04,lab = "ideogram\nPlot", box.col = "lightblue", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
texthexa(elpos[11,], 0.09, 0.04,lab = "make\nBoxPlot", box.col = "lightblue", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
texthexa(elpos[5,], 0.09, 0.04,lab = "plotWC\ndistribution", box.col = "lightblue", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
texthexa(elpos[15,], 0.09, 0.04,lab = "plotLG\ndistances", box.col = "lightblue", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
texthexa(elpos[20,], 0.09, 0.04,lab = "barplot\nLGCalls", box.col = "lightblue", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
texthexa(elpos[24,], 0.09, 0.04,lab = "plotContig\nOrder", box.col = "lightblue", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)




###################################################
### code chunk number 22: fig1
###################################################
library(diagram)

par(mar = c(1, 1, 1, 1))
 openplotmat()
# elpos <- coordinates (c(5, 5, 5, 5, 5, 5, 5, 5))
 elpos <- coordinates (rep(4,7))

fromto <- matrix(ncol = 2, byrow = TRUE, data = c(
	    3, 6,
 	    3, 8,
 	    6, 5,
 	    6, 7,
 	    6,9,
 	    6,10,
 	    8,7,
 	    8,11,
 	    8,20,
 	    10,14,
 	    14,18,
 	    18,19,
 	    10,11,
 	    10,15,
 	    19,15,
 	    19,20,
 	    19,23,
 	    23,27,
 	    9,17,
 	    14,13,
 	    17,22,
 	    22,23,
 	    18,23,
 	    23,24


))

 nr <- nrow(fromto)
 arrpos <- matrix(ncol = 2, nrow = nr)
 for (i in 1:nr)
arrpos[i, ] <- straightarrow (to = elpos[fromto[i, 2], ], from = elpos[fromto[i, 1], ], lwd = 2, arr.pos = 0.6, arr.width=0.15, arr.length = 0.5)

textround(elpos[3,], 0.04, lab = "BAMFILE", box.col = "grey70", shadow.col = "grey10", shadow.size = 0.005, cex = 0.8)
textrect(elpos[8,], 0.09, 0.04,lab = "make\nChrTable", box.col = "white", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
textrect(elpos[6,], 0.09, 0.04,lab = "strandSeq\nFreqTable", box.col = "white", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
textrect(elpos[10,], 0.09, 0.04,lab = "preprocess\nStrandTable", box.col = "white", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
textrect(elpos[14,], 0.09, 0.04,lab = "cluster\nContigs", box.col = "white", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
textrect(elpos[18,], 0.09, 0.04,lab = "reorient\nLinkageGroups", box.col = "white", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
textrect(elpos[19,], 0.09, 0.04,lab = "merge\nLinkageGroup", box.col = "white", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
textrect(elpos[23,], 0.09, 0.04,lab = "orderAll\nLinkageGroups", box.col = "white", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
textround(elpos[27,], 0.04, lab = "writeBed", box.col = "grey70", shadow.col = "grey10", shadow.size = 0.005, cex = 0.8)

texthexa(elpos[7,], 0.09, 0.04,lab = "ideogram\nPlot", box.col = "lightblue", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
texthexa(elpos[11,], 0.09, 0.04,lab = "make\nBoxPlot", box.col = "lightblue", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
texthexa(elpos[5,], 0.09, 0.04,lab = "plotWC\ndistribution", box.col = "lightblue", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
texthexa(elpos[15,], 0.09, 0.04,lab = "plotLG\ndistances", box.col = "lightblue", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
texthexa(elpos[20,], 0.09, 0.04,lab = "barplot\nLGCalls", box.col = "lightblue", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)
texthexa(elpos[24,], 0.09, 0.04,lab = "plotContig\nOrder", box.col = "lightblue", shadow.col = "grey10", shadow.size = 0.005, cex = 0.7)




