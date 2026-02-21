# Code example from 'ChIPpeakAnno' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(message = FALSE, 
                      warning = FALSE,
          					  tidy = FALSE, 
          					  fig.width = 6, 
          					  fig.height = 6,
          					  fig.align = "center")
# Handle the biofilecache error
library(BiocFileCache)
bfc <- BiocFileCache()
res <- bfcquery(bfc, 
                "annotationhub.index.rds", 
                field = "rname", 
                exact = TRUE) 
bfcremove(bfc, rids = res$rid)

## ----fig.cap = "A workflow for ChIP-seq data analysis", echo = FALSE, out.width = "100%", out.height = "100%"----
png <- system.file("extdata", "dataFlow.png", package = "ChIPpeakAnno")

knitr::include_graphics(png)

## -----------------------------------------------------------------------------
library(ChIPpeakAnno)

macs_peak <- system.file("extdata", "MACS_peaks.xls", 
                         package = "ChIPpeakAnno")
macs_peak_gr <- toGRanges(macs_peak, format = "MACS")
head(macs_peak_gr, n = 2)

## -----------------------------------------------------------------------------
# Use Ensembl annotation package:
library(EnsDb.Hsapiens.v86)

ensembl.hs86.transcript <- transcripts(EnsDb.Hsapiens.v86)

## -----------------------------------------------------------------------------
# Use Ensembl annotation package:
macs_peak_ensembl <- annotatePeakInBatch(macs_peak_gr, 
										 AnnotationData = ensembl.hs86.transcript)
head(macs_peak_ensembl, n = 2)

## -----------------------------------------------------------------------------
library(biomaRt)
mart <- useMart(biomart = "ENSEMBL_MART_ENSEMBL",
                dataset = "hsapiens_gene_ensembl")

# Use Ensembl annotation package:
macs_peak_ensembl <- addGeneIDs(annotatedPeak = macs_peak_ensembl, 
                                mart = mart,
                                feature_id_type = "ensembl_transcript_id",
                                IDs2Add = "hgnc_symbol")
head(macs_peak_ensembl, n = 2)

## -----------------------------------------------------------------------------
# Convert GFF to GRanges:
macs_peak_gff <- system.file("extdata", "GFF_peaks_hg38.gff", 
                             package = "ChIPpeakAnno")
macs_peak_gr1 <- toGRanges(macs_peak_gff, format = "GFF", header = FALSE)
head(macs_peak_gr1, n = 2)

# Convert BED to GRanges:
macs_peak_bed <- system.file("extdata", "MACS_output_hg38.bed", 
                             package = "ChIPpeakAnno")
macs_peak_gr2 <- toGRanges(macs_peak_bed, format = "BED", header = FALSE)
head(macs_peak_gr2, n = 2)

## -----------------------------------------------------------------------------
# For two samples:
data(peaks1)
data(peaks2)
head(peaks1, n = 2)
head(peaks2, n = 2)
ol <- findOverlapsOfPeaks(peaks1, peaks2)
names(ol)

# For three samples:
data(peaks3)
ol2 <- findOverlapsOfPeaks(peaks1, peaks2, peaks3,
                           connectedPeaks = "min")

# Find peaks with at least 90% overlap:
ol3 <- findOverlapsOfPeaks(peaks1, peaks2, minoverlap = 0.9)

## -----------------------------------------------------------------------------
# For peaks1:
length(ol$peaklist[["peaks1"]])

# For peaks2:
length(ol$peaklist[["peaks2"]])

## ----results = "hide", fig.cap = "Venn diagram showing the number of overlapping peaks for two samples", fig.small = TRUE----
# For two samples:
venn <- makeVennDiagram(ol, totalTest = 100,
                        fill = c("#009E73", "#F0E442"),
                        col = c("#D55E00", "#0072B2"),
                        cat.col = c("#D55E00", "#0072B2"))

# For three samples:
venn2 <- makeVennDiagram(ol2, totalTest = 100,
                         fill = c("#CC79A7", "#56B4E9", "#F0E442"),
                         col = c("#D55E00", "#0072B2", "#E69F00"),
                         cat.col = c("#D55E00", "#0072B2", "#E69F00"))

# For peaks overlap at least 90%:
venn3 <- makeVennDiagram(ol3, totalTest = 100,
                         fill = c("#009E73", "#F0E442"),
                         col = c("#D55E00", "#0072B2"),
                         cat.col = c("#D55E00", "#0072B2"))

## ----eval = FALSE-------------------------------------------------------------
# if (!library(Vennerable)) {
#   install.packages("Vennerable", repos="http://R-Forge.R-project.org")
#   library(Vennerable)
# }
# 
# n <- which(colnames(ol$vennCounts) == "Counts") - 1
# set_names <- colnames(ol$vennCounts)[1:n]
# weight <- ol$vennCounts[, "Counts"]
# names(weight) <- apply(ol$vennCounts[, 1:n], 1, base::paste, collapse = "")
# v <- Venn(SetNames = set_names, Weight = weight)
# plot(v)

## -----------------------------------------------------------------------------
names(ol$overlappingPeaks)
dim(ol$overlappingPeaks[["peaks1///peaks2"]])
ol$overlappingPeaks[["peaks1///peaks2"]][1:2, ]
unique(ol$overlappingPeaks[["peaks1///peaks2"]][["overlapFeature"]])
pie1(table(ol$overlappingPeaks[["peaks1///peaks2"]]$overlapFeature))

## ----echo = FALSE-------------------------------------------------------------
library(knitr)

Resource <- c("Ensembl", "NCBI RefSeq")
Generated_by <- c("EMBL-EBI", "NCBI")
Annotation_criteria <- c("Comprehensive (most transcripts)", "Conservative (fewer transcripts)")
Gene_id_name <- c("Ensembl gene ID", "NCBI Gene ID, or entrezGene ID, or entrez ID")
URL <- c("https://ftp.Ensembl.org/pub/", "https://ftp.ncbi.nlm.nih.gov/refseq/")
df <- data.frame(Resource, Generated_by, Annotation_criteria, URL)

