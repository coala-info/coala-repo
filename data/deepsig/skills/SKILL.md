---
name: deepsig
description: DeepSig detects signal peptides and predicts cleavage sites in protein sequences using deep learning architectures. Use when user asks to detect signal peptides, identify protein cleavage sites, or determine the secretory nature of proteins.
homepage: https://github.com/BolognaBiocomp/deepsig
---


# deepsig

## Overview
DeepSig is a bioinformatics tool designed to detect signal peptides in proteins with high accuracy using deep learning architectures. It processes protein sequences provided in FASTA format and outputs structural annotations in GFF3 format. The tool is particularly useful for identifying the secretory nature of proteins and determining the exact cleavage site that separates the signal peptide from the mature protein (the "Chain").

## Command Line Usage

The primary interface for DeepSig is the `deepsig` command (or `deepsig.py` depending on the installation method).

### Basic Syntax
```bash
deepsig -f <input_fasta> -o <output_file> -k <organism_type>
```

### Mandatory Arguments
- `-f FASTA`: Path to the input multi-FASTA file containing protein sequences.
- `-o OUTF`: Path for the output tabular file (GFF3 format).
- `-k {euk,gramp,gramn}`: The kingdom/organism type the sequences belong to:
  - `euk`: Eukaryotes
  - `gramp`: Gram-positive bacteria
  - `gramn`: Gram-negative bacteria

### Optional Arguments
- `-a CPU`: Number of threads/CPUs to be used by the TensorFlow backend.

## Output Interpretation
DeepSig produces a GFF3-compliant output file with nine columns. Key columns to analyze include:

1.  **Column 3 (Feature)**: Annotated as either "Signal peptide" or "Chain". If no signal peptide is detected, the entire sequence is labeled as "Chain".
2.  **Column 4 & 5 (Start/End)**: The coordinates of the detected feature.
3.  **Column 6 (Score)**: The confidence score assigned by the deep learning model (0.0 to 1.0).
4.  **Column 9 (Description)**: Usually contains the evidence code `ECO:0000256` (automatic annotation).

## Best Practices and Tips

- **Organism Selection**: Ensure the `-k` flag matches the biological source of the sequences. Using the wrong model (e.g., using `euk` for bacterial sequences) will significantly degrade prediction accuracy.
- **Docker Execution**: When using the Docker image `bolognabiocomp/deepsig`, you must map your local directory to the container's internal path to allow the tool to access your files:
  ```bash
  docker run -v $(pwd):/data/ bolognabiocomp/deepsig -f /data/input.fasta -o /data/output.gff3 -k euk
  ```
- **Resource Management**: For large-scale FASTA files, utilize the `-a` flag to increase the number of CPU cores, which speeds up the TensorFlow inference process.
- **Input Validation**: Ensure input sequences are protein sequences. DeepSig is not designed for nucleotide sequences and will produce errors or invalid results if provided with DNA/RNA.

## Reference documentation
- [DeepSig GitHub Repository](./references/github_com_BolognaBiocomp_deepsig.md)
- [DeepSig Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_deepsig_overview.md)