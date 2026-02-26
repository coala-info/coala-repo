---
name: pyani-plus
description: The pyani-plus tool performs whole-genome classification of microbes using Average Nucleotide Identity (ANI) and similar methods. Use when user asks to classify microbial genomes based on sequence similarity, calculate Average Nucleotide Identity (ANI) between genomes, or perform other related whole-genome comparative analyses.
homepage: https://github.com/pyani-plus/pyani-plus
---


# pyani-plus

yaml
name: pyani-plus
description: |
  Performs whole-genome classification of microbes using Average Nucleotide Identity (ANI) and similar methods.
  Use when Claude needs to:
  - Classify microbial genomes based on sequence similarity.
  - Calculate Average Nucleotide Identity (ANI) between genomes.
  - Perform other related whole-genome comparative analyses.
  - Analyze microbial diversity and relatedness.
```
## Overview
The `pyani-plus` tool is designed for classifying microbial genomes by calculating their Average Nucleotide Identity (ANI) and employing similar comparative genomic methods. It's particularly useful for understanding the evolutionary relationships and taxonomic placement of bacterial and archaeal species based on their complete genome sequences.

## Usage Instructions

`pyani-plus` is a command-line tool that can be installed via Conda (from the BioConda channel) or PyPI.

### Core Functionality: Classification and Comparison

The primary command for performing genome classification is `pyani-plus classify`. This command takes one or more FASTA files (or directories containing FASTA files) as input and computes similarity metrics between them.

**Basic Usage:**

```bash
pyani-plus classify <input_directory_or_fasta_files>
```

This will generate similarity matrices and potentially other output files in the current directory.

### Key Commands and Options

*   **`pyani-plus classify`**:
    *   **`--input`**: Path to input FASTA files or a directory containing FASTA files.
    *   **`--output`**: Directory to save output files (similarity matrices, etc.). Defaults to the current directory.
    *   **`--method`**: The comparison method to use. Common options include:
        *   `ani` (Average Nucleotide Identity - default)
        *   `aai` (Average Amino Acid Identity)
        *   `ggdc` (Genome-to-Genome Distance Calculator - requires external installation)
        *   `mash` (MinHash-based similarity - requires `mash` to be installed)
        *   `wani` (Weighted Average Nucleotide Identity)
        *   `gani` (Generalized Average Nucleotide Identity)
    *   **`--scheduler`**: Specifies how to parallelize computations. Options include `sync` (sequential), `multiprocessing`, `slurm`, `pbs`, etc. For local parallelization, `multiprocessing` is often suitable.
    *   **`--workers`**: The number of parallel workers to use when `multiprocessing` or other parallel schedulers are selected.
    *   **`--force`**: Overwrite existing output files if they exist.
    *   **`--verbose`**: Print detailed progress information.

**Example: Classifying genomes in a directory using multiprocessing:**

```bash
pyani-plus classify --input /path/to/genomes/ --output ./results --method ani --scheduler multiprocessing --workers 8 --verbose
```

### Advanced Features and Tips

*   **Input Formats**: `pyani-plus` accepts individual FASTA files or entire directories. Ensure all FASTA files within a directory are genomes you wish to compare.
*   **Output Interpretation**: The primary outputs are typically tab-separated value (TSV) files representing similarity matrices. These matrices show the calculated similarity score between each pair of input genomes.
*   **Dependencies**: Some methods (e.g., `ggdc`, `mash`) require external command-line tools to be installed separately. Ensure these dependencies are met for the chosen method.
*   **Citation**: Please refer to the `CITATIONS` file in the project repository for proper citation guidelines.

## Reference documentation
- [pyANI-plus documentation](https://pyani-plus.github.io/pyani-plus-docs/)