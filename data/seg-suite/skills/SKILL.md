---
name: seg-suite
description: The seg-suite toolkit performs composition and manipulation of sequence alignments and genomic annotations using a segment-based coordinate system. Use when user asks to convert MAF or BED files to seg format, compose transitive alignments between multiple species, or project annotations across different coordinate systems.
homepage: https://github.com/mcfrith/seg-suite
---


# seg-suite

## Overview
The `seg-suite` is a specialized toolkit designed for the composition and manipulation of sequence alignments and annotations. It treats genomic features as "segments"—tuples of length, sequence name, and start coordinate—allowing for complex operations like transitive alignment composition (e.g., mapping Species A to Species C via Species B) and the projection of annotations across different coordinate systems. It is particularly useful for comparative genomics workflows where gapped alignments need to be processed as sets of gapless blocks.

## The "seg" Format
The suite operates on a tab-separated format where each line represents a segment or alignment block:
- **Single segment**: `length  seqName  start`
- **Alignment pair**: `length  seq1Name  seq1Start  seq2Name  seq2Start`
- **Coordinates**: Zero-based. The start coordinate always indicates the 5'-end.
- **Strands**: Reverse strands are indicated by negative start coordinates (e.g., a segment of length 6 starting at coordinate 7 on the reverse strand is represented as `-7`).

## Core CLI Patterns

### 1. Importing Data
Convert standard bioinformatics formats to `.seg` using `seg-import`.
```bash
# Convert MAF alignment to seg
seg-import maf input.maf > output.seg

# Extract specific gene features from GTF/BED
seg-import gtf input.gtf -c > cds.seg
seg-import gtf input.gtf -i > introns.seg
seg-import bed input.bed -5 > five_prime_utr.seg
```
**Key Options:**
- `-f N`: Force the Nth segment to be forward-stranded (flips the whole line if necessary).
- `-a`: Add alignment ID and position (useful for tracking which blocks belong to the same gapped alignment).

### 2. Sorting Segments
Files must be sorted before using `seg-join`.
```bash
seg-sort input.seg > input.sorted.seg
```

### 3. Joining and Composing Alignments
Use `seg-join` to find intersections or compose alignments.
```bash
# Compose Species A-B and Species A-C alignments to get B-C
seg-join ab.sorted.seg ac.sorted.seg > abc.seg

# Find segments in x.seg that are entirely contained within y.seg
seg-join -c1 x.sorted.seg y.sorted.seg > inside.seg

# Get parts of x.seg that do NOT overlap y.seg (subtraction)
seg-join -v1 x.sorted.seg y.sorted.seg > difference.seg
```
**Advanced Join Options:**
- `-n [PERCENT]`: Output tuple from file 2 if at least X% is covered by file 1 (e.g., `-n30` or `-n1/3`).
- `-x [PERCENT]`: Output tuple from file 2 if at most X% is covered by file 1.
- `-w`: Join based on identical coordinates across all sequences in the tuple, not just the first.

## Expert Tips
- **Annotation Transfer**: To move annotations from Genome A to Genome B, import the annotations as segments and the A-B alignments as segment-pairs. Use `seg-join` to intersect them; the resulting segment-triple will contain the B coordinates for the A-features.
- **Gapped Alignments**: `seg-suite` handles gapped alignments by treating them as a collection of gapless segments. Use the `-a` flag during import to maintain the relationship between these segments.
- **Memory Efficiency**: Because `seg-join` requires sorted input, it processes files linearly, making it efficient for very large genomic datasets.

## Reference documentation
- [github_com_mcfrith_seg-suite.md](./references/github_com_mcfrith_seg-suite.md)
- [anaconda_org_channels_bioconda_packages_seg-suite_overview.md](./references/anaconda_org_channels_bioconda_packages_seg-suite_overview.md)