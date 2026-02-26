---
name: lordec
description: "LoRDEC is a hybrid error-correction tool that uses short-read de Bruijn graphs to fix errors in long-read sequencing data. Use when user asks to correct errors in long reads, build a de Bruijn graph from short reads, or trim and split corrected reads."
homepage: http://www.atgc-montpellier.fr/lordec/
---


# lordec

## Overview

LoRDEC (Long Read Error Correction) is a hybrid tool designed to fix high error rates in 3rd generation sequencing data. It builds a succinct de Bruijn Graph (DBG) from accurate short reads and uses it to find corrective paths for erroneous regions in long reads. It is particularly effective for handling insertions and deletions common in PacBio data. Use this skill to perform error correction, generate k-mer statistics, or trim corrected reads to remove remaining weak regions.

## Core Workflows

### Error Correction

The primary command is `lordec-correct`. It requires a short-read set (reference) and a long-read set (target).

```bash
lordec-correct -2 <short_reads.fq> -k <kmer_size> -s <abundance_threshold> -i <long_reads.fa> -o <output.fa>
```

**Key Parameters:**
- `-2`: Short read files (FASTA/Q, can be gzipped). Multiple files should be comma-separated.
- `-k`: K-mer length.
- `-s`: Solidity threshold (minimum occurrences for a k-mer to be considered "correct").
- `-i`: Long read file to be corrected.
- `-o`: Output file for corrected reads.

**Parameter Heuristics:**
- **Small Genomes (Bacteria/Small Eukaryotes):** Use `k=17` or `19` and `s=2` or `3`.
- **Large Genomes:** Use `k=21` and `s=2` or `3`.

### Post-Correction Trimming

LoRDEC outputs corrected reads in FASTA format where **uppercase** letters represent corrected/solid nucleotides and **lowercase** letters represent uncorrected/weak nucleotides.

1. **Basic Trimming**: Removes weak regions only from the ends of the reads.
   ```bash
   lordec-trim -i corrected_reads.fa -o trimmed_reads.fa
   ```

2. **Split Trimming**: Removes all weak regions and splits the long read into multiple solid fragments.
   ```bash
   lordec-trim-split -i corrected_reads.fa -o split_reads.fa
   ```

### Performance Optimization

For large datasets or iterative testing, pre-build the de Bruijn Graph to save time.

1. **Build and Save Graph**:
   ```bash
   lordec-build-SR-graph -2 illumina.fasta -k 19 -s 3 -g graph_output.h5
   ```

2. **Run Correction using Saved Graph**:
   Pass the HDF5 file (without the `.h5` extension) to the `-2` parameter.
   ```bash
   lordec-correct -2 graph_output -k 19 -s 3 -i pacbio.fasta -o corrected.fasta
   ```

## Expert Tips and Best Practices

- **Thread Management**: Use `-T <number>` to specify threads. By default, LoRDEC attempts to use all available cores.
- **Memory Efficiency**: LoRDEC is designed to be memory-efficient and can run on standard servers or high-end desktops even for eukaryotic genomes.
- **Input Formats**: While the output is always FASTA, the input can be FASTA or FASTQ, and reference short reads can be compressed (.gz).
- **Log Redirection**: When running `lordec-correct`, redirect stderr to a log file (`&> lordec.log`) to capture progress and statistics without cluttering the terminal.
- **Complete Search**: Use the `-c` or `--complete_search` flag if you require a weak region to be corrected only if all alternative paths in the graph have been explored.

## Reference documentation
- [LoRDEC Home and Usage](./references/www_atgc-montpellier_fr_lordec.md)
- [LoRDEC README](./references/www_atgc-montpellier_fr_lordec_README.org.md)