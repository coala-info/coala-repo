---
name: votuderep
description: votuderep is a command-line tool designed to curate viral metagenomic data by filtering sequences based on quality and performing dereplication to define non-redundant viral populations. Use when user asks to dereplicate viral sequences, cluster sequences into vOTUs, or filter contigs based on CheckV quality, completeness, and contamination metrics.
homepage: https://github.com/quadram-institute-bioscience/votuderep
---


# votuderep

## Overview
votuderep is a Python-based command-line interface designed to streamline the curation of viral metagenomic data. It is particularly useful in workflows involving CheckV, as it provides automated methods to filter contigs by quality, completeness, and contamination levels. The tool also handles sequence dereplication, which is a critical step in defining a non-redundant set of viral populations (vOTUs) from large-scale assembly projects.

## Core Workflows

### Sequence Dereplication
Use the `derep` command to cluster similar sequences and keep only a single representative for each cluster. This is essential for reducing computational overhead in mapping and annotation.

```bash
# Standard dereplication (95% ANI, 85% coverage)
votuderep derep -i viral_contigs.fasta -o dereplicated_vOTUs.fasta -t 8

# Stringent dereplication for closely related populations
votuderep derep -i input.fasta --min-ani 97 --min-tcov 90
```

**Expert Tips:**
* **Threads**: Always specify `-t` to match your available CPU cores, as BLAST+ is the primary bottleneck.
* **Intermediate Files**: Use `--keep` and `--tmp` if you need to inspect the BLAST results or the clustering assignments for troubleshooting.

### Quality Filtering with CheckV
The `filter` command integrates directly with CheckV output to prune low-quality or contaminated viral sequences.

```bash
# Filter for high-quality, complete genomes only
votuderep filter input.fasta checkv_output.tsv \
  --min-quality high \
  --complete \
  -o high_quality_complete.fasta

# Filter by specific completeness and contamination thresholds
votuderep filter input.fasta checkv_output.tsv \
  --min-completeness 50 \
  --max-contam 5 \
  --no-warnings
```

**Best Practices:**
* **Length Constraints**: Use `-m` (min-len) to remove short fragments that may pass quality checks but lack sufficient biological context.
* **Undetermined Quality**: By default, CheckV may label some contigs as "Not-determined." Use `--exclude-undetermined` to ensure your final set only contains contigs with confident quality assignments.

### Utility Operations
* **Database Management**: Before running workflows, ensure dependencies are met using `votuderep getdbs` to fetch Genomad and CheckV databases.
* **Coverage Analysis**: If using CoverM for abundance estimation, use `votuderep splitcoverm` to separate multi-metric TSV files into individual files per metric (e.g., mean, relative abundance).
* **Nextflow Preparation**: Use `votuderep tabulate` to quickly generate the sample sheets required for Nextflow-based viral pipelines from a directory of paired-end reads.



## Subcommands

| Command | Description |
|---------|-------------|
| derep | Dereplicate vOTUs using BLAST and ANI clustering. This command: 1. Creates a BLAST database from input sequences 2. Performs all-vs-all BLAST comparison 3. Calculates ANI and coverage for sequence pairs 4. Clusters sequences by ANI using greedy algorithm 5. Outputs cluster representatives (longest sequences) The algorithm selects the longest sequence from each cluster as the representative, effectively removing shorter redundant sequences. |
| getdbs | Download geNomad, CheckV, and PHROGs databases. Downloads and extracts viral classification and quality control databases required for viral metagenomics analysis. The command is resumable: if interrupted, it will skip already downloaded and extracted files when re-run. |
| tabulate | Generate CSV file from a directory containing sequencing reads. Scans INPUT_DIR for paired-end sequencing reads and generates a CSV table mapping sample names to their R1 and R2 file paths. The command identifies read pairs by looking for forward/reverse tags in filenames, extracts sample names, and outputs a table suitable for downstream analysis tools. |
| votuderep filter | Filter FASTA file using CheckV quality metrics. |
| votuderep trainingdata | Download training dataset from the internet. Uses a registry (DATASETS) of named datasets, each containing a set of {url, path} items. Adds new datasets by extending the DATASETS dict. |

## Reference documentation
- [votuderep GitHub Repository](./references/github_com_quadram-institute-bioscience_votuderep.md)
- [votuderep README and Usage Guide](./references/github_com_quadram-institute-bioscience_votuderep_blob_main_README.md)