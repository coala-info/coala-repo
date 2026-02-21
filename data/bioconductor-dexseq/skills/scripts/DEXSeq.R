# Code example from 'DEXSeq' vignette. See references/ for full tutorial.

## ----echo=FALSE, include=FALSE------------------------------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      cache = TRUE,
                      dev = "png",
                      message = FALSE,
                      error = FALSE,
                      warning = TRUE)

## ----warning=FALSE------------------------------------------------------------

library(GenomicFeatures)  # for the exonicParts() function
library(txdbmaker)        # for the makeTxDbFromGFF() function
download.file(
    "https://ftp.ensembl.org/pub/release-62/gtf/drosophila_melanogaster/Drosophila_melanogaster.BDGP5.25.62.gtf.gz",
    destfile="Drosophila_melanogaster.BDGP5.25.62.gtf.gz")
txdb = makeTxDbFromGFF("Drosophila_melanogaster.BDGP5.25.62.gtf.gz")

file.remove("Drosophila_melanogaster.BDGP5.25.62.gtf.gz")

flattenedAnnotation = exonicParts( txdb, linked.to.single.gene.only=TRUE )
names(flattenedAnnotation) =
    sprintf("%s:E%0.3d", flattenedAnnotation$gene_id, flattenedAnnotation$exonic_part)


## -----------------------------------------------------------------------------

library(pasillaBamSubset)
library(Rsamtools)
library(GenomicAlignments)
library(GenomeInfoDb)
bamFiles = c( untreated1_chr4(), untreated3_chr4() )
bamFiles = BamFileList( bamFiles )
seqlevelsStyle(flattenedAnnotation) = "UCSC"
se = summarizeOverlaps(
    flattenedAnnotation, BamFileList(bamFiles), singleEnd=FALSE,
    fragments=TRUE, ignore.strand=TRUE )


## ----buildExonCountSet--------------------------------------------------------
library(DEXSeq)
colData(se)$condition = factor(c("untreated1", "untreated3"))
colData(se)$libType = factor(c("single-end", "paired-end"))
dxd = DEXSeqDataSetFromSE( se, design= ~ sample + exon + condition:exon )

## ----startVignette------------------------------------------------------------
data(pasillaDEXSeqDataSet, package="pasilla")

## -----------------------------------------------------------------------------
colData(dxd)

## -----------------------------------------------------------------------------
head( counts(dxd), 5 )

## -----------------------------------------------------------------------------
split( seq_len(ncol(dxd)), colData(dxd)$exon )

## -----------------------------------------------------------------------------
head( featureCounts(dxd), 5 )

## -----------------------------------------------------------------------------
head( rowRanges(dxd), 3 )

## -----------------------------------------------------------------------------
sampleAnnotation( dxd )

## -----------------------------------------------------------------------------
dxd = estimateSizeFactors( dxd )

## -----------------------------------------------------------------------------
dxd = estimateDispersions( dxd )

## ----fitdiagnostics, fig.small=TRUE, fig.cap="Fit Diagnostics. The initial per-exon dispersion estimates (shown by black points), the fitted mean-dispersion values function (red line), and the shrinked values in blue"----
plotDispEsts( dxd )

## ----testForDEU1--------------------------------------------------------------
dxd = testForDEU( dxd )

## ----estFC--------------------------------------------------------------------
dxd = estimateExonFoldChanges( dxd, fitExpToVar="condition")

## ----results1-----------------------------------------------------------------
dxr1 = DEXSeqResults( dxd )
dxr1

## ----results2-----------------------------------------------------------------
mcols(dxr1)$description

## ----tallyExons---------------------------------------------------------------
table ( dxr1$padj < 0.1 )

## ----tallyGenes---------------------------------------------------------------
table ( tapply( dxr1$padj < 0.1, dxr1$groupID, any ) )

## ----MvsA, fig.small=TRUE, fig.cap="MA plot. Mean expression versus $log{2}$ fold change plot. Significant hits at an $FDR=0.1$ are coloured in red."----
plotMA( dxr1, cex=0.8 )

## ----design-------------------------------------------------------------------
sampleAnnotation(dxd)

## ----formulas2----------------------------------------------------------------
formulaFullModel    =  ~ sample + exon + type:exon + condition:exon
formulaReducedModel =  ~ sample + exon + type:exon 

## ----estDisps_again-----------------------------------------------------------
dxd = estimateDispersions( dxd, formula = formulaFullModel )

