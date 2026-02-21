# Code example from 'Annotation_Alignment' vignette. See references/ for full tutorial.

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
#   library(ORFik)                        # This package
#   # Here the default values are shown:
#   where_to_save_config <- config_file() # Bioc Cache directory default
# 
#   parent_folder <- "~/bio_data/" # Change if you want it somewhere else
#   fastq.dir <- file.path(parent_folder, "raw_data") # Raw fast files
#   bam.dir <- file.path(parent_folder, "processed_data") # Processed files
#   reference.dir <- file.path(parent_folder, "references") # Genome references
#   exp.dir <- file.path(base.dir, "ORFik_experiments/") # ORFik experiments
#   config.save(where_to_save_config,
#               fastq.dir, bam.dir, reference.dir, reference.dir)

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
#   config()

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
#   conf <- config.exper(experiment = "CHALMERS_Yeast", # short experiment info: here I used author + species
#                      assembly = "Yeast_SacCer3", # Reference folder
#                      type = c("RNA-seq")) # fastq and bam type
#   conf

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# 
# info <- download.SRA.metadata("SRP012047", outdir = conf["fastq RNA-seq"])
# # Let's take 2 first runs in this experiment:
# info <- info[1:2,]

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# # Subset
# # 18 MB, ~ 40 sec download time ->
# download.SRA(info, conf["fastq RNA-seq"], subset = 50000)
# 
# # Or you could do the full libraries
# # 1.6 GB, ~ 100 sec download time
# # (Full size files have faster MB/s download speed than subsets) ->
# # download.SRA(info, conf["fastq RNA-seq"])

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# organism <- info$ScientificName[1]
# is_paired_end <- all(info$LibraryLayout == "PAIRED")

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
#   annotation <- getGenomeAndAnnotation(
#                       organism = organism,
#                       output.dir = conf["ref"],
#                       optimize = TRUE,
#                       pseudo_5UTRS_if_needed = 100 # If species have not 5' UTR (leader) definitions, make 100nt pseudo leaders.
#                       )

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
#   annotation <- getGenomeAndAnnotation(
#                       organism = organism,
#                       genome = TRUE, GTF = TRUE,
#                       phix = TRUE, ncRNA = TRUE, tRNA = TRUE, rRNA = TRUE,
#                       output.dir = conf["ref"],
#                       assembly_type = "toplevel" # Usually leave this to "auto"
#                       )

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
#   gtf <- "/path/to/local/annotation.gtf"
#   genome <- "/path/to/local/genome.fasta"
#   makeTxdbFromGenome(gtf, genome, organism = "Saccharomyces cerevisiae")

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
#   txdb <- "/path/to/local/annotation.gtf.db"
#   cage <- "/path/to/CAGE.ofst" # Can be bed, wig etc (ofst is fastest)
#   reassigned_txdb <- assignTSSByCage(txdb, cage)
#   AnnotationDbi::saveDb("/path/to/local/annotation_cage.db")

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
#   txdb <- "/path/to/local/annotation.gtf.db"
#   reassigned_txdb <- assignTSSByCage(txdb, cage = NULL, pseudoLength = 100)
#   AnnotationDbi::saveDb(reassigned_txdb,
#                         "/path/to/local/annotation_pseudo_leaders.db")
#   leaders <- loadRegion(reassigned_txdb, "leaders")

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# index <- STAR.index(annotation)

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# alignment <-
#   STAR.align.folder(conf["fastq RNA-seq"], conf["bam RNA-seq"], index,
#                     paired.end = is_paired_end,
#                     steps = "tr-ge", # (trim needed: adapters found, then genome)
#                     adapter.sequence = "auto",
#                     max.cpus = 30, trim.front = 3, min.length = 20)

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# dir.create("~/UMIandTrimmed")
# system(paste(install.fastp(),
#              "-i", "~/sample1.fastq.gz",
#              "-o", "~/UMIandTrimmed/sample1.UMIandTrimmed.fastq.gz"
#              "--adapter_sequence=AGATCGGAAGAGC",
#              "--umi",
#              "--umi_loc", "read1",
#              "--umi_len", 12))
# # Read fastp documentation for info about umi arguments

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# alignment <-
#   STAR.align.folder(conf["fastq RNA-seq"], conf["bam RNA-seq"], index,
#                     paired.end = is_paired_end,
#                     steps = "tr", # (Only trim)
#                     adapter.sequence = "auto",
#                     max.cpus = 30, trim.front = 3, min.length = 20)
# trimmed_files <- file.path(conf["bam RNA-seq"], "trim")
# # Check that trimmed reads are average < 50 bases, else collapsing makes little sense for speedup.
# trim_table <- ORFik:::trimming.table(trimmed_files)
# stopifnot(all(trim_table$trim_mean_length < 50))
# trimmed_fastq <- list.files(path = trimmed_files, pattern = "fastq", full.names = TRUE)
# ORFik::collapse.fastq(files = trimmed_fastq, outdir = file.path(conf["bam Ribo-seq"], "collapsed") # Collapse all files in trim folder
# # Then align using collapsed reads
# alignment <-
#   STAR.align.folder(trimmed_files, conf["bam RNA-seq"], index,
#                     paired.end = is_paired_end,
#                     steps = "ge", # (Only genome alignment from collapsed)
#                     max.cpus = 30, min.length = 20)

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# index <- STAR.index(annotation, max.ram = 20, SAsparse = 2)

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# STAR.align.folder(conf["fastq RNA-seq"], conf["bam RNA-seq"], index,
#                     max.cpus = 4) # Reduce cores to 4 usually works for most systems

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# STAR.align.folder(conf["fastq RNA-seq"], conf["bam RNA-seq"], index,
#                     max.cpus = 4, steps = "tr-ge", resume = "ge") # Resume ge using completed tr

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# txdb_file <- paste0(annotation["gtf"], ".db") # Get txdb file, not raw gtf
# fa <- annotation["genome"]
# create.experiment(exper = "yeast_exp_RNA",
#                   dir = paste0(conf["bam RNA-seq"], "/aligned/"),
#                   txdb = txdb_file,
#                   fa = fa,
#                   organism = organism,
#                   viewTemplate = FALSE,
#                   pairedEndBam = is_paired_end # True/False per bam file
#                   )

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# df <- read.experiment("yeast_exp_RNA")

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
#   QCreport(df)

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
#   remove.experiments(df) # Remove loaded libraries
#   convertLibs(df, type = "ofst")

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
#   remove.experiments(df)
#   convertLibs(df, type = "wig")

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
#   remove.experiments(df)
#   outputLibs(df, type = "ofst")

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
#   mrna <- countTable(df, region = "mrna", type = "fpkm")
#   cds <- countTable(df, region = "cds", type = "fpkm")
#   ratio <- cds / mrna

