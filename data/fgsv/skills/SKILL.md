---
name: fgsv
description: The fgsv toolkit detects and aggregates genomic breakpoint evidence from sequencing alignments to identify structural variants. Use when user asks to detect structural variant breakpoints, aggregate and merge breakpoint evidence, or convert structural variant data to BEDPE format.
homepage: https://github.com/fulcrumgenomics/fgsv
metadata:
  docker_image: "quay.io/biocontainers/fgsv:0.2.1--hdfd78af_1"
---

# fgsv

## Overview

The `fgsv` toolkit is a specialized suite of tools for structural variant investigation, focusing on the detection and aggregation of breakpoint evidence. Rather than acting as a standalone SV caller, it provides a procedural workflow to identify junctions between genomic loci (breakpoints) by analyzing "chains" of primary and supplementary alignments. It is particularly useful for researchers needing to extract high-confidence breakpoint coordinates from short-read sequencing data and visualize them in standard formats.

## Core Workflow and CLI Usage

### 1. Initial Breakpoint Detection (`SvPileup`)
The first step involves scanning alignments for structural variant evidence. This tool identifies "jumps" between reference sequences or distant loci within the same sequence.

*   **Requirement**: Input BAM must be **queryname-grouped** (or queryname-sorted).
*   **Logic**: It constructs a chain of aligned sub-segments for each template. It marks breakpoints when inter-segment jumps exceed 100bp (intra-read) or 1000bp (inter-read).

```bash
fgsv SvPileup \
    --input sample.queryname_grouped.bam \
    --output sample.svpileup.txt
```

### 2. Polishing and Merging (`AggregateSvPileup`)
Because alignment artifacts or sequencing errors can cause a single true breakpoint to appear as multiple nearby events, this tool clusters evidence to reduce false positives.

*   **Logic**: Merges breakpoints if breakends map to the same strands/sequences and are within a 10bp threshold (default).
*   **Output**: A table of aggregated events and a BAM file where alignments are tagged with the aggregate breakpoint ID.

```bash
fgsv AggregateSvPileup \
    --bam sample.bam \
    --input sample.svpileup.txt \
    --output sample.svpileup.aggregate.txt
```

### 3. Format Conversion (`AggregateSvPileupToBedPE`)
To use the results with other bioinformatic tools or genome browsers, convert the aggregated output to BEDPE format.

```bash
fgsv AggregateSvPileupToBedPE \
    --input sample.svpileup.aggregate.txt \
    --output sample.svpileup.aggregate.bedpe
```

## Expert Tips and Best Practices

*   **Coordinate System**: All point intervals reported by `fgsv` are **1-based inclusive** relative to the reference sequence.
*   **Evidence Prioritization**: When both split-read (intra-read) and discordant pair (inter-read) evidence exist for the same event, `fgsv` favors the split-read evidence as it provides nucleotide-level precision for the breakpoint.
*   **Memory Management**: Since `fgsv` processes query groups, ensure your BAM is properly grouped to prevent the tool from holding excessive data in memory or failing to link mate pairs.
*   **Filtering**: Use the output of `AggregateSvPileup` to filter for events with high "support" (number of reads) to distinguish true somatic or germline variants from background noise.



## Subcommands

| Command | Description |
|---------|-------------|
| fgsv AggregateSvPileup | Aggregates and merges pileups that are likely to support the same breakpoint. |
| fgsv AggregateSvPileupToBedPE | Convert the output of AggregateSvPileup to BEDPE. |
| fgsv FilterAndMerge | Filters and merges SVPileup output. |
| fgsv SvPileup | Collates pileups of reads over breakpoint events. |

## Reference documentation

- [Introduction to fgsv](./references/github_com_fulcrumgenomics_fgsv_blob_main_docs_01_Introduction.md)
- [SvPileup Tool Details](./references/github_com_fulcrumgenomics_fgsv_blob_main_docs_tools_SvPileup.md)
- [AggregateSvPileup Tool Details](./references/github_com_fulcrumgenomics_fgsv_blob_main_docs_tools_AggregateSvPileup.md)
- [AggregateSvPileupToBedPE Tool Details](./references/github_com_fulcrumgenomics_fgsv_blob_main_docs_tools_AggregateSvPileupToBedPE.md)
- [fgsv README](./references/github_com_fulcrumgenomics_fgsv_blob_main_README.md)