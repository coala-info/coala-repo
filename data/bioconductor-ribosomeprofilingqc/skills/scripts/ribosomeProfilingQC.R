# Code example from 'ribosomeProfilingQC' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", warning=FALSE, message=FALSE-----------------
suppressPackageStartupMessages({
  library(ribosomeProfilingQC)
  library(BSgenome.Drerio.UCSC.danRer10)
  library(txdbmaker)
  library(Rsamtools)
  library(AnnotationDbi)
  library(motifStack)
})
knitr::opts_chunk$set(warning=FALSE, message=FALSE, fig.width=5, fig.height=3.5)

## ----eval=FALSE---------------------------------------------------------------
# library(BiocManager)
# BiocManager::install(c("ribosomeProfilingQC",
#                        "AnnotationDbi", "Rsamtools",
#                        "BSgenome.Drerio.UCSC.danRer10",
#                        "TxDb.Drerio.UCSC.danRer10.refGene",
#                        "motifStack"))

## -----------------------------------------------------------------------------
R.version

## ----loadLibrary, class.source='vig'------------------------------------------
## load library
library(ribosomeProfilingQC)
library(AnnotationDbi)
library(Rsamtools)
library(ggplot2)

## ----loadGenome, class.source='vig'-------------------------------------------
library(BSgenome.Drerio.UCSC.danRer10)
## set genome, Drerio is a shortname for BSgenome.Drerio.UCSC.danRer10
genome <- Drerio

## ----eval=FALSE---------------------------------------------------------------
# library(BSgenome.Hsapiens.UCSC.hg38)
# genome <- Hsapiens

## ----eval=FALSE---------------------------------------------------------------
# library(BSgenome.Mmusculus.UCSC.mm10)
# genome <- Mmusculus

## ----eval=FALSE---------------------------------------------------------------
# genome <- Biostrings::readDNAStringSet('filepath/to/the/genome/fasta/file')

## ----eval=FALSE---------------------------------------------------------------
# ## which is corresponding to BSgenome.Drerio.UCSC.danRer10
# library(TxDb.Drerio.UCSC.danRer10.refGene)
# txdb <- TxDb.Drerio.UCSC.danRer10.refGene ## give it a short name
# CDS <- prepareCDS(txdb)

## ----eval=FALSE---------------------------------------------------------------
# library(TxDb.Hsapiens.UCSC.hg38.knownGene)
# txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene ## give it a short name
# CDS <- prepareCDS(txdb)

## ----eval=FALSE---------------------------------------------------------------
# library(TxDb.Mmusculus.UCSC.mm10.knownGene)
# txdb <- TxDb.Mmusculus.UCSC.mm10.knownGene ## give it a short name
# CDS <- prepareCDS(txdb)

## ----loadTxDb, class.source='vig'---------------------------------------------
## Create a small TxDb object which only contain chr1 information.
library(txdbmaker)
txdb <- makeTxDbFromGFF(system.file("extdata",
                                    "Danio_rerio.GRCz10.91.chr1.gtf.gz",
                                    package="ribosomeProfilingQC"),
                        organism = "Danio rerio",
                        chrominfo = seqinfo(Drerio)["chr1"],
                        taxonomyId = 7955)
CDS <- prepareCDS(txdb)