kable(df, caption = 'Commonly used annotation resources')

## ----echo = FALSE-------------------------------------------------------------
library(knitr)

Human <- c("[hg38.refGene.gtf.gz](https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/genes/hg38.refGene.gtf.gz)",
           "[hg38.ncbiRefSeq.gtf.gz](https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/genes/hg38.ncbiRefSeq.gtf.gz)",
           "[hg38.knownGene.gtf.gz](https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/genes/hg38.knownGene.gtf.gz)")
Mouse <- c("[mm10.refGene.gtf.gz](https://hgdownload.soe.ucsc.edu/goldenPath/mm10/bigZips/genes/mm10.refGene.gtf.gz)",
           "[mm10.ncbiRefSeq.gtf.gz](https://hgdownload.soe.ucsc.edu/goldenPath/mm10/bigZips/genes/mm10.ncbiRefSeq.gtf.gz)",
           "[mm10.knownGene.gtf.gz](https://hgdownload.soe.ucsc.edu/goldenPath/mm10/bigZips/genes/mm10.knownGene.gtf.gz)")
Remark <- c("Based on RefSeq transcripts aligned by UCSC followed by manual curation",
            "Based on RefSeq transcripts as aligned by NCBI",
            "Based on Ensembl gene models")
df <- data.frame(Human, Mouse, Remark)

kable(df, caption = "UCSC Genome Browser hosted annotation files")

## -----------------------------------------------------------------------------
library(AnnotationHub)

ah <- AnnotationHub()

# Obtain EnsDb:
EnsDb_Mmusculus_all <- query(ah, pattern = c("Mus musculus", "EnsDb"))
head(EnsDb_Mmusculus_all, n = 2)
EnsDb_Mmusculus <- EnsDb_Mmusculus_all[["AH53222"]]
class(EnsDb_Mmusculus)

# Obtain TxDb:
TxDb_Mmusculus_all <- query(ah, pattern = c("Mus musculus", "TxDb"))
head(TxDb_Mmusculus_all, n = 2)
TxDb_Mmusculus <- TxDb_Mmusculus_all[["AH52264"]]
class(TxDb_Mmusculus)

## ----eval = FALSE-------------------------------------------------------------
# library(biomaRt)
# 
# listMarts()
# head(listDatasets(useMart("ENSEMBL_MART_ENSEMBL")), n = 2)
# mart <- useMart(biomart = "ENSEMBL_MART_ENSEMBL",
#                 dataset = "mmusculus_gene_ensembl")
# anno_from_biomart <- getAnnotation(mart,
#                                    featureType = "transcript")
# head(anno_from_biomart, n = 2)

## -----------------------------------------------------------------------------
library(EnsDb.Hsapiens.v86)

anno_ensdb_transcript <- toGRanges(EnsDb.Hsapiens.v86, 
                                   feature = "transcript")
head(anno_ensdb_transcript, n = 2)

## -----------------------------------------------------------------------------
anno_ensdb_transcript <- transcripts(EnsDb.Hsapiens.v86)

head(anno_ensdb_transcript, n = 2)

## ----fig.cap = "Peak count distribution around TSSs", warning = FALSE---------
library(TxDb.Hsapiens.UCSC.hg38.knownGene)

annotation_data <- transcripts(TxDb.Hsapiens.UCSC.hg38.knownGene)
binOverFeature(macs_peak_gr2, 
               featureSite = "FeatureStart",
               nbins = 20,
               annotationData = annotation_data,
               xlab = "peak distance from TSS (bp)", 
               ylab = "peak count", 
               main = "Distribution of aggregated peak numbers around TSS")

## ----fig.cap = "Bar graph showing peak distributions over different genomic features"----
chromosome_region <- assignChromosomeRegion(macs_peak_gr2,
                                            TxDb = TxDb.Hsapiens.UCSC.hg38.knownGene,
                                            nucleotideLevel = FALSE,
                                            precedence=c("Promoters",
                                                         "immediateDownstream", 
                                                         "fiveUTRs", 
                                                         "threeUTRs",
                                                         "Exons", 
                                                         "Introns"))

# optional helper function to rotate x-axis labels for barplot(): 
# ref: https://stackoverflow.com/questions/10286473/rotating-x-axis-labels-in-r-for-barplot
rotate_x <- function(data, rot_angle) {
  plt <- barplot(data, xaxt = "n")
  text(plt, par("usr")[3], 
       labels = names(data), 
       srt = rot_angle, adj = c(1.1,1.1), 
       xpd = TRUE, cex = 0.6)
}

rotate_x(chromosome_region[["percentage"]], 45)

## ----fig.cap = "Pie graph showing peak distributions over features at different levels"----
genomicElementDistribution(macs_peak_gr1, 
                           TxDb = TxDb.Hsapiens.UCSC.hg38.knownGene)

## ----fig.cap = "Bar graph showing peak distributions over features at different levels"----
macs_peaks <- GRangesList(rep1 = macs_peak_gr1,
                          rep2 = macs_peak_gr2)
genomicElementDistribution(macs_peaks, 
                           TxDb = TxDb.Hsapiens.UCSC.hg38.knownGene)

## ----fig.cap = "UpSet plot showing the overlappings of peak distributions among different genomic features"----
library(UpSetR)

res <- genomicElementUpSetR(macs_peak_gr1,
                            TxDb.Hsapiens.UCSC.hg38.knownGene)
upset(res[["plotData"]], 
      nsets = length(colnames(res$plotData)), 
      nintersects = NA)

## ----fig.cap = "How does peak-centric annotation method work", echo = FALSE, out.width = "100%", out.height = "100%"----
png <- system.file("extdata", "annoPeakCentric.png", package = "ChIPpeakAnno")

