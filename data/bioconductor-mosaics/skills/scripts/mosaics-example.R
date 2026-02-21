# Code example from 'mosaics-example' vignette. See references/ for full tutorial.

### R code from vignette source 'mosaics-example.Rnw'

###################################################
### code chunk number 1: preliminaries
###################################################
options(prompt = "R> ")


###################################################
### code chunk number 2: mosaics-prelim
###################################################
library("mosaics")


###################################################
### code chunk number 3: mosaicsExample-prelim
###################################################
library("mosaicsExample")


###################################################
### code chunk number 4: constructBins
###################################################
constructBins( infile=system.file( file.path("extdata","wgEncodeSydhTfbsGm12878Stat1StdAlnRep1_chr22_sorted.bam"), package="mosaicsExample"), 
    fileFormat="bam", outfileLoc="./", 
    byChr=FALSE, useChrfile=FALSE, chrfile=NULL, excludeChr=NULL, 
    PET=FALSE, fragLen=200, binSize=200, capping=0 )
constructBins( infile=system.file( file.path("extdata","wgEncodeSydhTfbsGm12878InputStdAlnRep1_chr22_sorted.bam"), package="mosaicsExample"), 
    fileFormat="bam", outfileLoc="./", 
    byChr=FALSE, useChrfile=FALSE, chrfile=NULL, excludeChr=NULL, 
    PET=FALSE, fragLen=200, binSize=200, capping=0 )


###################################################
### code chunk number 5: io-readbin
###################################################
fileName <- c(
    "wgEncodeSydhTfbsGm12878Stat1StdAlnRep1_chr22_sorted.bam_fragL200_bin200.txt",
    "wgEncodeSydhTfbsGm12878InputStdAlnRep1_chr22_sorted.bam_fragL200_bin200.txt")

binTFBS <- readBins( type=c("chip","input"), fileName=fileName )


###################################################
### code chunk number 6: io-bindata-show
###################################################
binTFBS


###################################################
### code chunk number 7: io-bindata-print
###################################################
print(binTFBS)[ 90600:90614, ]


###################################################
### code chunk number 8: io-bindata-plot (eval = FALSE)
###################################################
## plot( binTFBS )
## plot( binTFBS, plotType="input" )


###################################################
### code chunk number 9: fig-bindata-plot-hist
###################################################
plot(binTFBS)


###################################################
### code chunk number 10: fig-bindata-plot-input
###################################################
plot( binTFBS, plotType="input" )


###################################################
### code chunk number 11: io-mosaicsfit
###################################################
fitTFBS <- mosaicsFit( binTFBS, analysisType="IO", bgEst="rMOM" )


###################################################
### code chunk number 12: io-mosaicsfit-show
###################################################
fitTFBS


###################################################
### code chunk number 13: io-mosaicsfit-plot (eval = FALSE)
###################################################
## plot(fitTFBS)


###################################################
### code chunk number 14: fig-mosaicsfit-plot
###################################################
plot(fitTFBS)


###################################################
### code chunk number 15: ts-mosaicspeak
###################################################
peakTFBS <- mosaicsPeak( fitTFBS, signalModel="2S", FDR=0.05, 
maxgap=200, minsize=50, thres=10 )


###################################################
### code chunk number 16: io-mosaicspeak-show
###################################################
peakTFBS


###################################################
### code chunk number 17: io-mosaicspeak-print
###################################################
head(print(peakTFBS))


###################################################
### code chunk number 18: io-mosaicspeak-export (eval = FALSE)
###################################################
## export( peakTFBS, type="txt", filename="peakTFBS.txt" )
## export( peakTFBS, type="bed", filename="peakTFBS.bed" )
## export( peakTFBS, type="gff", filename="peakTFBS.gff" )
## export( peakTFBS, type="narrowPeak", filename="peakTFBS.narrowPeak" )
## export( peakTFBS, type="broadPeak", filename="peakTFBS.broadPeak" )


###################################################
### code chunk number 19: generateWig
###################################################
generateWig( infile=system.file( file.path("extdata","wgEncodeSydhTfbsGm12878Stat1StdAlnRep1_chr22_sorted.bam"), package="mosaicsExample"), 
    fileFormat="bam", outfileLoc="./", 
    byChr=FALSE, useChrfile=FALSE, chrfile=NULL, excludeChr=NULL, 
    PET=FALSE, fragLen=200, span=200, capping=0, normConst=1 )


