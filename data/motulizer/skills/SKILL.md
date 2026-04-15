---
name: motulizer
description: mOTUlizer is a bioinformatics suite for clustering metagenome-assembled genomes into taxonomic units and performing Bayesian pangenome analysis. Use when user asks to cluster genomes based on average nucleotide identity, identify species boundaries, or estimate core functional traits while accounting for genome incompleteness.
homepage: https://github.com/moritzbuck/mOTUlizer/
metadata:
  docker_image: "quay.io/biocontainers/motulizer:0.3.2--pyhdfd78af_0"
---

# motulizer

## Overview

mOTUlizer is a specialized bioinformatics suite designed to handle the inherent "dubious origin" of metagenomic data, such as incompleteness and contamination. It provides a workflow to transition from raw genomic sequences to taxonomically meaningful clusters (mOTUs) and subsequently analyze the pangenome of those clusters. It is particularly useful for researchers working with MAGs who need to establish species boundaries (typically at 95% ANI) and identify core functional traits across varying quality genomes.

## Core Workflows

### 1. Clustering Genomes with mOTUlize.py
This tool builds a network of genomes based on similarity (ANI) and identifies connected components as mOTUs.

*   **Basic Clustering**:
    `mOTUlize.py --fnas path/to/genomes/*.fna -o clusters.tsv`
*   **Using Quality Metadata**:
    Provide a CheckM-style file to distinguish between high-quality MAGs (used to seed the network) and lower-quality SUBs (recruited to existing clusters).
    `mOTUlize.py --fnas *.fna --checkm checkm_results.txt -o clusters.tsv`
*   **Custom Thresholds**:
    While 95% is the default species-level cutoff, you can adjust it based on your specific taxonomic needs.
    `mOTUlize.py --fnas *.fna --similarity-cutoff 97 -o clusters.tsv`
*   **Efficiency Tip**:
    If running multiple iterations, save the similarity file to skip the expensive `fastANI` step in subsequent runs.
    `mOTUlize.py --fnas *.fna --keep-simi-file -o clusters.tsv`
    Then reuse: `mOTUlize.py --similarities mOTUlizer_simis.tsv --similarity-cutoff 99 -o new_clusters.tsv`

### 2. Pangenome Analysis with mOTUpan.py
This tool uses a Bayesian approach to estimate the likelihood of a gene being "core," accounting for the completeness of the input genomes.

*   **Basic Pangenome**:
    `mOTUpan.py --faas path/to/proteomes/*.faa -o pangenome_results.tsv`
*   **Refining with Completeness Priors**:
    Improve accuracy by providing known completeness estimates (e.g., from CheckM).
    `mOTUpan.py --faas *.faa --checkm checkm_stats.txt -o pangenome_results.tsv`
*   **Using Custom Traits**:
    Instead of protein sequences, you can provide a JSON or TAB-separated file of traits (e.g., COGs, KEGG Orthologs).
    `mOTUpan.py --cog_file traits.json -o core_traits.tsv`
*   **Validation via Bootstrapping**:
    Use the `--boots` flag to estimate false positive rates and recall for your core genome set.
    `mOTUpan.py --faas *.faa --boots 100 -o validated_pangenome.tsv`

### 3. Format Conversion with mOTUconvert.py
mOTUlizer can ingest data from other popular pangenome tools to perform its Bayesian core-genome estimation.

*   **Supported Inputs**: mmseqs2, Roary, PPanGGOLiN, eggNOG-mapper, and anvi'o.
*   **Example (Roary)**:
    `mOTUconvert.py --roary gene_presence_absence.csv -o motupan_input.tsv`

## Expert Tips and Best Practices

*   **The 95% Rule**: The default 95% ANI cutoff is a widely accepted proxy for circumscribing microbial species. Only deviate from this if you have specific evidence for your lineage.
*   **Handling "SUBs"**: Use the `--MAG-completeness` and `--MAG-contamination` flags to strictly define your "anchor" genomes. Genomes falling below these thresholds but above the `--SUB` thresholds will be recruited to the nearest MAG-based cluster rather than forming their own.
*   **Iterative Pangenomics**: mOTUpan iteratively updates completeness priors based on the identified core genome. If your genomes have highly variable quality, ensure you provide an initial `--checkm` file to help the model converge on a more accurate biological reality.
*   **Memory Management**: `fastANI` can be memory-intensive. mOTUlize.py handles this by running in blocks, but ensure your environment has sufficient RAM for the number of genomes provided.



## Subcommands

| Command | Description |
|---------|-------------|
| mOTUconverts.py | Converts output of diverse software generatig COGs, or genetically encoded traits into a genome2gene_clusters-JSON file useable by mOTUpan |
| mOTUlize | From a set of genomes, makes metagenomic Operational Taxonomic Units (mOTUs). By default it makes a graph of 95% (reciprocal) ANI (with fastANI) connected MAGs (with completeness > 40%, contamination < 5%). The mOTUs will be the connected components of this graph, to which smaller "SUBs" with ANI > 95% are recruited. If similarities provided, it should be a TAB-separated file with columns as query, subject and similarity (in percent, e.g. [0-100]) if you also provide fasta-files (for stats purpouses) query and names should correspond to the fasta-files you provide. If the columns are file names, the folders are removed (mainly so it can read fastANI output directly). |
| mOTUpan.py | From a buch of amino-acid sequences or COG-sets, computes concensus AA/COG sets. Returns all to stdout by default. |

## Reference documentation
- [mOTUlizer GitHub README](./references/github_com_moritzbuck_mOTUlizer_blob_master_README.md)
- [mOTUlizer Repository Overview](./references/github_com_moritzbuck_mOTUlizer.md)