## ----filter, eval=FALSE-------------------------------------------------------
# bamfilename <- system.file("extdata", "RPF.WT.1.bam",
#                            package="ribosomeProfilingQC")
# bamHeader <- Rsamtools::scanBamHeader(bamfilename)
# (chromsomeNameStyle <- GenomeInfoDb::seqlevelsStyle(names(bamHeader[[1]]$targets)))
# library(rtracklayer)
# ## the gtf could be downloaded from https://www.ensembl.org/info/data/ftp/index.html
# ## Please make sure the version number are correct.
# ## check the version number at https://www.ensembl.org/info/website/archives/index.html
# gtf <- import(system.file("extdata",
#                           "Danio_rerio.GRCz10.91.chr1.gtf.gz",
#                           package="ribosomeProfilingQC"))
# gtf <- gtf[gtf$transcript_biotype %in%
#              c('rRNA', 'tRNA', 'snRNA', 'snoRNA', 'misc_RNA')]
# mcols(gtf) <- NULL
# annotation <- 'danRer10' ## must be UCSC style, eg, GRCm38 should be mm10, GRCh38 should be hg38
# rmsk <- data.table::fread(paste0('https://hgdownload.soe.ucsc.edu/goldenPath/',
#                                 annotation, '/database/rmsk.txt.gz'),
#                           header=FALSE)
# colnames(rmsk) <- c('bin', 'swScore', 'milliDiv', 'milliDel', 'milliIns',
#                     'genoName', 'genoStart', 'genoEnd', 'genoLeft', 'strand',
#                     'repName', 'repClass', 'repFamily', 'repStart', 'repEnd',
#                     'repLeft', 'id')
# rmsk_gr <- with(rmsk, GRanges(genoName, IRanges(genoStart+1, genoEnd),
#                               strand = strand))
# # 'UCSC' or 'ensembl', keep same as it in the bam file
# GenomeInfoDb::seqlevelsStyle(gtf) <- seqlevelsStyle(rmsk_gr) <-
#   chromsomeNameStyle[1]
# gr <- reduce(sort(c(gtf, rmsk_gr)))
# seqlevels(gr, pruning.mode="coarse") <-
#   intersect(seqlevels(gr), names(bamHeader[[1]]$targets))
# outputBed <- 'unused_regions.bed'
# export(gr, outputBed)
# filteredBamfileName <- sub('.bam$', '.fil.bam', bamfilename)
# unusedBamfileName <- sub('.bam$', '.no_use.bam', bamfilename)
# ## run the cmd in terminal or by system/system2
# ## please make sure the samtools is available in PATH
# ## see more about samtools at https://www.htslib.org/
# (cmd <- paste('samtools view -b -L', outputBed,
#               '-U', filteredBamfileName,
#               '-o', unusedBamfileName,
#               bamfilename))
# system2('samtools',
#   args = c('view', '-b',
#            '-L', outputBed,
#            '-U', filteredBamfileName,
#            '-o', unusedBamfileName,
#            bamfilename))
# (cmd2 <- paste('samtools bam2fq', filteredBamfileName,
#                '| gzip >', sub('.bam$', '.fq.gz', filteredBamfileName)))
# system2('samtools',
#         args = c('bam2fq', filteredBamfileName,
#                '|', 'gzip', '>', sub('.bam$', '.fq.gz', filteredBamfileName)))

## ----inputBamFile, class.source='vig'-----------------------------------------
library(Rsamtools)
## input the bamFile from the ribosomeProfilingQC package 
bamfilename <- system.file("extdata", "RPF.WT.1.bam",
                           package="ribosomeProfilingQC")
## For your own data, please set bamfilename as your file path.
## For example, your bam file is located at C:\mydata\a.bam
## you want to set bamfilename = "C:\\mydata\\a.bam"
## or you can change your working directory by
## setwd("C:\\mydata")
## and then set bamfilename = "a.bam"
yieldSize <- 10000000
bamfile <- BamFile(bamfilename, yieldSize = yieldSize)

## ----estimatePsite, class.source='vig'----------------------------------------
estimatePsite(bamfile, CDS, genome)

## ----estimatePsite3end, class.source='vig'------------------------------------
estimatePsite(bamfile, CDS, genome, anchor = "3end")

## ----readsEndPlot, fig.height=4, fig.width=6, class.source='vig'--------------
re <- readsEndPlot(bamfile, CDS, toStartCodon=TRUE)
readsEndPlot(re$reads, CDS, toStartCodon=TRUE, fiveEnd=FALSE)

## ----getPsiteCoordinates, class.source='vig'----------------------------------
pc <- getPsiteCoordinates(bamfile, bestpsite = 13)

## ----readsLen, class.source='vig'---------------------------------------------
readsLen <- summaryReadsLength(pc)

## ----filterSize, class.source='vig'-------------------------------------------
## for this QC demo, we will only use reads length of 28-29 nt.
pc.sub <- pc[pc$qwidth %in% c(28, 29)]

## ----strandPlot, fig.width=2,fig.height=3, class.source='vig'-----------------
strandPlot(pc.sub, CDS)

## ----readsDistribution, fig.width=7, fig.height=4, class.source='vig'---------
pc.sub <- readsDistribution(pc.sub, txdb, las=2)

## ----metaPlotUTR5cdsUTR3, fig.width=5, fig.height=4, class.source='vig'-------
cvgs.utr5 <- coverageDepth(RPFs = bamfilename, gtf = txdb, region="utr5")
cvgs.CDS <- coverageDepth(RPFs = bamfilename, gtf = txdb, region="cds")
cvgs.utr3 <- coverageDepth(RPFs = bamfilename, gtf = txdb, region="utr3")
metaPlot(cvgs.utr5, cvgs.CDS, cvgs.utr3, sample=1)

