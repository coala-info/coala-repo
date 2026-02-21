---
name: circle-map-cpp
description: The `circle-map-cpp` skill enables the identification of thousands of eccDNA genomic features with high computational efficiency.
homepage: https://github.com/BGI-Qingdao/Circle-Map-cpp
---

# circle-map-cpp

## Overview
The `circle-map-cpp` skill enables the identification of thousands of eccDNA genomic features with high computational efficiency. It is a C++ rewrite of the Realign module from the original Circle-Map, designed to handle deep sequencing data while correcting specific 1bp coordinate errors found in the Python version. The workflow typically involves two stages: extracting candidate reads that indicate circular structures (discordant and soft-clipped reads) and then performing a fine-grained realignment to the reference genome to define the circular boundaries.

## Core Workflow

### 1. Extracting Read Candidates
Use the `ReadExtractor` subprogram to identify reads that potentially originate from circular DNA. This requires a BAM file sorted by query name.

```bash
circle_map++ ReadExtractor -i qname_sorted_input.bam -o circular_read_candidates.bam -t 8
```

**Key Parameters:**
- `-i`: Input BAM (must be query-name sorted).
- `-o`: Output BAM containing candidate reads.
- `-q`: Mapping quality cutoff (default: 10).
- `-t`: Number of threads.

### 2. Realignment and eccDNA Calling
Use the `Realign` subprogram to process the candidates and output a BED file containing the detected eccDNA coordinates.

```bash
circle_map++ Realign \
  -i circular_read_candidates.bam \
  -qbam qname_sorted_input.bam \
  -sbam coordinate_sorted_input.bam \
  -fasta reference_genome.fa \
  -o detected_circles.bed \
  -t 8
```

**Key Parameters:**
- `-i`: The output from `ReadExtractor`.
- `-qbam`: The original query-name sorted BAM.
- `-sbam`: The original coordinate sorted BAM.
- `-fasta`: Reference genome in FASTA format.
- `-K`: Clustering distance (default: 500). Increase this for larger circular elements.

## Expert Tips and Best Practices

### Memory Management
`circle-map-cpp` loads IO files into RAM to maximize speed. For deep Circle-Seq data, memory usage can exceed 70 GB. Ensure your environment has sufficient RAM before processing large datasets.

### Input Preparation
The tool is sensitive to BAM sorting. You must maintain two versions of your alignment:
1. **Query-name sorted**: Required for `ReadExtractor` and the `-qbam` flag in `Realign`.
2. **Coordinate sorted**: Required for the `-sbam` flag in `Realign` to calculate coverage statistics.

### Filtering and Quality Control
- **Split Reads**: Use `-T` to set the minimum number of split reads required to call an eccDNA. The default is 0, but increasing this (e.g., `-T 2`) can reduce false positives.
- **Coverage Ratio**: Use `-r` (default: 0.0) to set a minimum in/out coverage ratio. This helps filter out linear DNA contaminants by ensuring the coverage inside the circle is significantly higher than the surrounding region.
- **Clustering**: If you expect very large eccDNAs, increase the `-K` (clustering distance) parameter to ensure reads from the same circle are grouped correctly.

### Performance Optimization
Always utilize the `-t` (threads) parameter in both subprograms. The C++ implementation scales well with additional CPU cores, significantly reducing the bottleneck during the realignment phase.

## Reference documentation
- [Circle-Map-cpp Overview](./references/anaconda_org_channels_bioconda_packages_circle-map-cpp_overview.md)
- [Circle-Map-cpp GitHub Repository](./references/github_com_BGI-Qingdao_Circle-Map-cpp.md)