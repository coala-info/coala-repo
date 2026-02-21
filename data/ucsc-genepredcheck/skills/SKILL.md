---
name: ucsc-genepredcheck
description: The `genePredCheck` utility is a diagnostic tool from the UCSC Genome Browser "Kent" suite.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-genepredcheck

## Overview
The `genePredCheck` utility is a diagnostic tool from the UCSC Genome Browser "Kent" suite. It is used to ensure that gene prediction files (often ending in `.gp` or `.genePred`) adhere to the strict structural requirements of the UCSC Genome Browser database. It checks for common errors such as overlapping exons, coordinates out of bounds, and mismatches between the number of exons and the actual coordinate blocks.

## Usage Patterns

### Basic Validation
To check a genePred file for errors, run the command against the file. By default, it will report errors to standard error.

```bash
genePredCheck file.genePred
```

### Validating Database Tables
If you are working with a tab-separated file intended for a database table, you can specify the source to ensure the tool parses the columns correctly.

```bash
genePredCheck -db=hg38 table_name file.txt
```

### Common Options and Flags
*   `-chromSizes=file`: Provide a tab-separated file of chromosome names and sizes to verify that all gene coordinates fall within valid genomic ranges.
*   `-verbose=N`: Increase the level of detail in the output. `-verbose=2` or higher is useful for debugging specific structural failures in a gene model.
*   `-err=file`: Redirect error messages to a specific file instead of stderr.

## Expert Tips
*   **Format Variants**: genePred comes in several flavors (standard, extended, and bigGenePred). If your file has extra columns (like gene symbols or frame information), `genePredCheck` is generally robust enough to handle them, but ensure the first 10 columns follow the standard genePred schema.
*   **Coordinate Systems**: Remember that genePred uses 0-based start and 1-based end coordinates. If you are converting from GFF or GTF, use `gtfToGenePred` first, then run `genePredCheck` to ensure the conversion didn't introduce coordinate shifts.
*   **Integration with bigGenePred**: Before converting a genePred file to a bigBed format (using `bedToBigBed` with the `bigGenePred.as` schema), always run `genePredCheck`. This prevents the creation of "broken" bigBed files that might crash genome browser tracks.

## Reference documentation
- [UCSC Genome Browser Admin Executables](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-genepredcheck Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-genepredcheck_overview.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)