###################################################
### code chunk number 20: mosaicsFitHMM-pre
###################################################
constructBins( infile=system.file( file.path("extdata","wgEncodeBroadHistoneGm12878H3k4me3StdAlnRep1_chr22_sorted.bam"), package="mosaicsExample"), 
    fileFormat="bam", outfileLoc="./", 
    byChr=FALSE, useChrfile=FALSE, chrfile=NULL, excludeChr=NULL, 
    PET=FALSE, fragLen=200, binSize=200, capping=0 )
constructBins( infile=system.file( file.path("extdata","wgEncodeBroadHistoneGm12878ControlStdAlnRep1_chr22_sorted.bam"), package="mosaicsExample"), 
    fileFormat="bam", outfileLoc="./", 
    byChr=FALSE, useChrfile=FALSE, chrfile=NULL, excludeChr=NULL, 
    PET=FALSE, fragLen=200, binSize=200, capping=0 )

fileName <- c(
    "wgEncodeBroadHistoneGm12878H3k4me3StdAlnRep1_chr22_sorted.bam_fragL200_bin200.txt",
    "wgEncodeBroadHistoneGm12878ControlStdAlnRep1_chr22_sorted.bam_fragL200_bin200.txt")

binHM <- readBins( type=c("chip","input"), fileName=fileName)
fitHM <- mosaicsFit( binHM, analysisType="IO", bgEst="rMOM" )


###################################################
### code chunk number 21: mosaicsFitHMM
###################################################
hmmHM <- mosaicsFitHMM( fitHM, signalModel = "2S", 
	init="mosaics", init.FDR = 0.05, parallel=FALSE, nCore=8 )


###################################################
### code chunk number 22: mosaicshmmfit-show
###################################################
hmmHM


###################################################
### code chunk number 23: mosaicshmmfit-plot (eval = FALSE)
###################################################
## plot(hmmHM)


###################################################
### code chunk number 24: fig-mosaicshmmfit-plot
###################################################
plot(hmmHM)


###################################################
### code chunk number 25: mosaicsPeakHMM
###################################################
peakHM <- mosaicsPeakHMM( hmmHM, FDR = 0.05, decoding="posterior",
  thres=10, parallel=FALSE, nCore=8 )


###################################################
### code chunk number 26: summit-extractreads
###################################################
peakHM <- extractReads( peakHM,
  chipFile=system.file( file.path("extdata","wgEncodeBroadHistoneGm12878H3k4me3StdAlnRep1_chr22_sorted.bam"), package="mosaicsExample"),
  chipFileFormat="bam", chipPET=FALSE, chipFragLen=200,
  controlFile=system.file( file.path("extdata","wgEncodeBroadHistoneGm12878ControlStdAlnRep1_chr22_sorted.bam"), package="mosaicsExample"), 
  controlFileFormat="bam", controlPET=FALSE, controlFragLen=200, parallel=FALSE, nCore=8 )
peakHM


###################################################
### code chunk number 27: summit-findsummit
###################################################
peakHM <- findSummit( peakHM, parallel=FALSE, nCore=8 )


###################################################
### code chunk number 28: summit-findsummit-print
###################################################
head(print(peakHM))


###################################################
### code chunk number 29: postprocess-adjustboundary
###################################################
peakHM <- adjustBoundary( peakHM, parallel=FALSE, nCore=8 )
peakHM
head(print(peakHM))


###################################################
### code chunk number 30: postprocess-filterpeak
###################################################
peakHM <- filterPeak( peakHM, parallel=FALSE, nCore=8 )
peakHM
head(print(peakHM))


###################################################
### code chunk number 31: summit-findsummit-plot (eval = FALSE)
###################################################
## plot( peakHM, filename="./peakplot.pdf" )


###################################################
### code chunk number 32: summit-findsummit-plot-peaknum-print
###################################################
print(peakHM)[8,]
print(peakTFBS)[18,]


###################################################
### code chunk number 33: summit-findsummit-plot-peaknum (eval = FALSE)
###################################################
## plot( peakHM, peakNum=8 )


###################################################
### code chunk number 34: fig-summit-findsummit-plot-peaknum-hm
###################################################
plot( peakHM, peakNum=8 )


