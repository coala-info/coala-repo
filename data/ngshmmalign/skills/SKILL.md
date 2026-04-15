---
name: ngshmmalign
description: This tool aligns Next-Generation Sequencing reads to a reference genome using profile Hidden Markov Models. Use when user asks to align NGS reads to small, highly variable genomes, or needs sensitive alignments that account for significant indels and point mutations.
homepage: https://github.com/cbg-ethz/ngshmmalign
metadata:
  docker_image: "quay.io/biocontainers/ngshmmalign:0.1.1--0"
---

# ngshmmalign

Aligns Next-Generation Sequencing (NGS) reads to a reference genome using profile Hidden Markov Models (HMMs).
  This tool is particularly useful for small, rapidly evolving genomes (e.g., RNA viruses like HIV-1 and HCV)
  that exhibit substantial biological insertions and deletions, where traditional aligners may produce artifacts.
  Use when:
  - Aligning NGS reads to small, highly variable genomes.
  - Needing sensitive alignments that account for significant indels and point mutations.
  - Working with RNA viruses like HIV-1 and HCV.
  - Requiring alignments that are more amenable to downstream studies of viral evolution and diversity.
body: |
  ## Overview
  ngshmmalign is a specialized aligner that employs profile Hidden Markov Models (HMMs) to achieve more sensitive alignments of NGS reads, especially for genomes that undergo rapid evolution and accumulate many mutations, such as RNA viruses. Unlike standard aligners that might struggle with high indel rates, ngshmmalign is designed to handle these variations more robustly, producing alignments that are better suited for detailed evolutionary and genetic studies.

  ## Usage

  ngshmmalign performs a glocal alignment (global-to-local) similar to the Needleman-Wunsch algorithm. It can estimate profile HMM parameters from multiple windows using local multiple sequence alignments (e.g., with MAFFT) or accept a FASTA file as a reference.

  ### Core Command Structure

  The general command structure involves specifying input reads, a reference, and output options.

  ```bash
  ngshmmalign [options] <reads_file> <reference_file_or_msa> <output_sam_file>
  ```

  ### Key Options and Best Practices

  *   **Input Reads**:
      *   Supports single-end or paired-end reads.
      *   Input files are typically in FASTQ format.

  *   **Reference**:
      *   Can be a single reference sequence in FASTA format.
      *   Can also be a multiple sequence alignment (MSA) in FASTA format, which ngshmmalign can use to estimate profile HMM parameters.

  *   **Output**:
      *   Outputs alignments in a fully compliant SAM file.
      *   The SAM file passes Picard validation.

  *   **Parameter Estimation**:
      *   `--estimate-params`: Enables parameter estimation from the reference/MSA.
      *   `--mafft-path <path>`: Specify the path to the MAFFT executable if it's not in your PATH, for estimating HMM parameters.
      *   `--subsample <N>`: Use a subsample of `N` reads for parameter estimation.

  *   **Alignment Strategy**:
      *   `--random-seed <int>`: Specify a seed for the random number generator to make alignments deterministic and reproducible. If not provided, an optimal alignment is chosen randomly. This is particularly useful for homopolymer regions where deterministic aligners might produce suboptimal results.
      *   `--template-len-cutoff <float>`: Filter out templates that are too long, using a 3-sigma cutoff.

  *   **Output Tags**:
      *   `--write-nm`: Writes the NM:i: tag (number of mismatches/edit distance), accounting for ambiguous bases.
      *   `--use-x-for-mismatches`: Writes the CIGAR using 'X' for mismatches, consistent with the NM:i: tag.
      *   `--write-md`: Writes the MD:Z: tag correctly for reference-free analysis.

  *   **Filtering**:
      *   `--filter-paired-end`: Filters likely invalid paired-end read configurations.

  *   **Parallelization**:
      *   The tool is fully parallelized using OpenMP. Ensure your compiler supports it (GCC 5+ or Clang 3.7+ recommended).

  ### Example Workflow

  1.  **Parameter Estimation and Alignment**:
      If you have a reference genome and want ngshmmalign to estimate its profile HMM parameters:

      ```bash
      ngshmmalign --estimate-params --mafft-path /path/to/mafft --subsample 1000 reads.fastq reference.fasta alignment.sam
      ```

  2.  **Alignment with Pre-defined MSA Reference**:
      If you have an MSA of related sequences and want to use it as a reference:

      ```bash
      ngshmmalign reads.fastq alignment_msa.fasta alignment.sam
      ```

  3.  **Reproducible Alignment**:
      To ensure reproducible results, especially for studies sensitive to homopolymer regions:

      ```bash
      ngshmmalign --random-seed 123 reads.fastq reference.fasta alignment_reproducible.sam
      ```

  ### Expert Tips

  *   **Homopolymer Sensitivity**: Leverage the `--random-seed` option when dealing with homopolymer regions, as ngshmmalign's probabilistic approach can yield more biologically relevant alignments than deterministic methods.
  *   **MSA Input**: Providing an MSA as input can lead to more accurate parameter estimation if your reference genome has closely related variants.
  *   **SAM Output**: The generated SAM files are designed to be compatible with downstream tools like Picard for validation and further processing.
  *   **Compilation**: Ensure you have a C++11 compliant compiler (GCC 4.8+, Clang 3.7+) and Boost (>= 1.50) installed for successful compilation and multi-threading.

## Reference documentation
- [ngshmmalign GitHub repository overview](./github_com_cbg-ethz_ngshmmalign.md)