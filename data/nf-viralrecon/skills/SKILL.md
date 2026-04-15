---
name: viralrecon
description: This pipeline performs assembly and intra-host variant calling for viral samples using Illumina or Nanopore FASTQ data, requiring a reference genome and optional primer sets for amplicon-based protocols. Use when identifying low-frequency variants, generating consensus sequences, or assigning lineages for viruses like SARS-CoV-2 from metagenomic or enrichment-based sequencing libraries.
homepage: https://github.com/nf-core/viralrecon
---

# viralrecon

## Overview
nf-core/viralrecon is designed for the analysis of viral sequencing data, supporting both Illumina short-read and Nanopore long-read platforms. It addresses the need for high-throughput identification of intra-host variants, *de novo* assembly of viral genomes, and automated lineage assignment for pathogens such as SARS-CoV-2.

The pipeline processes raw FASTQ files to produce consensus sequences, annotated variant calls (VCF), and comprehensive quality control reports. It handles various library preparation methods, including shotgun metagenomics, amplicon-based enrichment (e.g., ARTIC), and probe-capture protocols.

## Data preparation
Users must provide a CSV samplesheet containing sample identifiers and paths to FASTQ files. For Illumina data, technical replicates with the same sample ID are automatically merged.

`samplesheet.csv` example:
```csv
sample,fastq_1,fastq_2
SAMPLE_1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
```

Required reference files and constraints include:
- **Reference Genome:** A viral reference genome in FASTA format (`--fasta`) and optional annotation in GFF format (`--gff`).
- **Amplicon Data:** Primer positions in BED format (`--primer_bed`) for variant calling and primer sequences in FASTA format (`--primer_fasta`) for assembly.
- **Nanopore Data:** Requires a directory of FASTQ files (`--fastq_dir`) and a sequencing summary file (`--sequencing_summary`).
- **Host Filtering:** An optional Kraken 2 database (`--kraken2_db`) can be provided to remove host-derived reads.

## How to run
Run the pipeline using `nextflow run` with the appropriate `--platform` and `--protocol` flags. Use `-profile` to specify the execution environment (e.g., `docker`, `singularity`) and `-r` to pin a specific version.

**Illumina Shotgun Analysis:**
```bash
nextflow run nf-core/viralrecon \
   --input samplesheet.csv \
   --outdir ./results \
   --platform illumina \
   --protocol metagenomic \
   --genome 'MN908947.3' \
   -profile docker
```

**Illumina Amplicon Analysis:**
```bash
nextflow run nf-core/viralrecon \
   --input samplesheet.csv \
   --outdir ./results \
   --platform illumina \
   --protocol amplicon \
   --primer_set artic \
   --primer_set_version 3 \
   -profile docker
```

**Nanopore Amplicon Analysis:**
```bash
nextflow run nf-core/viralrecon \
   --input samplesheet.csv \
   --outdir ./results \
   --platform nanopore \
   --genome 'MN908947.3' \
   --fastq_dir fastq_pass/ \
   --sequencing_summary sequencing_summary.txt \
   -profile docker
```

## Outputs
Results are saved to the directory specified by `--outdir`. The primary deliverables include:
- `multiqc/`: Integrated quality control report; open `multiqc_report.html` for a summary of all samples.
- `variants/`: VCF files containing identified intra-host and low-frequency variants, along with SnpEff annotations.
- `consensus/`: FASTA files of the generated consensus sequences and QUAST assessment reports.
- `lineage/`: Lineage assignments from Pangolin and clade/mutation calling from Nextclade.
- `assembly/`: *De novo* assembly contigs and assessment reports if assembly was not skipped.

For a detailed description of all output files, refer to the official [output documentation](https://nf-co.re/viralrecon/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)