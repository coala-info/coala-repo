---
name: ucsc-bedtogenepred
description: ucsc-bedtogenepred converts BED-formatted genomic features into the genePred format. Use when user asks to convert BED to genePred, convert BED12 to genePred, or create refFlat files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-bedtogenepred:482--h0b57e2e_0"
---

# ucsc-bedtogenepred

## Overview
`ucsc-bedtogenepred` is a specialized utility from the UCSC Kent toolkit that transforms BED-formatted genomic features into the genePred format. While BED files are versatile for representing any genomic region, the genePred format is specifically optimized for gene models, providing a structured way to represent transcript structures, including exon/intron boundaries and coding sequence (CDS) regions. This tool is essential for bioinformaticians working within the UCSC ecosystem or those needing to convert simple region definitions into formal gene predictions.

## Usage Instructions

### Basic Conversion
The most common use case is a direct conversion of a BED file to a genePred file.
```bash
bedToGenePred input.bed output.gp
```

### Working with BED12
To accurately capture transcript structure (exons and introns), the input should be in **BED12** format. If the input is a simpler BED format (like BED3 or BED6), the resulting genePred will treat the entire region as a single exon.

### Creating refFlat Files
The genePred format is often used to create `refFlat` files, which are essentially genePred files with an additional column for the gene name at the beginning.
```bash
# Convert BED to genePred
bedToGenePred input.bed output.gp

# Use awk to prepend the gene name (often the same as the transcript ID in column 1)
awk 'BEGIN {FS="\t"; OFS="\t"} {print $1, $0}' output.gp > output.refFlat
```

### Common CLI Options
While specific versions may vary, the following patterns are standard for this utility:

*   **Coordinate Validation**: The tool automatically handles the 0-based, half-open coordinate system of BED and converts it to the format expected by genePred.
*   **Standard Input/Output**: Like many Kent tools, you can often use `stdin` or `stdout` by using `/dev/stdin` or `/dev/stdout` if the environment supports it, though direct file paths are preferred for stability.

## Expert Tips and Best Practices

1.  **Sort your BED first**: While not always strictly required for the conversion itself, many downstream tools that consume genePred files require the input to be sorted by chromosome and start position. Use `bedSort` before conversion.
2.  **Verify BED12 Integrity**: If your conversion results in "single-exon" genes when you expected multiple exons, verify that your input BED file actually contains 12 columns and that the block counts and sizes are correctly formatted.
3.  **GenePred Validation**: After conversion, it is a best practice to run `genePredCheck` on the output to ensure the resulting file is well-formed and biologically plausible (e.g., no overlapping exons in the same transcript).
4.  **Permission Handling**: If running the binary directly from a download, ensure it has execution permissions: `chmod +x bedToGenePred`.



## Subcommands

| Command | Description |
|---------|-------------|
| bedToGenePred | Convert a BED file to a genePred file. |
| genePredCheck | Validate genePred files, checking for various errors such as overlapping exons, invalid coordinates, and consistency with chromosome sizes. |

## Reference documentation
- [bioconda | ucsc-bedtogenepred](./references/anaconda_org_channels_bioconda_packages_ucsc-bedtogenepred_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [UCSC Linux x86_64 Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)