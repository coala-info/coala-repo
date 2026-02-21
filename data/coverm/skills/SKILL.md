---
name: coverm
description: CoverM is a fast and configurable tool designed to estimate the abundance of genomic entities in metagenomic samples.
homepage: https://github.com/wwood/coverm
---

# coverm

## Overview
CoverM is a fast and configurable tool designed to estimate the abundance of genomic entities in metagenomic samples. It simplifies the process of mapping reads to references and calculating various coverage metrics (such as mean coverage, relative abundance, and covered fraction). It is particularly useful for researchers working with Metagenome-Assembled Genomes (MAGs) who need to compare population levels across multiple samples or assess the quality of their assemblies.

## Core Usage Patterns

### Genome-level Coverage (MAGs)
Use the `genome` mode when you have a set of FASTA files representing distinct genomes.

```bash
# Calculate mean coverage and relative abundance from paired-end reads
coverm genome \
    --coupled sample_R1.fastq.gz sample_R2.fastq.gz \
    --genome-fasta-files genomes/*.fna \
    -m mean relative_abundance \
    -t 8 \
    -o coverage_results.tsv
```

### Contig-level Coverage
Use the `contig` mode to get statistics for every individual sequence in a reference file.

```bash
# Calculate coverage for all contigs in a BAM file
coverm contig --bam-files alignments.bam -m mean -o contig_stats.tsv
```

### Working with Pre-aligned BAMs
If you have already performed mapping, CoverM can process BAM files directly. Ensure BAMs are sorted by reference.

```bash
coverm genome --bam-files sample1.bam sample2.bam -m mean covered_fraction
```

## Key Parameters and Metrics

### Input Specification
- `--coupled`: For paired-end reads (R1 and R2).
- `--single`: For single-end reads.
- `--genome-fasta-files`: Path to the reference genomes (supports wildcards).
- `--bam-files`: Path to pre-generated BAM files.

### Common Metrics (`-m`)
- `mean`: Average depth of coverage across the genome.
- `relative_abundance`: The proportion of the community represented by the genome (includes an "unmapped" calculation).
- `covered_fraction`: The proportion of the genome covered by at least one read (useful for checking genome "breadth").
- `count`: Number of reads mapped.
- `trimmed_mean`: Mean coverage after removing the top and bottom outliers (e.g., to avoid artifacts from conserved regions).

### Alignment Filtering
CoverM allows on-the-fly filtering of alignments to ensure high-quality assignments:
- `--min-read-percent-identity`: Minimum identity (e.g., 95 or 97) for a read to be counted.
- `--min-read-aligned-percent`: Minimum percentage of the read length that must be aligned.

## Expert Tips
- **Thread Management**: Use `-t` to specify CPU threads. CoverM is highly parallelizable, especially during the mapping phase.
- **Unmapped Reads**: When calculating `relative_abundance`, CoverM automatically accounts for reads that did not map to any provided reference, providing a more accurate picture of the total community.
- **Mapper Selection**: By default, CoverM uses `minimap2` or `bwa-mem2`. You can specify the mapper if multiple are installed, but ensure the dependencies are in your PATH.
- **Dereplication**: If your genome set is redundant, use `coverm cluster` first to dereplicate genomes based on Average Nucleotide Identity (ANI) before calculating coverage to avoid multi-mapping issues.

## Reference documentation
- [CoverM GitHub Repository](./references/github_com_wwood_CoverM.md)
- [CoverM Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_coverm_overview.md)