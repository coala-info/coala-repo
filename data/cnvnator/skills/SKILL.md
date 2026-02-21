---
name: cnvnator
description: CNVnator is a powerful tool for identifying structural variants by analyzing the depth of coverage (read depth) across the genome.
homepage: https://github.com/abyzovlab/CNVnator
---

# cnvnator

## Overview

CNVnator is a powerful tool for identifying structural variants by analyzing the depth of coverage (read depth) across the genome. It utilizes a mean-shift approach to partition the signal and is highly effective for whole-genome sequencing (WGS) data. The tool operates through a specific sequence of commands that process data into a ROOT-based format, calculates statistics, and identifies regions of significant copy number change. Use this skill to navigate the mandatory pipeline steps, select appropriate bin sizes for your data's coverage, and interpret the resulting variant calls.

## Core Workflow

Running CNVnator requires a sequential execution of five primary steps. All steps must use the same `-root` file and the same bin size (except for the extraction step).

### 1. Extract Read Mapping
Convert your alignment data (BAM/SAM) into the CNVnator ROOT format.
```bash
# Extract all chromosomes (requires ~7GB RAM)
cnvnator -root sample.root -tree sample.bam

# Extract specific chromosomes to save memory
cnvnator -root sample.root -tree sample.bam -chrom 1 2 3 4
```
*Note: Chromosome names must exactly match the BAM header (e.g., "chr1" vs "1").*

### 2. Generate Histograms
Create read depth histograms. You must provide a directory containing individual chromosome FASTA files or a single genome FASTA.
```bash
cnvnator -root sample.root -his 1000 -d /path/to/chromosomes/
```
*Tip: Ensure FASTA files are named as `chr1.fa`, `chr2.fa`, etc., inside the directory.*

### 3. Calculate Statistics
Generate the necessary statistics for the signal partitioning.
```bash
cnvnator -root sample.root -stat 1000
```

### 4. Signal Partitioning
The most computationally intensive step where the tool segments the RD signal.
```bash
cnvnator -root sample.root -partition 1000
```

### 5. Call CNVs
Identify the final deletions and duplications.
```bash
cnvnator -root sample.root -call 1000 > cnvs.txt
```

## Expert Tips and Best Practices

### Bin Size Selection
The `-his`, `-stat`, `-partition`, and `-call` steps require a bin size. Choosing the right size is critical for sensitivity and specificity:
- **High Coverage (e.g., >100x):** Use 100 bp.
- **Standard WGS (e.g., 20x - 30x):** Use 500 bp or 1000 bp.
- **Low Coverage:** Use larger bins (e.g., 2000+ bp) to reduce noise.

### Output Interpretation
The output columns in the `.txt` file are:
1. **CNV_type**: `deletion` or `duplication`.
2. **Coordinates**: `chr:start-end`.
3. **CNV_size**: Length of the variant.
4. **Normalized_RD**: Read depth relative to the average (1.0 is normal).
5. **e-val1**: T-test significance.
6. **q0**: Fraction of reads with zero mapping quality (high q0 suggests repetitive regions/potential false positives).

### Genotyping Known Regions
If you have a list of specific coordinates and want to determine their copy number:
```bash
cnvnator -root sample.root -genotype 1000
# Then enter coordinates manually or pipe them:
# echo "1:1000000-1050000" | cnvnator -root sample.root -genotype 1000
```

### Merging and Managing Data
- **List Content**: Use `-ls` to see what data (trees, histograms) is inside a `.root` file: `cnvnator -root sample.root -ls`
- **Merging Samples**: To combine multiple BAMs for a single analysis, list them all in the `-tree` command: `cnvnator -root combined.root -tree file1.bam file2.bam file3.bam`

## Reference documentation
- [CNVnator GitHub README](./references/github_com_abyzovlab_CNVnator.md)
- [CNVnator Wiki](./references/github_com_abyzovlab_CNVnator_wiki.md)