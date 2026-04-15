---
name: wgsim
description: wgsim generates synthetic paired-end or single-end sequencing reads from a FASTA reference. Use when user asks to generate synthetic reads, simulate diploid genomes, introduce polymorphisms and errors, or evaluate read mappers.
homepage: https://github.com/lh3/wgsim
metadata:
  docker_image: "quay.io/biocontainers/wgsim:1.0--h577a1d6_10"
---

# wgsim

## Overview
wgsim is a lightweight command-line utility designed to generate synthetic paired-end or single-end sequencing reads from a FASTA reference. It simulates a diploid genome by introducing polymorphisms (SNPs and insertions/deletions) and applies a uniform substitution error model to the resulting reads. This tool is essential for bioinformaticians who need to validate the accuracy and sensitivity of alignment and variant-calling workflows using ground-truth data.

## CLI Usage and Patterns

### Basic Command Structure
The standard syntax for generating paired-end reads is:
```bash
wgsim [options] <reference.fa> <out.read1.fq> <out.read2.fq>
```

### Common Simulation Scenarios

**1. Standard Illumina-like Paired-End Simulation**
To simulate 1 million pairs of 100bp reads with a 500bp insert size:
```bash
wgsim -N 1000000 -1 100 -2 100 -d 500 -s 50 reference.fa read1.fq read2.fq
```

**2. High-Error Rate Stress Test**
To test a mapper's resilience against high sequencing error (e.g., 5% error rate):
```bash
wgsim -e 0.05 -N 500000 reference.fa read1.fq read2.fq
```

**3. Simulating High INDEL Frequency**
By default, 15% of polymorphisms are INDELs. To increase this to 30%:
```bash
wgsim -X 0.30 reference.fa read1.fq read2.fq
```

### Parameter Reference
- `-N INT`: Number of read pairs (default: 1,000,000).
- `-1 INT`: Length of the first read (default: 70).
- `-2 INT`: Length of the second read (default: 70).
- `-d INT`: Outer distance between the two reads (default: 250).
- `-s INT`: Standard deviation of the distance (default: 50).
- `-R FLOAT`: Fraction of mutations (default: 0.0010).
- `-X FLOAT`: Fraction of INDELs (default: 0.15).
- `-E FLOAT`: Probability of sequencing error (default: 0.020).
- `-S INT`: Seed for the random number generator. Use this for reproducible simulations.
- `-h`: Display help and all available options.

## Expert Tips and Best Practices

### Ground Truth Extraction
wgsim encodes the "true" coordinates and the number of errors/polymorphisms directly into the FASTQ read headers. When evaluating a mapper, parse the read names in the resulting SAM/BAM file to compare the mapped position against these encoded coordinates.

### Evaluating Mappers
Use the included `wgsim_eval.pl` script to calculate accuracy metrics. A typical evaluation pipeline looks like:
1. Generate reads with `wgsim`.
2. Map reads with your tool of choice (e.g., BWA, Bowtie2) to produce a SAM file.
3. Run evaluation:
```bash
wgsim_eval.pl unique aln.sam | wgsim_eval.pl alneval -g 20
```
*Note: The `-g` parameter defines the gap tolerance for considering a mapping "correct."*

### Handling Diploidy
wgsim automatically simulates a diploid genome. If you require a haploid simulation, you may need to post-process the reference or adjust mutation rates, though wgsim is natively optimized for diploid polymorphism simulation.

### Limitations to Consider
- **Error Model**: wgsim uses a uniform substitution error model. It does not natively simulate quality-score-dependent errors or INDEL sequencing errors (though it does simulate INDEL polymorphisms).
- **Memory**: While very efficient, ensure your reference FASTA is indexed or small enough to fit in memory if using extremely large genomes.

## Reference documentation
- [wgsim README](./references/github_com_lh3_wgsim.md)