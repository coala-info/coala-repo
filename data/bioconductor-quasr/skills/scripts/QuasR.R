# Code example from 'QuasR' vignette. See references/ for full tutorial.

## ----options, results='hide', echo=FALSE--------------------------------------
#options(width=65)
options('useFancyQuotes' = FALSE, continue = " ", digits = 3)

## ----cite, eval=TRUE----------------------------------------------------------
citation("QuasR")

## ----install, eval=FALSE------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("QuasR")

## ----loadLibraries, eval=TRUE-------------------------------------------------
suppressPackageStartupMessages({
    library(QuasR)
    library(BSgenome)
    library(Rsamtools)
    library(rtracklayer)
    library(GenomicFeatures)
    library(txdbmaker)
    library(Gviz)
})

## ----help1, eval=FALSE--------------------------------------------------------
# help.start()

## ----loadQuasRLibrary, eval=FALSE---------------------------------------------
# library(QuasR)

## ----help2, eval=FALSE--------------------------------------------------------
# ?preprocessReads

## ----help3, eval=FALSE--------------------------------------------------------
# help("preprocessReads")

## ----assign, eval=FALSE-------------------------------------------------------
# x <- 2

## ----ls, eval=FALSE-----------------------------------------------------------
# ls()

## ----printObject, eval=FALSE--------------------------------------------------
# x

## ----SampleSession1, eval=TRUE------------------------------------------------
file.copy(system.file(package = "QuasR", "extdata"), ".", recursive = TRUE)

## ----SampleSession2, eval=TRUE------------------------------------------------
sampleFile <- "extdata/samples_chip_single.txt"
genomeFile <- "extdata/hg19sub.fa"

proj <- qAlign(sampleFile, genomeFile)
proj

## ----SampleSession3, eval=TRUE------------------------------------------------
qQCReport(proj, "extdata/qc_report.pdf")

## ----SampleSession4, eval=TRUE------------------------------------------------
library(rtracklayer)
library(GenomicFeatures)
annotFile <- "extdata/hg19sub_annotation.gtf"
txStart <- import.gff(annotFile, format = "gtf", feature.type = "start_codon")
promReg <- promoters(txStart, upstream = 500, downstream = 500)
names(promReg) <- mcols(promReg)$transcript_name

promCounts <- qCount(proj, query = promReg)
promCounts

## ----sampleFileSingle, echo=FALSE, results="asis"-----------------------------
cat(paste(readLines(system.file(package = "QuasR",
                                "extdata", "samples_chip_single.txt")),
          collapse = "\n"))

## ----sampleFilePaired, echo=FALSE, results="asis"-----------------------------
cat(paste(readLines(system.file(package = "QuasR",
                                "extdata", "samples_rna_paired.txt")),
      collapse = "\n"))

## ----sampleFile, eval=FALSE---------------------------------------------------
# sampleFile1 <- system.file(package="QuasR", "extdata",
#                            "samples_chip_single.txt")
# sampleFile2 <- system.file(package="QuasR", "extdata",
#                            "samples_rna_paired.txt")

## ----<sampleFileSeqToBam, eval=FALSE------------------------------------------
# sampleFile1 <- "samples_fastq.txt"
# sampleFile2 <- "samples_bam.txt"
# 
# proj1 <- qAlign(sampleFile1, genomeFile)
# 
# write.table(alignments(proj1)$genome, sampleFile2, sep="\t", row.names=FALSE)
# 
# proj2 <- qAlign(sampleFile2, genomeFile)

## ----auxFile, echo=FALSE, results="asis"--------------------------------------
cat(paste(readLines(system.file(package = "QuasR",
                                "extdata", "auxiliaries.txt")),
          collapse = "\n"))

## ----auxiliaryFile, eval=TRUE-------------------------------------------------
auxFile <- system.file(package = "QuasR", "extdata", "auxiliaries.txt")

## ----selectGenomeBSgenome, eval=TRUE------------------------------------------
available.genomes()
genomeName <- "BSgenome.Hsapiens.UCSC.hg19"

## ----selectGenomeFile, eval=FALSE---------------------------------------------
# genomeFile <- system.file(package="QuasR", "extdata", "hg19sub.fa")

## ----preprocessReadsSingle,eval=TRUE------------------------------------------
td <- tempdir()
infiles <- system.file(package = "QuasR", "extdata",
                       c("rna_1_1.fq.bz2","rna_2_1.fq.bz2"))
