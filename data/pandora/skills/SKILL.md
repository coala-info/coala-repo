---
name: pandora
description: Pandora is a tool for bacterial genomics that uses reference graphs to identify genetic diversity and variation within orthologous regions. Use when user asks to index reference graphs, map reads to infer gene content, call variants, or perform multi-sample pangenome comparisons.
homepage: https://github.com/rmcolq/pandora
---


# pandora

## Overview
Pandora is a specialized tool for bacterial genomics that utilizes reference graphs to represent genetic diversity. Unlike linear reference mappers, it allows for the identification of mosaic sequences and variation within orthologous regions (loci) defined in a PanRG. Use this skill to index reference graphs, map single-sample reads to infer gene content, or perform multi-sample comparisons to generate pangenome matrices and multisample VCFs.

## Core Workflows

### 1. Indexing the PanRG
Before mapping, you must index the fasta-like PanRG file. This process generates (w,k)-minimizers.
```bash
pandora index -t <threads> <panrg.fa>
```
*   **Default Parameters**: Window size (`-w`) is 14, K-mer size (`-k`) is 15.
*   **Output**: Creates a `.idx` file and a directory of GFA files in the same location as the input.

### 2. Single Sample Mapping (map)
Use this to determine which genes are present in a sample and to call variants.
```bash
pandora map --genotype --outdir <output_dir> <indexed_panrg.fa> <reads.fastq>
```
*   **Long Reads (Nanopore)**: Default settings are optimized for high error rates (~11%).
*   **Short Reads (Illumina)**: Always use the `-I` or `--illumina` flag to adjust error rate and k-mer coverage models.
*   **Genotyping**: Include `--genotype` to perform variant calling. Use `--snps` if you only require SNP calls.

### 3. Multi-sample Comparison (compare)
Use this to generate a pangenome matrix (presence/absence) and a multisample VCF.
```bash
pandora compare --genotype --outdir <output_dir> <indexed_panrg.fa> <sample_index.tab>
```
*   **Sample Index Format**: A tab-delimited file where each line is: `SampleID /path/to/reads.fq`.
*   **Coverage Control**: Use `--max-covg 30` (or similar) to cap coverage, which can significantly speed up processing for deep datasets without losing sensitivity.

## Expert Tips and Best Practices
*   **Reference Selection**: When calling variants, Pandora uses the most informative recombinant path. If you need calls against a specific known sequence, provide it via `--vcf-refs`.
*   **Memory and Performance**:
    *   Increase threads (`-t`) for both indexing and mapping.
    *   For very large PanRGs, ensure the window size (`-w`) and k-mer size (`-k`) used during `map` or `compare` match those used during `index`.
*   **Novel Variation**: Use the `pandora discover` subcommand if the primary goal is finding variation not currently represented in the PanRG.
*   **Output Inspection**:
    *   `pandora_multisample.vcf`: The primary file for population-level variation.
    *   `pangenome_matrix.csv`: Useful for rapid gene content analysis across strains.

## Reference documentation
- [Pandora Wiki Usage](./references/github_com_iqbal-lab-org_pandora_wiki_Usage.md)
- [Pandora GitHub Overview](./references/github_com_iqbal-lab-org_pandora.md)