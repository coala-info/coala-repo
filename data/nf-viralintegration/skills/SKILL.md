---
name: viralintegration
description: This pipeline identifies viral integration events in genomic data using a chimeric read approach from FASTQ inputs, requiring a samplesheet, a host reference genome, and a viral genome database. Use when searching for viral insertions in host genomes, such as human clinical samples or infected cell lines, to generate abundance plots and interactive genome viewers for integration site evidence.
homepage: https://github.com/nf-core/viralintegration
---

# viralintegration

## Overview
nf-core/viralintegration is a bioinformatics pipeline designed to detect viral sequences integrated into host genomes. It utilizes a chimeric read approach, originally based on CTAT-VirusIntegrationFinder, to pinpoint exactly where viral DNA has inserted into the host's genetic material.

The pipeline processes raw sequencing reads through quality control, host alignment, and specialized chimeric read identification against combined host and viral references. It produces detailed reports, including viral read counts, abundance plots, and interactive visualizations for exploring insertion sites and viral infection evidence.

## Data preparation
The pipeline requires a comma-separated samplesheet containing paths to FASTQ files. Each row represents a single-end or paired-end sample.

`samplesheet.csv` example:
```csv
sample,fastq_1,fastq_2
CONTROL_REP1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
```

Required reference files include:
*   **Host Genome:** Specified via `--genome` (using iGenomes) or manually via `--fasta` and `--gtf`.
*   **Viral Database:** A FASTA file containing viral genomes, provided via `--viral_fasta`. A default database from the Broad Institute is used if not specified.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to use a specific release version with `-r` and a container profile like `docker` or `singularity`.

```bash
nextflow run nf-core/viralintegration \
   -r 1.1.0 \
   -profile <docker/singularity/conda> \
   --input samplesheet.csv \
   --genome GRCh38 \
   --outdir <OUTDIR>
```

Key parameters include:
*   `--min_reads`: Minimum number of reads required to report an integration (default: 5).
*   `--max_hits`: Maximum hits allowed (default: 50).
*   `--remove_duplicates`: Boolean to toggle removal of duplicate viral hits (default: true).
*   `-resume`: Use this flag to restart a run from the last cached step.

## Outputs
Results are saved in the directory specified by `--outdir`. Primary deliverables include:
*   `vif.html`: A web-based interactive genome viewer for visualizing virus insertion sites.
*   `vif.refined.wRefGeneAnnots.tsv`: A tab-delimited file containing refined insertion site candidates with gene annotations.
*   `VirusDetect.igvjs.html`: An interactive viewer for viral infection evidence.
*   `MultiQC/`: Quality control reports for raw reads, trimming, and alignments.
*   Viral read counts (TSV) and genome-wide abundance plots (PNG).

For a complete description of all output files, refer to the [official output documentation](https://nf-co.re/viralintegration/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)