outfiles <- file.path(td, basename(infiles))
res <- preprocessReads(filename = infiles,
                       outputFilename = outfiles,
                       truncateEndBases = 3,
                       Lpattern = "AAAAAAAAAA",
                       minLength = 14, 
                       nBases = 2)
res
unlink(outfiles)

## ----preprocessReadsPaired,eval=TRUE------------------------------------------
td <- tempdir()
infiles1 <- system.file(package = "QuasR", "extdata", "rna_1_1.fq.bz2")
infiles2 <- system.file(package = "QuasR", "extdata", "rna_1_2.fq.bz2")
outfiles1 <- file.path(td, basename(infiles1))
outfiles2 <- file.path(td, basename(infiles2))
res <- preprocessReads(filename = infiles1,
                       filenameMate = infiles2,
                       outputFilename = outfiles1,
                       outputFilenameMate = outfiles2,
                       nBases = 0)
res

## ----ChIP_copyExtdata, eval=TRUE----------------------------------------------
file.copy(system.file(package = "QuasR", "extdata"), ".", recursive = TRUE)

## ----ChIP_qAlign, eval=TRUE---------------------------------------------------
sampleFile <- "extdata/samples_chip_single.txt"
auxFile <- "extdata/auxiliaries.txt"
genomeFile <- "extdata/hg19sub.fa"

proj1 <- qAlign(sampleFile, genome = genomeFile, auxiliaryFile = auxFile)
proj1

## ----ChIP_bamfiles1, eval=TRUE------------------------------------------------
list.files("extdata", pattern = ".bam$")

## ----ChIP_bamfiles2, eval=TRUE------------------------------------------------
list.files("extdata", pattern = "^chip_1_1_")[1:3]

## ----ChIP_qcplot1, eval=TRUE, echo=FALSE--------------------------------------
qcdat1 <- qQCReport(proj1, pdfFilename = "extdata/qc_report.pdf")

## ----ChIP_qcplots2, eval=TRUE-------------------------------------------------
qQCReport(proj1, pdfFilename = "extdata/qc_report.pdf")

## ----ChIP_alignmentStats, eval=TRUE-------------------------------------------
alignmentStats(proj1)

## ----ChIP_qExportWig, eval=TRUE-----------------------------------------------
qExportWig(proj1, binsize = 100L, scaling = TRUE, collapseBySample = TRUE)

## ----ChIP_GenomicFeatures, eval=TRUE------------------------------------------
library(txdbmaker)
annotFile <- "extdata/hg19sub_annotation.gtf"
chrLen <- scanFaIndex(genomeFile)
chrominfo <- data.frame(chrom = as.character(seqnames(chrLen)),
                        length = width(chrLen),
                        is_circular = rep(FALSE, length(chrLen)))
txdb <- makeTxDbFromGFF(file = annotFile, format = "gtf",
                        chrominfo = chrominfo,
                        dataSource = "Ensembl",
                        organism = "Homo sapiens")
promReg <- promoters(txdb, upstream = 1000, downstream = 500,
                     columns = c("gene_id","tx_id"))
gnId <- vapply(mcols(promReg)$gene_id,
               FUN = paste, FUN.VALUE = "",
               collapse = ",")
promRegSel <- promReg[ match(unique(gnId), gnId) ]
names(promRegSel) <- unique(gnId)
promRegSel

## ----ChIP_qCount, eval=TRUE---------------------------------------------------
cnt <- qCount(proj1, promRegSel)
cnt

## ----ChIP_visualize, eval=TRUE, fig.width=8, fig.height=4.5-------------------
gr1 <- import("Sample1.wig.gz")
gr2 <- import("Sample2.wig.gz")

library(Gviz)
axisTrack <- GenomeAxisTrack()
dTrack1 <- DataTrack(range = gr1, name = "Sample 1", type = "h")
dTrack2 <- DataTrack(range = gr2, name = "Sample 2", type = "h")
txTrack <- GeneRegionTrack(txdb, name = "Transcripts", showId = TRUE)
plotTracks(list(axisTrack, dTrack1, dTrack2, txTrack),
           chromosome = "chr3", extend.left = 1000)

