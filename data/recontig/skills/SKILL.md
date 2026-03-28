---
name: recontig
description: "recontig translates chromosome and contig identifiers between different reference naming standards in genomic files. Use when user asks to convert contig names between UCSC, Ensembl, or NCBI formats, remap headers and records in VCF, BAM, or SAM files, or create custom contig mapping files."
homepage: https://github.com/blachlylab/recontig
---

# recontig

## Overview

recontig is a high-performance bioinformatics utility designed to bridge the gap between divergent reference naming standards. It allows for the seamless translation of chromosome and contig identifiers (e.g., "chr1" vs "1") within the headers and records of standard genomic files. By leveraging the speed of the D language and htslib, it handles large-scale datasets, including compressed and remote files, ensuring that downstream analysis tools receive consistent and compatible input.

## Core CLI Usage

The primary command for recontig is `convert`. It typically requires a build version, a conversion direction, and a file format specification.

### Basic Syntax
```bash
recontig convert -b <build> -c <conversion> -f <format> <input_file>
```

### Key Parameters
- `-b, --build`: The reference assembly build (e.g., `GRCh37`, `GRCh38`, `hg19`, `hg38`).
- `-c, --conv`: The conversion direction (e.g., `UCSC2ensembl`, `ensembl2UCSC`, `NCBI2UCSC`).
- `-f, --format`: The input file format (`vcf`, `bcf`, `sam`, `bam`, `gff`, `bed`).
- `-o, --output`: Specify an output filename (defaults to stdout).

## Common Patterns and Examples

### Converting VCF Files
To convert a compressed VCF from UCSC naming to Ensembl naming for the GRCh37 build:
```bash
recontig convert -b GRCh37 -c UCSC2ensembl -f vcf in.vcf.gz > out.vcf
```

### Handling Remote Files
recontig natively supports remote files via HTTP(S) or Amazon S3, handling the download and decompression automatically:
```bash
recontig convert -b GRCh38 -c ensembl2UCSC -f bam https://example.com/data/input.bam -o output.bam
```

### Working with SAM/BAM
Note that while most formats output uncompressed text to stdout, the `-f bam` flag will trigger BAM binary output, whereas `-f sam` will output plain text SAM.

## Expert Tips and Best Practices

- **Stream Processing**: Since recontig defaults to stdout, it is ideal for use in command-line pipes to avoid creating large intermediate files.
- **Mapping Files**: recontig can automatically download mapping specifications (such as those from dpryan79) on-the-fly if they are not provided locally.
- **Header Integrity**: Unlike simple `sed` replacements, recontig correctly modifies both the file headers (e.g., `@SQ` lines in SAM or `##contig` lines in VCF) and the individual data records to maintain file format specification compliance.
- **Python Integration**: For developers, the `pyrecontig` module (built via PyD) allows the core D-engine speed to be utilized directly within Python scripts for custom workflow development.



## Subcommands

| Command | Description |
|---------|-------------|
| recontig convert | remap contig names for different bioinformatics file types. |
| recontig make-mapping | make a contig conversion file from two fasta files |
| recontig_conversion-help | check availiable conversions for a specified build from dpryan79's github |

## Reference documentation

- [GitHub Repository Overview](./references/github_com_blachlylab_recontig.md)
- [Installation and Setup Guide](./references/github_com_blachlylab_recontig_blob_master_INSTALL.md)
- [README and Quick Start](./references/github_com_blachlylab_recontig_blob_master_README.md)