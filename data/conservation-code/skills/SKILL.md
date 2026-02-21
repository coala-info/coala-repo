---
name: conservation-code
description: The `conservation-code` skill enables the analysis of evolutionary pressure by comparing Coding DNA Sequences (CDS) against defined protein domains (e.g., Pfam).
homepage: https://github.com/hanjunlee21/conservation
---

# conservation-code

## Overview
The `conservation-code` skill enables the analysis of evolutionary pressure by comparing Coding DNA Sequences (CDS) against defined protein domains (e.g., Pfam). It automates the process of aligning sequences, calculating substitution frequencies, and determining the statistical significance of conserved residues. This tool is particularly useful for identifying functionally critical regions in proteins that have remained unchanged across divergent species.

## Installation
The tool can be installed via PyPI or Bioconda:
```bash
pip install conservation
# OR
conda install bioconda::conservation
```

## Command-Line Usage
The primary entry point for the tool is the `conservation codon` command.

### Basic Analysis Pattern
To run a standard conservation analysis between a domain and multiple species:
```bash
conservation codon \
  --domain domain.fasta \
  --cds species1.fasta,species2.fasta,species3.fasta \
  --output results_directory
```

### Advanced Configuration
Fine-tune the analysis using statistical thresholds and performance flags:
*   **Statistical Filtering**: Use `--fdr` (False Discovery Rate) to control for multiple testing and `--conservedness` to set the identity ratio threshold.
*   **Performance**: Use `--threads` to enable parallel processing for large datasets.
*   **Visualization**: Adjust `--dpi` for high-resolution PDF output plots.

Example with optimized parameters:
```bash
conservation codon -d pfam_domain.fasta -c human.fasta,mouse.fasta,yeast.fasta -o output_dir -t 8 -q 0.05 -s 0.7 -r 300
```

## Expert Tips and Best Practices
*   **Input Preparation**: Ensure that the CDS FASTA files contain valid coding sequences that correspond to the protein domain provided. The tool uses BLOSUM62 for alignment logic.
*   **Species Ordering**: When providing the comma-separated list for `--cds`, maintain a consistent order if running multiple comparative batches to ensure output matrices are comparable.
*   **Interpreting Outputs**:
    *   **Substitution Matrix (.tsv)**: Use this for raw frequency counts of codon changes.
    *   **Statistics (.statistics.tsv)**: Focus on the Fisher's exact test results to identify residues where conservation is statistically higher than background mutation rates.
    *   **PDF Visualizations**: These are ideal for identifying "hotspots" of conservation visually across the alignment.
*   **Resource Management**: For large-scale genomic comparisons involving many species, always specify `--threads` to prevent single-core bottlenecks during the alignment phase.

## Reference documentation
- [Conservation GitHub Repository](./references/github_com_hanjunlee21_conservation.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_conservation_overview.md)