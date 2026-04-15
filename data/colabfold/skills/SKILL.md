---
name: colabfold
description: ColabFold predicts protein structures and complexes by accelerating the AlphaFold2 pipeline using MMseqs2 for rapid sequence alignment. Use when user asks to predict 3D protein models, generate multiple sequence alignments locally, or run high-throughput structure predictions using colabfold_batch and colabfold_search.
homepage: https://github.com/sokrypton/ColabFold
metadata:
  docker_image: "quay.io/biocontainers/colabfold:1.5.5--pyh7cba7a3_2"
---

# colabfold

## Overview

ColabFold is a high-performance framework for protein structure and complex prediction that significantly accelerates the AlphaFold2 pipeline. It replaces the slow HMMER-based homology search with MMseqs2, allowing for rapid generation of Multiple Sequence Alignments (MSAs). This skill focuses on the local command-line interface (CLI) tools, `colabfold_batch` and `colabfold_search`, which enable users to run predictions on their own hardware, manage large-scale datasets, and utilize custom sequence databases.

## Command Line Usage

### Structure Prediction with colabfold_batch

The primary tool for generating 3D models from protein sequences.

*   **Basic Prediction**: Run prediction on a FASTA or CSV file using the public MSA server.
    `colabfold_batch input_sequences.fasta ./output_dir`
*   **Two-Step Workflow**: Separate MSA generation from GPU-intensive prediction to optimize resource usage.
    1. Generate MSAs only: `colabfold_batch input.fasta ./out_dir --msa-only`
    2. Run prediction on generated MSAs: `colabfold_batch ./out_dir ./predictions`
*   **Amber Relaxation**: To refine structures after prediction without re-running the entire model, use the `--amber` flag or a dedicated relaxation script if available.

### Local MSA Generation with colabfold_search

Use this for large-scale queries or when data privacy prevents using the public MSA server.

*   **Large-Scale Search (On-the-fly)**: Recommended for thousands of queries to minimize RAM overhead.
    `MMSEQS_IGNORE_INDEX=1 colabfold_search queries.fa /path/to/db_folder ./msa_output`
*   **Single-Query Search**: Use a specialized prefiltering mode to reduce overhead for individual sequences.
    `colabfold_search queries.fa /path/to/db_folder ./msa_output --prefilter-mode 1`

## Database Management

Local execution requires downloading large databases (approx. 940GB).

*   **Setup without Indexing**: To save significant disk space and avoid the requirement for 1TB+ RAM, use the `MMSEQS_NO_INDEX` environment variable during setup.
    `MMSEQS_NO_INDEX=1 ./setup_databases.sh /path/to/db_folder`
*   **Custom Databases**: You can create expandable search databases from your own FASTA files using `mmseqs createdb` and `mmseqs cluster` before converting them to the ColabFold-compatible format.

## Expert Tips and Best Practices

*   **GPU Memory Limits**: For a standard GPU with ~16GB VRAM (like a Tesla T4), the maximum total protein length is approximately 2000 residues.
*   **Confidence Metrics**: ColabFold populates the B-factor column of the output PDB files with **pLDDT** values (0-100, where higher is better). Note that some software (like Phenix.phaser) expects traditional B-factors where lower is better; adjust accordingly.
*   **Visualizing pLDDT**: In PyMOL, use the command `spectrum b, red_yellow_green_cyan_blue, minimum=50, maximum=90` to color the structure by confidence.
*   **Complex Prediction**:
    *   `AlphaFold2-multimer` is the default for complexes in recent versions.
    *   For older residue index jump methods, specific notebooks or legacy flags may be required.
*   **Local Installation**: Use the `LocalColabFold` installer script for a portable, non-root installation on Linux, macOS, or Windows (via WSL2).



## Subcommands

| Command | Description |
|---------|-------------|
| colabfold_batch | ColabFold batch prediction |
| colabfold_search | Search for queries in databases and store results. |

## Reference documentation

- [ColabFold Main Repository](./references/github_com_sokrypton_ColabFold.md)
- [ColabFold User Guide and Wiki](./references/github_com_sokrypton_ColabFold_wiki.md)
- [Creating Expandable Search Databases](./references/github_com_sokrypton_ColabFold_wiki_Creating-expandable-search-databases.md)