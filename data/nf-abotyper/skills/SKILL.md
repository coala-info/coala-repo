---
name: abotyper
description: This pipeline processes Oxford Nanopore FASTQ files and a samplesheet to perform quality control, mapping to ABO exon 6 and 7 reference sequences, and variant characterization for blood group deduction. Use when analyzing third-generation amplicon sequencing data of the human ABO gene to identify clinically relevant single nucleotide variants and determine blood group statistics.
homepage: https://github.com/nf-core/abotyper
---

## Overview
nf-core/abotyper is a bioinformatics pipeline designed for the analysis of Third Generation Sequencing data, specifically targeting the human ABO gene. It automates the process of deducing ABO blood types by analyzing sequences from exons 6 and 7, which contain the primary polymorphisms required for accurate genotyping.

The pipeline accepts FASTQ files and a samplesheet, performing read alignment to specific exon references, variant calling at polymorphic positions, and phenotype prediction. It produces comprehensive reports including alignment statistics, SNP frequency data, and final blood group determinations in both tabular and spreadsheet formats.

## Data preparation
The pipeline requires a CSV samplesheet and FASTQ files. Input FASTQ filenames should ideally follow a specific naming convention for optimal barcode and sample name extraction: `^(IMM|INGS|NGS|[A-Z0-9]+)(-[0-9]+-[0-9]+)?_barcode\d+$`.

The samplesheet must contain the following columns:
- `sample`: Unique sample identifier (no spaces).
- `fastq_1`: Path to the first FASTQ file (required).
- `fastq_2`: Path to the second FASTQ file (optional).

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2
SAMPLE1_barcode01,data/SAMPLE1_barcode01.fastq.gz,
SAMPLE2_barcode02,data/SAMPLE2_barcode02.fastq.gz,
```

Users can optionally provide a tab-delimited renaming file via `--renaming_file` containing `sequencingID` and `sampleName` columns to map internal IDs to clinical names. Reference files for ABO exons 6 and 7 (FASTA and FAI) can be provided via parameters like `--exon6fasta` and `--exon7fasta` if the defaults are not used.

## How to run
Run the pipeline using the standard Nextflow command. It is recommended to use a container profile (docker or singularity) and specify an output directory.

```bash
nextflow run nf-core/abotyper \
  -r 1.0.0 \
  -profile docker \
  --input samplesheet.csv \
  --outdir ./results \
  -resume
```

To skip the sample renaming process if a renaming file is not provided, use:
```bash
nextflow run nf-core/abotyper \
  -profile singularity \
  --input samplesheet.csv \
  --outdir ./results \
  --skip_renaming true
```

## Outputs
Results are organized within the directory specified by `--outdir`. The primary deliverables for interpreting results are:

- `ABO_result.xlsx`: An Excel workbook containing detailed SNVs and metrics used for phenotype deduction.
- `final_export.csv`: A summary table of the final ABO typing results for all samples.
- `qc-reports/multiqc/multiqc_report.html`: A compiled quality control report including FastQC and alignment metrics.
- `per_sample_processing/`: Individual folders for each sample containing BAM files, coverage statistics, and pileup results for exons 6 and 7.

Detailed documentation on output interpretation is available in the official pipeline documentation.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
