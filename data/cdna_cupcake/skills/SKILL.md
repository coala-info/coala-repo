---
name: cdna_cupcake
description: cdna_cupcake is a suite of scripts used to process and refine long-read transcriptomic data by collapsing redundant isoforms and generating abundance statistics. Use when user asks to collapse redundant transcripts, filter 5' degraded isoforms, calculate transcript abundance, perform rarefaction analysis, or manipulate FASTA/FASTQ sequences.
homepage: https://github.com/Magdoll/cDNA_Cupcake
---


# cdna_cupcake

## Overview
cDNA_Cupcake is a suite of Python and R scripts designed to refine long-read transcriptomic data. While official tools like `isoseq3` handle initial clustering, Cupcake is essential for post-clustering workflows—specifically for collapsing alignments into a clean, non-redundant set of isoforms and preparing those results for downstream functional annotation (e.g., SQANTI3). It is also highly effective for quick sequence utility tasks like format conversion, length statistics, and targeted sequence extraction.

## Core Workflows

### 1. Post-Clustering Isoform Collapse
After aligning clustered HQ isoforms to a reference genome (typically using `minimap2`), use Cupcake to collapse redundant transcripts.

*   **Collapse isoforms**:
    ```bash
    collapse_isoforms_by_sam.py --input <hq_isoforms.fasta> -s <aligned.sorted.sam> -o <output_prefix>
    ```
    *Note: Use `--gen_mol_count` if working with UMI-based data or FLNC counts.*
*   **Filter 5' degraded transcripts**:
    ```bash
    filter_away_subset.py <output_prefix>.collapsed
    ```
*   **Filter by FL count**:
    ```bash
    filter_by_count.py <output_prefix>.collapsed --min_count 2
    ```

### 2. Abundance and Statistics
Generate the count information required for differential expression or saturation analysis.

*   **Get abundance**:
    ```bash
    get_abundance_post_collapse.py <output_prefix>.collapsed.group.txt <cluster_report.csv>
    ```
*   **Generate summary stats**:
    ```bash
    simple_stats_post_collapse.py <output_prefix>.collapsed
    ```

### 3. Rarefaction (Subsampling) Analysis
To determine if sequencing depth has reached saturation for transcript discovery.

1.  **Prepare subsampling file**:
    ```bash
    make_file_for_subsampling_from_collapsed.py <collapsed.abundance.txt>
    ```
2.  **Run subsampling**:
    ```bash
    subsample.py <subsample_input.txt>
    ```

### 4. Sequence Manipulation Utilities
Quick CLI patterns for handling FASTA/FASTQ files.

*   **Summarize lengths**: `get_seq_stats.py <file.fasta>`
*   **Extract specific IDs**: `get_seqs_from_list.py <file.fasta> <id_list.txt> > extracted.fasta`
*   **Format conversion**: `fa2fq.py <file.fasta>` or `fq2fa.py <file.fastq>`
*   **Reverse complement**: `rev_comp.py "ATGC"`

## Best Practices and Constraints
*   **Nucleotide Assumptions**: Scripts assume standard A, T, C, G bases. Non-canonical bases (N, U, R) may cause unexpected behavior.
*   **Path Management**: Scripts are organized into subdirectories (e.g., `sequence/`, `cupcake/tofu/`). Ensure the specific subdirectory containing the script is in your `$PATH`.
*   **Tool Transition**: For core clustering and "collapse" functions in modern pipelines, check if an `isoseq3` equivalent exists (e.g., `isoseq3 collapse`), as these are now preferred over older Cupcake scripts.
*   **Input Formats**: `collapse_isoforms_by_sam.py` accepts both SAM and BAM inputs. If using BAM, ensure `samtools` is installed.

## Reference documentation
- [cDNA_Cupcake GitHub Repository](./references/github_com_Magdoll_cDNA_Cupcake.md)
- [cDNA_Cupcake Wiki](./references/github_com_Magdoll_cDNA_Cupcake_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cdna_cupcake_overview.md)