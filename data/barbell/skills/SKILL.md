---
name: barbell
description: Barbell is a pattern-aware demultiplexer designed to resolve trimming errors and contamination in Nanopore sequencing data. Use when user asks to demultiplex reads, annotate barcode patterns, or trim and sort sequences based on specific Nanopore kits.
homepage: https://github.com/rickbeeloo/barbell
---


# barbell

## Overview
Barbell is a pattern-aware demultiplexer designed to resolve common issues in Nanopore data, such as trimming errors and contamination from artefact reads. It uses a scoring system that is more robust than simple edit-distance, making it particularly effective for custom experiments and complex library preparations. It follows a modular workflow: **annotate** (find patterns), **inspect** (validate results), **filter** (select high-quality matches), and **trim** (produce clean reads).

## Quickstart with Presets
For standard Nanopore kits, use the `kit` command to automate the workflow.

```bash
# Basic usage for a specific kit
barbell kit -k <kit-name> -i reads.fastq -o output_folder --maximize

# Example: Native Barcoding Kit 114 (96 samples)
barbell kit -k SQK-NBD114-96 -i reads.fastq -o output_folder --maximize

# Example: Rapid Barcoding Kit 114 (96 samples)
barbell kit -k SQK-RBK114-96 -i reads.fastq -o output_folder --maximize
```
*Note: Use `--maximize` for assembly-bound workflows to include more reads while maintaining high specificity.*

## Manual Workflow (Annotate & Trim)
For custom experiments or in-depth inspection, run the steps manually.

### 1. Annotation
Generate a TSV table of all detected barcode/adapter patterns.
```bash
barbell annotate --kit <kit-name> -i reads.fastq -t 10 -o annotations.tsv
```

### 2. Trimming
Apply trimming based on the annotations.
```bash
barbell trim -i reads.fastq -a annotations.tsv -o trimmed_reads/
```

## Expert Tips & Troubleshooting
- **Handling Concat Reads**: Barbell can identify fusion points within a single read. Use the `--use-extended` flag during annotation to search for these artefacts (3x slower but higher quality).
- **Low Recovery**: If too few reads are annotated, slightly increase `--flank-max-errors`. The default is derived automatically but can be overridden if your data has higher error rates.
- **False Positives**: If you see many `Fflank` matches (matches not near the ends), check the `rel_dist_to_end` column in the annotation TSV. If matches are random, lower the `--flank-max-errors` or adjust `--min-score-diff`.
- **Gzip Support**: Barbell supports transparent decompression of `.fastq.gz` files.
- **Performance**: Always use `target-cpu=native` if compiling from source to leverage SIMD instructions for maximum speed.



## Subcommands

| Command | Description |
|---------|-------------|
| annotate | Annotate FASTQ files with barcode information |
| filter | Filter annotation files based on pattern |
| inspect | View most common patterns in annotation |
| kit | Run a preset |
| trim | Trim and sort reads based on filtered annotations |

## Reference documentation
- [Barbell README](./references/github_com_rickbeeloo_barbell_blob_master_README.md)
- [Barbell Changelog](./references/github_com_rickbeeloo_barbell_blob_master_CHANGELOG.md)