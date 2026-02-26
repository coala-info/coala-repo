---
name: seqcluster
description: seqcluster groups small RNA-seq data into clusters based on genomic location and abundance to handle multi-mapping reads and identify non-canonical small RNAs. Use when user asks to preprocess small RNA reads, align sequences to a reference genome, or group and quantify small RNA clusters for downstream analysis.
homepage: https://github.com/lpantano/seqclsuter
---


# seqcluster

## Overview
The `seqcluster` tool is designed to handle the complexity of small RNA-seq data by grouping sequences into clusters based on genomic location and abundance. This approach is particularly effective for identifying non-canonical small RNAs and dealing with multi-mapping reads. It transforms raw FASTQ files into quantified clusters that can be used for differential expression analysis and functional discovery.

## Core Workflow
The standard pipeline involves three primary stages: preprocessing, alignment, and clustering.

### 1. Preprocessing and Quality Control
Prepare raw reads by removing adapters and collapsing identical sequences to reduce computational load.
- Use `seqcluster prepare` to format input files.
- Ensure adapters are correctly specified to avoid truncated reads.
- Monitor the "collapsed" file size; a high ratio of unique to total reads may indicate sequencing artifacts or high noise.

### 2. Alignment
Align the processed reads to the reference genome.
- `seqcluster` typically expects BAM files.
- Use aligners that support multi-mapping (like Bowtie) because small RNAs often originate from repetitive elements or multi-copy genes.
- Recommended: Allow up to 10-20 hits per read to capture the full distribution of small RNA clusters.

### 3. Clustering and Annotation
Group overlapping reads into transcription units.
- Run `seqcluster cluster` on the aligned BAM files.
- Provide a GTF/BED file of known small RNA annotations (miRNA, snoRNA, etc.) to categorize the resulting clusters.
- The output `counts.tsv` and `sequences.fa` are the primary files for downstream analysis.

## Expert Tips
- **Complexity Management**: If the clustering step is too slow, increase the minimum abundance threshold during the `prepare` step to filter out singletons (reads appearing only once).
- **Multi-mapping Strategy**: `seqcluster` uses a heuristic to assign multi-mapping reads to the most likely cluster. Review the `report.pdf` to see the distribution of "unique" vs "multi-mapped" assignments.
- **Reference Selection**: Always include structural RNAs (rRNA, tRNA) in your annotation references to filter out degradation products that might otherwise be misidentified as novel small RNAs.

## Reference documentation
- [seqcluster Overview](./references/anaconda_org_channels_bioconda_packages_seqcluster_overview.md)