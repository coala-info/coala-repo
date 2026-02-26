---
name: perl-bio-kmer
description: This tool performs k-mer counting and frequency analysis for genomic sequence data. Use when user asks to count k-mers, estimate genome size, or generate k-mer histograms for sequencing depth assessment.
homepage: https://metacpan.org/pod/Bio::Kmer
---


# perl-bio-kmer

## Overview
The `perl-bio-kmer` skill provides a streamlined interface for k-mer based genomic analysis. It excels at rapid k-mer counting and frequency analysis, which are essential for tasks like genome size estimation, sequencing depth assessment, and comparative genomics. This tool is particularly useful for bioinformaticians working in Perl environments or requiring lightweight CLI utilities for k-mer statistics without the overhead of massive indexing structures.

## Core CLI Usage
The package typically provides the `count_kmers.pl` script (or similar wrappers) for direct sequence processing.

### Basic K-mer Counting
To count k-mers in a FASTA or FASTQ file:
```bash
count_kmers.pl --kmer-size 21 --input sequences.fastq --output counts.txt
```

### Estimating Genome Size
Use the k-mer frequency distribution (histograms) to estimate the total size of a genome:
```bash
# Generate histogram data
count_kmers.pl -k 31 -i reads.fq --histogram > kmer_dist.hist

# Analyze the peak to estimate size (manual or via script)
# Genome Size = Total K-mers / Peak Depth
```

## Expert Tips & Best Practices
- **K-mer Size Selection**: Use $k=21$ for general purpose bacterial genomics and $k=31$ or higher for more complex eukaryotic genomes to increase specificity.
- **Memory Management**: For large datasets, ensure you are using the threaded version if available, as k-mer counting is memory-intensive.
- **Quality Filtering**: Always perform adapter trimming and quality filtering before k-mer counting, as sequencing errors create a large "cloud" of low-frequency, unique k-mers that skew distributions.
- **Canonical K-mers**: By default, the tool treats a k-mer and its reverse complement as the same entity (canonical form). Ensure this is enabled to avoid doubling the count of asymmetric sites.

## Common Patterns
- **Finding Unique K-mers**: Compare two sets to find k-mers present in a sample but absent in a reference.
- **Subsampling**: For very high-coverage data, subsample your reads before k-mer counting to speed up the estimation of genome size.

## Reference documentation
- [Bio::Kmer Perl Documentation](./references/metacpan_org_pod_Bio__Kmer.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-kmer_overview.md)