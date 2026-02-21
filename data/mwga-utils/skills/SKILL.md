---
name: mwga-utils
description: The `mwga-utils` suite provides high-performance C++ utilities for analyzing and manipulating MAF files.
homepage: https://github.com/RomainFeron/mgwa_utils
---

# mwga-utils

## Overview
The `mwga-utils` suite provides high-performance C++ utilities for analyzing and manipulating MAF files. It is essential for bioinformatics workflows that require per-base statistics (like alignability and identity), alignment completeness checks, and the restoration of missing reference regions to ensure a continuous coordinate system.

## Command Reference

### 1. Generating Genomic Metrics
Use the `metrics` command to calculate position-specific data for the reference assembly. It produces `.wig` files suitable for visualization in genome browsers.
- **Alignability**: The fraction of assemblies aligned at a specific position.
- **Identity**: The fraction of assemblies matching the reference nucleotide.

```bash
metrics <maf_file> [-p prefix] [-t threads] [-n assemblies]
```
*Tip: If the number of assemblies is known, specify `-n` to avoid the overhead of the tool auto-detecting it from the MAF header.*

### 2. Filling Missing Reference Regions
MAF files often omit regions where no sequences align to the reference. Use `missing_regions` to create a complete MAF that includes these gaps with a score of `NA`.
```bash
missing_regions <maf_file> <reference_fasta> > complete_alignment.maf
```
*Note: This tool outputs to stdout. Always redirect to a file.*

### 3. Validating Reference Coverage
To ensure that each sequence in your reference assembly is represented exactly once in the alignment (avoiding overlapping blocks), use `single_coverage`.
```bash
single_coverage <maf_file> [-t threads]
```
*Output: A table showing coverage counts per contig. Ideal for QC before downstream phylogenomic analysis.*

### 4. Alignment Statistics
For a high-level summary of the alignment, such as the total number of base pairs aligned for each assembly in the MAF:
```bash
stats <maf_file> [-p prefix]
```

## Best Practices
- **Thread Management**: For large MAF files, utilize the `-t` flag in `metrics` and `single_coverage` to significantly reduce processing time.
- **Reference Consistency**: Ensure the FASTA file provided to `missing_regions` exactly matches the reference sequence used to generate the MAF.
- **Pipeline Integration**: While these tools are standalone, they are optimized for the output of MultiZ. If using other aligners, verify the MAF format compatibility.

## Reference documentation
- [mwga-utils GitHub Repository](./references/github_com_RomainFeron_mwga-utils.md)
- [Bioconda mwga-utils Package Overview](./references/anaconda_org_channels_bioconda_packages_mwga-utils_overview.md)