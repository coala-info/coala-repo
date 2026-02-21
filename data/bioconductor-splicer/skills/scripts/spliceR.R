# Code example from 'spliceR' vignette. See references/ for full tutorial.

### R code from vignette source 'spliceR.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Cufflinks_workflow
###################################################
library("spliceR")

dir <- tempdir()
extdata <- system.file("extdata", package="cummeRbund")
file.copy(file.path(extdata, dir(extdata)), dir)

cuffDB <- readCufflinks(dir=dir,
    gtf=system.file("extdata/chr1_snippet.gtf", package="cummeRbund"),genome="hg19" ,rebuild=TRUE)

cuffDB_spliceR <- prepareCuff(cuffDB)


###################################################
### code chunk number 2: Helper_functions
###################################################
myTranscripts <- transcripts(cuffDB_spliceR)
myExons <- exons(cuffDB_spliceR)
conditions(cuffDB_spliceR)


###################################################
### code chunk number 3: GRanges_1
###################################################
session <- browserSession("UCSC")
genome(session) <- "hg19"
query <- ucscTableQuery(session, "knownGene")
tableName(query) <- "knownGene"
cdsTable <- getTable(query)


###################################################
### code chunk number 4: GRanges_2
###################################################
tableName(query) <- "kgXref"
kgXref <- getTable(query)


###################################################
### code chunk number 5: GRanges_3
###################################################
knownGeneTranscripts <- GRanges(
	seqnames=cdsTable$"chrom",
	ranges=IRanges(
		start=cdsTable$"txStart",
		end=cdsTable$"txEnd"),
	strand=cdsTable$"strand",
	spliceR.isoform_id = cdsTable$"name",
	spliceR.sample_1="placeholder1",
	spliceR.sample_2="placeholder2",
	spliceR.gene_id=kgXref[match(cdsTable$"name", kgXref$"kgID"), 
		"geneSymbol"],
	spliceR.gene_value_1=1,
	spliceR.gene_value_2=1,
	spliceR.gene_log2_fold_change=log2(1/1),
	spliceR.gene_p_value=1,
	spliceR.gene_q_value=1,
	spliceR.iso_value_1=1,
	spliceR.iso_value_2=1,
	spliceR.iso_log2_fold_change=log2(1/1),
	spliceR.iso_p_value=1,
	spliceR.iso_q_value=1
	)


###################################################
### code chunk number 6: GRanges_4
###################################################
startSplit	<- strsplit(as.character(cdsTable$"exonStarts"), split=",")
endSplit  	<- strsplit(as.character(cdsTable$"exonEnds"), split=",")

startSplit  <- lapply(startSplit, FUN=as.numeric)
endSplit	<- lapply(endSplit, FUN=as.numeric)

knownGeneExons <- GRanges(
	seqnames=rep(cdsTable$"chrom", lapply(startSplit, length)),
	ranges=IRanges(
		start=unlist(startSplit)+1,
		end=unlist(endSplit)),
	strand=rep(cdsTable$"strand", lapply(startSplit, length)),
	spliceR.isoform_id=rep(knownGeneTranscripts$"spliceR.isoform_id",
	lapply(startSplit, length)),
	spliceR.gene_id=rep(knownGeneTranscripts$"spliceR.gene_id",
	lapply(startSplit, length))
	)


###################################################
### code chunk number 7: GRanges_5
###################################################
knownGeneSpliceRList <- SpliceRList(
	transcript_features=knownGeneTranscripts,
	exon_features=knownGeneExons,
	assembly_id="hg19",
	source="granges",
	conditions=c("placeholder1", "placeholder2")
	)


###################################################
### code chunk number 8: preSpliceRFilter
###################################################
#cuffDB_spliceR_filtered <- preSpliceRFilter(
#	cuffDB_spliceR,
#	filters=c("expressedIso", "isoOK", "expressedGenes", "geneOK")
#	)


###################################################
### code chunk number 9: spliceR
###################################################
#Commented out due to problems with vignettes and progress bars.
mySpliceRList <- spliceR(
	cuffDB_spliceR,
	compareTo="preTranscript",
	filters=c("expressedGenes","geneOK", "isoOK", "expressedIso", "isoClass"),
	useProgressBar=F
)


###################################################
### code chunk number 10: annotatePTC
###################################################
ucscCDS <- getCDS(selectedGenome="hg19", repoName="UCSC")
require("BSgenome.Hsapiens.UCSC.hg19",character.only = TRUE)
#Commented out due to problems with vignettes and progress bars.
#PTCSpliceRList <- annotatePTC(cuffDB_spliceR, cds=ucscCDS, Hsapiens, 
#	PTCDistance=50)


###################################################
### code chunk number 11: generateGTF
###################################################
generateGTF(mySpliceRList, filters=
c("geneOK", "isoOK", "expressedGenes", "expressedIso"), 
	scoreMethod="local",
	useProgressBar=F)


###################################################
### code chunk number 12: plot1
###################################################
#Plot the average number of transcripts pr gene
mySpliceRList <- spliceRPlot(mySpliceRList, 
	evaluate="nr_transcript_pr_gene")


###################################################
### code chunk number 13: plot2
###################################################
#Plot the average number of Exon skipping/inclucion evens pr gene
mySpliceRList <- spliceRPlot(mySpliceRList, evaluate="mean_AS_transcript", 
	asType="ESI")


###################################################
### code chunk number 14: plot3
###################################################
#Plot the average number of Exon skipping/inclucion evens pr gene, 
#but only using transcripts that are significantly differntially expressed
mySpliceRList <- spliceRPlot(mySpliceRList, evaluate="mean_AS_transcript", 
	asType="ESI", filters="sigIso",reset=TRUE)


###################################################
### code chunk number 15: sessionInfo
###################################################
sessionInfo()


