# FLAMES 2.3.1

Changqing Wang, Oliver Voogd, Yupei You

#### 15 January 2026

#### Package

FLAMES 2.4.2

# Contents

* [1 FLAMES](#flames)
  + [1.1 Creating a pipeline](#creating-a-pipeline)
  + [1.2 Running the pipeline](#running-the-pipeline)
    - [1.2.1 HPC support](#hpc-support)
  + [1.3 Visualizations](#visualizations)
    - [1.3.1 QC plots](#qc-plots)
    - [1.3.2 Work in progress](#work-in-progress)
  + [1.4 FLAMES on Windows](#flames-on-windows)
  + [1.5 Citation](#citation)
* [2 Session Info](#session-info)
* [References](#references)

# 1 FLAMES

The overhauled FLAMES 2.3.1 pipeline provides convenient pipelines for performing single-cell and bulk long-read analysis of mutations and isoforms. The pipeline is designed to take various type of experiments, e.g. with or without known cell barcodes and custome cell barcode designs, to reduce the need of constantly re-inventing the wheel for every new sequencing protocol.

![](data:image/png;base64...)

Figure 1: FLAMES pipeline

## 1.1 Creating a pipeline

To start your long-read RNA-seq analysis, simply create a pipeline via either `BulkPipeline()`, `SingleCellPipeline()` or `MultiSampleSCPipeline()`. Let’s try `SingleCellPipeline()` first:

```
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
#> Writing configuration parameters to:  /tmp/RtmpYkCTiN/file32419233b4943f/config_file_3293586.json
#> Configured steps:
#>  barcode_demultiplex: TRUE
#>  genome_alignment: TRUE
#>  gene_quantification: TRUE
#>  isoform_identification: TRUE
#>  read_realignment: TRUE
#>  transcript_quantification: TRUE
#> samtools not found, will use Rsamtools package instead
pipeline
#> → A FLAMES.SingleCellPipeline outputting to '/tmp/RtmpYkCTiN/file32419233b4943f'
#>
#> ── Inputs
#> ✔ fastq: '...0d7857/FLAMES/extdata/fastq/musc_rps24.fastq.gz'
#> ✔ annotation: '...Rinst31e8bd7c0d7857/FLAMES/extdata/rps24.gtf.gz'
#> ✔ genome_fa: '/tmp/RtmpYkCTiN/file32419233b4943f/rps24.fa'
#> ✔ barcodes_file: '/tmp/RtmpYkCTiN/file32419233b4943f/bc_allow.tsv'
#>
#> ── Outputs
#> ℹ demultiplexed_fastq: 'matched_reads.fastq.gz'
#> ℹ deduped_fastq: 'matched_reads_dedup.fastq.gz'
#> ℹ genome_bam: 'align2genome.bam'
#> ℹ transcriptome_assembly: 'transcript_assembly.fa'
#> ℹ transcriptome_bam: 'realign2transcript.bam'
#>
#> ── Pipeline Steps
#> ℹ barcode_demultiplex (pending)
#> ℹ genome_alignment (pending)
#> ℹ gene_quantification (pending)
#> ℹ isoform_identification (pending)
#> ℹ read_realignment (pending)
#> ℹ transcript_quantification (pending)
```

## 1.2 Running the pipeline

To execute the pipeline, simply call `run_FLAMES(pipeline)`. This will run through all the steps in the pipeline, returning a updated pipeline object:

```
pipeline <- run_FLAMES(pipeline)
#> ── Running step: barcode_demultiplex @ Thu Jan 15 17:53:01 2026 ────────────────
#> Using flexiplex for barcode demultiplexing.
#> FLEXIPLEX 0.96.2
#> Setting max barcode edit distance to 2
#> Setting max flanking sequence edit distance to 8
#> Setting read IDs to be  replaced
#> Setting number of threads to 8
#> Search pattern:
#> primer: CTACACGACGCTCTTCCGATCT
#> BC: NNNNNNNNNNNNNNNN
#> UMI: NNNNNNNNNNNN
#> polyT: TTTTTTTTT
#> Setting known barcodes from /tmp/RtmpYkCTiN/file32419233b4943f/bc_allow.tsv
#> Number of known barcodes: 143
#> Processing file: /tmp/RtmpW00AUH/Rinst31e8bd7c0d7857/FLAMES/extdata/fastq/musc_rps24.fastq.gz
#> Searching for barcodes...
#> Number of reads processed: 393
#> Number of reads where at least one barcode was found: 368
#> Number of reads with exactly one barcode match: 364
#> Number of chimera reads: 1
#> All done!
#> Reads    Barcodes
#> 10   2
#> 9    2
#> 8    5
#> 7    4
#> 6    3
#> 5    7
#> 4    14
#> 3    14
#> 2    29
#> 1    57
#> ── Running step: genome_alignment @ Thu Jan 15 17:53:02 2026 ───────────────────
#> Creating junction bed file from GFF3 annotation.
#> Aligning sample /tmp/RtmpYkCTiN/file32419233b4943f/matched_reads.fastq.gz -> /tmp/RtmpYkCTiN/file32419233b4943f/align2genome.bam
#> Warning in minimap2_align(fq_in = fastqs[i], fa_file = genome, config =
#> pipeline@config, : samtools not found, using Rsamtools instead, this could be
#> slower and might fail for large BAM files.
#> Sorting BAM files by genome coordinates with 8 threads...
#> Indexing bam files
#> ── Running step: gene_quantification @ Thu Jan 15 17:53:03 2026 ────────────────
#> 17:53:03 Thu Jan 15 2026 quantify genes
#> Using BAM(s): '/tmp/RtmpYkCTiN/file32419233b4943f/align2genome.bam'
#> Assigning reads to genes...
#> Writing the gene count matrix ...
#> Plotting the saturation curve ...
#> Generating deduplicated fastq file ...
#> ── Running step: isoform_identification @ Thu Jan 15 17:53:05 2026 ─────────────
#> #### Read gene annotations
#>  Removed similar transcripts in gene annotation: Counter()
#> #### find isoforms
#> chr14
#> ── Running step: read_realignment @ Thu Jan 15 17:53:05 2026 ───────────────────
#> Checking for fastq file(s) /tmp/RtmpW00AUH/Rinst31e8bd7c0d7857/FLAMES/extdata/fastq/musc_rps24.fastq.gz
#>  files found
#> Checking for fastq file(s) /tmp/RtmpYkCTiN/file32419233b4943f/matched_reads.fastq.gz
#>  files found
#> Checking for fastq file(s) /tmp/RtmpYkCTiN/file32419233b4943f/matched_reads_dedup.fastq.gz
#>  files found
#> Realigning sample /tmp/RtmpYkCTiN/file32419233b4943f/matched_reads_dedup.fastq.gz -> /tmp/RtmpYkCTiN/file32419233b4943f/realign2transcript.bam
#> Warning in minimap2_align(fq_in = fastqs[i], fa_file =
#> pipeline@transcriptome_assembly, : samtools not found, using Rsamtools instead,
#> this could be slower and might fail for large BAM files.
#> Sorting BAM files by 8 with CB threads...
#> ── Running step: transcript_quantification @ Thu Jan 15 17:53:06 2026 ──────────
pipeline
#> ✔ A FLAMES.SingleCellPipeline outputting to '/tmp/RtmpYkCTiN/file32419233b4943f'
#>
#> ── Inputs
#> ✔ fastq: '...0d7857/FLAMES/extdata/fastq/musc_rps24.fastq.gz'
#> ✔ annotation: '...Rinst31e8bd7c0d7857/FLAMES/extdata/rps24.gtf.gz'
#> ✔ genome_fa: '/tmp/RtmpYkCTiN/file32419233b4943f/rps24.fa'
#> ✔ barcodes_file: '/tmp/RtmpYkCTiN/file32419233b4943f/bc_allow.tsv'
#>
#> ── Outputs
#> ✔ demultiplexed_fastq: 'matched_reads.fastq.gz' [217.1 KB]
#> ✔ deduped_fastq: 'matched_reads_dedup.fastq.gz' [203.7 KB]
#> ✔ genome_bam: 'align2genome.bam' [270.9 KB]
#> ✔ novel_isoform_annotation: 'isoform_annotated.gff3' [7.4 KB]
#> ✔ transcriptome_assembly: 'transcript_assembly.fa' [8.4 KB]
#> ✔ transcriptome_bam: 'realign2transcript.bam' [394.0 KB]
#>
#> ── Pipeline Steps
#> ✔ barcode_demultiplex (completed in 0.72 sec)
#> ✔ genome_alignment (completed in 0.38 sec)
#> ✔ gene_quantification (completed in 2.00 sec)
#> ✔ isoform_identification (completed in 0.73 sec)
#> ✔ read_realignment (completed in 0.23 sec)
#> ✔ transcript_quantification (completed in 0.79 sec)
```

If you run into any error, `run_FLAMES()` will stop and return the pipeline object with the error message. After resolving the error, you can run `resume_FLAMES(pipeline)` to continue the pipeline from the last step. There is also `run_step(pipeline, step_name)` to run a specific step in the pipeline. Let’s show this by deliberately causing an error via deleting the input files:

```
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
#> Output directory does not exists: one is being created
#> [1] "/tmp/RtmpYkCTiN/file324192297883a7"
#> Writing configuration parameters to:  /tmp/RtmpYkCTiN/file32419233b4943f/config_file_3293586.json
#> Configured steps:
#>  barcode_demultiplex: TRUE
#>  genome_alignment: TRUE
#>  gene_quantification: TRUE
#>  isoform_identification: TRUE
#>  read_realignment: TRUE
#>  transcript_quantification: TRUE
#> samtools not found, will use Rsamtools package instead

# delete the reference genome
unlink(genome_fa)
pipeline2 <- run_FLAMES(pipeline2)
#> ── Running step: barcode_demultiplex @ Thu Jan 15 17:53:07 2026 ────────────────
#> Using flexiplex for barcode demultiplexing.
#> FLEXIPLEX 0.96.2
#> Setting max barcode edit distance to 2
#> Setting max flanking sequence edit distance to 8
#> Setting read IDs to be  replaced
#> Setting number of threads to 8
#> Search pattern:
#> primer: CTACACGACGCTCTTCCGATCT
#> BC: NNNNNNNNNNNNNNNN
#> UMI: NNNNNNNNNNNN
#> polyT: TTTTTTTTT
#> Setting known barcodes from /tmp/RtmpYkCTiN/file32419233b4943f/bc_allow.tsv
#> Number of known barcodes: 143
#> Processing file: /tmp/RtmpW00AUH/Rinst31e8bd7c0d7857/FLAMES/extdata/fastq/musc_rps24.fastq.gz
#> Searching for barcodes...
#> Number of reads processed: 393
#> Number of reads where at least one barcode was found: 368
#> Number of reads with exactly one barcode match: 364
#> Number of chimera reads: 1
#> All done!
#> Reads    Barcodes
#> 10   2
#> 9    2
#> 8    5
#> 7    4
#> 6    3
#> 5    7
#> 4    14
#> 3    14
#> 2    29
#> 1    57
#> ── Running step: genome_alignment @ Thu Jan 15 17:53:07 2026 ───────────────────
#> Creating junction bed file from GFF3 annotation.
#> Aligning sample /tmp/RtmpYkCTiN/file324192297883a7/matched_reads.fastq.gz -> /tmp/RtmpYkCTiN/file324192297883a7/align2genome.bam
#> Warning in minimap2_align(fq_in = fastqs[i], fa_file = genome, config =
#> pipeline@config, : samtools not found, using Rsamtools instead, this could be
#> slower and might fail for large BAM files.
#> Warning in value[[3L]](cond): Error in step genome_alignment: argument is
#> missing, with no default, pipeline stopped.
pipeline2
#> ! A FLAMES.SingleCellPipeline outputting to '/tmp/RtmpYkCTiN/file324192297883a7'
#>
#> ── Inputs
#> ✔ fastq: '...0d7857/FLAMES/extdata/fastq/musc_rps24.fastq.gz'
#> ✔ annotation: '...Rinst31e8bd7c0d7857/FLAMES/extdata/rps24.gtf.gz'
#> ! genome_fa: '/tmp/RtmpYkCTiN/file32419233b4943f/rps24.fa' [missing]
#> ✔ barcodes_file: '/tmp/RtmpYkCTiN/file32419233b4943f/bc_allow.tsv'
#>
#> ── Outputs
#> ✔ demultiplexed_fastq: 'matched_reads.fastq.gz' [217.1 KB]
#> ℹ deduped_fastq: 'matched_reads_dedup.fastq.gz'
#> ℹ genome_bam: 'align2genome.bam'
#> ℹ transcriptome_assembly: 'transcript_assembly.fa'
#> ℹ transcriptome_bam: 'realign2transcript.bam'
#>
#> ── Pipeline Steps
#> ✔ barcode_demultiplex (completed in 0.23 sec)
#> ✖ genome_alignment (failed: Error in .makeMessage(..., domain = domain): argument is missing, with no default
#> )
#> ℹ gene_quantification (pending)
#> ℹ isoform_identification (pending)
#> ℹ read_realignment (pending)
#> ℹ transcript_quantification (pending)
```

Let’s then fix the error by re-creating the reference genome file and resume the pipeline:

```
R.utils::gunzip(
  filename = system.file("extdata", "rps24.fa.gz", package = "FLAMES"),
  destname = genome_fa, remove = FALSE
)
pipeline2 <- resume_FLAMES(pipeline2)
#> Resuming pipeline from step: genome_alignment
#> ── Running step: genome_alignment @ Thu Jan 15 17:53:07 2026 ───────────────────
#> Aligning sample /tmp/RtmpYkCTiN/file324192297883a7/matched_reads.fastq.gz -> /tmp/RtmpYkCTiN/file324192297883a7/align2genome.bam
#> Warning in minimap2_align(fq_in = fastqs[i], fa_file = genome, config =
#> pipeline@config, : samtools not found, using Rsamtools instead, this could be
#> slower and might fail for large BAM files.
#> Sorting BAM files by genome coordinates with 8 threads...
#> Indexing bam files
#> ── Running step: gene_quantification @ Thu Jan 15 17:53:08 2026 ────────────────
#> 17:53:08 Thu Jan 15 2026 quantify genes
#> Using BAM(s): '/tmp/RtmpYkCTiN/file324192297883a7/align2genome.bam'
#> Assigning reads to genes...
#> Writing the gene count matrix ...
#> Plotting the saturation curve ...
#> Generating deduplicated fastq file ...
#> ── Running step: isoform_identification @ Thu Jan 15 17:53:08 2026 ─────────────
#> #### Read gene annotations
#>  Removed similar transcripts in gene annotation: Counter()
#> #### find isoforms
#> chr14
#> ── Running step: read_realignment @ Thu Jan 15 17:53:09 2026 ───────────────────
#> Checking for fastq file(s) /tmp/RtmpW00AUH/Rinst31e8bd7c0d7857/FLAMES/extdata/fastq/musc_rps24.fastq.gz
#>  files found
#> Checking for fastq file(s) /tmp/RtmpYkCTiN/file324192297883a7/matched_reads.fastq.gz
#>  files found
#> Checking for fastq file(s) /tmp/RtmpYkCTiN/file324192297883a7/matched_reads_dedup.fastq.gz
#>  files found
#> Realigning sample /tmp/RtmpYkCTiN/file324192297883a7/matched_reads_dedup.fastq.gz -> /tmp/RtmpYkCTiN/file324192297883a7/realign2transcript.bam
#> Warning in minimap2_align(fq_in = fastqs[i], fa_file =
#> pipeline@transcriptome_assembly, : samtools not found, using Rsamtools instead,
#> this could be slower and might fail for large BAM files.
#> Sorting BAM files by 8 with CB threads...
#> ── Running step: transcript_quantification @ Thu Jan 15 17:53:09 2026 ──────────
pipeline2
#> ✔ A FLAMES.SingleCellPipeline outputting to '/tmp/RtmpYkCTiN/file324192297883a7'
#>
#> ── Inputs
#> ✔ fastq: '...0d7857/FLAMES/extdata/fastq/musc_rps24.fastq.gz'
#> ✔ annotation: '...Rinst31e8bd7c0d7857/FLAMES/extdata/rps24.gtf.gz'
#> ✔ genome_fa: '/tmp/RtmpYkCTiN/file32419233b4943f/rps24.fa'
#> ✔ barcodes_file: '/tmp/RtmpYkCTiN/file32419233b4943f/bc_allow.tsv'
#>
#> ── Outputs
#> ✔ demultiplexed_fastq: 'matched_reads.fastq.gz' [217.1 KB]
#> ✔ deduped_fastq: 'matched_reads_dedup.fastq.gz' [203.7 KB]
#> ✔ genome_bam: 'align2genome.bam' [270.9 KB]
#> ✔ novel_isoform_annotation: 'isoform_annotated.gff3' [7.4 KB]
#> ✔ transcriptome_assembly: 'transcript_assembly.fa' [8.4 KB]
#> ✔ transcriptome_bam: 'realign2transcript.bam' [394.0 KB]
#>
#> ── Pipeline Steps
#> ✔ barcode_demultiplex (completed in 0.23 sec)
#> ✔ genome_alignment (completed in 0.17 sec)
#> ✔ gene_quantification (completed in 0.64 sec)
#> ✔ isoform_identification (completed in 0.41 sec)
#> ✔ read_realignment (completed in 0.22 sec)
#> ✔ transcript_quantification (completed in 0.62 sec)
```

After completing the pipeline, a `SingleCellExperiment` object is created (or `SummarizedExperiment` for bulk pipeline and list of `SingleCellExperiment` for multi-sample pipeline). You can access the results via `experiment(pipeline)`:

```
experiment(pipeline)
#> class: SingleCellExperiment
#> dim: 10 137
#> metadata(0):
#> assays(1): counts
#> rownames(10): ENSMUSG00000025290.17_19_5159_1
#>   ENSMUSG00000025290.17_19_5159_2 ... ENSMUST00000169826.2
#>   ENSMUST00000225023.1
#> rowData names(6): transcript_id source ... rank gene_id
#> colnames(137): AACTCTTGTCACCTAA AACCATGAGTCGTTTG ... TTGTAGGTCAGTGTTG
#>   TTTATGCAGACTAGAT
#> colData names(0):
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

### 1.2.1 HPC support

Individual steps can be submitted as HPC jobs via `crew` and `crew.cluster` packages, simply supply a list of crew controllers (named by step name) to the `controllers` argument of the pipeline constructors. For example, we could run the alignment steps through controllers, while keeping the rest in the main R session.

```
# example_pipeline provides an example pipeline for each of the three types
# of pipelines: BulkPipeline, SingleCellPipeline and MultiSampleSCPipeline
mspipeline <- example_pipeline("MultiSampleSCPipeline")
#> Writing configuration parameters to:  /tmp/RtmpYkCTiN/file3241922e42ed9e/config_file_3293586.json
#> Configured steps:
#>  barcode_demultiplex: TRUE
#>  genome_alignment: TRUE
#>  gene_quantification: TRUE
#>  isoform_identification: TRUE
#>  read_realignment: TRUE
#>  transcript_quantification: TRUE
#> samtools not found, will use Rsamtools package instead
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
```

`run_FLAMES()` will then submit the alignment step to the crew controller. By default, `run_step()` will ignore the crew controllers and run the step in the main R session, since it is easier to debug. You can use `run_step(pipeline, step_name, disable_controller = FALSE)` to prevent this behavior and run the step in crew controllers if available.

You can tailor the resources for each step by specifying different arguments to the controllers. The alignment step typically benifits from more cores (e.g. 64 cores and 20GB memory), whereas other steps might not need as much cores but more memory hungry.

```
# An example helper function to create a Slurm controller with specific resources
create_slurm_controller <- function(
    cpus, memory_gb, workers = 10, seconds_idle = 10,
    script_lines = "module load R/flexiblas/4.5.0") {
  name <- sprintf("slurm_%dc%dg", cpus, memory_gb)
  crew.cluster::crew_controller_slurm(
    name = name,
    workers = workers,
    seconds_idle = seconds_idle,
    retry_tasks = FALSE,
    options_cluster = crew.cluster::crew_options_slurm(
      script_lines = script_lines,
      memory_gigabytes_required = memory_gb,
      cpus_per_task = cpus,
      log_output = file.path("logs", "crew_log_%A.txt"),
      log_error = file.path("logs", "crew_log_%A.txt")
    )
  )
}
controllers(mspipeline)[["genome_alignment"]] <-
  create_slurm_controller(cpus = 64, memory_gb = 20)
```

See also the [`crew.cluster` website](https://wlandau.github.io/crew.cluster/reference/index.html) for more information on the supported job schedulers.

## 1.3 Visualizations

### 1.3.1 QC plots

Quality metrics are collected throughout the pipeline, and FLAMES provide visiualization functions to plot the metrics. For the first demultiplexing step, we can use the `plot_demultiplex` function to see how well many reads are retained after demultiplexing:

```
# don't have to run the entire pipeline for this
# let's just run the demultiplexing step
mspipeline <- run_step(mspipeline, "barcode_demultiplex")
#> ── Running step: barcode_demultiplex @ Thu Jan 15 17:53:10 2026 ────────────────
#> Using flexiplex for barcode demultiplexing.
#> FLEXIPLEX 0.96.2
#> Setting max barcode edit distance to 2
#> Setting max flanking sequence edit distance to 8
#> Setting read IDs to be  replaced
#> Setting number of threads to 1
#> Search pattern:
#> primer: CTACACGACGCTCTTCCGATCT
#> BC: NNNNNNNNNNNNNNNN
#> UMI: NNNNNNNNNNNN
#> polyT: TTTTTTTTT
#> Setting known barcodes from /tmp/RtmpYkCTiN/file3241922e42ed9e/bc_allow.tsv
#> Number of known barcodes: 143
#> Processing file: /tmp/RtmpYkCTiN/file3241922e42ed9e/fastq/sample1.fq.gz
#> Searching for barcodes...
#> Processing file: /tmp/RtmpYkCTiN/file3241922e42ed9e/fastq/sample2.fq.gz
#> Searching for barcodes...
#> Processing file: /tmp/RtmpYkCTiN/file3241922e42ed9e/fastq/sample3.fq.gz
#> Searching for barcodes...
#> Number of reads processed: 393
#> Number of reads where at least one barcode was found: 368
#> Number of reads with exactly one barcode match: 364
#> Number of chimera reads: 1
#> All done!
#> Reads    Barcodes
#> 10   2
#> 9    2
#> 8    5
#> 7    4
#> 6    3
#> 5    7
#> 4    14
#> 3    14
#> 2    29
#> 1    57
#> FLEXIPLEX 0.96.2
#> Setting max barcode edit distance to 2
#> Setting max flanking sequence edit distance to 8
#> Setting read IDs to be  replaced
#> Setting number of threads to 1
#> Search pattern:
#> primer: CTACACGACGCTCTTCCGATCT
#> BC: NNNNNNNNNNNNNNNN
#> UMI: NNNNNNNNNNNN
#> polyT: TTTTTTTTT
#> Setting known barcodes from /tmp/RtmpYkCTiN/file3241922e42ed9e/bc_allow.tsv
#> Number of known barcodes: 143
#> Processing file: /tmp/RtmpYkCTiN/file3241922e42ed9e/fastq/sample1.fq.gz
#> Searching for barcodes...
#> Number of reads processed: 100
#> Number of reads where at least one barcode was found: 92
#> Number of reads with exactly one barcode match: 91
#> Number of chimera reads: 1
#> All done!
#> Reads    Barcodes
#> 4    1
#> 3    9
#> 2    9
#> 1    44
#> FLEXIPLEX 0.96.2
#> Setting max barcode edit distance to 2
#> Setting max flanking sequence edit distance to 8
#> Setting read IDs to be  replaced
#> Setting number of threads to 1
#> Search pattern:
#> primer: CTACACGACGCTCTTCCGATCT
#> BC: NNNNNNNNNNNNNNNN
#> UMI: NNNNNNNNNNNN
#> polyT: TTTTTTTTT
#> Setting known barcodes from /tmp/RtmpYkCTiN/file3241922e42ed9e/bc_allow.tsv
#> Number of known barcodes: 143
#> Processing file: /tmp/RtmpYkCTiN/file3241922e42ed9e/fastq/sample2.fq.gz
#> Searching for barcodes...
#> Number of reads processed: 100
#> Number of reads where at least one barcode was found: 95
#> Number of reads with exactly one barcode match: 94
#> Number of chimera reads: 0
#> All done!
#> Reads    Barcodes
#> 4    2
#> 3    3
#> 2    16
#> 1    47
#> FLEXIPLEX 0.96.2
#> Setting max barcode edit distance to 2
#> Setting max flanking sequence edit distance to 8
#> Setting read IDs to be  replaced
#> Setting number of threads to 1
#> Search pattern:
#> primer: CTACACGACGCTCTTCCGATCT
#> BC: NNNNNNNNNNNNNNNN
#> UMI: NNNNNNNNNNNN
#> polyT: TTTTTTTTT
#> Setting known barcodes from /tmp/RtmpYkCTiN/file3241922e42ed9e/bc_allow.tsv
#> Number of known barcodes: 143
#> Processing file: /tmp/RtmpYkCTiN/file3241922e42ed9e/fastq/sample3.fq.gz
#> Searching for barcodes...
#> Number of reads processed: 193
#> Number of reads where at least one barcode was found: 181
#> Number of reads with exactly one barcode match: 179
#> Number of chimera reads: 0
#> All done!
#> Reads    Barcodes
#> 7    1
#> 6    1
#> 5    1
#> 4    7
#> 3    10
#> 2    27
#> 1    53
plot_demultiplex(mspipeline)
#> $reads_count_plot
```

![](data:image/png;base64...)

```
#>
#> $knee_plot
#> `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
#>
#> $flank_editdistance_plot
```

![](data:image/png;base64...)

```
#>
#> $barcode_editdistance_plot
```

![](data:image/png;base64...)

```
#>
#> $cutadapt_plot
```

![](data:image/png;base64...)

### 1.3.2 Work in progress

More examples coming soon.

## 1.4 FLAMES on Windows

Due to FLAMES requiring minimap2 and pysam, FLAMES is currently unavaliable on Windows.

## 1.5 Citation

Please cite the flames’s paper (Tian et al. [2020](#ref-flames)) if you use flames in your research. As FLAMES used incorporates BLAZE (You et al. [2023](#ref-blaze)), flexiplex (Davidson et al. [2023](#ref-flexiplex)) and minimap2 (Li [2018](#ref-minimap2)), samtools, bambu (Chen et al. [2023](#ref-bambu)). Please make sure to cite when using these tools.

# 2 Session Info

```
#> R version 4.5.2 (2025-10-31)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] FLAMES_2.4.2     BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.2               later_1.4.5
#>   [3] BiocIO_1.20.0               bitops_1.0-9
#>   [5] filelock_1.0.3              tibble_3.3.1
#>   [7] R.oo_1.27.1                 polyclip_1.10-7
#>   [9] bambu_3.12.1                XML_3.99-0.20
#>  [11] lifecycle_1.0.5             pwalign_1.6.0
#>  [13] edgeR_4.8.2                 doParallel_1.0.17
#>  [15] vroom_1.6.7                 processx_3.8.6
#>  [17] lattice_0.22-7              MASS_7.3-65
#>  [19] magrittr_2.0.4              limma_3.66.0
#>  [21] sass_0.4.10                 rmarkdown_2.30
#>  [23] jquerylib_0.1.4             yaml_2.3.12
#>  [25] metapod_1.18.0              otel_0.2.0
#>  [27] reticulate_1.44.1           cowplot_1.2.0
#>  [29] DBI_1.2.3                   RColorBrewer_1.1-3
#>  [31] abind_1.4-8                 ShortRead_1.68.0
#>  [33] GenomicRanges_1.62.1        purrr_1.2.1
#>  [35] R.utils_2.13.0              BiocGenerics_0.56.0
#>  [37] RCurl_1.98-1.17             yulab.utils_0.2.3
#>  [39] tweenr_2.0.3                rappdirs_0.3.3
#>  [41] circlize_0.4.17             IRanges_2.44.0
#>  [43] S4Vectors_0.48.0            ggrepel_0.9.6
#>  [45] irlba_2.3.5.1               dqrng_0.4.1
#>  [47] codetools_0.2-20            DelayedArray_0.36.0
#>  [49] scuttle_1.20.0              ggforce_0.5.0
#>  [51] tidyselect_1.2.1            shape_1.4.6.1
#>  [53] UCSC.utils_1.6.1            farver_2.1.2
#>  [55] ScaledMatrix_1.18.0         viridis_0.6.5
#>  [57] matrixStats_1.5.0           stats4_4.5.2
#>  [59] Seqinfo_1.0.0               GenomicAlignments_1.46.0
#>  [61] jsonlite_2.0.0              GetoptLong_1.1.0
#>  [63] BiocNeighbors_2.4.0         scater_1.38.0
#>  [65] iterators_1.0.14            foreach_1.5.2
#>  [67] tools_4.5.2                 collections_0.3.9
#>  [69] Rcpp_1.1.1                  glue_1.8.0
#>  [71] gridExtra_2.3               SparseArray_1.10.8
#>  [73] mgcv_1.9-4                  xfun_0.55
#>  [75] MatrixGenerics_1.22.0       GenomeInfoDb_1.46.2
#>  [77] dplyr_1.1.4                 withr_3.0.2
#>  [79] BiocManager_1.30.27         fastmap_1.2.0
#>  [81] basilisk_1.22.0             bluster_1.20.0
#>  [83] latticeExtra_0.6-31         digest_0.6.39
#>  [85] rsvd_1.0.5                  R6_2.6.1
#>  [87] colorspace_2.1-2            jpeg_0.1-11
#>  [89] dichromat_2.0-0.1           RSQLite_2.4.5
#>  [91] cigarillo_1.0.0             R.methodsS3_1.8.2
#>  [93] tidyr_1.3.2                 generics_0.1.4
#>  [95] data.table_1.18.0           rtracklayer_1.70.1
#>  [97] httr_1.4.7                  S4Arrays_1.10.1
#>  [99] scatterpie_0.2.6            pkgconfig_2.0.3
#> [101] gtable_0.3.6                blob_1.3.0
#> [103] ComplexHeatmap_2.26.0       S7_0.2.1
#> [105] hwriter_1.3.2.1             SingleCellExperiment_1.32.0
#> [107] XVector_0.50.0              htmltools_0.5.9
#> [109] bookdown_0.46               clue_0.3-66
#> [111] scales_1.4.0                Biobase_2.70.0
#> [113] png_0.1-8                   nanonext_1.7.2
#> [115] SpatialExperiment_1.20.0    scran_1.38.0
#> [117] ggfun_0.2.0                 knitr_1.51
#> [119] tzdb_0.5.0                  rjson_0.2.23
#> [121] nlme_3.1-168                curl_7.0.0
#> [123] crew_1.3.0                  cachem_1.1.0
#> [125] GlobalOptions_0.1.3         stringr_1.6.0
#> [127] parallel_4.5.2              vipor_0.4.7
#> [129] AnnotationDbi_1.72.0        restfulr_0.0.16
#> [131] pillar_1.11.1               grid_4.5.2
#> [133] vctrs_0.6.5                 promises_1.5.0
#> [135] BiocSingular_1.26.1         beachmat_2.26.0
#> [137] cluster_2.1.8.1             archive_1.1.12.1
#> [139] beeswarm_0.4.0              evaluate_1.0.5
#> [141] tinytex_0.58                readr_2.1.6
#> [143] GenomicFeatures_1.62.0      magick_2.9.0
#> [145] locfit_1.5-9.12             cli_3.6.5
#> [147] compiler_4.5.2              Rsamtools_2.26.0
#> [149] rlang_1.1.7                 crayon_1.5.3
#> [151] labeling_0.4.3              interp_1.1-6
#> [153] ps_1.9.1                    fs_1.6.6
#> [155] ggbeeswarm_0.7.3            stringi_1.8.7
#> [157] viridisLite_0.4.2           deldir_2.0-4
#> [159] BiocParallel_1.44.0         Biostrings_2.78.0
#> [161] Matrix_1.7-4                dir.expiry_1.18.0
#> [163] BSgenome_1.78.0             hms_1.1.4
#> [165] bit64_4.6.0-1               ggplot2_4.0.1
#> [167] statmod_1.5.1               KEGGREST_1.50.0
#> [169] SummarizedExperiment_1.40.0 mirai_2.5.3
#> [171] igraph_2.2.1                memoise_2.0.1
#> [173] bslib_0.9.0                 bit_4.6.0
#> [175] xgboost_3.1.3.1
```

# References

Chen, Ying, Andre Sim, Yuk Kei Wan, Keith Yeo, Joseph Jing Xian Lee, Min Hao Ling, Michael I Love, and Jonathan Göke. 2023. “Context-Aware Transcript Quantification from Long-Read Rna-Seq Data with Bambu.” *Nature Methods*, 1–9.

Davidson, Nadia M, Noorul Amin, Ling Min Hao, Changqing Wang, Oliver Cheng, Jonathan M Goeke, Matthew E Ritchie, and Shuyi Wu. 2023. “Flexiplex: A Versatile Demultiplexer and Search Tool for Omics Data.” *bioRxiv*, 2023–08.

Li, Heng. 2018. “Minimap2: pairwise alignment for nucleotide sequences.” *Bioinformatics* 34 (18): 3094–3100. <https://doi.org/10.1093/bioinformatics/bty191>.

Tian, Luyi, Jafar S. Jabbari, Rachel Thijssen, Quentin Gouil, Shanika L. Amarasinghe, Hasaru Kariyawasam, Shian Su, et al. 2020. “Comprehensive Characterization of Single Cell Full-Length Isoforms in Human and Mouse with Long-Read Sequencing.” *bioRxiv*. <https://doi.org/10.1101/2020.08.10.243543>.

You, Yupei, Yair DJ Prawer, De Paoli-Iseppi, Cameron PJ Hunt, Clare L Parish, Heejung Shim, Michael B Clark, and others. 2023. “Identification of Cell Barcodes from Long-Read Single-Cell Rna-Seq with Blaze.” *Genome Biology* 24 (1): 1–23.