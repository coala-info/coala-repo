---
name: bgreat
description: BGREAT2 aligns sequencing reads to a de Bruijn graph to represent them as paths of unitigs or corrected sequences. Use when user asks to map reads to a de Bruijn graph, perform read correction, or align reads to unitigs.
homepage: https://github.com/Malfoy/BGREAT2
metadata:
  docker_image: "quay.io/biocontainers/bgreat:2.0.0--hdb21b49_8"
---

# bgreat

## Overview
BGREAT2 is a specialized bioinformatics tool designed to align sequencing reads directly onto a de Bruijn graph. Unlike traditional reference-based aligners, it maps reads to a set of unitigs, representing the alignment as a path of nodes or as a corrected sequence. This is particularly useful for read correction workflows (like BCOOL) or when working with assembly graphs rather than linear reference genomes.

## Core CLI Usage

### Basic Mapping (Path Mode)
By default, bgreat outputs the path of unitigs that each read maps to (e.g., `3;4;-6;` where `-` indicates reverse complement).

```bash
# Map unpaired reads
bgreat -u reads.fa -g unitigs.fa -k 27 -f output_paths

# Map interleaved paired reads
bgreat -x paired_reads.fa -g unitigs.fa -k 27 -f output_paths
```

### Read Correction Mode
Use the `-c` flag to output the actual sequences corresponding to the paths in the graph. This effectively "corrects" the reads based on the graph's consensus.

```bash
# Output corrected reads directly
bgreat -u reads.fa -g unitigs.fa -k 27 -f corrected_reads.fa -c
```

### Post-Processing Paths
If you ran the tool in default path mode and need to convert those paths to sequences later, use the auxiliary `numbersToSequences` utility:

```bash
./numbersToSequences unitigs.fa output_paths 27 > superReads.fa
```

## Optimization and Best Practices

### Memory Management
If the tool consumes too much RAM during the indexing phase, use the `-i` flag to index only a fraction of the anchors.
- `-i 10`: Indexes 1 out of every 10 anchors, significantly reducing memory footprint at a potential cost to sensitivity.

### Handling High K-mer Values
When the k-mer size used to build the graph (`-k`) is significantly larger than the read length or standard anchor sizes (e.g., k > 31), explicitly set the anchor size:
- `-a 31`: A recommended starting value for standard NGS reads on high-k graphs.

### Performance and Input Formats
- **Threading**: Always specify `-t` to match your available CPU cores for faster processing.
- **Fastq Input**: Use the `-q` flag if your input reads are in FASTQ format. Note that bgreat ignores quality scores and treats them as sequences.
- **Compression**: Use `-z` to compress the output file directly, or provide `.gz` input files, which bgreat handles natively.
- **Mismatch Tolerance**: The default mismatch limit is 5. Adjust this using `-m` based on the expected error rate of your data.

## Reference documentation
- [BGREAT2 GitHub Repository](./references/github_com_Malfoy_BGREAT2.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bgreat_overview.md)