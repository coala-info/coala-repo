---
name: pairix
description: Pairix is a specialized indexing tool designed to handle 2D genomic coordinates.
homepage: https://github.com/4dn-dcic/pairix
---

# pairix

## Overview
Pairix is a specialized indexing tool designed to handle 2D genomic coordinates. While tools like tabix are optimized for 1D intervals (e.g., BED, VCF), pairix extends this capability to pairs of coordinates, allowing for rapid retrieval of data representing interactions between two genomic regions. It works by creating a `.px2` index for bgzipped text files, enabling users to query specific genomic "rectangles" or interactions without reading the entire dataset.

## Core CLI Workflows

### 1. Preparation and Indexing
Files must be compressed with `bgzip` and sorted before indexing. For 2D indexing, sort by the first chromosome, then the second chromosome, and finally the first genomic position.

```bash
# Compress the text file
bgzip data.pairs

# Index using a preset (pairs, merged_nodups, gff, vcf, bed, sam)
pairix -p pairs data.pairs.gz

# Custom indexing for non-standard columns (1-based indices)
# -s: chr1, -d: chr2, -b: pos1_start, -e: pos1_end, -u: pos2_start, -v: pos2_end
pairix -s1 -d3 -b2 -e2 -u4 -v4 data.custom.gz
```

### 2. Querying Regions
Queries use a specific string format to define the 2D region.

```bash
# Standard 2D query (chr1:start-end|chr2:start-end)
pairix data.pairs.gz 'chr1:1000-2000|chr2:5000-6000'

# 1D query on a 2D indexed file using wildcards
pairix data.pairs.gz 'chr1:1000-2000|*'

# Query using a file containing multiple regions (one per line)
pairix -L data.pairs.gz regions.txt
```

## Expert Tips and Best Practices

*   **The Auto-Flip Flag (`-a`)**: Most 2D genomic files (like 4DN pairs) are stored in an "upper triangle" format where `chr1` < `chr2`. If you query a region in the reverse order (e.g., `chrY|chrX`), pairix will return nothing by default. Always use the `-a` flag to automatically flip the query chromosomes to match the file's internal sorting.
*   **Space-Delimited Files**: If your input file is space-delimited rather than tab-delimited, you must use the `-T` flag during indexing.
*   **Delimiter Conflicts**: If your chromosome names contain the pipe character (`|`), use the `-w` option during indexing to change the region split character (e.g., `pairix -w '^' data.gz`).
*   **Metadata and Headers**: Pairix handles files with headers (lines starting with `#`). When querying, these headers are typically skipped, and only the matching data lines are returned.
*   **BAM Conversion**: Use the included `bam2pairs` utility to convert alignment files directly into a format suitable for pairix indexing.

## Reference documentation
- [Pairix GitHub Repository](./references/github_com_4dn-dcic_pairix.md)
- [Bioconda Pairix Package](./references/anaconda_org_channels_bioconda_packages_pairix_overview.md)