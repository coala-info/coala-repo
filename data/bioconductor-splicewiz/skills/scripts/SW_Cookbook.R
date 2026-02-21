# Code example from 'SW_Cookbook' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## -----------------------------------------------------------------------------
library(SpliceWiz)

## ----eval = FALSE-------------------------------------------------------------
# ref_path <- "./Reference"

## ----eval=FALSE---------------------------------------------------------------
# buildRef(
#     reference_path = ref_path,
#     fasta = "genome.fa", gtf = "transcripts.gtf",
#     genome_type = "hg38"
# )

## ----eval=FALSE---------------------------------------------------------------
# getResources(
#     reference_path = ref_path,
#     fasta = "genome.fa",
#     gtf = "transcripts.gtf"
# )
# 
# buildRef(
#     reference_path = ref_path,
#     fasta = "", gtf = "",
#     genome_type = "hg38"
# )

## ----eval=FALSE---------------------------------------------------------------
# buildRef(
#     reference_path = ref_path,
#     fasta = "genome.fa",
#     gtf = "transcripts.gtf"
#     genome_type = "hg38"
# )

## ----eval=FALSE---------------------------------------------------------------
# # Assuming hg38 genome:
# 
# buildRef(
#     reference_path = ref_path,
#     genome_type = "hg38",
#     overwrite = TRUE
# )

## ----eval=FALSE---------------------------------------------------------------
# FTP <- "ftp://ftp.ensembl.org/pub/release-94/"
# 
# buildRef(
#     reference_path = ref_path,
#     fasta = paste0(FTP, "fasta/homo_sapiens/dna/",
#         "Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz"),
#     gtf = paste0(FTP, "gtf/homo_sapiens/",
#         "Homo_sapiens.GRCh38.94.chr.gtf.gz"),
#     genome_type = "hg38"
# )

## -----------------------------------------------------------------------------
require(AnnotationHub)

ah <- AnnotationHub()
query(ah, "Ensembl")

## -----------------------------------------------------------------------------
query(ah, c("Homo Sapiens", "release-94"))

## ----eval=FALSE---------------------------------------------------------------
# buildRef(
#     reference_path = ref_path,
#     fasta = "AH65745",
#     gtf = "AH64631",
#     genome_type = "hg38"
# )

## ----eval=FALSE---------------------------------------------------------------
# buildRef(
#     reference_path = ref_path,
#     fasta = "genome.fa", gtf = "transcripts.gtf",
#     genome_type = ""
# )

## -----------------------------------------------------------------------------
getAvailableGO()

## ----eval=FALSE---------------------------------------------------------------
# buildRef(
#     reference_path = ref_path,
#     fasta = "genome.fa", gtf = "transcripts.gtf",
#     genome_type = "",
#     ontologySpecies = "Arabidopsis thaliana"
# )

## -----------------------------------------------------------------------------
STAR_version()

## ----eval = FALSE-------------------------------------------------------------
# ref_path = "./Reference"
# 
# # Ensure genome resources are prepared from genome FASTA and GTF file:
# 
# if(!dir.exists(file.path(ref_path, "resource"))) {
#     getResources(
#         reference_path = ref_path,
#         fasta = "genome.fa",
#         gtf = "transcripts.gtf"
#     )
# }
# 
# # Generate a STAR genome reference:
# STAR_BuildRef(
#     reference_path = ref_path,
#     n_threads = 8
# )
# 

## ----eval = FALSE-------------------------------------------------------------
# STAR_BuildRef(
#     reference_path = ref_path,
#     STAR_ref_path = "/path/to/another/directory",
#     n_threads = 8
# )

## ----eval = FALSE-------------------------------------------------------------
# # Generate a STAR genome reference:
# STAR_buildGenome(
#     reference_path = ref_path,
#     STAR_ref_path = "/path/to/hg38"
#     n_threads = 8
# )

## ----eval = FALSE-------------------------------------------------------------
# STAR_new_ref <- STAR_loadGenomeGTF(
#     reference_path = ref_path,
#     STAR_ref_path = "/path/to/hg38",
#     STARgenome_output = file.path(tempdir(), "STAR"),
#     n_threads = 8,
#     sjdbOverhang = 100,
#     extraFASTA = "./ercc.fasta"
# )

## ----eval = FALSE-------------------------------------------------------------
# STAR_mappability(
#   reference_path = ref_path,
#   STAR_ref_path = file.path(ref_path, "STAR"),
#   map_depth_threshold = 4,
#   n_threads = 8,
#   read_len = 70,
#   read_stride = 10,
#   error_pos = 35
# )

## ----eval=FALSE---------------------------------------------------------------
# buildFullRef(
#     reference_path = ref_path,
#     fasta = "genome.fa", gtf = "transcripts.gtf",
#     genome_type = "",
#     use_STAR_mappability = TRUE,
#     n_threads = 8
# )

