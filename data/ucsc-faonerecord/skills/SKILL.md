---
name: ucsc-faonerecord
description: This tool extracts a single sequence record from a FASTA file. Use when user asks to extract a single sequence record from a FASTA file, extract a specific chromosome, or extract a scaffold.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-faonerecord

## Overview
The `faOneRecord` utility is a specialized tool from the UCSC Genome Browser "kent" suite designed for high-efficiency extraction of a single sequence from a FASTA file. While general-purpose tools like `grep` or `awk` can be used for this task, `faOneRecord` is optimized for the FASTA format, ensuring that the entire sequence associated with a header is captured correctly without complex scripting.

Use this tool when:
- You have a large multi-FASTA file (e.g., a whole genome assembly).
- You need to extract exactly one record based on its header ID.
- You want a lightweight, reliable command-line solution that handles FASTA line wrapping automatically.

## Usage and Best Practices

### Basic Command Pattern
The tool follows a simple positional argument structure:

```bash
faOneRecord input.fa recordName
```

- **input.fa**: The source multi-FASTA file.
- **recordName**: The exact string found in the FASTA header (excluding the `>` symbol).

### Common Workflows

**Extracting a specific chromosome:**
To extract "chr1" from a human genome assembly file:
```bash
faOneRecord hg38.fa chr1 > chr1.fa
```

**Extracting a scaffold from a draft assembly:**
```bash
faOneRecord assembly.fa scaffold_452 > scaffold_452.fa
```

### Expert Tips
- **Exact Matching**: The `recordName` must match the header ID exactly. If the header is `>chr1 [organism=Homo sapiens]`, searching for `chr1` will work as the tool typically looks for the first space-delimited token.
- **Redirection**: By default, the tool outputs the record to `stdout`. Always use a redirect (`>`) to save the output to a new file.
- **Permissions**: If using a manually downloaded binary from the UCSC server instead of a Conda package, ensure the file is executable:
  ```bash
  chmod +x faOneRecord
  ./faOneRecord input.fa recordName
  ```
- **Large Files**: For extremely large files where you need to extract *multiple* specific records, consider using `faSomeRecords` instead, as `faOneRecord` is strictly for single-entry extraction.

## Reference documentation
- [ucsc-faonerecord - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-faonerecord_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)