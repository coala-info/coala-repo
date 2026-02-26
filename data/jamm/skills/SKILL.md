---
name: jamm
description: JAMM is a peak-calling algorithm that integrates biological replicates to improve the accuracy of peak detection and boundary definition. Use when user asks to call peaks from multiple replicates, identify enriched genomic regions, or process NGS data for narrow and broad signals.
homepage: https://github.com/mahmoudibrahim/JAMM
---


# jamm

## Overview
JAMM (Joint Analysis of NGS Replicates) is a peak-calling algorithm designed to process biological replicates together to improve the accuracy of peak detection and boundary definition. Unlike tools that pool replicates or analyze them individually, JAMM uses a statistical framework to integrate signal across replicates, effectively reducing noise and identifying consistent enriched regions. It is applicable to various sequencing technologies and can be tuned for both sharp (narrow) and diffuse (broad) genomic signals.

## Installation
Install JAMM via Bioconda:
```bash
conda install bioconda::jamm
```

## Command Line Usage
The primary entry point is the `JAMM.sh` script.

### Basic Peak Calling
Run JAMM by providing directories for samples and controls, along with a genome size file:
```bash
JAMM.sh -s <sample_bed_dir> -c <control_bed_dir> -g <genome_size_file> -o <output_dir>
```

### Key Parameters
- `-s`: Path to directory containing sample BED files (one file per replicate).
- `-c`: Path to directory containing control/input BED files.
- `-g`: Genome chromosome sizes file (tab-delimited: chromosome name and size).
- `-o`: Output directory.
- `-t`: Signal type. Use `narrow` (default) for transcription factors or `broad` for certain histone marks.
- `-e`: Enrichment threshold. Use `-e auto` to let JAMM determine the threshold automatically.
- `-p`: Number of processors to use for parallel processing.
- `-T`: Path to a custom temporary directory (recommended for large datasets to avoid filling `/tmp`).
- `-f`: Fragment length (optional; JAMM can estimate this automatically).

## Best Practices and Expert Tips
- **Input Preparation**: JAMM requires BED format. Ensure your BAM files are converted to BED and that reads are filtered for quality and uniqueness before running the tool.
- **Replicate Management**: Place all replicates for a single experimental condition into one directory. JAMM expects all files in the `-s` directory to be replicates of the same condition.
- **Handling Large Lists**: By default, JAMM produces a comprehensive list of potential peaks. If the output is too large, use the `-e auto` flag or filter the final results based on the "Score" or "Fold Enrichment" columns in the output files.
- **ATAC-Seq Processing**: For ATAC-Seq data, it is recommended to perform read shifting (e.g., +4bp for forward, -5bp for reverse) during pre-processing before passing the BED files to JAMM to accurately reflect the transposase insertion site.
- **Memory Management**: For high-depth datasets, always specify a custom temporary directory with `-T` on a disk with sufficient space, as the default system `/tmp` may be insufficient for the intermediate R workspace files.
- **Genome Files**: Ensure the genome size file matches the assembly used for alignment (e.g., hg38 vs hg19).

## Reference documentation
- [JAMM GitHub Repository](./references/github_com_mahmoudibrahim_JAMM.md)
- [JAMM Wiki and Documentation](./references/github_com_mahmoudibrahim_JAMM_wiki.md)
- [Bioconda JAMM Overview](./references/anaconda_org_channels_bioconda_packages_jamm_overview.md)