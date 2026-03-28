---
name: vg
description: The vg toolkit performs genome informatics using pangenomic variation graphs to represent populations of genomes as networks. Use when user asks to build graphs from FASTA or VCF files, map reads using Giraffe, call variants, or project graph alignments back to linear coordinates.
homepage: https://github.com/vgteam/vg
---

# vg

## Overview

The `vg` (Variation Graph) toolkit is a suite of tools designed for genome informatics using pangenomic representations. Unlike traditional linear references, variation graphs represent populations of genomes as a network of nodes (sequences), edges (connections), and paths (individual genomes or alignments). This skill assists in navigating the complex CLI environment of `vg` to build graphs from FASTA/VCF/GFA files, map reads using high-performance algorithms like Giraffe, and project graph-based data back into linear coordinates for standard downstream analysis.

## Core Workflows and CLI Patterns

### 1. Automatic Indexing (Best Practice)
The `vg autoindex` subcommand is the recommended entry point for creating the necessary data structures for mapping. It handles the complex ordering of index generation based on the intended mapping tool.

*   **For Short-Read Mapping (Giraffe):**
    ```bash
    vg autoindex --workflow sr-giraffe --prefix index_prefix --ref-fasta ref.fa --vcf variants.vcf.gz
    ```
*   **For Long-Read Mapping (Giraffe):**
    ```bash
    vg autoindex --workflow lr-giraffe --prefix index_prefix --ref-fasta ref.fa --vcf variants.vcf.gz
    ```
*   **For Splice-Aware RNA-seq (mpmap):**
    ```bash
    vg autoindex --workflow mpmap --prefix index_prefix --ref-fasta ref.fa --vcf variants.vcf.gz --tx-gff annotation.gtf
    ```

### 2. Read Mapping with Giraffe
`vg giraffe` is the primary tool for fast, haplotype-aware alignment. It requires a `.gbz` graph, a `.min` minimizer index, and a `.dist` distance index.

*   **Basic Alignment (Outputting GAF):**
    ```bash
    vg giraffe -Z graph.gbz -m graph.min -d graph.dist -f reads.fastq > aligned.gaf
    ```
*   **Alignment to BAM (Surjection):**
    To project graph alignments back to a linear reference (e.g., for use with standard variant callers):
    ```bash
    vg giraffe -Z graph.gbz -m graph.min -d graph.dist -f reads.fastq --output-format BAM > aligned.bam
    ```

### 3. Variant Calling and Deconstruction
`vg` can call variants by comparing alignments against the graph or deconstruct a graph into a VCF relative to a reference path.

*   **Calling Variants from GAM:**
    ```bash
    vg pack -x graph.xg -g aligned.gam -o graph.pack
    vg call graph.xg -k graph.pack > variants.vcf
    ```
*   **Deconstructing a Pangenome to VCF:**
    ```bash
    vg deconstruct -p ref_path_name graph.gbz > pangenome_variants.vcf
    ```

### 4. Graph Manipulation and Visualization
*   **Viewing Graph Statistics:**
    ```bash
    vg stats -z graph.gbz
    ```
*   **Visualizing Small Subgraphs:**
    Convert a portion of the graph to DOT format for rendering with Graphviz:
    ```bash
    vg find -x graph.xg -r ref:1000-2000 -c 1 | vg view -d - > subgraph.dot
    dot -Tpng subgraph.dot -o subgraph.png
    ```

## Expert Tips and Best Practices

*   **Memory Management:** Indexing eukaryotic pangenomes is resource-intensive. Use `--target-mem` in `vg autoindex` to suggest a memory limit and always point `--tmp-dir` to a high-capacity disk.
*   **File Formats:** Prefer `.gbz` for modern workflows. It is a compressed format that combines the graph structure and the GBWT haplotype index, significantly reducing memory overhead during mapping.
*   **Path Metadata:** When building graphs from GFA, ensure your path names follow the `[sample]#[haplotype]#[contig]` convention to allow `vg` to correctly parse pangenome metadata.
*   **Surjection:** If you need to use traditional tools (like GATK or Samtools), use `vg surject` or the `--output-format BAM` flag in Giraffe to move from graph space to linear coordinate space.



## Subcommands

| Command | Description |
|---------|-------------|
| vg augment | Embed GAM alignments into a graph to facilitate variant calling |
| vg autoindex | Build indexes for vg |
| vg call | Call variants or genotype known variants |
| vg construct | Construct a variation graph from reference and variant calls or a multiple sequence alignment. |
| vg giraffe | Fast haplotype-aware read mapper. |
| vg index | Creates an index on the specified graph or graphs. All graphs indexed must already be in a joint ID space. |
| vg map | Align reads to a graph. |
| vg mpmap | Multipath align reads to a graph. |
| vg pack | Compresses alignments into coverage packs. |
| vg rna | Constructs a splicing graph from transcripts and a graph. |

## Reference documentation

- [GitHub - vgteam/vg: tools for working with genome variation graphs](./references/github_com_vgteam_vg.md)
- [Automatic indexing for read mapping and downstream inference](./references/github_com_vgteam_vg_wiki_Automatic-indexing-for-read-mapping-and-downstream-inference.md)
- [Mapping short reads with Giraffe](./references/github_com_vgteam_vg_wiki_Mapping-short-reads-with-Giraffe.md)
- [VCF export with vg deconstruct](./references/github_com_vgteam_vg_wiki_VCF-export-with-vg-deconstruct.md)
- [File Formats](./references/github_com_vgteam_vg_wiki_File-Formats.md)