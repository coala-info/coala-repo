---
name: ucsc-psltopslx
description: The `pslToPslx` utility is a specialized tool from the UCSC Genome Browser "kent" source suite.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-psltopslx

## Overview
The `pslToPslx` utility is a specialized tool from the UCSC Genome Browser "kent" source suite. While standard PSL files describe the geometry of an alignment (coordinates, matches, gaps), they do not contain the nucleotide or amino acid sequences themselves. This tool bridges that gap by fetching sequences from specified source files and appending them to the PSL records, creating a PSLX file. This is essential for "pretty-printing" alignments or performing downstream sequence-level analysis without constantly re-querying large FASTA or 2bit files.

## Usage Instructions

### Basic Command Syntax
The tool requires the input PSL, the sequence sources for both target and query, and the output filename.

```bash
pslToPslx [options] input.psl targetSequence querySequence output.pslx
```

### Sequence Source Formats
The `targetSequence` and `querySequence` arguments can be:
*   **FASTA files (.fa / .fasta)**: Standard sequence files.
*   **2bit files (.2bit)**: Compressed, indexed binary sequence files (recommended for large genomes).
*   **NIB files (.nib)**: Older UCSC single-sequence files.
*   **Directories**: A path containing multiple .nib or .fa files.

### Common Patterns

**Converting with 2bit files (Efficient)**
If you are working with standard assemblies (like hg38), using 2bit files is the most performance-efficient method.
```bash
pslToPslx alignments.psl hg38.2bit queries.2bit output.pslx
```

**Converting with FASTA files**
```bash
pslToPslx alignments.psl target.fa query.fa output.pslx
```

### Expert Tips
*   **Sequence Masking**: If your input sequences are soft-masked (lowercase), `pslToPslx` will preserve that masking in the PSLX output. This is useful for identifying alignments in repetitive regions.
*   **Validation**: Always run `pslCheck` on your resulting PSLX file if you intend to upload it as a custom track to the UCSC Genome Browser, as the added sequence data must perfectly match the alignment coordinates.
*   **Permissions**: If you downloaded the binary directly from the UCSC server, ensure it is executable: `chmod +x pslToPslx`.
*   **Database Connectivity**: Some UCSC tools require a `.hg.conf` file in your home directory to connect to public MySQL servers, though `pslToPslx` typically operates on local files.

## Reference documentation
- [UCSC Administrative Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-psltopslx Package Metadata](./references/anaconda_org_channels_bioconda_packages_ucsc-psltopslx_overview.md)
- [UCSC Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)