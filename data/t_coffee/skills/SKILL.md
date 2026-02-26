---
name: t_coffee
description: "t_coffee computes, evaluates, and manipulates multiple sequence alignments for DNA, RNA, protein sequences, and structures. Use when user asks to generate multiple sequence alignments, evaluate alignment quality, refine existing alignments, or work with various sequence and structural data."
homepage: https://github.com/jashkenas/coffee-script-tmbundle
---


# t_coffee

Tools for Computing, Evaluating, and Manipulating Multiple Alignments of DNA, RNA, Protein Sequences, and Structures.
  Use when Claude needs to perform complex sequence alignment tasks, including:
  - Generating multiple sequence alignments (MSAs).
  - Evaluating the quality of existing alignments.
  - Manipulating and refining alignments.
  - Working with various sequence types (DNA, RNA, protein) and structural data.
---
## Overview

t_coffee is a powerful suite of tools designed for advanced bioinformatics tasks, specifically focusing on the computation, evaluation, and manipulation of multiple sequence alignments (MSAs). It supports various biological sequence types, including DNA, RNA, and proteins, and can also handle structural data. This skill is for users who need to perform sophisticated alignment operations beyond basic pairwise alignment.

## Usage Instructions

t_coffee offers a wide range of functionalities accessible via its command-line interface. The core operations revolve around generating, refining, and assessing MSAs.

### Core Commands and Options

The primary executable is `t_coffee`. Here are some common patterns and options:

*   **Generating a Multiple Sequence Alignment (MSA):**
    The most basic usage involves providing input sequences. t_coffee can accept sequences in various formats (e.g., FASTA).

    ```bash
    t_coffee input_sequences.fasta
    ```

*   **Specifying Alignment Methods:**
    t_coffee can leverage different underlying alignment algorithms. You can specify these using the `-method` option. Common methods include `tree`, `linsi`, `msa`, `clustalw`, `muscle`, `kalign`, `probcons`, `mafft`.

    ```bash
    t_coffee input_sequences.fasta -method tree
    t_coffee input_sequences.fasta -method mafft
    ```

*   **Refining Existing Alignments:**
    If you have an existing alignment, t_coffee can be used to refine it.

    ```bash
    t_coffee existing_alignment.aln -refine
    ```

*   **Evaluating Alignment Quality:**
    t_coffee provides metrics to assess the quality of an MSA.

    ```bash
    t_coffee alignment.aln -evaluate
    ```

*   **Output Formats:**
    You can specify the output format using the `-output` option. Common formats include `fasta`, `aln` (ClustalW format), `phylip`, `stockholm`.

    ```bash
    t_coffee input_sequences.fasta -output fasta
    ```

*   **Using Pre-computed Profiles:**
    For faster alignment of large datasets, you can use pre-computed profiles.

    ```bash
    t_coffee input_sequences.fasta -profile profile.prf
    ```

*   **Interactive Mode:**
    t_coffee can also be run in an interactive mode for more guided alignment construction.

    ```bash
    t_coffee -interactive
    ```

### Expert Tips

*   **Sequence Quality:** Ensure your input sequences are clean and in a supported format (e.g., FASTA). Ambiguous characters (like 'N' in DNA or 'X' in proteins) can affect alignment accuracy.
*   **Method Selection:** The choice of alignment method (`-method`) is crucial and depends on the dataset size, sequence similarity, and desired accuracy. For large datasets, faster methods like `kalign` or `mafft` are often preferred. For highly divergent sequences, methods like `probcons` or `clustalw` might yield better results. Experimentation is key.
*   **Parameter Tuning:** Many underlying alignment tools have their own parameters that t_coffee can pass through. Consult the t_coffee documentation for advanced options to fine-tune specific alignment algorithms.
*   **Computational Resources:** Generating MSAs, especially for large datasets or using computationally intensive methods, can require significant CPU and memory resources. Consider running t_coffee on a cluster or high-performance computing environment.
*   **Post-processing:** After generating an alignment, it's often beneficial to evaluate its quality using the `-evaluate` option or other bioinformatics tools to ensure biological relevance.

## Reference documentation
- [t_coffee Overview](./references/anaconda_org_channels_bioconda_packages_t_coffee_overview.md)