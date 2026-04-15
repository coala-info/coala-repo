---
name: ibdmix
description: IBDmix detects archaic admixture in modern human populations using a probabilistic approach that does not require a modern reference population. Use when user asks to identify introgressed regions, merge archaic and modern VCF files, or filter archaic segments based on LOD scores and length.
homepage: https://github.com/PrincetonUniversity/IBDmix
metadata:
  docker_image: "quay.io/biocontainers/ibdmix:1.0.1--h4ac6f70_2"
---

# ibdmix

## Overview
IBDmix is a specialized tool for detecting archaic admixture in modern human populations. Unlike traditional methods that require a "clean" modern reference population to identify non-native segments, IBDmix employs a novel probabilistic approach to identify introgressed regions based on genotype patterns. The workflow typically involves merging archaic and modern VCF files, running the detection algorithm, and then filtering the results based on length and Log-Odds (LOD) scores.

## Installation and Setup
The easiest way to install IBDmix is via Bioconda:
```bash
conda install bioconda::ibdmix
```
Alternatively, build from source using CMake (requires version 3.14+):
```bash
git clone https://github.com/PrincetonUniversity/IBDmix.git
cd IBDmix && mkdir build && cd build
cmake .. && cmake --build .
```
The executables `generate_gt` and `ibdmix` will be located in `build/src`.

## Core Workflow

### 1. Prepare Genotype Data
Use `generate_gt` to merge archaic and modern VCF files into the required internal format.
- **Requirement**: Input VCFs must be uncompressed text.
- **Requirement**: Chromosomes must be represented as integers.

```bash
generate_gt -a archaic.vcf -m modern.vcf -o merged.gt
```

### 2. Detect Introgressed Regions
Run the `ibdmix` detection algorithm on the merged genotype file.
```bash
ibdmix -g merged.gt -o output.txt -d 3.0 -m 1
```
**Key Parameters:**
- `-d, --LOD-threshold`: Minimum LOD score to report a region (Default: 3.0).
- `-m, --minor-allele-count-threshold`: Filters rare variants; sites with counts below this are ignored (LOD set to 0).
- `-r, --mask`: Provide a BED file of masked regions to exclude.
- `-t, --more-stats`: Highly recommended for downstream analysis; adds columns for site counts, mask overlaps, and genotype specifics.

### 3. Filter and Summarize
Use the `summary.sh` script to refine the raw output. This is faster than re-running the main detection with different thresholds.
```bash
# Usage: summary.sh <length_cutoff> <LOD_cutoff> <pop_label> <input> <output>
./scripts/summary.sh 50000 5.0 EUR output.txt filtered_results.txt
```

## Expert Tips and Best Practices
- **Chromosome Handling**: Ensure your VCF and mask BED files are split by chromosome. IBDmix expects integer chromosome identifiers.
- **Error Rates**: If working with low-coverage archaic genomes, consider adjusting `-a` (archaic error, default 0.01) and `-e` (modern error max, default 0.0025).
- **Inclusive Ends**: Use the `-i` flag if your downstream tools require the reported end position to be the last site with an increasing LOD score rather than the first site where the LOD begins to decrease.
- **SNP Extraction**: To perform secondary analysis on the specific variants driving the signal, use `-w` to output the SNP positions and `--write-lods` for their individual scores.
- **Masking Caveats**: Note that discordant homozygous SNPs (Archaic=2, Modern=0) may still be considered even if they fall within masked regions.

## Reference documentation
- [IBDmix GitHub Repository](./references/github_com_PrincetonUniversity_IBDmix.md)
- [Bioconda IBDmix Package](./references/anaconda_org_channels_bioconda_packages_ibdmix_overview.md)