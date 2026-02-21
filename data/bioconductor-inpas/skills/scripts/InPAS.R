# Code example from 'InPAS' vignette. See references/ for full tutorial.

## ----load_package-------------------------------------------------------------
logger <- file(tempfile(), open = "wt")
sink(logger, type="message")
suppressPackageStartupMessages({
library(InPAS)
library(BSgenome.Mmusculus.UCSC.mm10)
library(BSgenome.Hsapiens.UCSC.hg19)
library(TxDb.Mmusculus.UCSC.mm10.knownGene)
library(EnsDb.Hsapiens.v86)
library(EnsDb.Mmusculus.v79)
library(cleanUpdTSeq)
library(RSQLite)
library(future.apply)
})

## ----setup_sqlitedb-----------------------------------------------------------
plan(sequential)
data_dir <- system.file("extdata", package = "InPAS")
bedgraphs <- c(file.path(data_dir, "Baf3.extract.bedgraph"), 
               file.path(data_dir, "UM15.extract.bedgraph"))
hugeData <- FALSE
genome <- BSgenome.Mmusculus.UCSC.mm10

tags <- c("Baf3", "UM15")
metadata <- data.frame(tag = tags, 
                      condition = c("Baf3", "UM15"),
                      bedgraph_file = bedgraphs)

## In reality, don't use a temporary directory for your analysis. Instead, use a
## persistent directory to save your analysis output.
outdir = tempdir()
write.table(metadata, file = file.path(outdir =outdir, "metadata.txt"), 
            sep = "\t", quote = FALSE, row.names = FALSE)
    
sqlite_db <- setup_sqlitedb(metadata = file.path(outdir = outdir, 
                                                 "metadata.txt"),
                           outdir = outdir)

## check the database
db_conn <- dbConnect(drv = RSQLite::SQLite(), dbname = sqlite_db)
dbListTables(db_conn)
dbReadTable(db_conn, "metadata")
dbDisconnect(db_conn)

## ----extract_annotation-------------------------------------------------------
samplefile <- system.file("extdata", 
                          "hg19_knownGene_sample.sqlite",
            package="GenomicFeatures")
TxDb <- loadDb(samplefile)
seqnames <- seqnames(BSgenome.Hsapiens.UCSC.hg19)

# exclude mitochondrial genome and alternative haplotypes
chr2exclude <- c("chrM", "chrMT", seqnames[grepl("_(hap\\d+|fix|alt)$", seqnames, perl = TRUE)])

# set up global variables for InPAS analysis
set_globals(genome = BSgenome.Hsapiens.UCSC.hg19,
            TxDb = TxDb,
            EnsDb = EnsDb.Hsapiens.v86,
            outdir = tempdir(),
            chr2exclude = chr2exclude,
            lockfile = tempfile())
utr3_anno <- 
  extract_UTR3Anno(sqlite_db = sqlite_db,
                   TxDb = getInPASTxDb(),
                   edb = getInPASEnsDb(),
                   genome = getInPASGenome(),
                   outdir = getInPASOutputDirectory(),
                   chr2exclude = getChr2Exclude())

head(utr3_anno$chr1)

## ----load_anno----------------------------------------------------------------
## set global variables for mouse InPAS analysis
set_globals(genome = BSgenome.Mmusculus.UCSC.mm10,
            TxDb = TxDb.Mmusculus.UCSC.mm10.knownGene,
            EnsDb = EnsDb.Mmusculus.v79,
            outdir = tempdir(),
            chr2exclude = "chrM",
            lockfile = tempfile())

tx <- parse_TxDb(sqlite_db = sqlite_db,
                 TxDb = getInPASTxDb(),
                 edb = getInPASEnsDb(),
                 genome = getInPASGenome(),
                 outdir = getInPASOutputDirectory(),
                 chr2exclude = getChr2Exclude())

# load R object: utr3.mm10
data(utr3.mm10)

## convert the GRanges into GRangesList for the 3' UTR annotation
utr3.mm10 <- split(utr3.mm10, seqnames(utr3.mm10), 
                   drop = TRUE)