knitr::include_graphics(png)

## ----fig.cap = "How does feature-centric annotation method work", echo = FALSE, out.width = "100%", out.height = "100%"----
png <- system.file("extdata", "annoFeatureCentric1.png", package = "ChIPpeakAnno")

knitr::include_graphics(png)

## ----fig.cap = "How to define target region with bindingRegion", echo = FALSE, out.width = "100%", out.height = "100%"----
png <- system.file("extdata", "annoFeatureCentric2.png", package = "ChIPpeakAnno")

knitr::include_graphics(png)

## -----------------------------------------------------------------------------
library(TxDb.Hsapiens.UCSC.hg18.knownGene)

data(myPeakList)
peak_to_anno <- myPeakList[1:100]
anno_data <- transcripts(TxDb.Hsapiens.UCSC.hg18.knownGene)

annotated_peak <- annotatePeakInBatch(peak_to_anno, 
                                      output = "nearestLocation",
                                      PeakLocForDistance = "start",
                                      FeatureLocForDistance = "TSS",
                                      AnnotationData = anno_data)
head(annotated_peak, n = 2)

## -----------------------------------------------------------------------------
annotated_peak <- annotatePeakInBatch(peak_to_anno, 
                                      AnnotationData = anno_data,
                                      output = "both",
                                      maxgap = 100)
head(annotated_peak, n = 4)

## ----fig.cap = "Peak distribution around features"----------------------------
pie1(table(annotated_peak$insideFeature))

## -----------------------------------------------------------------------------
TF_binding_sites <- GRanges(seqnames = c("1", "2", "3", "4", "5", "6", "1", 
                                         "2", "3", "4", "5", "6", "6", "6", 
                                         "6", "6", "5"),
                            ranges = IRanges(start = c(967659, 2010898, 2496700, 
                                                       3075866, 3123260, 3857500,
                                                       96765, 201089, 249670, 
                                                       307586, 312326, 385750, 
                                                       1549800, 1554400, 1565000, 
                                                       1569400, 167888600),
                                             end = c(967869, 2011108, 2496920, 
                                                     3076166,3123470, 3857780,
                                                     96985, 201299, 249890, 307796, 
                                                     312586, 385960, 1550599, 
                                                     1560799, 1565399, 1571199, 
                                                     167888999),
                                             names = paste("t", 1:17, sep = "")),
                            strand = c("*", "*", "*", "*", "*", "*", "*", "*", "*", 
                                       "*", "*", "*", "*", "*", "*", "*", "*"))

annotated_peak2 <- annotatePeakInBatch(peaks1, AnnotationData = TF_binding_sites)
head(annotated_peak2, n = 2)

## -----------------------------------------------------------------------------
promoter_regions <- promoters(TxDb.Hsapiens.UCSC.hg18.knownGene, 
                              upstream = 2000, downstream = 500)
head(promoter_regions, n = 2)

annotated_peak3 <- annotatePeakInBatch(peak_to_anno, 
                                       AnnotationData = promoter_regions)
head(annotated_peak3, n = 2)

## -----------------------------------------------------------------------------
anno_txdb <- genes(TxDb.Hsapiens.UCSC.hg38.knownGene)
head(anno_txdb$gene_id, n = 5)

anno_ensdb <- genes(EnsDb.Hsapiens.v86)
head(anno_ensdb$gene_id, n = 5)

## -----------------------------------------------------------------------------
library(org.Hs.eg.db)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)

ucsc.hg38.knownGene <- genes(TxDb.Hsapiens.UCSC.hg38.knownGene)
entrez_ids <- head(ucsc.hg38.knownGene$gene_id, n = 10)
print(entrez_ids)

res <- addGeneIDs(entrez_ids, 
                  orgAnn = "org.Hs.eg.db", 
                  feature_id_type = "entrez_id",
                  IDs2Add = "symbol")
head(res, n = 3)

## -----------------------------------------------------------------------------
txdb.hg38.transcript <- transcripts(TxDb.Hsapiens.UCSC.hg38.knownGene)
head(txdb.hg38.transcript, n = 4)
head(names(txdb.hg38.transcript), n = 4)

## -----------------------------------------------------------------------------
tr_id <- txdb.hg38.transcript$tx_name
tr_id <- sub("\\..*$", "", tr_id) # get rid of the trailing version number
names(txdb.hg38.transcript) <- tr_id
head(txdb.hg38.transcript, n = 4)

## -----------------------------------------------------------------------------
res <- annotatePeakInBatch(macs_peak_gr2, 
                           AnnotationData = txdb.hg38.transcript)
head(res, n = 2)

## -----------------------------------------------------------------------------
library(biomaRt)

mart <- useMart(biomart = "ENSEMBL_MART_ENSEMBL",
                dataset = "hsapiens_gene_ensembl")
res <- addGeneIDs(res, 
                  mart = mart,
                  feature_id_type = "ensembl_transcript_id",
                  IDs2Add = "hgnc_symbol")
head(res, n = 2)

## ----fig.cap = "Histogram showing enriched GO terms"--------------------------
anno_data <- genes(EnsDb.Hsapiens.v86)
annotated_peak4 <- annotatePeakInBatch(macs_peak_gr2,
                                       AnnotationData = anno_data,
                                       output = "both")

enriched_go <- getEnrichedGO(annotated_peak4, 
                             orgAnn = "org.Hs.eg.db", 
                             feature_id_type = "ensembl_gene_id")
enrichmentPlot(enriched_go, label_wrap = 60)

## -----------------------------------------------------------------------------
length(enriched_go[["bp"]][["go.id"]])
length(enriched_go[["cc"]][["go.id"]])
length(enriched_go[["mf"]][["go.id"]])

## -----------------------------------------------------------------------------
head(enriched_go[["mf"]], n = 2)

