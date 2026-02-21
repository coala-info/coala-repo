# Code example from 'TarSeqQC-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'TarSeqQC-vignette.Rnw'

###################################################
### code chunk number 1: General options for R
###################################################
options(prompt="> ", continue="+  ", width=90, useFancyQuotes=FALSE, digits=3)


###################################################
### code chunk number 2: TarSeqQC-vignette.Rnw:171-173 (eval = FALSE)
###################################################
## source("http://www.bioconductor.org/biocLite.R")
## biocLite("TarSeqQC")


###################################################
### code chunk number 3: TarSeqQC-vignette.Rnw:184-185
###################################################
citation("TarSeqQC")


###################################################
### code chunk number 4: TarSeqQC-vignette.Rnw:285-286
###################################################
bedFile<-system.file("extdata", "mybed.bed", package="TarSeqQC", mustWork=TRUE)


###################################################
### code chunk number 5: TarSeqQC-vignette.Rnw:309-310
###################################################
bamFile<-system.file("extdata", "mybam.bam", package="TarSeqQC", mustWork=TRUE)


###################################################
### code chunk number 6: TarSeqQC-vignette.Rnw:323-325
###################################################
fastaFile<-system.file("extdata", "myfasta.fa", package="TarSeqQC", 
                        mustWork=TRUE)


###################################################
### code chunk number 7: library call
###################################################
suppressMessages(library("TarSeqQC"))
suppressMessages(library("BiocParallel"))


###################################################
### code chunk number 8: bedFasta control
###################################################
checkBedFasta(bedFile , fastaFile)


###################################################
### code chunk number 9: constructor (eval = FALSE)
###################################################
## library("TarSeqQC")
## library("BiocParallel")
## BPPARAM<-bpparam()
## myPanel<-TargetExperiment(bedFile, bamFile, fastaFile, feature="amplicon", 
##                         attribute="coverage", BPPARAM=BPPARAM)


###################################################
### code chunk number 10: loading TargetExperiment object
###################################################
BPPARAM<-bpparam()
data(ampliPanel, package="TarSeqQC")
myPanel<-ampliPanel
rm(ampliPanel)
setBamFile(myPanel)<-system.file("extdata", "mybam.bam", package="TarSeqQC",
                                    mustWork=TRUE)
setFastaFile(myPanel)<-system.file("extdata", "myfasta.fa", 
                                    package="TarSeqQC", mustWork=TRUE)



###################################################
### code chunk number 11: setters
###################################################
# set feature slot value
setFeature(myPanel)<-"amplicon"
# set attribute slot value
setAttribute(myPanel)<-"coverage"


###################################################
### code chunk number 12: setters (eval = FALSE)
###################################################
## # set scanBamP slot value
## scanBamP<-ScanBamParam()
## #set scanBamP which slot
## bamWhich(scanBamP)<-getBedFile(myPanel)
## setScanBamP(myPanel)<-scanBamP
## # set pileupP slot value
## setPileupP(myPanel)<-PileupParam(max_depth=1000)
## # build the featurePanel again
## setFeaturePanel(myPanel)<-buildFeaturePanel(myPanel, BPPARAM)
## # build the genePanel again
## setGenePanel(myPanel)<-summarizePanel(myPanel, BPPARAM)


###################################################
### code chunk number 13: loading TargetExperiment object
###################################################
data(ampliPanel, package="TarSeqQC")


###################################################
### code chunk number 14: re-defininf file paths
###################################################
# Defining bam file and fasta file names and paths
setBamFile(ampliPanel)<-system.file("extdata", "mybam.bam", 
    package="TarSeqQC", mustWork=TRUE)
setFastaFile(ampliPanel)<-system.file("extdata", "myfasta.fa", 
    package="TarSeqQC", mustWork=TRUE)


###################################################
### code chunk number 15: exploration
###################################################
# show/print
myPanel
# summary
summary(myPanel)
#summary at feature level
summaryFeatureLev(myPanel)
#summary at gene level
summaryGeneLev(myPanel)


###################################################
### code chunk number 16: boxplot and density plot (eval = FALSE)
###################################################
## g<-plotAttrExpl(myPanel,level="feature",join=TRUE, log=FALSE, color="blue")
## x11(type="cairo");
## g


###################################################
### code chunk number 17: length exploration (eval = FALSE)
###################################################
## # explore amplicon length distribution
## plotMetaDataExpl(myPanel, "length", log=FALSE, join=FALSE, color=
##                     "blueviolet")


