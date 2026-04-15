---
name: viralmetagenome
description: Reconstructs consensus genomes and identifies intra-host variants from metagenomic FASTQ samplesheets using de novo assembly, taxonomic classification, and iterative mapping-based refinement to produce consensus FASTA and VCF files. Use when performing untargeted viral genome reconstruction from complex samples or hybrid capture data, particularly when the target reference is unknown or multiple viral species are expected.
homepage: https://github.com/nf-core/viralmetagenome
---

# viralmetagenome

## Overview
The nf-core/viralmetagenome pipeline is designed for the reconstruction of viral consensus genomes and the identification of intra-host variants from metagenomic sequencing data. It supports both untargeted metagenomics and enriched sequencing methods like hybrid capture, providing a robust framework for discovering and characterizing viral sequences in complex biological samples.

The pipeline transforms raw FASTQ reads into high-quality consensus sequences and annotated variant calls. It integrates de novo assembly with taxonomic classification and iterative refinement to handle samples where the viral content is unknown or highly diverse.

## Data preparation
Users must provide a CSV samplesheet via the `--input` parameter. The file requires a header and three columns: `sample`, `fastq_1`, and `fastq_2` (optional for single-end data). Sample names must not contain spaces, and FASTQ files must have the extension `.fastq.gz` or `.fq.gz`.

Example `samplesheet.csv`:
```csv
sample,fastq_1,fastq_2
sample1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
sample2,AEG588A5_S5_L003_R1_001.fastq.gz,
```

Optional inputs include:
* `--reference_pool`: A FASTA file of potential reference sequences used for scaffolding.
* `--host_k2_db`: A Kraken2 database used to remove host and contaminant reads.
* `--metadata`: A CSV/TSV file with extra per-sample annotations (e.g., collection date, location) for MultiQC.
* `--mapping_constraints`: Specific sequences to use as a reference instead of de novo contigs.

## How to run
Execute the pipeline using the `nextflow run` command. It is recommended to use `-profile` for software management (e.g., docker, singularity) and `-r` to pin a specific release version.

```bash
nextflow run nf-core/viralmetagenome \
  -profile <docker/singularity/conda> \
  --input samplesheet.csv \
  --outdir ./results \
  -r 1.0.0 \
  -resume
```

Key parameters include `--assemblers` (e.g., `spades,megahit`), `--read_classifiers` (e.g., `kraken2,kaiju`), and `--variant_caller` (e.g., `ivar,bcftools`). Use `--skip_preprocessing` if reads are already cleaned or `--skip_assembly` to perform only reference-based mapping.

## Outputs
Results are saved to the directory specified by `--outdir`. The primary deliverables include:
* `multiqc_report.html`: A comprehensive summary of quality control, assembly statistics, and mapping metrics.
* **Consensus genomes**: FASTA files generated from de novo assembly or reference-based scaffolding.
* **Variant calls**: VCF files containing identified intra-host variants and optional functional annotations.
* **Taxonomic reports**: Classification summaries and diversity estimates from Kraken2, Kaiju, or Bracken.

Detailed documentation on output structure and file interpretation is available at https://nf-co.re/viralmetagenome/output.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
- [`references/docs/usage/databases.md`](references/docs/usage/databases.md)
- [`references/docs/usage/workflow/1_overview.md`](references/docs/usage/workflow/1_overview.md)
- [`references/docs/usage/workflow/2_preprocessing.md`](references/docs/usage/workflow/2_preprocessing.md)
- [`references/docs/usage/workflow/3_metagenomic_diversity.md`](references/docs/usage/workflow/3_metagenomic_diversity.md)
- [`references/docs/usage/workflow/4_assembly_polishing.md`](references/docs/usage/workflow/4_assembly_polishing.md)
- [`references/docs/usage/workflow/5_variant_and_refinement.md`](references/docs/usage/workflow/5_variant_and_refinement.md)
- [`references/docs/usage/workflow/6_consensus_qc.md`](references/docs/usage/workflow/6_consensus_qc.md)