## ----ChIP_rtracklayer, eval=TRUE----------------------------------------------
library(rtracklayer)
annotationFile <- "extdata/hg19sub_annotation.gtf"
tssRegions <- import.gff(annotationFile, format = "gtf",
                         feature.type = "start_codon",
                         colnames = "gene_name")
tssRegions <- tssRegions[!duplicated(tssRegions)]
names(tssRegions) <- rep("TSS", length(tssRegions))
head(tssRegions)

## ----ChIP_qProfile, eval=TRUE-------------------------------------------------
prS <- qProfile(proj1, tssRegions, upstream = 3000, downstream = 3000, 
                orientation = "same")
prO <- qProfile(proj1, tssRegions, upstream = 3000, downstream = 3000, 
                orientation = "opposite")
lapply(prS, "[", , 1:10)

## ----ChIP_visualizeProfile, eval=TRUE, fig.width=8, fig.height=4.5------------
prCombS <- do.call("+", prS[-1]) / prS[[1]]
prCombO <- do.call("+", prO[-1]) / prO[[1]]

plot(as.numeric(colnames(prCombS)), filter(prCombS[1,], rep(1/100,100)), 
     type = 'l', xlab = "Position relative to TSS",
     ylab = "Mean no. of alignments")
lines(as.numeric(colnames(prCombO)), filter(prCombO[1,], rep(1/100,100)), 
      type = 'l', col = "red")
legend(title = "strand", legend = c("same as query","opposite of query"), 
       x = "topleft", col = c("black","red"),
       lwd = 1.5, bty = "n", title.adj = 0.1)

## ----ChIP_BSgenomeProject, eval=FALSE-----------------------------------------
# file.copy(system.file(package="QuasR", "extdata"), ".", recursive=TRUE)
# 
# sampleFile <- "extdata/samples_chip_single.txt"
# auxFile <- "extdata/auxiliaries.txt"
# 
# available.genomes() # list available genomes
# genomeName <- "BSgenome.Hsapiens.UCSC.hg19"
# 
# proj1 <- qAlign(sampleFile, genome=genomeName, auxiliaryFile=auxFile)
# proj1

## ----RNA_qAlign, eval=TRUE----------------------------------------------------
file.copy(system.file(package = "QuasR", "extdata"), ".", recursive = TRUE)

sampleFile <- "extdata/samples_rna_paired.txt"
genomeFile <- "extdata/hg19sub.fa"

proj2 <- qAlign(sampleFile, genome = genomeFile,
                splicedAlignment = TRUE, aligner = "Rhisat2")
proj2

## ----RNA_alignmentStats, eval=TRUE--------------------------------------------
proj2unspl <- qAlign(sampleFile, genome = genomeFile,
                     splicedAlignment = FALSE)

alignmentStats(proj2)
alignmentStats(proj2unspl)

## ----RNA_qCount, eval=TRUE----------------------------------------------------
geneLevels <- qCount(proj2, txdb, reportLevel = "gene")
exonLevels <- qCount(proj2, txdb, reportLevel = "exon")

head(geneLevels)
head(exonLevels)

## ----RNA_RPMK, eval=TRUE------------------------------------------------------
geneRPKM <- t(t(geneLevels[,-1] / geneLevels[,1] * 1000)
              / colSums(geneLevels[,-1]) * 1e6)
geneRPKM

## ----RNA_junction, eval=TRUE--------------------------------------------------
exonJunctions <- qCount(proj2, NULL, reportLevel = "junction")
exonJunctions

## ----RNA_junction2, eval=TRUE-------------------------------------------------
knownIntrons <- unlist(intronsByTranscript(txdb))
isKnown <- overlapsAny(exonJunctions, knownIntrons, type = "equal")
table(isKnown)

tapply(rowSums(as.matrix(mcols(exonJunctions))),
       isKnown, summary)

## ----RNA_includeSpliced, eval=TRUE--------------------------------------------
exonBodyLevels <- qCount(proj2, txdb, reportLevel = "exon",
                         includeSpliced = FALSE)
summary(exonLevels - exonBodyLevels)

## ----RNA_qcplot1, eval=TRUE, echo=FALSE---------------------------------------
qcdat2 <- qQCReport(proj2unspl, pdfFilename = "qc_report.pdf")

## ----miRNA_extdata, eval=TRUE-------------------------------------------------
file.copy(system.file(package = "QuasR", "extdata"), ".", recursive = TRUE)