###################################################
### code chunk number 35: mosaicsRunAll (eval = FALSE)
###################################################
##      mosaicsRunAll( 
##          chipFile="/scratch/eland/STAT1_ChIP_eland_results.txt", 
##          chipFileFormat="eland_result", 
##          controlFile="/scratch/eland/STAT1_control_eland_results.txt", 
##          controlFileFormat="eland_result", 
##          binfileDir="/scratch/bin/", 
##          peakFile=c("/scratch/peak/STAT1_peak_list.bed", 
##                     "/scratch/peak/STAT1_peak_list.gff"),
##          peakFileFormat=c("bed", "gff"),
##          reportSummary=TRUE, 
##          summaryFile="/scratch/reports/mosaics_summary.txt", 
##          reportExploratory=TRUE, 
##          exploratoryFile="/scratch/reports/mosaics_exploratory.pdf", 
##          reportGOF=TRUE, 
##          gofFile="/scratch/reports/mosaics_GOF.pdf",
##          byChr=FALSE, useChrfile=FALSE, chrfile=NULL, excludeChr="chrM",
##          PET=FALSE, FDR=0.05, fragLen=200, binSize=fragLen, capping=0,
##          bgEst="rMOM", signalModel="BIC", parallel=TRUE, nCore=8 )


###################################################
### code chunk number 36: ts-readbin
###################################################
exampleBinData <- readBins( type=c("chip","input","M","GC","N"),
    fileName=c( system.file( file.path("extdata","chip_chr21.txt"), package="mosaicsExample"),
    system.file( file.path("extdata","input_chr21.txt"), package="mosaicsExample"),
    system.file( file.path("extdata","M_chr21.txt"), package="mosaicsExample"),
    system.file( file.path("extdata","GC_chr21.txt"), package="mosaicsExample"),
    system.file( file.path("extdata","N_chr21.txt"), package="mosaicsExample") ) )


###################################################
### code chunk number 37: ts-bindata-plot
###################################################
plot( exampleBinData, plotType="M" )
plot( exampleBinData, plotType="GC" )
plot( exampleBinData, plotType="M|input" )
plot( exampleBinData, plotType="GC|input" )  


###################################################
### code chunk number 38: fig-bindata-plot-M
###################################################
plot( exampleBinData, plotType="M" )


###################################################
### code chunk number 39: fig-bindata-plot-GC
###################################################
plot( exampleBinData, plotType="GC" )


###################################################
### code chunk number 40: fig-bindata-plot-M-input
###################################################
plot( exampleBinData, plotType="M|input" )


###################################################
### code chunk number 41: fig-bindata-plot-GC-input
###################################################
plot( exampleBinData, plotType="GC|input" )


###################################################
### code chunk number 42: ts-mosaicsfit (eval = FALSE)
###################################################
## exampleFit <- mosaicsFit( exampleBinData, analysisType="TS", bgEst="automatic" )


###################################################
### code chunk number 43: os-mosaicspeak (eval = FALSE)
###################################################
## OneSamplePeak <- mosaicsPeak( OneSampleFit, signalModel="2S", FDR=0.05,
## maxgap=200, minsize=50, thres=10 )


###################################################
### code chunk number 44: os-readbin (eval = FALSE)
###################################################
## exampleBinData <- readBins( type=c("chip","M","GC","N"),
##     fileName=c( system.file( file.path("extdata","chip_chr21.txt"), package="mosaicsExample"),
##     system.file( file.path("extdata","M_chr21.txt"), package="mosaicsExample"),
##     system.file( file.path("extdata","GC_chr21.txt"), package="mosaicsExample"),
##     system.file( file.path("extdata","N_chr21.txt"), package="mosaicsExample") ) )


###################################################
### code chunk number 45: os-mosaicsfit (eval = FALSE)
###################################################
## exampleFit <- mosaicsFit( exampleBinData, analysisType="OS", bgEst="automatic" )


###################################################
### code chunk number 46: os-mosaicspeak (eval = FALSE)
###################################################
## examplePeak <- mosaicsPeak( exampleFit, signalModel="2S", FDR=0.05,
## maxgap=200, minsize=50, thres=10 )


###################################################
### code chunk number 47: tuning-case1 (eval = FALSE)
###################################################
## exampleFit <- mosaicsFit( exampleBinData, analysisType="IO", bgEst="rMOM" )


###################################################
### code chunk number 48: tuning-case2 (eval = FALSE)
###################################################
## exampleFit <- mosaicsFit( exampleBinData, analysisType="IO", 
## 	bgEst="automatic", truncProb=0.80 )


