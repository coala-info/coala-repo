---
name: elector
description: ELECTOR is a benchmarking framework that evaluates the quality of error correction tools for long-read sequencing data by generating standardized performance metrics. Use when user asks to assess error correction quality, benchmark long-read correction tools, or calculate recall and precision for corrected sequencing reads.
homepage: https://github.com/kamimrcht/ELECTOR
---


# elector

## Overview
ELECTOR (EvaLuator of Error Correction Tools for lOng Reads) is a benchmarking framework designed to assess the quality of error correction in long-read sequencing data. It supports both hybrid and non-hybrid correction methods and works with both simulated data (from tools like NanoSim or SimLord) and real sequencing reads. By aligning corrected reads back to a reference or "perfect" read set, it generates standardized metrics including recall, precision, throughput, and detailed error profiles (insertions, deletions, substitutions).

## Installation
The most reliable way to install ELECTOR is via Bioconda:
```bash
conda install bioconda::elector
```

## Core CLI Usage

### Evaluating Simulated Reads
When using supported simulators (SimLord or NanoSim), ELECTOR can automatically handle the relationship between reads.

```bash
python3 -m elector \
    -reference referenceGenome.fa \
    -uncorrected simulatedReadsPrefix \
    -corrected correctedReads.fa \
    -threads 8 \
    -corrector lordec \
    -simulator simlord \
    -output ./results_dir
```

### Evaluating Real Reads
For real sequencing data, use the `-simulator real` flag. ELECTOR will rely on alignment to the reference genome to generate the necessary reference reads for evaluation.

```bash
python3 -m elector \
    -reference referenceGenome.fa \
    -uncorrected real_uncorrected.fa \
    -corrected real_corrected.fa \
    -threads 16 \
    -simulator real \
    -output ./real_data_eval
```

### Using Perfect Reads Directly
If you already have the "perfect" (error-free) versions of the reads, provide them directly to bypass the simulator-specific logic.

```bash
python3 -m elector \
    -perfect perfectReads.fa \
    -uncorrected uncorrectedReads.fa \
    -corrected correctedReads.fa \
    -threads 4 \
    -output ./direct_eval
```

## Expert Tips and Best Practices

### Handling Split Reads
If the error correction tool you are evaluating trims or splits the original long reads into multiple fragments, you **must** include the `-split` flag. Failure to do so will result in incorrect recall and precision calculations.

### Custom Correctors
ELECTOR has built-in logic for many popular correctors (e.g., Canu, LoRDEC, CONSENT, FMLRC). If you are testing a tool not on the "compatible correctors" list:
1. Omit the `-corrector` parameter.
2. Ensure that the headers in your `correctedReads.fa` are identical to (or contain) the headers of the `uncorrected` and `reference` reads. ELECTOR uses these headers to map corrected segments back to their origin.

### Reference Genome Formatting
Ensure your reference genome file has one sequence per line. While ELECTOR has been updated to handle multi-line FASTA files, single-line sequences are the most stable format for the underlying alignment tools.

### Output Interpretation
The primary output is `summary.pdf` and `log`. Key metrics to watch:
*   **Recall**: Rate of correct bases out of those that actually needed correction.
*   **Precision**: Rate of correct bases out of the total number of modifications made by the tool.
*   **Homopolymer Ratio**: A ratio near 1.0 indicates the corrector is handling homopolymer regions accurately, which is a common challenge for long-read technologies.

## Reference documentation
- [ELECTOR GitHub Repository](./references/github_com_kamimrcht_ELECTOR.md)
- [Bioconda ELECTOR Overview](./references/anaconda_org_channels_bioconda_packages_elector_overview.md)