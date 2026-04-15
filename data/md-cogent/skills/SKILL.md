---
name: md-cogent
description: Cogent reconstructs a representative coding genome from transcriptome data, specifically optimized for PacBio Iso-Seq sequences. Use when user asks to organize transcript sequences into gene families, reconstruct contigs for non-model organisms, or create a reference-free genome for isoform collapsing.
homepage: https://github.com/Magdoll/Cogent
metadata:
  docker_image: "quay.io/biocontainers/md-cogent:8.0.0--pyh3252c3a_0"
---

# md-cogent

## Overview

Cogent (COding GENome reconstruction Tool) is a specialized bioinformatic pipeline designed to transform transcriptome data into a representative coding genome. It is primarily optimized for PacBio Iso-Seq data. By using transcript sequences as the building blocks, Cogent allows researchers to organize sequences into gene families and reconstruct contigs that represent the underlying genomic loci. This is essential for downstream tasks like isoform collapsing and functional annotation in non-model organisms.

## Installation and Environment

The tool is available via Bioconda. Ensure dependencies like `minimap2` and `parasail` are available in the environment, as Cogent relies on them for alignment and sequence processing.

```bash
conda install -c bioconda md-cogent
```

## Core Workflow and CLI Patterns

The Cogent workflow typically involves finding gene families, building graphs, and reconstructing contigs.

### 1. Pre-clustering
For large datasets, use pre-clustering to speed up the family-finding process.
- **Script**: `run_preCluster.py`
- **Key Argument**: `--cpus` to specify parallel processing.

### 2. Family Finding and Graph Processing
Cogent identifies sequences belonging to the same genomic locus.
- **Script**: `process_kmer_to_graph.py`
- **Note**: If a "CycleDetectedException" occurs, the tool may need an increased k-mer size.

### 3. Contig Reconstruction
This is the primary step for generating the coding genome assembly.
- **Script**: `reconstruct_contigs.py`
- **Key Options**:
    - `-k <int>`: Set the k-mer size. Versions 3.7+ support k-mer sizes greater than 200.
    - `-R` or `--randomly_resolve_ambiguous_dangling`: Use this to resolve ambiguous dangling ends in the assembly graph (available in v8.0.0+).
    - `--output_prefix`: Append a specific string to the resulting Cogent IDs.
    - `--dun_trim_sequence`: Prevents the tool from trimming sequences during reconstruction.

### 4. Post-Processing and Analysis
After reconstruction, use helper scripts to format and analyze the output.
- **GFF Conversion**: Use `sam_to_gff3.py` to convert alignments to GFF3 format for genome browsers.
- **Tallying**: Use `tally_Cogent_contigs_per_family.py` to summarize the number of contigs generated per gene family.
- **Sequence Extraction**: Use `get_seqs_from_list.py` to retrieve specific sequences from the unassigned or tucked categories.

## Expert Tips and Best Practices

- **Reference-Free Collapsing**: Use Cogent to create a "fake" reference genome when no real reference exists. You can then map your Iso-Seq reads back to the Cogent contigs using Cupcake to collapse isoforms.
- **Handling Cycles**: If the graph contains non-obvious cycles that cause crashes, ensure you are using the latest version (v8.0.0+), which includes improved cycle detection and k-mer size auto-incrementing logic.
- **Alignment Stringency**: Cogent uses high stringency for final selection (>= 98% coverage and >= 98% identity). If too many sequences are ending up in the "tucked" category, verify the quality of the input high-quality (HQ) isoforms.
- **Minimap2 Integration**: Since version 3.1, Cogent uses `minimap2` instead of GMAP. Ensure `minimap2` is in your PATH for optimal performance.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_Magdoll_Cogent.md)
- [Cogent Wiki Home](./references/github_com_Magdoll_Cogent_wiki.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_md-cogent_overview.md)