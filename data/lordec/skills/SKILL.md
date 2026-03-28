---
name: lordec
description: LoRDEC is a hybrid error-correction tool that uses accurate short-read sequencing data to correct errors in long-read sequences via a De Bruijn Graph. Use when user asks to correct long reads, build a short-read graph, trim uncorrected regions, or generate read statistics.
homepage: http://www.atgc-montpellier.fr/lordec/
---

# lordec

## Overview
LoRDEC (Long Read De Bruijn Graph Error Correction) is a hybrid tool designed to correct the high error rates typically found in third-generation sequencing data. It works by building a succinct De Bruijn Graph (DBG) from accurate short reads and then traversing paths within that graph to find corrective sequences for the erroneous regions of long reads. This skill provides the necessary command-line patterns to build graphs, correct reads, and perform post-correction trimming.

## Core Workflows

### 1. Error Correction (lordec-correct)
The primary command for correcting long reads. It identifies "weak" regions (those not found in the short-read DBG) and attempts to find a path in the graph to replace them.

**Basic Usage:**
```bash
lordec-correct -2 illumina.fasta -k 19 -s 3 -i pacbio.fasta -o corrected.fasta
```

**Key Parameters:**
- `-2`: Short-read files (FASTA/Q, can be gzipped). Multiple files should be comma-separated.
- `-k`: K-mer size.
- `-s`: Solidity threshold (minimum k-mer occurrences to be considered "correct").
- `-i`: Input long-read file.
- `-o`: Output file for corrected reads.
- `-T`: Number of threads (defaults to all cores).

**Expert Tips for Parameter Selection:**
- **Small Genomes (Bacteria/Yeast):** Use `k=17` or `19` and `s=2` or `3`.
- **Large Genomes (Vertebrates/Plants):** Use `k=21` and `s=2` or `3`.
- **Memory Management:** If processing large datasets, pre-build the graph (see below) to save time on repeated runs.

### 2. Graph Management (lordec-build-SR-graph)
If you plan to run multiple correction attempts with different parameters or on different long-read sets, build the graph once to save significant processing time.

**Build Graph:**
```bash
lordec-build-SR-graph -2 short_reads.fa -k 19 -s 3 -g graph_output.h5
```

**Use Pre-built Graph in Correction:**
```bash
lordec-correct -2 graph_output -k 19 -s 3 -i long_reads.fa -o corrected.fa
```
*Note: When referencing a pre-built graph, omit the `.h5` extension in the `-2` argument.*

### 3. Post-Correction Trimming
LoRDEC outputs corrected regions in **UPPERCASE** and uncorrected regions in **lowercase**. Use trimming tools to remove or split reads based on these regions.

- **Trim ends only:** Removes uncorrected regions from the start and end of reads.
  ```bash
  lordec-trim -i corrected.fasta -o trimmed.fasta
  ```
- **Trim and Split:** Removes all uncorrected regions and splits the long read into multiple sequences where internal regions could not be corrected.
  ```bash
  lordec-trim-split -i corrected.fasta -o trimmed_split.fasta
  ```

### 4. Generating Statistics
To evaluate the quality of the long reads relative to the short-read graph before or after correction:
```bash
lordec-stat -2 short_reads.fa -k 19 -s 3 -i long_reads.fa -S stats_output.txt
```
The output includes the number of solid k-mers, total k-mers, and lengths of solid k-mer runs for each read.

## Best Practices
- **Input Formats:** LoRDEC accepts FASTA and FASTQ. It can handle gzipped short-read files directly.
- **Error Rate:** If the long reads have an extremely high error rate, you can increase the search depth using `-b` (maximum branches, default 200) or `-t` (target k-mers, default 5), though this increases runtime.
- **Complete Search:** Use the `-c` flag in `lordec-correct` if you want to ensure a region is only corrected if all alternative paths in the graph have been explored (more conservative).



## Subcommands

| Command | Description |
|---------|-------------|
| lordec-build-SR-graph | reads the <FASTA/Q file(s)> of short reads, then builds and save their de Bruijn graph for k-mers of length <k-mer size> and occurring at least <abundance threshold> time; the graph is saved in an external file named <out graph file> |
| lordec-correct | Corrects long reads using short reads. |
| lordec-trim | LoRDEC v0.9 |
| lordec-trim-split | Scan a set of corrected long reads (in FASTA format) and output as sequence their regions that have indeed been corrected (which are in uppercase). |

## Reference documentation
- [LoRDEC Overview and Usage](./references/www_atgc-montpellier_fr_lordec.md)
- [LoRDEC 0.6 README](./references/www_atgc-montpellier_fr_lordec_README.org.md)