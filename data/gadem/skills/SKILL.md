---
name: gadem
description: GADEM discovers conserved DNA sequence patterns using a genetic algorithm and an EM algorithm. Use when user asks to identify conserved DNA sequence patterns (motifs) within a set of sequences.
homepage: https://www.niehs.nih.gov/research/resources/software/biostatistics/gadem/index.cfm
metadata:
  docker_image: "quay.io/biocontainers/gadem:1.3.1--h7b50bb2_8"
---

# gadem

gadem/SKILL.md
```yaml
name: gadem
description: |
  Motif discovery tool that uses a Genetic Algorithm guided formation of Spaced Dyads coupled with an EM Algorithm.
  Use when Claude needs to identify conserved DNA sequence patterns (motifs) within a set of sequences, particularly for biological research and sequence analysis.
```
## Overview
GADEM is a powerful bioinformatics tool designed for discovering conserved DNA sequence patterns, known as motifs, within large sets of genetic sequences. It employs a sophisticated approach combining a Genetic Algorithm for identifying spaced dyads (pairs of motifs with a specific distance between them) with an Expectation-Maximization (EM) algorithm for refining motif discovery. This makes it ideal for researchers looking to uncover regulatory elements, binding sites, or other functional patterns in genomic data.

## Usage Instructions

GADEM is primarily used via its command-line interface (CLI). The core functionality involves providing input sequences and specifying parameters to guide the motif discovery process.

### Basic Usage

The most fundamental way to run GADEM is by providing an input FASTA file containing the sequences of interest.

```bash
gadem -i input_sequences.fasta
```

This command will initiate the motif discovery process with default parameters.

### Key Parameters and Options

*   **`-i <input_file>` / `--input <input_file>`**: Specifies the input file containing DNA sequences in FASTA format. This is a mandatory argument.

*   **`-o <output_dir>` / `--output <output_dir>`**: Defines the directory where GADEM will save its output files. If not specified, output will be written to the current directory.

*   **`-m <number>` / `--motifs <number>`**: Sets the number of motifs to search for. The default is typically 2. Increase this number if you suspect multiple distinct motifs are present.

*   **`-s <length>` / `--seqlen <length>`**: Specifies the length of the input sequences. This can be useful for optimizing performance if all sequences are of uniform length.

*   **`-w <length>` / `--width <length>`**: Defines the width (length) of the motifs to be discovered. This is a crucial parameter; if you have prior knowledge about the expected motif size, set it accordingly.

*   **`-d <distance>` / `--distance <distance>`**: Specifies the distance between spaced dyads. This parameter is central to GADEM's unique approach to finding pairs of motifs.

*   **`-e <iterations>` / `--em <iterations>`**: Sets the number of iterations for the Expectation-Maximization (EM) algorithm. More iterations can lead to more refined motif models but increase computation time.

*   **`-g <iterations>` / `--ga <iterations>`**: Sets the number of iterations for the Genetic Algorithm (GA). Similar to the EM algorithm, more GA iterations can improve results but take longer.

*   **`-p <probability>` / `--prior <probability>`**: Sets the prior probability for motif occurrence.

*   **`-v` / `--verbose`**: Enables verbose output, providing more detailed information during the execution of the program.

### Expert Tips for Motif Discovery

1.  **Start with a reasonable number of motifs (`-m`)**: If you are unsure, start with a small number (e.g., 2-3) and gradually increase it if the results are not satisfactory or if you suspect more complex regulatory regions.
2.  **Experiment with motif width (`-w`)**: The `width` parameter is critical. If you have an idea of the typical length of your target motifs, set this parameter accordingly. If not, try a range of values.
3.  **Leverage spaced dyad discovery (`-d`)**: GADEM's strength lies in finding spaced dyads. If you hypothesize that two related motifs co-occur with a specific spacing, tune the `-d` parameter.
4.  **Iterative refinement**: For challenging datasets, consider increasing the number of iterations for both the Genetic Algorithm (`-g`) and the EM algorithm (`-e`). Monitor the output to see if convergence is improving.
5.  **Input quality matters**: Ensure your input FASTA file is clean, contains only relevant sequences, and is correctly formatted. Remove any non-biological sequences or artifacts.
6.  **Output interpretation**: GADEM typically outputs motif logos and position weight matrices (PWMs). Familiarize yourself with these representations to interpret the discovered motifs effectively. The output directory will contain detailed information for each discovered motif.

## Reference documentation
- [GADEM Overview](https://www.niehs.nih.gov/research/resources/software/biostatistics/gadem/index.cfm)
- [GADEM on Bioconda](https://anaconda.org/bioconda/gadem)