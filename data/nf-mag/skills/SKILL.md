---
name: mag
description: This pipeline performs metagenome assembly, binning, and annotation using short or long reads to generate high-quality Metagenome-Assembled Genomes (MAGs) with integrated taxonomic classification and quality control. Use when processing environmental or clinical shotgun sequencing data to recover individual genomes, including support for hybrid assembly, co-assembly groups, and ancient DNA damage validation.
homepage: https://github.com/nf-core/mag
---

## Overview
nf-core/mag is a bioinformatics best-practice analysis pipeline designed for the assembly, binning, and annotation of metagenomes. It handles the complexity of metagenomic data by providing a streamlined workflow that transitions from raw sequencing reads to refined, taxonomically annotated genome bins.

The pipeline supports both short-read (e.g., Illumina) and long-read (e.g., Oxford Nanopore, PacBio) data, allowing for hybrid assembly approaches. It produces comprehensive outputs including assembled contigs, binned genomes, functional annotations, and detailed quality control reports for both the reads and the resulting MAGs.

## Data preparation
The pipeline requires a CSV samplesheet specified with the `--input` parameter. This file defines the relationship between samples, sequencing runs, and experimental groups.

**Samplesheet Columns:**
- `sample`: Unique sample identifier (no spaces).
- `group`: Group identifier used for co-assembly or co-abundance computation.
- `short_reads_1`: Path to the first FASTQ file for short reads.
- `short_reads_2`: Path to the second FASTQ file (optional for paired-end).
- `short_reads_platform`: Sequencing platform (e.g., `ILLUMINA`, `BGISEQ`).
- `long_reads`: Path to long-read FASTQ file (optional).
- `long_reads_platform`: Long-read platform (e.g., `OXFORD_NANOPORE`, `PACBIO_HIFI`).

**Example samplesheet.csv:**
```csv
sample,group,short_reads_1,short_reads_2,short_reads_platform,long_reads,long_reads_platform
sample1,1,s1_R1.fq.gz,s1_R2.fq.gz,ILLUMINA,,
sample2,1,s2_R1.fq.gz,s2_R2.fq.gz,ILLUMINA,s2_long.fq.gz,OXFORD_NANOPORE
```

If you have pre-computed assemblies, you can skip the assembly stage by providing an additional CSV via `--assembly_input` containing `id,group,assembler,fasta`.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to use a specific release version with `-r` and a container profile for reproducibility.

```bash
# Basic run with Docker
nextflow run nf-core/mag \
    -profile docker \
    --input samplesheet.csv \
    --outdir ./results

# Run with co-assembly enabled and specific binning options
nextflow run nf-core/mag \
    -profile singularity \
    --input samplesheet.csv \
    --outdir ./results \
    --coassemble_group \
    --binning_map_mode group \
    -resume
```

Key parameters include `--coassemble_group` to pool samples within a group for assembly and `--binning_map_mode` to define how reads are mapped back to contigs for abundance estimation.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include:

- `MultiQC/`: A summary report containing quality control metrics from FastQC, fastp, Quast, and software versions.
- `Assembly/`: Assembled contigs and scaffolds from MEGAHIT, SPAdes, or Flye.
- `GenomeBinning/`: Binned genomes from tools like MetaBAT2, MaxBin2, or CONCOCT, including refined bins if DAS Tool was used.
- `QC/`: Quality assessments of bins from BUSCO, CheckM, or CheckM2.
- `Taxonomy/`: Taxonomic assignments for bins from GTDB-Tk or CAT.
- `Annotation/`: Predicted genes and functional annotations from Prokka or Prodigal.

For a detailed description of all output files, refer to the official [output documentation](https://nf-co.re/mag/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
