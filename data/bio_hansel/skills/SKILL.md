---
name: bio_hansel
description: "bio_hansel performs fast, k-mer based subtyping of microbial pathogens from genomic assemblies or raw sequencing reads. Use when user asks to subtype Salmonella or Mycobacterium tuberculosis, identify specific sub-lineages for outbreak investigation, or process batch genomic data for public health surveillance."
homepage: https://github.com/phac-nml/bio_hansel
---


# bio_hansel

## Overview
The `bio_hansel` tool provides a fast, k-mer based approach to subtyping microbial pathogens without the need for full genome alignment. It is particularly effective for public health surveillance and outbreak investigation where rapid identification of specific sub-lineages is required. It supports both assembled genomes and raw sequencing reads, including gzipped files.

## Core Usage Patterns

### Basic Subtyping
To subtype a single FASTA or FASTQ file using an automatically detected built-in scheme:
```bash
hansel -o summary.tsv input_genome.fasta
```

### Specifying Schemes
While `bio_hansel` attempts to detect the appropriate scheme, it is best practice to specify it using `-s` if the serovar is known:
- **Salmonella:** `heidelberg`, `enteritidis`, `typhimurium`, `typhi`
- **M. tuberculosis:** `tb_lineage`

```bash
hansel -s enteritidis -o summary.tsv input_reads.fastq.gz
```

### Processing Paired-End Reads
For raw sequencing data, provide both forward and reverse reads:
```bash
hansel -p forward_R1.fastq.gz reverse_R2.fastq.gz -o summary.tsv
```

### Batch Processing
Process an entire directory of genomes efficiently:
```bash
hansel -D ./input_directory/ -o batch_summary.tsv -t 4
```
*Note: For paired-end files in a directory, ensure they follow the `_1.fastq` / `_2.fastq` naming convention for automatic pairing.*

## Advanced Configuration

### Output Formats
- **Standard Summary (`-o`):** Detailed tab-delimited results.
- **Simple Summary (`-S`):** A condensed version for quick review.
- **JSON Output (`--json`):** Use this when the output needs to be parsed by other scripts or downstream pipelines.

### Quality Control and Thresholds
Adjust these parameters if dealing with low-coverage or atypical data:
- `--min-kmer-freq`: Minimum frequency for a k-mer to be considered present (default is usually sufficient for assemblies, increase for raw reads).
- `--max-missing-kmers`: Increase this (0.0 - 1.0) if you are getting "Unknown" results due to fragmented assemblies.
- `--low-cov-warning`: Set a threshold to trigger warnings if the overall k-mer coverage is insufficient for confident typing.

## Expert Tips
- **Custom Schemes:** You can use your own subtyping schemes by providing a path to a custom k-mer file with `-s` and a metadata table with `-M`.
- **Performance:** Always use the `-t` (threads) flag when processing multiple samples to significantly reduce wall-clock time.
- **Input Flexibility:** The tool natively handles `.fasta`, `.fa`, `.fna`, `.fastq`, and `.fq` formats, including their `.gz` compressed versions. No pre-decompression is required.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_phac-nml_biohansel.md)
- [Installation and Versioning](./references/anaconda_org_channels_bioconda_packages_bio_hansel_overview.md)