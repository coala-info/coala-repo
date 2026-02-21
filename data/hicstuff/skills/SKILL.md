---
name: hicstuff
description: hicstuff is a lightweight and modular toolkit designed for the end-to-end processing of Hi-C data.
homepage: https://github.com/koszullab/hicstuff
---

# hicstuff

## Overview

hicstuff is a lightweight and modular toolkit designed for the end-to-end processing of Hi-C data. It transforms raw sequencing reads into contact maps for any organism, offering flexibility in alignment and output formats. It is particularly effective for users who need a streamlined pipeline that integrates genome digestion, iterative alignment, and matrix generation into a single workflow while maintaining the ability to run individual components for custom analysis.

## Installation

The most reliable way to install hicstuff and its bioinformatic dependencies (bowtie2, bwa, samtools, etc.) is via Conda:

```bash
conda install -c bioconda hicstuff
```

## Core Pipeline Usage

The `pipeline` command is the primary entry point for generating a contact matrix from raw Fastq files.

### Standard Execution
To run the full pipeline using 8 threads and the DpnII enzyme:
```bash
hicstuff pipeline -t 8 -a minimap2 -e DpnII -o output_dir/ -g genome.fa reads_R1.fq reads_R2.fq
```

### Key Parameters
- `-g, --genome`: Path to the reference genome (FASTA).
- `-e, --enzyme`: Restriction enzyme name (e.g., DpnII, HindIII) or a fixed bin size (e.g., 5000).
- `-a, --aligner`: Choice of aligner (`bowtie2`, `bwa`, or `minimap2`).
- `-M, --matfmt`: Output format (`graal`, `cool`, or `bg2`). Use `cool` for compatibility with most modern Hi-C tools.
- `-t, --threads`: Number of CPU cores to use.

### Starting from BAM files
If reads are already aligned, ensure they are name-sorted before running the pipeline:
```bash
samtools sort -n aligned_for.bam -o namesorted_for.bam
samtools sort -n aligned_rev.bam -o namesorted_rev.bam
hicstuff pipeline -S bam -e 5000 -M cool -o out/ -g genome.fa namesorted_for.bam namesorted_rev.bam
```

## Individual Components

hicstuff allows running specific modules for granular control over the Hi-C workflow.

### Genome Digestion
Generate a fragment list and contig information:
```bash
hicstuff digest --enzyme MaeII,HinfI --plot --outdir digest_out Sc_ref.fa
```

### Iterative Alignment
Optimize the proportion of uniquely aligned reads by iteratively truncating and re-aligning unmapped reads:
```bash
hicstuff iteralign --aligner bowtie2 --threads 4 --genome genome.fa --out-bam aligned.bam reads.fq
```

### Matrix Manipulation
- **Rebinning**: Change the resolution of an existing matrix.
  ```bash
  hicstuff rebin --bin-size 10000 input_matrix.pcr.gz output_matrix
  ```
- **Visualization**: Generate a quick preview of the contact map.
  ```bash
  hicstuff view --binning 10000 --transform log10 input_matrix.pcr.gz
  ```
- **Conversion**: Move between formats (e.g., GRAAL to Cooler).
  ```bash
  hicstuff convert --to cool input.mat.gz output.cool
  ```

## Expert Tips and Best Practices

- **Aligner Selection**: Use `minimap2` for significantly faster processing on large genomes or when using long-read Hi-C data.
- **Memory Management**: For very large datasets, use the `--tmpdir` flag to point to a high-speed scratch disk to prevent system slowdowns during alignment and sorting.
- **Quality Control**: Always check the `distance_law` output to ensure the library shows the expected decay of contact frequency with genomic distance, which is a hallmark of high-quality Hi-C data.
- **Enzyme Combinations**: If using multiple enzymes, provide them as a comma-separated list (e.g., `-e DpnII,HinfI`).

## Reference documentation
- [hicstuff Main Documentation](./references/github_com_koszullab_hicstuff.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hicstuff_overview.md)