## ----assignReadingFrame, fig.width=5, fig.height=3, class.source='vig'--------
pc.sub <- assignReadingFrame(pc.sub, CDS)
plotDistance2Codon(pc.sub)

## ----plotFrameDensity, fig.width=2.5,fig.height=3, class.source='vig'---------
plotFrameDensity(pc.sub)

## ----allReadFrame, fig.width=2.5,fig.height=3, class.source='vig'-------------
pc <- assignReadingFrame(pc, CDS)
plotFrameDensity(pc)

## ----plotTranscript, fig.width=8, fig.height=6, class.source='vig'------------
plotTranscript(pc.sub, c("ENSDART00000161781", "ENSDART00000166968",
                         "ENSDART00000040204", "ENSDART00000124837"))

## ----ORFscore, eval=FALSE, class.source='vig'---------------------------------
# cvg <- frameCounts(pc.sub, coverageRate=TRUE)
# ORFscore <- getORFscore(pc.sub)
# ## Following code will plot the ORFscores vs coverage.
# ## Try it by removing the '#'.
# #plot(cvg[names(ORFscore)], ORFscore,
# #     xlab="coverage ORF1", ylab="ORF score",
# #     type="p", pch=16, cex=.5, xlim=c(0, 1))

## ----badStrandPlot, fig.width=2,fig.height=3, class.source='vig'--------------
bamfilename <- system.file("extdata", "RPF.chr1.bad.bam",
                           package="ribosomeProfilingQC")
yieldSize <- 10000000
bamfile <- BamFile(bamfilename, yieldSize = yieldSize)
pc <- getPsiteCoordinates(bamfile, bestpsite = 13)
pc.sub <- pc[pc$qwidth %in% c(27, 28, 29)]
## in this example, most of the reads mapped to the antisense strand
## which may indicate that there are some issues in the mapping step
strandPlot(pc.sub, CDS)

## ----badReadsDistribution, fig.width=7, fig.height=4, class.source='vig'------
## in this exaple, most of the reads mapped to inter-genic regions
## rather than the CDS, which could indicate that ribosome protected
## fragments are not being properly isolated/selected
pc.sub <- readsDistribution(pc.sub, txdb, las=2)

## ----badAssignReadingFrame, fig.width=5, fig.height=4, class.source='vig'-----
## Selection of the proper P site is also critical.
## If we assign the wrong P site position the frame mapping will 
## likely be impacted. 
pc <- getPsiteCoordinates(bamfile, 12)
pc.sub <- pc[pc$qwidth %in% c(27, 28, 29)]
pc.sub <- assignReadingFrame(pc.sub, CDS)
plotDistance2Codon(pc.sub)

## ----badPlotFrameDensity, fig.width=2.5,fig.height=3, class.source='vig'------
plotFrameDensity(pc.sub)

## ----countReads, class.source='vig'-------------------------------------------
library(ribosomeProfilingQC)
library(AnnotationDbi)
path <- system.file("extdata", package="ribosomeProfilingQC")
RPFs <- dir(path, "RPF.*?\\.[12].bam$", full.names=TRUE)
gtf <- file.path(path, "Danio_rerio.GRCz10.91.chr1.gtf.gz")
cnts <- countReads(RPFs, gtf=gtf, level="gene",
                   bestpsite=13, readsLen=c(28,29))
head(cnts$RPFs)
## To save the cnts, please try following codes by removing '#'
# write.csv(cbind(cnts$annotation[rownames(cnts$RPFs), ], cnts$RPFs),
#           "counts.csv")

## ----prePareGTF, eval=FALSE---------------------------------------------------
# BiocManager::install("AnnotationHub")
# library(AnnotationHub)
# ah = AnnotationHub()
# ## for human hg38
# hg38 <- query(ah, c("Ensembl", "GRCh38", "gtf"))
# hg38 <- hg38[length(hg38)]
# gtf <- mcols(hg38)$sourceurl
# ## for mouse mm10
# mm10 <- query(ah, c("Ensembl", "GRCm38", "gtf"))
# mm10 <- mm10[length(mm10)]
# gtf <- mcols(mm10)$sourceurl

