---
name: scrnaseq
description: This pipeline processes 10x Genomics single-cell RNA-seq data using a samplesheet of FASTQ files and reference FASTA/GTF files to produce count matrices and quality reports. Use when analyzing single-cell transcriptomics data to generate h5ad, Seurat, or MTX matrices via aligners like SimpleAF, STARSolo, Kallisto, or Cellranger.
homepage: https://github.com/nf-core/scrnaseq
---

# scrnaseq

## Overview
nf-core/scrnaseq is a bioinformatics pipeline designed for the analysis of single-cell RNA-seq data, specifically optimized for 10x Genomics platforms. It handles the transition from raw sequencing reads to processed count matrices, enabling researchers to perform downstream clustering and differential expression analysis.

The pipeline accepts raw FASTQ files and reference genome annotations to perform read alignment, barcode processing, and UMI quantification. It provides a flexible framework where users can choose between several established quantification methods, such as STARSolo or Alevin-Fry, to produce standardized output formats.

## Data preparation
Users must provide a CSV samplesheet containing paths to FASTQ files and experimental metadata. The file requires a header and specific columns for sample identification, read pairs, and the number of expected cells.

`samplesheet.csv` example:
```csv
sample,fastq_1,fastq_2,expected_cells
pbmc8k,pbmc8k_S1_L007_R1_001.fastq.gz,pbmc8k_S1_L007_R2_001.fastq.gz,10000
pbmc8k,pbmc8k_S1_L008_R1_001.fastq.gz,pbmc8k_S1_L008_R2_001.fastq.gz,10000
```

Mandatory reference files include a genome FASTA (`--fasta`) and a GTF annotation file (`--gtf`). If using the `simpleaf` aligner, a transcript FASTA (`--transcript_fasta`) and a transcript-to-gene mapping file (`--txp2gene`) are required. For non-10x Genomics platforms, a custom barcode list can be provided via the `--barcode_whitelist` parameter.

## How to run
Execute the pipeline using the `nextflow run` command. It is recommended to specify a pipeline version with `-r` and use `-resume` for incremental updates.

```bash
nextflow run nf-core/scrnaseq \
   -r 2.7.2 \
   -profile docker \
   --input samplesheet.csv \
   --fasta genome.fasta \
   --gtf genes.gtf \
   --protocol 10XV3 \
   --aligner simpleaf \
   --outdir ./results
```

Key parameters include `--protocol` (e.g., `10XV2`, `10XV3`, or `auto` for Cellranger) and `--aligner` (options: `simpleaf`, `star`, `kallisto`, `cellranger`). Use `-profile test` to verify the installation with a minimal dataset.

## Outputs
Results are saved to the directory specified by `--outdir`. The primary deliverables are the quantification matrices in `h5ad`, `Seurat`, or `mtx` formats, which are ready for downstream analysis.

Quality control summaries are aggregated into a MultiQC report, which provides an overview of alignment statistics and library quality. Detailed documentation on specific output files and folder structures is available at `https://nf-co.re/scrnaseq/output`.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)