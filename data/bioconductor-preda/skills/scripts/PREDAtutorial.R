# Code example from 'PREDAtutorial' vignette. See references/ for full tutorial.

### R code from vignette source 'PREDAtutorial.Rnw'

###################################################
### code chunk number 1: PREDAtutorial.Rnw:128-131
###################################################
options(width=60)
require("PREDAsampledata")
require("PREDA")


###################################################
### code chunk number 2: PREDAtutorial.Rnw:134-136 (eval = FALSE)
###################################################
## require("PREDAsampledata")
## require("PREDA")


###################################################
### code chunk number 3: PREDAtutorial.Rnw:142-146
###################################################
# sample info file for the gene expression dataset
infofile <- system.file("sampledata", "GeneExpression", "sampleinfoGE_PREDA.txt", package = "PREDAsampledata")
sampleinfo<-read.table(infofile, sep="\t", header=TRUE)
head(sampleinfo)


###################################################
### code chunk number 4: PREDAtutorial.Rnw:153-154 (eval = FALSE)
###################################################
## data(AffybatchRCC)


###################################################
### code chunk number 5: PREDAtutorial.Rnw:159-160 (eval = FALSE)
###################################################
## CELfilesPath <- "/path/to/local/CEL/files/directory"


###################################################
### code chunk number 6: PREDAtutorial.Rnw:180-191 (eval = FALSE)
###################################################
## GEDataForPREDA<-preprocessingGE(SampleInfoFile=infofile,
## CELfiles_dir=CELfilesPath,
## custom_cdfname="hgu133plus2",
## arrayNameColumn=1,
## sampleNameColumn=2,
## classColumn="Class",
## referenceGroupLabel="normal",
## statisticType="tstatistic",
## optionalAnnotations=c("SYMBOL", "ENTREZID"),
## retain.chrs=1:22
## )


###################################################
### code chunk number 7: PREDAtutorial.Rnw:198-207 (eval = FALSE)
###################################################
## GEDataForPREDA<-preprocessingGE(
## AffyBatchInput=AffybatchRCC,
## custom_cdfname="hgu133plus2",
## classColumn="Class",
## referenceGroupLabel="normal",
## statisticType="tstatistic",
## optionalAnnotations=c("SYMBOL", "ENTREZID"),
## retain.chrs=1:22
## )


###################################################
### code chunk number 8: PREDAtutorial.Rnw:227-229 (eval = FALSE)
###################################################
## # generate ExpressionSet from raw  CEL files
## ExpressionSetRCC <-justRMA(filenames=sampleinfo[,"Arrayname"], celfile.path=CELfilesPath, sampleNames=sampleinfo[,"Samplename"], cdfname="hgu133plus2")


###################################################
### code chunk number 9: PREDAtutorial.Rnw:231-232
###################################################
data(ExpressionSetRCC)


###################################################
### code chunk number 10: PREDAtutorial.Rnw:237-240 (eval = FALSE)
###################################################
## AffybatchRCC@cdfName<-"hgu133plus2"
## annotation(AffybatchRCC)<-"hgu133plus2"
## ExpressionSetRCC <- rma(AffybatchRCC)


###################################################
### code chunk number 11: PREDAtutorial.Rnw:251-252
###################################################
GEstatisticsForPREDA<-statisticsForPREDAfromEset(ExpressionSetRCC, statisticType="tstatistic", referenceGroupLabel="normal", classVector=sampleinfo[,"Class"])


###################################################
### code chunk number 12: PREDAtutorial.Rnw:256-257
###################################################
analysesNames(GEstatisticsForPREDA)


###################################################
### code chunk number 13: PREDAtutorial.Rnw:278-279 (eval = FALSE)
###################################################
## GEGenomicAnnotations<-eset2GenomicAnnotations(ExpressionSetRCC, retain.chrs=1:22)


###################################################
### code chunk number 14: PREDAtutorial.Rnw:288-289 (eval = FALSE)
###################################################
## GEGenomicAnnotations<-GenomicAnnotationsFromLibrary(annotLibrary="org.Hs.eg.db", retain.chrs=1:22)