## ----differentialByEdgeR, class.source='vig'----------------------------------
library(edgeR)  ## install edgeR by BiocManager::install("edgeR")
gp <- c("KD", "KD", "CTL", "CTL") ## sample groups: KD:knockdown; CTL:Control
y <- DGEList(counts = cnts$RPFs, group = gp)
y <- calcNormFactors(y)
design <- model.matrix(~0+gp)
colnames(design) <- sub("gp", "", colnames(design))
y <- estimateDisp(y, design)
## To perform quasi-likelihood F-tests:
fit <- glmQLFit(y, design)
qlf <- glmQLFTest(fit)
topTags(qlf, n=3) # set n=nrow(qlf) to pull all results.
## To perform likelihood ratio tests:
fit <- glmFit(y, design)
lrt <- glmLRT(fit)
topTags(lrt, n=3) # set n=nrow(lrt) to pull all results.

## ----alternativeSplicing, fig.width=6, fig.height=4, class.source='vig'-------
coverage <- coverageDepth(RPFs[grepl("KD1|WT", RPFs)], 
                          gtf=txdb, 
                          level="gene",
                          region="feature with extension")
group1 <- c("RPF.KD1.1", "RPF.KD1.2")
group2 <- c("RPF.WT.1", "RPF.WT.2")
## subset the data, for sample run only
coverage <- lapply(coverage, function(.ele){##do not run this for real data
  .ele$coverage <- lapply(.ele$coverage, `[`, i=seq.int(50))
  .ele$granges <- .ele$granges[seq.int(50)]
  .ele
})
se <- spliceEvent(coverage, group1, group2)
table(se$type)
plotSpliceEvent(se, se$feature[1], coverage, group1, group2)

## ----countRPFandRNA, class.source='vig'---------------------------------------
path <- system.file("extdata", package="ribosomeProfilingQC")
RPFs <- dir(path, "RPF.*?\\.[12].bam$", full.names=TRUE)
RNAs <- dir(path, "mRNA.*?\\.[12].bam$", full.names=TRUE)
gtf <- file.path(path, "Danio_rerio.GRCz10.91.chr1.gtf.gz")

## ----countReadsRPFandRNA,eval=FALSE, class.source='vig'-----------------------
# ## make sure that the order of the genes listed in the bam files for RPFs
# ## and RNAseq data is the same.
# cnts <- countReads(RPFs, RNAs, gtf, level="tx")
# ## To save the cnts, please try following codes by removing '#'
# # rn <- cnts$annotation$GeneID
# # write.csv(cbind(cnts$annotation,
# #                 cnts$RPFs[match(rn, rownames(cnts$RPFs)), ],
# #                 cnts$mRNA[match(rn, rownames(cnts$mRNA)), ]),
# #           "counts.csv")

## ----include=FALSE------------------------------------------------------------
cnts <- readRDS(file.path(path, "cnts.rds"))

## ----translationalEfficiency, class.source='vig'------------------------------
fpkm <- getFPKM(cnts)
TE <- translationalEfficiency(fpkm)

## ----differentialTEbyLimma, class.source='vig'--------------------------------
library(limma)
gp <- c("KD", "KD", "CTL", "CTL") ## sample groups: KD:knockdown; CTL:Control
TE.log2 <- log2(TE$TE + 1)
#plot(TE.log2[, 1], TE.log2[, 3], 
#     xlab=colnames(TE.log2)[1], ylab=colnames(TE.log2)[3],
#     main="Translational Efficiency", pch=16, cex=.5)
design <- model.matrix(~0+gp)
colnames(design) <- sub("gp", "", colnames(design))
fit <- lmFit(TE.log2, design)
fit2 <- eBayes(fit)
topTable(fit2, number=3) ## set number=nrow(fit2) to pull all results

## ----class.source='vig'-------------------------------------------------------
library(edgeR)
gp <- c("KD", "KD", "CTL", "CTL")
design <- model.matrix(~0+gp)
colnames(design) <- sub("gp", "", colnames(design))
y <- lapply(cnts[c("RPFs", "mRNA")], function(.cnt){
  .y <- DGEList(counts = .cnt, 
             samples = data.frame(gp=gp))
  .y <- calcNormFactors(.y)
  .y <- estimateDisp(.y, design)
  .y
})

## To perform likelihood ratio tests:
fit <- lapply(y, glmFit, design = design)
lrt <- lapply(fit, glmLRT)
topTags(lrt[["RPFs"]], n=3) # difference between CTL and KD for RPFs
topTags(lrt[["mRNA"]], n=3) # difference between CTL and KD for mRNA
results <- lapply(lrt, topTags, p.value = 0.05, n = nrow(lrt[[1]]))
RPFs_unique <- setdiff(rownames(results[["RPFs"]]),
                       rownames(results[["mRNA"]]))
