---
name: metaquant
description: Metaquant performs quantitative analysis on the function and taxonomy of microbiomes. Use when user asks to perform quantitative analysis on microbiomes, install via Bioconda, or use the command-line interface.
homepage: The package home page
---


# metaquant

metaquant/
├── SKILL.md
└── references/
    ├── anaconda_org_channels_bioconda_packages_metaquant_overview.md
    └── github_com_galaxyproteomics_metaquantome.md

---
name: metaquant
description: Quantitative microbiome analysis tool. Use when Claude needs to perform quantitative analysis on the function and taxonomy of microbiomes, including installation via Bioconda, local development with pip, and command-line interface usage.
---

## Overview

The metaQuantome tool is designed for quantitative analysis of microbiomes, focusing on their functional and taxonomic composition and interactions. It can be installed via Bioconda or developed locally using pip. The primary interface is a command-line tool for performing various microbiome analyses.

## Usage Instructions

### Installation

**Via Bioconda (Recommended for Mac/Linux):**

1.  **Install Conda:** Download and install Anaconda or Miniconda if you don't have it.
2.  **Configure Channels:**
    ```bash
    conda config --add channels defaults
    conda config --add channels bioconda
    conda config --add channels conda-forge
    ```
3.  **Create Environment:**
    ```bash
    conda create -n mqome metaquantome=2.0.3
    ```
    (Type 'y' to proceed if prompted.)
4.  **Activate Environment:**
    ```bash
    conda activate mqome
    ```
    This makes the `metaquantome` command available.

**Local Development (using pip):**

1.  **Ensure Python 3 is installed.**
2.  **Install metaQuantome:** Navigate to the root directory of the cloned repository and run:
    ```bash
    pip install .
    ```

### Command-Line Interface (CLI)

The `metaquantome` command is used for various analyses.

**Example: Downloading necessary databases for testing:**

```bash
metaquantome db ncbi --dir ./metaquantome/data/test/
```
*(Note: This step can take a few minutes.)*

**Example: Running unit tests:**

1.  Clone the repository:
    ```bash
    git clone https://github.com/galaxyproteomics/metaquantome.git
    cd metaquantome
    ```
2.  Set up a BioConda environment as described above.
3.  Download test databases (as shown above).
4.  Run tests from the root directory:
    ```bash
    python -m unittest discover tests
    ```
    *(Note: This step can take a few minutes.)*

### Tutorials

In-depth tutorials for the metaQuantome command-line interface and its Galaxy tool integration can be found in the project's documentation.

## Expert Tips

*   Always ensure your conda environment is activated (`conda activate mqome`) before running `metaquantome` commands.
*   For local development, use a virtual environment to manage dependencies.
*   Refer to the official GitHub repository for the most up-to-date CLI options and advanced usage patterns.

## Reference documentation

- [metaQuantome Quantitative analysis on the function and taxonomy of microbiomes and their interaction.](./references/github_com_galaxyproteomics_metaquantome.md)
- [metaquant - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_metaquant_overview.md)