###################################################
### code chunk number 15: PREDAtutorial.Rnw:295-296 (eval = FALSE)
###################################################
## GEGenomicAnnotations<-GenomicAnnotationsFromLibrary(annotLibrary="hgu133plus2.db", retain.chrs=1:22, optionalAnnotations=c("SYMBOL", "ENTREZID"))


###################################################
### code chunk number 16: PREDAtutorial.Rnw:304-305 (eval = FALSE)
###################################################
## GEGenomicAnnotationsForPREDA<-GenomicAnnotations2GenomicAnnotationsForPREDA(GEGenomicAnnotations, reference_position_type="median")


###################################################
### code chunk number 17: PREDAtutorial.Rnw:315-316 (eval = FALSE)
###################################################
## GEDataForPREDA<-MergeStatisticAnnotations2DataForPREDA(GEstatisticsForPREDA, GEGenomicAnnotationsForPREDA, sortAndCleanNA=TRUE)


###################################################
### code chunk number 18: PREDAtutorial.Rnw:326-327 (eval = FALSE)
###################################################
## GEanalysisResults<-PREDA_main(GEDataForPREDA)


###################################################
### code chunk number 19: PREDAtutorial.Rnw:330-331
###################################################
data(GEanalysisResults)


###################################################
### code chunk number 20: PREDAtutorial.Rnw:360-362
###################################################
genomic_regions_UP<-PREDAResults2GenomicRegions(GEanalysisResults, qval.threshold=0.05, smoothStatistic.tail="upper", smoothStatistic.threshold=0.5)
genomic_regions_DOWN<-PREDAResults2GenomicRegions(GEanalysisResults, qval.threshold=0.05, smoothStatistic.tail="lower", smoothStatistic.threshold=(-0.5))


###################################################
### code chunk number 21: PREDAtutorial.Rnw:368-370
###################################################
dataframe_UPregions<-GenomicRegions2dataframe(genomic_regions_UP[[1]])
head(dataframe_UPregions)


###################################################
### code chunk number 22: genomePlot1 (eval = FALSE)
###################################################
## checkplot<-genomePlot(GEanalysisResults, genomicRegions=c(genomic_regions_UP, genomic_regions_DOWN), grouping=c(1, 1), scale.positions="Mb", region.colors=c("red","blue"))
## legend(x=140000000, y=22, legend=c("UP", "DOWN"), fill=c("red","blue"))


###################################################
### code chunk number 23: genomePlot1
###################################################
checkplot<-genomePlot(GEanalysisResults, genomicRegions=c(genomic_regions_UP, genomic_regions_DOWN), grouping=c(1, 1), scale.positions="Mb", region.colors=c("red","blue"))
legend(x=140000000, y=22, legend=c("UP", "DOWN"), fill=c("red","blue"))


###################################################
### code chunk number 24: genomePlot2 (eval = FALSE)
###################################################
## checkplot<-genomePlot(GEanalysisResults, genomicRegions=c(genomic_regions_UP, genomic_regions_DOWN), scale.positions="Mb", region.colors=c("red","blue"))


###################################################
### code chunk number 25: genomePlot2
###################################################
checkplot<-genomePlot(GEanalysisResults, genomicRegions=c(genomic_regions_UP, genomic_regions_DOWN), scale.positions="Mb", region.colors=c("red","blue"))


###################################################
### code chunk number 26: PREDAtutorial.Rnw:446-459 (eval = FALSE)
###################################################
## # preprocess raw data files
## SODEGIRGEDataForPREDA<-SODEGIRpreprocessingGE(
## SampleInfoFile=infofile,
## CELfiles_dir=CELfilesPath,
## custom_cdfname="hgu133plus2",
## arrayNameColumn=1,
## sampleNameColumn=2,
## classColumn="Class",
## referenceGroupLabel="normal",
## statisticType="tstatistic",
## optionalAnnotations=c("SYMBOL", "ENTREZID"),
## retain.chrs=1:22
## )


