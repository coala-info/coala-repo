---
name: fastoma
description: FastOMA is a scalable orthology inference engine that identifies orthologs and organizes protein sequences into Hierarchical Orthologous Groups. Use when user asks to perform large-scale phylogenomic analysis, infer orthology from protein sequences, or generate Hierarchical Orthologous Groups using a species phylogeny.
homepage: https://github.com/DessimozLab/FastOMA
metadata:
  docker_image: "quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0"
---

# fastoma

## Overview
FastOMA is a scalable orthology inference engine that transforms raw protein sequences into structured evolutionary data. By leveraging the OMAmer database and a provided species phylogeny, it identifies orthologs across diverse proteomes and organizes them into Hierarchical Orthologous Groups (HOGs). This tool is particularly useful for researchers performing large-scale phylogenomic analyses who require high-performance, automated workflows that integrate with containerized environments like Docker or Singularity.

## Input Requirements
To ensure a successful run, prepare your input directory with the following structure and constraints:

- **Proteome Folder**: A directory (e.g., `proteome/`) containing protein sequences in FASTA format.
  - Files must use the `.fa` extension.
  - The filename (excluding `.fa`) must exactly match the species name used in the species tree.
  - **Constraint**: Sequence headers must not contain special characters, specifically the pipe symbol `||`.
- **Species Tree**: A rooted tree in Newick format.
  - Branch lengths are not required.
  - The tree does not need to be fully resolved (binary).
  - **Constraint**: Internal nodes and leaves must not contain special characters (spaces, slashes, etc.) or quotation marks.
- **OMAmer Database**: By default, FastOMA downloads the LUCA database (approx. 7.7 GB). You can provide a local path or a URL to a smaller subset (e.g., Primates) using the `--omamer_db` flag.

## Common CLI Patterns

### Standard Execution
The most efficient way to run FastOMA is via Nextflow, which handles dependencies automatically through profiles.

```bash
nextflow run dessimozlab/FastOMA -profile docker --input /path/to/proteome_folder --output_folder /path/to/output
```

### Using Specific Versions
To ensure reproducibility, specify a release version:

```bash
nextflow run dessimozlab/FastOMA -r v0.5.1 -profile singularity --input ./proteome --output_folder ./results
```

### Custom Database and Container
If working offline or with a specific subset of the OMAmer database:

```bash
nextflow run dessimozlab/FastOMA -profile conda \
  --input ./proteome \
  --output_folder ./results \
  --omamer_db /local/path/to/omamer_db.h5
```

## Expert Tips and Best Practices
- **Tree Validation**: FastOMA automatically checks the species tree. If labels are missing for internal nodes, it will generate them and save the corrected tree as `species_tree_checked.nwk` in the output folder. Use this file for downstream HAM (Phylogenetic HOG Analysis Method) analyses.
- **Memory Management**: When running the LUCA database, ensure the system has at least 16GB of RAM available for the OMAmer mapping step.
- **Nextflow Cache**: If a run fails or you update the code, Nextflow might use a cached version. Use `nextflow drop dessimozlab/FastOMA` to clear the local cache and pull the latest version.
- **Output Interpretation**: 
  - `OrthologousGroups.orthoxml`: The primary HOG structure for use with PyHAM.
  - `RootHOGs.tsv`: Deepest level orthology information.
  - `MarkerGenes/`: Contains groups with a maximum of one gene per species, ideal for species tree reconstruction.

## Reference documentation
- [FastOMA GitHub Repository](./references/github_com_DessimozLab_FastOMA.md)
- [FastOMA Wiki](./references/github_com_DessimozLab_FastOMA_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_fastoma_overview.md)