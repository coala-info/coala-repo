---
name: gtotree
description: GToTree automates the retrieval of genomes, identification of single-copy genes, and construction of phylogenomic trees from various input formats. Use when user asks to build a phylogenetic tree, identify single-copy genes across genomes, or place metagenome-assembled genomes into an evolutionary context.
homepage: https://github.com/AstrobioMike/GToTree/wiki/what-is-gtotree%3F
metadata:
  docker_image: "quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2"
---

# gtotree

## Overview
GToTree is a high-throughput tool designed to simplify the complex process of phylogenomics. It automates the retrieval of genomes from NCBI, identifies target single-copy genes using HMMER, aligns sequences, and produces a concatenated alignment and a phylogenetic tree. It is particularly useful for placing newly recovered Metagenome-Assembled Genomes (MAGs) into an evolutionary context alongside reference genomes or for building large-scale "Trees of Life."

## Core Workflow and CLI Patterns

### 1. Input Preparation
GToTree accepts four primary input types, each requiring a single-column text file containing the identifiers or paths:
- **NCBI Accessions (`-a`)**: List of GCF or GCA assembly accessions.
- **GenBank Files (`-g`)**: Paths to `.gbk` or `.gbff` files.
- **Nucleotide FASTA (`-f`)**: Paths to `.fasta` or `.fna` files.
- **Amino Acid FASTA (`-A`)**: Paths to `.faa` files.

### 2. Selecting HMM Sets
Use `gtt-hmms` to list available pre-built single-copy gene sets. Common sets include:
- `Bacteria.hmm` (74 genes)
- `Archaea.hmm` (76 genes)
- `Universal.hmm` (16 genes from Hug et al.)
- Taxon-specific sets (e.g., `Actinobacteria.hmm`, `Cyanobacteria.hmm`, `Proteobacteria.hmm`).

### 3. Common Command Execution
A standard run combining local MAGs with NCBI references:
```bash
GToTree -a ncbi_accessions.txt -f my_mags.txt -H Bacteria.hmm -o output_dir -j 8
```

### 4. Expert Tips and Best Practices
- **Labeling**: Use the `-m` flag with a two-column tab-delimited file (ID <tab> New_Label) to ensure your specific genomes are easily identifiable in the final tree.
- **Taxonomy Integration**: Use the `-t` flag to add NCBI lineage information to tree labels (requires TaxonKit).
- **GTDB Integration**: For more consistent taxonomy, use the `-D` flag to use Genome Taxonomy Database (GTDB) information instead of NCBI.
- **Representative Genomes**: When dealing with thousands of hits (e.g., *Staphylococcus*), use the helper tool `gtt-get-accessions-from-GTDB` with the `--GTDB-representatives-only` flag to keep the tree size manageable.
- **Outgroups**: Always include a known outgroup (e.g., an Archaeon for a Bacterial tree) to properly root your phylogeny.
- **Advanced Treeing**: If the default FastTree output is insufficient, use the generated `Partitions.txt` and `Aligned_SCGs.faa` with IQ-TREE for more rigorous model selection and tree construction.

## Helper Programs
- `gtt-hmms`: Lists available HMM sets and their locations.
- `gtt-get-accessions-from-GTDB`: Retrieves accessions based on GTDB taxonomy.
- `gtt-subset-GTDB-accessions`: Subsets large accession lists (e.g., picking one representative per Order).



## Subcommands

| Command | Description |
|---------|-------------|
| gtotree | This program takes input genomes from various sources and ultimately produces a phylogenomic tree. |
| gtotree_gtt-hmms | GToTree pre-packaged HMM SCG-sets. See github.com/AstrobioMike/GToTree/wiki/SCG-sets for more info |
| gtt-get-accessions-from-GTDB | This is a helper program to facilitate using taxonomy and genomes from the Genome Taxonomy Database (gtdb.ecogenomic.org) with GToTree. It primarily returns NCBI accessions and GTDB summary tables based on GTDB-taxonomy searches. It also currently has filtering capabilities built-in for specifying only GTDB representative species or RefSeq representative genomes (see help menu and links therein for explanations of what these are). For examples, please visit the GToTree wiki here: github.com/AstrobioMike/GToTree/wiki/example-usage |
| gtt-subset-GTDB-accessions | This script is a helper program of GToTree (https://github.com/AstrobioMike/GToTree/wiki) to facilitate subsetting accessions pulled from the GTDB database (with 'gtt-get-accessions-from-GTDB' – the input file is the "*metadata.tsv" from that program). It is intended to help when wanting a tree to span the breadth of diversity we know about, while also helping to reduce over-representation of certain taxa. There are 2 primary methods for using it: 1) If a specific Class makes up > 0.05% (by default) of the total number of target genomes, the script will randomly subset that class down to 1% of what it was. So if there are 40,000 total target genomes, and Gammaproteobacteria make up 8,000 of them (20% of the total), the program will randomly select 80 Gammaproteobacteria to include (1% of 8,000). 2) Select 1 random genome from each taxa of the specified rank. It ultimately outputs a new subset accessions file ready for use with the main GToTree program. |

## Reference documentation
- [GToTree User Guide](./references/github_com_AstrobioMike_GToTree_wiki_User-Guide.md)
- [Example Usage and Workflows](./references/github_com_AstrobioMike_GToTree_wiki_Example-usage.md)
- [Single-Copy Gene (SCG) Sets](./references/github_com_AstrobioMike_GToTree_wiki_SCG-sets.md)
- [Phylogenomic Considerations](./references/github_com_AstrobioMike_GToTree_wiki_Things-to-consider.md)