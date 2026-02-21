# Code example from 'AneuFinder' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----options, results='hide', message=FALSE, eval=TRUE, echo=FALSE----------------------
library(AneuFinder)
options(width=90)

## ----eval=FALSE-------------------------------------------------------------------------
#  library(AneuFinder)
#  Aneufinder(inputfolder='folder-with-BAM-or-BED', outputfolder='output-directory',
#             numCPU=2, method=c('edivisive', 'dnacopy','HMM'))

## ----eval=TRUE--------------------------------------------------------------------------
?Aneufinder

## ----eval=FALSE-------------------------------------------------------------------------
#  Aneufinder(..., configfile='AneuFinder.config')

## ----eval=FALSE-------------------------------------------------------------------------
#  files <- list.files('output-directory/binned', full.names=TRUE)
#  binned.data <- loadFromFiles(files)

## ----eval=FALSE-------------------------------------------------------------------------
#  files <- list.files('output-directory/MODELS/method-edivisive', full.names=TRUE)
#  hmms <- loadFromFiles(files)
#  cl <- clusterByQuality(hmms)
#  heatmapGenomewide(cl$classification[[1]])

## ----eval=FALSE, message=FALSE, warning=FALSE-------------------------------------------
#  library(AneuFinder)
#  
#  ## Load human genome
#  library(BSgenome.Hsapiens.UCSC.hg19)
#  
#  ## Get a BAM file for the estimation of quality scores (adjust this to your experiment)
#  bamfile <- system.file("extdata", "BB150803_IV_074.bam", package="AneuFinderData")
#  
#  ## Simulate reads of length 51bp for human genome
#  # We simulate reads every 500000bp for demonstration purposes, for a real
#  # application you should use a much denser spacing (e.g. 500bp or less)
#  simulatedReads.file <- tempfile() # replace this with your destination file
#  simulateReads(BSgenome.Hsapiens.UCSC.hg19, readLength=51, bamfile=bamfile,
#                file=simulatedReads.file, every.X.bp=500000)

## ----eval=TRUE, warning=FALSE, message=FALSE, fig.width=9.5, fig.height=4, out.width='\\textwidth'----
library(AneuFinder)

## Get a euploid reference (adjust this to your experiment)
bedfile <- system.file("extdata", "hg19_diploid.bam.bed.gz", package="AneuFinderData")

## Make 100kb fixed-width bins
bins <- binReads(bedfile, assembly='hg19', binsizes=100e3,
                 chromosomes=c(1:22,'X'))[[1]]
## Make a plot for visual inspection and get the blacklist
lcutoff <- quantile(bins$counts, 0.05)
ucutoff <- quantile(bins$counts, 0.999)
p <- plot(bins) + coord_cartesian(ylim=c(0,50))
p <- p + geom_hline(aes(yintercept=lcutoff), color='red')
p <- p + geom_hline(aes(yintercept=ucutoff), color='red')
print(p)
## Select regions that are above or below the cutoff as blacklist
blacklist <- bins[bins$counts <= lcutoff | bins$counts >= ucutoff]
blacklist <- reduce(blacklist)
## Write blacklist to file
blacklist.file <- tempfile()
exportGRanges(blacklist, filename=blacklist.file, header=FALSE,
              chromosome.format='NCBI')

## ----eval=TRUE, message=FALSE-----------------------------------------------------------
library(AneuFinder)

## First, get some data and reference files (adjust this to your experiment)
var.width.ref <- system.file("extdata", "hg19_diploid.bam.bed.gz", package="AneuFinderData")
blacklist <- system.file("extdata", "blacklist-hg19.bed.gz", package="AneuFinderData")
datafolder <- system.file("extdata", "B-ALL-B", package = "AneuFinderData")
list.files(datafolder) # only 3 cells for demonstration purposes

## Library for GC correction
library(BSgenome.Hsapiens.UCSC.hg19)

