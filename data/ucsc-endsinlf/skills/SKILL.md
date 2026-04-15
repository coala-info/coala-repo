---
name: ucsc-endsinlf
description: ucsc-endsinlf verifies that a text file is properly terminated with a line feed character. Use when user asks to 'check if a file ends in a line feed', 'validate file line endings', or 'perform quality control on file line endings'.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
metadata:
  docker_image: "quay.io/biocontainers/ucsc-endsinlf:377--h199ee4e_0"
---

# ucsc-endsinlf

## Overview
The `endsInLf` utility is a specialized validation tool from the UCSC Genome Browser "kent" source suite. Its primary purpose is to verify that a text file is properly terminated with a line feed (LF) character. In many bioinformatics workflows, files missing a trailing newline can cause parsing errors, truncated data, or unexpected behavior in downstream command-line tools. This skill provides guidance on integrating this check into data quality control (QC) routines.

## Usage Patterns

### Basic Validation
To check if a file ends in a line feed, run the command with the filename as the argument:

```bash
endsInLf filename.txt
```

### Behavior and Output
- **Success**: If the file ends with a line feed, the tool typically exits silently with a return code of 0.
- **Failure**: If the file does not end with a line feed, the tool will report the discrepancy.
- **Usage Statement**: Running the command without arguments displays the basic usage help.

### Batch Processing
When processing large genomic datasets (e.g., a directory of chromosome-specific BED files), use a loop to validate all files:

```bash
for file in *.bed; do
    echo "Checking $file..."
    endsInLf "$file"
done
```

## Expert Tips and Best Practices

### Integration with fixCr
If `endsInLf` reports issues, it is often due to Windows-style line endings (CRLF) or a completely missing final newline. Use the companion tool `fixCr` to normalize line endings before re-validating:
1. Run `fixCr filename.txt` to convert CRLF to LF.
2. If the last line is still missing a newline, append it using `echo >> filename.txt`.

### Permission Handling
If you encounter a "permission denied" error when running the binary, ensure the execution bit is set:
```bash
chmod +x endsInLf
./endsInLf filename.txt
```

### Pipeline Quality Control
Incorporate `endsInLf` as a pre-processing step in shell scripts. This prevents complex tools like `bedToBigBed` or `faToTwoBit` from failing due to malformed input files:

```bash
endsInLf input.bed || { echo "Error: input.bed missing trailing newline"; exit 1; }
# Proceed with processing
```

## Reference documentation
- [Bioconda ucsc-endsinlf Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-endsinlf_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Executables List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)