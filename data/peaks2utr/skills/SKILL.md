---
name: peaks2utr
description: peaks2utr is a command-line tool that automates the discovery and refinement of 3' UTR boundaries by combining read coverage peaks with polyA-tail truncation analysis. Use when user asks to identify 3' UTR termination sites, refine transcript annotations, or process 3'-end enriched sequencing data.
homepage: https://github.com/haessar/peaks2utr
metadata:
  docker_image: "quay.io/biocontainers/peaks2utr:1.4.1--pyhdfd78af_0"
---

# peaks2utr

## Overview
peaks2utr is a parallelized Python command-line tool that automates the discovery and refinement of 3' UTR boundaries. It works by identifying broad peaks of read coverage (using MACS2) and pinpointing precise termination sites through the analysis of soft-clipped bases and polyA-tail truncation points. This tool is essential for researchers working with non-model organisms or specialized sequencing protocols where standard 3' UTR annotations are incomplete or inaccurate.

## Installation and Setup
The tool requires `bedtools` to be installed on the system.
- **Conda**: `conda install bioconda::peaks2utr`
- **Pip**: `pip install peaks2utr`
- **Verification**: Run `peaks2utr-demo` to process a small sample dataset and ensure all dependencies (like MACS2 and bedtools) are correctly configured.

## Core CLI Usage
The primary command is `peaks2utr`. While specific argument flags vary by version, the standard workflow requires a BAM file and a reference annotation file.

### Basic Command Pattern
```bash
peaks2utr --bam input.bam --gff reference.gff [options]
```

### Working with GTF Files
If using GTF instead of GFF, ensure you specify the format to avoid ID-related parsing errors:
```bash
peaks2utr --bam input.bam --gtf reference.gtf
```

### Handling Pseudogenes and Non-Coding RNA
By default, the tool may ignore certain feature types. Use these flags to include them in the analysis:
- `--do-pseudo`: Includes pseudogene features in the annotation process.
- The tool automatically attempts to reintegrate ncRNA into the final output in recent versions (v1.3.3+).

### Managing Strand Overlaps
To prevent UTRs from extending into features on the opposite strand (a common issue in dense genomes):
- `--no-strand-overlap`: Disables the overlapping of UTRs with features located on the other strand.

## Expert Tips and Best Practices
- **Input Quality**: This tool is highly optimized for 3'-end enriched libraries. Using standard bulk RNA-seq (full-length) may result in less precise UTR boundary detection.
- **Parallelization**: peaks2utr is parallelized; ensure your environment has sufficient CPU resources allocated for the MACS2 peak-calling step.
- **Post-Processing**: For the cleanest GFF3 output, install `GenomeTools` (`apt-get install genometools`) and use it to validate or sort the resulting GFF file.
- **Output Validation**: Always check the source column in the resulting GFF; new or modified UTRs will be labeled with "peaks2utr" as the source.
- **Mismatched Filenames**: Ensure your output filename extension matches the input format (e.g., use `.gtf` output if using `--gtf` input) to avoid internal parsing warnings.

## Reference documentation
- [peaks2utr Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_peaks2utr_overview.md)
- [peaks2utr GitHub Repository](./references/github_com_haessar_peaks2utr.md)
- [peaks2utr Issues and Bug Fixes](./references/github_com_haessar_peaks2utr_issues.md)