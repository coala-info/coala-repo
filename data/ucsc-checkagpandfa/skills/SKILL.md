---
name: ucsc-checkagpandfa
description: This tool verifies the structural integrity of a genome assembly by cross-referencing AGP instructions with FASTA sequence data. Use when user asks to verify genome assembly integrity, cross-reference AGP and FASTA files, or check for synchronization errors between assembly instructions and sequence data.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-checkagpandfa

## Overview
The `checkAgpAndFa` utility is a quality control tool from the UCSC Genome Browser "kent" source suite. It is designed to verify the structural integrity of a genome assembly by cross-referencing the assembly instructions (AGP) with the raw sequence data (FASTA). It ensures that every component mentioned in the AGP exists in the FASTA file and that the lengths specified in the assembly layout match the actual base counts in the sequence file.

## Usage Instructions

### Basic Command Pattern
The tool follows a standard UCSC command-line interface where the primary arguments are the AGP file and the FASTA file to be checked.

```bash
checkAgpAndFa input.agp input.fa
```

### Common CLI Options
While specific flags can vary by version, the following are standard behaviors for UCSC assembly tools:
- **Running without arguments**: Displays the built-in help and usage statement.
- **-verbose=N**: Increases the amount of status information printed to the screen (where N is typically 1-4).

### Expert Tips and Best Practices
- **Pre-processing FASTA**: Ensure your FASTA file is indexed or formatted correctly. If the tool struggles with large files, consider using `faSize` or `faToTwoBit` first to verify the FASTA integrity independently.
- **AGP Versioning**: This tool is designed for standard AGP formats (v1.1 or v2.0). Ensure your AGP file does not contain non-standard component types that might trigger false synchronization errors.
- **Permission Errors**: If running the binary directly from a download, ensure it has execution permissions:
  ```bash
  chmod +x checkAgpAndFa
  ```
- **Synchronization Errors**: If the tool reports a mismatch, check for:
  - Off-by-one errors in AGP coordinates (AGP is 1-based).
  - Trailing newlines or hidden characters in the FASTA sequence.
  - Mismatched identifiers between the AGP component_id and the FASTA header.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-checkagpandfa Package Details](./references/anaconda_org_channels_bioconda_packages_ucsc-checkagpandfa_overview.md)
- [Linux x86_64 Binary Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)