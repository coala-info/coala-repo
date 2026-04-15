---
name: alleleexpression
description: This pipeline performs allele-specific expression analysis using RNA-seq FASTQ files and sample-specific VCFs alongside reference genomes, GTF annotations, and Beagle phasing panels. Use when you need to quantify haplotype-level expression using STAR-WASP alignment, UMI deduplication, and phaser-based detection of allelic imbalance.
homepage: https://github.com/nf-core/alleleexpression
---

# alleleexpression

## Overview
The nf-core/alleleexpression pipeline addresses the challenge of identifying allele-specific expression (ASE) by integrating transcriptomic data with genomic variants. It processes raw sequencing reads and known variants to distinguish between maternal and paternal expression levels, accounting for mapping biases and duplicate reads.

In practice, users provide paired-end FASTQ files and a VCF of known variants for each sample. The pipeline generates phased genomic data and quantitative ASE metrics at both the haplotype and gene levels, summarized in a comprehensive quality control report.

## Data preparation
The pipeline requires a comma-separated samplesheet provided via the `--input` parameter. This file must contain a header row and four mandatory columns for every sample.

- `sample`: Unique sample identifier without spaces.
- `fastq_1`: Path to the first-read FASTQ file (.fastq.gz or .fq.gz).
- `fastq_2`: Path to the second-read FASTQ file (.fastq.gz or .fq.gz).
- `vcf`: Path to the sample-specific VCF file (.vcf or .vcf.gz) containing known variants.

Required reference files include a genome FASTA (`--fasta`), a GTF annotation (`--gtf`), and a BED file defining gene features (`--gene_features`). For haplotype phasing, the pipeline requires a Beagle reference panel VCF (`--beagle_ref`) and a genetic map (`--beagle_map`). You may optionally restrict analysis to a specific chromosome using the `--chromosome` parameter.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to specify a pipeline release with `-r` and use a container profile such as `-profile docker` or `-profile singularity` for reproducibility.

```bash
nextflow run nf-core/alleleexpression \
    -r 1.0.0 \
    -profile docker \
    --input samplesheet.csv \
    --outdir ./results \
    --fasta genome.fasta \
    --gtf genes.gtf \
    --gene_features features.bed \
    --beagle_ref panel.vcf.gz \
    --beagle_map map.txt
```

Common Nextflow flags include `-resume` to continue a previous run from the last successful process and `--outdir` to define the results location.

## Outputs
Results are organized by sample name within the directory specified by `--outdir`. The primary results are found in the following subdirectories:

- `ase/`: Final allele-specific expression results and gene-level ASE counts.
- `phaser/`: Haplotype-level expression results.
- `beagle/`: Phased VCF files.
- `multiqc/`: A consolidated MultiQC report summarizing quality control metrics from FastQC, STAR, and UMI-tools.
- `star/`, `wasp/`, and `umi/`: Alignment files, WASP-filtered BAMs, and UMI-deduplicated BAMs.

The MultiQC report is the recommended starting point for evaluating the success and quality of the analysis run.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)