## Produce output files
outputfolder <- tempdir()
Aneufinder(inputfolder = datafolder, outputfolder = outputfolder, assembly = 'hg19',
           numCPU = 3, binsizes = c(5e5, 1e6), variable.width.reference = var.width.ref,
           chromosomes = c(1:22,'X','Y'), blacklist = blacklist, correction.method = 'GC',
           GC.BSgenome = BSgenome.Hsapiens.UCSC.hg19, refine.breakpoints=FALSE,
           method = 'edivisive')

## ----eval=FALSE, message=FALSE----------------------------------------------------------
#  library(AneuFinder)
#  files <- list.files('outputfolder/MODELS/method-edivisive', full.names=TRUE)
#  models <- loadFromFiles(files)

## ----eval=TRUE, message=FALSE, fig.align='center', fig.width=9.5, fig.height=4, out.width='\\textwidth'----
## Get some pre-produced results (adjust this to your experiment)
results <- system.file("extdata", "primary-lung", "hmms", package="AneuFinderData")
files <- list.files(results, full.names=TRUE)
plot(files[1], type='profile')
plot(files[1], type='histogram')
plot(files[1], type='karyogram')

## ----eval=TRUE, message=FALSE, fig.align='center', out.width='0.8\\textwidth'-----------
library(AneuFinder)

## Get some pre-produced results (adjust this to your experiment)
results <- system.file("extdata", "primary-lung", "hmms", package="AneuFinderData")
files <- list.files(results, full.names=TRUE)

## Cluster by quality, please type ?getQC for other available quality measures
cl <- clusterByQuality(files, measures=c('spikiness','num.segments','entropy','bhattacharyya','sos'))
plot(cl$Mclust, what='classification')
print(cl$parameters)
## Apparently, the last cluster corresponds to failed libraries
## while the first cluster contains high-quality libraries

## ----eval=TRUE, message=FALSE, fig.width=50, fig.height=10, fig.align='center', out.width='\\textwidth'----
## Select the two best clusters and plot it
selected.files <- unlist(cl$classification[1:2])
heatmapGenomewide(selected.files)

## ----eval=TRUE, message=FALSE, fig.width=9.5, fig.height=4, out.width='\\textwidth'-----
library(AneuFinder)

## Get some pre-produced results (adjust this to your experiment)
results <- system.file("extdata", "primary-lung", "hmms", package="AneuFinderData")
files.lung <- list.files(results, full.names=TRUE)
results <- system.file("extdata", "metastasis-liver", "hmms", package="AneuFinderData")
files.liver <- list.files(results, full.names=TRUE)

## Get karyotype measures
k.lung <- karyotypeMeasures(files.lung)
k.liver <- karyotypeMeasures(files.liver)

## Print the scores in one data.frame
df <- rbind(lung = k.lung$genomewide, liver = k.liver$genomewide)
print(df)
## While the aneuploidy is similar between both cancers, the heterogeneity is
## nearly twice as high for the primary lung cancer.
plotHeterogeneity(hmms.list = list(lung=files.lung, liver=files.liver))

## ----eval=TRUE, message=FALSE, fig.width=9.5, fig.height=4, out.width='\\textwidth'-----
## Get results from a small-cell-lung-cancer
lung.folder <- system.file("extdata", "primary-lung", "hmms", package="AneuFinderData")
lung.files <- list.files(lung.folder, full.names=TRUE)
## Get results from the liver metastasis of the same patient
liver.folder <- system.file("extdata", "metastasis-liver", "hmms", package="AneuFinderData")
liver.files <- list.files(liver.folder, full.names=TRUE)
## Plot a clustered heatmap
classes <- c(rep('lung', length(lung.files)), rep('liver', length(liver.files)))
labels <- c(paste('lung',1:length(lung.files)), paste('liver',1:length(liver.files)))
plot_pca(c(lung.files, liver.files), colorBy=classes, PC1=2, PC2=4)

## ----sessionInfo, results="asis", eval=TRUE---------------------------------------------
toLatex(sessionInfo())

