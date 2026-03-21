---
name: nf-core-drop
description: This pipeline detects aberrant expression, aberrant splicing, and mono-allelic expression from RNA-seq BAM files and optional DNA VCFs using a TSV samplesheet and gene annotations. Use when identifying rare transcriptomic outliers in cohort-scale data, ideally with at least 30 to 50 samples to ensure statistical confidence for the underlying OUTRIDER and FRASER algorithms.
homepage: https://github.com/nf-core/drop
---

## Overview
nf-core/drop (Detection of RNA Outliers Pipeline) is an integrative workflow designed to identify rare transcriptomic events that may indicate underlying genetic causes of disease. It provides a standardized framework for detecting expression outliers, splicing defects, and mono-allelic expression (MAE) by comparing individual samples against a cohort.

The pipeline processes aligned RNA-seq data to generate read count matrices and statistical reports. It utilizes OUTRIDER for expression analysis, FRASER for splicing analysis, and GATK ASEReadCounter with DESeq2 for mono-allelic expression detection, culminating in comprehensive QC reports and outlier lists.

## Data preparation
The pipeline requires a TSV samplesheet specified with `--input`. Each row represents an RNA sample and its associated metadata. To detect outliers confidently, the documentation recommends a cohort size of at least 30 samples (50+ preferred for some modules).

**Samplesheet columns:**
- `RNA_ID`: Unique identifier for the RNA sample.
- `RNA_BAM_FILE`: Path to the aligned BAM or CRAM file.
- `RNA_BAI_FILE`: Path to the BAM/CRAM index.
- `DROP_GROUP`: Comma-separated list of analysis groups (e.g., `group1,group2`).
- `STRAND`: Library strandedness (`yes`, `no`, or `reverse`).
- `DNA_ID`, `DNA_VCF_FILE`, `DNA_TBI_FILE`, `GENOME`: Required only for mono-allelic expression (MAE) analysis.

**Minimal samplesheet example:**
```tsv
RNA_ID  RNA_BAM_FILE    RNA_BAI_FILE    DROP_GROUP  STRAND
HG00103 path/to/103.bam path/to/103.bai group1      no
HG00106 path/to/106.bam path/to/106.bai group1      no
```

**Required Reference Files:**
- `--genome`: Assembly version (e.g., `hg19`, `hg38`, `hs37d5`, or `GRCh38`).
- `--gene_annotation`: Path to a YAML or GTF file defining gene annotations.
- `--ucsc_fasta`: Path to the reference FASTA file (required for MAE).

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to use a stable release with `-r` and a container profile like `-profile docker`.

```bash
nextflow run nf-core/drop \
   -profile docker \
   -r 1.0.0 \
   --input samplesheet.tsv \
   --outdir ./results \
   --genome hg38 \
   --gene_annotation gene_annotation.yaml \
   --ucsc_fasta reference.fasta
```

**Key Parameters:**
- `--ae_skip`, `--as_skip`, `--mae_skip`: Booleans to disable specific analysis modules.
- `--ae_implementation`: Method for sample covariation in OUTRIDER (`autoencoder`, `pca`, or `peer`).
- `--as_fraser_version`: Version of FRASER to use (`FRASER` or `FRASER2`).
- `-resume`: Use this Nextflow flag to restart a pipeline from the last cached step.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include:

- **MultiQC Report**: An integrated HTML report summarizing quality control metrics across all samples.
- **Outlier Results**: Tabular files and reports containing significant aberrant expression and splicing events.
- **Count Matrices**: Genomic read counts and split-read counts used for the statistical analyses.
- **MAE Results**: Allelic counts and significant mono-allelically expressed gene lists.

For detailed descriptions of specific folder structures and file formats, refer to the official [output documentation](https://nf-co.re/drop/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