## ----format_coverage----------------------------------------------------------
coverage <- list()
for (i in seq_along(bedgraphs)){
coverage[[tags[i]]] <- get_ssRleCov(bedgraph = bedgraphs[i],
                                    tag = tags[i],
                                    genome = genome,
                                    sqlite_db = sqlite_db,
                                    outdir = outdir,
                                    chr2exclude = getChr2Exclude())
}
coverage <- assemble_allCov(sqlite_db,
                            seqname = "chr6",
                            outdir, 
                            genome = getInPASGenome())

## ----coverage_QC--------------------------------------------------------------
if (.Platform$OS.type == "windows")
{
  plan(multisession)
} else {
  plan(multicore)
}
run_coverageQC(sqlite_db, 
               TxDb = getInPASTxDb(), 
               edb = getInPASEnsDb(), 
               genome = getInPASGenome(),
               chr2exclude = getChr2Exclude(),
               which = GRanges("chr6",
               ranges = IRanges(98013000, 140678000)))
plan(sequential)

## ----search_CPs---------------------------------------------------------------
## load the Naive Bayes classifier model for classify CP sites from the 
## cleanUpdTseq package
data(classifier)

prepared_data <- setup_CPsSearch(sqlite_db,
                                 genome = getInPASGenome(), 
                                 chr.utr3 = utr3.mm10$chr6,
                                 seqname = "chr6",
                                 background = "10K",
                                 TxDb = getInPASTxDb(),
                                 hugeData = TRUE,
                                 outdir = outdir,
                                 silence = TRUE,
                                 coverage_threshold = 5)

CPsites <- search_CPs(seqname = "chr6",
                       sqlite_db = sqlite_db,
                       genome = getInPASGenome(),
                       MINSIZE = 10, 
                       window_size = 100,
                       search_point_START = 50,
                       search_point_END = NA,
                       cutEnd = 0,
                       filter.last = TRUE,
                       adjust_distal_polyA_end = TRUE,
                       long_coverage_threshold = 2,
                       PolyA_PWM = NA, 
                       classifier = classifier,
                       classifier_cutoff = 0.8,
                       shift_range = 50,
                       step = 5,
                       outdir = outdir, 
                       silence = TRUE)

## ----estimate_PDUI------------------------------------------------------------
utr3_cds_cov <- get_regionCov(chr.utr3 = utr3.mm10[["chr6"]],
                              sqlite_db,
                              outdir,
                              phmm = FALSE)

eSet <- get_UTR3eSet(sqlite_db,
                     normalize ="none", 
                     singleSample = FALSE)

## ----dPDUI_test---------------------------------------------------------------
test_out <- test_dPDUI(eset = eSet, 
                       method = "fisher.exact",
                       normalize = "none",
                       sqlite_db = sqlite_db)

## ----filter_dPDUI-------------------------------------------------------------
filter_out <- filter_testOut(res = test_out,
                             gp1 = "Baf3",
                             gp2 = "UM15",
                             background_coverage_threshold = 2,
                             P.Value_cutoff = 0.05,
                             adj.P.Val_cutoff = 0.05,
                             dPDUI_cutoff = 0.3,
                             PDUI_logFC_cutoff = 0.59)

## ----visualization------------------------------------------------------------
## Visualize dPDUI events                       
gr <- GRanges("chr6", IRanges(128846245, 128850081), strand = "-")
names(gr) <- "128846245-128850081"
data4plot <- get_usage4plot(gr, 
                            proximalSites = 128849130, 
                            sqlite_db,
                            hugeData = TRUE) 

plot_utr3Usage(usage_data = data4plot, 
               vline_color = "purple", 
               vline_type = "dashed")

## ----setup_GSEA---------------------------------------------------------------
## prepare a rank file for GSEA
setup_GSEA(eset = test_out,
           groupList= list(Baf3 = "Baf3", UM15 ="UM15"),
           outdir = outdir,
           preranked = TRUE,
           rankBy = "logFC",
           rnkFilename = "InPAS.rnk")

## ----sessionInfo, results='asis'----------------------------------------------
sessionInfo()
sink(type="message")
close(logger)

