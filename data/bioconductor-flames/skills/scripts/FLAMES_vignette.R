# Code example from 'FLAMES_vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(FLAMES)

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
outdir <- tempfile()
dir.create(outdir)
# some example data
# known cell barcodes, e.g. from coupled short-read sequencing
bc_allow <- file.path(outdir, "bc_allow.tsv")
R.utils::gunzip(
  filename = system.file("extdata", "bc_allow.tsv.gz", package = "FLAMES"),
  destname = bc_allow, remove = FALSE
)
# reference genome
genome_fa <- file.path(outdir, "rps24.fa")
R.utils::gunzip(
  filename = system.file("extdata", "rps24.fa.gz", package = "FLAMES"),
  destname = genome_fa, remove = FALSE
)

pipeline <- SingleCellPipeline(
  # use the default configs
  config_file = create_config(
    outdir,
    pipeline_parameters.demultiplexer = "flexiplex"
  ),
  outdir = outdir,
  # the input fastq file
  fastq = system.file("extdata", "fastq", "musc_rps24.fastq.gz", package = "FLAMES"),
  # reference annotation file
  annotation = system.file("extdata", "rps24.gtf.gz", package = "FLAMES"),
  genome_fa = genome_fa,
  barcodes_file = bc_allow
)
pipeline

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
pipeline <- run_FLAMES(pipeline)
pipeline

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
# set up a new pipeline
outdir2 <- tempfile()
pipeline2 <- SingleCellPipeline(
  config_file = create_config(
    outdir,
    pipeline_parameters.demultiplexer = "flexiplex"
  ),
  outdir = outdir2,
  fastq = system.file("extdata", "fastq", "musc_rps24.fastq.gz", package = "FLAMES"),
  annotation = system.file("extdata", "rps24.gtf.gz", package = "FLAMES"),
  genome_fa = genome_fa,
  barcodes_file = bc_allow
)

# delete the reference genome
unlink(genome_fa)
pipeline2 <- run_FLAMES(pipeline2)
pipeline2

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
R.utils::gunzip(
  filename = system.file("extdata", "rps24.fa.gz", package = "FLAMES"),
  destname = genome_fa, remove = FALSE
)
pipeline2 <- resume_FLAMES(pipeline2)
pipeline2

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
experiment(pipeline)

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
# example_pipeline provides an example pipeline for each of the three types
# of pipelines: BulkPipeline, SingleCellPipeline and MultiSampleSCPipeline
mspipeline <- example_pipeline("MultiSampleSCPipeline")
# Providing a single controller will run all steps in it:
controllers(mspipeline) <- crew::crew_controller_local()
# Setting controllers to an empty list will run all steps in the main R session:
controllers(mspipeline) <- list()
# Alternatively, we can run only the alignment steps in the crew controller:
controllers(mspipeline)[["genome_alignment"]] <- crew::crew_controller_local(workers = 4)
# Or `controllers(mspipeline) <- list(genome_alignment = crew::crew_cluster())`
# to remove controllers for all other steps.
# Replace `crew_controller_local()` with `crew.cluster::crew_controller_slurm()` or other
# crew controllers according to your HPC job scheduler.

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# # An example helper function to create a Slurm controller with specific resources
# create_slurm_controller <- function(
#     cpus, memory_gb, workers = 10, seconds_idle = 10,
#     script_lines = "module load R/flexiblas/4.5.0") {
#   name <- sprintf("slurm_%dc%dg", cpus, memory_gb)
#   crew.cluster::crew_controller_slurm(
#     name = name,
#     workers = workers,
#     seconds_idle = seconds_idle,
#     retry_tasks = FALSE,
#     options_cluster = crew.cluster::crew_options_slurm(
#       script_lines = script_lines,
#       memory_gigabytes_required = memory_gb,
#       cpus_per_task = cpus,
#       log_output = file.path("logs", "crew_log_%A.txt"),
#       log_error = file.path("logs", "crew_log_%A.txt")
#     )
#   )
# }
# controllers(mspipeline)[["genome_alignment"]] <-
#   create_slurm_controller(cpus = 64, memory_gb = 20)

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
# don't have to run the entire pipeline for this
# let's just run the demultiplexing step
mspipeline <- run_step(mspipeline, "barcode_demultiplex")
plot_demultiplex(mspipeline)

## ----echo=FALSE---------------------------------------------------------------
utils::sessionInfo()

