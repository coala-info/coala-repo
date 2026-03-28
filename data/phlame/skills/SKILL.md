---
name: phlame
description: PHLAME is a bioinformatics pipeline designed to characterize strain-level diversity and estimate phylogenetic divergence within a species from metagenomic samples. Use when user asks to build species-specific classifiers, generate candidate mutation tables, or profile metagenomic reads to identify strain frequencies and novel diversity.
homepage: https://github.com/quevan/phlame
---


# phlame

## Overview

PHLAME (Phylogenetic Likelihood Analysis of Metagenomic Evolution) is a bioinformatics pipeline designed to characterize strain-level diversity within a species from metagenomic samples. Unlike traditional methods that might misidentify novel strains as mixtures of known references, PHLAME uses a "Divergence" (DVb) metric to estimate where a sample's strains branch off from the known phylogeny. It is particularly effective for analyzing sample types where recovering high-quality genomes directly from metagenomes is difficult.

## Core Workflow

### 1. Database Preparation
Before profiling metagenomes, you must build a species-specific classifier.

*   **Align Reference Genomes**: Align your collection of WGS data (fastq or fasta) to a single species-specific reference genome using `bowtie2`.
*   **Generate Counts**: Convert aligned `.bam` files into compressed `.counts` objects.
    ```bash
    phlame counts -i sample.bam -r reference.fasta -o sample.counts
    ```
*   **Build Candidate Mutation Table (CMT)**: Aggregate multiple counts files.
    ```bash
    phlame cmt -i counts_list.txt -s names_list.txt -r reference.fasta -o species_CMT.pickle.gz
    ```
*   **Generate Phylogeny**: Create a tree (requires RaXML).
    ```bash
    phlame tree -i species_CMT.pickle.gz -p species.phylip -r mapping.txt -o species.tre
    ```
*   **Create Classifier**: Detect clades and build the final database.
    ```bash
    phlame makedb -i species_CMT.pickle.gz -t species.tre -o species.classifier --min_branchlen 500
    ```

### 2. Metagenomic Classification
Once a classifier is built, use it to profile metagenomic samples.

*   **Align Metagenome**: Align metagenomic reads to the same species-specific reference used in database construction.
*   **Run Classification**:
    ```bash
    phlame classify -i metagenome.bam -c species.classifier -r reference.fasta -m bayesian -o frequencies.csv -p fitinfo.data
    ```

## Expert Tips and Best Practices

*   **Input Selection**: Prefer `.fastq` over assembled `.fasta` for reference genomes to avoid variant call errors introduced by draft assemblies. If you must use `.fasta`, simulate reads first using `wgsim`.
*   **Branch Length Threshold**: The `--min_branchlen` parameter in `makedb` is critical. Visualize your tree first (e.g., in FigTree) to identify natural clade separations before setting this value.
*   **Algorithm Choice**: 
    *   Use `-m bayesian` for high-quality results. It provides a "Probability Score" and quantifies uncertainty, which is vital at low sequencing depths.
    *   Use `-m mle` (Maximum Likelihood) only if computational speed is the primary concern, as it provides less information about novel diversity.
*   **Interpreting Relative Abundance**: If the sum of relative abundances is significantly less than 1.0, it indicates the presence of novel intraspecies diversity not represented by any clade in your reference database.
*   **Divergence (DVb)**: A DVb value represents the ratio of shared to unshared branch lengths (0 to 1). A value of 1.0 suggests the strain in the sample is nearly identical to the reference clade MRCA.



## Subcommands

| Command | Description |
|---------|-------------|
| cmt | This tool is part of the phlame suite and is used for processing count data. |
| phlame makedb | Build a phlame classifier database. |
| phlame tree | Builds a phylogenetic tree from mutation data. |
| phlame_classify | Classify lineages from bam files. |
| phlame_counts | Calculate phlame counts from BAM file. |
| phlame_plot | Generate informative output plots from lineage classification. |

## Reference documentation
- [PHLAME README](./references/github_com_quevan_phlame_blob_master_README.md)
- [Building a Database Tutorial](./references/github_com_quevan_phlame_blob_master_docs_building_database_tutorial.md)
- [Classifying Samples Tutorial](./references/github_com_quevan_phlame_blob_master_docs_classifying_samples_tutorial.md)
- [Conceptual Introduction to PHLAME](./references/github_com_quevan_phlame_blob_master_docs_conceptual_intro.md)