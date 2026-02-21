---
name: pygcap
description: pygcap (Python Gene Cluster Annotation & Profiling) is a specialized bioinformatics tool for finding and analyzing gene clusters in microbial genome databases.
homepage: https://github.com/jrim42/pyGCAP
---

# pygcap

## Overview
pygcap (Python Gene Cluster Annotation & Profiling) is a specialized bioinformatics tool for finding and analyzing gene clusters in microbial genome databases. It automates the workflow of downloading genomic data from NCBI, searching for homologous genes using MMseqs2 and BLASTP, and visualizing the resulting gene content and order. Use this skill to streamline the identification of conserved or novel gene clusters across specific taxonomic groups.

## Installation and Environment
Ensure the following dependencies are available in your conda environment:
- **Core Tools**: `blast`, `mmseqs2`, `ncbi-datasets-cli`
- **Installation**: `conda install -c bioconda -c conda-forge pygcap ncbi-datasets-cli mmseqs2 blast`

## Command Line Usage
The basic syntax for running a discovery pipeline is:
`pygcap [TAXON] [PROBE_FILE] [OPTIONS]`

### Arguments
- **TAXON**: The target organism group. Accepts both scientific names (e.g., *Facklamia*) and NCBI TaxIDs (e.g., *66831*).
- **PROBE_FILE**: A TSV file defining the search probes.

### Probe File Format
The `probe.tsv` must contain three columns (no headers):
1. **Probe Name**: User-defined name for the gene.
2. **Prediction**: User-defined functional prediction or category.
3. **Accession**: The UniProt entry ID for the reference protein sequence.

## Expert CLI Patterns
### Resource Optimization
For large datasets, manually tune the threading and alignment depth:
- Use `-t` to set threads (default 50).
- Use `-m` to limit BLASTP results (default 500) to prevent memory overflow on common genes.
- Use `-i` to adjust protein identity thresholds (default 0.5) for MMseqs2 clustering.

### Iterative Refinement (The --skip Flag)
The `--skip` (or `-s`) option is critical for saving time when re-running analyses:
- **Adding new probes to the same taxon**: Use `-s ncbi -s parsing` to avoid re-downloading and processing genomes.
- **Adjusting search sensitivity**: Use `-s ncbi -s parsing -s uniprot` to re-run only the MMseqs2 and BLAST steps with different identity parameters.
- **Available skip arguments**: `ncbi`, `mmseqs2`, `parsing`, `uniprot`, `blastdb`, or `all`.

## Output Structure
The tool creates a directory named after the `[TAXON]`:
- `data/`: Raw metadata and assembly reports.
- `input/`: Downloaded genome files organized by genus.
- `output/img/`: Heatmaps of gene content.
- `output/genus/`: Visualizations of gene order/synteny.
- `seqlib/`: BLAST results and sequence libraries.

## Reference documentation
- [pyGCAP GitHub Repository](./references/github_com_quotient42_pyGCAP.md)
- [Probe Sample Format](./references/github_com_quotient42_pyGCAP_blob_main_pygcap_data_probe_sample.tsv.md)