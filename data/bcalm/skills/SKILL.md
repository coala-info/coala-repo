---
name: bcalm
description: BCALM 2 is a high-efficiency bioinformatics tool used to generate unitigs from raw sequencing reads by compacting de Bruijn graphs. Use when user asks to generate unitigs, process large-scale genomic data into non-branching paths, or convert sequencing reads into a compacted graph representation.
homepage: https://github.com/GATB/bcalm
metadata:
  docker_image: "quay.io/biocontainers/bcalm:2.2.3--h43eeafb_6"
---

# bcalm

## Overview

BCALM 2 is a high-efficiency bioinformatics tool used to generate unitigs—sequences representing non-branching paths in a de Bruijn graph—from raw sequencing reads. By utilizing a memory-efficient compaction algorithm, it allows for the processing of large-scale genomic data on standard hardware. This skill provides the necessary command-line patterns to execute graph construction, manage multi-file inputs, and interpret the resulting unitig headers.

## Command Line Usage

### Basic Execution
To generate unitigs from a single sequencing file:
```bash
bcalm -in reads.fastq -kmer-size 21 -abundance-min 2
```

### Core Parameters
- `-in [file]`: Path to input file (FASTA/FASTQ, can be gzipped).
- `-kmer-size [int]`: The length of the k-mers (nodes).
- `-abundance-min [int]`: Minimum k-mer occurrences to keep; use this to filter out sequencing errors (e.g., set to 2 or higher).
- `-all-abundance-counts`: Include this flag to output the abundance of every k-mer in the unitig within the FASTA header.

### Handling Multiple Input Files
BCALM 2 does not accept multiple file arguments directly. Instead, provide a text file containing a list of paths:
1. Generate the list: `ls -1 *.fastq > list_reads.txt`
2. Run bcalm: `bcalm -in list_reads.txt -kmer-size 31 -abundance-min 3`

## Output Interpretation

### FASTA Header Format
The output FASTA file contains unitigs with metadata in the headers:
- `LN:i:[int]`: Length of the unitig.
- `KC:i:[int]`: Total k-mer abundance (sum of counts of all k-mers in the unitig).
- `km:f:[float]`: Mean k-mer abundance.
- `L:[+/-]:[id]:[+/-]`: Edge information. For example, `L:+:12:0:+` indicates a connection between the end of the current unitig and the start of unitig 12.

### Graph Conversion
To convert the native FASTA output to Graphical Fragment Assembly (GFA) format for visualization or use in other tools, use the provided Python script:
```bash
python scripts/convertToGFA.py input_unitigs.fa output_graph.gfa [kmer_size]
```

## Expert Tips and Best Practices

### Memory and Storage Management
- **Intermediate Files**: BCALM 2 generates `.h5` files (or a `_gatb/` folder) and `*glue*` files during execution. These are only needed for the assembly process and can be safely deleted once the final FASTA output is produced to save disk space.
- **Canonical Representation**: The tool automatically uses canonical k-mers (the lexicographically smaller of a k-mer and its reverse complement). Orientation of unitigs in the output is not guaranteed to be consistent across identical runs.

### Large K-mer Sizes
- The default build typically supports $k$ up to 31 or 64.
- For $k$ values larger than 64 (e.g., $k=128$), the tool must be recompiled from source using the `KSIZE_LIST` flag:
  ```bash
  cmake -DKSIZE_LIST="32 64 96 128" .. && make -j 8
  ```
- Always include `32` in the `KSIZE_LIST` and use multiples of 32 for optimal performance.

### Input Requirements
- BCALM 2 ignores paired-end information; all reads are treated as a single pool of k-mers.
- Ensure your compiler supports C++11 (GCC >= 4.8) if building from source.

## Reference documentation
- [BCALM 2 GitHub Repository](./references/github_com_GATB_bcalm.md)
- [Bioconda BCALM Package Overview](./references/anaconda_org_channels_bioconda_packages_bcalm_overview.md)