---
name: ucsc-catuncomment
description: The `catUncomment` utility is a specialized concatenation tool from the UCSC Genome Browser "kent" source tree.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-catuncomment

## Overview

The `catUncomment` utility is a specialized concatenation tool from the UCSC Genome Browser "kent" source tree. Unlike the standard Unix `cat` command, it filters the input stream to remove any line beginning with a hash character (`#`). This is particularly useful in bioinformatics pipelines for stripping headers from BED, GFF, or custom tabular files before passing them to tools that do not natively handle comment lines.

## Usage Instructions

### Basic Syntax
The tool can read from one or more files or from standard input.

```bash
catUncomment [file1] [file2] ...
```

### Common Patterns

**1. Cleaning a single file**
To remove comments from a file and save the result:
```bash
catUncomment input.txt > clean_output.txt
```

**2. Merging multiple datasets**
Concatenate multiple files into a single stream while ensuring all internal comments and headers are removed:
```bash
catUncomment data_part1.txt data_part2.txt data_part3.txt > merged_data.txt
```

**3. Piping from other tools**
Use standard input to filter the output of another process:
```bash
grep "pattern" large_file.txt | catUncomment > filtered_clean.txt
```

## Expert Tips and Best Practices

*   **Strict Line Start**: The tool specifically looks for `#` at the very beginning of the line. It does not remove trailing comments (comments starting mid-line).
*   **Permission Handling**: If using the binary directly from the UCSC download server, ensure you have execution permissions: `chmod +x catUncomment`.
*   **Stream Processing**: `catUncomment` is highly efficient for large genomic datasets because it processes the file as a stream rather than loading the entire file into memory.
*   **Preserving Data Integrity**: Use this tool only when you are certain that no valid data lines begin with `#`. In some specific formats, `#` might be used for data; in those cases, use standard `cat` or a more specific `awk` filter.

## Reference documentation

- [ucsc-catuncomment Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-catuncomment_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)