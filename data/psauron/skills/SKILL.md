---
name: psauron
description: "PSAURON uses recurrent neural networks to assess and score the likelihood that protein-coding gene annotations are genuine. Use when user asks to score protein-coding gene annotations, validate CDS or protein sequences, or filter gene predictions in non-model organisms."
homepage: https://github.com/salzberg-lab/PSAURON
---


# psauron

## Overview
PSAURON (Protein Sequence Annotation Using Recurrent Neural networks) provides a rapid, machine-learning-based assessment of protein-coding gene annotations. It scores sequences to determine their likelihood of being genuine genes, supporting both nucleotide (CDS) and amino acid (protein) inputs. It is especially effective for validating annotations in non-model organisms where traditional evidence might be sparse.

## Installation
Install via Conda or Pip:
```bash
conda install bioconda::psauron
# OR
pip install psauron
```
*Note: PSAURON depends on PyTorch. Using a virtual environment is recommended to avoid dependency conflicts.*

## Common CLI Patterns

### 1. Standard CDS Assessment (Default)
Scores all six reading frames of nucleotide coding sequences. This is the recommended mode as it uses alternate frame scores to boost model power.
```bash
psauron -i spliced_cds.fa -o results.csv
```

### 2. Protein Sequence Assessment
Use the `-p` flag if the input FASTA contains amino acid sequences.
```bash
psauron -i proteins.faa -o results.csv -p
```

### 3. Single-Frame Scoring
To score only the specific in-frame nucleotide sequence (faster but potentially less accurate):
```bash
psauron -i spliced_cds.fa -o results.csv -s
```

### 4. Filtering and Preprocessing
Exclude short sequences (minimum amino acid length) or specific annotations (case-invariant text match) during the run:
```bash
psauron -i input.fa -m 30 -e "hypothetical" -o filtered_results.csv
```

## Expert Tips & Best Practices

*   **Preprocessing with gffread**: PSAURON requires spliced CDS sequences. If you have a GFF/GTF and a reference genome, generate the required input file using gffread:
    `gffread -x CDS_FASTA.fa -g genome.fa input.gff`
*   **Hardware Acceleration**: PSAURON automatically attempts to use a GPU. If you encounter environment issues or want to save GPU resources, force CPU usage with the `-c` flag.
*   **Sensitivity Tuning**:
    *   **In-frame threshold**: Increase `--inframe` (default 0.5) to increase specificity (fewer, higher-confidence hits).
    *   **Out-frame threshold**: Increase `--outframe` (default 0.5) to increase sensitivity (more hits, but potentially more false positives).
*   **Internal Stop Codons**: PSAURON ignores internal stop codons. While a high score indicates a protein-like coding pattern, it does not strictly guarantee a valid, uninterrupted ORF.
*   **Verbose Output**: Use `-v` to see progress bars, which is helpful for large multi-fasta files.

## Reference documentation
- [PSAURON GitHub Repository](./references/github_com_salzberg-lab_PSAURON.md)
- [Bioconda PSAURON Overview](./references/anaconda_org_channels_bioconda_packages_psauron_overview.md)