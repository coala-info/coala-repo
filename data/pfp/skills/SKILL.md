---
name: pfp
description: The `pfp` tool implements a dictionary-based compression strategy called Prefix-Free Parsing.
homepage: https://github.com/marco-oliva/pfp
---

# pfp

## Overview

The `pfp` tool implements a dictionary-based compression strategy called Prefix-Free Parsing. This technique is a critical preprocessing step for building Burrows-Wheeler Transforms (BWTs) on massive datasets, such as pangenomes or large collections of sequencing reads. By decomposing a text into a dictionary of phrases and a parse, `pfp` allows downstream tools to construct BWTs in a memory-efficient manner. It is specifically optimized for genomic data, supporting direct input from FASTA files or the generation of consensus sequences from VCF files and a reference.

## Core CLI Usage

The primary executable is `pfp++`.

### Basic FASTA Parsing
To parse a standard FASTA file:
```bash
pfp++ -f input.fasta -o output_prefix
```

### VCF-Based Parsing
`pfp` can process variants directly against a reference. This is often more efficient than manually creating consensus FASTA files.
```bash
pfp++ -r reference.fa -v variants.vcf.gz -o output_prefix
```
*Note: VCF files must be in genome order.*

### Performance Tuning
*   **Multi-threading**: Use `-j` to specify the number of threads.
    ```bash
    pfp++ -f input.fa -o out -j 8
    ```
*   **Window and Modulo**: Adjust the sliding window size (`-w`, default range 3-200) and the modulo (`-p`, default range 5-20000) to control the granularity of the parse.
    ```bash
    pfp++ -f input.fa -o out -w 10 -p 100
    ```

## Expert Tips and Best Practices

### VCF Acceleration
When working with multiple samples or iterative runs on the same reference, use the acceleration flag to avoid redundant parsing of the reference sequence:
```bash
pfp++ -r reference.fa -v variants.vcf.gz --use-vcf-acceleration -o output_prefix
```

### Data Cleaning
Genomic files often contain non-ACGT characters (like 'N' or IUPAC codes) that can complicate downstream BWT construction. Use the `--acgt-only` flag to normalize these to 'N':
```bash
pfp++ -f input.fa --acgt-only -o output_prefix
```

### Handling Large Sample Sets
If you have a specific list of samples to analyze from a multi-sample VCF, provide a sample file:
```bash
pfp++ -v variants.vcf.gz -S samples_list.txt -o output_prefix
```

### Output Management
*   **Compressed Dictionary**: Use `-c` or `--compress-dictionary` to reduce the disk footprint of the resulting dictionary file.
*   **Statistics**: Use `--print-statistics` to output a CSV containing parsing metrics, which is useful for benchmarking and quality control.
*   **Auxiliary Arrays**: If your downstream BWT tool requires the Document Array (last) or Suffix Array Intervals (sai), use `--output-last` and `--output-sai`.

## Reference documentation
- [pfp Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pfp_overview.md)
- [pfp GitHub Repository](./references/github_com_marco-oliva_pfp.md)