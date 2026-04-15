---
name: sina
description: SINA is a tool for reference-based multiple sequence alignment that allows incorporating additional sequences into an existing alignment without modification. Use when user asks to add new sequences to an existing multiple sequence alignment, leverage a pre-existing curated MSA to align new sequences, perform homology searches against a reference MSA to classify query sequences, or work with ARB format reference databases.
homepage: https://github.com/epruesse/SINA
metadata:
  docker_image: "quay.io/biocontainers/sina:1.7.2--h9aa86b4_0"
---

# sina

SINA (Sequence Information Navigator and Aligner) is a tool for reference-based multiple sequence alignment.
  It allows incorporating additional sequences into an existing multiple sequence alignment (MSA) without modifying the original alignment.
  This is particularly useful for protecting investments in curated MSAs, phylogenetic trees, and taxonomic annotations.
  SINA also includes a homology search feature for classifying query sequences based on taxonomic information from the reference MSA.
  Use SINA when you need to:
  - Add new sequences to an existing multiple sequence alignment without recomputing the entire alignment from scratch.
  - Leverage a pre-existing, curated MSA (e.g., from SILVA) to align new sequences.
  - Perform homology searches against a reference MSA to classify query sequences.
  - Work with ARB format reference databases.
body: |
  ## Overview

  SINA is a powerful tool for reference-based multiple sequence alignment. Its primary strength lies in its ability to efficiently integrate new sequences into an existing alignment without altering the original, thereby preserving valuable manual curation and downstream analyses like phylogenetic tree construction. It also offers a homology search function that leverages the reference alignment to classify query sequences.

  ## Usage Instructions

  SINA is primarily used via its command-line interface. The core functionality revolves around aligning sequences to a reference database.

  ### Installation

  The recommended installation method is via Bioconda:
  ```bash
  conda create -n sina sina
  conda activate sina
  ```
  Alternatively, self-contained binaries are available for download from the SINA GitHub releases page.

  ### Core Command: `sina`

  The main command for performing alignments is `sina`.

  **Basic Alignment:**

  To align query sequences (`query.fasta`) against a reference database (`reference.fasta` or a pre-built SINA database), use the following structure:

  ```bash
  sina <query_sequences> <reference_database> [options]
  ```

  **Example:**

  ```bash
  sina reads.fasta silva_nr.fasta -o aligned_reads.fasta
  ```

  *   `reads.fasta`: Your input file containing sequences to be aligned.
  *   `silva_nr.fasta`: The reference alignment file or database.
  *   `-o aligned_reads.fasta`: Specifies the output file for the aligned sequences.

  ### Key Options and Patterns

  *   **Output Format**: SINA can output alignments in various formats. The default is typically FASTA. Use the `-o` or `--output` flag to specify the output file.
      ```bash
      sina query.fasta reference.fasta -o output.fasta
      ```

  *   **Reference Database Types**: SINA can work with different types of reference data.
      *   **FASTA/Multi-FASTA**: A simple alignment file can be used directly as a reference.
      *   **ARB Format**: SINA can directly read and write ARB format files, commonly used by the SILVA project.
      *   **Pre-built SINA Databases**: For performance, SINA can utilize pre-built index files. The documentation or installation process will detail how to create or obtain these.

  *   **Homology Search and Classification**: SINA includes a module for homology-based classification. This is often invoked with specific flags or as a separate step depending on the version and intended workflow. The core idea is to use the reference MSA to find the most similar sequences and then infer a taxonomic classification.

      While the exact command for classification might vary, it generally involves providing query sequences and a reference database, and requesting a classification output. Consult the official documentation for the precise command and options for classification.

  *   **Performance and Large Datasets**: SINA is designed for high-throughput. For very large datasets, consider:
      *   Using pre-built SINA index files if available for your reference database.
      *   Ensuring sufficient system resources (RAM, CPU).
      *   Referencing the documentation for any specific optimizations for large-scale alignments.

  *   **Error Handling and Debugging**:
      *   Pay close attention to error messages. They often indicate issues with input file formats, reference database compatibility, or missing dependencies.
      *   The `--verbose` flag (if available) can provide more detailed output for debugging.

  ### Expert Tips

  *   **Reference Database Preparation**: For optimal performance and accuracy, ensure your reference database is in a format SINA efficiently handles (e.g., pre-built index or ARB format if working with SILVA data).
  *   **Understanding Alignment Quality**: SINA's graph-based approach is robust, but always review the quality of alignments, especially in highly variable regions. The documentation for SINA provides insights into its alignment algorithm.
  *   **Leveraging SILVA Data**: SINA is tightly integrated with the SILVA project. If you are working with ribosomal RNA genes, using SILVA-provided reference databases and ARB formats is highly recommended.

  ## Reference documentation
  - [SINA Overview](https://anaconda.org/bioconda/sina)
  - [SINA GitHub Repository](https://github.com/epruesse/SINA)
  - [SINA Documentation](https://sina.readthedocs.io/)