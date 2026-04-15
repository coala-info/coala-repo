---
name: seg-suite
description: The seg-suite toolkit performs composition, transformation, and intersection operations on sequence alignments and genomic annotations using a unified segment format. Use when user asks to convert genomic formats to seg, compose alignments to transfer coordinates between genomes, find intersections or differences between coordinate sets, or mask sequences based on genomic regions.
homepage: https://github.com/mcfrith/seg-suite
metadata:
  docker_image: "quay.io/biocontainers/seg-suite:98--py310h184ae93_0"
---

# seg-suite

## Overview

The `seg-suite` is a specialized toolkit for the composition and transformation of sequence alignments and genomic annotations. By treating annotations as alignments (e.g., a gene aligned to a chromosome), the suite allows for complex operations like transferring gene coordinates from one genome to another using a reference alignment. The suite operates on the "seg" format, a simple tab-delimited representation of sequence segments.

Use this skill when you need to:
- Convert various alignment and annotation formats to a unified segment format.
- Perform "alignment composition" to link disparate sequence relationships.
- Find intersections, differences, or containments between sets of genomic coordinates.
- Mask specific regions of a genome in FASTA or FASTQ files.

## The "seg" Format

The suite uses a coordinate-based format where each line represents a segment or a gapless alignment:
- **Single Segment**: `length  sequence_name  start_coordinate`
- **Segment Pair**: `length  seq1_name  seq1_start  seq2_name  seq2_start`
- **Coordinates**: 0-based. A segment at the very beginning of a sequence starts at 0.
- **Strands**: Forward strands use positive coordinates. Reverse strands are indicated by **negative** start coordinates, where the value points to the 5'-end of the segment.

## Tool Usage and Patterns

### seg-import: Format Conversion
Converts external formats to `.seg`. Supported formats include `maf`, `psl`, `bed`, `genePred`, `gtf`, `rmsk`, and `lastTab`.

```bash
# Basic conversion
seg-import maf alignments.maf > alignments.seg

# Extract specific features from GTF/BED/genePred
seg-import gtf -c genes.gtf > coding_regions.seg
seg-import gtf -i genes.gtf > introns.seg
seg-import gtf -5 genes.gtf > five_prime_utrs.seg
```

**Key Options:**
- `-f N`: Force the Nth segment in each line to be forward-stranded (flips the whole line if necessary).
- `-a`: Appends alignment number and position (useful for tracking lines belonging to the same gapped alignment).

### seg-join: Composition and Intersections
Joins two `.seg` files based on overlaps in their **first** sequence. 

**CRITICAL**: Both input files must be sorted (typically via `seg-sort`) before using `seg-join`.

```bash
# Compose alignments: If ab.seg maps A->B and ac.seg maps A->C, 
# this creates a triple mapping A->B->C
seg-join ab.seg ac.seg > abc.seg

# Find segments in x.seg wholly contained within y.seg
seg-join -c1 x.seg y.seg > inside.seg

# Find parts of x.seg that do NOT overlap y.seg (subtraction)
seg-join -v1 x.seg y.seg > difference.seg

# Join based on identical coordinates in ALL sequences (not just the first)
seg-join -w ab.seg cd.seg > intersection.seg
```

**Filtering Options:**
- `-n PERCENT`: Output file 2 segments only if at least PERCENT is covered by file 1.
- `-f FILENUM`: Output the whole tuple from the specified file if it overlaps the other.

### seg-mask: Sequence Masking
Masks segments in a FASTA/FASTQ file based on a `.seg` file.

```bash
# Default: lowercase masked regions, uppercase others
seg-mask segments.seg genome.fa > masked_genome.fa

# Mask with a specific character (e.g., 'N')
seg-mask -x N repeats.seg genome.fa > hard_masked.fa
```

## Expert Tips
- **Alignment Composition**: To transfer annotations from Human to Mouse using a Human-Mouse alignment:
  1. Convert Human annotations to `.seg` (e.g., `seg-import gtf human.gtf`).
  2. Ensure the first column of the annotation and the alignment file is the shared sequence (Human).
  3. Sort both and use `seg-join`.
- **Sorting**: Always ensure your `.seg` files are sorted by sequence name and then coordinate before attempting a join.
- **Reverse Strands**: Remember that a negative coordinate like `-7` means the segment's 5'-end is at position 7 on the reverse strand.



## Subcommands

| Command | Description |
|---------|-------------|
| seg-import | Read segments or alignments in various formats, and write them in SEG format. |
| seg-join | Read two SEG files, and write their JOIN. |
| sort | Sort lines of text |

## Reference documentation
- [seg-suite README](./references/github_com_mcfrith_seg-suite_blob_master_README.rst.md)