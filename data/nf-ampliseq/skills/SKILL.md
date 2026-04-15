---
name: ampliseq
description: This pipeline performs amplicon sequencing analysis from FASTQ files or ASV/OTU FASTA sequences using DADA2 denoising and various taxonomic databases like SILVA, UNITE, or GTDB. Use when analyzing 16S, ITS, CO1, or 18S rRNA gene amplicons from Illumina, PacBio, or IonTorrent platforms to characterize microbial or eukaryotic communities.
homepage: https://github.com/nf-core/ampliseq
---

# ampliseq

## Overview
nf-core/ampliseq is designed for the denoising and taxonomic classification of amplicon sequencing data, supporting markers such as 16S, ITS, CO1, and 18S. It addresses the biological challenge of profiling microbial or environmental communities by converting raw sequencing reads into high-resolution Amplicon Sequence Variants (ASVs).

The pipeline processes raw data through quality control, primer trimming, and denoising, ultimately delivering feature tables, phylogenetic trees, and diversity metrics. It supports multiple sequencing technologies including Illumina, PacBio, and IonTorrent, and provides integrated downstream analysis for ecological statistics.

## Data preparation
Input data can be provided as a folder path containing gzipped FASTQ files or via a structured samplesheet (CSV, TSV, or YAML). If using a folder via `--input_folder`, files should follow the `/*_R{1,2}_001.fastq.gz` naming convention unless specified otherwise via `--extension`.

A samplesheet requires the following columns:
- `sampleID`: Unique identifier starting with a letter (letters, numbers, or underscores only).
- `forwardReads`: Path to the forward FASTQ file.
- `reverseReads`: Path to the reverse FASTQ file (required for paired-end).
- `run`: Optional identifier for data from multiple sequencing runs.

Example samplesheet (CSV):
```csv
sampleID,forwardReads,reverseReads
sample1,data/s1_R1.fastq.gz,data/s1_R2.fastq.gz
sample2,data/s2_R1.fastq.gz,data/s2_R2.fastq.gz
```

Users must provide biological primer sequences using `--FW_primer` and `--RV_primer`. For downstream diversity analysis and differential abundance testing, an optional metadata file following QIIME2 specifications is required via `--metadata`.

## How to run
Run the pipeline by specifying the input source, primers, and an output directory. Use `-profile` to select the appropriate container engine or institutional configuration.

```bash
nextflow run nf-core/ampliseq \
    -r 2.11.0 \
    -profile docker \
    --input "path/to/samplesheet.csv" \
    --FW_primer "GTGYCAGCMGCCGCGGTAA" \
    --RV_primer "GGACTACNVGGGTWTCTAAT" \
    --outdir ./results
```

For PacBio or IonTorrent data, include the `--pacbio` or `--iontorrent` flags. To resume a failed or modified run, use the `-resume` parameter. Specific taxonomic databases can be selected using `--dada_ref_taxonomy` (default is SILVA 138).

## Outputs
Results are saved in the directory specified by `--outdir`. Key deliverables include:
- `overall_summary.html`: An R Markdown summary report of the analysis results.
- `multiqc/`: Quality control reports from FastQC and pipeline stages.
- `dada2/`: ASV sequences in FASTA format and feature abundance tables.
- `taxonomy/`: Taxonomic assignments based on the chosen reference database.
- `plots/`: Alpha rarefaction curves, taxonomic barplots, and diversity indices (generated if metadata is provided).

For detailed interpretation of results, refer to the official [output documentation](https://nf-co.re/ampliseq/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)