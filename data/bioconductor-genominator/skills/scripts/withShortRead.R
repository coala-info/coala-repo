# Code example from 'withShortRead' vignette. See references/ for full tutorial.

### R code from vignette source 'withShortRead.Rnw'

###################################################
### code chunk number 1: withShortRead.Rnw:5-6
###################################################
options(width=80)


###################################################
### code chunk number 2: packages
###################################################
require(Genominator)
require(ShortRead)
require(yeastRNASeq)


###################################################
### code chunk number 3: yeastAligned
###################################################
data(yeastAligned)
yeastAligned[[1]]
sapply(yeastAligned, length)


###################################################
### code chunk number 4: filesInYeastRNASeq
###################################################
list.files(file.path(system.file(package = "yeastRNASeq"), "reads"), 
           pattern = "bowtie")


###################################################
### code chunk number 5: chrMap
###################################################
chrMap <- paste("Scchr", sprintf("%02d", 1:16), sep = "")
unique(chromosome((yeastAligned[[1]])))


###################################################
### code chunk number 6: filesArgument
###################################################
files <- list.files(file.path(system.file(package = "yeastRNASeq"), "reads"), 
                    pattern = "bowtie", full.names = TRUE)
names(files) <- sub("_f\\.bowtie\\.gz", "", basename(files))
names(files)


###################################################
### code chunk number 7: importFromAlignedReads
###################################################
eData <- importFromAlignedReads(files, chrMap = chrMap,
                                dbFilename = "my.db",
                                tablename = "raw", type = "Bowtie")
eData
head(eData)


###################################################
### code chunk number 8: biomaRt (eval = FALSE)
###################################################
## require(biomaRt)
## mart <- useMart("ensembl", "scerevisiae_gene_ensembl")
## attributes.gene <- c("ensembl_gene_id", "chromosome_name",  "start_position", 
##                      "end_position", "strand", "gene_biotype")
## attributes.tr <- c("ensembl_gene_id", "ensembl_transcript_id", "ensembl_exon_id", "chromosome_name",  "start_position", 
##                    "end_position", "strand", "gene_biotype", "exon_chrom_start", "exon_chrom_end", "rank")
## ensembl.gene <- getBM(attributes = attributes.gene,  mart = mart)
## ensembl.transcript <- getBM(attributes = attributes.tr,  mart = mart)


###################################################
### code chunk number 9: ensemblAnno
###################################################
data(yeastAnno.sources)
ensembl.gene <- yeastAnno.sources$ensembl.gene
ensembl.transcript <- yeastAnno.sources$ensembl.transcript
head(ensembl.gene, n = 2)
head(ensembl.transcript, n = 2)
dim(ensembl.gene)
dim(ensembl.transcript)
subset(ensembl.gene, ensembl_gene_id == "YPR098C")
subset(ensembl.transcript, ensembl_gene_id == "YPR098C")
length(unique(ensembl.transcript$ensembl_transcript_id))


###################################################
### code chunk number 10: rtracklayer (eval = FALSE)
###################################################
## require(rtracklayer)
## session <- browserSession()
## genome(session) <- "sacCer2"
## ucsc.sgdGene <- getTable(ucscTableQuery(session, "sgdGene"))
## ucsc.ensGene <- getTable(ucscTableQuery(session, "ensGene"))


###################################################
### code chunk number 11: yeastAnno.sources (eval = FALSE)
###################################################
## yeastAnno.sources <- list(ensembl.gene = ensembl.gene,
##                           ensembl.transcript = ensembl.transcript,
##                           ucsc.sgdGene = ucsc.sgdGene,
##                           ucsc.ensGene = ucsc.ensGene)
## save(yeastAnno.sources, file = "yeastAnno.sources.rda")


###################################################
### code chunk number 12: ucscAnno
###################################################
data(yeastAnno.sources)
ucsc.sgdGene <- yeastAnno.sources$ucsc.sgdGene
ucsc.ensGene <- yeastAnno.sources$ucsc.ensGene
head(ucsc.sgdGene, n = 2)
head(ucsc.ensGene, n = 2)
dim(ucsc.sgdGene)
dim(ucsc.ensGene)
subset(ucsc.sgdGene, name == "YPR098C")
subset(ucsc.ensGene, name == "YPR098C")
subset(ucsc.sgdGene, name == "YER102W")
subset(ucsc.ensGene, name == "YER102W")


###################################################
### code chunk number 13: yAnno
###################################################
yAnno <- yeastAnno.sources$ensembl.transcript
yAnno$chr <- match(yAnno$chr, c(as.character(as.roman(1:16)), "MT", "2-micron"))
yAnno$start <- yAnno$start_position
yAnno$end <- yAnno$end_position
rownames(yAnno) <- yAnno$ensembl_exon_id
yAnno.simple <- yAnno[yAnno$chr %in% 1:16, c("chr", "start", "end", "strand")]
head(yAnno.simple, n = 2)
head(yAnno, n = 2)


###################################################
### code chunk number 14: validAnno
###################################################
validAnnotation(yAnno)


###################################################
### code chunk number 15: geneCounts.1
###################################################
geneCounts.1 <- summarizeByAnnotation(eData, yAnno, ignoreStrand = TRUE)
head(geneCounts.1)


###################################################
### code chunk number 16: geneCounts.2
###################################################
geneCounts.2 <- summarizeByAnnotation(eData, yAnno, ignoreStrand = TRUE, 
                                      groupBy = "ensembl_gene_id")
head(geneCounts.2)


###################################################
### code chunk number 17: makeGeneRep
###################################################
yAnno.UI <- makeGeneRepresentation(yAnno, type = "UIgene", gene.id = "ensembl_gene_id",
                                   transcript.id = "ensembl_transcript_id")
head(yAnno.UI)


###################################################
### code chunk number 18: gof (eval = FALSE)
###################################################
## groups <- gsub("_[0-9]_f", "", colnames(geneCounts))
## groups
## plot(regionGoodnessOfFit(geneCounts, groups), chisq = TRUE)


###################################################
### code chunk number 19: computePrimingWeights
###################################################
weightsList <- lapply(yeastAligned, computePrimingWeights, 
                      unbiasedIndex = 20:21, weightsLength = 6L)
sapply(weightsList, summary)


###################################################
### code chunk number 20: addPrimingWeights
###################################################
yeastAligned2 <- mapply(addPrimingWeights, yeastAligned, weightsList)
alignData(yeastAligned2[[1]])
head(alignData(yeastAligned2[[1]])$weights)


###################################################
### code chunk number 21: importWithWeights
###################################################
eData2 <- importFromAlignedReads(yeastAligned2, chrMap = chrMap,
                                 dbFilename = "my.db", tablename = "weights")


###################################################
### code chunk number 22: reweightedCounts
###################################################
reweightedCounts <- summarizeByAnnotation(eData2, yAnno, ignoreStrand = TRUE, 
                                          groupBy = "ensembl_gene_id")
head(reweightedCounts)


###################################################
### code chunk number 23: sessionInfo
###################################################
toLatex(sessionInfo())


