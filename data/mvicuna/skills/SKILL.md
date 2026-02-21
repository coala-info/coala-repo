---
name: mvicuna
description: mvicuna is a specialized tool designed for the de novo assembly of viral populations characterized by high mutation rates.
homepage: https://github.com/broadinstitute/mvicuna
---

# mvicuna

## Overview

mvicuna is a specialized tool designed for the de novo assembly of viral populations characterized by high mutation rates. It excels at handling ultra-deep sequencing data (tens of thousands fold coverage) and high levels of contamination (e.g., >95% host DNA). The tool provides a modular suite of preprocessing tasks—including quality trimming, duplicate removal, and read merging—to generate a linear representation of mixed populations suitable for intra-host variant mapping.

## Command Line Usage

The basic syntax for mvicuna involves specifying input files, output destinations, and the specific tasks to be performed.

### Core Parameters

- **Input/Output**:
  - `-ipfq <file1,file2>`: Comma-separated paired-end FASTQ files.
  - `-isfq <file>`: Comma-separated single-end FASTQ files.
  - `-fa <file>`: Comma-separated single-end FASTA files.
  - `-opfq <file1,file2>`: Final output paths for paired-end FASTQ files.
  - `-osfq <file>`: Final output path for singleton FASTQ files.
- **Performance**:
  - `-pthreads <int>`: Number of CPU cores (default: 8).
  - `-batch <int>`: Number of sequence pairs loaded into memory at once (default: 500,000; minimum: 10,000). Adjust this based on available RAM.

### Task Selection

Use the `-tasks` flag to define a comma-separated list of operations. The default set is `DupRm,Trim,PairedReadMerge,SFrqEst`.

1.  **DupRm (Duplicate Removal)**:
    - `-drm_perc_sim <int>`: Percent similarity for duplicates (default: 98).
    - `-drm_max_mismatch <int>`: Maximum allowed mismatches (default: 5).
2.  **Trim (Vector/Quality Trimming)**:
    - `-trm_vecfa <file>`: FASTA file containing vector or primer sequences to trim.
    - `-trm_min_match <int>`: Minimum match length between vector and read (default: 13).
    - `-trm_min_rlen <int>`: Minimum read length to keep after trimming (default: 70).
    - `-trm_q <int>`: Minimum Phred quality score (default: 2, which is ASCII 35 '#').
3.  **PairedReadMerge**:
    - Merges overlapping paired-end reads into single-end reads.
4.  **SFrqEst (Sequence Frequency Estimation)**:
    - `-fe_k <int>`: K-mer length for frequency calibration (default: 14, max: 16).

### Common CLI Patterns

**Standard Preprocessing Pipeline**
Run the full suite of default tasks on paired-end data:
`mvicuna -ipfq input_R1.fq,input_R2.fq -opfq clean_R1.fq,clean_R2.fq -osfq clean_unpaired.fq`

**Vector Trimming Only**
Perform only vector and quality trimming using a specific primer file:
`mvicuna -tasks Trim -ipfq R1.fq,R2.fq -trm_vecfa primers.fa -trm_min_rlen 50 -opfq trimmed_R1.fq,trimmed_R2.fq`

**Memory-Efficient Processing**
For systems with limited RAM or extremely large datasets, reduce the batch size:
`mvicuna -ipfq R1.fq,R2.fq -batch 100000 -pthreads 16 -opfq out_R1.fq,out_R2.fq`

## Best Practices

- **Low Complexity Filtering**: mvicuna filters low complexity sequences by default. You can tune these using `-lc_n` (ambiguous bases), `-lc_mono` (mononucleotides), and `-lc_di` (dinucleotides).
- **Intermediate Files**: By default, mvicuna removes intermediate files. Use `-noclean` if you need to inspect the output of individual tasks (e.g., after `DupRm` but before `Trim`).
- **Input Ordering**: When using `-ipfq`, ensure the files are listed such that the $i$-th and $(i+1)$-th files form a pair, where $i$ is an odd number (1st and 2nd, 3rd and 4th, etc.).

## Reference documentation
- [mvicuna README](./references/github_com_broadinstitute_mvicuna.md)