###################################################
### code chunk number 27: PREDAtutorial.Rnw:464-475 (eval = FALSE)
###################################################
## data(AffybatchRCC)
## # preprocess raw data files
## SODEGIRGEDataForPREDA<-SODEGIRpreprocessingGE(
## AffyBatchInput=AffybatchRCC,
## custom_cdfname="hgu133plus2",
## classColumn="Class",
## referenceGroupLabel="normal",
## statisticType="tstatistic",
## optionalAnnotations=c("SYMBOL", "ENTREZID"),
## retain.chrs=1:22
## )


###################################################
### code chunk number 28: PREDAtutorial.Rnw:478-479
###################################################
data(SODEGIRGEDataForPREDA)


###################################################
### code chunk number 29: PREDAtutorial.Rnw:485-487 (eval = FALSE)
###################################################
## # run PREDA analysis on GE data
## SODEGIRGEanalysisResults<-PREDA_main(SODEGIRGEDataForPREDA)


###################################################
### code chunk number 30: PREDAtutorial.Rnw:490-491
###################################################
data(SODEGIRGEanalysisResults)


###################################################
### code chunk number 31: PREDAtutorial.Rnw:496-498
###################################################
SODEGIR_GE_UP<-PREDAResults2GenomicRegions(SODEGIRGEanalysisResults, qval.threshold=0.05, smoothStatistic.tail="upper", smoothStatistic.threshold=0.5)
SODEGIR_GE_DOWN<-PREDAResults2GenomicRegions(SODEGIRGEanalysisResults, qval.threshold=0.05, smoothStatistic.tail="lower", smoothStatistic.threshold= -0.5)


###################################################
### code chunk number 32: genomePlotSODEGIRge1 (eval = FALSE)
###################################################
## # plot all the chromosomes for one sample
## checkplot<-genomePlot(SODEGIRGEanalysisResults, genomicRegions=c(SODEGIR_GE_UP[1], SODEGIR_GE_DOWN[1]), grouping=c(1,1), scale.positions="Mb", region.colors=c("red","blue"))
## title(paste("Sample", names(SODEGIR_GE_UP[1])))


###################################################
### code chunk number 33: genomePlotSODEGIRge1
###################################################
# plot all the chromosomes for one sample
checkplot<-genomePlot(SODEGIRGEanalysisResults, genomicRegions=c(SODEGIR_GE_UP[1], SODEGIR_GE_DOWN[1]), grouping=c(1,1), scale.positions="Mb", region.colors=c("red","blue"))
title(paste("Sample", names(SODEGIR_GE_UP[1])))


###################################################
### code chunk number 34: genomePlotSODEGIRge2 (eval = FALSE)
###################################################
## # plot chromosome 5 for all of the samples
## checkplot<-genomePlot(SODEGIRGEanalysisResults, genomicRegions=SODEGIR_GE_UP, scale.positions="Mb", region.colors=rep("red", times=length(SODEGIR_GE_UP)), limitChrs=5, custom.labels=names(SODEGIR_GE_UP))


###################################################
### code chunk number 35: genomePlotSODEGIRge2
###################################################
# plot chromosome 5 for all of the samples
checkplot<-genomePlot(SODEGIRGEanalysisResults, genomicRegions=SODEGIR_GE_UP, scale.positions="Mb", region.colors=rep("red", times=length(SODEGIR_GE_UP)), limitChrs=5, custom.labels=names(SODEGIR_GE_UP))


###################################################
### code chunk number 36: PREDAtutorial.Rnw:550-554 (eval = FALSE)
###################################################
## # path to copy number data files
## CNdataPath <- system.file("sampledata", "CopyNumber", package = "PREDAsampledata")
## CNdataFile <- file.path(CNdataPath , "CNAG_data_PREDA.txt")
## CNannotationFile <- file.path(CNdataPath , "SNPAnnot100k.csv")


###################################################
### code chunk number 37: PREDAtutorial.Rnw:560-562 (eval = FALSE)
###################################################
## # read copy number data from file
## CNStatisticsForPREDA<-StatisticsForPREDAFromfile(file=CNdataFile, ids_column="AffymetrixSNPsID", testedTail="both", sep="\t", header=TRUE)


