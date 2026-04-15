---
name: ucsc-fafrag
description: The `ucsc-fafrag` tool extracts a specific DNA sequence fragment from a FASTA file using defined coordinates. Use when user asks to extract a specific DNA fragment, pull out a window of DNA, extract promoter regions, specific genes, or flanking sequences.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-fafrag:482--h0b57e2e_0"
---

# ucsc-fafrag

## Overview
The `faFrag` utility is a specialized tool from the UCSC Genome Browser "kent" source tree designed for high-performance sequence extraction. It allows researchers to pull out a specific window of DNA from a larger FASTA file by defining the start and end coordinates. This is particularly useful for extracting promoter regions, specific genes, or flanking sequences for primer design from large-scale genomic data.

## Usage Patterns

### Basic Extraction
The standard syntax requires the input file, the sequence name (e.g., chromosome), the start and end positions, and the output filename.

```bash
faFrag <input.fa> <sequence_name> <start> <end> <output.fa>
```

*   **Coordinates**: Note that UCSC tools typically use 0-based, half-open coordinates (the start is inclusive, the end is exclusive).
*   **Example**: To extract the first 100 bases of chromosome 1:
    `faFrag hg38.fa chr1 0 100 fragment.fa`

### Common CLI Workflows
*   **Extracting Multiple Regions**: `faFrag` is designed for single-fragment extraction. For batch extraction of multiple regions defined in a BED file, consider using `faSomeRecords` or `bitToFa` if the source is in 2bit format.
*   **Permission Handling**: If running a freshly downloaded binary, ensure it is executable:
    `chmod +x faFrag`

## Expert Tips and Best Practices
*   **Memory Efficiency**: `faFrag` is more efficient than general text processing tools (like `sed` or `awk`) for FASTA files because it is optimized for the FASTA format structure.
*   **Sequence Names**: The `<sequence_name>` must exactly match the header in the FASTA file (the string immediately following the `>` character).
*   **Large Genomes**: When working with whole-genome files, ensure you have indexed the file or are using the correct chromosome name to avoid scanning the entire file unnecessarily.
*   **Output Format**: The output is a standard FASTA file containing only the requested fragment, with a header indicating the source and coordinates.

## Reference documentation
- [UCSC Genome Browser Admin Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-fafrag Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-fafrag_overview.md)
- [Linux x86_64 Binary Directory](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)