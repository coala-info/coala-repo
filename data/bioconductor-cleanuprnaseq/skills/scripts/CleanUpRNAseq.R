# Code example from 'CleanUpRNAseq' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
options(timeout = Inf)
knitr::opts_chunk$set(
    eval = TRUE,
    message = FALSE,
    warning = FALSE,
    tidy = FALSE,
    fig.align = 'center'
)

## ----load_package, eval = TRUE------------------------------------------------
suppressPackageStartupMessages({
  library("CleanUpRNAseq")
  #devtools::load_all("../../CleanUpRNAseq")
  library("ggplotify")
  library("patchwork")
  library("ensembldb")
  library("utils")
})

## ----load_ensdb, eval=FALSE---------------------------------------------------
# suppressPackageStartupMessages({
#   library("EnsDb.Hsapiens.v86")
# })
# hs_ensdb_sqlite <- EnsDb.Hsapiens.v86

## ----create_ensdb-------------------------------------------------------------
options(timeout = max(3000, getOption("timeout")))
tmp_dir <- tempdir()
gtf <- system.file("extdata", "example.gtf.gz",
                    package = "CleanUpRNAseq")

hs_ensdb_sqlite <-
  ensDbFromGtf(
        gtf = gtf,
        outfile = file.path(tmp_dir, "EnsDb.hs.v110.sqlite"),
        organism = "Homo_Sapiens",
        genomeVersion = "GRCh38",
        version = 110
  )

## ----prepare_saf--------------------------------------------------------------
bam_file <- system.file("extdata", "K084CD7PCD1N.srt.bam",
    package = "CleanUpRNAseq"
)
saf_list <- get_saf(
    ensdb_sqlite = hs_ensdb_sqlite,
    bamfile = bam_file,
    mitochondrial_genome = "MT"
)

## ----load_data----------------------------------------------------------------
 tmp_dir <- tempdir()
 in_dir <- system.file("extdata", package = "CleanUpRNAseq")
 gtf.gz <- dir(in_dir, ".gtf.gz$", full.name = TRUE)
 gtf <- file.path(tmp_dir, gsub("\\.gz", "", basename(gtf.gz)))
 R.utils::gunzip(gtf.gz, destname= gtf,
                 overwrite = TRUE, remove = FALSE)

 in_dir <- system.file("extdata", package = "CleanUpRNAseq")
 BAM_file <- dir(in_dir, ".bam$", full.name = TRUE)
 salmon_quant_file <- dir(in_dir, ".sf$", full.name = TRUE)
 sample_name = gsub(".+/(.+?).srt.bam", "\\1", BAM_file)
 salmon_quant_file_opposite_strand <- salmon_quant_file
 col_data <- data.frame(sample_name = sample_name,
                        BAM_file = BAM_file,
                        salmon_quant_file = salmon_quant_file,
                        salmon_quant_file_opposite_strand =
                            salmon_quant_file_opposite_strand,
                        group = c("CD1N", "CD1P"))

 sc <- create_summarizedcounts(lib_strand = 0, colData = col_data)
 
## featurecounts 
 capture.output({counts_list <- summarize_reads(
     SummarizedCounts = sc,
     saf_list = saf_list,
     gtf = gtf,
     threads = 1,
     verbose = TRUE
 )}, file = tempfile())

## load salmon quant 
salmon_counts <- salmon_tximport(
     SummarizedCounts = sc,
     ensdb_sqlite = hs_ensdb_sqlite
)


## ----plot_assignment_stat-----------------------------------------------------
data("feature_counts_list")
data("salmon_quant")
data("intergenic_GC")
data("gene_GC")

lib_strand <- 0
col_data_f <- system.file("extdata", "example.colData.txt",
                          package = "CleanUpRNAseq")
col_data <- read.delim(col_data_f, as.is = TRUE)
## create fake bam files
tmp_dir <- tempdir()
bamfiles <- gsub(".+/", "", col_data$BAM_file)
null <- lapply(file.path(tmp_dir, bamfiles), file.create)
## create fake quant.sf files
quant_sf <- file.path(tmp_dir, gsub(".srt.bam$",
                                     "quant.sf",
                                     bamfiles))
null <- lapply(quant_sf, file.create)
col_data$BAM_file <- file.path(tmp_dir, bamfiles)
col_data$salmon_quant_file <- quant_sf

## pretend this is stranded RA=NA-seq data
col_data$salmon_quant_file_opposite_strand <- quant_sf

sc <- create_summarizedcounts(lib_strand, col_data)
sc$set_feature_counts(feature_counts_list)
sc$set_salmon_quant(salmon_quant)
sc$set_salmon_quant_opposite(salmon_quant)

p_assignment_stat <-plot_assignment_stat(SummarizedCounts = sc)
wrap_plots(p_assignment_stat)

## -----------------------------------------------------------------------------
assigned_per_region <- get_region_stat(SummarizedCounts = sc)
p <- plot_read_distr(assigned_per_region)
p


## ----plot_sample_corr---------------------------------------------------------
plot_sample_corr(SummarizedCounts = sc)

## ----plot_read_distr----------------------------------------------------------
p_expr_distr <- plot_expr_distr(
    SummarizedCounts = sc,
    normalization = "DESeq2"
)
wrap_plots(p_expr_distr, ncol = 1, nrow = 3)

## ----percent_expressed_gene---------------------------------------------------
plot_gene_content(
    SummarizedCounts = sc,
    min_cpm = 1,
    min_tpm =1
)

## ----pca_heatmap--------------------------------------------------------------
## DESeq2 exploratory analysis before correction
p<- plot_pca_heatmap(SummarizedCounts = sc,
                     silent = TRUE)
p$pca + as.ggplot(p$heatmap)

## ----global_correction--------------------------------------------------------
global_correction <- correct_global(SummarizedCounts = sc)

## ----GC_correction------------------------------------------------------------
gc_correction <-
    correct_GC(
        SummarizedCounts = sc,
        gene_gc = gene_GC,
        intergenic_gc = intergenic_GC,
        plot = FALSE
    )

## ----sessionInfo, eval=TRUE, echo = FALSE-------------------------------------
sessionInfo()

