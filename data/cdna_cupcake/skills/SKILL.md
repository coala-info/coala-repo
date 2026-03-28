---
name: cdna_cupcake
description: cdna_cupcake is a suite of scripts designed to process and refine transcript isoforms from Iso-Seq workflows. Use when user asks to collapse redundant isoforms, filter 5' degraded products, perform rarefaction analysis, or detect fusion genes.
homepage: https://github.com/Magdoll/cDNA_Cupcake
---


# cdna_cupcake

## Overview

cDNA_Cupcake is a specialized suite of Python and R scripts designed to supplement official Iso-Seq workflows. It provides essential tools for the "ToFU" (Transcript Isoforms: Full-length and Unassembled) pipeline, focusing on refining clustered transcript sequences. You should use this skill to handle tasks that occur after the initial clustering step, such as merging redundant transcripts that map to the same genomic location, filtering 5' degraded products, and performing saturation (rarefaction) analysis to estimate sequencing depth sufficiency.

## Core Workflows and CLI Patterns

### 1. Collapsing Redundant Isoforms
The most common use case is collapsing HQ (High Quality) isoforms into a unique set based on genomic coordinates.

*   **Basic Collapse**:
    ```bash
    collapse_isoforms_by_sam.py --input <input.fq> -s <aligned.sam> -o <output_prefix> -c 0.99 -i 0.95
    ```
    *   `-c`: Minimum coverage (default 0.99).
    *   `-i`: Minimum identity (default 0.95).
    *   `--gen_mol_count`: Use this if you have UMI-based or FLNC counts to generate an abundance file automatically.

### 2. Abundance and Filtering
After collapsing, you must associate full-length (FL) read counts with the unique isoforms.

*   **Get Abundance**:
    ```bash
    get_abundance_post_collapse.py <collapsed_prefix>.cluster_report.csv <collapsed_prefix>.abundance.txt
    ```
*   **Filter 5' Degraded Isoforms**:
    ```bash
    filter_away_subset.py <collapsed_prefix>
    ```
*   **Filter by FL Count**:
    ```bash
    filter_by_count.py --min_count 2 <collapsed_prefix>
    ```

### 3. Rarefaction (Saturation) Analysis
To determine if you have sequenced deeply enough to capture the majority of the transcriptome:

1.  **Prepare the file**:
    ```bash
    make_file_for_subsampling_from_collapsed.py -i <collapsed_prefix> -o subsample_input.txt
    ```
2.  **Run subsampling**:
    ```bash
    subsample.py --input subsample_input.txt --step 10000 --iterations 5 > rarefaction_results.txt
    ```

### 4. Sequence Manipulation Utilities
Cupcake includes several "one-liner" scripts for fast FASTA/FASTQ processing:

*   **Summarize lengths**: `get_seq_stats.py <file.fasta>`
*   **Extract specific IDs**: `get_seqs_from_list.py <file.fasta> <id_list.txt>`
*   **Reverse complement**: `rev_comp.py "ATGC"`
*   **Format conversion**: `fa2fq.py <file.fa>` or `fq2fa.py <file.fq>`

### 5. Fusion Gene Detection
If looking for fusion events, use the `fusion_finder.py` script on your aligned SAM file.

```bash
fusion_finder.py -s <aligned.sam> -o <output_prefix> --input <input.fq>
```

## Expert Tips and Best Practices

*   **Input Assumptions**: All scripts assume standard A, T, C, G nucleotides. Presence of `N` or `U` may cause unexpected behavior.
*   **Path Management**: Since Cupcake is a collection of scripts, it is often easiest to add the specific subdirectories (e.g., `sequence/`, `cupcake/tofu/`) to your `$PATH` rather than relying on a single installation point.
*   **SAM Requirements**: When using `collapse_isoforms_by_sam.py`, ensure your SAM file is sorted by coordinate. If using `minimap2`, use the `-ax splice` preset for best results.
*   **Integration with SQANTI3**: Cupcake outputs (GFF/GTF and abundance files) are the standard input for SQANTI3. Use `make_file_for_subsampling_from_collapsed.py` with the `-m2` flag to incorporate SQANTI3 classifications into your rarefaction curves.



## Subcommands

| Command | Description |
|---------|-------------|
| cdna_cupcake_fa2fq.py | Convert FASTA format files to FASTQ format. (Note: The provided help text contained system error logs; arguments are derived from the tool's standard usage). |
| cdna_cupcake_get_abundance_post_collapse.py | Calculate transcript abundance after collapsing redundant isoforms by mapping back to the original cluster reports. |
| collapse_isoforms_by_sam.py | Collapse redundant isoforms based on SAM alignments. |

## Reference documentation
- [github_com_Magdoll_cDNA_Cupcake.md](./references/github_com_Magdoll_cDNA_Cupcake.md)
- [github_com_Magdoll_cDNA_Cupcake_wiki_Annotation-and-Rarefaction-Wiki.md](./references/github_com_Magdoll_cDNA_Cupcake_wiki_Annotation-and-Rarefaction-Wiki.md)
- [github_com_Magdoll_cDNA_Cupcake_wiki_Cupcake_-supporting-scripts-for-Iso-Seq-after-clustering-step.md](./references/github_com_Magdoll_cDNA_Cupcake_wiki_Cupcake_-supporting-scripts-for-Iso-Seq-after-clustering-step.md)
- [github_com_Magdoll_cDNA_Cupcake_wiki_Sequence-Manipulation-Wiki.md](./references/github_com_Magdoll_cDNA_Cupcake_wiki_Sequence-Manipulation-Wiki.md)