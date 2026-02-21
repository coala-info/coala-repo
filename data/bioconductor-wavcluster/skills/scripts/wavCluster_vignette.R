# Code example from 'wavCluster_vignette' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# 	#ALIGN:
# 		sample.fastq -> sample.sam
# 	#CONVERT:
# 		samtools view -b -S sample.sam -o sample.bam
# 	#SORT:
# 		samtools sort sample.bam sample_sorted
# 	#INDEXING:
# 		samtools index sample_sorted.bam

## ----eval=TRUE----------------------------------------------------------------
library(wavClusteR)
filename <- system.file( "extdata", "example.bam", package = "wavClusteR" )
Bam <- readSortedBam(filename = filename)
Bam

## ----eval=TRUE----------------------------------------------------------------
countTable <- getAllSub( Bam, minCov = 10 )
head( countTable )

## ----fig.width=5, fig.height=5, fig.align='center', eval=TRUE-----------------
plotSubstitutions( countTable, highlight = "TC" )

## ----eval=FALSE---------------------------------------------------------------
# model <- fitMixtureModel(countTable, substitution = "TC")

## ----eval=TRUE----------------------------------------------------------------
data(model)
str(model)

## ----fig.width=7, fig.height=4.5, fig.align='center', eval=TRUE---------------
(support <- getExpInterval( model, bayes = TRUE ) )

## ----fig.width=7, fig.height=4.5, fig.align='center', eval=TRUE---------------
(support <- getExpInterval( model, bayes = FALSE, leftProb = 0.9, rightProb = 	0.9 ) )

## ----fig.width=7, fig.height=5, fig.align='center', eval=TRUE-----------------
plotSubstitutions( countTable, highlight = "TC", model )

## ----eval=TRUE----------------------------------------------------------------
highConfSub <- getHighConfSub( countTable, 
                               support = support, 
                               substitution = "TC" )
head( highConfSub )                               

## ----eval=FALSE---------------------------------------------------------------
# highConfSub <- getHighConfSub( countTable,
#                                supportStart = 0.2,
#                                supportEnd = 0.7,
#                                substitution = "TC" )
# head( highConfSub )

## ----eval=TRUE----------------------------------------------------------------
coverage <- coverage( Bam )
coverage$chrX

## ----eval=TRUE----------------------------------------------------------------
clusters <- getClusters( highConfSub = highConfSub,
                         		coverage = coverage,
                         		sortedBam = Bam,
                         		threshold = 1,
                         		cores = 1 )
clusters

## ----eval=TRUE----------------------------------------------------------------
clusters <- getClusters( highConfSub = highConfSub,
                         		coverage = coverage,
                         		sortedBam = Bam,
                         		cores = 1 )
clusters

## ----eval=TRUE----------------------------------------------------------------
require(BSgenome.Hsapiens.UCSC.hg19)

wavclusters <- filterClusters( clusters = clusters, 
                   highConfSub = highConfSub,
                   coverage = coverage, 
                   model = model, 
                   genome = Hsapiens, 
                   refBase = "T", 
                   minWidth = 12)

wavclusters

## ----eval=FALSE---------------------------------------------------------------
# exportHighConfSub( highConfSub = highConfSub,
#                    filename = "hcTC.bed",
#                    trackname = "hcTC",
#                    description = "hcTC" )

## ----eval=FALSE---------------------------------------------------------------
# exportClusters( clusters = wavclusters,
#                 filename = "wavClusters.bed",
#                 trackname = "wavClusters",
#                 description = "wavClusters" )

## ----eval=FALSE---------------------------------------------------------------
# exportCoverage( coverage = coverage, filename = "coverage.bigWig" )

## ----eval=FALSE---------------------------------------------------------------
# txDB <- makeTxDbFromUCSC(genome = "hg19", tablename = "ensGene")

## ----eval=FALSE---------------------------------------------------------------
# annotateClusters( clusters = wavclusters,
#               txDB = txDB,
#               plot = TRUE,
#               verbose = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# getMetaGene( clusters = wavclusters,
#              txDB = txDB,
#              upstream = 1e3,
#              downstream = 1e3,
#              nBins = 40,
#              nBinsUD = 10,
#              minLength = 1,
#              plot = TRUE,
#              verbose = TRUE )

## ----eval=FALSE---------------------------------------------------------------
# getMetaTSS( sortedBam = Bam,
#             txDB = txDB,
#             upstream = 1e3,
#             downstream = 1e3,
#             nBins = 40,
#             unique = FALSE,
#             plot = TRUE,
#             verbose = TRUE )

## ----fig.width=5, fig.height=5, fig.align='center', eval=TRUE-----------------
plotSizeDistribution( clusters = wavclusters, showCov = TRUE, col = "skyblue2" )

## ----fig.width=5, fig.height=5, fig.align='center', eval=FALSE----------------
# plotStatistics( clusters = wavclusters,
#                 corMethod = "spearman",
#                 lower = panel.smooth )

## ----eval=TRUE----------------------------------------------------------------
sessionInfo()

