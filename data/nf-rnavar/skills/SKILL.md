---
name: nf-core-rnavar
description: nf-core/rnavar processes FASTQ, BAM, or CRAM inputs to identify SNPs and indels using STAR alignment and GATK4 best practices, offering optional UMI extraction, HLA typing via Seq2HLA, and variant annotation with VEP or snpEff. Use when performing germline variant calling from RNA-seq data to generate filtered VCFs and comprehensive MultiQC reports.
homepage: https://github.com/nf-core/rnavar
---

## Overview
nf-core/rnavar is a bioinformatics pipeline designed for the identification of genetic variants, specifically SNPs and small indels, directly from RNA sequencing data. It implements the GATK4 "Best Practices" for RNA-seq variant calling, which includes specialized handling for reads spanning splice junctions and base quality score recalibration to ensure high-call accuracy.

The pipeline transforms raw sequencing reads or existing alignments into high-quality, annotated variant sets. It provides integrated quality control at multiple stages and supports advanced features like UMI deduplication and HLA typing to enhance the depth of biological analysis.

## Data preparation
The pipeline requires a samplesheet in CSV, TSV, YAML, or JSON format. Each row represents a sample and its associated data files. The pipeline can start from raw FASTQ files, aligned BAM/CRAM files, or even VCF files for annotation.

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2
CONTROL_REP1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
```

Reference requirements:
- A reference genome is mandatory, specified via `--genome` (for iGenomes) or `--fasta`.
- Gene annotations are required via `--gtf` or `--gff`.
- For GATK4 best practices, providing `--dbsnp` and `--known_indels` is highly recommended for base recalibration.
- If using UMIs, specify `--extract_umi` and the appropriate `--umitools_bc_pattern`.

## How to run
The pipeline is executed using Nextflow. It is recommended to use a container profile (e.g., `docker` or `singularity`) for reproducibility.

```console
nextflow run nf-core/rnavar \
    -r 1.1.0 \
    -profile docker \
    --input samplesheet.csv \
    --genome GRCh38 \
    --outdir ./results
```

Key parameters:
- `-r`: Pin a specific version of the pipeline.
- `-resume`: Restart a run from the last successful step.
- `--tools`: Enable optional analysis modules such as `seq2hla` (HLA typing), `snpeff`, `vep`, or `merge` (both annotation tools).
- `--skip_baserecalibration`: Skip GATK BQSR if known variant sites are unavailable.

## Outputs
Results are organized within the directory specified by `--outdir`.

- `multiqc/`: Contains the MultiQC HTML report, which should be the first file inspected for an overview of read quality, alignment statistics, and variant metrics.
- `gatk4/`: Contains the final filtered VCF files and their indices.
- `annotation/`: Contains annotated VCFs if `snpeff` or `vep` were enabled.
- `star/`: Contains alignment files (BAM) and mapping statistics.
- `seq2hla/`: Contains HLA typing results if enabled.

For a complete description of all output files, refer to the [official output documentation](https://nf-co.re/rnavar/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
