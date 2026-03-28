---
name: pyani-plus
description: pyani-plus calculates Average Nucleotide Identity (ANI) to classify and compare microbial genomes using various alignment algorithms. Use when user asks to calculate ANI between genome sequences, classify bacterial species, manage genomic analysis runs in a database, or generate identity heatmaps.
homepage: https://github.com/pyani-plus/pyani-plus
---

# pyani-plus

## Overview

`pyani-plus` is a specialized tool for microbial genomics used to classify and compare whole-genome sequences. It calculates the Average Nucleotide Identity (ANI) between pairs of genomes, which serves as a gold standard for defining bacterial species (typically using a 95-96% identity threshold). The tool manages results in a local SQLite database, allowing for incremental updates, run comparisons, and robust data tracking. It is a modern reimplementation of the original `pyani` package, offering improved performance and support for a wider range of alignment algorithms and schedulers.

## Core Workflows

### 1. Initializing an Analysis
To run an ANI analysis, you must provide a directory containing your genome FASTA files. Results are automatically stored in a SQLite database (defaulting to `pyani_plus.db` in the current directory).

**Common Methods:**
- **ANIm (MUMmer):** `pyani-plus anim -i <input_dir> -o <output_dir>`
- **ANIb (BLAST+):** `pyani-plus anib -i <input_dir> -o <output_dir>`
- **FastANI:** `pyani-plus fastani -i <input_dir> -o <output_dir>`
- **Sourmash:** `pyani-plus sourmash -i <input_dir> -o <output_dir>`

### 2. Managing Analysis Runs
Since `pyani-plus` uses a database, you can manage multiple experiments within the same file.

- **List all runs:** `pyani-plus list-runs`
- **Delete a specific run:** `pyani-plus delete-run --run-id <ID>`
- **Resume an interrupted run:** `pyani-plus resume --run-id <ID>`

### 3. Classification and Visualization
Once the identity matrix is calculated, use the following commands to interpret the data:

- **Classify genomes:** Group genomes into clusters based on an identity threshold (e.g., 0.95 for species).
  `pyani-plus classify --run-id <ID> --threshold 0.95`
- **Generate plots:** Create heatmaps of the ANI results.
  `pyani-plus plot-run --run-id <ID> -o <output_dir>`
- **Export data:** Extract matrices (identity, coverage, etc.) to TSV or Excel.
  `pyani-plus export-run --run-id <ID> -o <output_dir>`

## Expert Tips

- **Database Portability:** You can specify a custom database path using the `--database` or `-d` flag. This is useful for sharing results or organizing projects.
- **Naming Runs:** Always use the `--name` flag when starting a run. It makes identifying specific experiments in `list-runs` much easier than relying on timestamps or IDs.
- **Thread Management:** For large datasets, use the `--threads` flag to speed up alignments, especially for BLAST-based (ANIb) or FastANI methods.
- **External Alignments:** If you have already performed alignments using other tools, `pyani-plus` can import external alignment data using the `external-alignment` subcommand.



## Subcommands

| Command | Description |
|---------|-------------|
| pyani-plus anib | Execute ANIb calculations, logged to a pyANI-plus SQLite3 database. |
| pyani-plus anim | Execute ANIm calculations, logged to a pyANI-plus SQLite3 database. |
| pyani-plus classify | Classify genomes into clusters based on ANI results. |
| pyani-plus delete-run | Delete any single run from the given pyANI-plus SQLite3 database. |
| pyani-plus dnadiff | Execute mumer-based dnadiff calculations, logged to a pyANI-plus SQLite3 database. |
| pyani-plus export-run | Export any single run from the given pyANI-plus SQLite3 database. |
| pyani-plus external-alignment | Compute pairwise ANI from given multiple-sequence-alignment (MSA) file. |
| pyani-plus fastani | Execute fastANI calculations, logged to a pyANI-plus SQLite3 database. |
| pyani-plus list-runs | List the runs defined in a given pyANI-plus SQLite3 database. |
| pyani-plus plot-run | Plot heatmaps and distributions for any single run. |
| pyani-plus plot-run-comp | Plot comparisons between multiple runs. |
| pyani-plus resume | Resume any (partial) run already logged in the database. |
| pyani-plus sourmash | Execute sourmash-plugin-branchwater ANI calculations, logged to a pyANI-plus SQLite3 database. |

## Reference documentation

- [Walkthrough: A First Analysis](./references/pyani-plus_github_io_pyani-plus-docs_walkthrough.html.md)
- [Subcommands Overview](./references/pyani-plus_github_io_pyani-plus-docs_subcommands_subcommands.html.md)
- [Installation Guide](./references/pyani-plus_github_io_pyani-plus-docs_installation.html.md)
- [Main README](./references/github_com_pyani-plus_pyani-plus_blob_main_README.md)