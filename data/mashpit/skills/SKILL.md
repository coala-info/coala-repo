---
name: mashpit
description: Mashpit is a lightweight genomic epidemiology platform that utilizes Mash signatures (min-hash sketches) to facilitate fast and efficient comparison of genomic assemblies.
homepage: https://github.com/tongzhouxu/mashpit
---

# mashpit

## Overview
Mashpit is a lightweight genomic epidemiology platform that utilizes Mash signatures (min-hash sketches) to facilitate fast and efficient comparison of genomic assemblies. It is particularly useful for researchers and public health professionals who need to perform local surveillance on sensitive data or in environments with limited computational infrastructure. The tool automates the retrieval of representative genomes from the NCBI Pathogen Detection portal, allows for custom database creation via BioSample accessions, and provides both CLI and web-based interfaces for querying and visualization.

## Installation and Setup
The recommended installation method is via Conda or Mamba to ensure all dependencies (like Mash and Sourmash) are correctly managed.

```bash
conda create -n mashpit -c conda-forge -c bioconda 'mashpit=0.9.8'
conda activate mashpit
```

If using `pip`, ensure the NCBI `datasets` command-line tool is installed and available in your PATH.

## Core CLI Workflows

### 1. Building a Database
You can build a database based on a taxonomic name (fetching representative genomes from NCBI Pathogen Detection) or a specific list of accessions.

**By Taxon:**
```bash
# Build a database for Salmonella enterica
mashpit build taxon salmonella_db --species "Salmonella enterica"
```

**By Accession List:**
```bash
# Build a database from a text file containing BioSample accessions
mashpit build accession custom_db --list accessions.txt
```

**Expert Tip:** Use the `--pd_version` flag (e.g., `PDG000000091.9`) to build a database against a specific version of the NCBI Pathogen Detection clusters. This ensures reproducibility in longitudinal studies.

### 2. Querying Samples
Once a database is built (consisting of a `.db` and a `.sig` file within a folder), you can query local FASTA/genomic files against it.

```bash
# Query a local assembly against the listeria database
mashpit query path/to/sample.fasta path/to/mashpit_listeria_db
```

**Key Outputs:**
- `{sample}_output.csv`: Results ranked by Jaccard similarity (0-1).
- `{sample}_tree.newick`: A phylogenetic tree file.
- `{sample}_tree.png`: A visual representation of the genomic relationships.

### 3. Updating Databases
To keep a taxon-based database current with the latest NCBI releases:

```bash
mashpit update path/to/database_folder database_name
```

## Best Practices and Parameters
- **K-mer Size (`--ksize`):** The default is 31. For higher specificity in closely related strains, ensure this matches your sketch requirements.
- **Sketch Size (`--number`):** Default is 1000. Increasing this value can improve sensitivity but increases database size and query time.
- **Similarity Threshold (`--threshold`):** When querying, the default Jaccard similarity threshold for inclusion in the tree is 0.85. Adjust this lower if your samples are more divergent.
- **Web Interface:** For interactive visualization and sharing results with non-CLI users, use `mashpit webserver` to launch a GUI at `127.0.0.1:8080`. Note that a pre-built database is required before starting the server.

## Reference documentation
- [Mashpit GitHub Repository](./references/github_com_tongzhouxu_mashpit.md)
- [Mashpit Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mashpit_overview.md)