---
name: nf-core-circrna
description: This pipeline analyzes total RNA sequencing data to perform back-splice junction detection, annotation, and quantification of circular RNAs using a samplesheet and reference genome files. Use when investigating circRNA expression profiles or circRNA-miRNA interactions in organisms with established genomic annotations.
homepage: https://github.com/nf-core/circrna
---

# nf-core-circrna

## Overview
nf-core/circrna is designed for the comprehensive analysis of circular RNAs (circRNAs) from total RNA sequencing data. It addresses the challenge of identifying and quantifying non-linear splicing events by detecting back-splice junctions (BSJ) across multiple specialized algorithms.

The pipeline processes raw FASTQ files to produce annotated circRNA candidates, expression matrices, and optional miRNA target predictions. Users receive a consolidated MultiQC report and structured data folders containing results from various detection and quantification tools.

## Data preparation
The primary input is a CSV samplesheet specifying sample names and paths to FASTQ files. Strandedness can be specified as `unstranded`, `forward`, `reverse`, or `auto`.

```csv
sample,fastq_1,fastq_2,strandedness
CONTROL,CONTROL_R1.fastq.gz,CONTROL_R2.fastq.gz,auto
TREATMENT,TREATMENT_R1.fastq.gz,TREATMENT_R2.fastq.gz,auto
```

Additional required or optional files include:
*   **Reference Genome:** A FASTA file (`--fasta`) and a GTF annotation (`--gtf`) are mandatory if not using the `--genome` iGenomes shortcut.
*   **Phenotype Sheet:** A CSV (`--phenotype`) with `sample` and `condition` columns is required for statistical testing via CircTest.
*   **miRNA Data:** To perform miRNA target prediction, provide a FASTA of mature miRNAs (`--mature`) and optionally a TSV of miRNA expression counts (`--mirna_expression`).
*   **Custom Annotations:** A CSV (`--annotation`) containing paths to BED files can be used for specific genomic feature overlaps.

## How to run
Execute the pipeline using the Nextflow CLI. It is recommended to use `-profile` for software management (e.g., docker or singularity) and `-r` to pin a specific version.

```bash
nextflow run nf-core/circrna \
  -profile docker \
  --input samplesheet.csv \
  --outdir ./results \
  --genome GRCh38
```

To enable specific features like miRNA analysis or statistical testing, include the relevant parameters:

```bash
nextflow run nf-core/circrna \
  -profile singularity \
  --input samplesheet.csv \
  --outdir ./results \
  --mature mature.fa \
  --phenotype phenotype.csv \
  -resume
```

## Outputs
Results are organized within the directory specified by `--outdir`.

*   **MultiQC:** A summary report (`multiqc/multiqc_report.html`) containing QC metrics and pipeline statistics.
*   **BSJ Detection:** Tool-specific folders (e.g., `ciri`, `circexplorer2`) containing identified back-splice junctions.
*   **Quantification:** Expression matrices for circular and linear transcriptomes, including results from `psirc-quant` or `CIRIquant`.
*   **miRNA Analysis:** Predicted binding sites and correlation results if miRNA parameters were provided.

For detailed file descriptions and interpretation, refer to the [official output documentation](https://nf-co.re/circrna/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)