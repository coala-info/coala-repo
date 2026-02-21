---
name: perbase
description: perbase is a specialized bioinformatics utility written in Rust, designed to provide extremely fast and accurate per-base metrics from sequencing alignment files.
homepage: https://github.com/sstadick/perbase
---

# perbase

## Overview
perbase is a specialized bioinformatics utility written in Rust, designed to provide extremely fast and accurate per-base metrics from sequencing alignment files. It excels at breaking down the composition of every genomic position, providing counts for all four nucleotides, ambiguity codes, insertions, and deletions. It is significantly faster than traditional tools like bam-readcount or sambamba because it leverages Rust's concurrency to automatically parallelize analysis over input regions.

## Core CLI Usage

The primary tool within the suite is `base-depth`.

### Basic Depth Analysis
To generate a table of per-base metrics for an entire BAM or CRAM file:
```bash
perbase base-depth input.bam
```

### Using a Reference Genome
Providing a reference FASTA allows the tool to include the `REF_BASE` column in the output, which is essential for identifying mismatches:
```bash
perbase base-depth --reference-fasta reference.fasta input.bam
```

### Compressed Output and Indexing
For large-scale analyses, always use the compressed output flag (`-Z`) and index the resulting file with `tabix` for rapid downstream querying:
```bash
# Generate compressed output
perbase base-depth -Z input.bam -o output.tsv.gz

# Index with tabix (Columns: REF=1, POS=2)
tabix -S 1 -s 1 -b 2 -e 2 output.tsv.gz

# Query a specific region
tabix output.tsv.gz chr1:1000-2000
```

## Advanced Features and Best Practices

### Overlapping Mate Resolution
When working with paired-end data, overlapping mates can artificially inflate depth. Use the `--mate-fix` flag to resolve these overlaps.

**Recommended Strategies:**
*   `BaseQualMapQualFirstInPair`: (Standard) Prioritizes the base with higher quality, then higher MAPQ.
*   `MapQualBaseQualIUPAC`: Prioritizes mapping quality and returns IUPAC ambiguity codes for ties.
*   `N`: Conservative approach; returns 'N' if mates disagree.

Example command:
```bash
perbase base-depth --mate-fix --mate-resolution-strategy BaseQualMapQualFirstInPair input.bam
```

### Handling Empty SEQ Fields
perbase gracefully handles BAM records with empty SEQ fields (marked as `*`). These reads contribute to the total `DEPTH` but are categorized under the `N` column since the specific nucleotide is unknown.

### Understanding Depth Calculations
Be aware of how perbase differs from other tools to ensure consistent results:
*   **Deletions (DEL):** Counted toward total depth.
*   **Reference Skips (REF_SKIP):** Not counted toward depth (unlike sambamba).
*   **Failures:** Reads failing filters are tracked in the `FAIL` column but do not contribute to `DEPTH`.

## Expert Tips
*   **Performance:** perbase scales linearly with available compute resources. On high-core machines, it can be orders of magnitude faster than single-threaded alternatives.
*   **Memory Management:** If you encounter performance bottlenecks on extremely high-coverage sites, ensure you are using the latest version, as optimizations for "deep" regions are a primary focus of the tool.
*   **IUPAC Codes:** If your downstream pipeline can handle ambiguity, use the `IUPAC` strategies to preserve information about heterogeneous base calls between mates.

## Reference documentation
- [perbase GitHub Repository](./references/github_com_sstadick_perbase.md)
- [Bioconda perbase Overview](./references/anaconda_org_channels_bioconda_packages_perbase_overview.md)