## ----miRNA_preprocessReads, eval=TRUE-----------------------------------------
# prepare sample file with processed reads filenames
sampleFile <- file.path("extdata", "samples_mirna.txt")
sampleFile
sampleFile2 <- sub(".txt", "_processed.txt", sampleFile)
sampleFile2

tab <- read.delim(sampleFile, header = TRUE, as.is = TRUE)
tab

tab2 <- tab
tab2$FileName <- sub(".fa", "_processed.fa", tab$FileName)
write.table(tab2, sampleFile2, sep = "\t", quote = FALSE, row.names = FALSE)
tab2

# remove adapters
oldwd <- setwd(dirname(sampleFile))
res <- preprocessReads(tab$FileName,
                       tab2$FileName,
                       Rpattern = "TGGAATTCTCGGGTGCCAAGG")
res
setwd(oldwd)

## ----miRNA_lengthes, eval=TRUE, fig.width=6, fig.height=4.5-------------------
# get read lengths
library(Biostrings)
oldwd <- setwd(dirname(sampleFile))
lens <- fasta.seqlengths(tab$FileName, nrec = 1e5)
lens2 <- fasta.seqlengths(tab2$FileName, nrec = 1e5)
setwd(oldwd)
# plot length distribution
lensTab <- rbind(raw = tabulate(lens, 50),
                 processed = tabulate(lens2, 50))
colnames(lensTab) <- 1:50
barplot(lensTab/rowSums(lensTab)*100,
        xlab = "Read length (nt)", ylab = "Percent of reads")
legend(x = "topleft", bty = "n", fill = gray.colors(2),
       legend = rownames(lensTab))

## ----miRNA_qAlign, eval=TRUE--------------------------------------------------
proj3 <- qAlign(sampleFile2, genomeFile, maxHits = 50)
alignmentStats(proj3)

## ----miRNA_prepareQuery, eval=TRUE--------------------------------------------
mirs <- import("extdata/mirbaseXX_qsr.gff3")
names(mirs) <- mirs$Name
preMirs <- mirs[ mirs$type == "miRNA_primary_transcript" ]
matureMirs <- mirs[ mirs$type == "miRNA" ]

## ----miRNA_coverage, eval=TRUE, fig.width=6, fig.height=4.5-------------------
library(Rsamtools)
alns <- scanBam(alignments(proj3)$genome$FileName,
                param = ScanBamParam(what = scanBamWhat(),
                                     which = preMirs[1]))[[1]]
alnsIR <- IRanges(start = alns$pos - start(preMirs), width = alns$qwidth)
mp <- barplot(as.vector(coverage(alnsIR)), names.arg = seq_len(max(end(alnsIR))),
              xlab = "Relative position in pre-miRNA",
              ylab = "Alignment coverage")
rect(xleft = mp[start(matureMirs) - start(preMirs) + 1,1],
     ybottom = -par('cxy')[2],
     xright = mp[end(matureMirs) - start(preMirs) + 1,1],
     ytop = 0, col = "#CCAA0088", border = NA, xpd = NA)

## ----miRNA_extendQuery, eval=TRUE---------------------------------------------
matureMirsExtended <- resize(matureMirs, width = 1L, fix = "start") + 3L

## ----miRNA_quantify, eval=TRUE------------------------------------------------
# quantify mature miRNAs
cnt <- qCount(proj3, matureMirsExtended, orientation = "same")
cnt

# quantify pre-miRNAs
cnt <- qCount(proj3, preMirs, orientation = "same")
cnt

## ----Bis_qAlign, eval=TRUE----------------------------------------------------
file.copy(system.file(package = "QuasR", "extdata"), ".", recursive = TRUE)

sampleFile <- "extdata/samples_bis_single.txt"
genomeFile <- "extdata/hg19sub.fa"

proj4 <- qAlign(sampleFile, genomeFile, bisulfite = "dir")
proj4

## ----Bis_qMeth1, eval=TRUE----------------------------------------------------
meth <- qMeth(proj4, mode = "CpGcomb", collapseBySample = TRUE)
meth

## ----Bis_qMeth2, eval=TRUE----------------------------------------------------
chrs <- readDNAStringSet(genomeFile)
sum(vcountPattern("CG",chrs))
length(qMeth(proj4))
length(qMeth(proj4, keepZero = FALSE))

