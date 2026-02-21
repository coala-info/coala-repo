---
name: ucsc-bedtobigbed
description: The `bedToBigBed` utility is a core tool from the UCSC Genome Browser "kent" suite.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-bedtobigbed

## Overview
The `bedToBigBed` utility is a core tool from the UCSC Genome Browser "kent" suite. It converts standard BED files into bigBed files, which are binary, indexed, and support multi-resolution "zoom levels." This format is essential for handling large genomic datasets because it allows tools to fetch only the data needed for a specific genomic region without reading the entire file.

## Usage Patterns

### Basic Conversion
The tool requires three primary inputs: the input BED file, a file containing chromosome sizes, and the output filename.

```bash
bedToBigBed input.bed chrom.sizes output.bb
```

### Preparing Input Data
`bedToBigBed` is strict about input formatting. Before running the tool, ensure your BED file is sorted by chromosome and then by start position.

```bash
# Sort BED file correctly for bedToBigBed
sort -k1,1 -k2,2n input.unsorted.bed > input.sorted.bed

# Generate chrom.sizes if not already available (example for hg38)
fetchChromSizes hg38 > hg38.chrom.sizes
```

### Handling Custom BED Fields (AutoSQL)
If your BED file has more than the standard 3 to 12 columns, you must provide an AutoSQL (.as) file to define the extra fields.

```bash
bedToBigBed -as=fields.as -type=bed12+4 input.bed chrom.sizes output.bb
```
*Note: The `-type` parameter should match the number of standard BED columns plus the number of extra columns (e.g., `bed3+1`).*

### Common Options
- `-blockSize=N`: Sets the number of items to bundle in R-tree nodes. Default is 256.
- `-itemsPerSlot=N`: Sets the number of data points bundled at lowest level. Default is 512.
- `-unc`: Disable compression (useful for debugging or very small files).
- `-tab`: Use if your input BED file is tab-separated (standard BED is tab-separated, but some variants use spaces).

## Expert Tips
1. **Validation First**: Use `bedToBigBed` with the `-extraIndex` option if you need to search for items by name (column 4) in the resulting bigBed file.
2. **Memory Management**: For extremely large datasets, ensure your system has enough temporary disk space, as the tool creates temporary files during the indexing process.
3. **Chromosome Naming**: Ensure the chromosome names in your `input.bed` exactly match those in your `chrom.sizes` file (e.g., "chr1" vs "1").
4. **BigBed to BED**: If you need to reverse the process, use the companion tool `bigBedToBed`.

## Reference documentation
- [ucsc-bedtobigbed Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bedtobigbed_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binaries List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)