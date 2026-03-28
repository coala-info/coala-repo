---
name: rosella
description: Rosella is a high-performance metagenomic binning pipeline that uses manifold learning to cluster sequence data based on composition and coverage. Use when user asks to install the tool, set up the environment, or execute binning workflows for shotgun metagenomic datasets.
homepage: https://github.com/rhysnewell/rosella.git
---

# rosella

## Overview
Rosella provides a high-performance metagenomic binning pipeline written in Rust with Python-based manifold learning. It excels at identifying clusters in high-dimensional sequence data (composition and coverage) by leveraging non-linear dimensionality reduction. Use this skill to guide the installation, environment setup, and execution of binning workflows for shotgun metagenomic datasets.

## Installation and Environment Setup
Rosella requires a specific environment to manage its Rust-based core and Python dependencies (UMAP/HDBSCAN).

- **Recommended (Conda):**
  ```bash
  conda create -n rosella -c bioconda rosella
  conda activate rosella
  ```
- **Development/Manual Build:**
  If the latest features are required, clone the repository recursively to include submodules:
  ```bash
  git clone --recursive https://github.com/rhysnewell/rosella
  cd rosella
  cargo install --path .
  mamba env create -f rosella.yml -n rosella
  ```

## Core Usage Patterns
Rosella typically requires a FASTA file of contigs and BAM files representing mapping of reads to those contigs to calculate coverage profiles.

### Basic Binning Command
```bash
rosella -r [CONTIGS.fasta] -b [MAPPING_1.bam] [MAPPING_2.bam] -o [OUTPUT_DIRECTORY]
```

### Key Parameters and Best Practices
- **Refinement:** Rosella is under active development; always check `rosella --version` to ensure compatibility with specific parameters.
- **Resource Management:** Since UMAP and HDBSCAN can be memory-intensive on very large assemblies, ensure the environment has sufficient RAM for the Python component.
- **Input Requirements:** Ensure BAM files are sorted and indexed before running the pipeline to prevent execution errors.

## Expert Tips
- **Submodules:** If building from source, the `--recursive` flag during git clone is critical because Rosella relies on specific sub-components (like `flight`) for its manifold learning implementation.
- **Version Selection:** For the most stable results, use the latest release from Bioconda. For cutting-edge improvements in clustering accuracy, consider building from the `dev` branch on GitHub.



## Subcommands

| Command | Description |
|---------|-------------|
| rosella recover | Recover MAGs from contigs using UMAP and HDBSCAN clustering. |
| rosella refine | Refine MAGs using UMAP and HDBSCAN clustering. |
| rosella shell-completion | Generate a shell completion script for lorikeet |

## Reference documentation
- [Rosella GitHub Repository](./references/github_com_rhysnewell_rosella.md)
- [Bioconda Rosella Overview](./references/anaconda_org_channels_bioconda_packages_rosella_overview.md)