---
name: antismash
description: antiSMASH is a bioinformatic pipeline for the automated identification and annotation of biosynthetic gene clusters in genomic sequences. Use when user asks to identify secondary metabolite clusters, run comparative cluster analysis, or predict biosynthetic pathways in bacterial, fungal, or plant genomes.
homepage: http://antismash.secondarymetabolites.org/
---


# antismash

## Overview
antiSMASH is the standard bioinformatic pipeline for the automated identification of biosynthetic gene clusters. This skill assists in configuring runs, selecting appropriate analysis modules (like ClusterFinder or SubClusterBlast), and interpreting the resulting genomic annotations. It is particularly useful for natural product discovery, comparative genomics of specialized metabolism, and functional annotation of uncharacterized genomic regions.

## Core CLI Usage
The basic command structure for a bacterial genome analysis:
```bash
antismash --cb-general --cb-knownclusters --cb-subclusters --asf --pfam2go --genefinderversion GlimmerHMM input_genome.gbk
```

### Input Formats
- **GenBank (.gbk) / EMBL**: Preferred. Ensure files contain gene features; otherwise, antiSMASH will attempt to predict them.
- **FASTA**: Use only if no annotation is available. antiSMASH will run Prodigal or GlimmerHMM for gene prediction.

### Essential Analysis Flags
- `--cb-general`: Compare identified clusters against the antiSMASH internal database.
- `--cb-knownclusters`: Compare clusters against the MIBiG database (Known Cluster Blast).
- `--cb-subclusters`: Identify sub-clusters within larger BGCs.
- `--asf`: Active Site Finder; identifies highly conserved active sites in biosynthetic enzymes.
- `--pfam2go`: Map Pfam domains to Gene Ontology terms.

## Expert Tips and Best Practices
- **Taxonomy-Specific Runs**: Use `--taxon fungal` or `--taxon plants` when working with non-bacterial genomes to trigger specialized HMM profiles and logic.
- **Resource Management**: For large metagenomic assemblies or multiple genomes, use `--cpus [N]` to parallelize the workload.
- **Output Interpretation**: The primary output is an interactive HTML report (`index.html`). For downstream bioinformatics, use the `.gbk` files generated in the output folder, which contain the new "cluster" and "proto-cluster" features.
- **Minimal Runs**: If only basic cluster identification is needed without time-consuming comparative analysis, omit the `--cb-*` flags to significantly reduce runtime.
- **Cluster Border Detection**: antiSMASH uses a "greedy" approach for cluster borders. Always manually inspect the flanking genes in the HTML output to verify if the cluster might extend further than predicted.

## Reference documentation
- [antiSMASH Documentation Overview](./references/antismash_secondarymetabolites_org_index.md)
- [Bioconda antiSMASH Package Details](./references/anaconda_org_channels_bioconda_packages_antismash_overview.md)