---
name: stag
description: STAG performs taxonomic assignment of metagenomic sequences and genomes using a hierarchical classification approach. Use when user asks to classify gene sequences, annotate genomes, or train a custom taxonomic database.
homepage: https://github.com/zellerlab/stag
---


# stag

## Overview
STAG is a specialized bioinformatics tool designed for the taxonomic assignment of metagenomic data. Unlike flat classifiers, STAG utilizes a hierarchical approach, training LASSO logistic regression classifiers at each node of a taxonomic tree. This allows for high-precision classification and the ability to stop assignment at higher taxonomic ranks when a sequence cannot be confidently placed at the species or genus level. It is particularly effective for 16S rRNA gene fragments and specific marker gene sets.

## Core Workflows

### 1. Sequence Classification
Classify gene sequences or 16S amplicons against a pre-built STAG database.

*   **Gene/Amplicon Classification:**
    ```bash
    stag classify -d <database.stagDB> -i <input.fasta>
    ```
    The output provides the sequence ID followed by the full taxonomic lineage (e.g., `d__Bacteria;p__Firmicutes;...`).

*   **Genome Classification:**
    Use this command to annotate entire genomes (FASTA files). STAG will predict genes (using Prodigal) and classify them.
    ```bash
    stag classify_genome -i <genome.fasta> -d <genome_db.stagDB> -o <output_directory>
    ```
    To classify a directory of genomes:
    ```bash
    stag classify_genome -D <genomes_dir> -d <genome_db.stagDB> -o <output_directory>
    ```

### 2. Database Construction
Building a custom database requires three primary components: reference sequences (FASTA), a taxonomy mapping file, and a Hidden Markov Model (HMM) file.

*   **Step 1: Validate Inputs**
    Always check the consistency between your FASTA headers and taxonomy IDs before training.
    ```bash
    stag check_input -i <ref_seqs.fa> -x <taxonomy.tax> -a <model.hmm>
    ```

*   **Step 2: Train the Database**
    Training is computationally intensive. For ~40k sequences, expect roughly 3 hours of processing time.
    ```bash
    stag train -i <ref_seqs.fa> -x <taxonomy.tax> -a <model.hmm> -o <new_database.stagDB>
    ```

## Expert Tips and Best Practices

*   **Taxonomy Format:** Ensure the taxonomy file is tab-separated: `gene_id [TAB] Kingdom;Phylum;Class;Order;Family;Genus;Species`.
*   **HMM Selection:** The HMM file must correspond to the sequences being trained. If you are working with a specific 16S region (e.g., V4), use an HMM trained specifically on that region for better alignment and classification accuracy.
*   **Memory and Performance:** Training large databases can be slow. Monitor the `.log` file generated during training (same name as the output DB) to track progress through stages like "Train all classifiers" and "Learn taxonomy selection function."
*   **Genome Annotation Output:** When using `classify_genome`, the primary result is found in the `genome_annotation` file within the specified output directory.



## Subcommands

| Command | Description |
|---------|-------------|
| check_input | Check the input for the train command |
| stag | Supervised Taxonomic Assignment of marker Genes |
| stag | Supervised Taxonomic Assignment of marker Genes |
| stag | Supervised Taxonomic Assignment of marker Genes |
| stag | Supervised Taxonomic Assignment of marker Genes |
| stag | Supervised Taxonomic Assignment of marker Genes |
| stag | Supervised Taxonomic Assignment of marker Genes |
| stag | Supervised Taxonomic Assignment of marker Genes |
| stag | Supervised Taxonomic Assignment of marker Genes |
| stag | Supervised Taxonomic Assignment of marker Genes |
| train | Train a STAG database |

## Reference documentation
- [GitHub - zellerlab/stag: A hierarchical taxonomic classifier for metagenomic sequences](./references/github_com_zellerlab_stag.md)
- [Build STAG database for genes](./references/github_com_zellerlab_stag_wiki_Build-STAG-database-for-genes.md)
- [Classify genomes](./references/github_com_zellerlab_stag_wiki_Classify-genomes.md)
- [Build STAG database for 16S amplicon](./references/github_com_zellerlab_stag_wiki_Build-STAG-database-for-16S-amplicon.md)