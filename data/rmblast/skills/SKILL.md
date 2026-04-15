---
name: rmblast
description: RMBlast is a specialized version of the NCBI BLAST+ suite designed for repeat identification and genomic annotation. Use when user asks to install RMBlast, configure it for RepeatMasker or RepeatModeler, and run rmblastn for repeat-specific sequence searches.
homepage: https://www.repeatmasker.org/rmblast/
metadata:
  docker_image: "quay.io/biocontainers/rmblast:2.14.1--hdb21ba3_2"
---

# rmblast

## Overview
RMBlast is a specialized version of the NCBI BLAST+ suite, primarily used as a search engine for RepeatMasker and RepeatModeler. It introduces the `rmblastn` program, which provides features not found in the standard NCBI distribution, such as support for custom matrices without KA-Statistics, cross_match-like complexity adjusted scoring, and masklevel filtering. This skill provides guidance on installing, configuring, and utilizing RMBlast within genomic annotation pipelines.

## Installation and Setup

### Conda Installation
The most efficient way to install RMBlast is via Bioconda:
```bash
conda install bioconda::rmblast
```

### Manual Configuration
After installing the binaries, you must register RMBlast with your repeat analysis tools. Navigate to your RepeatMasker or RepeatModeler installation directories and run the configuration scripts:
```bash
# In RepeatMasker directory
./configure

# In RepeatModeler directory
./configure
```

## Command Line Usage

### The rmblastn Program
The primary executable is `rmblastn`. It functions similarly to standard `blastn` but includes specific logic for repeat identification.

**Key Options:**
- `-db_soft_mask`: Use this to enable soft masking of the database (available in version 2.14.1+).
- Standard BLAST+ arguments (e.g., `-query`, `-db`, `-out`, `-evalue`) are supported as `rmblastn` is built upon the NCBI BLAST+ framework.

### Telemetry and Privacy
By default, RMBlast versions 2.11.0+ report usage statistics (program version, parameter values, and file sizes) to `repeatmasker.org`. To opt out of this reporting, set the following environment variable in your shell:
```bash
export BLAST_USAGE_REPORT=false
```

## Best Practices

- **Thread Consistency**: If using multi-threaded execution in versions prior to 2.14.0, be aware that masklevel filtering might produce slightly different alignments across runs. Upgrade to 2.14.0+ for deterministic results via subject ID sorting.
- **OS Compatibility**: For older Linux distributions (e.g., Ubuntu 20.04) with GLIBC versions older than 2.34, ensure you use the specific "Older OS versions" binary package if installing manually.
- **Performance**: Version 2.13.0+ introduced query-based threading, which significantly improves performance when used with RepeatModeler. Ensure you are using a recent version for large-scale genomic searches.
- **Scoring**: Use RMBlast when you require Smith-Waterman-like seeded search results (cross_match style) which standard NCBI BLAST+ cannot replicate exactly.

## Reference documentation
- [RMBlast Download and Overview](./references/www_repeatmasker_org_rmblast.md)
- [Bioconda RMBlast Package](./references/anaconda_org_channels_bioconda_packages_rmblast_overview.md)