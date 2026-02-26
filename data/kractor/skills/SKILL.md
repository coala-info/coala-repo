---
name: kractor
description: "kractor extracts raw sequence data from FASTQ or FASTA files based on Kraken2 taxonomic classifications. Use when user asks to extract reads for specific taxon IDs, filter out host sequences, or include taxonomic children in sequence extraction."
homepage: https://github.com/Sam-Sims/kractor
---


# kractor

## Overview
kractor is a high-performance Rust-based utility designed to bridge the gap between Kraken2 taxonomic classification and downstream analysis. While Kraken2 identifies the organisms in a sample, kractor performs the actual extraction of the raw sequence data. It is significantly faster than traditional Python-based alternatives like KrakenTools, making it ideal for processing large-scale metagenomic datasets. It supports both single and paired-end reads, handles compressed files (.gz, .bz2) natively, and can navigate the taxonomic tree to include related taxa (parents or children) during extraction.

## Core Usage Patterns

### Basic Extraction
To extract reads for a specific Taxon ID from a single-end FASTQ file:
```bash
kractor -i input.fastq -o output.fastq -k kraken_output.txt -t <TAXID>
```

### Paired-End Extraction
For paired-end data, provide the input and output flags twice. The order of output files must match the order of input files:
```bash
kractor -i R1.fq.gz -i R2.fq.gz -o out_R1.fq.gz -o out_R2.fq.gz -k kraken_output.txt -t <TAXID>
```

### Working with Taxonomic Hierarchies
If you need to extract an entire group (e.g., all reads within a specific family), use the `--children` flag. This requires the Kraken2 report file (`-r`) in addition to the standard output file (`-k`):
```bash
kractor -i input.fq -o output.fq -k kraken.out -r kraken.report -t <TAXID> --children
```

### Excluding Specific Taxa
To remove specific reads (e.g., removing host/human reads from a clinical sample), use the `--exclude` flag:
```bash
kractor -i sample.fq -o filtered.fq -k kraken.out -t 9606 --exclude
```

## Expert Tips and Best Practices

*   **Memory Efficiency**: kractor uses approximately 4.5 MB of RAM even for massive (17 GB+) FASTQ files. You do not need to request high-memory nodes on HPC clusters for this task.
*   **Compression Handling**: Output compression is automatically inferred from the file extension (e.g., `.gz` or `.bz2`). You can manually override this or set the compression level (1-9) using `--compression-level`. Level 2 is the default, providing a good balance between speed and file size.
*   **Multiple Taxa**: You can pass multiple Taxon IDs to a single command: `-t 562 10239`.
*   **Summary Statistics**: Always use the `--summary` flag when running in a pipeline. It outputs a JSON object to stdout containing the proportion of reads extracted and identifies any requested Taxon IDs that were missing from the Kraken2 results.
*   **Format Conversion**: If your downstream tool requires FASTA but your input is FASTQ, use the `--output-fasta` flag to perform the conversion during extraction, saving a separate processing step.

## Reference documentation
- [kractor GitHub Repository](./references/github_com_Sam-Sims_kractor.md)
- [kractor Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kractor_overview.md)