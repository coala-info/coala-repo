---
name: ucsc-mafaddqrows
description: The `mafAddQRows` utility is part of the UCSC Genome Browser "kent" toolset.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-mafaddqrows

## Overview
The `mafAddQRows` utility is part of the UCSC Genome Browser "kent" toolset. It processes Multiple Alignment Format (MAF) files to insert "q" rows, which represent the quality scores of the sequences in the alignment. This is essential for bioinformatics workflows where alignment reliability must be assessed at the base level, or when preparing data for tracks that display sequence quality alongside comparative genomics data.

## Usage Patterns

### Basic Command Structure
The tool typically requires the input MAF file and the source of the quality data (often in `.qac` or `.nib` format).

```bash
mafAddQRows input.maf qualitySource output.maf
```

### Common Parameters and Options
While specific flags can vary by version, the standard UCSC tool behavior for MAF utilities includes:

*   **Quality Source**: This is usually a directory containing quality files or a specific file mapped to the assembly names used in the MAF.
*   **Handling Missing Data**: If quality data is missing for a specific species or region, the tool typically inserts a placeholder or skips the row depending on the configuration.

### Expert Tips
*   **Permissions**: If running the binary directly after download, ensure it is executable: `chmod +x mafAddQRows`.
*   **Database Configuration**: Some UCSC utilities require an `.hg.conf` file in your home directory to connect to public MySQL servers for metadata. If the tool fails to find assembly information, verify your connection settings.
*   **MAF Validation**: Before adding quality rows, ensure your MAF file is properly formatted using `mafCheck`. Adding data to a corrupt MAF can lead to silent data errors.
*   **Memory Management**: For very large MAF files (e.g., whole-genome alignments), process the file in chunks by chromosome to avoid excessive memory consumption.

## Troubleshooting
*   **Permission Denied**: Common when downloading binaries from the UCSC server. Use `chmod +x` on the binary.
*   **Missing Quality Rows**: Ensure the sequence names in the MAF exactly match the identifiers in your quality source files. Discrepancies in naming (e.g., "chr1" vs "1") will prevent the tool from locating the correct quality scores.

## Reference documentation
- [ucsc-mafaddqrows - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-mafaddqrows_overview.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [UCSC Genome Browser Executables Help](./references/hgdownload_cse_ucsc_edu_admin_exe.md)