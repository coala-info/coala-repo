---
name: bactmap
description: This pipeline maps Illumina short reads or Oxford Nanopore long reads to a bacterial reference genome to generate filtered VCF files, consensus pseudogenomes, and a multi-sample alignment of variant sites. Use when performing bacterial comparative genomics or phylogenetics requiring high-quality variant calls and pseudogenome generation from diverse sequencing platforms.
homepage: https://github.com/nf-core/bactmap
---

# bactmap

## Overview
nf-core/bactmap is a bioinformatics analysis pipeline designed for mapping bacterial whole genome sequencing (WGS) data to a reference sequence. It supports both short-read (Illumina) and long-read (Oxford Nanopore) data, facilitating the creation of filtered variant calls and the generation of high-quality pseudogenomes.

The pipeline produces standardized outputs including VCF files, consensus FASTA sequences, and concatenated alignments of variant sites. These results are suitable for downstream applications such as phylogenetic tree construction and comparative genomic analysis, supported by comprehensive quality control reports.

## Data preparation
The pipeline requires a comma-separated samplesheet (CSV) and a reference genome in FASTA format. If using Oxford Nanopore data, a specific Clair3 model path must also be provided.

**Samplesheet requirements:**
The CSV must contain the following columns:
- `sample`: Unique sample identifier (no spaces).
- `run_accession`: Run or library identifier.
- `instrument_platform`: Either `ILLUMINA` or `OXFORD_NANOPORE`.
- `fastq_1`: Path to the first FASTQ file (must be `.fq.gz` or `.fastq.gz`).
- `fastq_2`: Path to the second FASTQ file for paired-end Illumina data (leave empty for single-end or ONT).

Example `samplesheet.csv`:
```csv
sample,run_accession,instrument_platform,fastq_1,fastq_2
sample1,run1,ILLUMINA,sample1_R1.fq.gz,sample1_R2.fq.gz
sample2,run1,OXFORD_NANOPORE,sample2.fastq.gz,
```

**Reference files:**
- `--fasta`: Path to the bacterial reference genome FASTA file.
- `--clair3_model`: (Required for ONT) Path to the directory containing the Clair3 model.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to use `-profile` for environment management (e.g., docker, singularity) and `-r` to pin a specific version.

```bash
nextflow run nf-core/bactmap \
   -profile <docker/singularity/conda> \
   --input samplesheet.csv \
   --fasta reference.fasta \
   --outdir ./results
```

For Oxford Nanopore data, include the model path:
```bash
nextflow run nf-core/bactmap \
   -profile docker \
   --input samplesheet.csv \
   --fasta reference.fasta \
   --clair3_model ./models/ont_model \
   --outdir ./results
```

Common parameters include `--shortread_mapping_tool` (bowtie2 or bwa), `--subsampling_depth_cutoff` (default 100), and `-resume` to restart a run from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir`. Key outputs include:

- `multiqc/`: Combined quality control reports for raw reads, alignments, and variant statistics. Open `multiqc_report.html` first to assess run quality.
- `variants/`: Filtered VCF and BCF files containing identified variants.
- `pseudogenomes/`: FASTA files representing the consensus sequence for each sample, with low-coverage regions masked.
- `alignment/`: Concatenated alignment of pseudogenomes and variant-only sites (SNP-sites) for phylogenetic analysis.
- `analysis_ready_reads/`: (Optional) Cleaned and preprocessed FASTQ files if `--save_analysis_ready_fastqs` is used.

Detailed descriptions of all output files are available in the official [output documentation](https://nf-co.re/bactmap/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
- [`references/docs/usage/faq-troubleshooting.md`](references/docs/usage/faq-troubleshooting.md)
- [`references/docs/usage/tutorials.md`](references/docs/usage/tutorials.md)