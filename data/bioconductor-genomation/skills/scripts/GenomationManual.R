# Code example from 'GenomationManual' vignette. See references/ for full tutorial.

## ----setup2, include=FALSE, cache=FALSE, eval=TRUE----------------------------
library(knitr)
opts_chunk$set(root.dir=getwd(),fig.align='center',
               fig.path='Figures', 
               dev='png',
               fig.show='hold', 
               cache=FALSE)
library(genomation)
library(genomationData)
library(GenomicRanges)
set.seed=10

## ----echo=FALSE,warnings=FALSE,out.width=500----------------------------------

knitr::include_graphics("https://raw.githubusercontent.com/BIMSBbioinfo/genomation/master/vignettes/Figures/genomationFlowChart1.png")

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install('genomationData')
# BiocManager::install('genomation')

## ----listgenomationData, eval=TRUE--------------------------------------------
list.files(system.file('extdata',package='genomationData'))

## ----genomationDataInfo, eval=TRUE, tidy=TRUE---------------------------------
sampleInfo = read.table(system.file('extdata/SamplesInfo.txt',
                                    package='genomationData'),header=TRUE, sep='\t')
sampleInfo[1:5,1:5]

## ----genomationInfo, eval=FALSE, tidy=TRUE------------------------------------
# library(genomation)
# data(cage)
# data(cpgi)
# 
# list.files(system.file('extdata', package='genomation'))

## ----readGeneric1, eval=TRUE, tidy=TRUE---------------------------------------
library(genomation)
tab.file1=system.file("extdata/tab1.bed", package = "genomation")
readGeneric(tab.file1, header=TRUE)

## ----readGeneric2, eval=TRUE, tidy=TRUE---------------------------------------
readGeneric(tab.file1, header=TRUE, keep.all.metadata=TRUE)

readGeneric(tab.file1, header=TRUE, meta.col = list(CpGnum=4))

## ----readGeneric3, eval=TRUE, tidy=TRUE---------------------------------------
readGeneric(tab.file1, header=TRUE, keep.all.metadata=TRUE)

## ----readGeneric4, eval=TRUE, tidy=TRUE---------------------------------------
tab.file2=system.file("extdata/tab2.bed", package = "genomation")
readGeneric(tab.file2, chr=3, start=2, end=1)

## ----readGff1, eval=TRUE, tidy=TRUE-------------------------------------------
gff.file=system.file("extdata/chr21.refseq.hg19.gtf", package = "genomation")
gff = gffToGRanges(gff.file)
head(gff)

## ----readGff2, eval=FALSE, tidy=TRUE------------------------------------------
# gff = gffToGRanges(gff.file, split.group=TRUE)
# head(gff)

## ----readFeatureFlank, eval=TRUE, tidy=TRUE-----------------------------------
# reading genes stored as a BED files
cpgi.file = system.file("extdata/chr21.CpGi.hg19.bed", package = "genomation")
cpgi.flanks = readFeatureFlank(cpgi.file)
head(cpgi.flanks$flanks)

## ----ScoreMatrixExample, eval=TRUE, tidy=TRUE---------------------------------
data(cage)
data(promoters)
sm = ScoreMatrix(target=cage, windows=promoters)
sm

## ----ScoreMatrixBinExample, eval=FALSE, tidy=TRUE-----------------------------
# data(cage)
# gff.file = system.file('extdata/chr21.refseq.hg19.gtf', package="genomation")
# exons = gffToGRanges(gff.file, filter='exon')
# sm = ScoreMatrixBin(target=cage, windows=exons, bin.num=50)
# sm

## ----ScoreMatrixBinExample_GRangesList, eval=FALSE, tidy=TRUE-----------------
# data(cage)
# library(GenomicRanges)
# gff.file = system.file('extdata/chr21.refseq.hg19.gtf', package="genomation")
# exons = gffToGRanges(gff.file, filter="exon")
# transcripts = split(exons, exons$transcript_id)
# sm = ScoreMatrixBin(target=cage, windows=transcripts, bin.num=10)
# sm

## ----ScoreMatrixList, eval=TRUE, tidy=TRUE------------------------------------
data(promoters)
data(cpgi)
data(cage)

cage$tpm = NULL
targets = list(cage=cage, cpgi=cpgi)
sm = ScoreMatrixList(targets=targets, windows=promoters, bin.num=50)
sm

## ----heatMatrix1, eval=FALSE, tidy=TRUE,  fig.keep='all'----------------------
# data(cage)
# data(promoters)
# sm = ScoreMatrix(target=cage, windows=promoters)
# 
# heatMatrix(sm, xcoords=c(-1000, 1000))
# plotMeta(sm, xcoords=c(-1000, 1000))

## ----echo=FALSE,out.width="300px",fig.align='default'-------------------------
knitr::include_graphics(c("https://raw.githubusercontent.com/BIMSBbioinfo/genomation/master/vignettes/Figures/heatMatrix1-1.png",
                          "https://raw.githubusercontent.com/BIMSBbioinfo/genomation/master/vignettes/Figures/heatMatrix1-2.png"),dpi=30)

