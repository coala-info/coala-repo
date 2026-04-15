---
name: seqsero
description: SeqSero2 performs digital serotyping of Salmonella from raw sequencing data or genome assemblies. Use when user asks to predict Salmonella serotypes, perform allele micro-assembly for contamination detection, or run rapid k-mer based screening.
homepage: https://github.com/denglab/SeqSero2
metadata:
  docker_image: "biocontainers/seqsero:v1.0.1dfsg-1-deb_cv1"
---

# seqsero

## Overview
SeqSero2 is a specialized pipeline designed for the digital serotyping of Salmonella. It transforms raw sequencing data or assembled genomes into serotype predictions, effectively replacing traditional phenotypic agglutination methods. This skill should be used to select the appropriate analysis workflow—either the high-resolution Allele Micro-assembly mode for detailed determinant analysis and contamination detection, or the rapid K-mer mode for fast screening and assembly-based prediction.

## Command Line Usage

The primary executable is `SeqSero2_package.py`.

### Core Workflow Selection (-m)
*   **Allele Micro-assembly (`-m a`)**: The default mode. Performs targeted assembly of serotype alleles. Best for high accuracy and identifying inter-serotype contamination in raw reads.
*   **K-mer (`-m k`)**: Rapid prediction based on unique k-mers. Required for genome assemblies and faster for raw reads.

### Input Data Types (-t)
Specify the input format using the `-t` flag:
*   `1`: Interleaved paired-end reads
*   `2`: Separated paired-end reads (requires two files after `-i`)
*   `3`: Single-end reads
*   `4`: Genome assembly (requires `-m k`)
*   `5`: Nanopore reads (FASTA/FASTQ)

### Common CLI Patterns

**1. Standard Allele Analysis (Separated Paired-End)**
```bash
SeqSero2_package.py -m a -t 2 -i read_R1.fastq.gz read_R2.fastq.gz -p 4
```

**2. Rapid K-mer Analysis (Separated Paired-End)**
```bash
SeqSero2_package.py -m k -t 2 -i read_R1.fastq.gz read_R2.fastq.gz
```

**3. Serotyping a Genome Assembly**
```bash
SeqSero2_package.py -m k -t 4 -i assembly.fasta
```

**4. Nanopore Read Analysis**
```bash
SeqSero2_package.py -m a -t 5 -i nanopore_reads.fastq.gz
```

## Expert Tips and Best Practices

*   **Dependency Check**: Before running a pipeline for the first time, use `SeqSero2_package.py --check` to ensure all third-party dependencies (BWA, SAMtools, SPAdes, etc.) are correctly installed and in your PATH.
*   **Thread Optimization**: While the `-p` flag allows specifying threads, Allele mode is optimized for a maximum of 4 threads during the assembly phase because the subset of extracted reads is typically small.
*   **Output Management**:
    *   By default, the tool creates a directory named `SeqSero_result_[timestamp]`.
    *   Use `-d <name>` to specify a custom output directory.
    *   Use the `-c` flag to output only the serotype prediction result to the console without creating a log directory.
*   **Contamination Detection**: Only the Allele micro-assembly workflow (`-m a`) can flag potential inter-serotype contamination. If you suspect a mixed sample, avoid K-mer mode.
*   **Batch Processing**: When processing multiple samples for a report, use `-s` to suppress the header in the `SeqSero_result.tsv` file, making it easier to concatenate results.

## Reference documentation
- [SeqSero2 Main Documentation](./references/github_com_denglab_SeqSero2.md)