---
name: conservation
description: The conservation tool quantifies and visualizes the evolutionary conservation of genetic sequences by comparing protein domains against coding sequences across multiple species. Use when user asks to quantify evolutionary conservation, calculate codon substitution matrices, perform statistical tests on sequence conservation, or visualize conservation patterns across species.
homepage: https://github.com/hanjunlee21/conservation
---


# conservation

## Overview
The `conservation` tool is a specialized bioinformatics package used to quantify and visualize the evolutionary conservation of genetic sequences. It bridges the gap between protein-level domain analysis and nucleotide-level coding sequences (CDS). By comparing a specific protein domain (like those from Pfam) against the CDS of multiple species, it calculates codon substitution matrices and applies statistical tests (Fisher's exact test) to determine the significance of observed conservation. This is particularly useful for researchers studying selective pressure, functional genomics, and molecular evolution.

## Installation
The tool can be installed via Bioconda or PyPI:
```bash
# Via Bioconda
conda install bioconda::conservation

# Via PyPI
pip install conservation
```

## Command Line Usage
The primary entry point for the tool is the `conservation codon` command.

### Basic Syntax
```bash
conservation codon -d <domain_file> -c <cds_files> -o <output_directory>
```

### Core Arguments
- `-d, --domain`: Path to the Pfam or domain FASTA file.
- `-c, --cds`: A **comma-separated** list of CDS FASTA files (one per species). Do not include spaces between commas.
- `-o, --output`: The directory where results and visualizations will be saved.
- `-t, --threads`: Number of parallel threads to use for computation (default is usually 1).

### Statistical and Visualization Tuning
- `-q, --fdr`: Set the False Discovery Rate (FDR) cutoff for statistical significance.
- `-s, --conservedness`: Define the identity ratio threshold to classify a position as "conserved."
- `-r, --dpi`: Set the resolution (DPI) for the generated PDF plots, useful for publication-quality figures.

## Common Workflow Example
To analyze conservation across three species (e.g., human, mouse, and yeast) using a specific Pfam domain:

```bash
conservation codon \
  -d pfam_domain.fasta \
  -c human.fasta,mouse.fasta,yeast.fasta \
  -o analysis_results \
  -t 4 \
  -q 0.05
```

## Outputs
The tool generates several files in the specified output directory:
1. **Substitution Matrix (`.tsv`)**: Contains the raw codon substitution data.
2. **Statistical Analysis (`.statistics.tsv`)**: Results of the Fisher's exact tests and significance calculations.
3. **Visualizations (PDF)**: Heatmaps and alignment plots showing conservation patterns across the input species.

## Expert Tips
- **Input Consistency**: Ensure that the headers in your CDS FASTA files are consistent and that the sequences correspond correctly to the domain being analyzed.
- **Performance**: For large datasets or many species, always utilize the `--threads` argument to take advantage of multi-core processing.
- **Thresholding**: If the output shows too much or too little "significance," iterate on the `--conservedness` (-s) and `--fdr` (-q) parameters to better fit the evolutionary distance of the species being compared.

## Reference documentation
- [Conservation GitHub Repository](./references/github_com_hanjunlee21_conservation.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_conservation_overview.md)