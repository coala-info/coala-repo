---
name: gtotree
description: GToTree is a high-throughput workflow that automates the identification of single-copy genes and the construction of phylogenomic trees from various genomic input formats. Use when user asks to build a phylogenomic tree, identify single-copy genes using HMMs, or generate concatenated gene alignments from NCBI accessions and FASTA files.
homepage: https://github.com/AstrobioMike/GToTree/wiki/what-is-gtotree%3F
---


# gtotree

## Overview
GToTree is a high-throughput workflow designed to streamline the complex process of phylogenomics. It automates the identification of single-copy genes using HMMER3, performs individual gene alignment and trimming, and concatenates the results into a final phylogenomic tree. This skill allows you to handle various input types simultaneously, manage taxonomic labeling via NCBI or GTDB, and estimate genome completeness based on the targeted gene sets.

## Core CLI Usage

### Basic Command Structure
The primary command requires specifying input genomes and a target HMM set.
```bash
GToTree -a accessions.txt -H Bacterial.hmm -o output_dir
```

### Input Options
- **NCBI Accessions (`-a`)**: A file containing one NCBI assembly accession per line (e.g., GCF_000153765.1).
- **FASTA Files (`-f`)**: A file containing paths to nucleotide FASTA files.
- **GenBank Files (`-g`)**: A file containing paths to `.gbk` or `.gbff` files.
- **Amino Acid Files (`-A`)**: A file containing paths to protein FASTA files (skips gene prediction).

### Managing HMM Sets
Use `gtt-hmms` to list available pre-packaged single-copy gene sets.
- **Universal**: `Universal_Hug_et_al.hmm` (16 genes)
- **Domain-specific**: `Bacterial.hmm` (74 genes), `Archaea.hmm` (76 genes)
- **Taxon-specific**: `Alphaproteobacteria.hmm`, `Cyanobacteria.hmm`, `Firmicutes.hmm`, etc.

## Expert Workflows and Tips

### 1. Working with GTDB (Genome Taxonomy Database)
For more accurate taxonomic placement than NCBI, use the GTDB helper tools:
- **Retrieve accessions**: `gtt-get-accessions-from-GTDB -t "Family_Name"`
- **Use GTDB labels**: Add the `-D` flag to the main `GToTree` command to use GTDB taxonomy for tree labels.

### 2. Handling Large Datasets
Building trees with thousands of genomes is computationally expensive and often redundant.
- **Representative Genomes**: Use NCBI or GTDB "representative" genomes to cover diversity without over-representing specific species.
- **Subsetting**: Use `gtt-subset-GTDB-accessions` to pick one representative per Order or Family.

### 3. Custom Labeling
Use a mapping file (`-m`) to provide human-readable names. The file should be tab-delimited:
```text
GCA_002271865.1.fa    My_New_MAG
GCF_000011365.1       Reference_Strain_A
```

### 4. Quality Filtering
GToTree performs automated filtering to ensure tree quality:
- **Genome Hits (`-G`)**: By default, genomes with hits to <50% of target SCGs are removed.
- **Gene Length (`-L`)**: Filters out gene hits that are >20% different from the median length of that gene across all genomes.

### 5. Downstream Analysis
If you want to use a more advanced tree builder (like IQ-TREE with specific models):
- Run GToTree with `-N` to generate only the alignment and partitions file without building the initial tree.
- Use the `Partitions.txt` and `Aligned_SCGs.faa` files in the output directory as inputs for your preferred phylogenetics software.

## Reference documentation
- [GToTree User Guide](./references/github_com_AstrobioMike_GToTree_wiki_User-Guide.md)
- [Example Usage](./references/github_com_AstrobioMike_GToTree_wiki_Example-usage.md)
- [SCG Sets Information](./references/github_com_AstrobioMike_GToTree_wiki_SCG-sets.md)
- [Important Considerations](./references/github_com_AstrobioMike_GToTree_wiki_Things-to-consider.md)