## ----fig.cap = "Bar graph showing enriched pathways"--------------------------
library(reactome.db)

data(annotatedPeak)
enriched_path <- getEnrichedPATH(annotatedPeak,
                                 orgAnn = "org.Hs.eg.db",
                                 feature_id_type = "ensembl_gene_id",
                                 pathAnn = "reactome.db")

## ----fig.cap = "Histogram showing enriched pathways"--------------------------
enrichmentPlot(enriched_path)

## -----------------------------------------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg38)

sequence_around_peak <- getAllPeakSequence(macs_peak_gr2, 
                                           upstream = 20,
                                           downstream = 20, 
                                           genome = BSgenome.Hsapiens.UCSC.hg38)
head(sequence_around_peak, n = 2)

## ----eval = FALSE-------------------------------------------------------------
# library(biomaRt)
# 
# mart <- useMart(biomart="ENSEMBL_MART_ENSEMBL",
#                 dataset="hsapiens_gene_ensembl")
# 
# sequence_around_peak <- getAllPeakSequence(macs_peak_gr2[1],
#                                            upstream = 20,
#                                            downstream = 20,
#                                            genome = mart)

## ----eval = FALSE-------------------------------------------------------------
# write2FASTA(sequence_around_peak, file = "macs_peak_gr2.fa")

## -----------------------------------------------------------------------------
freqs <- oligoFrequency(BSgenome.Hsapiens.UCSC.hg38$chr1)
motif_summary <- oligoSummary(sequence_around_peak, 
                              oligoLength = 6,
                              MarkovOrder = 3,
                              freqs = freqs,
                              quickMotif = TRUE)

## ----fig.cap = "Histogram showing Z-score distribution"-----------------------
zscore <- sort(motif_summary$zscore)
h <- hist(zscore, breaks = 100, main = "Histogram of Z-score")
text(x = zscore[length(zscore)], 
     y = h$counts[length(h$counts)] + 1, 
     labels = names(zscore[length(zscore)]), 
     adj = 0, 
     srt = 90)

## ----fig.cap = "Histogram showing Z-score distribution for simulation data"----
set.seed(1)

# motifs to simulate
simulate_motif_1 <- "AATTTA"
simulate_motif_2 <- "TGCATG"

# sample 5000 sequences with lengths ranging from 100 to 2000 nucleotides
# randomly insert motif_1 to 10% of the sequences, and motif_2 to 15% of the sequences
simulation_seqs <- sapply(sample(c(1, 2, 0), 
                                 5000,
                                 prob = c(0.1, 0.15, 0.75),
                                 replace = TRUE), 
                           function(x) {
                             seq <- sample(c("A", "T", "C", "G"),
                                           sample.int(1900, 1) + 100, 
                                           replace = TRUE)
                             insert_pos <- sample.int(length(seq) - 6, 1)
                             if (x == 1) {
                               seq[insert_pos:(insert_pos + 5)] <- strsplit(simulate_motif_1, "")[[1]]
                             } else if (x == 2) {
                               seq[insert_pos:(insert_pos + 5)] <- strsplit(simulate_motif_2, "")[[1]]
                             }
                             paste(seq, collapse = "")
                           }
)

motif_summary_simu <- oligoSummary(simulation_seqs, 
                                   oligoLength = 6, 
                                   MarkovOrder = 3, 
                                   quickMotif = TRUE)
zscore_simu <- sort(motif_summary_simu$zscore, 
                    decreasing = TRUE)
h_simu <- hist(x = zscore_simu, 
               breaks = 100, 
               main = "Histogram of Z-score for simulation data")
text(x = zscore_simu[1:2],  
     y = rep(5, 2), 
     labels = names(zscore_simu[1:2]), 
     adj = 0, 
     srt = 90)

## ----fig.small = TRUE---------------------------------------------------------
library(motifStack)

pfm <- new("pfm", mat = motif_summary_simu$motifs[[1]],
           name = "sample motif 1")
motifStack(pfm)

## ----fig.cap = "Plot showing the first motif detected", fig.small = TRUE------
pfms <- mapply(function(motif, id) { new("pfm", mat = motif, name = as.character(id)) },
               motif_summary$motifs,
               seq_along(motif_summary$motifs))

motifStack(pfms[[1]])

## -----------------------------------------------------------------------------
example_pattern_file <- system.file("extdata/examplePattern.fa",
                                    package = "ChIPpeakAnno")
readLines(example_pattern_file)
pattern_in_peak <- summarizePatternInPeaks(patternFilePath = example_pattern_file,
                                           BSgenomeName = BSgenome.Hsapiens.UCSC.hg38,
                                           peaks = macs_peak_gr2[1:200],
                                           bgdForPerm = "chromosome",
                                           nperm = 100, 
                                           method = "permutation.test")

pattern_in_peak$motif_enrichment
head(pattern_in_peak$motif_occurrence, n = 2)

## -----------------------------------------------------------------------------
tf1 <- toGRanges(system.file("extdata/TAF.broadPeak", package = "ChIPpeakAnno"),
                 format = "broadPeak")
tf2 <- toGRanges(system.file("extdata/Tead4.broadPeak", package = "ChIPpeakAnno"),
                 format = "broadPeak")
tf3 <- toGRanges(system.file("extdata/YY1.broadPeak", package = "ChIPpeakAnno"),
                 format = "broadPeak")

## ----results = "hide", fig.cap = "Venn diagram1 showing overlapping peaks", fig.small = TRUE----
overlapping_peaks <- findOverlapsOfPeaks(tf1, 
                                         tf2, 
                                         tf3, 
                                         connectedPeaks = "keepAll")
mean_peak_width <- mean(width(unlist(GRangesList(overlapping_peaks[["all.peaks"]]))))

