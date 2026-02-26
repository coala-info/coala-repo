---
name: maxbin2
description: MaxBin2 reconstructs individual microbial genomes from metagenomic assemblies by integrating genomic signatures and abundance patterns. Use when user asks to bin assembled contigs into genomes, perform metagenomic binning using reads or abundance profiles, or improve binning resolution through differential coverage.
homepage: http://downloads.jbei.org/data/microbial_communities/MaxBin/MaxBin.html
---


# maxbin2

## Overview
MaxBin2 is a powerful automated binning tool that reconstructs individual genomes from complex microbial communities. It is most effective when you have assembled contigs and corresponding coverage information (either as raw reads or pre-calculated abundance files). By integrating both genomic signatures and abundance patterns, it can distinguish between closely related species that single-metric binners might miss.

## Usage Patterns

### Basic Binning with Reads
Use this pattern when you have a fasta file of contigs and one or more sets of paired-end reads.
```bash
run_MaxBin.pl -contig [assembled_contigs.fasta] -reads [reads_1.fastq] -reads2 [reads_2.fastq] -out [output_prefix]
```

### Binning with Abundance Profiles
If you have already calculated contig abundance (e.g., using BBMap or Bowtie2), providing the abundance file directly is significantly faster.
```bash
run_MaxBin.pl -contig [assembled_contigs.fasta] -abund [abundance.txt] -out [output_prefix]
```

### Multi-sample Binning
MaxBin2 supports multiple abundance files or multiple read sets to improve binning resolution through differential coverage.
```bash
run_MaxBin.pl -contig [contigs.fasta] -abund [sample1.abund] -abund2 [sample2.abund] -abund3 [sample3.abund] -out [output_prefix]
```

## Expert Tips and Best Practices
- **Contig Length Filter**: By default, MaxBin2 ignores contigs shorter than 1000bp. For highly fragmented assemblies, you can adjust this with `-min_contig_length`, but be aware that very short contigs often lack sufficient tetranucleotide signal for accurate binning.
- **Marker Gene Sets**: MaxBin2 uses 107 marker genes (for bacteria) or 40 marker genes (for archaea) to estimate the number of bins. You can specify the marker set using the `-markerset` flag (107 or 40).
- **Probability Threshold**: Use the `-prob_threshold` (default 0.5) to adjust how aggressively contigs are assigned to bins. Increasing this value improves bin purity but may decrease completeness.
- **Thread Management**: Use the `-thread` parameter to speed up the EM algorithm and the initial marker gene search (via FragGeneScan and HMMER).

## Reference documentation
- [MaxBin2 Overview](./references/anaconda_org_channels_bioconda_packages_maxbin2_overview.md)