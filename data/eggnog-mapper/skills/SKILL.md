---
name: eggnog-mapper
description: eggnog-mapper performs functional annotation of novel biological sequences by leveraging orthology-based transfer from the eggNOG database. Use when user asks to annotate protein or nucleotide sequences, perform metagenomic gene prediction, or assign GO terms and KEGG pathways to genomic data.
homepage: https://github.com/jhcepas/eggnog-mapper
---

# eggnog-mapper

## Overview
The eggnog-mapper tool provides a high-performance workflow for annotating novel biological sequences by leveraging the eggNOG database. Unlike simple BLAST-based homology searches, it uses orthology-based transfer, which significantly reduces the risk of transferring incorrect functional information from paralogs. It is particularly effective for large-scale datasets like metagenomic catalogs where precision and speed are critical.

## Core Workflow
The tool typically operates in two distinct phases:
1.  **Search Phase**: Identifying "seed orthologs" using DIAMOND (default/recommended), MMseqs2, or HMMER.
2.  **Annotation Phase**: Expanding functional data from those seed orthologs to the query sequences.

### Database Setup
Before running annotations, the required databases must be downloaded:
```bash
# Download the main annotation database and DIAMOND/HMMER data
download_eggnog_data.py euk bact arch
```

### Common CLI Patterns

**Standard DIAMOND-based Annotation (Recommended)**
Fastest and most common approach for protein sequences.
```bash
emapper.py -i input_proteins.fasta -o output_prefix -m diamond
```

**Metagenomic Gene Prediction and Annotation**
Use this when starting with nucleotide sequences (e.g., contigs). It uses Prodigal for gene calling.
```bash
emapper.py -i metagenome.fasta -o output_prefix --itype metagenome --translate
```

**HMMER-based Annotation**
Use for higher sensitivity at the cost of speed, or when targeting specific taxonomic levels.
```bash
emapper.py -i input.fasta -o output_prefix -d maNOG --usemem
```

### Performance Optimization
*   **Memory Mapping**: Use `--usemem` to load HMM databases into RAM, significantly speeding up HMMER searches.
*   **Server Mode**: For processing multiple files sequentially, start a server to keep the database in memory:
    ```bash
    # Start server
    emapper.py -d bact --cpu 10 --servermode
    # Connect client
    emapper.py -d bact:localhost:51600 -i query.fa -o results
    ```
*   **Large Datasets**: For >10M sequences, split the input into chunks (e.g., 1M sequences each) and run the search phase (`--no_annot`) across a cluster, then merge and run the annotation phase (`--annotate_hits_table`).

## Output Files
*   `.emapper.seed_orthologs`: Contains the best match in eggNOG for each query.
*   `.emapper.annotations`: The primary results file. Key columns include:
    *   **Column 1**: Query name.
    *   **Column 6**: GO terms.
    *   **Column 7**: KEGG KOs.
    *   **Column 12**: COG functional categories.
    *   **Column 13**: eggNOG functional description.

## Expert Tips
*   **Taxonomic Scope**: Use `--tax_scope` to restrict orthology searches to a specific clade if the origin of your samples is known (e.g., `--tax_scope Bacteria`).
*   **E-value Thresholds**: While defaults are robust, use `--evalue` to adjust sensitivity for highly divergent sequences.
*   **Version Alignment**: Ensure your eggnog-mapper version matches the database version. Major version changes in the database usually require re-running the search phase.



## Subcommands

| Command | Description |
|---------|-------------|
| download_eggnog_data.py | Download eggNOG data |
| emapper.py | EggNOG-mapper: functional annotation of novel and known proteins. |

## Reference documentation
- [eggNOG-mapper v2.1.5 to v2.1.13](./references/github_com_eggnogdb_eggnog-mapper_wiki_eggNOG-mapper-v2.1.5-to-v2.1.13.md)
- [eggNOG-mapper v1 (HMMER/Server details)](./references/github_com_eggnogdb_eggnog-mapper_wiki_eggNOG-mapper-v1.md)
- [FAQ - Frequently Asked Questions](./references/github_com_eggnogdb_eggnog-mapper_wiki_FAQ---Frequently-Asked-Questions.md)