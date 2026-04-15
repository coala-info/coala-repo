---
name: oligomap
description: Oligomap is a specialized alignment tool designed for the rapid mapping of small RNA sequences to a reference with zero or one error. Use when user asks to map sRNA sequences, find all occurrences of a query in a genome, or perform small RNA alignment with mismatches and indels.
homepage: https://github.com/zavolanlab/oligomap
metadata:
  docker_image: "quay.io/biocontainers/oligomap:1.0.1--h077b44d_1"
---

# oligomap

## Overview
Oligomap is a specialized alignment tool designed for the rapid mapping of small RNA (sRNA) sequences. Unlike general-purpose aligners, it is optimized to find all occurrences of a query sequence with either zero or one error (mismatch, insertion, or deletion). It is particularly effective for processing large libraries—around 500,000 sequences—within a modest memory footprint of approximately 2GB.

## Installation
The most reliable way to install oligomap is via Bioconda:
```bash
conda install -c bioconda oligomap
```
Alternatively, use the official Docker image:
```bash
docker pull quay.io/biocontainers/oligomap:1.0.1--hdcf5f25_0
```

## Command Line Usage
The basic syntax requires a target sequence file and a query library file, both in FASTA format.

```bash
oligomap target.fa query.fa [options] > output.oligomap
```

### Key Options
- `-s`: Restrict the search to the **plus strand** of the target only.
- `-d`: Treat the target argument as a **directory** containing multiple `.fa` files.
- `-r <path>`: Generate a summary **match report** at the specified path.
- `-m <int>`: Limit the **maximum number of hits** printed for a single query.

### Best Practices
- **Output Redirection**: By default, oligomap prints results to `STDOUT`. Always redirect to a file (conventionally using the `.oligomap` extension) to save results.
- **Memory Management**: Ensure at least 2GB of RAM is available when processing libraries of ~500,000 sequences.
- **Batch Processing**: Use the `-d` flag when you have a genome split into multiple chromosome files to avoid running the tool multiple times manually.
- **Reporting**: Use the `-r` flag to get a concise table showing the distribution of 0-error and 1-error matches per read, which is useful for downstream statistical analysis.

## Output Interpretation
Oligomap produces a 6-line alignment block for every match:
1. **Header**: Read name, length, read coordinates, reference name, and reference coordinates.
2. **Reference Name**: Repeated for clarity.
3. **Metadata**: Number of errors (0 or 1) and strand orientation (+ or -).
4. **Alignment**: Three lines showing the Read sequence, a match bar line (`|`), and the Reference sequence.

Example:
```text
read_1 (23 nc) 1..23 ref_chr_19 44377..44398
ref_chr_19
errors: 1 orientation: +
CTACAAAGGGAAGCACTTGTCTC
|||||||||||||||||| ||||
CTACAAAGGGAAGCACTT-TCTC
```

## Reference documentation
- [Oligomap GitHub Repository](./references/github_com_zavolanlab_oligomap.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_oligomap_overview.md)