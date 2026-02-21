---
name: ngsep
description: NGSEP (Next Generation Sequencing Experience Platform) is a comprehensive Java-based framework for analyzing high-throughput sequencing data from both short and long-read platforms.
homepage: https://github.com/NGSEP/NGSEPcore
---

# ngsep

## Overview

NGSEP (Next Generation Sequencing Experience Platform) is a comprehensive Java-based framework for analyzing high-throughput sequencing data from both short and long-read platforms. It provides a modular workflow for reference-guided variant discovery—covering SNVs, small and large indels, STRs, inversions, and CNVs—as well as tools for de-novo assembly, k-mer analysis, and extensive VCF file processing.

## Core Execution Pattern

NGSEP is distributed as a runnable JAR file. The general syntax for all modules is:

```bash
java -jar NGSEPcore.jar <MODULE> <OPTIONS>
```

To list all available modules:
```bash
java -jar NGSEPcore.jar --help
```

To get specific help for a module:
```bash
java -jar NGSEPcore.jar <MODULE> --help
```

## Common CLI Workflows

### 1. Read Processing and Quality Control

**Demultiplexing Reads**
Separate barcoded samples into individual FASTQ files.
- Use `-i` for a tab-delimited index file (flowcell, lane, barcode, sampleID).
- Use `-f` and `-f2` for single or paired-end raw reads.
- Use `-d` to specify a file listing multiple lane FASTQ files.

```bash
java -jar NGSEPcore.jar Demultiplex -i index.txt -f reads_R1.fastq.gz -f2 reads_R2.fastq.gz -o output_directory/
```

**Filtering FASTQ Files**
Filter reads based on length and quality scores.
- `-m`: Minimum read length.
- `-q`: Minimum average quality score.

```bash
java -jar NGSEPcore.jar FastqFileFilter -i input.fastq.gz -o filtered.fastq.gz -m 50 -q 20
```

### 2. Genomic Analysis

**K-mer Extraction**
Generate k-mer abundance distributions from FASTA or FASTQ files.
- `-k`: K-mer length (default 15).
- `-m`: Minimum count to report (default 5).

```bash
java -jar NGSEPcore.jar KmersExtractor -k 21 -m 10 -o kmer_output input.fastq.gz
```

**Variant Detection**
NGSEP performs accurate detection and genotyping of:
- Single Nucleotide Variants (SNVs)
- Small and large Indels
- Short Tandem Repeats (STRs)
- Copy Number Variants (CNVs) and Inversions

### 3. VCF Downstream Analysis

NGSEP provides specialized utilities for manipulating VCF files:
- **Functional Annotation**: Predict the effect of variants on genes.
- **Filtering**: Remove low-quality variants or specific samples.
- **Comparison**: Compare variant calls between different datasets or tools.
- **Population Genetics**: Perform clustering, imputation, and introgression analysis.

## Expert Tips and Best Practices

- **Memory Allocation**: As a Java application, NGSEP may require significant memory for large genomic datasets. Always use the `-Xmx` flag to allocate sufficient heap space (e.g., `java -Xmx16g -jar NGSEPcore.jar ...`).
- **Gzip Support**: Most modules natively support `.gz` compressed FASTQ and VCF files, saving disk space and I/O time.
- **Version 5+ Features**: If using version 5.0 or higher, leverage new modules for read alignment, error correction, and de-novo assembly of long-read whole genome sequencing (WGS) data.
- **Naming Convention**: For convenience, create a symbolic link to the versioned JAR file (e.g., `ln -s NGSEPcore_5.1.1.jar NGSEPcore.jar`) to keep scripts version-agnostic.

## Reference documentation
- [NGSEPcore Overview](./references/github_com_NGSEP_NGSEPcore.md)
- [Bioconda NGSEP Package](./references/anaconda_org_channels_bioconda_packages_ngsep_overview.md)