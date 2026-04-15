---
name: bacass
description: This pipeline performs bacterial assembly and annotation using short reads, long reads, or hybrid datasets with integrated quality trimming, contamination screening via Kraken2 or Kmerfinder, and multiple assembly and polishing options. Use when you need a best-practice workflow to generate annotated bacterial genomes and comprehensive QC reports from Illumina, Oxford Nanopore, or PacBio sequencing data.
homepage: https://github.com/nf-core/bacass
---

# bacass

## Overview
nf-core/bacass is designed for the de novo assembly and functional annotation of bacterial genomes. It streamlines the transition from raw sequencing reads to polished, annotated contigs by providing specialized routes for different data modalities, including short-read only, long-read only, and hybrid approaches.

The pipeline handles the complexity of choosing between various assemblers like Unicycler or Dragonflye and provides automated quality control at every stage. Users receive a complete analysis package including assembly statistics, contamination checks, and standardized annotation files suitable for downstream comparative genomics.

## Data preparation
The pipeline requires a samplesheet in TSV, CSV, or YAML format. This file defines the relationship between sample identifiers, read files, and optional metadata like expected genome size.

The samplesheet must contain the following columns:
- `ID`: Unique sample identifier (must start with a letter, no spaces).
- `R1`: Path to forward short-read FastQ file (zipped).
- `R2`: Path to reverse short-read FastQ file (required for paired-end).
- `LongFastQ`: Path to long-read FastQ file (zipped).
- `Fast5`: Path to the directory containing FAST5 files (optional, for polishing).
- `GenomeSize`: Estimated size (e.g., `2.8m`) required for certain assemblers.

Example `samplesheet.tsv`:
```tsv
ID	R1	R2	LongFastQ	Fast5	GenomeSize
sample_short	./data/S1_R1.fastq.gz	./data/S1_R2.fastq.gz	NA	NA	NA
sample_long	NA	NA	./data/S1_long.fastq.gz	./data/FAST5	2.8m
sample_hybrid	./data/S1_R1.fastq.gz	./data/S1_R2.fastq.gz	./data/S1_long.fastq.gz	NA	2.8m
```

## How to run
The pipeline is executed using `nextflow run`. You must specify the assembly type and provide a path to a Kraken2 database if contamination screening is desired.

```bash
# Basic run with short reads
nextflow run nf-core/bacass \
  -profile docker \
  --input samplesheet.tsv \
  --assembly_type 'short' \
  --outdir ./results

# Long read assembly with a specific assembler and Kraken2 DB
nextflow run nf-core/bacass \
  -profile singularity \
  --input samplesheet.tsv \
  --assembly_type 'long' \
  --assembler 'miniasm' \
  --kraken2db "https://genome-idx.s3.amazonaws.com/kraken/k2_standard_8gb_20210517.tar.gz" \
  --outdir ./results
```

Key parameters include `-profile` (e.g., `docker`, `conda`), `--assembly_type` (`short`, `long`, or `hybrid`), and `--assembler` (`unicycler`, `canu`, `miniasm`, or `dragonflye`). Use `-resume` to restart a run from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir`. Primary deliverables include:
- `multiqc/`: Combined quality control reports from FastQC, FastP, NanoPlot, and other tools.
- `unicycler/` or `dragonflye/`: Assembled genome contigs in FASTA format.
- `prokka/`, `bakta/`, or `dfast/`: Genome annotations including GFF, GenBank, and protein sequences.
- `quast/` and `busco/`: Assembly quality and completeness metrics.
- `kraken2/` and `kmerfinder/`: Taxonomy and contamination reports.

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/bacass/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)