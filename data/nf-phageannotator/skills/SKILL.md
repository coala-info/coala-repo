---
name: phageannotator
description: The pipeline identifies, annotates, and quantifies phage sequences from (meta)-genomic assemblies and FASTQ reads using tools like geNomad, CheckV, and bowtie2 to produce abundance matrices, taxonomic classifications, and host predictions. Use when analyzing viral components within metagenomic datasets or genomic assemblies to characterize phage diversity, lifestyle, and host associations.
homepage: https://github.com/nf-core/phageannotator
---

# phageannotator

## Overview
nf-core/phageannotator addresses the challenge of extracting and characterizing viral signals from complex (meta)-genomic data. It processes assemblies and reads to identify viral contigs, assess their quality, and provide detailed ecological context through host and lifestyle predictions.

In practice, users provide genomic assemblies and the raw reads used to generate them. The pipeline generates a dereplicated viral catalog, abundance tables suitable for downstream differential abundance analysis, and comprehensive annotation reports including taxonomic assignments and protein-coding gene predictions.

## Data preparation
The pipeline requires a comma-separated samplesheet (CSV) containing paths to both assembly files and sequencing reads. All sequence files must be compressed (gzipped).

**Samplesheet columns:**
- `sample`: Unique sample identifier (no spaces).
- `group`: Group ID for the sample (no spaces).
- `fastq_1`: Path to the first FASTQ file (`.fastq.gz` or `.fq.gz`).
- `fastq_2`: Path to the second FASTQ file for paired-end data (optional).
- `fasta`: Path to the (meta)-genomic assembly file (`.fa.gz`, `.fasta.gz`, `.fna.gz`, or `.fas.gz`).

**Example `samplesheet.csv`:**
```csv
sample,group,fastq_1,fastq_2,fasta
SAMPLE1,GROUP_A,reads_1.fastq.gz,reads_2.fastq.gz,assembly.fasta.gz
SAMPLE2,GROUP_B,single_end.fastq.gz,,assembly_2.fasta.gz
```

**Reference Databases:**
The pipeline requires several databases for full functionality, including geNomad, CheckV, iPHoP, and pharokka. These can be specified via parameters like `--genomad_db`, `--checkv_db`, and `--iphop_db`.

## How to run
The pipeline is executed using Nextflow with the `--input` and `--outdir` parameters. It is recommended to use a specific pipeline version with `-r` and a container profile for reproducibility.

```bash
nextflow run nf-core/phageannotator \
  -profile docker \
  --input samplesheet.csv \
  --outdir ./results \
  -r 1.0.0
```

**Common parameters:**
- `-profile`: Choose a configuration profile (e.g., `docker`, `singularity`, `conda`).
- `--assembly_min_length`: Minimum length for input assembly contigs (default: 1000).
- `--run_iphop`: Enable host prediction using iPHoP.
- `--run_bacphlip`: Enable lifestyle prediction.
- `-resume`: Restart a pipeline from the last successful step if it was interrupted.

## Outputs
Results are saved in the directory specified by the `--outdir` parameter.

- `multiqc/`: Combined quality control reports from FastQC and other tools.
- `genomad/`: Viral identification and taxonomic classification results.
- `checkv/`: Quality assessment and filtering of viral sequences.
- `abundance/`: Abundance estimation matrices from CoverM, suitable for input into `nf-core/differentialabundance`.
- `annotation/`: Functional annotations, host predictions (iPHoP), and lifestyle predictions (BACPHLIP).

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/phageannotator/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)