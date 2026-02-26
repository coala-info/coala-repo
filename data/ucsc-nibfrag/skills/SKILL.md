---
name: ucsc-nibfrag
description: This tool extracts specific genomic sequence fragments from .nib files and converts them to FASTA format. Use when user asks to extract genomic sequence fragments, obtain reverse complements, or convert .nib files to FASTA.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-nibfrag

## Overview
The `nibFrag` utility is a specialized tool from the UCSC Genome Browser "kent" source suite designed to handle .nib files. A .nib file stores a genomic sequence with 4 bits per base, allowing for efficient storage of DNA. This skill enables the extraction of specific fragments from these files, converting them into standard FASTA format for downstream analysis. It is particularly useful when working with older genomic datasets or specific UCSC pipelines that utilize the NIB format instead of the more modern 2bit format.

## Usage Instructions

### Basic Command Syntax
The tool follows a strict positional argument structure:
```bash
nibFrag [options] file.nib start end strand out.fa
```
*   **file.nib**: The source NIB file.
*   **start**: The starting position (0-indexed).
*   **end**: The ending position.
*   **strand**: Use `+` for forward strand or `-` for reverse complement.
*   **out.fa**: The destination FASTA file.

### Common CLI Patterns

**Extracting a specific region:**
To extract bases 1000 to 5000 from the forward strand:
```bash
nibFrag genome.nib 1000 5000 + fragment.fa
```

**Extracting the reverse complement:**
To extract the same region but as a reverse complement:
```bash
nibFrag genome.nib 1000 5000 - fragment_rc.fa
```

**Using with pipes:**
You can direct the output to stdout by using `stdout` as the filename:
```bash
nibFrag genome.nib 0 100 + stdout
```

### Expert Tips & Best Practices
*   **Coordinate System**: `nibFrag` uses 0-indexed, half-open coordinates (similar to BED format). The `start` is inclusive, and the `end` is exclusive.
*   **Case Sensitivity**: By default, `nibFrag` often outputs sequences in lower case. If your downstream tools require upper case, pipe the output to a transformer:
    ```bash
    nibFrag seq.nib 0 500 + stdout | seqtk seq -U > upper.fa
    ```
*   **NIB vs 2bit**: While .nib files represent a single sequence (usually one chromosome per file), .2bit files can store an entire genome. If you have a .2bit file, use `twoBitToFa` instead. Use `nibFrag` specifically when the source data is already partitioned into .nib files.
*   **Permissions**: If running the binary directly after download from UCSC, ensure it has execution permissions:
    ```bash
    chmod +x nibFrag
    ```

## Reference documentation
- [ucsc-nibfrag - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-nibfrag_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)