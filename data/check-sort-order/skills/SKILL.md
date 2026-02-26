---
name: check-sort-order
description: "check-sort-order validates that genomic files are correctly sorted and follow the chromosome sequence defined by a reference genome. Use when user asks to verify file sorting, check chromosome ordering against a reference, or validate genomic file headers and indices."
homepage: https://github.com/gogetdata/ggd-utils
---


# check-sort-order

## Overview
check-sort-order is a specialized validation utility from the ggd-utils suite. It ensures that genomic files are not just internally sorted by position, but also follow a specific chromosome sequence defined by a reference genome file. This tool is particularly useful during the preparation of genomic datasets or the creation of data-sharing recipes, as it catches common errors like missing indices, incorrect headers, or coordinates that exceed known chromosome boundaries.

## CLI Usage and Patterns

The tool generally follows a straightforward positional argument pattern:

```bash
check-sort-order <genome-file> <input-file>
```

### Supported File Formats
The tool automatically detects and validates the following formats (typically expected to be bgzipped):
- **VCF**: `.vcf.gz`
- **BED**: `.bed.gz`
- **bedGraph**: `.bedgraph.gz`
- **GFF/GTF**: `.gff`, `.gtf`
- **TSV**: Generic tab-separated files formatted like VCF or BED.

### Validation Criteria
When running the tool, it performs the following checks:
1.  **Index Presence**: For compressed files, it verifies that a corresponding `.tbi` index file exists in the same directory.
2.  **Header Integrity**: 
    - For VCFs, it checks for the mandatory `##fileformat=VCF` string on the first line.
    - It verifies the presence of the `#CHROM` header line.
3.  **Chromosome Ordering**: It enforces that chromosomes appear in the exact order defined in the provided `<genome-file>`.
4.  **Coordinate Sorting**: It checks that genomic positions are in ascending order within each chromosome.
5.  **Boundary Validation**: It ensures that no feature position exceeds the chromosome length defined in the genome file.

## Best Practices and Expert Tips

### Creating a Compatible Genome File
The `<genome-file>` is a simple tab-delimited file (often with a `.genome` extension) containing chromosome names and their respective lengths.
```text
chr1    248956422
chr2    242193529
...
```
Ensure your genome file matches the 'chr' prefix convention of your data (e.g., "chr1" vs "1"), as `check-sort-order` uses this to dictate the expected naming and presence of chromosomes.

### Handling Unmappable Chromosomes
The tool will issue warnings if it encounters chromosomes in the input file that are not defined in the genome file. If you are working with "decoy" or "alt" contigs, ensure they are included in your genome file to pass validation.

### Pre-validation Workflow
Before running `check-sort-order`, ensure your files are properly processed:
1.  Sort the file: `sort -k1,1 -k2,2n` (or use `gsort`).
2.  Compress with bgzip: `bgzip file.vcf`.
3.  Index with tabix: `tabix -p vcf file.vcf.gz`.
4.  Run validation: `check-sort-order reference.genome file.vcf.gz`.

## Reference documentation
- [check-sort-order - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_check-sort-order_overview.md)
- [gogetdata/ggd-utils: programs for use in ggd](./references/github_com_gogetdata_ggd-utils.md)