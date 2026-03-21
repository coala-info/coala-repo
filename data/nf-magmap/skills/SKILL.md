---
name: magmap
description: nf-core/magmap maps metagenomic or metatranscriptomic reads to large genome collections using samplesheets and reference metadata to generate gene quantification tables and summary statistics. Use when quantifying features in prokaryotic communities or mapping reads to specific contig sets, particularly for non-model organisms where standard RNA-seq pipelines are not applicable.
homepage: https://github.com/nf-core/magmap
---

## Overview
nf-core/magmap is designed for the analysis of complex microbial communities by mapping reads to extensive collections of genomes. It addresses the need for quantifying gene features in metatranscriptomic and metagenomic datasets where a single reference genome is insufficient.

The pipeline accepts raw FASTQ files and a set of reference genomes, which can be provided locally or fetched from remote sources like NCBI. It produces comprehensive gene count matrices and quality control reports, facilitating downstream differential abundance analysis or community profiling.

## Data preparation
Users must provide a samplesheet in CSV, TSV, YAML, or JSON format. For paired-end data, the CSV should follow this structure:

```csv
sample,fastq_1,fastq_2
CONTROL_REP1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
CONTROL_REP2,AEG588A1_S2_L002_R1_001.fastq.gz,AEG588A1_S2_L002_R2_001.fastq.gz
```

Reference genomes are specified via a genome information file:

```csv
accno,genome_fna,genome_gff
genome1,path/to/fna.gz,path/to/gff.gz
genome2,path/to/fna.gz,path/to/gff.gz
```

Additional metadata can be integrated using `--gtdb_metadata`, `--checkm_metadata`, or `--gtdbtk_metadata`. Remote genomes can be fetched using `--remote_genome_sources` pointing to NCBI assembly summaries.

## How to run
Execute the pipeline using the `nextflow run` command, specifying the input files and a container profile.

```bash
nextflow run nf-core/magmap \
  --input samplesheet.csv \
  --genomeinfo genomeinfo.csv \
  --outdir ./results \
  -profile docker
```

Key parameters include `--bbmap_ambiguous` to handle multi-mapping reads (options: best, all, random, toss) and `--skip_sourmash` to control genome filtering based on k-mer signatures. Use `-resume` to restart a run from the last successful step and `-r` to pin a specific pipeline release.

## Outputs
Results are saved to the directory specified by `--outdir`. The primary outputs include TSV tables containing raw counts per gene (via FeatureCounts) and a summary statistics table. A MultiQC report is generated to provide an overview of read quality and mapping performance. Detailed output descriptions are available at https://nf-co.re/magmap/output.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
