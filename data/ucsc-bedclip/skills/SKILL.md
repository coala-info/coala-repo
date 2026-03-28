---
name: ucsc-bedclip
description: This tool removes or truncates BED file features that extend beyond defined chromosome boundaries. Use when user asks to clip genomic coordinates, remove out-of-bounds features, or prepare BED files for conversion to bigBed or bigWig formats.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-bedclip

## Overview
The `bedClip` utility is a specialized tool from the UCSC Genome Browser "kent" suite designed to ensure genomic data integrity. It compares the coordinates in a BED file against a provided list of chromosome sizes and "clips" or removes any features that fall outside those valid ranges. You should use this tool whenever you encounter "out of bounds" errors during track hub creation or when working with assembly-specific data where features might inadvertently overlap the ends of chromosomes.

## Command Line Usage

The basic syntax for `bedClip` requires an input BED file, a chromosome sizes file, and a destination for the clipped output.

```bash
bedClip input.bed chrom.sizes output.bed
```

### Input Requirements
- **BED File**: A standard tab-separated BED file (3-column minimum).
- **Chromosome Sizes**: A two-column text file containing `chromName` and `chromSize` (e.g., `chr1 248956422`). You can generate this using `fetchChromSizes` or by querying a database.

## Best Practices and Expert Tips

### Pre-conversion Workflow
Always run `bedClip` before using `bedGraphToBigWig` or `bedToBigBed`. These conversion tools will fail if a single record exceeds the chromosome length.
```bash
# Recommended pipeline
bedSort input.bedGraph sorted.bedGraph
bedClip sorted.bedGraph hg38.chrom.sizes clipped.bedGraph
bedGraphToBigWig clipped.bedGraph hg38.chrom.sizes output.bw
```

### Handling Standard Input/Output
Like most UCSC utilities, `bedClip` supports `stdin` and `stdout` using the hyphen (`-`) character, allowing it to be integrated into pipes without creating intermediate files.
```bash
cat data.bed | bedClip - hg38.chrom.sizes stdout | next_tool
```

### Coordinate Validation
`bedClip` specifically handles two types of boundary issues:
1. **End-clipping**: If a feature starts within a chromosome but ends after the chromosome's length, the end coordinate is truncated to the maximum chromosome size.
2. **Removal**: If a feature starts and ends entirely outside the chromosome boundaries (e.g., a negative start coordinate or a start coordinate greater than the chromosome length), the entry is removed entirely.

### Troubleshooting "Permission Denied"
If you have just downloaded the binary from the UCSC server, you must set the execution bit before it will run:
```bash
chmod +x ./bedClip
```



## Subcommands

| Command | Description |
|---------|-------------|
| bedSort | Sort a BED file. The input and output can be the same file. |
| bedToBigBed | Convert a BED file to a bigBed file. The input BED file must be sorted by chromosome and start position. |
| fetchChromSizes | Fetch chromosome sizes for a specified UCSC genome database (e.g., hg38, mm10). The output is sent to stdout. |

## Reference documentation
- [UCSC Genome Browser Kent Utility Directory](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [UCSC Kent Wiki](./references/github_com_ucscGenomeBrowser_kent_wiki.md)