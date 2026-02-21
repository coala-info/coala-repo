---
name: gfainject
description: gfainject is a specialized tool for "injecting" standard genomic alignments into pangenome graphs.
homepage: https://github.com/AndreaGuarracino/gfainject
---

# gfainject

## Overview
gfainject is a specialized tool for "injecting" standard genomic alignments into pangenome graphs. It takes alignments produced by traditional mappers and projects them onto the paths defined within a GFA file. This process is critical for downstream pangenome analysis, as it transforms linear reference-based coordinates into a sequence of graph steps (GAF). The tool is highly efficient, supports compressed graph inputs, and can handle complex alignment features like alternative hits and paired-end data.

## Installation
The recommended way to install gfainject is via Bioconda:
```bash
conda install bioconda::gfainject
```

## Core CLI Patterns

### Basic Format Conversion
Map linear alignments to a GFA graph to produce GAF output.
```bash
# From SAM
gfainject --gfa graph.gfa --sam aligned.sam > output.gaf

# From BAM
gfainject --gfa graph.gfa --bam aligned.bam > output.gaf

# From PAF
gfainject --gfa graph.gfa --paf aligned.paf > output.gaf
```

### Working with Compressed Graphs
gfainject natively supports gzip and bgzip compressed GFA files without manual decompression.
```bash
gfainject --gfa graph.gfa.gz --bam aligned.bam > output.gaf
```

### Streaming and Piping
For large datasets, pipe input from tools like `samtools` to avoid intermediate disk usage. Use `-` to denote stdin.
```bash
samtools view -h aligned.bam | gfainject --gfa graph.gfa --sam - > output.gaf
```

### Handling Alternative Alignments
If your alignment file contains alternative hits (e.g., in the `XA` tag of a SAM/BAM file), use `--alt-hits` to include them in the GAF output.
```bash
gfainject --gfa graph.gfa --bam aligned.bam --alt-hits 5 > output.gaf
```

### Path Range Queries
To debug or analyze a specific region of a path within the graph, use the `--range` flag.
```bash
gfainject --gfa graph.gfa --range "chr1:1000-2000" --bam aligned.bam > subset.gaf
```

## Expert Tips and Best Practices

*   **Name Matching**: The most common cause of failure is a mismatch between reference names. Ensure that the reference sequence names in your BAM/PAF headers exactly match the `P` (Path) or `W` (Walk) line names in your GFA file.
*   **Output Format**: The output GAF includes the 12 standard columns. It also appends the CIGAR string in the `cg:Z` tag, which is essential for tools that require base-level alignment details within the graph.
*   **Paired-End Reads**: gfainject automatically handles paired-end reads by recognizing `/1` and `/2` suffixes, ensuring that both ends of a fragment are correctly mapped to the graph paths.
*   **Memory Efficiency**: When working with massive pangenomes, prefer BAM or GBAM inputs over SAM to reduce the memory footprint and processing time.

## Reference documentation
- [gfainject GitHub Repository](./references/github_com_AndreaGuarracino_gfainject.md)
- [gfainject Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gfainject_overview.md)