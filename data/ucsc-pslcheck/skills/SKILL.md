---
name: ucsc-pslcheck
description: The `pslCheck` utility verifies the format and internal consistency of PSL alignment files. Use when user asks to check PSL file integrity, verify custom alignments, debug genomic pipelines, or sanitize data for UCSC Genome Browser upload.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-pslcheck

## Overview
The `pslCheck` utility is a specialized tool from the UCSC Genome Browser "kent" source suite designed to ensure that PSL files are correctly formatted and internally consistent. It verifies that alignment blocks do not overlap inappropriately, coordinates stay within sequence bounds, and the mathematical relationships between block sizes and starts are accurate. Use this skill to debug failed genomic pipelines, verify custom-generated alignments, or sanitize data before uploading it to the UCSC Genome Browser as a custom track.

## Native CLI Usage and Best Practices

### Basic Validation
The most common use case is a simple check of a PSL file's integrity.
```bash
pslCheck input.psl
```
*Note: If the tool is installed via Bioconda, the binary name is typically `pslCheck`.*

### Environment Setup
If you have just downloaded the binary from the UCSC servers, ensure it has execution permissions:
```bash
chmod +x ./pslCheck
```

### Common Patterns
While specific flags are discovered by running the tool without arguments, the following logic applies to the UCSC kent tool suite:
- **Standard Output**: The tool typically reports errors to `stderr`. If no output is produced, the file is generally considered valid.
- **Batch Processing**: When validating multiple files, use a loop to identify specific files with errors:
  ```bash
  for f in *.psl; do echo "Checking $f"; pslCheck "$f"; done
  ```

### Expert Tips
- **Format Verification**: PSL files are tab-separated. Ensure your input is not space-separated, as `pslCheck` will immediately flag this as a format error.
- **Coordinate Systems**: Remember that PSL files use a 0-indexed, half-open coordinate system. `pslCheck` is particularly strict about the `blockCount`, `blockSizes`, `qStarts`, and `tStarts` arrays matching the total span of the alignment.
- **Database Connectivity**: Although `pslCheck` primarily validates local file structure, some UCSC utilities require an `.hg.conf` file in your home directory if they need to verify coordinates against the UCSC MySQL database. If you encounter "permission denied" or "connection" errors while checking alignments against specific assemblies, verify your `.hg.conf` setup.

## Reference documentation
- [Bioconda ucsc-pslcheck Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-pslcheck_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)