###################################################
### code chunk number 38: PREDAtutorial.Rnw:567-578 (eval = FALSE)
###################################################
## # read genomic annotations
## CNGenomicsAnnotationsForPREDA<-GenomicAnnotationsForPREDAFromfile(
## file=CNannotationFile,
## ids_column=1,
## chr_column="Chromosome",
## start_column=4,
## end_column=4,
## strand_column="Strand",
## chromosomesLabelsInput=1:22,
## MinusStrandString="-", PlusStrandString="+", optionalAnnotationsColumns=c("Cytoband", "Entrez_gene"),
## header=TRUE, sep=",", quote="\"", na.strings = c("NA", "", "---"))


###################################################
### code chunk number 39: PREDAtutorial.Rnw:583-585 (eval = FALSE)
###################################################
## # merge data and annotations
## SODEGIRCNDataForPREDA<-MergeStatisticAnnotations2DataForPREDA(CNStatisticsForPREDA, CNGenomicsAnnotationsForPREDA, sortAndCleanNA=TRUE, quiet=FALSE, MedianCenter=TRUE)


###################################################
### code chunk number 40: PREDAtutorial.Rnw:590-592 (eval = FALSE)
###################################################
## # run preda analysis
## SODEGIRCNanalysisResults<-PREDA_main(SODEGIRCNDataForPREDA, outputGenomicAnnotationsForPREDA=SODEGIRGEDataForPREDA)


###################################################
### code chunk number 41: PREDAtutorial.Rnw:595-596
###################################################
data(SODEGIRCNanalysisResults)


###################################################
### code chunk number 42: PREDAtutorial.Rnw:601-603
###################################################
SODEGIR_CN_GAIN<-PREDAResults2GenomicRegions(SODEGIRCNanalysisResults, qval.threshold=0.01, smoothStatistic.tail="upper", smoothStatistic.threshold=0.1)
SODEGIR_CN_LOSS<-PREDAResults2GenomicRegions(SODEGIRCNanalysisResults, qval.threshold=0.01, smoothStatistic.tail="lower", smoothStatistic.threshold= -0.1)


###################################################
### code chunk number 43: genomePlotSODEGIRcn1 (eval = FALSE)
###################################################
## # plot chromosome 5 for all of the samples
## checkplot<-genomePlot(SODEGIRGEanalysisResults, genomicRegions=SODEGIR_CN_GAIN, scale.positions="Mb", region.colors=rep("red", times=length(SODEGIR_CN_GAIN)), limitChrs=5, custom.labels=names(SODEGIR_CN_GAIN))


###################################################
### code chunk number 44: genomePlotSODEGIRcn1
###################################################
# plot chromosome 5 for all of the samples
checkplot<-genomePlot(SODEGIRGEanalysisResults, genomicRegions=SODEGIR_CN_GAIN, scale.positions="Mb", region.colors=rep("red", times=length(SODEGIR_CN_GAIN)), limitChrs=5, custom.labels=names(SODEGIR_CN_GAIN))


###################################################
### code chunk number 45: PREDAtutorial.Rnw:628-631
###################################################
analysesNames(SODEGIRCNanalysisResults)
analysesNames(SODEGIRGEanalysisResults)
all(analysesNames(SODEGIRCNanalysisResults) == analysesNames(SODEGIRGEanalysisResults))


###################################################
### code chunk number 46: PREDAtutorial.Rnw:636-641
###################################################
SODEGIR_AMPLIFIED<-GenomicRegionsFindOverlap(SODEGIR_GE_UP, SODEGIR_CN_GAIN)
SODEGIR_DELETED<-GenomicRegionsFindOverlap(SODEGIR_GE_DOWN, SODEGIR_CN_LOSS)

names(SODEGIR_AMPLIFIED)<-names(SODEGIR_GE_UP)
names(SODEGIR_DELETED)<-names(SODEGIR_GE_DOWN)


