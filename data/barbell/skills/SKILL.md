---
name: barbell
description: Barbell is a specialized tool for Oxford Nanopore Technologies demultiplexing that uses pattern-aware processing to identify barcodes and remove chimeric artifacts. Use when user asks to demultiplex Nanopore reads, annotate barcode patterns, or filter and trim reads for high-quality assembly.
homepage: https://github.com/rickbeeloo/barbell
---


# barbell

## Overview

Barbell is a specialized tool for Oxford Nanopore Technologies (ONT) demultiplexing that focuses on "pattern-aware" processing. Unlike standard demultiplexers that may over-trim or miss chimeric artifacts, Barbell identifies specific arrangements of barcodes and flanks to ensure contamination-free assemblies. It is significantly faster and more accurate than many traditional tools, making it ideal for both standard runs and complex, multi-protocol experiments.

## Installation

Barbell can be installed via Conda or Cargo:

```bash
# Via Bioconda
conda install -c bioconda barbell

# Via Cargo (requires Rust)
RUSTFLAGS="-C target-cpu=native" cargo install barbell
```

## Core Workflows

### 1. Quickstart with Presets
For standard Nanopore kits (e.g., Native or Rapid barcoding), use the `kit` command.

```bash
barbell kit -k <kit-name> -i <reads.fastq> -o <output_folder> --maximize
```

*   **Recommended Flag**: `--maximize` is generally preferred for assembly tasks as it uses a more balanced barcode configuration.
*   **Extended Search**: Use `--use-extended` to search for fusion points and artifacts. This is ~3x slower but essential for high-quality consensus sequences.

### 2. Manual In-depth Workflow
For maximum control, follow the `annotate` -> `inspect` -> `filter` -> `trim` sequence.

#### Step A: Annotate
Generate a TSV identifying barcodes and flanks in every read.
```bash
barbell annotate --kit <kit-name> -i <input.fastq> -t <threads> -o anno.tsv
```

#### Step B: Inspect
Summarize the patterns found in the annotation file to identify expected vs. unexpected (chimeric) reads.
```bash
barbell inspect -i anno.tsv
```

#### Step C: Filter
Create a `filters.txt` containing the specific patterns you want to keep (one per line), then run:
```bash
barbell filter -i anno.tsv -f filters.txt -o filtered.tsv
```

## Expert Tips and Troubleshooting

*   **Handling "Missed" Reads**: If too few reads are annotated, slightly increase `--flank-max-errors`. Check the log to see the automatically derived cutoff first.
*   **Reducing False Positives**: If you see too many `Fflank` matches (flank matches without confident barcodes) at random locations, lower the `--flank-max-errors` threshold.
*   **Trimming Syntax**: When defining custom patterns for trimming, use `>>` to indicate "cut after this element" and `<<` for "cut before this element" inside the tag brackets.
    *   Example: `Ftag[fw, *, @left(0..250), >>]`
*   **Custom Experiments**: For non-standard protocols, ensure that the sequences provided for annotation are unique to avoid ambiguous mapping.

## Reference documentation

- [Barbell GitHub Repository](./references/github_com_rickbeeloo_barbell.md)
- [Barbell Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_barbell_overview.md)