---
name: ucsc-genepredtoprot
description: The `ucsc-genepredtoprot` tool translates gene prediction data and a reference sequence into amino acid sequences. Use when user asks to 'validate gene models', 'perform proteogenomics analysis', or 'generate custom protein databases for mass spectrometry'.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---


# ucsc-genepredtoprot

## Overview
The `genePredToProt` utility is a specialized tool from the UCSC Genome Browser "Kent" suite. It automates the translation of genomic coordinates into amino acid sequences. By taking gene prediction data—which defines exons, introns, and coding start/stop sites—and a reference sequence, it produces a FASTA file containing the resulting proteins. This is particularly useful for validating gene models, performing proteogenomics analysis, or generating custom protein databases for mass spectrometry.

## Usage Instructions

### Basic Command Syntax
The tool requires a gene prediction file and a reference sequence (typically in `.2bit` or FASTA format) to generate the protein output.

```bash
genePredToProt [options] input.gp sequence.2bit output.faa
```

### Common CLI Patterns
- **Using FASTA instead of 2bit**: If your reference genome is in FASTA format, use the `-fa` flag.
- **Including the Codon Table**: For non-standard genetic codes (e.g., mitochondrial DNA), ensure the environment or parameters are set to handle alternative translation tables if supported by your specific version.
- **Input Validation**: Use `genePredCheck` (another UCSC utility) before running this tool to ensure the input `.gp` file is correctly formatted and coordinates are within the bounds of the reference sequence.

### Expert Tips
- **Permission Errors**: If running a freshly downloaded binary, you must grant execution permissions: `chmod +x genePredToProt`.
- **Database Connectivity**: Some versions of UCSC tools can pull data directly from the UCSC MySQL servers. This requires a `.hg.conf` file in your home directory with the appropriate credentials (user: `genome`, host: `genome-mysql.soe.ucsc.edu`).
- **Format Conversion**: If your data is in GTF or GFF3 format, use `gtfToGenePred` or `gff3ToGenePred` first, as this tool specifically expects the genePred format.
- **Silent Usage**: Running the command without any arguments will display the full list of available flags and version information for your specific build.

## Reference documentation
- [Bioconda ucsc-genepredtoprot Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-genepredtoprot_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary Directory](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)