total_binding_sites <- length(BSgenome.Hsapiens.UCSC.hg38[["chr2"]]) * 0.03 / mean_peak_width
venn1 <- makeVennDiagram(overlapping_peaks, 
                         totalTest = total_binding_sites, 
                         connectedPeaks = "keepAll", 
                         fill = c("#CC79A7", "#56B4E9", "#F0E442"),
                         col = c("#D55E00", "#0072B2", "#E69F00"),
                         cat.col = c("#D55E00", "#0072B2", "#E69F00"))

## -----------------------------------------------------------------------------
venn1[["p.value"]]

## -----------------------------------------------------------------------------
venn1[["vennCounts"]]

## ----results = "hide", fig.cap = "Venn diagram2 showing overlapping peaks", fig.small = TRUE----
venn2 <- makeVennDiagram(overlapping_peaks, 
                         totalTest = total_binding_sites, 
                         connectedPeaks = "keepFirstListConsistent", 
                         fill = c("#CC79A7", "#56B4E9", "#F0E442"),
                         col = c("#D55E00", "#0072B2", "#E69F00"),
                         cat.col = c("#D55E00", "#0072B2", "#E69F00"))

## ----eval = FALSE-------------------------------------------------------------
# library(TxDb.Hsapiens.UCSC.hg38.knownGene)
# 
# txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene
# set.seed(123)
# 
# # Example1: non-relevant peak sets
# utr5 <- unique(unlist(fiveUTRsByTranscript(txdb)))
# utr3 <- unique(unlist(threeUTRsByTranscript(txdb)))
# 
# utr5 <- utr5[sample.int(length(utr5), 1000)]
# utr3 <- utr3[sample.int(length(utr3), 1000)]
# 
# pt1 <- peakPermTest(peaks1 = utr3,
#                     peaks2 = utr5,
#                     TxDb = txdb,
#                     maxgap = 500,
#                     seed = 1)
# plot(pt1)

## ----fig.cap = "Permutation test for non-relevant peak sets", echo = FALSE, out.width = "100%", out.height = "100%"----
png <- system.file("extdata", "permTest1.png", package = "ChIPpeakAnno")

knitr::include_graphics(png)

## ----eval = FALSE-------------------------------------------------------------
# # Example2: highly relevant peak sets
# cds <- unique(unlist(cdsBy(txdb)))
# ol <- findOverlaps(cds, utr3, maxgap = 1)
# peaks2 <- c(cds[sample.int(length(cds), 500)],
#             cds[queryHits(ol)][sample.int(length(ol), 500)])
# pt2 <- peakPermTest(peaks1 = utr3,
#                     peaks2 = peaks2,
#                     TxDb = txdb,
#                     maxgap = 500,
#                     seed = 1)
# plot(pt2)

## ----fig.cap = "Permutation test for highly relevant peak sets", echo = FALSE, out.width = "100%", out.height = "100%"----
png <- system.file("extdata", "permTest2.png", package = "ChIPpeakAnno")

knitr::include_graphics(png)

## ----eval = FALSE-------------------------------------------------------------
# # Step1: download TF binding sites
# temp <- tempfile()
# download.file(file.path("https://hgdownload.cse.ucsc.edu/",
#                         "goldenpath/",
#                         "hg38/",
#                         "encRegTfbsClustered/",
#                         "encRegTfbsClusteredWithCells.hg38.bed.gz"),
#               temp)
# df_tfbs <- read.delim(gzfile(temp, "r"), header = FALSE)
# unlink(temp)
# 
# colnames(df_tfbs)[1:4] <- c("seqnames", "start", "end", "TF")
# tfbs_hg38 <- GRanges(as.character(df_tfbs$seqnames),
#                      IRanges(df_tfbs$start, df_tfbs$end),
#                      TF = df_tfbs$TF)
# 
# # Step2: download hot spots
# base_url <- "http://metatracks.encodenets.gersteinlab.org/metatracks/"
# 
# temp1 <- tempfile()
# temp2 <- tempfile()
# download.file(file.path(base_url,
#                         "HOT_All_merged.tar.gz"),
#               temp1)
# download.file(file.path(base_url,
#                         "HOT_intergenic_All_merged.tar.gz"),
#               temp2)
# untar(temp1, exdir = dirname(temp1))
# untar(temp2, exdir = dirname(temp1))
# bedfiles <- dir(dirname(temp1), "bed$")
# hot_spots_hg19 <- sapply(file.path(dirname(temp1), bedfiles), toGRanges, format = "BED")
# unlink(temp1)
# unlink(temp2)
# 
# names(hot_spots_hg19) <- gsub("_merged.bed", "", bedfiles)
# hot_spots_hg19 <- sapply(hot_spots_hg19, unname)
# hot_spots_hg19 <- GRangesList(hot_spots_hg19)
# 
# # Step3: liftover hot spots to hg38
# library(R.utils)
# 
# temp_chain_gz <- tempfile()
# temp_chain <- tempfile()
# base_url_chain <- "http://hgdownload.cse.ucsc.edu/goldenpath/"
# download.file(file.path(base_url_chain,
#                         "hg19/liftOver/",
#                         "hg19ToHg38.over.chain.gz"),
#               temp_chain_gz)
# gunzip(filename = temp_chain_gz, destname = temp_chain)
# chain_file <- import.chain(hg19_to_hg38)
# unlink(temp_chain_gz)
# unlink(temp_chain)
# 
# hot_spots_hg38 <- liftOver(hot_spots_hg19, chain_file)
# 
# # Step4: select peak sets to test
# tfbs_hg38_by_TF <- split(tfbs_hg38, tfbs_hg38$TF)
# TAF1 <- tfbs_hg38_by_TF[["TAF1"]]
# TEAD4 <- tfbs_hg38_by_TF[["TEAD4"]]
# 
# # Step5: remove hot spots from binding pool
# tfbs_hg38 <- subsetByOverlaps(tfbs_hg38, hot_spots_hg38, invert=TRUE)
# tfbs_hg38 <- reduce(tfbs_hg38)
# 
# # Step6: perform permutation test
# pool <- new("permPool",
#             grs = GRangesList(tfbs_hg38),
#             N = length(TAF1))
# pt3 <- peakPermTest(TAF1, TEAD4, pool = pool, ntimes = 500)
# plot(pt3)

