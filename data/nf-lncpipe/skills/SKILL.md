---
name: lncpipe
description: This pipeline performs comprehensive analysis of long non-coding RNAs from RNA-seq data using FASTQ inputs, reference genomes, and various alignment or pseudo-alignment options including STAR, Salmon, and Kallisto. Use when identifying and quantifying lncRNAs across multiple samples, especially when requiring integrated quality control via MultiQC and flexible read counting through featureCounts or HTSeq.
homepage: https://github.com/nf-core/lncpipe
---

## Overview
nf-core/lncpipe is a bioinformatics pipeline designed for the systematic discovery and quantification of long non-coding RNAs (lncRNAs) from transcriptomic data. It automates the transition from raw sequencing reads to processed expression matrices, handling quality control, alignment, and biotype-specific quantification.

In practice, users provide a samplesheet and reference files to generate standardized outputs including aligned BAM files, transcript counts, and comprehensive QC reports. The pipeline supports both traditional alignment-based workflows and faster pseudo-alignment routes, allowing for flexibility based on computational resources and research goals.

## Data preparation
The pipeline requires a comma-separated (CSV) samplesheet specified with the `--input` parameter. This file must contain a header and define the sample names, paths to FASTQ files, and the library strandedness.

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2,strandedness
CONTROL_REP1,AEG588A1_R1.fastq.gz,AEG588A1_R2.fastq.gz,auto
```

Reference requirements:
- A FASTA genome file is mandatory via `--fasta` unless a pre-configured iGenomes ID is provided via `--genome`.
- Gene annotations should be provided using `--gtf` or `--gff`.
- Optional files include `--transcript_fasta` for pseudo-alignment or `--ribo_database_manifest` for rRNA removal using SortMeRNA.

## How to run
The pipeline is executed using Nextflow with the `-profile` flag to define the software container engine (e.g., Docker or Singularity). It is recommended to use `-r` to pin a specific version and `-resume` to continue from previous successful steps if a run is interrupted.

```bash
nextflow run nf-core/lncpipe \
   -profile <docker/singularity/conda> \
   --input samplesheet.csv \
   --outdir <RESULTS_DIR> \
   --genome GRCh38
```

Key parameters include:
- `--aligner`: Choose between `star` (default) or `hisat2`.
- `--pseudo_aligner`: Specify `salmon` or `kallisto` for alignment-free quantification.
- `--counts`: Select `featurecounts` (default) or `htseq` for read counting.
- `--remove_ribo_rna`: Enable rRNA depletion using SortMeRNA.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverable for quality assessment is the MultiQC report, typically found at `multiqc/multiqc_report.html`, which aggregates statistics from FastQC and alignment steps.

Other key outputs include:
- Aligned reads in BAM format (if using an aligner).
- Gene and transcript-level quantification matrices.
- Trimmed FASTQ files if `--save_trimmed` is enabled.

For a complete list of generated files and their formats, refer to the [official output documentation](https://nf-co.re/lncpipe/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
