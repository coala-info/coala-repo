---
name: mapsplice
description: MapSplice is a specialized alignment tool designed for RNA-seq analysis.
homepage: http://www.netlab.uky.edu/p/bioinfo/MapSplice2
---

# mapsplice

## Overview
MapSplice is a specialized alignment tool designed for RNA-seq analysis. It excels at identifying both canonical and non-canonical splice junctions by splitting reads into segments and mapping them to the genome. It is particularly useful for discovery-based research where transcriptome annotations are incomplete or unavailable, as it operates independently of gene models.

## Usage Guidelines

### Core Workflow
1. **Indexing**: Before alignment, the reference genome must be indexed. MapSplice typically uses Bowtie indices.
2. **Alignment**: Run the main MapSplice executable providing the fastq files and the reference index.
3. **Output**: The tool generates a SAM/BAM file containing alignments and a specific file (usually `junctions.txt`) detailing discovered splice sites.

### Common CLI Patterns
While specific flags vary by version, the standard execution follows this structure:
```bash
mapsplice -p <threads> -x <bowtie_index> -1 <reads_1.fq> -2 <reads_2.fq> -o <output_directory>
```

### Expert Tips
- **Memory Management**: MapSplice can be memory-intensive. Ensure the host system has sufficient RAM relative to the genome size (e.g., ~16GB+ for human/mouse genomes).
- **Segment Length**: The tool splits reads into segments (default is often 25bp). If working with very short reads or specific library types, adjusting the segment length can improve sensitivity.
- **Filtering**: Review the `junctions.txt` output for "canonical" vs "non-canonical" tags. High-confidence junctions are typically supported by multiple "anchor" lengths.

## Reference documentation
- [MapSplice Overview](./references/anaconda_org_channels_bioconda_packages_mapsplice_overview.md)