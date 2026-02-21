---
name: deeptoolsintervals
description: The `deeptoolsintervals` library is a specialized Python module for constructing and querying interval trees based on genomic annotations.
homepage: https://github.com/deeptools/deeptools_intervals
---

# deeptoolsintervals

## Overview

The `deeptoolsintervals` library is a specialized Python module for constructing and querying interval trees based on genomic annotations. Unlike standard interval tree implementations, it is optimized to store and retrieve associated metadata, including exon coordinates and custom group tags. Use this skill to efficiently find overlaps between genomic regions and annotated features while maintaining the hierarchical structure of transcripts and exons.

## Core Usage Patterns

### Initializing the GTF Class
The `GTF` class is the primary interface. It can load single or multiple files (GTF or BED).

```python
from deeptoolsintervals import GTF

# Load a single GTF file
gtf = GTF("annotations.gtf")

# Load multiple files (GTF and compressed BED)
# By default, exon information is NOT stored to save memory.
gtf = GTF(["file1.gtf", "file2.bed.gz"], keepExons=True)
```

### Finding Overlaps
The `findOverlaps` method uses 0-based, half-open coordinates (standard BED format).

```python
# Basic overlap search
overlaps = gtf.findOverlaps("chr1", 1000, 2000)

# Advanced search with strand and match constraints
# matchType=1: Exact match of coordinates
# strandType=3: Match specific strand (ignore '.')
overlaps = gtf.findOverlaps("chr1", 1000, 2000, strand="+", matchType=1, strandType=3)
```

### Output Structure
The method returns a list of tuples. Each tuple contains:
1. Start position (0-based)
2. End position (1-based)
3. ID (Transcript ID for GTF, Column 4 for BED)
4. Group Label
5. List of exon coordinates (if `keepExons=True`)
6. Strand

## Metadata and Labeling

### Group Labels
Labels allow you to categorize intervals. They can be defined within the files or passed during initialization.

*   **In BED files**: Use trailing comments (e.g., `chr1 100 200 #MyGroup`).
*   **In GTF files**: Use the `deepTools_group` attribute (e.g., `... transcript_id "ID"; deepTools_group "Group1";`).
*   **Manual Override**: Pass a list of labels to the constructor. The number of labels must match the number of groups encountered.

```python
gtf = GTF(["file1.gtf"], labels=["Control", "Treatment"])
# Or update after loading
gtf.labels = ["NewName"]
```

### GTF-Specific Customization
If your GTF uses non-standard feature names (e.g., using "gene" instead of "transcript"), use these parameters:
*   `exonID`: The feature type to treat as exons (default: "exon").
*   `transcriptID`: The feature type to treat as the parent interval (default: "transcript").
*   `transcript_id_designator`: The attribute key for the ID (default: "transcript_id").

## Expert Tips

*   **Parallel Processing**: When dividing the genome into chunks for parallel analysis, set `trimOverlap=True` in `findOverlaps`. This prevents intervals that span across chunk boundaries from being processed multiple times.
*   **Chromosome Naming**: The tool attempts to automatically convert between chromosome naming systems (e.g., "chr1" vs "1"). If queries return unexpected empty results, verify that the naming convention in your query matches the file or that the conversion is succeeding.
*   **Memory Management**: Only set `keepExons=True` if you specifically need sub-interval coordinates. Storing exon bounds significantly increases memory usage for large annotation files.
*   **Duplicate IDs**: The library automatically ignores duplicate transcript IDs within GTF files to maintain biological consistency.

## Reference documentation
- [deeptoolsintervals Overview](./references/anaconda_org_channels_bioconda_packages_deeptoolsintervals_overview.md)
- [deeptools_intervals GitHub README](./references/github_com_deeptools_deeptools_intervals.md)