###################################################
### code chunk number 18: gene exploration (eval = FALSE)
###################################################
## # explore gene's relative frequencies 
## plotMetaDataExpl(myPanel, "gene", abs=FALSE)


###################################################
### code chunk number 19: read percentages and plot (eval = FALSE)
###################################################
## readFrequencies(myPanel)
## plotInOutFeatures(readFrequencies(myPanel))


###################################################
### code chunk number 20: attributeThres
###################################################
# definition of the interval extreme values
attributeThres<-c(0,1,50,200,500, Inf)


###################################################
### code chunk number 21: plot (eval = FALSE)
###################################################
## # plot panel overview
## plot(myPanel, attributeThres=attributeThres, chrLabels =TRUE)


###################################################
### code chunk number 22: plotFeatPerform (eval = FALSE)
###################################################
## # plot panel overview
## g<-plotFeatPerform(myPanel, attributeThres, complete=TRUE, log=FALSE, 
##     featureLabs=TRUE, sepChr=TRUE, legend=TRUE)
## g


###################################################
### code chunk number 23: gc exploration (eval = FALSE)
###################################################
## x11(type="cairo")
## biasExploration(myPanel, source="gc", dens=TRUE)


###################################################
### code chunk number 24: frequency table
###################################################
# summaryIntervals
summaryIntervals(myPanel, attributeThres)


###################################################
### code chunk number 25: coveragePerform (eval = FALSE)
###################################################
## plotAttrPerform(myPanel, attributeThres)


###################################################
### code chunk number 26: low counts features
###################################################
getLowCtsFeatures(myPanel, level="gene", threshold=50)


###################################################
### code chunk number 27: low counts features
###################################################
getLowCtsFeatures(myPanel, level="feature", threshold=50)


###################################################
### code chunk number 28: geneAttrPerFeat (eval = FALSE)
###################################################
## g<-plotGeneAttrPerFeat(myPanel, geneID="gene4")
## # adjust text size
## g<-g+theme(title=element_text(size=16), axis.title=element_text(size=16),
##     legend.text=element_text(size=14))
## g


###################################################
### code chunk number 29: geneAttrPerFeat (eval = FALSE)
###################################################
## g<-plotGeneAttrPerFeat(myPanel, geneID="gene4", overlap = TRUE, level="both")
## g


###################################################
### code chunk number 30: getOverlappedRegions
###################################################
dfRegions<-getOverlappedRegions(myPanel,collapse=TRUE)
head(dfRegions)
#change the region_id field name to consistency of the new bed file
names(dfRegions)[5]<-"name"


###################################################
### code chunk number 31: getOverlappedRegions (eval = FALSE)
###################################################
## #save the new bed file
## write.table(dfRegions[,1:5], file="myRegions.bed", sep="\t", col.names=T,
## row.names=F,quote=F)


###################################################
### code chunk number 32: pileupCounts (eval = FALSE)
###################################################
## # define function parameters
## bed<-getBedFile(myPanel)
## bamFile<-system.file("extdata", "mybam.bam", package="TarSeqQC", mustWork=TRUE)
## fastaFile<-system.file("extdata", "myfasta.fa", package="TarSeqQC", 
##                         mustWork=TRUE)
## scanBamP<-getScanBamP(myPanel)
## pileupP<-getPileupP(myPanel)
## #call pileupCounts function
## myCounts<-pileupCounts(bed=bed, bamFile=bamFile, fastaFile=fastaFile, 
##                         scanBamP=scanBamP, pileupP=pileupP, BPPARAM=BPPARAM)


###################################################
### code chunk number 33: pileupCounts
###################################################
data("myCounts", package="TarSeqQC")


###################################################
### code chunk number 34: pileupCounts
###################################################
head(myCounts)


###################################################
### code chunk number 35: getRegion
###################################################
#complete information for gene7
getRegion(myPanel, level="gene", ID="gene7", collapse=FALSE)
#summarized information for gene7
getRegion(myPanel, level="gene", ID="gene7", collapse=TRUE)


###################################################
### code chunk number 36: plotRegion (eval = FALSE)
###################################################
## g<-plotRegion(myPanel, region=c(4500,6800), seqname="chr10", SNPs=TRUE, 
##     minAAF = 0, minRD = 0, xlab="", title="gene7 amplicons",size=0.5)
## x11(type="cairo")
## g


###################################################
### code chunk number 37: plotFeature (eval = FALSE)
###################################################
## g<-plotFeature(myPanel, featureID="AMPL20")
## x11(type="cairo")
## g


