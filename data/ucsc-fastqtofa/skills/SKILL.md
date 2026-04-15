---
name: ucsc-fastqtofa
description: The `ucsc-fastqtofa` tool converts FASTQ files to FASTA format. Use when user asks to 'convert FASTQ to FASTA' or 'transform FASTQ to FASTA'.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-fastqtofa:482--h0b57e2e_0"
---

# ucsc-fastqtofa

## Overview

The `fastqToFa` utility is a specialized command-line tool designed for the rapid transformation of FASTQ files into FASTA format. While FASTQ files are essential for initial quality control and alignment due to their inclusion of Phred quality scores, many downstream bioinformatics applications—such as certain types of de novo assembly, k-mer analysis, or sequence database indexing—only require the raw nucleotide sequences. 

Use this skill to perform these conversions efficiently, especially when working in high-performance computing (HPC) environments or when quality scores are no longer needed for your specific analysis pipeline.

## Usage Instructions

### Basic Command Pattern
The tool follows the standard UCSC Kent utility syntax, requiring an input file and an output destination:

```bash
fastqToFa input.fastq output.fa
```

### Working with Compressed Files
UCSC utilities typically support gzipped input directly. If your FASTQ files are compressed (e.g., `.fastq.gz`), you can often run:

```bash
fastqToFa input.fastq.gz output.fa
```

If the specific version does not support direct decompression, use a pipe:

```bash
zcat input.fastq.gz | fastqToFa stdin output.fa
```

### Installation via Bioconda
If the tool is not present in the environment, it can be installed using:

```bash
conda install bioconda::ucsc-fastqtofa
```

## Expert Tips and Best Practices

1. **Memory Efficiency**: Unlike many script-based converters (Python or Perl), `fastqToFa` is written in C and is highly efficient. It is the preferred choice for processing "Big Data" sequencing runs (e.g., Illumina NovaSeq outputs).
2. **Permission Errors**: If running the binary directly from a download, ensure it has execution permissions: `chmod +x fastqToFa`.
3. **Validation**: After conversion, it is good practice to verify the sequence count matches the original file. You can use `grep -c "^+" input.fastq` and compare it to `grep -c "^>" output.fa`.
4. **Quality Score Removal**: Remember that this process is destructive regarding quality data. Ensure you have a backup of the original FASTQ files if you might need to perform quality-aware re-alignment later.
5. **Standard Kent Flags**: Most UCSC utilities support a `-verbose` flag. If you need to debug a malformed FASTQ file, try:
   ```bash
   fastqToFa -verbose=2 input.fastq output.fa
   ```

## Reference documentation

- [ucsc-fastqtofa overview](./references/anaconda_org_channels_bioconda_packages_ucsc-fastqtofa_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [UCSC Linux x86_64 Utility List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)