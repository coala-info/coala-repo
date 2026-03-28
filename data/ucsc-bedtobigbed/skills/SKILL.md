---
name: ucsc-bedtobigbed
description: This tool converts text-based BED files into binary BigBed format for high-performance genomic data visualization. Use when user asks to convert BED files to BigBed, handle chromosome sizes for file conversion, or create indexed genomic data files for the UCSC Genome Browser.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-bedtobigbed

## Overview
The `bedToBigBed` utility is a core tool from the UCSC Genome Browser "kent" suite. It converts text-based BED files into binary BigBed files. BigBed files are essential for high-performance genomic data visualization because they allow browsers to fetch only the data needed for a specific genomic window without downloading the entire file. This skill provides the necessary CLI patterns to perform this conversion, including handling chromosome sizes and custom data schemas.

## Basic Usage
The tool requires three primary inputs: the source BED file, a file containing chromosome sizes, and the desired output filename.

```bash
bedToBigBed input.bed chrom.sizes output.bb
```

### Preparing Input Files
1.  **Sort the BED file**: The input BED file **must** be sorted by chromosome and then by start position.
    ```bash
    bedSort input.bed sorted_input.bed
    ```
2.  **Chromosome Sizes**: This is a two-column tab-separated file (Chromosome Name, Size in BP). You can often fetch this using `fetchChromSizes` or from the UCSC hgdownload site.

## Common CLI Options
- `-type=bedN[+P]`: Specify the BED format (e.g., `bed3`, `bed6`, `bed12`). The `+P` indicates extra non-standard columns.
- `-as=file.as`: Provide an AutoSql (.as) definition file for custom columns.
- `-extraIndex=columnList`: Create an index on specific extra columns (comma-separated) for fast searching.
- `-blockSize=N`: Number of items to bundle in R-tree leaf nodes (default 256).
- `-itemsPerSlot=N`: Number of items to bundle in data nodes (default 512).
- `-unc`: Disable compression.

## Expert Tips & Best Practices
- **Validation**: Always run `bedSort` before `bedToBigBed`. The tool will fail if the input is not strictly ordered.
- **Custom Columns**: If your BED file has more than the standard 12 columns, you must use the `-as` option with an AutoSql schema and specify the `-type` correctly (e.g., `-type=bed12+4` for 12 standard and 4 extra columns).
- **Memory Management**: For extremely large datasets, ensure you have sufficient disk space in your `/tmp` directory, as the tool creates temporary files during the B+ tree construction.
- **BigBed Info**: After conversion, use `bigBedInfo output.bb` to verify the structure and `bigBedSummary` to extract data statistics.



## Subcommands

| Command | Description |
|---------|-------------|
| bedToBigBed | Convert a BED file to a bigBed file. The input BED file must be sorted by chromosome and start position. |
| fetchChromSizes | Fetch chromosome sizes for a specific genome assembly from the UCSC Genome Browser. |

## Reference documentation
- [UCSC Genome Browser Kent Wiki](./references/github_com_ucscGenomeBrowser_kent_wiki.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)