## ----fig.cap = "Permutation test using custom peak pool", echo = FALSE, out.width = "100%", out.height = "100%"----
png <- system.file("extdata", "permTest3.png", package = "ChIPpeakAnno")

knitr::include_graphics(png)

## ----fig.cap = "Heatmap of coverage densities for selected TFs"---------------
# Step1: read in example peak files
extdata_path <- system.file("extdata", package = "ChIPpeakAnno")
broadPeaks <- dir(extdata_path, "broadPeak")
gr_TFs <- sapply(file.path(extdata_path, broadPeaks), toGRanges, format = "broadPeak")
names(gr_TFs) <- gsub(".broadPeak", "", broadPeaks)
names(gr_TFs)

## -----------------------------------------------------------------------------
# Step2: find peaks that are shared by all
ol <- findOverlapsOfPeaks(gr_TFs)
gr_TFs_ol <- ol$peaklist$`TAF///Tead4///YY1`

# Step3: read in example coverage files
# here we read in coverage data from -2000bp to -2000bp of each shared peak center
gr_TFs_ol_center <- reCenterPeaks(gr_TFs_ol, width = 4000) # use the center of the peaks and extend 2000bp upstream and downstream to obtain peaks with uniform length of 4000bp

bigWigs <- dir(extdata_path, "bigWig")
coverage_list <- sapply(file.path(extdata_path, bigWigs), 
                        import, # rtracklayer::import
                        format = "BigWig",
                        which = gr_TFs_ol_center,
                        as = "RleList")

names(coverage_list) <- gsub(".bigWig", "", bigWigs)
names(coverage_list)

## ----fig.cap = "Heatmap of coverages for selected TFs", fig.height = 6, message = FALSE----
# Step4: visualize binding patterns
sig <- featureAlignedSignal(coverage_list, gr_TFs_ol_center)

# since the bigWig files are only a subset of the original files,
# filter to keep peaks that are with coverage data for all peak sets
keep <- rowSums(sig[[1]]) > 0 & rowSums(sig[[2]]) > 0 & rowSums(sig[[3]]) > 0
sig <- sapply(sig, function(x) x[keep, ], simplify = FALSE)
gr_TFs_ol_center <- gr_TFs_ol_center[keep]

featureAlignedHeatmap(sig, gr_TFs_ol_center,
                      upper.extreme=c(3, 0.5, 4))

## ----fig.cap = "Heatmap of coverages for selected TFs sorted by hierarchical clustering", fig.height = 6, message = FALSE----
# perform hierarchical clustering on rows
sig_rowsums <- sapply(sig, rowSums, na.rm = TRUE)
row_distance <- dist(sig_rowsums)
hc <- hclust(row_distance)

# use hierarchical clustering order to sort
gr_TFs_ol_center$sort_by <- hc$order
featureAlignedHeatmap(sig, gr_TFs_ol_center, 
                      upper.extreme = c(3, 0.5, 4),
                      sortBy = "sort_by")

## ----fig.cap = "Distribution of coverage densities for selected TFs", message = FALSE----
featureAlignedDistribution(sig, gr_TFs_ol_center,
                           type = "l")

## ----message = FALSE, warning = FALSE-----------------------------------------
library(ChIPpeakAnno)

# Convert BED/GFF into GRanges
bed1 <- system.file("extdata", "MACS_output_hg38.bed", 
                    package = "ChIPpeakAnno")
gr1 <- toGRanges(bed1, format = "BED", header = FALSE)
gff1 <- system.file("extdata", "GFF_peaks_hg38.gff", 
                    package = "ChIPpeakAnno")
gr2 <- toGRanges(gff1, format = "GFF", header = FALSE)

# Find overlapping peaks
ol <- findOverlapsOfPeaks(gr1, gr2)

# Add "score" metadata column to overlapping peaks
ol <- addMetadata(ol, colNames = "score", FUN = mean) 
head(ol$mergedPeaks, n = 2)

## ----results = "hide", fig.cap = "Venn diagram showing the number of overlapping peaks for gr1 and gr2", fig.small = TRUE----
venn <- makeVennDiagram(ol,
                        fill = c("#009E73", "#F0E442"),
                        col = c("#D55E00", "#0072B2"),
                        cat.col = c("#D55E00", "#0072B2"))

## -----------------------------------------------------------------------------
venn[["p.value"]]

## -----------------------------------------------------------------------------
venn[["vennCounts"]]

## ----warning = FALSE----------------------------------------------------------
library(EnsDb.Hsapiens.v86)

ensembl.hs86.gene <- toGRanges(EnsDb.Hsapiens.v86, feature = "gene")
head(ensembl.hs86.gene, n = 2)

## ----fig.cap = "Peak count distribution around transcription start sites", warning = FALSE----
binOverFeature(ol$mergedPeaks, 
               nbins = 20,
               annotationData = ensembl.hs86.gene,
               xlab = "peak distance from TSSs (bp)", 
               ylab = "peak count", 
               main = "Distribution of aggregated peak numbers around TSS")

## ----fig.cap = "Pie graph showing peak distributions over different genomic features"----
library(TxDb.Hsapiens.UCSC.hg38.knownGene)

genomicElementDistribution(ol$mergedPeaks, 
                           TxDb = TxDb.Hsapiens.UCSC.hg38.knownGene)

## ----fig.cap = "Bar graph showing peak distributions over different genomic features for two replicates"----
macs_peaks <- GRangesList(rep1 = gr1,
                          rep2 = gr2)
