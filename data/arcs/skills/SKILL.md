---
name: arcs
description: ARCS (Assembly Roundup by Linked-Read Scaffolding) and its alignment-free variant, ARKS, are tools designed to organize genomic contigs into larger scaffolds.
homepage: https://github.com/bcgsc/arcs
---

# arcs

## Overview

ARCS (Assembly Roundup by Linked-Read Scaffolding) and its alignment-free variant, ARKS, are tools designed to organize genomic contigs into larger scaffolds. By utilizing the long-range information provided by linked-read barcodes or the inherent connectivity of long reads, these tools identify which contigs belong together and in what orientation. The process typically involves a three-step pipeline: generating a connectivity graph, converting that graph into a format compatible with the LINKS scaffolder, and finally performing the scaffolding.

## Core Execution Modes

The `arcs-make` wrapper is the primary interface for running the full pipeline. Choose the mode based on your data type and computational constraints:

- **ARCS (Default):** Uses read alignments. Recommended for very fragmented assemblies or large genomes where accuracy is paramount.
- **ARKS (`--arks`):** Uses alignment-free k-mer mapping. Significantly faster than ARCS and suitable for most standard linked-read datasets.
- **ARCS-long / ARKS-long:** Specifically for long reads. These modes segment long reads into "pseudo-linked" reads to leverage the scaffolding algorithm.

## Common CLI Patterns

### Scaffolding with Linked Reads
For 10x Genomics or similar data, ensure reads are interleaved and contain the barcode in the `BX` tag.

```bash
# Using ARKS (alignment-free) for speed
arcs-make arks draft=assembly.fa reads=interleaved_reads.fq.gz k=60

# Using ARCS (alignment-based)
arcs-make arcs draft=assembly.fa reads=interleaved_reads.fq.gz z=1000
```

### Scaffolding with Long Reads
Long reads are automatically converted to pseudo-linked reads during the process.

```bash
# Using ARKS-long (k-mer based)
arcs-make arks-long draft=assembly.fa reads=long_reads.fa.gz k=20 j=0.05

# Using ARCS-long (alignment based)
arcs-make arcs-long draft=assembly.fa reads=long_reads.fa.gz
```

## Parameter Tuning & Best Practices

### General Parameters
- `draft`: Path to the input draft assembly (FASTA).
- `reads`: Path to the reads file (FASTQ/FASTA, can be gzipped).
- `z`: Minimum contig length to consider for scaffolding (default is often 1000bp).
- `k`: K-mer size (for ARKS modes).

### Long Read Optimization
Long reads have higher error rates. When using `arks-long` or `arcs-long`, start with these suggested values to account for noise:
- `m=8-10000` (Range of k-mer head/tail distance)
- `j=0.05` (Jaccard coefficient threshold for ARKS-long)
- `c=4` (Minimum number of links to establish an edge)
- `l=4` (Minimum number of barcodes to establish an edge)
- `a=0.3` (Minimum ratio of links to the next best candidate)

### Workflow Tips
1. **Interleaved Reads:** ARCS expects linked reads to be interleaved. If using raw Chromium reads, run `Long Ranger basic` first to generate the appropriate file.
2. **Dependency Check:** Ensure `LINKS` is installed and in your PATH, as ARCS generates the evidence graph but relies on LINKS to perform the final sequence joining.
3. **Memory Management:** ARKS is generally more memory-efficient than alignment-based ARCS, making it the preferred choice for initial passes on large datasets.

## Reference documentation
- [ARCS GitHub Repository](./references/github_com_bcgsc_arcs.md)
- [Bioconda ARCS Overview](./references/anaconda_org_channels_bioconda_packages_arcs_overview.md)