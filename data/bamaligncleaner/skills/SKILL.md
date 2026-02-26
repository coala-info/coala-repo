---
name: bamaligncleaner
description: This tool removes unused reference sequences from BAM or CRAM alignment files to reduce header bloat and file size. Use when user asks to remove references with zero mapped reads, filter alignment files using a list of reference names, or clean up genomic alignment headers.
homepage: https://github.com/maxibor/bamAlignCleaner
---


# bamaligncleaner

## Overview
The `bamaligncleaner` tool is a specialized utility designed to streamline genomic alignment files by stripping away any reference sequences that do not have any reads mapped to them. In many bioinformatics workflows—especially metagenomics or large-scale screening—alignment headers can become bloated with thousands of unused reference entries. This tool filters the BAM/CRAM file so that the resulting output only contains the references that actually contributed to the alignment, making downstream processing faster and the files more manageable.

## Installation
The tool can be installed via Conda or Pip:
```bash
# Via Conda
conda install -c bioconda bamaligncleaner

# Via Pip
pip install bamAlignCleaner
```

## Core Usage Patterns

### Basic Cleaning
To remove all references with zero mapped reads and output to a new file:
```bash
bamAlignCleaner input.bam --output cleaned.bam
```

### Choosing the Optimal Method
The tool provides two distinct methods for identifying unaligned references. Choosing the right one depends on the ratio of reads to reference sequences:

1.  **Parse Method (`-m parse`)**: This is the default. It iterates through every read in the file.
    *   **Use case**: Best when you have a very large number of references (e.g., a massive metagenomic database) but a relatively small number of reads.
2.  **Index Stat Method (`-m index_stat`)**: This checks the BAM index (`.bai`) for the count of mapped reads per reference.
    *   **Use case**: Best when you have a high volume of reads but a smaller number of references.
    *   **Requirement**: The input BAM must be indexed.

```bash
# Using the index_stat method for high-depth samples
bamAlignCleaner -m index_stat input.bam -o cleaned.bam
```

### Filtering with External Lists
If you already know which references you want to keep, you can bypass the automatic detection:

*   **Using a text list**: Provide a file containing one reference name per line.
    ```bash
    bamAlignCleaner -r references_to_keep.txt input.bam -o filtered.bam
    ```
*   **Using a FASTA file**: Provide a FASTA file; only references present in this FASTA will be kept in the BAM.
    ```bash
    bamAlignCleaner -f subset_refs.fasta input.bam -o filtered.bam
    ```

## Expert Tips and Best Practices
*   **Input Requirements**: Always ensure your input BAM/CRAM file is **coordinate-sorted**. While the tool can automatically index files if needed, providing a pre-indexed file is more efficient when using the `index_stat` method.
*   **CRAM Support**: The tool natively supports CRAM files. When working with CRAM, ensure the reference genome used for the original alignment is accessible in your environment (e.g., via `REF_PATH` or `REF_CACHE`).
*   **Piping**: By default, the tool outputs to `STDOUT`. You can pipe the cleaned output directly into other tools like `samtools`:
    ```bash
    bamAlignCleaner input.bam | samtools view -C -o cleaned.cram
    ```
*   **Performance**: If your alignment has millions of references (common in some environmental DNA studies), the `parse` method is significantly more memory-efficient than standard header-replacement scripts.

## Reference documentation
- [github_com_maxibor_bamAlignCleaner.md](./references/github_com_maxibor_bamAlignCleaner.md)
- [anaconda_org_channels_bioconda_packages_bamaligncleaner_overview.md](./references/anaconda_org_channels_bioconda_packages_bamaligncleaner_overview.md)