mRNA_zero <- rownames(cnts[["mRNA"]])[rowSums(cnts[["mRNA"]]) == 0]
RPFs_unique <- RPFs_unique[!RPFs_unique %in% mRNA_zero]
head(results[["RPFs"]][RPFs_unique, ], n=3) ## top 3 events for translation level

## ----plotTE, class.source='vig'-----------------------------------------------
plotTE(TE, sample=2, xaxis="mRNA", log2=TRUE)
#plotTE(TE, sample=2, xaxis="RPFs", log2=TRUE)

## ----plotTE90, class.source='vig'---------------------------------------------
cvgs <- coverageDepth(RPFs, RNAs, txdb)
TE90 <- translationalEfficiency(cvgs, window = 90, normByLibSize=TRUE)
plotTE(TE90, sample=2, xaxis="mRNA", log2=TRUE)

## ----include=FALSE------------------------------------------------------------
cvgs.utr3 <- coverageDepth(RPFs, RNAs, txdb, region="utr3")

## ----eval=FALSE, class.source='vig'-------------------------------------------
# cvgs.utr3 <- coverageDepth(RPFs, RNAs, txdb, region="utr3")
# TE90.utr3 <- translationalEfficiency(cvgs.utr3, window = 90)
# ## Following code will plot the TE90 for 3'UTR regions.
# ## Try it by removing the '#'.
# #plotTE(TE90.utr3, sample=2, xaxis="mRNA", log2=TRUE)
# #plotTE(TE90.utr3, sample=2, xaxis="RPFs", log2=TRUE)

## ----class.source='vig'-------------------------------------------------------
cnts_normByEdgeR <- normBy(cnts, method = 'edgeR')
TE_edgeR <- translationalEfficiency(cnts_normByEdgeR)
plotTE(TE_edgeR)

## ----class.source='vig'-------------------------------------------------------
TE.log2_norm <- normalizeTEbyLoess(TE)
## please note that output is log2 transformed TE.
plotTE(TE.log2_norm, log2 = FALSE)

## ----eval=FALSE, class.source='vig'-------------------------------------------
# RRS <- ribosomeReleaseScore(TE90, TE90.utr3, log2 = TRUE)
# ## Following code will compare RSS for 2 samples.
# ## Try it by removing the '#'.
# #plot(RRS[, 1], RRS[, 3],
# #     xlab="log2 transformed RRS of KD1",
# #     ylab="log2 transformed RRS of WT1")
# ## Following code will show RSS along TE90.
# ## Try it by removing the '#'.
# #plot(RRS[, 1], log2(TE90$TE[rownames(RRS), 1]),
# #     xlab="log2 transformed RSS of KD1",
# #     ylab="log2 transformed TE of KD1")

## ----metaPlot, class.source='vig'---------------------------------------------
cvgs.utr5 <- coverageDepth(RPFs, RNAs, txdb, region="utr5")
## set sample to different number to plot metagene analysis 
## for different samples
#metaPlot(cvgs.utr5, cvgs, cvgs.utr3, sample=2, xaxis = "RPFs")
metaPlot(cvgs.utr5, cvgs, cvgs.utr3, sample=2, xaxis = "mRNA")

## ----eval=FALSE---------------------------------------------------------------
# ## documentation: https://useast.ensembl.org/Help/Faq?id=468
# gtf <- import("Danio_rerio.GRCz10.91.gtf.gz")

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("AnnotationHub")
# library(AnnotationHub)
# ah = AnnotationHub()
# ## for human hg38
# hg38 <- query(ah, c("Ensembl", "GRCh38", "gtf"))
# hg38 <- hg38[[length(hg38)]]
# ## for mouse mm10
# mm10 <- query(ah, c("Ensembl", "GRCm38", "gtf"))
# mm10 <- mm10[[length(mm10)]]
# ## because the gene ids in TxDb.Mmusculus.UCSC.mm10.knownGene and
# ## TxDb.Hsapiens.UCSC.hg38.knownGene
# ## are entriz_id, the gene_id in mm10 or hg38 need to changed to entriz_id.
# library(ChIPpeakAnno)
# library(org.Mm.eg.db)
# mm10$gene_id <- ChIPpeakAnno::xget(mm10$gene_id, org.Mm.egENSEMBL2EG)
# library(org.Hg.eg.db)
# hg38$gene_id <- ChIPpeakAnno::xget(hg38$gene_id, org.Mm.egENSEMBL2EG)

