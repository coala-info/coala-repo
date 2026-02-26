---
name: metaeuk
description: MetaEuk is a modular toolkit designed to identify protein-coding genes in eukaryotic metagenomic data by reconstructing exon-intron structures through protein homology. Use when user asks to predict eukaryotic genes, call exons from environmental contigs, reduce gene redundancy, or perform taxonomic assignment on metagenomic sequences.
homepage: https://github.com/soedinglab/metaeuk
---


# metaeuk

## Overview

MetaEuk is a modular toolkit designed specifically for identifying protein-coding genes in eukaryotic metagenomic data. Unlike prokaryotic gene finders, MetaEuk is optimized to handle the complex exon-intron structures of eukaryotes by using protein homology. It combines the speed of MMseqs2 with a dynamic programming procedure to reconstruct optimal exon sets from environmental contigs. Use this skill to navigate the various modules for gene prediction, redundancy reduction, and taxonomic classification.

## Core Workflows

### The easy-predict Workflow
For most users, `easy-predict` is the primary entry point. it automates exon calling, redundancy reduction, and file conversion in a single command.

```bash
metaeuk easy-predict contigs.fasta proteins.fasta output_prefix tmp_folder
```

**Outputs generated:**
- `output_prefix.fas`: Predicted protein sequences.
- `output_prefix.codon.fas`: Predicted nucleotide (codon) sequences.
- `output_prefix.gff`: Gene annotations in GFF3 format.
- `output_prefix.headersMap.tsv`: Mapping between internal IDs and original headers.

### Manual Multi-Step Processing
If you need granular control over the pipeline, use the individual modules:

1.  **Exon Calling**: `metaeuk predictexons contigsDB targetDB callsDB tmp`
2.  **Redundancy Reduction**: `metaeuk reduceredundancy callsDB reducedDB tmp`
3.  **Fasta/GFF Generation**: `metaeuk unitesetstofasta contigsDB targetDB reducedDB output_prefix`

## Key Parameters and Optimization

| Parameter | Description | Expert Tip |
| :--- | :--- | :--- |
| `--min-length` | Minimum number of codons in a fragment. | Default is often 40; decrease for higher sensitivity to small fragments, increase to reduce noise. |
| `-e` | Maximum E-value for individual fragment matches. | Set higher (e.g., 100) during `predictexons` to allow the dynamic programming to find weak exons. |
| `--metaeuk-eval` | Maximum combined E-value for the exon set. | This is the primary filter for the final gene call confidence. |
| `--metaeuk-tcov` | Minimum length ratio of combined set to target. | Use > 0.5 to ensure you are capturing at least half of the reference protein length. |
| `--exhaustive-search` | Enables sensitive profile searching. | **Required** if your reference database consists of protein profiles (HMMs) rather than sequences. |
| `--max-exon-sets` | Max sets per contig/strand for a target. | Increase from 1 if you suspect gene duplications on the same contig. |

## Taxonomic Assignment
MetaEuk can assign taxonomy to both individual predictions and entire contigs using the `taxtocontig` module. It uses a majority voting system based on the hits found during the prediction phase.

```bash
metaeuk taxtocontig contigsDB referenceDB callsDB taxonomy_output tmp
```

## Expert Tips

*   **MMseqs2 Integration**: MetaEuk includes MMseqs2 internally. You can run any MMseqs2 command by prefixing it with `metaeuk` (e.g., `metaeuk createdb` or `metaeuk convertalis`).
*   **Database Preparation**: For large-scale runs, convert your Fasta files to MMseqs2 databases first using `createdb`. This allows for faster indexing and re-usability across different MetaEuk modules.
*   **Hardware**: MetaEuk is highly parallelized. Always specify threads using the `-threads` parameter to match your system's capabilities.
*   **Memory Management**: Ensure the `tmp` folder is located on a fast disk (SSD) with sufficient space, as MetaEuk generates significant intermediate data during the search phase.

## Reference documentation
- [MetaEuk GitHub Repository](./references/github_com_soedinglab_metaeuk.md)
- [Bioconda MetaEuk Overview](./references/anaconda_org_channels_bioconda_packages_metaeuk_overview.md)