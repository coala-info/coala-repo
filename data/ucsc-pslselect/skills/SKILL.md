---
name: ucsc-pslselect
description: The ucsc-pslselect utility filters and selects specific alignments from PSL files based on criteria such as sequence names, scores, or genomic coordinates. Use when user asks to filter PSL alignment files, select alignments by query or target name, extract high-scoring alignments, or subset records by genomic position.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-pslselect:482--h0b57e2e_0"
---

# ucsc-pslselect

## Overview

The `pslSelect` utility is a specialized tool from the UCSC Genome Browser "kent" source suite designed for high-performance filtering of PSL files. PSL files typically store alignments of DNA or protein sequences to a genome. This tool allows researchers to isolate specific alignments of interest—such as those belonging to a particular chromosome, a specific query sequence, or meeting certain quality thresholds—without needing to write custom parsing scripts. It is particularly useful in bioinformatics pipelines where large-scale alignment data must be refined before downstream analysis or visualization.

## Usage Instructions

### Basic Syntax
The standard invocation requires an input PSL and an output destination. Selection criteria are typically provided via command-line flags.

```bash
pslSelect [options] input.psl output.psl
```

### Common Selection Patterns

- **Filter by Query or Target Name**: Use flags to specify exactly which sequences to keep.
  - `-qt=name`: Select records where the query name matches 'name'.
  - `-tt=name`: Select records where the target name matches 'name'.
- **Filter by Score**: Extract only high-quality alignments.
  - `-minScore=N`: Keep records with a score of at least N.
- **Positional Selection**: Subset alignments based on genomic coordinates.
  - `-tPos=chrom:start-end`: Select alignments overlapping a specific target region.
  - `-qPos=seq:start-end`: Select alignments overlapping a specific query region.

### Expert Tips

- **Standard Input/Output**: Like many UCSC tools, you can often use `stdin` or `stdout` by using `stdin` or `stdout` as filenames, allowing you to pipe results directly into other tools like `pslCheck` or `pslToBed`.
- **Performance**: `pslSelect` is written in C and optimized for speed. It is significantly faster than using `grep` or `awk` for complex coordinate-based filtering because it understands the PSL structure.
- **Validation**: After selecting records, it is best practice to run `pslCheck` on the output to ensure the resulting file maintains a valid format, especially if the output is intended for track hubs.
- **Permissions**: If running the binary for the first time after downloading from the UCSC servers, ensure it is executable: `chmod +x pslSelect`.

## Reference documentation

- [ucsc-pslselect Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-pslselect_overview.md)
- [UCSC Genome Browser Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [UCSC Kent Source README](./references/github_com_ucscGenomeBrowser_kent.md)