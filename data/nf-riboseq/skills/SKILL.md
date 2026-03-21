---
name: nf-core-riboseq
description: This pipeline processes Ribo-seq or TI-seq data from FASTQ files using a samplesheet to perform UMI extraction, adapter trimming, rRNA removal, and STAR alignment to genome and transcriptome references. Use when analyzing ribosome footprinting experiments to identify translated open reading frames, estimate P-site offsets, or perform translational efficiency analysis with matched RNA-seq data.
homepage: https://github.com/nf-core/riboseq
---

## Overview
nf-core/riboseq is a bioinformatics pipeline designed for the specialized analysis of ribosome profiling (Ribo-seq) and translation initiation site profiling (TI-seq) data. It handles the intensive preprocessing required for these libraries—including UMI deduplication and ribosomal RNA depletion—before performing genomic alignment and downstream translation-specific quantification.

The pipeline produces standard alignment files (BAM) alongside specialized outputs such as P-site offset estimates, de novo predicted open reading frames (ORFs), and frame bias reports. When matched RNA-seq data is provided, it can also perform translational efficiency analysis to study the relationship between transcription and translation across different experimental conditions.

## Data preparation
The primary input is a comma-separated samplesheet specified with `--input`. This file defines the raw data and metadata for each library.

**Samplesheet columns:**
- `sample`: Unique sample identifier.
- `fastq_1`: Path to the first FASTQ file (compressed).
- `fastq_2`: Path to the second FASTQ file for paired-end data (optional).
- `strandedness`: Library strand orientation (`forward`, `reverse`, `unstranded`, or `auto`).
- `type`: The data modality, which must be `riboseq`, `tiseq`, or `rnaseq`.

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2,strandedness,type
CONTROL_REP1,AEG588A1_S1_L002_R1_001.fastq.gz,,forward,riboseq
```

**Reference files:**
- `--fasta`: Path to the genome FASTA file.
- `--gtf` or `--gff`: Path to the gene annotation file.
- `--transcript_fasta`: Optional path to a transcriptome FASTA file.
- `--ribo_database_manifest`: A text file containing paths to fasta files for SortMeRNA to use for rRNA depletion.

**Contrasts file:**
If performing translational efficiency analysis with `anota2seq`, a CSV file must be provided via `--contrasts` containing columns for `id`, `variable`, `reference`, `target`, and optionally `batch` and `pair`.

## How to run
The pipeline requires Nextflow and a container engine (Docker, Singularity, or Conda). Use the `-profile` flag to specify the execution environment and `-r` to pin a specific version.

```bash
nextflow run nf-core/riboseq \
   -profile docker \
   -r 1.0.0 \
   --input samplesheet.csv \
   --outdir ./results \
   --fasta genome.fasta \
   --gtf genes.gtf
```

Key parameters:
- `--with_umi`: Enable UMI-based read deduplication (requires `--umitools_bc_pattern`).
- `--remove_ribo_rna`: Enable rRNA removal using SortMeRNA (default: true).
- `--skip_ribotish`, `--skip_ribotricer`, `--skip_ribowaltz`: Skip specific downstream analysis modules.
- `-resume`: Restart a previous run from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir`.

- **MultiQC**: A summary report in `multiqc/` aggregating quality control metrics from FastQC, STAR, and other tools.
- **Alignments**: Sorted and indexed BAM files in `star/` for both genome and transcriptome coordinates.
- **Ribo-seq Metrics**: P-site offsets and frame distribution plots from `riboWaltz` and `Ribo-TISH`.
- **ORF Predictions**: Predicted translated regions from `Ribo-TISH` and `Ribotricer`.
- **Translational Efficiency**: Differential translation results from `anota2seq` if matched RNA-seq and contrasts were provided.

For a comprehensive list of output files, refer to the [official output documentation](https://nf-co.re/riboseq/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
