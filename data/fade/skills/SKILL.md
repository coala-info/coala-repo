---
name: fade
description: FADE detects and eliminates sequencing artifacts introduced by enzymatic DNA fragmentation. Use when user asks to annotate BAM files for artifacts, filter or clip artifact-containing reads, report artifact statistics, or extract artifact sequences.
homepage: https://github.com/blachlylab/fade
---

# fade

## Overview

FADE (Fragmentase Artifact Detection and Elimination) is a specialized bioinformatics tool designed to address a specific type of sequencing artifact introduced by enzymatic DNA fragmentation. Unlike physical shearing (sonication), enzymatic methods can create unexpected alterations in the DNA source material, often manifesting as specific soft-clipped sequences that align elsewhere in the reference. This skill provides the procedural knowledge to run the FADE pipeline—from initial annotation of BAM files to the final extraction or clipping of artifact-free reads.

## Core Workflow

The standard FADE pipeline consists of three primary steps: annotation, sorting, and filtering.

### 1. Annotation
Identify potential artifacts by re-aligning soft-clipped regions to the reference genome.

```bash
fade annotate -b input.bam reference.fa > annotated.bam
```
*   **Input**: A BAM/SAM file and an indexed FASTA reference.
*   **Mechanism**: FADE extracts the reference sequence around the mapped read (default 300nt padding), reverse-complements the read, and performs a Smith-Waterman local alignment to detect stem-loop structures or other enzymatic artifacts.
*   **Key Flags**:
    *   `--min-length`: Minimum bases for a soft-clip to be considered (default is usually sufficient).
    *   `-w, --window-size`: Number of bases considered outside the read/mate region for re-alignment.

### 2. Queryname Sorting (Recommended)
To ensure FADE can remove entire fragments (both R1 and R2) when an artifact is found on either read, the BAM should be sorted by queryname.

```bash
samtools sort -n annotated.bam > annotated.qsort.bam
```

### 3. Elimination or Clipping
Remove the artifact-containing reads or hard-clip the artifact sequences.

**Option A: Filter entire fragments (Highest Stringency)**
```bash
fade out -b annotated.qsort.bam > filtered.bam
```

**Option B: Hard-clip artifacts (Preserve Read)**
```bash
fade out -c -b annotated.qsort.bam > clipped.bam
```
*   **Note**: If using the `-c` (clip) flag, you should run a tool like Picard `FixMateInformation` after re-sorting to ensure mate coordinates and flags are updated correctly.

## Advanced Operations and Diagnostics

### Reporting Statistics
Generate detailed reports on artifact prevalence after the annotation step.
*   `fade stats`: Reports extended info about identified artifact reads.
*   `fade stats-clip`: Reports info on all soft-clipped reads, regardless of artifact status.

### Extracting Artifacts
To inspect the artifacts themselves for quality control:
```bash
fade extract -b annotated.bam > artifacts_only.bam
```

## Expert Tips

*   **Parallelization**: `fade annotate` supports multi-threading. Use the `-t` flag to speed up processing on large datasets.
*   **Sorting Impact**: `fade annotate` works in parallel and does not guarantee output order. Always re-sort the output if you require coordinate-sorted BAMs for IGV or indexing.
*   **BAM Tags**: FADE adds specific tags to the BAM records:
    *   `rs`: A 6-bit flag indicating artifact status (e.g., bit 1 for left artifact, bit 2 for right).
    *   `am`: Mapping information for the artifact sequence (Chrom, Pos, CIGAR).
*   **Docker Usage**: When running via Docker, ensure you mount your local directory to `/data` and reference paths relative to that mount point.



## Subcommands

| Command | Description |
|---------|-------------|
| ./fade extract | extracts artifacts into a mapped SAM/BAM (used after annotate) |
| ./fade stats | reports extended information about all artifact reads (used after annotate) |
| ./fade stats-clip | reports extended information about all soft-clipped reads (used after annotate) |
| fade annotate | performs re-alignment of soft-clips and annotates bam records with bitflag (rs) and realignment tags (am) |
| fade out | Fragmentase Artifact Detection and Elimination. Removes all reads and mates for reads containing the artifact (used after annotate) or hard clips out artifact sequence from reads. |

## Reference documentation

- [FADE Main Documentation](./references/github_com_blachlylab_fade_blob_master_README.md)
- [BAM Tag Specifications](./references/github_com_blachlylab_fade_blob_master_TAGS.md)
- [Installation and Prerequisites](./references/github_com_blachlylab_fade_blob_master_INSTALL.md)