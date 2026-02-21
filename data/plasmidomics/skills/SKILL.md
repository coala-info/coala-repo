---
name: plasmidomics
description: The plasmidomics skill provides a structured workflow for analyzing plasmid sequences to uncover their functional characteristics and evolutionary relationships.
homepage: https://github.com/braddmg/Plasmidome-analysis
---

# plasmidomics

## Overview
The plasmidomics skill provides a structured workflow for analyzing plasmid sequences to uncover their functional characteristics and evolutionary relationships. It integrates several bioinformatics tools—primarily Anvi’o, MobMess, and Mashtree—to transform raw plasmid contigs into annotated databases, classified networks (backbone, compound, fragment, and maximal clusters), and comparative pangenomic models. This skill is particularly useful for researchers investigating the "plasmidome" of specific bacterial species to identify potential pathogenicity factors or mobile genetic elements.

## Core Workflows and CLI Patterns

### 1. Database Generation and Annotation
Before functional analysis, plasmid sequences must be formatted and annotated using the Anvi’o framework.

*   **Reformat and Filter**: Remove short contigs (typically < 1000 bp) to improve assembly quality.
    ```bash
    anvi-script-reformat-fasta plasmids.fasta -o plasmids.fa -l 1000 --seq-type NT
    ```
*   **Generate Contigs Database**:
    ```bash
    anvi-gen-contigs-database -f plasmids.fa -o plasmids.db
    ```
*   **Functional Annotation**: Run HMMs and assign COG/Pfam functions.
    ```bash
    anvi-run-hmms -c plasmids.db
    anvi-run-ncbi-cogs -c plasmids.db -T 64 --cog-version COG14
    anvi-run-pfams -c plasmids.db -T 64
    ```
*   **Export Calls**: Extract gene calls and functions for downstream tools like MobMess.
    ```bash
    anvi-export-gene-calls --gene-caller prodigal -c plasmids.db -o plasmids-gene-calls.txt
    anvi-export-functions --annotation-sources COG14_FUNCTION,Pfam -c plasmids.db -o plasmids-cogs-and-pfams.txt
    ```

### 2. MobMess Network Analysis
MobMess classifies plasmids into networks based on shared gene content.

*   **System Generation**:
    ```bash
    mobmess systems --sequences plasmids.fa --complete plasmids.txt --output mobmess --threads 64
    ```
*   **Network Visualization**: To visualize specific plasmid relationships, provide a comma-separated list of contig IDs.
    ```bash
    mobmess visualize -s plasmids.fa -a plasmids-cogs-and-pfams.txt -g plasmids-gene-calls.txt -o output_dir/ --contigs ID1,ID2,ID3 --align-blocks-height 1
    ```

### 3. Comparative Phylogeny (Mashtree)
Generate distance-based dendrograms using Mash distances to visualize plasmid clusters.

*   **Subsampling**: Create a non-redundant (nr) set of representative plasmids.
    ```bash
    seqtk subseq plasmids.fa representative.txt > nrplasmids.fasta
    ```
*   **Dendrogram Generation**: Use Mashtree on individual FASTA files (split from the main set).
    ```bash
    mashtree --mindepth 0 *.fasta --outtree plasmid_relationships.tree
    ```

### 4. Functional Enrichment Analysis
Identify functions that are statistically overrepresented in specific plasmid groups.

*   **Pangenome Setup**:
    ```bash
    anvi-gen-genomes-storage -e external-genomes.txt -o GENOMES.db
    anvi-pan-genome -g GENOMES.db --project-name PlasmidPan --num-threads 32
    ```
*   **Compute Enrichment**:
    ```bash
    anvi-compute-functional-enrichment -p PlasmidPan/PlasmidPan-PAN.db -g GENOMES.db -o enrichment_results.txt --category-variable group --annotation-source COG14_FUNCTION
    ```

## Expert Tips
*   **Thread Optimization**: Tools like `anvi-run-ncbi-cogs` and `mobmess` are computationally intensive; always utilize the `--threads` or `-T` flag based on available hardware.
*   **Sequence Splitting**: When running Mashtree, ensure the `nrplasmids.fasta` is split into individual files (one per plasmid) using a helper script like `sep.py` to ensure the distance matrix is calculated correctly between individual entities.
*   **Database Paths**: Ensure the `--cog-data-dir` and `--pfam-data-dir` paths in Anvi'o commands point to the local installation of these databases.

## Reference documentation
- [Pipeline for plasmidomic analyses](./references/github_com_braddmg_Plasmidome-analysis.md)