## ----eval=FALSE---------------------------------------------------------------
# gtf <- gtf[!is.na(gtf$gene_id)]
# gtf <- gtf[gtf$gene_id!=""]
# ## protein coding
# protein <-
#   gtf$gene_id[gtf$transcript_biotype %in%
#                   c("IG_C_gene", "IG_D_gene", "IG_J_gene", "IG_LV_gene",
#                     "IG_M_gene", "IG_V_gene", "IG_Z_gene",
#                     "nonsense_mediated_decay", "nontranslating_CDS",
#                     "non_stop_decay",
#                     "protein_coding", "TR_C_gene", "TR_D_gene", "TR_gene",
#                     "TR_J_gene", "TR_V_gene")]
# ## mitochondrial genes
# mito <- gtf$gene_id[grepl("^mt\\-", gtf$gene_name) |
#                         gtf$transcript_biotype %in% c("Mt_tRNA", "Mt_rRNA")]
# ## long noncoding
# lincRNA <-
#   gtf$gene_id[gtf$transcript_biotype %in%
#                   c("3prime_overlapping_ncrna", "lincRNA",
#                     "ncrna_host", "non_coding")]
# ## short noncoding
# sncRNA <-
#   gtf$gene_id[gtf$transcript_biotype %in%
#                   c("miRNA", "miRNA_pseudogene", "misc_RNA",
#                     "misc_RNA_pseudogene", "Mt_rRNA", "Mt_tRNA",
#                     "Mt_tRNA_pseudogene", "ncRNA", "pre_miRNA",
#                     "RNase_MRP_RNA", "RNase_P_RNA", "rRNA", "rRNA_pseudogene",
#                     "scRNA_pseudogene", "snlRNA", "snoRNA",
#                     "snRNA_pseudogene", "SRP_RNA", "tmRNA", "tRNA",
#                     "tRNA_pseudogene", "ribozyme", "scaRNA", "sRNA")]
# ## pseudogene
# pseudogene <-
#   gtf$gene_id[gtf$transcript_biotype %in%
#                   c("disrupted_domain", "IG_C_pseudogene", "IG_J_pseudogene",
#                     "IG_pseudogene", "IG_V_pseudogene", "processed_pseudogene",
#                     "pseudogene", "transcribed_processed_pseudogene",
#                     "transcribed_unprocessed_pseudogene",
#                     "translated_processed_pseudogene",
#                     "translated_unprocessed_pseudogene", "TR_J_pseudogene",
#                     "TR_V_pseudogene", "unitary_pseudogene",
#                     "unprocessed_pseudogene")]
# danrer10.annotations <- list(protein=unique(protein),
#                              mito=unique(mito),
#                              lincRNA=unique(lincRNA),
#                              pseudogene=unique(pseudogene))

## ----loadPresavedAnnotations, class.source='vig'------------------------------
danrer10.annotations <- 
  readRDS(system.file("extdata",
                      "danrer10.annotations.rds",
                      package = "ribosomeProfilingQC"))

## ----fig.width=4, fig.height=4, class.source='vig'----------------------------
library(ribosomeProfilingQC)
library(txdbmaker)
## prepare CDS annotation
txdb <- makeTxDbFromGFF(system.file("extdata",
                                    "Danio_rerio.GRCz10.91.chr1.gtf.gz",
                                    package="ribosomeProfilingQC"),
                        organism = "Danio rerio",
                        chrominfo = seqinfo(Drerio)["chr1"],
                        taxonomyId = 7955)
CDS <- prepareCDS(txdb)

library(Rsamtools)
## input the bamFile from the ribosomeProfilingQC package 
bamfilename <- system.file("extdata", "RPF.WT.1.bam",
                           package="ribosomeProfilingQC")
## For your own data, please set bamfilename as your file path.
yieldSize <- 10000000
bamfile <- BamFile(bamfilename, yieldSize = yieldSize)

pc <- getPsiteCoordinates(bamfile, bestpsite = 13)
readsLengths <- 20:34
fl <- FLOSS(pc, ref = danrer10.annotations$protein, 
            CDS = CDS, readLengths=readsLengths, level="gene", draw = FALSE)
fl.max <- t(fl[c(1, which.max(fl$cooks.distance)), as.character(readsLengths)])
matplot(fl.max, type = "l", x=readsLengths, 
        xlab="Fragment Length", ylab="Fraction of Reads", 
        col = c("gray", "red"), lwd = 2, lty = 1)
legend("topright",  legend = c("ref", "selected gene"), 
       col = c("gray", "red"), lwd = 2, lty = 1, cex=.5)

