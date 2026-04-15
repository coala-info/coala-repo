---
name: ucsc-subchar
description: This tool replaces every instance of a specific character with another throughout a file. Use when user asks to replace characters in large files, convert tab-separated values to comma-separated values, or sanitize identifiers by replacing spaces with underscores.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-subchar:482--h0b57e2e_0"
---

# ucsc-subchar

## Overview
The `ucsc-subchar` utility (often installed as the binary `subChar`) is a specialized tool from the UCSC Genome Browser "kent" suite. It provides a streamlined, high-performance method for replacing every instance of a specific character with another throughout a file. While similar to the Unix `tr` command, it is optimized for the workflows and file sizes common in bioinformatics, ensuring minimal memory overhead when processing massive sequence or annotation files.

## Usage Instructions

### Basic Syntax
The tool requires four arguments: the character to replace, the replacement character, the input file, and the output file.

```bash
subChar <old_char> <new_char> <input_file> <output_file>
```

### Common CLI Patterns

**1. Converting Tab-Separated Values (TSV) to Comma-Separated Values (CSV)**
Useful for preparing genomic data for spreadsheet software or databases that prefer CSV.
```bash
subChar '\t' ',' input.tsv output.csv
```

**2. Replacing Spaces with Underscores**
Commonly used to sanitize headers or identifiers in FASTA or BED files where whitespace can break downstream parsers.
```bash
subChar ' ' '_' input.txt sanitized.txt
```

**3. Removing Specific Characters (Substitution with Null/Alternative)**
Note that `subChar` is strictly for 1-to-1 character substitution. If you need to "delete" a character, you must substitute it with a placeholder or use a different tool like `tr -d`.

### Expert Tips
*   **Binary Name:** Although the package is named `ucsc-subchar` in Bioconda, the executable command is typically `subChar`.
*   **Special Characters:** When using special characters like tabs (`\t`) or newlines, ensure they are properly escaped or quoted depending on your shell environment.
*   **Large File Performance:** `subChar` is significantly faster than complex `sed` scripts for simple character swaps because it does not use regex engines. Use it for multi-gigabyte files to save time.
*   **Permissions:** If you downloaded the binary directly from the UCSC server, remember to set execution permissions: `chmod +x subChar`.
*   **In-place Editing:** `subChar` does not support in-place editing. You must always specify a distinct output file. To overwrite the original, use: `subChar 'A' 'B' file.txt temp.txt && mv temp.txt file.txt`.

## Reference documentation
- [ucsc-subchar Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-subchar_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)