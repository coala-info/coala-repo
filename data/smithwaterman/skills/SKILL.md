---
name: smithwaterman
description: "Performs local sequence alignment using the Smith-Waterman-Gotoh algorithm. Use when user asks to find local similarities between two biological sequences."
homepage: https://github.com/ekg/smithwaterman
---


# smithwaterman

Performs sequence alignment using the Smith-Waterman-Gotoh algorithm.
  Use when Claude needs to find local similarities between two biological sequences (DNA, RNA, or protein).
  This skill is suitable for tasks such as identifying homologous regions, gene finding, or protein domain analysis.
body: |
  ## Overview
  The smithwaterman tool implements the Smith-Waterman-Gotoh algorithm for local sequence alignment. It is designed to find regions of similarity between two sequences, which is crucial for tasks in bioinformatics like identifying homologous genes or protein domains. This skill provides direct command-line interface usage instructions for the smithwaterman executable.

  ## Usage
  The primary command for using the smithwaterman tool is `smithwaterman`. It requires two input sequences and can be configured with various parameters to control the alignment process.

  ### Basic Alignment
  To perform a basic local alignment between two sequences, provide the sequences as arguments. The tool will output the alignment score and the aligned sequences.

  ```bash
  smithwaterman <sequence1> <sequence2>
  ```

  ### Inputting Sequences from Files
  For longer sequences, it is recommended to provide them via input files. The tool expects sequences in a FASTA-like format.

  ```bash
  smithwaterman --seq1 <path/to/sequence1.fasta> --seq2 <path/to/sequence2.fasta>
  ```

  ### Key Parameters

  *   `--seq1 <path>`: Path to the first input sequence file (FASTA format).
  *   `--seq2 <path>`: Path to the second input sequence file (FASTA format).
  *   `--match <score>`: Score for a match (default: 2).
  *   `--mismatch <score>`: Penalty for a mismatch (default: -1).
  *   `--gap <score>`: Penalty for opening a gap (default: -2).
  *   `--extend <score>`: Penalty for extending a gap (default: -1).
  *   `--band <width>`: Width of the banded alignment matrix. This can significantly speed up computation for highly similar sequences by reducing the search space.
  *   `--output <path>`: Path to save the alignment results. If not specified, output goes to stdout.
  *   `--verbose`: Enable verbose output, showing more details about the alignment process.

  ### Example: Aligning two DNA sequences with custom scoring
  This example demonstrates aligning two DNA sequences using custom scoring parameters for matches, mismatches, and gaps.

  ```bash
  smithwaterman --seq1 dna1.fasta --seq2 dna2.fasta --match 3 --mismatch -2 --gap -4 --extend -1
  ```

  ### Example: Using banding for faster alignment
  If you expect high similarity between sequences, using the `--band` option can improve performance.

  ```bash
  smithwaterman --seq1 protein1.fasta --seq2 protein2.fasta --band 10
  ```

  ### Output Format
  The default output includes the alignment score, followed by the aligned sequences in a pairwise alignment format. When using `--verbose`, additional information about the alignment parameters and process may be displayed.

  ## Best Practices and Expert Tips

  *   **Sequence Format**: Ensure your input sequences are in a standard FASTA format. Each sequence should start with a header line (e.g., `>sequence_name`) followed by the sequence data on subsequent lines.
  *   **Scoring Matrix**: Carefully choose your scoring parameters (`--match`, `--mismatch`, `--gap`, `--extend`). These values significantly influence the alignment results. For protein sequences, consider using established substitution matrices like BLOSUM or PAM, although this tool does not directly support them as input; you would need to translate these into numerical scores.
  *   **Banding**: Utilize the `--band` option for sequences that are expected to be highly similar. This can drastically reduce computation time. Experiment with different band widths to find an optimal balance between speed and sensitivity.
  *   **Verbose Output**: Use `--verbose` when debugging or when you need a deeper understanding of the alignment process and parameters used.
  *   **Output Redirection**: For long alignments or when integrating into scripts, redirect the output to a file using the `--output` option or shell redirection (`>`).

  ## Reference documentation
  - [Smith-Waterman-Gotoh alignment algorithm overview](./references/github_com_ekg_smithwaterman.md)
  - [Smith-Waterman-Gotoh alignment algorithm installation](./references/anaconda_org_channels_bioconda_packages_smithwaterman_overview.md)