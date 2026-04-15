---
name: fastq-pair
description: The fastq-pair utility synchronizes paired-end FASTQ files by identifying matching reads and separating them from singletons. Use when user asks to re-pair broken FASTQ files, synchronize paired-end data after filtering, or extract singleton reads from mismatched sequencing files.
homepage: https://github.com/linsalrob/fastq-pair
metadata:
  docker_image: "quay.io/biocontainers/fastq-pair:1.0--h87f3376_3"
---

# fastq-pair

## Overview
The `fastq-pair` utility is a high-performance C tool designed to solve the common problem of "broken" paired-end FASTQ files. This often occurs when files are downloaded from the SRA or after independent quality control filtering where some reads lose their mates. The tool takes two input FASTQ files and generates four output files: two containing the synchronized pairs and two containing the "singleton" reads that lacked a match. It uses a hash table approach to remain memory-efficient even with very large datasets.

## Basic Usage
The simplest way to run the tool is by providing the two FASTQ files as positional arguments:

```bash
fastq_pair file1.fastq file2.fastq
```

**Outputs generated:**
- `file1.fastq.paired.fq`: Reads from file 1 that have a mate in file 2.
- `file2.fastq.paired.fq`: Reads from file 2 that have a mate in file 1.
- `file1.fastq.single.fq`: Reads from file 1 with no mate found.
- `file2.fastq.single.fq`: Reads from file 2 with no mate found.

## Performance Optimization
The performance of `fastq-pair` is heavily dependent on the hash table size. If the table is too small, performance degrades to O(n); if it is too large, memory is wasted and initialization slows down.

### Tuning the Hash Table (-t)
The optimal table size is approximately the number of sequences in your FASTQ files.
1. **Calculate sequences**: Run `wc -l <filename>` and divide the result by 4.
2. **Set the parameter**: Use the `-t` flag to specify this value.

```bash
# Example: If your file has 1,000,000 lines (250,000 sequences)
fastq_pair -t 250000 file1.fastq file2.fastq
```

### Verifying Efficiency (-p)
Use the `-p` flag to print the number of elements in each hash bucket. 
- If the average bucket count is > 12: Increase `-t`.
- If most entries are zero: Decrease `-t`.

```bash
fastq_pair -p -t 100000 file1.fastq file2.fastq
```

## Expert Tips and Constraints
- **Gzip Support**: `fastq-pair` does **not** support gzipped files directly because it requires random access to the file stream. You must decompress files before processing.
  - *Recommended workflow*: `pigz -d file1.fastq.gz file2.fastq.gz && fastq_pair file1.fastq file2.fastq`
- **File Order**: For maximum efficiency, provide the **smallest** file as the first argument. The tool stores the indices of the first file in memory.
- **Memory Errors**: If you see an error regarding "cannot allocate memory for a table size of [negative number]", you have likely encountered an integer overflow. Reduce the value provided to `-t`.
- **Validation**: Always check that your files actually contain paired data before running. The tool is significantly slower if there are zero matches between the files.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_linsalrob_fastq-pair.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_fastq-pair_overview.md)