---
name: ucsc-bedclip
description: ucsc-bedclip validates and corrects genomic coordinates in BED files by clipping or removing entries that exceed chromosome boundaries. Use when user asks to validate BED file coordinates, correct invalid genomic coordinates, prepare BED files for BigBed conversion, or ensure genomic data integrity.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-bedclip

## Overview
The `ucsc-bedclip` utility is a specialized tool from the UCSC Genome Browser "Kent" suite used to ensure genomic data integrity. In bioinformatics workflows, BED files may occasionally contain entries with coordinates that are technically invalid—such as start positions less than zero or end positions that exceed the known length of a chromosome. This tool compares a BED file against a specific genome's chromosome sizes and "clips" the data to fit, either by removing the offending lines or truncating the coordinates to the maximum allowable boundary.

## Usage Instructions

### Basic Command Line Syntax
The tool requires three positional arguments: the input BED file, a chromosome sizes file, and the destination for the clipped output.

```bash
bedClip input.bed chrom.sizes output.bed
```

### Preparing the chrom.sizes File
The `chrom.sizes` file is a two-column, tab-separated text file where the first column is the chromosome name (e.g., `chr1`) and the second column is the size in base pairs. You can generate this for UCSC assemblies using the `fetchChromSizes` utility:

```bash
# Example for Human GRCh38/hg38
fetchChromSizes hg38 > hg38.chrom.sizes
```

## Expert Tips and Best Practices

### Prerequisite for BigBed Conversion
The most common use case for `bedClip` is as a mandatory step before running `bedToBigBed`. The BigBed conversion tool will fail with an error if any feature extends beyond the chromosome limits defined in the sizes file. Always pipe or sequence your commands as follows:
1. `bedSort` (to order the file)
2. `bedClip` (to validate boundaries)
3. `bedToBigBed` (to create the binary index)

### Handling Truncation vs. Removal
By default, `bedClip` is designed to keep the data valid. If a feature starts at -10 and ends at 50, it will be clipped to start at 0. If a feature is entirely outside the range (e.g., starts at 5000 on a chromosome only 4000 bp long), it will be removed.

### Integration with Pipes
To save disk space and avoid intermediate files, `bedClip` can be used in a command pipeline. Use `stdin` or `stdout` notation if supported, though standard Kent tools often prefer explicit file paths. If using a shell that supports process substitution:
```bash
bedSort input.bed stdout | bedClip stdin hg38.chrom.sizes output.clipped.bed
```

### Verification
After clipping, you can verify the coordinate range of your file using `awk` to ensure no negative starts remain:
```bash
awk '$2 < 0' output.bed
```

## Reference documentation
- [ucsc-bedclip Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bedclip_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Tool List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)