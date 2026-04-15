---
name: orthofisher
description: Orthofisher automates gene identification and retrieval for phylogenomics and evolutionary biology analyses. Use when user asks to identify and retrieve orthologous genes from genomic data.
homepage: https://github.com/JLSteenwyk/orthofisher.git
metadata:
  docker_image: "quay.io/biocontainers/orthofisher:1.1.1--pyhdfd78af_0"
---

# orthofisher

orthofisher/SKILL.md
---
name: orthofisher
description: |
  Automates gene identification and retrieval for phylogenomics, gene family copy number determination, and related evolutionary biology analyses. Use when Claude needs to perform automated ortholog identification and retrieval from genomic data.
---

## Overview

Orthofisher is a powerful command-line tool designed for the automated identification and retrieval of orthologous genes. It is particularly useful for large-scale phylogenomic studies, determining gene family copy numbers, and other evolutionary biology analyses. Orthofisher leverages HMMER to search for predefined sets of orthologs within your sequence data.

## Usage Instructions

Orthofisher is designed to be run from the command line. The core functionality involves providing it with a list of HMM profiles and a set of target sequences.

### Installation

Orthofisher can be installed via conda or pip. It is recommended to install within a virtual environment to manage dependencies.

**Using Conda:**
```bash
conda install -c jlsteenwyk orthofisher
```

**Using Pip:**
```bash
pip install orthofisher
```

**From Source:**
```bash
git clone https://github.com/JLSteenwyk/orthofisher.git
cd orthofisher/
make install
```

### Prerequisites

Before installing orthofisher, ensure that HMMER3 is installed and its binaries are added to your system's PATH.

### Running Orthofisher

The basic command structure for running orthofisher is:

```bash
orthofisher -m <hmms.txt> -f <fasta_arg.txt> [options]
```

- `-m hmms.txt`: Path to a text file containing the HMM profiles to search for.
- `-f fasta_arg.txt`: Path to a FASTA file containing the sequences to search within.

### Key Options and Patterns

*   **Sequence Type Specification:**
    By default, orthofisher attempts to infer the sequence type (nucleotide or amino acid) from the HMM's ALPH header. For explicit control, use the `--seq-type` flag:
    ```bash
    # Query nucleotide sequences with nucleotide HMMs
    orthofisher -m hmm_nucl.txt -f fasta_nucl.txt --seq-type nucleotide

    # Query amino acid sequences with amino acid HMMs (default behavior for non-DNA/RNA ALPH headers)
    orthofisher -m hmm_aa.txt -f fasta_aa.txt --seq-type amino-acid
    ```

*   **Verbose Output:**
    To obtain detailed raw output files (e.g., `all_sequences/` and `hmmsearch_output/`), use the `--verbose-output` flag:
    ```bash
    orthofisher -m hmms.txt -f fasta_arg.txt --verbose-output
    ```

*   **Overwriting Output Directory:**
    If the specified output directory already exists, orthofisher will stop with an error. To overwrite an existing directory, use the `--force` flag:
    ```bash
    orthofisher -m hmms.txt -f fasta_arg.txt --force
    ```

*   **Resuming Interrupted Runs:**
    To continue an interrupted run in an existing output directory, use the `--resume` flag. This reuses checkpoint state, skips completed pairs, and rewrites the summary files:
    ```bash
    orthofisher -m hmms.txt -f fasta_arg.txt -o orthofisher_output --resume
    ```

*   **Combining Flags:**
    You can combine multiple flags for comprehensive control:
    ```bash
    orthofisher -m hmms.txt -f fasta_arg.txt --verbose-output --force
    ```

### Output Structure

By default, orthofisher produces a "slim" output, including:
*   `scog/` (directory for single-copy orthologs)
*   `long_summary.txt`
*   `short_summary.txt`

When `--verbose-output` is used, additional directories like `all_sequences/` and `hmmsearch_output/` will be generated.

## Expert Tips

*   **Virtual Environments:** Always use a virtual environment (e.g., `venv` or `conda env`) for installation to prevent dependency conflicts. Activate the environment before running orthofisher.
*   **HMMER Installation:** Ensure HMMER3 is correctly installed and its executables are in your system's PATH. This is a critical prerequisite.
*   **Input File Preparation:** Carefully prepare your `hmms.txt` and `fasta_arg.txt` files. Ensure correct formatting and that the HMM profiles are compatible with the sequences in your FASTA file.
*   **Performance:** Orthofisher is designed for high-throughput analysis and has been shown to have near-perfect performance compared to tools like BUSCO.

## Reference documentation

- [Orthofisher README](https://github.com/JLSteenwyk/orthofisher.md)
- [Orthofisher Installation and Usage](https://jlsteenwyk.com/orthofisher/)
---