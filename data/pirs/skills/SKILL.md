---
name: pirs
description: pIRS simulates Illumina paired-end reads using empirical profiles to account for GC-content bias and base-calling error distributions. Use when user asks to generate synthetic genomic data, simulate Illumina sequencing reads, or create a diploid reference genome with known variations.
homepage: https://github.com/galaxy001/pirs
---


# pirs

## Overview
pIRS (profile-based Illumina pair-end Reads Simulator) is a suite of tools designed to generate synthetic genomic data that closely mimics the output of Illumina sequencing platforms. Unlike simple simulators, pIRS uses empirical profiles to account for GC-content coverage bias and base-calling error distributions. The workflow typically involves two main stages: creating a diploid reference with known variations and then simulating the sequencing process to produce FASTQ files.

## Command Line Usage

### 1. Generating a Diploid Genome
Use `pirs diploid` to introduce heterozygosity into a haploid reference. This creates a "second" genome containing SNPs, indels, and structural variations (SV).

```bash
pirs diploid [OPTIONS] <reference.fasta>
```

**Key Options:**
- `-s, --snp-rate`: Set the heterozygous SNP rate (default: 0.001).
- `-d, --indel-rate`: Set the small indel rate (default: 0.0001).
- `-v, --sv-rate`: Set the large-scale structural variation rate (default: 0.000001).
- `-R`: Set the transition-to-transversion ratio (default: 2.0).
- `-o, --output-prefix`: Prefix for the generated FASTA and log files.

### 2. Simulating Illumina Reads
Use `pirs simulate` to generate paired-end reads. You can provide a single haploid reference or both the original and the diploid-generated reference to simulate a true diploid sample.

```bash
pirs simulate [OPTIONS] <reference.fasta> [diploid_reference.fasta]
```

**Common Workflow Patterns:**
- **Haploid Simulation**: Provide only the original reference.
- **Diploid Simulation**: Provide both the original reference and the output from `pirs diploid`.

### 3. Profile Generation (Advanced)
pIRS includes auxiliary tools to generate custom profiles from real sequencing data:
- `gc_coverage_bias`: Calculates depth distribution based on GC content.
- `error_matrix_calculator`: Generates base-calling error profiles from SAM/BAM/SOAP alignment files.
- `indelstat_sam_bam`: Extracts indel profiles from alignments.

## Best Practices and Expert Tips
- **Diploid Consistency**: When simulating a diploid organism, always run `pirs diploid` first to generate the variant genome, then pass both the original and the new FASTA to `pirs simulate`.
- **Memory and Performance**: Note that `pirs diploid` does not support multi-threading, even if the package was compiled with multi-threading enabled. Plan resource allocation accordingly for large genomes.
- **Input Formats**: The tool supports gzipped FASTA files as input. If reading from stdin using `-`, the input must be uncompressed.
- **Quality Control**: Use the `.gc` files generated during profile stat stages to manually check for abnormal depth levels in specific GC-content windows before running large-scale simulations.
- **Randomness**: Use the `-S` (random seed) option if you need to generate reproducible datasets for testing.



## Subcommands

| Command | Description |
|---------|-------------|
| diploid | Simulate a diploid genome by creating a copy of a haploid genome with heterozygosity introduced. REFERENCE specifies a FASTA file containing the reference genome. It may be compressed (gzip). It may contain multiple sequences (scaffolds or chromosomes), each marked with a separate FASTA tag line. The introduced heterozygosity takes the form of SNPs, indels, and large-scale structural variation (insertions, deletions and inversions). If REFERENCE is '-', the reference sequence is read from stdin, but it must be uncompressed. |
| simulate | pIRS is a program for simulating paired-end reads from a genome. It is optimized for simulating reads from the Illumina platform. The input to pIRS is any number of reference sequences. Typically you would just provide one FASTA file containing your reference sequence, but you may provide two if you have generated a diploid sequence with `pirs diploid', or if you have chromosomes split up into multiple FASTA files. The output of pIRS is two FASTQ files containing the simulated paired-end reads, as well as several log files. |

## Reference documentation
- [pIRS README and Usage](./references/github_com_galaxy001_pirs.md)
- [pIRS Project Archive](./references/code_google_com_archive_p_pirs.md)