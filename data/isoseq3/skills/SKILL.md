---
name: isoseq3
description: isoseq3 transforms PacBio HiFi reads into high-quality, full-length transcript sequences for bulk or single-cell RNA-seq analysis. Use when user asks to refine reads, cluster transcripts, deduplicate UMI-tagged data, or generate polished isoforms.
homepage: https://github.com/PacificBiosciences/IsoSeq3
metadata:
  docker_image: "quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0"
---

# isoseq3

## Overview
The `isoseq3` (now often invoked as `isoseq`) toolset is designed to transform PacBio Circular Consensus Sequence (CCS) reads into high-quality, full-length transcript sequences. It supports two primary workflows: a standard clustering workflow for bulk RNA-seq and a deduplication workflow for single-cell or UMI-tagged data. This skill provides the necessary command-line patterns to execute these workflows, from initial refinement to final polished isoform generation.

## Core Workflows

### 1. Standard Clustering Workflow (Bulk RNA-seq)
Use this workflow to generate transcripts from HiFi reads by clustering similar sequences.

**Step A: Refine**
Remove primers, trim poly(A) tails, and remove concatemers.
```bash
# Basic refinement
isoseq refine movie.fl.bam primers.fasta output.flnc.bam --require-polya
```

**Step B: Cluster**
Generate polished isoforms using hierarchical alignment and iterative merging.
```bash
# Use --use-qvs to utilize quality values for better consensus
isoseq cluster output.flnc.bam clustered.bam --verbose --use-qvs
```

**Step C: Polish (Optional)**
Improve consensus quality using original subreads (time-intensive).
```bash
isoseq polish clustered.bam merged.subreadset.xml polished.bam
```

### 2. Deduplication Workflow (Single-Cell/UMI)
Use this workflow when your library includes UMIs or Cell Barcodes.

**Step A: Tag**
Clip and associate UMIs/Barcodes based on a design string (e.g., `T-10U-16B`).
```bash
isoseq tag movie.fl.bam output.flt.bam --design T-10U-16B
```

**Step B: Refine**
Perform refinement on the tagged BAM.
```bash
isoseq refine output.flt.bam primers.fasta output.fltnc.bam --require-polya
```

**Step C: Deduplicate**
Cluster reads by UMI and cell barcode to generate one consensus per founder molecule.
```bash
isoseq dedup output.fltnc.bam deduped.bam
```

## Expert Tips and Best Practices

- **Binary Naming**: While the package is often installed as `isoseq3`, the modern command-line tool is simply `isoseq`.
- **Parallelization**: 
    - `isoseq cluster` cannot be internally parallelized easily; provide as many CPU cores as possible.
    - For large datasets, use `--split-bam <N>` in the cluster step to create multiple BAM files that can be polished in parallel.
- **Poly(A) Selection**: Always use `--require-polya` if your library prep included poly(A) selection. This ensures only true full-length transcripts with a minimum tail length (default 20bp) are kept.
- **SMRT Cell Merging**: If processing multiple SMRT cells, create a "File of Filenames" (`.fofn`) containing the paths to all your `.flnc.bam` files and provide the `.fofn` as input to the cluster/dedup step.
- **Memory Management**: Clustering hundreds of millions of reads (e.g., using `cluster2`) requires significant RAM. Monitor system resources during the hierarchical alignment phase.



## Subcommands

| Command | Description |
|---------|-------------|
| isoseq bcstats | Generates stats for group barcodes and (optionally) molecular barcodes |
| isoseq cluster | Cluster FLNC reads and generate transcripts (FLNC to TRANSCRIPTS) |
| isoseq cluster2 | Cluster FLNC reads and generate transcripts, much faster than "cluster" (FLNC to TRANSCRIPTS) |
| isoseq collapse | Collapse transcripts based on genomic mapping |
| isoseq correct | Correct group barcodes given a barcode truth set |
| isoseq dedup | Deduplicate PCR artifacts (FLTNC to DEDUP) |
| isoseq refine | Remove polyA and concatemers from FL reads and generate FLNC transcripts (FL to FLNC) |
| isoseq summarize | Create barcode overview from transcripts (TRANSCRIPTS to CSV) |
| isoseq tag | Remove cell barcodes and UMIs from FL reads and generate tagged FL transcripts (FL to FLT) |
| isoseq3_groupdedup | Deduplicate PCR artifacts grouped by cell barcode (barcode-sorted FLTNC to DEDUP) |

## Reference documentation
- [IsoSeq Clustering Workflow](./references/github_com_PacificBiosciences_IsoSeq_blob_master_isoseq-clustering.md)
- [IsoSeq Deduplication and Tagging](./references/github_com_PacificBiosciences_IsoSeq_blob_master_isoseq-deduplication.md)
- [IsoSeq Project Overview](./references/github_com_PacificBiosciences_IsoSeq_blob_master_README.md)