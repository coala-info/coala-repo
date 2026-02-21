---
name: gmsc-mapper
description: GMSC-mapper is a specialized bioinformatics tool for the discovery and characterization of small proteins within the global microbiome.
homepage: https://github.com/BigDataBiology/GMSC-mapper
---

# gmsc-mapper

## Overview
GMSC-mapper is a specialized bioinformatics tool for the discovery and characterization of small proteins within the global microbiome. It automates the workflow of predicting smORFs from raw genomic contigs and performing high-throughput alignments against the GMSC database. By integrating with alignment engines like DIAMOND and MMseqs2, the tool provides ecological and evolutionary context for small proteins, including their likely habitats, taxonomic origins, and sequence quality metrics.

## Core Workflows

### 1. Database Preparation
Before running queries, you must download and index the GMSC database.

*   **Download**: `gmsc-mapper downloaddb --dbdir ./db`
*   **Index (DIAMOND - Default)**: `gmsc-mapper createdb -i ./db/GMSC10.90AA.faa.gz -o ./db -m diamond`
*   **Index (MMseqs2)**: `gmsc-mapper createdb -i ./db/GMSC10.90AA.faa.gz -o ./db -m mmseqs`

### 2. Running Alignments
The tool accepts three primary input types. Ensure the `--dbdir` points to the directory containing your indexed database.

*   **From Genome Contigs**: Predicts smORFs automatically before mapping.
    `gmsc-mapper -i ./input_contigs.fa --dbdir ./db -o ./output_dir`
*   **From Amino Acid Sequences**:
    `gmsc-mapper --aa-genes ./input_proteins.faa --dbdir ./db -o ./output_dir`
*   **From Nucleotide Gene Sequences**:
    `gmsc-mapper --nt-genes ./input_genes.fna --dbdir ./db -o ./output_dir`

### 3. Customizing Annotations
By default, the tool attempts to provide habitat, taxonomy, quality, and domain annotations. You can disable specific modules to reduce processing time or output size:

`gmsc-mapper -i input.fa --dbdir ./db --no-habitat --no-taxonomy --no-quality --no-domain`

## CLI Best Practices
*   **Tool Selection**: Use `--tool mmseqs` if you require MMseqs2 alignment; otherwise, DIAMOND is the default and generally faster for most smORF mapping tasks.
*   **Directory Consistency**: The `-o` path used during `createdb` must be the same path passed to `--dbdir` during the mapping phase.
*   **Output Interpretation**:
    *   `predicted.filterd.smorf.faa`: Contains the sequences predicted from your contigs.
    *   `mapped.smorfs.faa`: Contains only the query sequences that had hits in the GMSC.
    *   `*.out.smorfs.tsv`: Tab-separated files containing the specific metadata (habitat, taxonomy, etc.) for each hit.

## Reference documentation
- [GMSC-mapper GitHub Repository](./references/github_com_BigDataBiology_GMSC-mapper.md)
- [GMSC-mapper Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gmsc-mapper_overview.md)