## ----heatMatrix2, eval=FALSE, tidy=TRUE, fig.width=4, fig.height=3------------
# library(GenomicRanges)
# data(cage)
# data(promoters)
# data(cpgi)
# 
# sm = ScoreMatrix(target=cage, windows=promoters, strand.aware=TRUE)
# cpg.ind = which(countOverlaps(promoters, cpgi)>0)
# nocpg.ind = which(countOverlaps(promoters, cpgi)==0)
# heatMatrix(sm, xcoords=c(-1000, 1000), group=list(CpGi=cpg.ind, noCpGi=nocpg.ind))

## ----echo=FALSE,out.width="400px"---------------------------------------------
knitr::include_graphics("https://raw.githubusercontent.com/BIMSBbioinfo/genomation/master/vignettes/Figures/heatMatrix2-1.png")

## ----heatMatrixScales, eval=FALSE, tidy=TRUE, echo=TRUE, fig.width=4, fig.height=3, dpi=300----
# sm.scaled = scaleScoreMatrix(sm)
# heatMatrix(sm.scaled, xcoords=c(-1000, 1000), group=list(CpGi=cpg.ind, noCpGi=nocpg.ind))

## ----echo=FALSE,out.width="400px"---------------------------------------------
knitr::include_graphics("https://raw.githubusercontent.com/BIMSBbioinfo/genomation/master/vignettes/Figures/heatMatrixScales-1.png")

## ----multiHeatMatrix1, eval=FALSE, tidy=TRUE, fig.width=4.5, fig.height=3, dpi=300----
# cage$tpm = NULL
# targets = list(cage=cage, cpgi=cpgi)
# sml = ScoreMatrixList(targets=targets, windows=promoters, bin.num=50, strand.aware=TRUE)
# multiHeatMatrix(sml, xcoords=c(-1000, 1000))

## ----echo=FALSE,out.width="400px"---------------------------------------------
knitr::include_graphics("https://raw.githubusercontent.com/BIMSBbioinfo/genomation/master/vignettes/Figures/multiHeatMatrix1-1.png")

## ----multiHeatMatrix2, eval=FALSE, tidy=TRUE, fig.width=4.5, fig.height=3, dpi=300----
# multiHeatMatrix(sml, xcoords=c(-1000, 1000), clustfun=function(x) kmeans(x, centers=2)$cluster)

## ----echo=FALSE,out.width="400px"---------------------------------------------
knitr::include_graphics("https://raw.githubusercontent.com/BIMSBbioinfo/genomation/master/vignettes/Figures/multiHeatMatrix2-1.png")

## ----getFiles_annotation, eval=TRUE, tidy=TRUE--------------------------------
library(genomationData)
genomationDataPath = system.file('extdata',package='genomationData')
sampleInfo = read.table(file.path(genomationDataPath, 'SamplesInfo.txt'), 
                        header=TRUE, sep='\t', stringsAsFactors=FALSE)

peak.files=list.files(genomationDataPath, full.names=TRUE, pattern='broadPeak')
names(peak.files) = sampleInfo$sampleName[match(basename(peak.files),sampleInfo$fileName)]

ctcf.peaks = readBroadPeak(peak.files['Ctcf'])

## ----readAllPeaks_annotation, eval=TRUE, tidy=TRUE----------------------------
data(cpgi)
peak.annot = annotateWithFeature(ctcf.peaks, cpgi, intersect.chr=TRUE)
peak.annot

## ----readTranscriptFeatures, eval=TRUE, tidy=TRUE-----------------------------
bed.file=system.file("extdata/chr21.refseq.hg19.bed", package = "genomation")
gene.parts = readTranscriptFeatures(bed.file)

## ----annotateCtcf, eval=TRUE, tidy=TRUE---------------------------------------
ctcf.annot=annotateWithGeneParts(ctcf.peaks, gene.parts, intersect.chr=TRUE)
ctcf.annot

## ----annotateTargetList, eval=TRUE, tidy=TRUE---------------------------------
peaks = GRangesList(lapply(peak.files, readGeneric))
names(peaks) = names(peak.files)
annot.list = annotateWithGeneParts(peaks, gene.parts, intersect.chr=TRUE)

## ----plotGeneAnnotation, eval=FALSE, tidy=TRUE, dpi=300-----------------------
# plotGeneAnnotation(annot.list)
# plotGeneAnnotation(annot.list, cluster=TRUE)

## ----echo=FALSE,out.width="300px",fig.align='default'-------------------------
knitr::include_graphics(c("https://raw.githubusercontent.com/BIMSBbioinfo/genomation/master/vignettes/Figures/plotGeneAnnotation-1.png",
                     "https://raw.githubusercontent.com/BIMSBbioinfo/genomation/master/vignettes/Figures/plotGeneAnnotation-2.png"     
                          ))

## ----selectBamChipseq, eval=TRUE, tidy=TRUE-----------------------------------
genomationDataPath = system.file('extdata',package='genomationData')
bam.files = list.files(genomationDataPath, full.names=TRUE, pattern='bam$')
bam.files = bam.files[!grepl('Cage', bam.files)]