###################################################
### code chunk number 38: plotNtd (eval = FALSE)
###################################################
## plotNtdPercentage(myPanel, featureID="AMPL20")


###################################################
### code chunk number 39: featureInfo
###################################################
getFeaturePanel(myPanel)["AMPL20"]


###################################################
### code chunk number 40: readCountsFeat<
###################################################
featureCounts<-myCounts[myCounts[, "seqnames"] =="chr10" & 
                        myCounts[,"pos"] >= 4866 & myCounts[,"pos"] <= 4928,]


###################################################
### code chunk number 41: readCountsFeat<
###################################################
featureCounts[which.min(featureCounts[,"="]),]


###################################################
### code chunk number 42: buildReport (eval = FALSE)
###################################################
## imageFile<-system.file("extdata", "plot.pdf", package="TarSeqQC",
##                         mustWork=TRUE)
## buildReport(myPanel, attributeThres, imageFile ,file="Results.xlsx")


###################################################
### code chunk number 43: TarSeqQC-vignette.Rnw:1138-1139 (eval = FALSE)
###################################################
## panelList<-list(panel1=te1, panel2=te2)  


###################################################
### code chunk number 44: TarSeqQC-vignette.Rnw:1154-1156 (eval = FALSE)
###################################################
## TEList<-TargetExperimentList(TEList=ampliList, feature="amplicon", 
##     attribute="coverage")


###################################################
### code chunk number 45: TarSeqQC-vignette.Rnw:1159-1160
###################################################
data(TEList, package = "TarSeqQC")


###################################################
### code chunk number 46: TarSeqQC-vignette.Rnw:1166-1170
###################################################
# show/print
TEList
# summary
summary(TEList)


###################################################
### code chunk number 47: TarSeqQC-vignette.Rnw:1184-1186 (eval = FALSE)
###################################################
## x11(type="cairo")
## plotAttrExpl(TEList, dens=TRUE, join=FALSE, log=FALSE, pool=TRUE)


###################################################
### code chunk number 48: TarSeqQC-vignette.Rnw:1208-1210 (eval = FALSE)
###################################################
## x11(type="cairo");
## plotPoolPerformance(TEList, dens=TRUE, join=FALSE, log=FALSE)


###################################################
### code chunk number 49: TarSeqQC-vignette.Rnw:1252-1254 (eval = FALSE)
###################################################
## plot(TEList, attributeThres = attributeThres, sampleLabs = TRUE,
##     featureLabs = TRUE)


###################################################
### code chunk number 50: TarSeqQC-vignette.Rnw:1277-1278
###################################################
getLowCtsFeatures(TEList, level="feature", threshold=50)


###################################################
### code chunk number 51: TarSeqQC-vignette.Rnw:1288-1291 (eval = FALSE)
###################################################
## x11(type="cairo")
## plotGlobalAttrExpl(TEList, attributeThres=attributeThres, dens=FALSE,
##     pool=TRUE, featureLabs=FALSE)


###################################################
### code chunk number 52: filtering unmapped reads (eval = FALSE)
###################################################
## bedFile<-system.file("extdata", "mybed.bed", package="TarSeqQC", mustWork=TRUE)
## fastaFile<-system.file("extdata", "myfasta.fa", package="TarSeqQC",
##     mustWork=TRUE)
## bamFile<-system.file("extdata", "mybam.bam", package="TarSeqQC", mustWork=TRUE)
## flag<-scanBamFlag(isUnmappedQuery = FALSE)
## scanBamP<-ScanBamParam(flag=flag)
## myPanel<-TargetExperiment(bedFile, bamFile, fastaFile, feature="amplicon", 
##                         attribute="coverage", scanBamP=scanBamP,BPPARAM=BPPARAM)
## 


###################################################
### code chunk number 53: loading TarSeqQC example data
###################################################
data(ampliPanel, package="TarSeqQC")
ampliPanel


###################################################
### code chunk number 54: using TarSeqQC example data (eval = FALSE)
###################################################
## 
## setBamFile(ampliPanel)<-system.file("extdata", "mybam.bam", package="TarSeqQC",
##                                     mustWork=TRUE)
## setFastaFile(ampliPanel)<-system.file("extdata", "myfasta.fa", 
##                                     package="TarSeqQC", mustWork=TRUE)


###################################################
### code chunk number 55: buildFeaturePanel using TarSeqQC example data (eval = FALSE)
###################################################
## plotFeature(ampliPanel, featureID="AMPL1")


###################################################
### code chunk number 56: Session Info
###################################################
sessionInfo()


