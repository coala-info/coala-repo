---
name: bitseq
description: "BitSeq uses a probabilistic framework to estimate transcript-level expression and differential expression from RNA-seq data. Use when user asks to parse alignments, estimate transcript expression using MCMC or Variational Bayes, perform differential expression analysis, or calculate posterior probabilities of log ratios."
homepage: https://github.com/BitSeq/BitSeq
---


# bitseq

## Overview
BitSeq (Bayesian Inference of Transcripts from SEQuencing data) is a specialized toolset for analyzing RNA-seq data at the transcript level. Unlike simple counting methods, BitSeq uses a probabilistic framework to account for the uncertainty of reads mapping to multiple transcripts. It provides two primary paths for expression estimation: a highly accurate Markov Chain Monte Carlo (MCMC) sampler and a faster Variational Bayes (VB) approximation. The workflow typically involves parsing alignments, estimating expression for individual samples, and then performing differential expression analysis across conditions.

## Installation and Setup
BitSeq must be compiled from source. It requires `g++`, `make`, and `zlib`.

1.  **Compilation**:
    ```bash
    make
    ```
    For macOS users, a specific Makefile is provided: `make -f Makefile.mac`.

2.  **Dependencies**: Ensure `samtools` is available if working with BAM files, as `parseAlignment` relies on the samtools API.

## Core Workflow and CLI Patterns

### 1. Pre-processing and Alignment Parsing
Before estimation, transcript information must be extracted and alignments must be converted into BitSeq's internal format.

*   **Extract Transcript Info**: Use `extractTranscriptInfo.py` to process a GTF file and create a transcript information file required by the estimators.
*   **Parse Alignments**: Convert SAM/BAM files into a `.prob` file.
    ```bash
    ./parseAlignment input.bam -o output.prob
    ```
    *   **Expert Tip**: Use the `--saveAlignmentProbs` (or `phi` in older versions) flag if you need to output the specific probabilities of reads mapping to transcripts for downstream custom analysis.

### 2. Expression Estimation
BitSeq provides two main engines for quantification.

*   **Variational Bayes (Fast)**: Use `estimateVBExpression` for quick results.
    ```bash
    ./estimateVBExpression output.prob -o sample_vb
    ```
*   **Gibbs Sampling (MCMC - Robust)**: Use `estimateExpression` for a more thorough exploration of the posterior distribution.
    ```bash
    ./estimateExpression output.prob -o sample_mcmc
    ```
    *   **Note**: This produces `.thetaMeans` (mean expression) and `.rpkm` files.

### 3. Differential Expression (DE) Analysis
DE analysis is performed by comparing the posterior distributions of two or more conditions.

*   **Estimate DE**: Use `estimateDE` to compare samples.
    ```bash
    ./estimateDE -o condition_comparison sample1.thetaMeans sample2.thetaMeans
    ```
*   **Calculate PPLR**: The Posterior Probability of Log Ratio (PPLR) is the primary metric for significance in BitSeq.
    ```bash
    ./getPPLR -o results.pplr condition_comparison.est
    ```

## Common Utility Patterns
*   **Gene-level Analysis**: While BitSeq is transcript-centric, use `getGeneExpression` to aggregate transcript-level estimates to the gene level.
*   **Sample Conversion**: Use `convertSamples` to transform raw posterior samples into different formats or scales (e.g., log-scale).
*   **GTF Manipulation**: Use `gtftool` for specific operations on GTF files, such as extracting unspliced gene sequences or handling Ensembl/GENCODE specific formatting.

## Expert Tips
*   **Handling Multi-mapping**: BitSeq's strength is multi-mapping. Ensure your aligner (like Bowtie or STAR) is configured to report all valid alignments (e.g., `bowtie -a`) to provide `parseAlignment` with the full set of mapping possibilities.
*   **Memory Management**: For very large datasets, `transposeLargeFile` can be used to reorient data files for more efficient processing by the DE estimators.
*   **Convergence Checking**: When using MCMC (`estimateExpression`), always check the log files for R-hat values or use `getVariance` to ensure the chains have converged.

## Reference documentation
- [BitSeq GitHub Repository](./references/github_com_BitSeq_BitSeq.md)
- [BitSeq Wiki Home](./references/github_com_BitSeq_BitSeq_wiki.md)
- [BitSeq Issue Tracker (Usage Notes)](./references/github_com_BitSeq_BitSeq_issues.md)