genomicElementDistribution(macs_peaks, 
                           TxDb = TxDb.Hsapiens.UCSC.hg38.knownGene)

## ----fig.cap = "UpSet plot showing peak overlappings for multiple features"----
library(UpSetR)

res <- genomicElementUpSetR(ol$mergedPeak,
                            TxDb.Hsapiens.UCSC.hg38.knownGene)
upset(res[["plotData"]], 
      nsets = length(colnames(res$plotData)), 
      nintersects = NA)

## -----------------------------------------------------------------------------
ol_anno <- annotatePeakInBatch(ol$mergedPeak, 
                               AnnotationData = ensembl.hs86.gene, 
                               output = "nearestBiDirectionalPromoters",
                               bindingRegion = c(-2000, 500))
head(ol_anno, n = 2)

## ----eval = FALSE-------------------------------------------------------------
# ol_anno <- unname(ol_anno) # remove names to avoid duplicate row.names error
# ol_anno$peakNames <- NULL # remove peakNames to avoid unimplemented type 'list' error
# write.csv(as.data.frame(ol_anno), "ol_anno.csv")

## ----fig.cap = "Pie chart showing peak distribution around features"----------
pie1(table(ol_anno$insideFeature))

## -----------------------------------------------------------------------------
peaks_near_BDP <- peaksNearBDP(ol$mergedPeaks, 
                    AnnotationData = ensembl.hs86.gene, 
                    MaxDistance = 5000) 
# MaxDistance will be translated into "bindingRegion = 
# c(-MaxDistance, MaxDistance)" internally

peaks_near_BDP$n.peaks
peaks_near_BDP$n.peaksWithBDP
peaks_near_BDP$percentPeaksWithBDP

head(peaks_near_BDP$peaksWithBDP, n = 2)

## -----------------------------------------------------------------------------
library(EnsDb.Hsapiens.v75)

ensembl.hs75.gene <- toGRanges(EnsDb.Hsapiens.v75, feature = "gene")

DNA5C <- system.file("extdata", 
                     "wgEncodeUmassDekker5CGm12878PkV2.bed.gz",
                     package="ChIPpeakAnno")
DNAinteractiveData <- toGRanges(gzfile(DNA5C))
# the example bed.gz file can also be downloaded from:
# https://hgdownload.cse.ucsc.edu/goldenpath/hg19/encodeDCC/wgEncodeUmassDekker5C/wgEncodeUmassDekker5CGm12878PkV2.bed.gz

peaks_near_enhancer <-  findEnhancers(peaks = ol$mergedPeaks,
                                      annoData = ensembl.hs75.gene, 
                                      DNAinteractiveData = DNAinteractiveData)
head(peaks_near_enhancer, n = 2)

## ----fig.cap = "Histogram showing enriched GO terms"--------------------------
library(org.Hs.eg.db)

enriched_go <- getEnrichedGO(annotatedPeak = ol_anno, 
                             orgAnn = "org.Hs.eg.db", 
                             feature_id_type = "ensembl_gene_id",
                             condense = TRUE)
enrichmentPlot(enriched_go)

## ----fig.cap = "Histogram showing enriched pathways"--------------------------
library(reactome.db)

enriched_pathway <- getEnrichedPATH(annotatedPeak = ol_anno,
                                    orgAnn = "org.Hs.eg.db", 
                                    pathAnn = "KEGGREST",
                                    maxP = 0.05)
enrichmentPlot(enriched_pathway)

# To remove the common suffix " - Homo sapiens (human)":
enrichmentPlot(enriched_pathway, label_substring_to_remove = " - Homo sapiens \\(human\\)")

## -----------------------------------------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg38)

seq_around_peak <- getAllPeakSequence(ol$mergedPeaks, 
                                      upstream = 20,
                                      downstream = 20, 
                                      genome = BSgenome.Hsapiens.UCSC.hg38)
head(seq_around_peak, n = 2)

## ----fig.cap = "Histogram showing Z-score distribution for oligos of length 6"----
freqs <- oligoFrequency(BSgenome.Hsapiens.UCSC.hg38$chr1)
motif_summary <- oligoSummary(seq_around_peak, 
                              oligoLength = 6,
                              MarkovOrder = 3,
                              freqs = freqs,
                              quickMotif = TRUE)
zscore <- sort(motif_summary$zscore)
h <- hist(zscore, 
          breaks = 100, 
          main = "Histogram of Z-score")
text(x = zscore[length(zscore)], 
     y = h$counts[length(h$counts)] + 1, 
     labels = names(zscore[length(zscore)]), 
     adj = 0, 
     srt = 90)

## ----fig.cap = "Sequence log of detected motif 1", fig.small = TRUE-----------
library(motifStack)

pfm <- new("pfm", mat = motif_summary$motifs[[1]],
           name = "sample motif 1")
motifStack(pfm)

## ----warning = FALSE----------------------------------------------------------
tf1 <- toGRanges(system.file("extdata/TAF.broadPeak", package = "ChIPpeakAnno"),
                 format = "broadPeak")
tf2 <- toGRanges(system.file("extdata/Tead4.broadPeak", package = "ChIPpeakAnno"),
                 format = "broadPeak")
tf3 <- toGRanges(system.file("extdata/YY1.broadPeak", package = "ChIPpeakAnno"),
                 format = "broadPeak")

## ----results = "hide", fig.cap = "Venn diagram showing overlapping peaks for three TFs", fig.small = TRUE----
library(BSgenome.Hsapiens.UCSC.hg38)

overlapping_peaks <- findOverlapsOfPeaks(tf1, 
                                         tf2, 
                                         tf3, 
                                         connectedPeaks = "keepAll")
mean_peak_width <- mean(width(unlist(GRangesList(overlapping_peaks[["all.peaks"]]))))

