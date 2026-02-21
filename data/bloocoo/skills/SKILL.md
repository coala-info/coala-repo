---
name: bloocoo
description: Bloocoo is a memory-efficient tool designed to correct errors in genomic reads using a k-mer spectrum approach.
homepage: http://gatb.inria.fr/software/bloocoo/
---

# bloocoo

## Overview

Bloocoo is a memory-efficient tool designed to correct errors in genomic reads using a k-mer spectrum approach. It is particularly effective for processing whole human genome re-sequencing data on standard hardware, as it can handle 70x coverage with less than 4GB of RAM. It utilizes the GATB library's disk-streaming k-mer counting and a Bloom filter to identify "solid" k-mers, following a multi-stage correction procedure similar to Musket but with significantly reduced resource requirements.

## Command Line Usage

Bloocoo is typically invoked via the command line. While specific flags may vary by version, the standard execution pattern follows this structure:

### Basic Syntax
```bash
Bloocoo -file <input_reads.fastq> -kmer-size <k> -nb-cores <n> [options]
```

### Key Parameters
- `-file`: Path to the input sequence file (FASTA/FASTQ, often supports gzipped files).
- `-kmer-size`: The length of k-mers used for error detection. Choosing an appropriate $k$ is critical (typically 31 for human genomes).
- `-nb-cores`: Number of CPU threads to use for parallel processing.
- `-abundance-min`: The threshold for a k-mer to be considered "solid." K-mers appearing fewer times than this value are treated as potential errors.
- `-out`: Specify the prefix or filename for the corrected reads.

### Common Workflow Pattern
1. **Estimation**: Determine the optimal k-mer size and abundance threshold based on your genome size and coverage.
2. **Correction**: Run Bloocoo to generate a corrected FASTQ file.
3. **Validation**: Compare the corrected reads against the original to ensure error rates have decreased without losing significant biological variation.

## Expert Tips and Best Practices

- **Memory Management**: Bloocoo is optimized for low RAM. If you encounter memory constraints on extremely large datasets, ensure you are utilizing the disk-streaming capabilities by providing a fast temporary disk path if the tool supports a `-tmp` directory flag.
- **K-mer Selection**: For high-coverage data (e.g., >50x), a higher `abundance-min` (e.g., 3 or 5) helps filter out unique sequencing errors more effectively.
- **Input Formats**: Bloocoo is designed for short-read data (Illumina). It is not intended for long-read technologies like Oxford Nanopore or PacBio, which have different error profiles.
- **Platform Support**: Use the Bioconda package for the most stable installation on Linux and macOS.

## Reference documentation

- [Bloocoo Overview - Bioconda](./references/anaconda_org_channels_bioconda_packages_bloocoo_overview.md)
- [Bloocoo Software Page - GATB Inria](./references/gatb_inria_fr_software_bloocoo.md)