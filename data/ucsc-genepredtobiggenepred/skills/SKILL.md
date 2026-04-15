---
name: ucsc-genepredtobiggenepred
description: This tool converts gene prediction files from genePred or genePredExt format into bigGenePred format. Use when user asks to convert gene prediction files, transform gene models, or prepare data for bigGenePred tracks in the UCSC Genome Browser.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-genepredtobiggenepred:482--h0b57e2e_0"
---

# ucsc-genepredtobiggenepred

## Overview
The `genePredToBigGenePred` utility is a specialized converter within the UCSC Kent toolset. It transforms gene models stored in the legacy `genePred` (or extended `genePredExt`) table format into a BED12+8 format known as `bigGenePred`. This format is specifically designed to support the `bigGenePred` track type, which allows the Genome Browser to display rich metadata—such as gene IDs, symbols, and transcript types—directly from a binary BigBed file.

## Usage Instructions

### Basic Command Line
The tool takes a genePred file as input and produces a tab-separated file formatted for bigGenePred.

```bash
genePredToBigGenePred input.genePred output.bgp
```

### Standard Workflow
Converting to `bigGenePred` is usually the middle step in a three-part process to create a binary track:

1.  **Conversion**: Use `genePredToBigGenePred` to create the intermediate BED-like file.
2.  **Sorting**: The output must be sorted by chromosome and then by start position.
    ```bash
    sort -k1,1 -k2,2n output.bgp > output.sorted.bgp
    ```
3.  **BigBed Creation**: Use `bedToBigBed` with the specific `bigGenePred.as` AutoSql schema file.
    ```bash
    bedToBigBed -type=bed12+8 -as=bigGenePred.as output.sorted.bgp chrom.sizes output.bb
    ```

### Input Formats
*   **genePred**: The standard format used in UCSC database tables.
*   **genePredExt**: The extended version that includes additional fields like frame information and gene names. The tool automatically detects and handles these extra fields to populate the `bigGenePred` columns.

## Expert Tips and Best Practices
*   **Schema Matching**: When using the resulting file with `bedToBigBed`, ensure you use the `bigGenePred.as` file provided by UCSC. This schema defines the 20 columns (12 standard BED columns plus 8 specific to gene predictions) required for the track to render correctly.
*   **Pre-validation**: If the conversion fails or produces unexpected results, run `genePredCheck` on your input file first to ensure the coordinates and exon counts are internally consistent.
*   **Column 12+**: Note that `bigGenePred` adds fields for `geneName`, `transcriptType`, `transcriptStatus`, `geneId`, `geneType`, `geneStatus`, `proteinId`, and `exonFrames`. If your input `genePred` lacks these, the tool will provide default or empty values.
*   **Binary Availability**: This tool is part of the `ucsc-genepredtobiggenepred` package on Bioconda and is also available as a standalone binary for Linux and macOS from the UCSC hgdownload server.

## Reference documentation
- [ucsc-genepredtobiggenepred overview](./references/anaconda_org_channels_bioconda_packages_ucsc-genepredtobiggenepred_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)