## ----Bis_visualize, eval=TRUE, fig.height=4.5, fig.width=8--------------------
percMeth <- mcols(meth)[,2] * 100 / mcols(meth)[,1]
summary(percMeth)

axisTrack <- GenomeAxisTrack()
dTrack1 <- DataTrack(range = gr1, name = "H3K4me3", type = "h")
dTrack2 <- DataTrack(range = meth, data = percMeth,
                     name = "Methylation", type = "p")
txTrack <- GeneRegionTrack(txdb, name = "Transcripts", showId = TRUE)
plotTracks(list(axisTrack, dTrack1, dTrack2, txTrack),
           chromosome = "chr3", extend.left = 1000)

## ----Bis_query, eval=TRUE-----------------------------------------------------
qMeth(proj4, query = GRanges("chr1",IRanges(start = 31633, width = 2)),
      collapseBySample = TRUE)
qMeth(proj4, query = promRegSel, collapseByQueryRegion = TRUE,
      collapseBySample = TRUE)

## ----snpFile, echo=FALSE, results="asis"--------------------------------------
cat(paste(c(readLines(system.file(package = "QuasR",
                                  "extdata", "hg19sub_snp.txt"))[1:4], "..."),
          collapse = "\n"))

## ----Alelle_Extdata, eval=TRUE------------------------------------------------
file.copy(system.file(package = "QuasR", "extdata"), ".", recursive = TRUE)

## ----Allele_qAlign, eval=TRUE-------------------------------------------------
sampleFile <- "extdata/samples_chip_single.txt"
genomeFile <- "extdata/hg19sub.fa"
snpFile <- "extdata/hg19sub_snp.txt"
proj1SNP <- qAlign(sampleFile, genome = genomeFile, snpFile = snpFile)
proj1SNP

## ----Allele_qCount, eval=TRUE-------------------------------------------------
head(qCount(proj1, promRegSel))
head(qCount(proj1SNP, promRegSel))

## ----Allele_Bis, eval=TRUE----------------------------------------------------
sampleFile <- "extdata/samples_bis_single.txt"
genomeFile <- "extdata/hg19sub.fa"
proj4SNP <- qAlign(sampleFile, genomeFile,
                   snpFile = snpFile, bisulfite = "dir")
head(qMeth(proj4SNP, mode = "CpGcomb", collapseBySample = TRUE))

## ----qcplotsFig1, eval=TRUE, echo=FALSE, fig.height=4, fig.width=8------------
QuasR:::plotQualByCycle(qcdat1$raw$qa, lmat = rbind(1:2))

## ----qcplotsFig2, eval=TRUE, echo=FALSE, fig.height=4, fig.width=8------------
QuasR:::plotNuclByCycle(qcdat1$raw$qa, lmat = rbind(1:2))

## ----qcplotsFig3, eval=TRUE, echo=FALSE, fig.height=4, fig.width=8------------
QuasR:::plotDuplicated(qcdat1$raw$qa, lmat = rbind(1:2))

## ----qcplotsFig4, eval=TRUE, echo=FALSE, fig.height=4, fig.width=8------------
QuasR:::plotMappings(qcdat1$raw$mapdata, a4layout = FALSE)

## ----qcplotsFig5, eval=TRUE, echo=FALSE, fig.height=4, fig.width=8------------
QuasR:::plotUniqueness(qcdat1$raw$unique, a4layout = FALSE)

## ----qcplotsFig6, eval=TRUE, echo=FALSE, fig.height=4, fig.width=8------------
QuasR:::plotErrorsByCycle(qcdat1$raw$mm, lmat = rbind(1:2))

## ----qcplotsFig7, eval=TRUE, echo=FALSE, fig.height=4, fig.width=8------------
QuasR:::plotMismatchTypes(qcdat1$raw$mm, lmat = rbind(1:2))

## ----qcplotsFig8, eval=TRUE, echo=FALSE, fig.height=4, fig.width=8------------
QuasR:::plotFragmentDistribution(qcdat2$raw$frag, lmat = rbind(1:2))

## ----alignmentStats, eval=TRUE------------------------------------------------
# using bam files
alignmentStats(alignments(proj1)$genome$FileName)
alignmentStats(unlist(alignments(proj1)$aux))

# using a qProject object
alignmentStats(proj1)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

## ----cleanUp, eval=TRUE, echo=FALSE-------------------------------------------
unlink("extdata", recursive = TRUE, force = TRUE)

