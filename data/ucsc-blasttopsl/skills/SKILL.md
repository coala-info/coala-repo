---
name: ucsc-blasttopsl
description: This tool converts standard BLAST output to PSL format. Use when user asks to convert BLAST output to PSL format, or prepare BLAST results for the UCSC Genome Browser.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-blasttopsl

## Overview
The `blastToPsl` utility is a specialized converter within the UCSC Genome Browser "kent" tool suite. It transforms standard BLAST output into PSL format, which is the native alignment format for the UCSC Genome Browser. This is essential for researchers who want to view their BLAST-derived sequence similarities alongside genomic annotations or perform downstream analysis using other UCSC utilities that expect PSL files.

## Usage Patterns

### Basic Conversion
The tool typically reads from a BLAST output file and writes to a PSL file.
```bash
blastToPsl blast_output.txt output.psl
```

### Common CLI Options
While specific flags can vary by version, the following are standard patterns for the kent source utilities:
- **-pslx**: Output in PSLX format (includes the sequence strings).
- **-scores=file**: Specify a file to output alignment scores.
- **-verbose=N**: Set the verbosity level (e.g., -verbose=2).

### Expert Tips
- **BLAST Format Requirement**: Ensure your BLAST output is in a compatible format. Older versions of `blastToPsl` often require the default human-readable BLAST output (standard text) rather than the tabular (`-outfmt 6`) or XML formats. If using modern BLAST+, use the default output format.
- **PSL Validation**: After conversion, it is a best practice to run `pslCheck` on the resulting file to ensure it conforms to the UCSC specification before attempting to upload it as a custom track.
- **Sorting**: The UCSC Genome Browser often requires PSL files to be sorted by target sequence and position. Use `pslSort` on the output of `blastToPsl` if you encounter display errors.
- **Permissions**: If you downloaded the binary directly from the UCSC server, remember to set execution permissions: `chmod +x blastToPsl`.

## Reference documentation
- [UCSC Genome Browser Binaries Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-blasttopsl Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-blasttopsl_overview.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)