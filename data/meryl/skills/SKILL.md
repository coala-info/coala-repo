---
name: meryl
description: Meryl is a high-performance k-mer counter and sequence utility used to build and manipulate genomic k-mer frequency databases. Use when user asks to count k-mers, merge k-mer databases, filter k-mers by frequency, or generate k-mer histograms for genome analysis.
homepage: https://github.com/marbl/meryl
---


# meryl

## Overview

Meryl is a high-performance k-mer counter and sequence utility designed for large-scale genomic data. It transforms raw sequence reads into a searchable database of k-mer frequencies. Modern meryl (v1.0+) uses a directory-based storage format—typically containing 128 files (64 binaries and 64 indexes)—to achieve significantly higher speeds than previous versions. It is a core component of the Merqury workflow for reference-free assembly evaluation, providing the underlying k-mer distributions needed to estimate genome size, heterozygosity, and assembly completeness.

## Common CLI Patterns

### K-mer Counting
The primary function is to count k-mers in a set of reads.
```bash
# Count k-mers of size 21 from a FASTQ file
meryl count k=21 input.fastq output read-db.meryl

# Count k-mers from multiple files (including compressed files)
meryl count k=21 input1.fastq.gz input2.fastq.gz output read-db.meryl

# Count k-mers from SAM/BAM/CRAM files (v1.4+)
meryl count k=21 input.bam output read-db.meryl
```

### Database Operations
Meryl allows for set operations and filtering on existing databases.
```bash
# Merge multiple databases
meryl union-sum read-db1.meryl read-db2.meryl output combined.meryl

# Filter k-mers by frequency (e.g., keep k-mers appearing at least 5 times)
meryl greater-than 4 read-db.meryl output filtered.meryl

# Find k-mers unique to one database
meryl difference db1.meryl db2.meryl output unique_to_db1.meryl
```

### Statistics and Reporting
Generate reports on the k-mer distribution.
```bash
# Generate a histogram of k-mer frequencies
meryl statistics read-db.meryl

# Report k-mer counts for specific sequences
meryl print read-db.meryl

# Analyze ploidy levels (v1.4+)
meryl ploidy read-db.meryl
```

## Expert Tips and Best Practices

- **Database Format**: Remember that a meryl "database" is a directory, not a single file. When moving or copying results, ensure you treat the entire `.meryl` directory as a single unit.
- **K-mer Size**: For most mammalian genomes, `k=21` is the standard. For smaller genomes (bacteria), `k=15-17` may be more appropriate.
- **Memory and Threads**: Meryl is highly parallelized. On large systems, use `threads=N` to speed up counting, though it generally auto-detects available resources.
- **Compatibility**: Databases built with meryl v1.0+ are not compatible with older versions (e.g., those found in Canu 1.8 or earlier). Always use the latest version for both building and querying.
- **Input Heuristics**: Recent versions of meryl include heuristics to automatically detect input formats (FASTQ vs. SAM). If using older versions, ensure your input extensions are standard.
- **Disk Space**: Use the `compress` option if disk space is a concern, though this may impact access speed for some operations.

## Reference documentation
- [Meryl Main README](./references/github_com_marbl_meryl.md)
- [Bioconda Meryl Overview](./references/anaconda_org_channels_bioconda_packages_meryl_overview.md)