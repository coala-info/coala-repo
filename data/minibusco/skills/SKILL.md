---
name: minibusco
description: Minibusco evaluates the completeness of genomic assemblies and protein sets using fast protein-to-genome alignment. Use when user asks to assess assembly quality, evaluate protein set completeness, download taxonomic lineages, or identify missing and duplicated orthologs.
homepage: https://github.com/huangnengCSU/minibusco
---


# minibusco

## Overview
Minibusco (also known as `compleasm`) is a high-performance tool designed to evaluate the completeness of genomic assemblies. It leverages `miniprot` for protein-to-genome alignment, making it significantly faster than traditional HMM-based methods while maintaining high sensitivity. It is ideal for rapid quality control of de novo assemblies, comparing different assembly versions, or identifying missing, duplicated, or fragmented orthologs across various taxonomic lineages.

## Core Workflows

### Genome Completeness Evaluation
The primary module is `run`, which automates the pipeline from lineage selection to final scoring.

```bash
# Basic evaluation with a known lineage
compleasm run -a assembly.fasta -o output_dir -l primates -t 16

# Automatic lineage detection (requires sepp)
compleasm run -a assembly.fasta -o output_dir --autolineage -t 16
```

### Managing Lineages
Before running an analysis, you must ensure the required OrthoDB datasets are available.

```bash
# List available lineages (remote or local)
compleasm list

# Download a specific lineage to a custom path
compleasm download primates -L /path/to/library
```

### Protein Set Assessment
To evaluate the completeness of a predicted proteome rather than a raw genome assembly:

```bash
compleasm protein -p proteins.faa -l eukaryota -o protein_out
```

## Expert Tips and Parameters

- **Resource Management**: Use the `-t` flag to match your available CPU cores. Minibusco is highly parallelizable during the alignment phase.
- **Custom Libraries**: If working in an offline environment or a cluster, use `-L` to point to a shared directory containing pre-downloaded BUSCO lineages to avoid redundant downloads.
- **Handling Retrocopies**: Use the `--retrocopy` flag to distinguish between true gene duplications and processed pseudogenes (retrocopies), which provides a more nuanced view of genome evolution.
- **Sensitivity Tuning**:
    - `--min_identity`: Default is 0.4. Increase this for very high-quality assemblies to filter out distant homologs.
    - `--min_length_percent`: Default is 0.6. Adjust this if you expect highly fragmented genes in your assembly.
- **Contig Filtering**: If you only want to evaluate specific chromosomes or scaffolds (e.g., excluding unplaced contigs), use `--specified_contigs chr1 chr2 chr3`.

## Output Interpretation
The main output is a `summary.txt` file in the output directory. It follows the standard BUSCO notation:
- **S**: Complete and single-copy
- **D**: Complete and duplicated
- **F**: Fragmented
- **M**: Missing

## Reference documentation
- [Compleasm GitHub Repository](./references/github_com_huangnengCSU_compleasm.md)
- [Minibusco Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_minibusco_overview.md)