## ----readCtcfPeaks, eval=TRUE, tidy=TRUE--------------------------------------
ctcf.peaks = readBroadPeak(file.path(genomationDataPath, 
                                     'wgEncodeBroadHistoneH1hescCtcfStdPk.broadPeak.gz'))
ctcf.peaks = ctcf.peaks[seqnames(ctcf.peaks) == 'chr21']
ctcf.peaks = ctcf.peaks[order(-ctcf.peaks$signalValue)]
ctcf.peaks = resize(ctcf.peaks, width=1000, fix='center')

## ----ctcfScoreMatrixList, eval=FALSE, tidy=TRUE, fig.width=5, fig.height=3.5, dpi=300----
# sml = ScoreMatrixList(bam.files, ctcf.peaks, bin.num=50, type='bam')
# sampleInfo = read.table(system.file('extdata/SamplesInfo.txt',
#                                     package='genomationData'),header=TRUE, sep='\t')
# names(sml) = sampleInfo$sampleName[match(names(sml),sampleInfo$fileName)]
# multiHeatMatrix(sml, xcoords=c(-500, 500), col=c('lightgray', 'blue'))

## ----echo=FALSE,out.width="350px",fig.cap="Heatmap profile of unscaled coverage shows a slight colocalization of Ctcf, Rad21 and Znf143."----
knitr::include_graphics(c("https://raw.githubusercontent.com/BIMSBbioinfo/genomation/master/vignettes/Figures/ctcfScoreMatrixList-1.png"     
                          ))

## ----plotScaledProfile, eval=FALSE, tidy=TRUE, fig.width=5, fig.height=3.5, dpi=300----
# sml.scaled = scaleScoreMatrixList(sml)
# multiHeatMatrix(sml.scaled, xcoords=c(-500, 500), col=c('lightgray', 'blue'))

## ----echo=FALSE,out.width="350px",fig.cap="Heatmap profile of scaled coverage shows much stronger colocalization   of the transcription factors; nevertheless, it is evident that some of the CTCF   peaks have a very weak enrichment"----
knitr::include_graphics(c("https://raw.githubusercontent.com/BIMSBbioinfo/genomation/master/vignettes/Figures/plotScaledProfile-1.png"     
                          ))

## ----eadAllPeaks, eval=TRUE, tidy=TRUE----------------------------------------
genomationDataPath = system.file('extdata',package='genomationData')
sampleInfo = read.table(file.path(genomationDataPath, 'SamplesInfo.txt'), 
                        header=TRUE, sep='\t', stringsAsFactors=FALSE)


peak.files = list.files(genomationDataPath, full.names=TRUE, pattern='Peak.gz$')
peaks = list()
for(i in 1:length(peak.files)){
  file = peak.files[i]
  name=sampleInfo$sampleName[match(basename(file),sampleInfo$fileName)]
  message(name)
  peaks[[name]] = readGeneric(file, meta.col=list(score=5))
}
peaks = GRangesList(peaks)
peaks = peaks[seqnames(peaks) == 'chr21' & width(peaks) < 1000  & width(peaks) > 100]

## ----findFeatureComb, eval=TRUE, tidy=TRUE------------------------------------
  tf.comb = findFeatureComb(peaks, width=1000)

## ----visualizeFeatureComb, eval=FALSE, tidy=TRUE, fig.width=5, fig.height=3, dpi=300----
#   tf.comb = tf.comb[order(tf.comb$class)]
#   bam.files = list.files(genomationDataPath, full.names=TRUE, pattern='bam$')
#   bam.files = bam.files[!grepl('Cage', bam.files)]
#   sml = ScoreMatrixList(bam.files, tf.comb, bin.num=20, type='bam')
#   names(sml) = sampleInfo$sampleName[match(names(sml),sampleInfo$fileName)]
#   sml.scaled = scaleScoreMatrixList(sml)
#   multiHeatMatrix(sml.scaled, xcoords=c(-500, 500), col=c('lightgray', 'blue'))

## ----echo=FALSE,out.width="350px"---------------------------------------------
knitr::include_graphics(c("https://raw.githubusercontent.com/BIMSBbioinfo/genomation/master/vignettes/Figures/visualizeFeatureComb-1.png"     
                          ))

## ----annotationHubExample1, eval=FALSE, tidy=TRUE-----------------------------
# library(AnnotationHub)
# ah = AnnotationHub()
# # retrieve CpG island data from annotationHub
# cpgi_query <- query(ah, c("CpG Islands", "UCSC", "hg19"))
# cpgi <- ah[[names(cpgi_query)]]
# dnase_query <- query(ah, c("wgEncodeOpenChromDnase8988tPk.narrowPeak.gz", "UCSC", "hg19"))
# dnaseP <- ah[[names(dnase_query)]]
# sm = ScoreMatrixBin(target=dnaseP, windows=cpgi, strand.aware=FALSE)

## -----------------------------------------------------------------------------
sessionInfo()

