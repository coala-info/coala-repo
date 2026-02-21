---
name: metacoag
description: MetaCoAG (Metagenomic Contig binning via Composition, Coverage and Assembly Graphs) is a binning tool designed to reconstruct microbial genomes from metagenomic samples.
homepage: https://github.com/metagentools/MetaCoAG
---

# metacoag

## Overview

MetaCoAG (Metagenomic Contig binning via Composition, Coverage and Assembly Graphs) is a binning tool designed to reconstruct microbial genomes from metagenomic samples. While traditional binners focus on k-mer frequencies and abundance, MetaCoAG incorporates the connectivity information found in assembly graphs. It utilizes single-copy marker genes to estimate the initial number of bins and employs graph matching and label propagation techniques to iteratively refine the binning results.

## Installation

The recommended way to install MetaCoAG is via Bioconda to ensure all dependencies (like FragGeneScan and HMMER) are correctly configured.

```bash
conda create -n metacoag -c bioconda metacoag
conda activate metacoag
```

## Common CLI Patterns

MetaCoAG requires different input files depending on the assembler used to generate the contigs.

### Using metaSPAdes Output
When using metaSPAdes, you must provide the assembly graph, the contigs file, and the paths file.

```bash
metacoag --assembler spades \
  --graph assembly_graph_with_scaffolds.gfa \
  --contigs contigs.fasta \
  --paths contigs.paths \
  --abundance abundance.tsv \
  --output output_dir
```

### Using MEGAHIT Output
MEGAHIT requires the assembly graph and the contigs file.

```bash
metacoag --assembler megahit \
  --graph intermediate_contigs.gfa \
  --contigs final.contigs.fa \
  --abundance abundance.tsv \
  --output output_dir
```

### Using Flye Output
For long-read assemblies from Flye, use the assembly graph and the assembly info file.

```bash
metacoag --assembler flye \
  --graph assembly_graph.gfa \
  --contigs assembly.fasta \
  --paths assembly_info.txt \
  --abundance abundance.tsv \
  --output output_dir
```

## Usage Tips and Best Practices

- **Abundance Data**: The `--abundance` file should be a tab-separated values (TSV) file containing the mean coverage of contigs across samples.
- **Marker Genes**: MetaCoAG relies on FragGeneScan and HMMER to identify single-copy marker genes. If you are not using the Conda installation, ensure these tools are in your system's `PATH`.
- **Graph Files**: Ensure you are using the correct GFA file. For metaSPAdes, this is typically `assembly_graph_with_scaffolds.gfa`. For MEGAHIT, you may need to export the graph to GFA format if it isn't provided by default.
- **Resource Management**: Binning large metagenomes can be memory-intensive due to the graph processing. Ensure your environment has sufficient RAM for the size of your assembly graph.

## Reference documentation
- [MetaCoAG GitHub Repository](./references/github_com_metagentools_MetaCoAG.md)
- [MetaCoAG Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_metacoag_overview.md)