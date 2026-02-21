# Code example from 'SplicingGraphs' vignette. See references/ for full tutorial.

### R code from vignette source 'SplicingGraphs.Rnw'

###################################################
### code chunk number 1: settings
###################################################
options(width=90)
.loadPrecomputed <- function(objname)
{
    filename <- paste0(objname, ".rds")
    path <- file.path("precomputed_results", filename)
    updateObject(readRDS(path))
}


###################################################
### code chunk number 2: txdb
###################################################
library(TxDb.Hsapiens.UCSC.hg19.refGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.refGene


###################################################
### code chunk number 3: isActiveSeq
###################################################
isActiveSeq(txdb)[1:25]


###################################################
### code chunk number 4: keep_chr14_only
###################################################
isActiveSeq(txdb)[-match("chr14", names(isActiveSeq(txdb)))] <- FALSE
names(which(isActiveSeq(txdb)))


###################################################
### code chunk number 5: SplicingGraphs_constructor
###################################################
library(SplicingGraphs)
sg <- SplicingGraphs(txdb)  # should take between 5 and 10 sec. on
                            # a modern laptop
sg


###################################################
### code chunk number 6: load_sg_with_bubbles
###################################################
## We load a precomputed 'sg' that contains all the bubbles in
## 'sg@.bubbles_cache'.
sg_with_bubbles <- .loadPrecomputed("sg_with_bubbles")
sg@.bubbles_cache <- sg_with_bubbles@.bubbles_cache
## Replace NAs with FALSE in circularity flag (because having the flag set
## to NA instead of FALSE (or vice-versa) is not considered a significant
## difference between the 2 objects):
isCircular(sg) <- isCircular(sg) %in% TRUE
isCircular(sg_with_bubbles) <- isCircular(sg_with_bubbles) %in% TRUE
if (!identical(sg, sg_with_bubbles))
    stop("'sg' is not identical to precomputed version")


###################################################
### code chunk number 7: names_sg
###################################################
names(sg)[1:20]


###################################################
### code chunk number 8: seqnames_sg
###################################################
seqnames(sg)[1:20]
strand(sg)[1:20]
table(strand(sg))


###################################################
### code chunk number 9: lengths_sg
###################################################
lengths(sg)[1:20]


###################################################
### code chunk number 10: sg_double_bracket_3183
###################################################
sg[["3183"]]


###################################################
### code chunk number 11: mcols_sg_double_bracket_3183
###################################################
mcols(sg[["3183"]])


###################################################
### code chunk number 12: mcols_sg_double_bracket_3183
###################################################
mcols(sg[["3183"]])$txpath


###################################################
### code chunk number 13: txpath_sg_3183
###################################################
txpath(sg[["3183"]])


###################################################
### code chunk number 14: plotTranscripts_sg_3183 (eval = FALSE)
###################################################
## plotTranscripts(sg[["3183"]])


###################################################
### code chunk number 15: plotTranscripts_sg_3183_as_pdf
###################################################
pdf("3183-transcripts.pdf", width=6, height=4)
plotTranscripts(sg[["3183"]])
dev.off()


###################################################
### code chunk number 16: unlist_sg
###################################################
ex_by_tx <- unlist(sg)
head(names(ex_by_tx))


###################################################
### code chunk number 17: unlist_sg
###################################################
ex_by_tx[names(ex_by_tx) %in% c("10001", "100128927")]


###################################################
### code chunk number 18: single_bracket_subsetting
###################################################
sg[strand(sg) == "-"]
sg[1:20]
tail(sg)  # equivalent to 'sg[tail(seq_along(sg))]'
sg["3183"]


###################################################
### code chunk number 19: sgedges_sg_3183
###################################################
sgedges(sg["3183"])


###################################################
### code chunk number 20: sgnodes_sg_3183
###################################################
sgnodes(sg["3183"])


###################################################
### code chunk number 21: sgedgesByGene_sg
###################################################
edges_by_gene <- sgedgesByGene(sg)


###################################################
### code chunk number 22: edges_by_gene_3183
###################################################
edges_by_gene[["3183"]]


###################################################
### code chunk number 23: plot_sg_3183 (eval = FALSE)
###################################################
## plot(sg["3183"])
## plot(sgraph(sg["3183"], tx_id.as.edge.label=TRUE))


###################################################
### code chunk number 24: plot_sg_3183_as_pdf
###################################################
pdf("3183-sgraph.pdf", width=3, height=5)
plot(sgraph(sg["3183"]))
dev.off()
pdf("3183-sgraph-labelled.pdf", width=3, height=5)
plot(sgraph(sg["3183"], tx_id.as.edge.label=TRUE))
dev.off()


###################################################
### code chunk number 25: plot_sg_115801414_as_pdf
###################################################
pdf("115801414-sgraph-labelled.pdf", width=5, height=5)
plot(sgraph(sg["115801414"], tx_id.as.edge.label=TRUE))
dev.off()


###################################################
### code chunk number 26: bubbles_sg_115801414
###################################################
bubbles(sg["115801414"])


###################################################
### code chunk number 27: ASCODE2DESC
###################################################
codes <- bubbles(sg["115801414"])$AScode
data.frame(AScode=codes, description=ASCODE2DESC[codes], row.names=NULL)

codes <- bubbles(sg["10202"])$AScode
data.frame(AScode=codes, description=ASCODE2DESC[codes], row.names=NULL)


###################################################
### code chunk number 28: AScode_summary
###################################################
AScode_list <- lapply(seq_along(sg), function(i) bubbles(sg[i])$AScode)
names(AScode_list) <- names(sg)
AScode_table <- table(unlist(AScode_list))
AScode_table <- sort(AScode_table, decreasing=TRUE)
AScode_summary <- data.frame(AScode=names(AScode_table),
                             NbOfEvents=as.vector(AScode_table),
                             Description=ASCODE2DESC[names(AScode_table)])
nrow(AScode_summary)


###################################################
### code chunk number 29: head_AScode_summary
###################################################
head(AScode_summary, n=10)


###################################################
### code chunk number 30: nb_bubbles_per_gene
###################################################
nb_bubbles_per_gene <- lengths(AScode_list)


###################################################
### code chunk number 31: head_sort_nb_bubbles_per_gene
###################################################
head(sort(nb_bubbles_per_gene, decreasing=TRUE))


###################################################
### code chunk number 32: nb_unique_bubbles_per_gene
###################################################
nb_unique_bubbles_per_gene <- lengths(unique(CharacterList(AScode_list)))


###################################################
### code chunk number 33: head_sort_nb_unique_bubbles_per_gene
###################################################
head(sort(nb_unique_bubbles_per_gene, decreasing=TRUE))


###################################################
### code chunk number 34: plot_sg_91833_as_pdf
###################################################
pdf("91833-sgraph.pdf", width=5, height=5)
plot(sgraph(sg["91833"]))
dev.off()


###################################################
### code chunk number 35: bam_files
###################################################
library(RNAseqData.HNRNPC.bam.chr14)
bam_files <- RNAseqData.HNRNPC.bam.chr14_BAMFILES
names(bam_files)  # the names of the runs


###################################################
### code chunk number 36: quickBamFlagSummary
###################################################
quickBamFlagSummary(bam_files[1], main.groups.only=TRUE)


###################################################
### code chunk number 37: readGAlignmentPairs
###################################################
param <- ScanBamParam(which=GRanges("chr14", IRanges(1, 20000000)))
gapairs <- readGAlignmentPairs(bam_files[1], param=param)
length(gapairs)  # nb of alignment pairs
gapairs


###################################################
### code chunk number 38: ScanBamParam
###################################################
flag0 <- scanBamFlag(isSecondaryAlignment=FALSE,
                     isNotPassingQualityControls=FALSE,
                     isDuplicate=FALSE)
param0 <- ScanBamParam(flag=flag0)


###################################################
### code chunk number 39: assignReads
###################################################
## The following loop takes about 1 minute on a modern laptop/desktop...
for (i in seq_along(bam_files)) {
    bam_file <- bam_files[i]
    cat("Processing run ", names(bam_file), " ... ", sep="")
    gapairs <- readGAlignmentPairs(bam_file, use.names=TRUE, param=param0)
    sg <- assignReads(sg, gapairs, sample.name=names(bam_file))
    cat("OK\n")
}


###################################################
### code chunk number 40: sg_3183_assignments
###################################################
edges_by_tx <- sgedgesByTranscript(sg["3183"], with.hits.mcols=TRUE)
edge_data <- mcols(unlist(edges_by_tx))
colnames(edge_data)


###################################################
### code chunk number 41: head_edge_data_sgedge_id_ERR127306.hits
###################################################
head(edge_data[ , c("sgedge_id", "ERR127306.hits")])


###################################################
### code chunk number 42: load_reads_in_3183_region
###################################################
param <- ScanBamParam(flag=flag0, which=range(unlist(sg[["3183"]])))
reads <- readGAlignmentPairs(bam_files[1], use.names=TRUE, param=param)
junction_reads <- reads[njunc(first(reads)) + njunc(last(reads)) != 0L]


###################################################
### code chunk number 43: plotTranscripts_sg_3183_and_reads (eval = FALSE)
###################################################
## plotTranscripts(sg[["3183"]], reads=junction_reads, from=21675000, to=21702000)


###################################################
### code chunk number 44: plotTranscripts_sg_3183_and_reads_as_pdf
###################################################
pdf("3183-transcripts-and-reads.pdf", width=12, height=12)
plotTranscripts(sg[["3183"]], reads=junction_reads, from=21675000, to=21702000)
dev.off()


###################################################
### code chunk number 45: plotTranscripts_sg_3183_and_reads_zoom (eval = FALSE)
###################################################
## plotTranscripts(sg[["3183"]], reads=junction_reads, from=21698400, to=21698600)


###################################################
### code chunk number 46: plotTranscripts_sg_3183_and_reads_zoom_as_pdf
###################################################
pdf("3183-transcripts-and-reads-zoom.pdf", width=12, height=12)
plotTranscripts(sg[["3183"]], reads=junction_reads, from=21698400, to=21698600)
dev.off()


###################################################
### code chunk number 47: countReads_sg
###################################################
sg_counts <- countReads(sg)


###################################################
### code chunk number 48: head_sg_counts
###################################################
dim(sg_counts)
head(sg_counts[1:5])


###################################################
### code chunk number 49: sapply_sg_counts
###################################################
sapply(sg_counts[-(1:2)], sum)


###################################################
### code chunk number 50: SessionInfo
###################################################
sessionInfo()


