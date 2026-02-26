---
name: seqsero2s
description: "SeqSero2S is a bioinformatics pipeline for predicting Salmonella serotypes from raw genomic reads or finished assemblies. Use when user asks to predict Salmonella serotypes, perform allele micro-assembly of serotype determinants, or identify inter-serotype contamination in genomic data."
homepage: https://github.com/LSTUGA/SeqSero2S
---


# seqsero2s

## Overview
SeqSero2S is a specialized bioinformatics pipeline designed for the rapid and accurate prediction of Salmonella serotypes. It processes genomic data through two distinct mechanisms: an allele micro-assembly workflow that performs targeted assembly of serotype determinants (ideal for raw reads and detecting contamination) and a k-mer based workflow for high-speed prediction from both reads and finished assemblies.

## Usage Patterns

### Core Workflows (-m)
*   **Allele Micro-assembly (`-m a`)**: The default mode. Best for raw reads. It provides high resolution and can identify potential inter-serotype contamination.
*   **K-mer (`-m k`)**: Faster processing. Required for genome assemblies (`-t 4`) and recommended for rapid screening of raw reads or Nanopore data.

### Input Type Selection (-t)
| Code | Input Type | Recommended Workflow |
| :--- | :--- | :--- |
| `1` | Interleaved paired-end reads | `-m a` or `-m k` |
| `2` | Separated paired-end reads | `-m a` or `-m k` |
| `3` | Single reads | `-m a` or `-m k` |
| `4` | Genome assembly (FASTA) | Must use `-m k` |
| `5` | Nanopore reads (FASTA/FASTQ) | Must use `-m k` |

### Common CLI Examples

**1. Standard Illumina Paired-End (Allele Mode)**
Use this for the highest accuracy and contamination detection:
```bash
SeqSero2S.py -p 4 -t 2 -i sample_R1.fastq.gz sample_R2.fastq.gz
```

**2. Rapid K-mer Prediction from Assembly**
Use this when you already have a FASTA assembly:
```bash
SeqSero2S.py -m k -t 4 -i assembly.fasta
```

**3. Nanopore Read Processing**
```bash
SeqSero2S.py -m k -t 5 -i nanopore_reads.fastq.gz
```

## Expert Tips and Best Practices

*   **Thread Optimization**: While you can specify many threads with `-p`, the allele micro-assembly workflow is optimized for a maximum of 4 threads during the assembly phase due to the small volume of extracted reads.
*   **Dependency Verification**: Before running a large batch, use the `--check` flag to ensure all underlying dependencies (BWA, SAMtools, BLAST+, SPAdes, etc.) are correctly configured in your environment.
*   **Output Management**:
    *   By default, the tool creates a directory `SeqSero_result_[timestamp]`.
    *   Use `-c` to suppress the creation of the log directory and only output the serotype prediction.
    *   Use `-s` if you are piping the output into a combined table and want to skip the TSV header.
*   **Contamination Alerts**: When using allele mode (`-m a`), pay attention to the output regarding "potential inter-serotype contamination." This indicates the presence of alleles from multiple serotypes, which often suggests a non-pure culture or sequencing carryover.

## Reference documentation
- [SeqSero2S GitHub Repository](./references/github_com_LSTUGA_SeqSero2S.md)
- [SeqSero2S Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_seqsero2s_overview.md)