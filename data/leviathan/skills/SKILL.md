---
name: leviathan
description: "Leviathan is a structural variant caller optimized for identifying genomic rearrangements in Linked-Reads data. Use when user asks to call structural variants from Linked-Reads, index barcodes in a BAM file, or identify SV candidates using shared barcode frequencies."
homepage: https://github.com/morispi/LEVIATHAN
---


# leviathan

## Overview
LEVIATHAN is a structural variant caller optimized for Linked-Reads data. It identifies SVs by first indexing the positions of barcodes across a BAM file and then calculating the frequency of shared barcodes between distant genomic regions. This approach allows it to highlight SV candidates that traditional short-read callers might miss. The tool follows a two-step process: barcode indexing via the integrated LRez utility, followed by candidate refinement and SV calling to produce a standard VCF output.

## Installation and Setup
LEVIATHAN is available via Bioconda or source compilation.
- **Conda**: `conda install -c bioconda leviathan`
- **Source**: Requires `g++` (>= 5.5.0), `CMake`, and `zlib`. Build using the provided `install.sh` script.

## Core Workflow

### 1. Barcode Indexing
Before calling variants, you must generate a barcode index (`.bci`) from your BAM file using `LRez`.
**Note**: The BAM file must have an associated `.bai` index in the same directory.

```bash
LRez index bam -p -b input.bam -o barcodeIndex.bci
```

### 2. Structural Variant Calling
Run the main LEVIATHAN binary using the generated index and the reference genome.

```bash
LEVIATHAN -b input.bam -i barcodeIndex.bci -g genome.fasta -o output.vcf
```

## CLI Options and Tuning

### Performance and Scaling
- **Threads**: Use `-t` (default: 8) to specify the number of threads.
- **Memory Management**: Use `-B` (default: 10) to set the number of iterations through the barcode index if memory is constrained.

### Sensitivity and Filtering
- **Region Size (`-r`)**: Sets the genomic window size (default: 1000bp). Smaller windows increase resolution but raise computational cost.
- **Variant Size (`-v`)**: Minimum SV size to detect. Usually matches the region size.
- **Shared Barcode Thresholds**:
  - `-s`, `-m`, `-l`: Percentile thresholds for small, medium, and large variants (default: 99). Adjust these to control the stringency of candidate selection.
  - `-c`: Minimum absolute number of shared barcodes required to keep a candidate (default: 1).

### Structural Variant Types
- **Translocations**: Use `--skipTranslocations` if you only want to focus on intra-chromosomal variants.
- **Duplicate Filtering**: Use `-d` (default: 10) to set the distance threshold for merging identical SV types.

## Expert Tips
- **Input Pre-processing**: LEVIATHAN requires barcodes to be present in the read headers. If using raw data, pre-process with `Long Ranger basic` or a similar tool to ensure the BAM format is compatible.
- **Candidate Inspection**: Use the `-C` option to specify a filename (default: `candidates.bedpe`) to save the raw SV candidates before the refinement step. This is useful for debugging why specific variants might be filtered out of the final VCF.
- **Reference Consistency**: Ensure the chromosome names in your BAM file exactly match those in the FASTA reference; otherwise, the tool will exit with an error.

## Reference documentation
- [Bioconda Leviathan Overview](./references/anaconda_org_channels_bioconda_packages_leviathan_overview.md)
- [LEVIATHAN GitHub Repository](./references/github_com_morispi_LEVIATHAN.md)