###################################################
### code chunk number 47: genomePlotSODEGIR1 (eval = FALSE)
###################################################
## # plot chromosome 5 for all of the samples
## checkplot<-genomePlot(SODEGIRGEanalysisResults, genomicRegions=SODEGIR_AMPLIFIED, scale.positions="Mb", region.colors=rep("red", times=length(SODEGIR_AMPLIFIED)), limitChrs=5, custom.labels=names(SODEGIR_AMPLIFIED))


###################################################
### code chunk number 48: genomePlotSODEGIR1
###################################################
# plot chromosome 5 for all of the samples
checkplot<-genomePlot(SODEGIRGEanalysisResults, genomicRegions=SODEGIR_AMPLIFIED, scale.positions="Mb", region.colors=rep("red", times=length(SODEGIR_AMPLIFIED)), limitChrs=5, custom.labels=names(SODEGIR_AMPLIFIED))


###################################################
### code chunk number 49: PREDAtutorial.Rnw:667-672
###################################################
# plot all regions from one sample
  regions_forPlot<-c(
  SODEGIR_GE_UP[[1]],SODEGIR_CN_GAIN[[1]],SODEGIR_AMPLIFIED[[1]],
  SODEGIR_GE_DOWN[[1]],SODEGIR_CN_LOSS[[1]],SODEGIR_DELETED[[1]]
  )


###################################################
### code chunk number 50: genomePlotSODEGIR2 (eval = FALSE)
###################################################
## checkplot<-genomePlot(SODEGIRGEanalysisResults, genomicRegions=regions_forPlot, grouping=c(1:3, 1:3), scale.positions="Mb", region.colors=c("red","red2","red4","blue","blue2","blue4"))
## legend(x=140000000, y=22*3, legend=c("GeneExpression UP","CopyNumber gain","SODEGIR amplified","GeneExpression DOWN","CopyNumber loss","SODEGIR deleted"), fill=c("red","red2","red4","blue","blue2","blue4"))
## title(paste("Sample",names(SODEGIR_GE_UP[[1]])))


###################################################
### code chunk number 51: genomePlotSODEGIR2
###################################################
checkplot<-genomePlot(SODEGIRGEanalysisResults, genomicRegions=regions_forPlot, grouping=c(1:3, 1:3), scale.positions="Mb", region.colors=c("red","red2","red4","blue","blue2","blue4"))
legend(x=140000000, y=22*3, legend=c("GeneExpression UP","CopyNumber gain","SODEGIR amplified","GeneExpression DOWN","CopyNumber loss","SODEGIR deleted"), fill=c("red","red2","red4","blue","blue2","blue4"))
title(paste("Sample",names(SODEGIR_GE_UP[[1]])))


###################################################
### code chunk number 52: PREDAtutorial.Rnw:701-703
###################################################
SDGsignature_amplified<-computeDatasetSignature(SODEGIRGEDataForPREDA, genomicRegionsList=SODEGIR_AMPLIFIED)
SDGsignature_deleted<-computeDatasetSignature(SODEGIRGEDataForPREDA, genomicRegionsList=SODEGIR_DELETED)


###################################################
### code chunk number 53: genomePlotSODEGIRsignature (eval = FALSE)
###################################################
## # dataset signature
## checkplot<-genomePlot(SODEGIRGEanalysisResults, genomicRegions=c(SDGsignature_amplified, SDGsignature_deleted), grouping=c(1,1), scale.positions="Mb", region.colors=c("red","blue"))


###################################################
### code chunk number 54: genomePlotSODEGIRsignature
###################################################
# dataset signature
checkplot<-genomePlot(SODEGIRGEanalysisResults, genomicRegions=c(SDGsignature_amplified, SDGsignature_deleted), grouping=c(1,1), scale.positions="Mb", region.colors=c("red","blue"))


###################################################
### code chunk number 55: PREDAtutorial.Rnw:727-729
###################################################
GenomicRegions2dataframe(SDGsignature_amplified[[1]])
GenomicRegions2dataframe(SDGsignature_deleted[[1]])