## ----eval = FALSE-------------------------------------------------------------
# require(Rsubread)
# 
# # (1a) Creates genome resource files
# 
# ref_path <- file.path(tempdir(), "Reference")
# 
# getResources(
#     reference_path = ref_path,
#     fasta = chrZ_genome(),
#     gtf = chrZ_gtf()
# )
# 
# # (1b) Systematically generate reads based on the SpliceWiz example genome:
# 
# generateSyntheticReads(
#     reference_path = ref_path
# )
# 
# # (2) Align the generated reads using Rsubread:
# 
# # (2a) Build the Rsubread genome index:
# 
# subreadIndexPath <- file.path(ref_path, "Rsubread")
# if(!dir.exists(subreadIndexPath)) dir.create(subreadIndexPath)
# Rsubread::buildindex(
#     basename = file.path(subreadIndexPath, "reference_index"),
#     reference = chrZ_genome()
# )
# 
# # (2b) Align the synthetic reads using Rsubread::subjunc()
# 
# Rsubread::subjunc(
#     index = file.path(subreadIndexPath, "reference_index"),
#     readfile1 = file.path(ref_path, "Mappability", "Reads.fa"),
#     output_file = file.path(ref_path, "Mappability", "AlignedReads.bam"),
#     useAnnotation = TRUE,
#     annot.ext = chrZ_gtf(),
#     isGTF = TRUE
# )
# 
# # (3) Analyse the aligned reads in the BAM file for low-mappability regions:
# 
# calculateMappability(
#     reference_path = ref_path,
#     aligned_bam = file.path(ref_path, "Mappability", "AlignedReads.bam")
# )
# 
# # (4) Build the SpliceWiz reference using the calculated Mappability Exclusions
# 
# buildRef(ref_path)
# 

## ----eval = FALSE-------------------------------------------------------------
# buildRef(ref_path, genome_type = "hg38")

## -----------------------------------------------------------------------------
STAR_version()

## ----eval = FALSE-------------------------------------------------------------
# STAR_alignReads(
#     fastq_1 = "sample1_1.fastq", fastq_2 = "sample1_2.fastq",
#     STAR_ref_path = file.path(ref_path, "STAR"),
#     BAM_output_path = "./bams/sample1",
#     n_threads = 8,
#     trim_adaptor = "AGATCGGAAG"
# )

## ----eval = FALSE-------------------------------------------------------------
# Experiment <- data.frame(
#     sample = c("sample_A", "sample_B"),
#     forward = file.path("raw_data", c("sample_A", "sample_B"),
#         c("sample_A_1.fastq", "sample_B_1.fastq")),
#     reverse = file.path("raw_data", c("sample_A", "sample_B"),
#         c("sample_A_2.fastq", "sample_B_2.fastq"))
# )
# 
# STAR_alignExperiment(
#     Experiment = Experiment,
#     STAR_ref_path = file.path("Reference_FTP", "STAR"),
#     BAM_output_path = "./bams",
#     n_threads = 8,
#     two_pass = FALSE
# )

## ----eval = FALSE-------------------------------------------------------------
# # Assuming sequencing files are named by their respective sample names
# fastq_files <- findFASTQ(
#     sample_path = "./sequencing_files",
#     paired = TRUE,
#     fastq_suffix = ".fq.gz", level = 0
# )

## ----eval = FALSE-------------------------------------------------------------
# STAR_alignExperiment(
#     Experiment = fastq_files,
#     STAR_ref_path = file.path("Reference_FTP", "STAR"),
#     BAM_output_path = "./bams",
#     n_threads = 8,
#     two_pass = FALSE
# )

## ----eval=FALSE---------------------------------------------------------------
# bams <- findBAMS("./bams", level = 1)

## ----eval=FALSE---------------------------------------------------------------
# # assume SpliceWiz reference has been generated in `ref_path` using the
# # `buildRef()` function.
# 
# processBAM(
#     bamfiles = bams$path,
#     sample_names = bams$sample,
#     reference_path = ref_path,
#     output_path = "./pb_output",
#     n_threads = 4,
#     useOpenMP = TRUE
# )

## ----eval=FALSE---------------------------------------------------------------
# BAM2COV(
#     bamfiles = bams$path,
#     sample_names = bams$sample,
#     output_path = "./cov_output",
#     n_threads = 4,
#     useOpenMP = TRUE
# )

## -----------------------------------------------------------------------------
se <- SpliceWiz_example_NxtSE()

cov_file <- covfile(se)[1]

cov_negstrand <- getCoverage(cov_file, strand = "-")
bw_file <- file.path(tempdir(), "sample_negstrand.bw")
rtracklayer::export(cov_negstrand, bw_file, "bw")

## ----eval=FALSE---------------------------------------------------------------
# expr <- findSpliceWizOutput("./pb_output")

## ----eval = FALSE-------------------------------------------------------------
# collateData(
#     Experiment = expr,
#     reference_path = ref_path,
#     output_path = "./NxtSE_output"
# )

## ----eval = FALSE-------------------------------------------------------------
# collateData(
#     Experiment = expr,
#     reference_path = ref_path,
#     output_path = "./NxtSE_output_novelSplicing",
#     novelSplicing = TRUE
# )

## ----eval = FALSE-------------------------------------------------------------
# se <- makeSE("./NxtSE_output")

## -----------------------------------------------------------------------------
sessionInfo()

