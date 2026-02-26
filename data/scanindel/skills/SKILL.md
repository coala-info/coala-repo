---
name: scanindel
description: ScanIndel is a bioinformatics pipeline that detects insertions and deletions by performing BLAT re-alignment and de novo assembly on soft-clipped reads. Use when user asks to identify indels in complex regions, detect variants from soft-clipped sequences, or run an indel detection pipeline using BAM or FastQ files.
homepage: https://github.com/cauyrd/ScanIndel
---


# scanindel

## Overview
ScanIndel is a specialized bioinformatics pipeline designed to improve the sensitivity of indel detection. While many variant callers struggle with medium-to-large indels or those located in complex regions, ScanIndel specifically targets "soft-clipped" reads—sequences that partially align to the reference genome. By extracting these reads and subjecting them to both BLAT re-alignment and de novo assembly (via Inchworm), the tool can reconstruct the true sequence of the indel. It produces VCF files categorized by the detection method (mapping vs. assembly) and a final merged result.

## Installation and Environment
ScanIndel is a legacy tool with specific environment requirements:
- **Language**: Python 2.7
- **Conda**: `conda install bioconda::scanindel`
- **Critical Dependency**: Requires SAMtools version 1.0 or lower.
- **External Tools**: Ensure `bwa`, `blat` (gfServer/gfClient), `freebayes`, `bedtools`, and `inchworm` are in your system PATH.

## Configuration Files
ScanIndel requires two primary input files to define the run:

### 1. Sample File (`sample.txt`)
A plain text file listing the samples to be analyzed, one per line.
- If using raw reads: Provide paths to FastQ files.
- If using aligned data: Provide paths to BAM files and ensure you use the `--bam` flag in the command.

### 2. Config File (`config.txt`)
This file defines the paths to the reference genomes used by the underlying tools. It must contain paths for:
- BWA index
- BLAT 2bit file
- Freebayes reference fasta

## Command Line Usage

### Basic Execution (BAM Input)
To run ScanIndel on pre-aligned BAM files:
```bash
python ScanIndel.py -i sample.txt -p config.txt --bam -o ./output_dir
```

### Basic Execution (FastQ Input)
To run the full pipeline starting from raw reads:
```bash
python ScanIndel.py -i sample.txt -p config.txt -o ./output_dir
```

### Targeted Analysis
To limit the analysis to specific genomic regions (e.g., exome targets or specific genes), provide a BED file:
```bash
python ScanIndel.py -i sample.txt -p config.txt -t regions.bed
```

### Parallel Processing
If running multiple instances of ScanIndel on the same machine, you must change the `gfServer` port to avoid conflicts:
```bash
python ScanIndel.py -i sample.txt -p config.txt --gfServer_port 50001
```

## Expert Tips and Best Practices
- **Duplicate Removal**: Use the `--rmdup` flag to execute a duplicate removal step before re-alignment, which can reduce false positives in high-coverage data.
- **Soft-clipping Sensitivity**: The `-s` parameter (default 0.2) controls the percentage of soft-clipping required to trigger BLAT re-alignment. Lower this value if you suspect very small indels are being missed.
- **Quality Filtering**: If working with low-quality data, adjust `--lowqual_cutoff` (default 20) and `--min_percent_hq` (default 0.8) to prevent the assembler from attempting to process noisy reads.
- **Interpreting Outputs**:
    - `*.mapping.indel.vcf`: Indels found via soft-clipped read re-alignment.
    - `*.assembly.indel.vcf`: Indels found via de novo assembly.
    - `*.merged.indel.vcf`: The comprehensive set of detected variants.

## Reference documentation
- [ScanIndel GitHub Repository](./references/github_com_cauyrd_ScanIndel.md)
- [ScanIndel Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scanindel_overview.md)