---
name: cutandrun
description: This pipeline processes paired-end FASTQ files from CUT&RUN, CUT&Tag, or TIPseq experiments using a CSV samplesheet to perform alignment to target and spike-in genomes, peak calling with SEACR or MACS2, and generation of normalized bigWig coverage tracks. Use when performing epigenomic profiling or studying protein-DNA interactions that require spike-in or IgG control normalization and comprehensive quality control reports via MultiQC.
homepage: https://github.com/nf-core/cutandrun
---

# cutandrun

## Overview
nf-core/cutandrun is designed for the analysis of CUT&RUN, CUT&Tag, and TIPseq experimental protocols used in epigenomic profiling and the study of protein-DNA interactions. It automates the transition from raw sequencing reads to peak calls and visualization-ready coverage files while handling complex normalization requirements.

The pipeline accepts paired-end FASTQ files and requires a samplesheet to define experimental groups and replicates. It produces aligned BAM files, peak sets from SEACR or MACS2, normalized bigWig tracks, and extensive quality control metrics including library complexity and fragment-based analysis.

## Data preparation
A CSV samplesheet is required to define the input data. Each row represents a pair of FASTQ files and must include the experimental group, replicate number, and the associated control group ID.

`samplesheet.csv` example:
```csv
group,replicate,fastq_1,fastq_2,control
h3k27me3,1,h3k27me3_rep1_r1.fastq.gz,h3k27me3_rep1_r2.fastq.gz,igg_ctrl
igg_ctrl,1,igg_rep1_r1.fastq.gz,igg_rep1_r2.fastq.gz,
```

Reference requirements and constraints:
- `--genome`: Name of an iGenomes reference (e.g., GRCh38).
- `--fasta`: Path to genome FASTA if not using `--genome`.
- `--spikein_genome`: Reference for spike-in normalization (defaults to `K12-MG1655`).
- `--gtf` and `--gene_bed`: Annotation files for downstream analysis and heatmap generation.
- FASTQ files must be paired-end and compressed (`.fastq.gz` or `.fq.gz`).

## How to run
Run the pipeline using the `nextflow run` command. Specify the input samplesheet, the desired peak caller, and the reference genome.

```bash
nextflow run nf-core/cutandrun \
  -profile docker \
  --input samplesheet.csv \
  --genome GRCh38 \
  --peakcaller 'seacr,macs2' \
  --outdir ./results
```

Key parameters:
- `-profile`: Choose a configuration profile (e.g., `docker`, `singularity`, `conda`, `test`).
- `--peakcaller`: Select `seacr`, `macs2`, or both (comma-separated).
- `--normalisation_mode`: Sets target read normalization; options include `Spikein` (default), `RPKM`, `CPM`, `BPM`, or `None`.
- `--dedup_target_reads`: Set to `true` to de-duplicate target reads in addition to control reads.
- `--remove_linear_duplicates`: Use for TIPseq assays involving linear amplification.
- `-resume`: Use this Nextflow flag to restart a run from the last successful step.

## Outputs
Results are saved to the directory specified by `--outdir`. The primary quality control summary is found in the `multiqc/` folder as an HTML report.

Key output locations:
- `alignment/`: Aligned BAM files for target and spike-in genomes.
- `peaks/`: Peak calls from SEACR and/or MACS2, including consensus peaks and reporting.
- `tracks/`: bedGraph and bigWig files for genome browser visualization.
- `igv/`: Automatically generated IGV session files for viewing results.
- `reporting/`: Detailed QC metrics including fragment-based analysis and heatmaps.

For more details about the output files and reports, refer to the [official output documentation](https://nf-co.re/cutandrun/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)