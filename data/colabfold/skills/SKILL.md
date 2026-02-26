---
name: colabfold
description: ColabFold predicts protein structures and complexes by combining MMseqs2 for fast sequence alignment with AlphaFold2 models. Use when user asks to predict protein structures, generate multiple sequence alignments locally, or perform high-throughput structural biology workflows.
homepage: https://github.com/sokrypton/ColabFold
---


# colabfold

## Overview

ColabFold is a high-performance framework designed to make protein structure and complex prediction accessible and efficient. It replaces the slow sensitive search of the original AlphaFold2 pipeline with MMseqs2, significantly reducing the time required for Multiple Sequence Alignment (MSA) generation. This skill focuses on the local command-line interface (CLI) tools, `colabfold_batch` and `colabfold_search`, which allow for high-throughput structural biology workflows on local GPUs or clusters.

## Installation

The most reliable way to install ColabFold locally is via the Bioconda channel or the LocalColabFold installer script.

```bash
# Using Conda
conda install bioconda::colabfold

# Using LocalColabFold (Linux/macOS/WSL2)
curl -L https://raw.githubusercontent.com/YoshitakaMo/localcolabfold/main/install_colabfold_linux.sh | bash
```

## Core CLI Workflows

### 1. Basic Structure Prediction
The simplest way to predict structures is using the public MSA server. This is suitable for a small number of sequences.

```bash
colabfold_batch input_sequences.fasta output_directory
```

### 2. Local MSA Generation (Two-Step Workflow)
For large-scale predictions or sensitive data, generate MSAs locally before running the folding models. This separates the CPU-intensive search from the GPU-intensive folding.

**Step A: Search (CPU intensive)**
```bash
colabfold_search input.fasta /path/to/databases msa_output_folder
```

**Step B: Batch Prediction (GPU intensive)**
```bash
colabfold_batch msa_output_folder prediction_output_folder
```

### 3. Database Setup
To run local searches, you must download the required databases (approx. 940GB).

```bash
# Setup without pre-indexing to save disk space
MMSEQS_NO_INDEX=1 ./setup_databases.sh /path/to/db_folder
```

## Expert CLI Patterns & Tips

### Optimizing for Single Queries
By default, `colabfold_search` is optimized for thousands of queries. For a single sequence, the overhead of the default k-mer matching is high. Use `--prefilter-mode 1` to switch to a diagonal-based ungapped alignment strategy which is faster for single queries.

```bash
colabfold_search query.fasta /db_folder msas --prefilter-mode 1
```

### Memory and Performance Management
- **Disk Space:** Use `MMSEQS_NO_INDEX=1` during setup to avoid generating massive index files if you have limited storage.
- **RAM Requirements:** Batch searches typically require ~128GB RAM. If you wish to keep the entire database in memory for maximum speed, >1TB RAM is required.
- **GPU Limits:** A Tesla T4 (16GB VRAM) can typically handle sequences up to ~2000 residues.

### Handling Complexes (Multimers)
ColabFold supports multimer prediction via `colabfold_batch`. Ensure your input FASTA uses the appropriate format (e.g., separate chains with a colon `:` or provide a CSV with multiple sequences).

### Visualization Tips
ColabFold populates the B-factor column of the output PDB files with **pLDDT** (Predicted Local Distance Difference Test) values.
- **PyMOL Coloring:** To color by confidence (AlphaFold colors):
  ```text
  spectrum b, red_yellow_green_cyan_blue, minimum=50, maximum=90
  ```

## Common Troubleshooting
- **MSA Server Limits:** Do not use multiple IPs to query the public MMseqs2 server simultaneously; use local `colabfold_search` for large batches.
- **Database Path:** If `mmseqs` is not in your PATH, specify it explicitly:
  ```bash
  colabfold_search --mmseqs /path/to/bin/mmseqs input.fasta db_folder msas
  ```

## Reference documentation
- [ColabFold GitHub Repository](./references/github_com_sokrypton_ColabFold.md)
- [ColabFold User Guide & Wiki](./references/github_com_sokrypton_ColabFold_wiki.md)
- [Bioconda ColabFold Package](./references/anaconda_org_channels_bioconda_packages_colabfold_overview.md)