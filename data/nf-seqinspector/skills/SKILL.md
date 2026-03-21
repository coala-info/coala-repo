---
name: seqinspector
description: This pipeline processes raw FASTQ sequences to perform comprehensive quality control including subsampling, mapping with Bwamem2, and contamination detection using FastqScreen and Picard metrics. Use when managing sequencing core facilities or research projects that require detailed per-sample and project-wide MultiQC reports, including optional parsing of Illumina run folder statistics.
homepage: https://github.com/nf-core/seqinspector
---

## Overview
nf-core/seqinspector is designed for high-throughput quality control of raw sequencing data. It addresses the need for standardized assessment of sequence quality, duplication levels, and potential contaminants across various data types including DNA, RNA, and synthetic sequences.

The pipeline processes FASTQ files to generate a suite of QC metrics and alignments. It culminates in a MultiQC report that can integrate Illumina run folder statistics and custom metadata tags, making it suitable for both individual research samples and large-scale sequencing runs.

## Data preparation
The pipeline requires a comma-separated samplesheet containing paths to FASTQ files and optional metadata. Each row represents a single-end or paired-end sample.

**Samplesheet columns:**
- `sample`: Unique sample identifier (no spaces).
- `fastq_1`: Path to the first gzipped FASTQ file.
- `fastq_2`: Path to the second gzipped FASTQ file (optional).
- `rundir`: Path to an Illumina run folder directory or a `.tar.gz` archive (optional).
- `tags`: Colon-separated list of tags for MultiQC reporting (e.g., `lane1:project5`).

**Example `samplesheet.csv`:**
```csv
sample,fastq_1,fastq_2,rundir,tags
CONTROL_REP1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz,200624_A00834_0183_BHMTFYDRXX,lane1:project5:group2
```

**Reference files:**
- A reference genome is required via `--genome` (iGenomes ID) or `--fasta`.
- If using Picard HS metrics, `--bait_intervals` and `--target_intervals` must be provided.
- FastQ Screen requires a CSV of reference genomes via `--fastq_screen_references`.

## How to run
The pipeline is executed using Nextflow with the `--input` and `--outdir` parameters. It is recommended to use a specific pipeline version with `-r`.

```bash
nextflow run nf-core/seqinspector \
   -profile docker \
   -r 1.0.0 \
   --input samplesheet.csv \
   --outdir ./results
```

**Common parameters:**
- `--sample_size`: Subsample reads using a fraction (e.g., `0.20`) or absolute integer.
- `--run_picard_collecthsmetrics`: Enable hybrid-selection QC (requires interval files).
- `--skip_tools`: Comma-separated list of tools to skip (e.g., `'fastqscreen,bwamem2_mem'`).
- `-resume`: Use cached results from a previous run.

## Outputs
Results are organized within the directory specified by `--outdir`.

- `multiqc/`: Contains the primary MultiQC HTML report which aggregates all tool outputs and Illumina run statistics.
- `alignment/`: BAM and BAI files if mapping was performed (sorted by default).
- `fastqc/`: Quality control reports for raw reads.
- `fastqscreen/`: Contamination detection reports.
- `seqfu/`: General sequence statistics.

For a complete description of all output files, refer to the official [output documentation](https://nf-co.re/seqinspector/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
