---
name: clipcontext
description: clipcontext maps CLIP-seq genomic coordinates to transcriptomic contexts and analyzes binding site distribution relative to gene architecture. Use when user asks to map coordinates between genome and transcriptome, identify prominent isoforms, filter intronic sites, or extract exon border sequences.
homepage: https://github.com/BackofenLab/CLIPcontext
---


# clipcontext

## Overview
The `clipcontext` tool suite facilitates the comparative analysis of CLIP-seq data by bridging the gap between genomic locations and their corresponding transcriptomic contexts. While standard peak callers identify binding sites on the genome, `clipcontext` allows researchers to view these sites as they appear on mature or pre-mRNA, accounting for splicing and transcript-specific sequences. Use this skill to perform coordinate conversions, identify "prominent" isoforms for analysis, and analyze binding site distribution relative to gene architecture (exons/introns).

## Core Operating Modes

### 1. Coordinate Mapping
*   **Genome to Transcriptome (`g2t`)**: Maps genomic BED regions to transcripts. Use this to see the sequence context as it exists in the RNA molecule.
    *   `clipcontext g2t --in sites.bed --out output_dir --tr transcripts.txt --gtf annotations.gtf --gen genome.2bit`
*   **Transcriptome to Genome (`t2g`)**: Maps transcript-based sites back to genomic coordinates. Useful for visualizing transcript-level discoveries on a genome browser.

### 2. Transcriptome Preparation
*   **Prominent Isoform Selection (`lst`)**: Filters a GTF to find the most representative transcript per gene based on GENCODE basic tags, Transcript Support Level (TSL), and length.
    *   `clipcontext lst --gtf annotations.gtf --out prominent_transcripts.txt`
    *   *Tip*: Use the output of this mode as the `--tr` input for `g2t` or `t2g`.

### 3. Structural Analysis
*   **Intron Filtering (`int`)**: Identifies binding sites that overlap with intronic regions.
*   **Exon Border Extraction (`exb`)**: Isolates binding regions located near exon-intron junctions.
*   **Region Generation (`eir`)**: Creates BED files defining all exon and intron boundaries for a specific set of transcript IDs.

### 4. Motif Analysis (`mtf`)
Searches for specific sequences or regular expressions within the extracted contexts.
*   Compares motif frequency between genomic and transcriptomic sets.
*   Can map transcriptome-wide motif hits back to the genome.

## Expert Tips and Best Practices
*   **Input Formatting**: Ensure your input BED file follows the strict 6-column format (chrom, start, end, name, score, strand).
*   **Reference Requirements**: The tool requires a `.2bit` genome file rather than a standard FASTA for sequence extraction. Use `faToTwoBit` if you only have a FASTA file.
*   **GTF Compatibility**: This tool is optimized for Ensembl GTF files. Using UCSC or RefSeq GTFs may cause parsing errors due to differences in attribute naming (e.g., `transcript_id`).
*   **Memory Management**: When processing large CLIP-seq datasets, use the `lst` mode first to restrict the search space to one transcript per gene, significantly reducing computation time and output redundancy.
*   **Dependency Check**: Ensure `bedtools`, `twoBitToFa`, and `twoBitInfo` are in your system PATH, as `clipcontext` wraps these command-line utilities.

## Reference documentation
- [CLIPcontext GitHub Repository](./references/github_com_BackofenLab_CLIPcontext.md)
- [CLIPcontext Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_clipcontext_overview.md)