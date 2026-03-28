---
name: vclean
description: vclean identifies and mitigates contamination in viral genomes from environmental samples using machine learning. Use when user asks to identify viral contamination, calculate contamination probabilities, or extract reliable contigs from contaminated sequences.
homepage: https://github.com/TsumaR/vclean
---


# vclean

## Overview

vclean is a specialized bioinformatics tool designed to identify and mitigate contamination in viral genomes derived from environmental samples. It uses a machine-learning approach to calculate contamination probabilities and provides a "purification" step that extracts the most reliable contigs from sequences flagged as contaminated. This skill provides the necessary procedures for environment setup, database management, and execution of the analysis pipeline.

## Installation and Setup

vclean requires Python 3.9 and is best managed via Conda to handle its dependencies (pandas, scikit-learn, lightgbm, biopython).

```bash
# Create environment and install vclean
conda install -c conda-forge -c bioconda vclean python=3.9
```

## Database Management

Before running analyses, you must download the required model databases.

1.  **Download**: Use the built-in command to fetch the data to a specific path.
    ```bash
    vclean download_database /path/to/database_dir
    ```
2.  **Configuration**: Set the `VCLEANDB` environment variable so the tool can locate the models automatically.
    ```bash
    export VCLEANDB=/path/to/database_dir
    ```

## Running the Pipeline

The primary command processes a directory of FASTA files and generates a contamination report.

```bash
vclean run <input_fasta_dir> <output_dir> [options]
```

### Key Outputs
- `Contamination_probability.tsv`: The main report containing the probability scores for each input sequence.
- `feature_table.tsv`: The raw features extracted from the sequences used by the model.
- `purified_fasta/`: A subdirectory created within the output folder. For sequences identified as contaminated, vclean saves new FASTA files here containing only the longest (and presumably most reliable) contigs.

## Expert Tips
- **Environment Variable**: Always ensure `VCLEANDB` is exported in your current shell session or added to your `.bashrc` to avoid using the `-d` flag repeatedly.
- **Input Structure**: vclean expects a directory as input, not individual files. Ensure your target FASTA files are grouped in a single folder.
- **Python Version**: If installation fails, verify you are strictly using Python 3.9, as the underlying machine learning models (LightGBM/Scikit-learn) may have version-specific serialization requirements.



## Subcommands

| Command | Description |
|---------|-------------|
| download_database | Download the latest version of vClean's database |
| vclean | Run vClean |

## Reference documentation
- [vClean README](./references/github_com_TsumaR_vclean_blob_main_README.md)
- [Project Metadata](./references/github_com_TsumaR_vclean_blob_main_pyproject.toml.md)