---
name: seqsero2
description: SeqSero2 is a specialized bioinformatics pipeline for determining Salmonella serotypes from Whole Genome Sequencing (WGS) data.
homepage: https://github.com/denglab/SeqSero2
---

# seqsero2

## Overview

SeqSero2 is a specialized bioinformatics pipeline for determining Salmonella serotypes from Whole Genome Sequencing (WGS) data. It improves upon the original SeqSero by offering two distinct workflows: a high-accuracy allele micro-assembly mode and a rapid k-mer based mode. This tool is essential for public health surveillance and clinical microbiology tasks involving Salmonella identification, providing results that correlate with traditional Kaufmann-White-Leake schemes but with the speed and resolution of genomic data.

## Core Workflows

SeqSero2 operates using three primary modes defined by the `-m` (method) and `-t` (input type) flags:

1.  **Allele Micro-assembly (Default: `-m a`)**: Performs targeted assembly of serotype determinant alleles. Use this for raw reads when high resolution is required or when you suspect inter-serotype contamination.
2.  **Raw Reads K-mer (`-m k`)**: A rapid workflow that uses unique k-mers for prediction. Use this for high-throughput screening where speed is prioritized over assembly.
3.  **Genome Assembly K-mer (`-m k -t 4`)**: Specifically for pre-assembled fasta files.

## Command Line Usage

The primary executable is `SeqSero2_package.py`.

### Common Input Types (`-t`)
- `1`: Interleaved paired-end reads
- `2`: Separated paired-end reads (R1 and R2)
- `3`: Single reads
- `4`: Genome assembly (fasta)
- `5`: Nanopore reads (fasta/fastq)

### Execution Patterns

**Allele Mode (Separated Paired-End)**
```bash
SeqSero2_package.py -m a -t 2 -i sample_R1.fastq.gz sample_R2.fastq.gz -p 10
```

**K-mer Mode (Separated Paired-End)**
```bash
SeqSero2_package.py -m k -t 2 -i sample_R1.fastq.gz sample_R2.fastq.gz
```

**Genome Assembly Mode**
```bash
SeqSero2_package.py -m k -t 4 -i assembly.fasta
```

## Expert Tips and Best Practices

- **Thread Management**: While you can specify many threads with `-p`, the allele micro-assembly workflow effectively caps at 4 threads for the assembly stage because the volume of extracted reads is small.
- **Contamination Detection**: Only the Allele workflow (`-m a`) can flag potential inter-serotype contamination (the presence of multiple Salmonella serotypes in a single sample).
- **Output Handling**:
    - By default, SeqSero2 creates a directory named `SeqSero_result_[timestamp]`.
    - Use `-c` to output only the serotype prediction to stdout without creating a log directory.
    - Use `-n <name>` to specify a custom sample name in the report.
    - Use `-s` to suppress the header in the `SeqSero_result.tsv` file, which is useful for piping or appending results to a master list.
- **Dependency Check**: Run `SeqSero2_package.py --check` to verify that all required dependencies (BWA, SAMtools, BLAST+, SPAdes, etc.) are correctly installed and in your PATH.

## Reference documentation
- [SeqSero2 GitHub Repository](./references/github_com_denglab_SeqSero2.md)
- [SeqSero2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_seqsero2_overview.md)