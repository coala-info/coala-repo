---
name: smartmap
description: SmartMap provides a probabilistic approach to reweight and assign multi-mapping sequencing reads using alignment scores and local genomic context. Use when user asks to resolve multi-mapping reads, perform Bayesian reweighting of alignments, or generate weighted BedGraph files for DNA-seq and RNA-seq data.
homepage: http://shah-rohan.github.io/SmartMap
metadata:
  docker_image: "quay.io/biocontainers/smartmap:1.0.0--h077b44d_4"
---

# smartmap

## Overview
SmartMap provides a probabilistic approach to multi-mapping reads. Instead of discarding reads that align to multiple genomic locations or picking one at random, it uses alignment scores and local genomic context to iteratively reweight each alignment. The workflow typically involves three stages: alignment and preprocessing (using `SmartMapPrep` or `SmartMapRNAPrep`), followed by the core Bayesian assignment (using the `SmartMap` binary) to generate weighted BedGraph files.

## Workflow and CLI Usage

### 1. Preprocessing (Alignment & BED Generation)
Use these scripts to align FASTQ files and format them for the reweighting algorithm.

**For DNA-seq (ChIP-seq, ATAC-seq, MNase-seq):**
Uses Bowtie2.
```bash
SmartMapPrep -x [BT2_INDEX] -o [PREFIX] -1 [R1.fastq.gz] -2 [R2.fastq.gz] -p [THREADS] -k 51
```
*   `-k`: Maximum alignments to report (default 51). Increase for highly repetitive genomes.
*   `-I` / `-L`: Set minimum/maximum insert sizes (default 100-250).

**For RNA-seq (Strand-specific):**
Uses Hisat2.
```bash
SmartMapRNAPrep -x [HISAT2_INDEX] -o [PREFIX] -1 [R1.fastq.gz] -2 [R2.fastq.gz] -p [THREADS]
```

### 2. Bayesian Reweighting (Core Tool)
Run the `SmartMap` binary on the `.bed` or `.bed.gz` files generated in the previous step.

**Standard Command:**
```bash
SmartMap -g [GENOME_CHROMSIZES] -o [OUTPUT_PREFIX] [INPUT_BEDS...]
```

**Common Options:**
*   `-i [INT]`: Number of iterations. 1 is standard; 10 is used for maximum refinement.
*   `-S`: **Crucial** for RNA-seq; enables strand-specific output.
*   `-m [INT]`: Max alignments per read to process (default 50). Should match or exceed the `-k` parameter used in Prep.
*   `-c`: Generates continuous BedGraph files (fills in zeros).
*   `-l [FLOAT]`: Rate of fitting (default 1.0). Use lower values (e.g., 0.25) for "slow fitting" to prevent over-fitting in complex regions.

### 3. Output Interpretation
*   **Standard:** Produces a `.bedgraph.gz` file where the score represents the weighted coverage.
*   **Strand-specific:** Produces two files (one per strand).
*   **Log files:** Check the `.log` output for convergence metrics and alignment distribution statistics.

## Expert Tips
*   **Genome Length File:** The `-g` file must be a tab-delimited list of `chromosome [tab] length`. The order in this file determines the order in the output BedGraph.
*   **Memory Management:** For large datasets with high `-k` values, ensure the system has sufficient RAM, as SmartMap loads alignment metadata into memory to perform iterations.
*   **Single-End Data:** While the binary can process single-end BED files, the `Prep` scripts are hardcoded for paired-end SAM flags (99, 163, 355, 419). For single-end data, manually convert BAM to the extended BED format required by the binary.



## Subcommands

| Command | Description |
|---------|-------------|
| SmartMap | SmartMap for analysis of ambiguously mapping reads in next-generation sequencing. |
| SmartMapPrep | SmartMapPrep prepares input files for SmartMap. |
| SmartMapPrep | SmartMapRNAPrep [options] -x [Bowtie2 index] -o [output prefix] -1 [R1 fastq] -2 [R2 fastq] |

## Reference documentation
- [SmartMap Manual and Documentation](./references/shah-rohan_github_io_SmartMap.md)
- [SmartMap Analysis Workflow](./references/shah-rohan_github_io_SmartMap_analysis.html.md)