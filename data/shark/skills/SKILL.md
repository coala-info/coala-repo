---
name: shark
description: The shark tool performs mapping-free isolation of RNA-Seq reads belonging to specific genes of interest using Bloom filters and k-mer indexing. Use when user asks to fish relevant reads from a dataset, filter reads by gene, or perform targeted read extraction without full alignment.
homepage: https://algolab.github.io/shark/
---


# shark

## Overview
The `shark` tool provides a high-speed, memory-efficient method for isolating reads belonging to specific genes of interest from an RNA-Seq dataset. By utilizing Bloom filters and k-mer indexing, it bypasses traditional mapping steps to quickly categorize reads. This is ideal for targeted analysis where you only need reads corresponding to a subset of the genome or specific transcripts.

## Command Line Usage

### Basic Syntax
```bash
shark -r <references.fa> -1 <sample_1.fq> [options]
```

### Common Patterns

**Single-end Filtering:**
```bash
shark -r genes.fa -1 reads.fq -o filtered_reads.fq > associations.ssv
```

**Paired-end Filtering:**
```bash
shark -r genes.fa -1 reads_R1.fq -2 reads_R2.fq -o filtered_R1.fq -p filtered_R2.fq > associations.ssv
```

### Key Arguments
- `-r, --reference`: Reference sequences in FASTA format (can be gzipped).
- `-1, --sample1`: Input FASTQ file (can be gzipped).
- `-2, --sample2`: Second input FASTQ for paired-end data.
- `-o, --out1`: Output file for filtered reads from sample 1.
- `-p, --out2`: Output file for filtered reads from sample 2.
- `-k, --kmer-size`: K-mer size (default: 17, max: 31). Adjust based on sequence uniqueness.
- `-c, --confidence`: Threshold for associating a read to a gene (default: 0.6).
- `-b, --bf-size`: Bloom filter size in GB (default: 1). Increase for very large reference sets to reduce false positives.
- `-s, --single`: Only report associations if a read matches exactly one gene.

## Expert Tips & Best Practices
- **Output Handling**: `shark` writes the read-to-gene associations to `stdout` in Space-Separated Values (SSV) format. Always redirect this to a file (e.g., `> output.ssv`) to capture the mapping data.
- **Memory Management**: The `-b` parameter controls the Bloom filter size. If you encounter high false-positive rates (reads being "fished" that don't belong), increase the GB allocation.
- **Quality Filtering**: Use `-q` to set a minimum base quality (Phred scale) if your input data has not been pre-trimmed. This prevents low-quality k-mers from polluting the Bloom filter matches.
- **Performance**: Use the `-t` flag to specify multiple threads for faster processing of large FASTQ files.
- **Reference Preparation**: Ensure your reference FASTA contains only the genes/transcripts you are interested in "fishing" to keep the Bloom filter efficient.

## Reference documentation
- [Shark: Mapping-free fishing relevant reads](./references/algolab_github_io_shark.md)
- [Bioconda Shark Package Overview](./references/anaconda_org_channels_bioconda_packages_shark_overview.md)