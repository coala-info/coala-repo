---
name: ucsc-fatotwobit
description: This tool converts and compresses FASTA files into a randomly accessible .2bit binary format. Use when user asks to convert FASTA files to .2bit, compress genomic sequences, or combine multiple FASTA files into a single .2bit file.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-fatotwobit:482--hdc0a859_0"
---

# ucsc-fatotwobit

## Overview
The `faToTwoBit` utility is a specialized tool from the UCSC Genome Browser "Kent" suite designed to compress FASTA files into a randomly accessible binary format (.2bit). This format is significantly more compact than plain text FASTA and is the standard input for many UCSC bioinformatics utilities. It is particularly useful for handling large-scale genomic data where memory efficiency and rapid sequence retrieval are required.

## Usage Patterns

### Basic Conversion
The most common usage converts a single FASTA file (which may contain multiple records) into a single 2bit file.

```bash
faToTwoBit input.fa output.2bit
```

### Handling Multiple Input Files
You can provide multiple FASTA files as input; the tool will concatenate them into the single output 2bit file.

```bash
faToTwoBit chr1.fa chr2.fa chr3.fa genome.2bit
```

### Advanced Options
While the tool is simple, several flags allow for specific data handling:

- **-long**: Use this if your resulting 2bit file will exceed 4GB. This enables 64-bit offsets.
- **-noMask**: By default, `faToTwoBit` preserves masking information (lowercase letters in FASTA become masked regions in 2bit). Use this flag to treat all input as unmasked (uppercase).
- **-stripVersion**: Removes version numbers from accessions (e.g., "NM_001.1" becomes "NM_001").

### Verification
After conversion, it is best practice to verify the contents of the 2bit file using the companion tool `twoBitInfo`.

```bash
twoBitInfo output.2bit stdout | head
```

## Expert Tips
1. **Memory Efficiency**: 2bit files use 2 bits per base, effectively achieving a 4:1 compression ratio over raw text, while also storing 'N' (ambiguity) and masking data in separate internal indices.
2. **Random Access**: Unlike gzipped FASTA files, 2bit files allow tools to jump to any coordinate in any chromosome without decompressing the entire file, making it ideal for web servers and high-throughput alignment.
3. **Naming Consistency**: Ensure your FASTA headers do not contain spaces if you intend to use the resulting 2bit file with other UCSC tools, as everything after the first space in a FASTA header is typically ignored.

## Reference documentation
- [UCSC Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-fatotwobit_overview.md)
- [UCSC Linux x86_64 Binary Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)