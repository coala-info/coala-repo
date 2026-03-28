---
name: baktfold
description: Baktfold identifies the functions of hypothetical proteins by performing structural homology searches using protein language models and 3D shape prediction. Use when user asks to annotate hypothetical proteins, perform structural homology searches with Foldseek, or convert Prokka and eukaryotic GenBank files for functional annotation.
homepage: https://github.com/gbouras13/baktfold
---


# baktfold

## Overview
Baktfold is a specialized bioinformatics tool designed to bridge the gap in genome annotation where sequence-based methods fail. It specifically targets "hypothetical proteins"—sequences that standard tools like Bakta or Prokka cannot confidently identify. By using the ProstT5 language model to translate amino acid sequences into 3Di structural tokens, Baktfold allows for sensitive structural homology searches using Foldseek. This approach can identify protein functions based on their predicted 3D shape rather than just their primary sequence, making it highly effective for diverse biological entities including bacteria, plasmids, and eukaryotes.

## Installation and Database Setup
Before running annotations, the environment must be configured and databases must be initialized.

*   **Environment**: Use Conda to manage dependencies, especially `foldseek`.
    ```bash
    conda create -n baktfoldENV -c conda-forge -c bioconda baktfold
    ```
*   **GPU Acceleration**: If an NVIDIA GPU is available, install the CUDA-compatible version of pytorch to significantly speed up the ProstT5 translation step.
    ```bash
    conda install -c pytorch -c nvidia pytorch-cuda=11.8
    ```
*   **Database Initialization**: Download the required structural databases. Use the `-t` flag to specify threads for faster downloads.
    ```bash
    baktfold install -d baktfold_db -t 8
    ```
*   **GPU Database Padding**: If using a GPU for Foldseek searches, you must format the database accordingly:
    ```bash
    baktfold install -d baktfold_db --foldseek-gpu
    ```

## Core Workflows

### 1. Annotating Bakta Outputs
The primary workflow involves taking the `.json` output from a Bakta annotation run. Baktfold will automatically extract the hypothetical proteins and attempt to annotate them.
```bash
baktfold run -i assembly.json -o output_dir -d baktfold_db -t 8
```

### 2. Annotating Protein Sequences (Fasta)
If you have a set of protein sequences in FASTA format (e.g., from a different annotator or a specific study), use the `proteins` subcommand.
```bash
baktfold proteins -i proteins.faa -o output_dir -d baktfold_db -t 8
```

### 3. Handling Non-Bakta GenBank Files
If your starting point is a Prokka GenBank file or a eukaryotic GenBank file, you must convert it to the Bakta JSON format first.
*   **Prokka Conversion**:
    ```bash
    baktfold convert-prokka -i prokka.gbk -o converted.json
    ```
*   **Eukaryotic Conversion (Experimental)**:
    ```bash
    baktfold convert-euk -i euk.gbk -o euk.json
    ```

## Expert Tips and Best Practices
*   **Eukaryotic Support**: When running Baktfold on eukaryotic data, always include the `--euk` flag in the `run` command to ensure proper handling of eukaryotic genomic features.
*   **Custom Databases**: You can supplement the default structural databases with your own using the `--custom-db` flag.
*   **Pre-computed Structures**: If you have already generated `.pdb` or `.cif` structures (e.g., via AlphaFold2 or ColabFold), you can provide these to Baktfold to skip the ProstT5 translation step, increasing accuracy.
*   **Resource Management**: The ProstT5 model is memory-intensive. If running on a system with limited RAM, monitor usage closely during the translation phase.
*   **Multi-domain Proteins**: Baktfold is configured to keep non-overlapping top hits for CATH (similar to Foldseek's `--greedy-best-hits`), which is essential for correctly identifying functions in multi-domain proteins.



## Subcommands

| Command | Description |
|---------|-------------|
| baktfold compare | Runs Foldseek vs baktfold db |
| baktfold install | Installs ProstT5 model and baktfold database |
| baktfold predict | Uses ProstT5 to predict 3Di tokens - GPU recommended |
| baktfold proteins-compare | Runs Foldseek vs baktfold db on proteins input |
| baktfold run | baktfold predict then comapare all in one - GPU recommended |
| proteins | baktfold proteins-predict then comapare all in one - GPU recommended |

## Reference documentation
- [Baktfold GitHub Repository](./references/github_com_gbouras13_baktfold_blob_main_README.md)
- [Baktfold Version History](./references/github_com_gbouras13_baktfold_blob_main_HISTORY.md)