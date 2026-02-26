---
name: votuderep
description: votuderep manages and refines viral Operational Taxonomic Units by dereplicating sequences and filtering them based on quality. Use when user asks to dereplicate viral sequences, filter viral contigs by quality, prepare sample sheets for Nextflow, or split CoverM tables.
homepage: https://github.com/quadram-institute-bioscience/votuderep
---


# votuderep

## Overview

`votuderep` is a specialized toolkit designed for the management and refinement of viral Operational Taxonomic Units (vOTUs). It provides a streamlined workflow for bioinformaticians to transform raw viral contigs into a non-redundant, high-quality representative set. The tool primarily focuses on two critical tasks: BLAST-based Average Nucleotide Identity (ANI) clustering to remove redundant sequences and multi-parameter filtering based on CheckV quality reports.

## Core Workflows

### 1. Sequence Dereplication
Use the `derep` subcommand to cluster sequences and select representatives. This is typically the first step after viral identification to reduce the computational load of downstream mapping.

```bash
# Standard dereplication (95% ANI, 85% coverage)
votuderep derep -i viral_contigs.fasta -o vOTUs.fasta -t 8

# Stringent dereplication for closely related strains
votuderep derep -i input.fasta -o strict_vOTUs.fasta --min-ani 99 --min-tcov 90
```

**Expert Tips:**
* **Thread Allocation**: BLAST+ is the bottleneck; always use `-t` to match your available CPU cores.
* **Intermediate Files**: Use `--keep` and `--tmp` if you need to inspect the BLAST results or cluster assignments for troubleshooting.

### 2. Quality Filtering
Use the `filter` subcommand to prune your dataset based on CheckV results. This requires both the original FASTA and the `quality_summary.tsv` from CheckV.

```bash
# Filter for high-quality or complete genomes only
votuderep filter contigs.fasta checkv_out.tsv --min-quality high -o filtered.fasta

# Complex filtering for high-confidence datasets
votuderep filter contigs.fasta checkv_out.tsv \
  --min-completeness 80 \
  --max-contam 5 \
  --min-len 5000 \
  --no-warnings \
  -o high_confidence_vOTUs.fasta
```

**Quality Level Hierarchy:**
The `--min-quality` flag is inclusive. Selecting a level includes everything above it:
* `low`: (Default) Includes Low, Medium, High, and Complete.
* `medium`: Includes Medium, High, and Complete.
* `high`: Includes High and Complete.

### 3. Data Preparation and Utilities
* **Nextflow Preparation**: Use `tabulate` to create sample sheets from directories of paired-end reads.
  ```bash
  votuderep tabulate path/to/reads/ -o samples.csv --extension .fastq.gz
  ```
* **Coverage Analysis**: Use `splitcoverm` to separate multi-metric CoverM tables into individual files per metric (e.g., mean, trimmed_mean).
  ```bash
  votuderep splitcoverm -i coverage.tsv -o results/prefix
  ```

## Best Practices

* **Database Management**: Before starting a new project, ensure you have the latest dependencies using `votuderep getdbs`.
* **Provirus Handling**: If your study focuses on integrated viruses, use the `--provirus` flag in the `filter` command to isolate sequences identified as proviruses by CheckV.
* **Handling "Not-determined"**: By default, CheckV sequences with "Not-determined" quality are kept. Use `--exclude-undetermined` if you require strictly validated sequences.
* **Piping**: The `filter` command defaults to STDOUT if no output is specified, allowing for integration into command-line pipes:
  ```bash
  votuderep filter in.fa checkv.tsv --complete | grep ">" | wc -l
  ```

## Reference documentation
- [votuderep Main Documentation](./references/github_com_quadram-institute-bioscience_votuderep.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_votuderep_overview.md)