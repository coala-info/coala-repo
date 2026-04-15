---
name: isoseq
description: This pipeline performs gene and isoform annotation from PacBio Iso-Seq long-reads by processing raw subreads or mapped reads using tools like uLTRA and TAMA to generate polished gene models and merged annotations. Use when analyzing long-read transcriptomic data to define and clean gene models, specifically supporting both raw subread inputs with associated index files or direct mapping of existing fasta sequences.
homepage: https://github.com/nf-core/isoseq
---

# isoseq

## Overview
The pipeline provides a best-practice analysis for gene and transcript annotation using PacBio Iso-Seq long-read sequencing data. It addresses the complexity of long-read processing by handling the transition from raw subreads to high-quality, non-chimeric circular consensus sequences (CCS) and subsequent mapping to a reference genome.

Users can choose between two primary entry points: starting from raw subreads to perform the full processing suite or starting from the mapping step if pre-processed reads are already available. The final deliverables include refined gene models that have been cleaned, collapsed, and merged across samples to provide a comprehensive transcriptomic annotation.

## Data preparation
The pipeline requires a samplesheet, a reference genome, and a primer sequences file. The samplesheet is a CSV file with four columns: `sample`, `bam`, `pbi`, and `reads`.

- **sample**: Unique sample identifier (no spaces).
- **bam**: Path to the subreads BAM file (use `None` if starting from the mapping entrypoint).
- **pbi**: Path to the PacBio index file (use `None` if starting from the mapping entrypoint).
- **reads**: Path to long-read FASTA files (use `None` if starting from the subreads entrypoint).

Example `samplesheet.csv`:
```csv
sample,bam,pbi,reads
sample1,sample1.subreads.bam,sample1.subreads.bam.pbi,None
```

Mandatory reference files include a genome FASTA (via `--fasta` or an iGenomes ID via `--genome`) and a FASTA file containing primer sequences (`--primers`). If using the `uLTRA` aligner, a GTF annotation file is also required.

## How to run
The pipeline is executed using `nextflow run`. It is recommended to use `-profile` for software management (e.g., docker or singularity) and `-r` to pin a specific version.

```bash
nextflow run nf-core/isoseq \
   -profile <docker/singularity/conda> \
   --input samplesheet.csv \
   --outdir <OUTDIR> \
   --genome GRCh38 \
   --primers primers.fasta
```

Key parameters include:
- `--entrypoint`: Set to `isoseq` (default) for raw subreads or `map` to start from existing reads.
- `--aligner`: Choose between `minimap2` (default) or `ultra` (requires `--gtf`).
- `--capped`: Use this flag if the input RNAs are capped.
- `-resume`: Use this to restart a run from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary outputs include:

- **TAMA Results**: Cleaned and merged gene models in BED or GTF formats.
- **MultiQC**: A summary report aggregating statistics from various tools in the pipeline.
- **Mapped Reads**: BAM files containing aligned sequences.

For a complete list of output files and detailed descriptions, refer to the [official output documentation](https://nf-co.re/isoseq/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)