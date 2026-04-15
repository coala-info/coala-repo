---
name: heliano
description: HELIANO identifies and annotates Helitron-like elements within host genomes by distinguishing between canonical and non-canonical variants. Use when user asks to perform de novo searches for Helitrons, generate consensus sequences from predicted elements, or use pre-identified pair information to accelerate discovery in related species.
homepage: https://github.com/Zhenlisme/heliano
metadata:
  docker_image: "quay.io/biocontainers/heliano:1.3.1--hdfd78af_0"
---

# heliano

## Overview
HELIANO (Helitron-like elements annotator) is a specialized bioinformatics tool designed for the fast and accurate identification of Helitron-like elements within host genomes. It distinguishes between canonical Helitrons (HLE1) and non-canonical variants (HLE2), providing coordinates in BED format and sequences in FASTA format. This skill provides the necessary command-line patterns to execute de novo searches, generate consensus sequences, and utilize pre-identified pair information to accelerate discovery in related species.

## Installation and Environment
The tool is best managed via Conda or Mamba to handle its extensive dependencies (Python 3.9, R 4.1, Biopython, Bedtools, HMMER, etc.).

```bash
# Create and activate environment
mamba create -n HELIANO
mamba activate HELIANO

# Install from bioconda
mamba install zhenlisme::HELIANO -c conda-forge -c bioconda
```

## Core CLI Usage

### De Novo Detection
To perform a standard search for Helitron-like elements in a genome file:

```bash
heliano -g <genome.fa> -is1 0 -is2 0 -o <output_prefix> -w 15000
```
*   `-g`: Input genome in FASTA format.
*   `-is1 / -is2`: Insertion size parameters (0 for default).
*   `-o`: Prefix for output files.
*   `-w`: Window size for searching (e.g., 15000 bp).

### Dis-denovo Prediction (Accelerated)
If you have a `pairlist.tbl` from a previous run or a closely related species, you can skip the computationally expensive de novo LTS-RTS pairing process:

```bash
heliano -g <genome.fa> -o <output_prefix> -ts pairlist.tbl --dis_denovo
```

### Generating Consensus Sequences
After a successful run, use the `heliano_cons` utility to create consensus sequences from the predicted elements:

```bash
heliano_cons -g <genome.fa> -r <RC.representative.bed> -o <output_dir> -n <threads>
```

## Output Interpretation
The tool produces several key files in the output directory:
*   `RC.representative.bed`: 11-column BED file containing coordinates, subfamily classification, p-values (Fisher's exact test), and mobility type (autonomous vs. non-autonomous).
*   `RC.representative.fa`: FASTA file of the predicted sequences.
*   `pairlist.tbl`: Contains LTS-RTS pair information, useful for subsequent `dis_denovo` runs.
*   `TIR_count.tbl`: Counts of terminal inverted repeats for each subfamily.

## Expert Tips
*   **Autonomous vs. Non-autonomous**: HELIANO classifies insertions encoding Rep/helicase as "putative autonomous" (auto) in the 10th column of the BED output.
*   **Significance**: Pay close attention to the `pvalue` column (column 7) in the BED file; lower values indicate higher significance in the Fisher's exact test prediction.
*   **Memory Management**: For large genomes, ensure the window size (`-w`) is optimized; 15000 is a standard starting point but may need adjustment based on the expected size of elements in your specific target organism.

## Reference documentation
- [HELIANO GitHub Repository](./references/github_com_Zhenlisme_heliano.md)
- [HELIANO Wiki](./references/github_com_Zhenlisme_heliano_wiki.md)
- [Bioconda Heliano Overview](./references/anaconda_org_channels_bioconda_packages_heliano_overview.md)