## ----test_again---------------------------------------------------------------
dxd = testForDEU( dxd, 
	reducedModel = formulaReducedModel, 
        fullModel = formulaFullModel )

## ----res_again----------------------------------------------------------------
dxr2 = DEXSeqResults( dxd )

## ----table2-------------------------------------------------------------------
table( dxr2$padj < 0.1 )

## ----table3-------------------------------------------------------------------
table( before = dxr1$padj < 0.1, now = dxr2$padj < 0.1 )

## ----plot1, fig.height=8, fig.width=12, fig.cap="Fitted expression. The plot represents the expression estimates from a call to `testForDEU()`. Shown in red is the exon that showed significant differential exon usage."----
plotDEXSeq( dxr2, "FBgn0010909", legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 )

## ----checkClaim---------------------------------------------------------------
wh = (dxr2$groupID=="FBgn0010909")
stopifnot(sum(dxr2$padj[wh] < formals(plotDEXSeq)$FDR)==1)

## ----plot2, fig.height=8, fig.width=12, fig.cap="Transcripts. As in the previous plots, but including the annotated transcript models"----
plotDEXSeq( dxr2, "FBgn0010909", displayTranscripts=TRUE, legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 )

## ----plot3, fig.height=8, fig.width=12, fig.cap="Normalized counts. As in the previous plots, with normalized count values of each exon in each of the samples."----
plotDEXSeq( dxr2, "FBgn0010909", expression=FALSE, norCounts=TRUE,
   legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 )

## ----plot4, fig.height=8, fig.width=12, fig.cap="Fitted splicing. As in the previous plots, but after subtraction of overall changes in gene expression."----
plotDEXSeq( dxr2, "FBgn0010909", expression=FALSE, splicing=TRUE,
   legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 )

## ----DEXSeqHTML, cache=TRUE, eval=FALSE---------------------------------------
# DEXSeqHTML( dxr2, FDR=0.1, color=c("#FF000080", "#0000FF80") )

## ----para1,cache=TRUE,results='hide', eval=FALSE------------------------------
# BPPARAM = MultiCoreParam(4)
# dxd = estimateSizeFactors( dxd )
# dxd = estimateDispersions( dxd, BPPARAM=BPPARAM)
# dxd = testForDEU( dxd, BPPARAM=BPPARAM)
# dxd = estimateExonFoldChanges(dxd, BPPARAM=BPPARAM)

## ----alldeu-------------------------------------------------------------------
dxr = DEXSeq(dxd)
class(dxr)

## ----pergeneqval--------------------------------------------------------------
numbOfGenes = sum( perGeneQValue(dxr) < 0.1)
numbOfGenes

## ----systemFile---------------------------------------------------------------
pythonScriptsDir = system.file( "python_scripts", package="DEXSeq" )
list.files(pythonScriptsDir)
system.file( "python_scripts", package="DEXSeq", mustWork=TRUE )

## ----loadDEXSeq---------------------------------------------------------------
inDir = system.file("extdata", package="pasilla")
countFiles = list.files(inDir, pattern="fb.txt$", full.names=TRUE)
basename(countFiles)
flattenedFile = list.files(inDir, pattern="gff$", full.names=TRUE)
basename(flattenedFile)

## ----sampleTable--------------------------------------------------------------
sampleTable = data.frame(
   row.names = c( "treated1", "treated2", "treated3", 
      "untreated1", "untreated2", "untreated3", "untreated4" ),
   condition = c("knockdown", "knockdown", "knockdown",  
      "control", "control", "control", "control" ),
   libType = c( "single-end", "paired-end", "paired-end", 
      "single-end", "single-end", "paired-end", "paired-end" ) )

## ----check--------------------------------------------------------------------
sampleTable

## ----message=FALSE------------------------------------------------------------
library( "DEXSeq" )

dxd = DEXSeqDataSetFromHTSeq(
   countFiles,
   sampleData=sampleTable,
   design= ~ sample + exon + condition:exon,
   flattenedfile=flattenedFile )

## ----acc----------------------------------------------------------------------
head( geneIDs(dxd) )
head( exonIDs(dxd) )

## ----grmethods----------------------------------------------------------------
interestingRegion = GRanges( "chr2L", 
   IRanges(start=3872658, end=3875302) )
subsetByOverlaps( x=dxr, ranges=interestingRegion )
findOverlaps( query=dxr, subject=interestingRegion )

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

