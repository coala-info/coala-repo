---
name: umap
description: The `umap` software suite provides a deterministic way to identify which regions of a genome can be uniquely mapped by sequencing reads of a specific length.
homepage: https://bitbucket.org/hoffmanlab/umap/
---

# umap

## Overview
The `umap` software suite provides a deterministic way to identify which regions of a genome can be uniquely mapped by sequencing reads of a specific length. This is essential for filtering out ambiguous genomic regions in NGS pipelines, particularly for ChIP-seq, ATAC-seq, and DNA methylation analysis (Bismap). It helps researchers understand the "mappability" of a reference genome to avoid false positives in peak calling or methylation quantification.

## Core Workflows

### Genome Mappability (Umap)
To calculate the uniqueness of genomic positions for a specific read length ($k$):
1. **Generate $k$-mers**: Create all possible $k$-mers from the reference genome.
2. **Map $k$-mers**: Align these $k$-mers back to the genome using a fast aligner (typically Bowtie).
3. **Calculate Uniqueness**: For each position, determine if the $k$-mer starting there maps to exactly one location.

### Methylome Mappability (Bismap)
Bismap accounts for the reduced complexity of bisulfite-converted DNA (C->T and G->A transitions):
1. **Convert Genome**: Create C->T and G->A converted versions of the reference.
2. **Map Converted $k$-mers**: Align converted $k$-mers to the converted genomes.
3. **Identify Mappable Cytosines**: Determine which cytosine positions can be uniquely identified despite the bisulfite conversion process.

## Best Practices
- **Read Length Selection**: Always match the $k$ parameter to the actual read length of your sequencing data. Common values are 24, 36, 50, 75, or 100.
- **Memory Management**: Genome-wide mappability calculations are memory-intensive. Ensure the system has enough RAM to hold the genome index (e.g., ~3GB for human genome with Bowtie).
- **Output Formats**: The tool typically produces `.uint8` or BigWig files. Use BigWig for visualization in genome browsers (IGV/UCSC) to identify problematic repetitive regions.
- **Filtering**: Use the generated mappability tracks to filter out signal in non-uniquely mappable regions before performing downstream statistical analysis.

## Reference documentation
- [Umap and Bismap Overview](./references/anaconda_org_channels_bioconda_packages_umap_overview.md)