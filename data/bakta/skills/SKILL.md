---
name: bakta
description: Bakta provides comprehensive functional annotation of bacterial genomes, plasmids, and metagenome-assembled genomes using a high-throughput, database-driven approach. Use when user asks to annotate bacterial sequences, identify specialized features like ncRNAs and CRISPR arrays, or generate FAIR-compliant annotations with extensive database cross-references.
homepage: https://github.com/oschwengers/bakta
---


# bakta

## Overview

Bakta is a high-throughput tool designed to provide comprehensive functional annotation of bacterial sequences. It utilizes a large, versioned database and an alignment-free sequence identification (AFSI) approach to accelerate the annotation process by matching known protein sequences via MD5 hashes. This allows it to annotate a typical bacterial genome in approximately 10 minutes. Bakta is the preferred choice when you require FAIR-compliant annotations with extensive database cross-references (UniProt, RefSeq, GO, COG, EC) and high-quality detection of specialized features like ncRNAs and CRISPR arrays.

## Core CLI Usage

### Basic Annotation
To run a standard annotation on a bacterial genome:
```bash
bakta --db <path_to_db> --output <output_directory> --prefix <sample_name> <input.fasta>
```

### Handling Plasmids and MAGs
For Metagenome-Assembled Genomes or specific plasmid sequences, use the following flags to optimize the workflow:
*   **MAGs**: Use `--prodigal-training` if the assembly is fragmented.
*   **Plasmids**: Bakta is optimized for plasmids by default, but ensure you specify circularity if known.

### Metadata and Taxonomy
Providing taxonomic context can improve the naming of certain features, though the underlying search is taxonomy-independent:
```bash
bakta --db <db> --genus "Escherichia" --species "coli" --strain "K-12" <input.fasta>
```

### Specifying Replicon Information
If your input contains multiple contigs representing different replicons (e.g., a chromosome and three plasmids), provide a replicon table:
```bash
bakta --db <db> --replicons <replicons.tsv> <input.fasta>
```
*Note: The TSV should contain columns for sequence ID, topology (linear/circular), and replicon type (chromosome/plasmid).*

## Expert Tips and Best Practices

*   **Database Management**: Always ensure your database is up to date. Use the auxiliary tool `bakta_db` to manage downloads:
    ```bash
    bakta_db download --output <path>
    ```
*   **Custom Protein Sequences**: If you have a set of previously annotated proteins or specific genes of interest, use the `--proteins` flag to prioritize these during the annotation process.
*   **Small Proteins (sORFs)**: Bakta detects sORFs that are often missed by Prodigal. If your downstream analysis requires these, ensure you check the `.json` or `.gff3` outputs specifically for features labeled as sORFs.
*   **AMR and Virulence Factors**: Bakta integrates NCBI's AMRFinderPlus and VFDB. To ensure these are active, verify that the dependencies are correctly installed in your environment (standard in BioConda/Docker installs).
*   **JSON for Automation**: For automated pipelines, parse the `<prefix>.json` output. It contains the most comprehensive set of metadata and cross-references in a machine-readable format.
*   **Translation Tables**: By default, Bakta uses translation table 11 (Bacteria). If annotating specific taxa with alternative codes, specify it via `--translation-table`.

## Common CLI Patterns

| Task | Command/Flag |
| :--- | :--- |
| **Circular Contigs** | `--complete` (treats all contigs as circular) |
| **Thread Control** | `--threads <int>` (defaults to available cores) |
| **Compliance Check** | `--compliant` (forces Genbank/ENA submission compliance) |
| **Skip tRNA/rRNA** | `--skip-trna` or `--skip-rrna` (useful for re-running functional annotation only) |

## Reference documentation
- [Bakta GitHub Repository](./references/github_com_oschwengers_bakta.md)
- [Bakta BioConda Overview](./references/anaconda_org_channels_bioconda_packages_bakta_overview.md)
- [Bakta Community Discussions](./references/github_com_oschwengers_bakta_discussions.md)