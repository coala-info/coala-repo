---
name: mitoz
description: MitoZ is a comprehensive bioinformatic toolkit for the assembly, annotation, and visualization of animal mitochondrial genomes from sequencing reads. Use when user asks to perform end-to-end mitochondrial genome analysis, filter raw reads, assemble mitogenomes, identify mitochondrial scaffolds, or annotate and visualize genes.
homepage: https://github.com/linzhi2013/MitoZ
---


# mitoz

## Overview
MitoZ is a comprehensive bioinformatic toolkit designed specifically for animal mitochondrial genomics. It provides a "one-click" pipeline to transform raw sequencing reads into a circularized, annotated, and visualized mitochondrial genome. Beyond the end-to-end pipeline, it offers modular subcommands for read filtering, assembly, scaffold identification, and gene annotation (PCGs, tRNAs, and rRNAs).

## CLI Usage and Best Practices

### Core Subcommands
- `mitoz all`: The primary entry point for end-to-end analysis (Filter -> Assemble -> Find -> Annotate -> Visualize).
- `mitoz filter`: Pre-processes raw fastq reads.
- `mitoz assemble`: Performs mitochondrial genome assembly.
- `mitoz findmitoscaf`: Identifies mitochondrial sequences within a larger fasta file (e.g., from a nuclear genome assembly).
- `mitoz annotate`: Annotates protein-coding genes (PCGs), tRNAs, and rRNAs.
- `mitoz visualize`: Generates circular or linear maps from GenBank (.gb) files.

### Optimization and Performance Tips
- **Data Volume**: Using excessive raw data (e.g., >10 Gbp) can paradoxically lead to failed circularization. Start with a smaller subset (approx. 0.3 Gbp to 1.0 Gbp).
- **Assembler Choice**: `megahit` is often more efficient than `spades` for mitochondrial data.
- **Resource Management**: For a 0.3 Gbp dataset, 8 CPUs and 2GB of RAM are typically sufficient, with a runtime of approximately 10 minutes.
- **Shell Environment**: Ensure your default shell is set to `bash`. Other shells (like `zsh` or `dash`) may cause failures in tRNA annotation modules.

### Common Command Patterns

**End-to-End Pipeline (One-click)**
```bash
mitoz all --fq1 read_1.fastq.gz --fq2 read_2.fastq.gz --outprefix sample_name --thread 8 --clade Chordata --assembler megahit
```

**Searching for Mitochondrial Scaffolds in a Fasta File**
```bash
mitoz findmitoscaf --fasta assembly.fa --clade Arthropoda --outprefix search_results
```

**Annotating an Existing Assembly**
```bash
mitoz annotate --fasta mitogenome.fa --clade Mollusca --outprefix annotation_results
```

### Troubleshooting and Known Issues
- **Missing tRNAs**: If tRNA annotation is missing, verify that `cmsearch` is correctly compiled for your architecture and that you are running in a `bash` environment.
- **Circularization**: If the output is not circular, try reducing the input data volume or adjusting k-mer sizes (e.g., `--kmers_megahit 43 71 99`).
- **Low Abundance**: If the tool reports low abundance (<10X), the mitochondrial content in your library may be insufficient for a de novo assembly.

## Reference documentation
- [MitoZ GitHub Repository](./references/github_com_linzhi2013_MitoZ.md)
- [MitoZ Wiki Home](./references/github_com_linzhi2013_MitoZ_wiki.md)
- [Bioconda MitoZ Overview](./references/anaconda_org_channels_bioconda_packages_mitoz_overview.md)