total_binding_sites <- length(BSgenome.Hsapiens.UCSC.hg38[["chr2"]]) * 0.03 / mean_peak_width
venn1 <- makeVennDiagram(overlapping_peaks, 
                         totalTest = total_binding_sites, 
                         connectedPeaks = "keepAll", 
                         fill = c("#CC79A7", "#56B4E9", "#F0E442"),
                         col = c("#D55E00", "#0072B2", "#E69F00"),
                         cat.col = c("#D55E00", "#0072B2", "#E69F00"))

## -----------------------------------------------------------------------------
venn1[["p.value"]]

## ----fig.cap = "Heatmap of coverages for selected TFs", fig.height = 6, message = FALSE----
ol_tfs <- findOverlapsOfPeaks(tf1, tf2, tf3, 
                              connectedPeaks = "keepAll")
gr_ol_tfs <- ol_tfs$peaklist$`tf1///tf2///tf3`

TF_width <- width(gr_ol_tfs)
gr_ol_tfs_center <- reCenterPeaks(gr_ol_tfs, width = 4000)

extdata_path <- system.file("extdata", package = "ChIPpeakAnno")
bigWigs <- dir(extdata_path, "bigWig")
coverage_list <- sapply(file.path(extdata_path, bigWigs), 
                        import, # rtracklayer::import
                        format = "BigWig",
                        which = gr_ol_tfs_center,
                        as = "RleList")

names(coverage_list) <- gsub(".bigWig", "", bigWigs)

sig <- featureAlignedSignal(coverage_list, gr_ol_tfs_center)
# since the bigWig files are only a subset of the original files,
# filter to keep peaks that are with coverage data for all peak sets
keep <- rowSums(sig[[1]]) > 0 & rowSums(sig[[2]]) > 0 & rowSums(sig[[3]]) > 0
sig <- sapply(sig, function(x) x[keep, ], simplify = FALSE)
gr_ol_tfs_center <- gr_ol_tfs_center[keep]

featureAlignedHeatmap(sig, gr_ol_tfs_center,
                      upper.extreme=c(3, 0.5, 4))

## ----fig.cap = "Heatmap of coverages for selected TFs sorted by YY1 sample", fig.height = 6, message = FALSE----
featureAlignedHeatmap(sig, gr_ol_tfs_center,
                      upper.extreme=c(3, 0.5, 4),
                      sortBy = "YY1")

## ----fig.cap = "Distribution of coverage densities for selected TFs", message = FALSE----
featureAlignedDistribution(sig, gr_ol_tfs_center, 
                           type="l")

## ----warning = FALSE----------------------------------------------------------
library(ensembldb)
library(EnsDb.Hsapiens.v75)
data(myPeakList)
annoData <- annoGR(EnsDb.Hsapiens.v75)

# Step1: annotate peaks to the overlapping features, if "select = 'all'", multiple features can be assigned to a single peak.
anno_overlapping <- annotatePeakInBatch(myPeakList, 
                                        AnnotationData = annoData, 
                                        output = "overlapping", 
                                        select = "first")
anno_overlapping_non_na <- anno_overlapping[!is.na(anno_overlapping$feature)]

# Step2: annotate peaks that are without overlapping features to nearest features
myPeakList_non_overlapping <- myPeakList[!(names(myPeakList) %in% anno_overlapping_non_na$peak)]  
anno_nearest <- annotatePeakInBatch(myPeakList_non_overlapping,
                                    AnnotationData = annoData, 
                                    output = "nearestLocation", 
                                    select = "first")

# Step3: concatenate the two
anno_final <- c(anno_overlapping_non_na, anno_nearest)

## ----warning = FALSE----------------------------------------------------------
library(ChIPpeakAnno)
library(reshape2)

# Step1: read in two peak files
bed <- system.file("extdata", 
                   "MACS_output.bed",
                   package = "ChIPpeakAnno")
gff <- system.file("extdata", 
                   "GFF_peaks.gff", 
                   package = "ChIPpeakAnno")
gr1 <- toGRanges(bed, format = "BED", 
                 header = FALSE)
gr2 <- toGRanges(gff, format = "GFF", 
                 header = FALSE, skip = 3)
names(gr2) <- seq(length(gr2)) # add names to gr2 for Step4

# Step2: find overlapping peaks
ol <- findOverlapsOfPeaks(gr1, gr2)
peakNames <- ol$peaklist[['gr1///gr2']]$peakNames

# Step3: extract original peak names
peakNames <- melt(peakNames, 
                  value.name = "merged_peak_id") # reshape df
head(peakNames, n = 2)

peakNames <- cbind(peakNames[, 1], 
                   do.call(rbind, 
                           strsplit(as.character(peakNames[, 3]), "__")))

colnames(peakNames) <- c("merged_peak_id", "group", "peakName")
head(peakNames, n = 2)

# Step4: split by peak group
gr1_subset <- gr1[peakNames[peakNames[, "group"] %in% "gr1", "peakName"]]
gr2_subset <- gr2[peakNames[peakNames[, "group"] %in% "gr2", "peakName"]]
head(gr1_subset, n = 2)
head(gr2_subset, n = 2)

## -----------------------------------------------------------------------------
gr1_renamed <- ol$all.peaks$gr1
gr2_renamed <- ol$all.peaks$gr2
head(gr1_renamed, n = 2)
head(gr2_renamed, n = 2)

peakNames <- melt(ol$peaklist[['gr1///gr2']]$peakNames, 
                  value.name = "merged_peak_id")
gr1_subset <- gr1_renamed[peakNames[grepl("^gr1", peakNames[, 3]), 3]]
gr2_subset <- gr2_renamed[peakNames[grepl("^gr2", peakNames[, 3]), 3]]
head(gr1_subset, n = 2)
head(gr2_subset, n = 2)

## ----citation, echo = FALSE---------------------------------------------------
citation(package = "ChIPpeakAnno")

## ----sessionInfo, echo = FALSE------------------------------------------------
sessionInfo()

