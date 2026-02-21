---
name: fade
description: `fade` (Fragmentase Artifact Detection and Elimination) is a specialized bioinformatics tool designed to clean up DNA sequencing data.
homepage: https://github.com/blachlylab/fade
---

# fade

## Overview
`fade` (Fragmentase Artifact Detection and Elimination) is a specialized bioinformatics tool designed to clean up DNA sequencing data. It targets artifacts introduced during enzymatic shearing, which often manifest as sequences from the opposite strand being ligated to the fragment. By identifying these via soft-clip re-alignment, `fade` can either filter out the problematic reads entirely or trim the artifactual sequences to preserve the valid portion of the data.

## Core Workflow
The standard `fade` pipeline requires three primary steps: annotation, sorting, and elimination.

### 1. Annotate Artifacts
The `annotate` command performs Smith-Waterman local alignment on soft-clipped regions to identify artifacts. It adds the `rs` (bitflag) and `am` (realignment) tags to the BAM records.

```bash
fade annotate -t 8 -b input.bam reference.fasta > annotated.bam
```
*   **-t**: Specify extra threads for parsing.
*   **--min-length**: Minimum soft-clip length to consider (default is usually sufficient).

### 2. Queryname Sort (Critical Step)
Before running the elimination step, you must sort the BAM file by query name. This ensures that `fade` can see both reads in a pair (R1 and R2) simultaneously.

```bash
samtools sort -n annotated.bam > annotated.qsort.bam
```

### 3. Eliminate or Clip Artifacts
The `out` command uses the tags created in step 1 to process the reads.

**Option A: Filter (Recommended)**
Removes the entire fragment (both R1 and R2) if an artifact is detected on either read.
```bash
fade out -b annotated.qsort.bam > filtered.bam
```

**Option B: Hard Clip**
Trims the artifactual sequence from the read instead of deleting the read.
```bash
fade out -c -b annotated.qsort.bam > clipped.bam
```

## Expert Tips and Best Practices
*   **Fragment-Level Logic**: Always use queryname-sorted BAMs for `fade out`. If the file is coordinate-sorted, `fade` will only eject the specific read containing the artifact, orphaning its mate. The tool assumes the entire fragment is biased and should be removed together.
*   **Post-Processing**: Because `fade annotate` works in parallel, the output order is non-deterministic. You must re-sort the final output (e.g., `samtools sort`) before indexing or viewing in IGV.
*   **Fixing Mate Info**: If using the `-c` (clip) flag in `fade out`, the starting positions of alignments may change. It is highly recommended to run `Picard FixMateInformation` after the final sort to ensure BAM consistency.
*   **Docker Usage**: If running via Docker, ensure you mount your current working directory to `/data` and reference files relative to that path.
    ```bash
    docker run -v `pwd`:/data blachlylab/fade annotate -b /data/in.bam /data/ref.fa > out.bam
    ```
*   **Statistics**: Use `fade stats` after the annotation step to generate a report on the percentage of soft-clipped reads and identified artifacts to assess the severity of fragmentation bias in your library.

## Reference documentation
- [GitHub Repository - blachlylab/fade](./references/github_com_blachlylab_fade.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_fade_overview.md)