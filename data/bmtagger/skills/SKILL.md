---
name: bmtagger
description: BMTagger (Best Match Tagger) is a specialized tool for the rapid identification of host DNA sequences within large NGS datasets.
homepage: https://github.com/movingpictures83/BMTagger
---

# bmtagger

## Overview
BMTagger (Best Match Tagger) is a specialized tool for the rapid identification of host DNA sequences within large NGS datasets. It operates by using a bitmask to quickly screen out potential matches and SRPRISM for high-sensitivity alignment of the remaining reads. This skill provides guidance on configuring the tool, managing its specific indexing requirements, and executing the tagging process to generate lists of host-contaminant sequences.

## Core Command Line Usage

The primary execution script is `bmtagger.sh`. It requires pre-computed indexes for both the bitmask and the alignment engine.

### Standard Execution
To identify host sequences in paired-end data:
```bash
bmtagger.sh -b host.bitmask -x host.srprism -1 forward.fastq -2 reverse.fastq -o output_prefix
```

### Key Arguments
- `-b <file>`: Path to the bitmask file (generated via `bmtool`).
- `-x <prefix>`: Prefix for the SRPRISM index files.
- `-T <directory>`: Path to a temporary directory. BMTagger generates large intermediate files; ensure this location has sufficient space.
- `-q 1`: Enable fastq input mode (default is often fasta).
- `-o <prefix>`: Base name for output files. The tool will produce an `.out` file containing the IDs of identified host reads.

## Configuration for Plugin-based Workflows
When using BMTagger within specific plugin architectures (like PluMA), the tool expects a tab-delimited TXT configuration file. This file maps specific keywords to their respective paths:

| Keyword | Description |
| :--- | :--- |
| `config` | Path to the BMTagger configuration file (sets `BMTAGGER_DB`) |
| `bitmask` | Path to the `.bitmask` file produced by BMTool |
| `srprism` | Prefix for the SRPRISM index files |
| `forward` | Path to the forward (R1) FASTQ file |
| `reverse` | Path to the reverse (R2) FASTQ file |

## Expert Tips and Best Practices

### Index Preparation
BMTagger requires two distinct indexing steps for the reference genome:
1. **BMTool**: Creates the bitmask used for the initial rapid screening.
2. **SRPRISM**: Creates the suffix array/index used for the final alignment verification.
Ensure both indexes are generated from the exact same reference FASTA file to maintain consistency.

### Memory Management
BMTagger is memory-intensive because it loads the bitmask and alignment indexes into RAM. 
- For a human reference genome, expect to require at least 12GB–16GB of available RAM.
- If running on a cluster, explicitly request high-memory nodes to prevent OOM (Out of Memory) kills.

### Handling Output
The primary output is a list of read identifiers. To create "clean" FASTQ files (removing the host sequences), use the output list with a tool like `seqtk` or a custom script to filter the original FASTQ files:
```bash
# Example: Extracting non-host reads using the BMTagger output list
grep -v -f output_prefix.out original.fastq > filtered.fastq
```

## Reference documentation
- [BMTagger Repository Overview](./references/github_com_movingpictures83_BMTagger.md)