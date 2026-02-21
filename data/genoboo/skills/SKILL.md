---
name: genoboo
description: Genoboo is a collaborative notebook environment specifically designed for comparative genomics.
homepage: https://github.com/gogepp/genoboo
---

# genoboo

---

## Overview
Genoboo is a collaborative notebook environment specifically designed for comparative genomics. As an active fork of GeneNoteBook, it provides a web-based interface for teams to visualize, annotate, and share genomic data. It is best used when you need a centralized platform to manage multiple genome versions, comparative annotations, and gene-specific notes within a research group.

## Installation and Setup
Genoboo is primarily distributed via Bioconda.

```bash
# Install via conda
conda install -c bioconda genoboo

# Start the server
genoboo run
```
By default, the application initializes a web server accessible at `http://localhost:3000`.

## Core CLI Operations
The `genoboo` command-line interface is used to populate the database with genomic data.

### 1. Adding a Genome
To import a reference sequence, use the `add genome` command. You must provide administrative credentials and a unique name for the genome.

```bash
genoboo add genome -u admin -p admin --port 3000 -n <genome_name> <path_to_fasta>
```

### 2. Adding Annotations
Once a genome is established, you can overlay structural or functional annotations using GFF3 files.

```bash
genoboo add annotation -u admin -p admin --port 3000 -n <genome_name> <path_to_gff3>
```

## Expert Tips and Best Practices
- **Security First**: The default administrative credentials are `admin` / `admin`. Change these immediately upon the first login to prevent unauthorized access to your genomic datasets.
- **Data Naming**: The `-n` (name) flag is the primary identifier used to link annotations to sequences. Ensure the name used during the `add annotation` step exactly matches the name used during the `add genome` step.
- **Port Management**: If port 3000 is occupied by another service (like a standard Meteor or Node.js app), use the `--port` flag during both the `run` and `add` commands to specify an alternative.
- **Progress Tracking**: For large genome files, the loader provides a progress bar. If running in an automated environment or a CI/CD pipeline, look for the `--silent` option (available in newer versions) to reduce log verbosity.
- **Database Persistence**: Genoboo uses MongoDB (via Meteor) to store annotations and metadata. Ensure your environment has sufficient disk space for the `private/data` directory where the database resides.

## Reference documentation
- [genoboo Overview](./references/anaconda_org_channels_bioconda_packages_genoboo_overview.md)
- [genoboo GitHub README](./references/github_com_gogepp_genoboo.md)