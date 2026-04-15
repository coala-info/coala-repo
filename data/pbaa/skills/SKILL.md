---
name: pbaa
description: The pbaa tool performs reference-aided clustering and consensus generation for PacBio HiFi amplicon data to resolve complex mixtures of alleles. Use when user asks to cluster HiFi reads using guide sequences, generate consensus sequences for amplicons, or visualize read assignments in a BAM file.
homepage: https://github.com/PacificBiosciences/pbAA
metadata:
  docker_image: "quay.io/biocontainers/pbaa:1.2.0--h9ee0642_0"
---

# pbaa

## Overview
The `pbaa` tool is a reference-aided (pseudo de-novo) clustering application specifically designed for PacBio HiFi data (>QV20). It excels at resolving complex mixtures of amplicons in samples with unknown copy numbers. By using guide sequences to group reads, it performs error correction and k-means clustering to produce accurate consensus sequences for each allele present in the sample.

## Core Workflows

### 1. Clustering and Consensus Generation
The primary command `pbaa cluster` processes HiFi reads against a set of guide sequences.

```bash
pbaa cluster [options] <guide.fasta> <reads.fastq> <output_prefix>
```

**Key Requirements:**
*   **HiFi Only:** Do not use with CLR data.
*   **Indexing:** Both the guide FASTA and the read FASTQ must be indexed using `samtools faidx` and `samtools fqidx` (v1.9+) respectively.
*   **Guide Selection:** Use representative sequences (90-95% similarity) rather than exhaustive databases to maintain performance.

### 2. Visualizing Clusters (BAM Painting)
To visualize how reads were clustered in a genome browser like IGV, use `bampaint` to add `HP` (grouping) and `YC` (color) tags.

```bash
pbaa bampaint <prefix>_read_info.txt <input.bam> <output_tagged.bam>
```

## Expert Tips and Best Practices

### Guide Sequence Optimization
*   **Locus Grouping:** Use the pipe symbol in FASTA headers to group divergent alleles into a single locus for clustering: `>AlleleName|LocusName`.
*   **Avoid Chromosomes:** Never use a full chromosome as a guide; it will cause placement failures. Guides should only contain the amplified region and immediate flanking sequences.
*   **Pseudogenes:** Include known closely related pseudogenes in your guide file to prevent "off-target" reads from being incorrectly forced into your primary target clusters.

### Parameter Tuning
*   **Filtering Chimeras:** The `uchime_score` in the output header indicates the likelihood of a sequence being chimeric. If you see high-quality but unexpected alleles, check the `failed_cluster_sequences.fasta` and adjust `--max-uchime-score` (default 1.0).
*   **Low Frequency Variants:** If looking for minor variants, lower `--min-cluster-frequency` (default 0.1) and `--min-cluster-read-count` (default 5).
*   **Performance:** Use `-j 0` for automatic thread detection to maximize CPU utilization during the k-means iterations.

### Interpreting Output
*   **Passed vs. Failed:** `pbaa` automatically segregates results. Always check the `filters:` field in the FASTA headers of the `failed` file to understand why a cluster was rejected (e.g., `fail-low-frequency`, `fail-high-diversity`).
*   **Read Info:** The `_read_info.txt` file is the source of truth for which specific HiFi read was assigned to which cluster.



## Subcommands

| Command | Description |
|---------|-------------|
| pbaa bampaint | Add color tags to BAM records, based on pbaa clusters. |
| pbaa cluster | Run clustering tool for HiFi reads using guide sequences. |

## Reference documentation
- [PacBio Amplicon Analysis Overview](./references/github_com_PacificBiosciences_pbAA_blob_main_README.md)
- [Guide Sequence Curation Protocol](./references/github_com_PacificBiosciences_pbAA_blob_main_guide_reference.md)