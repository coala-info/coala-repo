---
name: macsyfinder
description: MacSyFinder is a specialized bioinformatics tool used to detect molecular systems in protein datasets.
homepage: https://github.com/gem-pasteur/macsyfinder
---

# macsyfinder

## Overview

MacSyFinder is a specialized bioinformatics tool used to detect molecular systems in protein datasets. Unlike simple homology searches that identify individual proteins, MacSyFinder uses "systems modeling" to look for clusters of proteins that together form a functional biological system. It relies on Hidden Markov Model (HMM) profiles to identify components and then applies rules regarding their presence, number, and genetic proximity to determine if a complete system is present. This is particularly useful for annotating secretion systems, pili, and other complex bacterial machineries.

## Model Management with msf_data

In version 2.x, models are managed separately from the main engine using the `msf_data` tool (formerly `macsydata`).

- **Search for available model packages**:
  `msf_data search <package_name>`
- **Install a model package**:
  `msf_data install <package_name>`
- **List installed models and their structure**:
  `msf_data show <package_name>`
- **Initialize a new model package (for modelers)**:
  `msf_data init <package_name>`

## Running MacSyFinder

The primary command is `macsyfinder`. It requires a sequence database, a definition of the database type, and the specific models to search for.

### Common CLI Pattern
```bash
macsyfinder --db-type gembase --models-dir /path/to/models --models T2SS T4P --sequence-db my_genome.fasta -w 12
```

### Key Parameters
- `--db-type`: Defines the organization of the input data.
  - `gembase`: For data organized as replicons (standard for many genomic databases).
  - `ordered_replicon`: For a single ordered set of proteins (e.g., a single FASTA file of a genome).
  - `unordered`: For datasets where protein order is unknown or irrelevant (e.g., metagenomic bins).
- `--models`: A list of specific systems to search for (e.g., `T2SS`, `T6SS`, `Flagellum`).
- `--models-dir`: Path to the directory containing the installed model definitions.
- `--sequence-db`: The input protein FASTA file.
- `-w` or `--worker`: Number of CPUs to use for HMMER searches.

## Expert Tips and Best Practices

- **Script Renaming**: Note that in version 2.1.5+, several scripts were renamed for consistency. Use the `msf_` prefix versions:
  - `macsydata` -> `msf_data`
  - `macsyprofile` -> `msf_profile`
  - `macsy_merge` -> `msf_merge`
  - `macsy_split` -> `msf_split`
- **HMMER Dependency**: Ensure HMMER >= 3.1 is installed and available in your PATH, as MacSyFinder relies on it for the initial protein detection phase.
- **Docker/Apptainer Usage**: When using containers, you must mount a local directory to `/home/msf` to exchange data. Models should be installed into this mounted directory using `msf_data install --target /home/msf/my_models`.
- **Memory Management**: For very large datasets, use `msf_split` to break the database into smaller chunks before processing, then use `msf_merge` to consolidate results.
- **Model Validation**: If you are developing your own models, use `msf_data check` to verify that your HMM profiles are valid and that the metadata is correctly formatted before running a full search.

## Reference documentation
- [MacSyFinder GitHub README](./references/github_com_gem-pasteur_macsyfinder.md)
- [MacSyFinder Version 2.1.5 Release Notes](./references/github_com_gem-pasteur_macsyfinder_tags.md)
- [Bioconda MacSyFinder Overview](./references/anaconda_org_channels_bioconda_packages_macsyfinder_overview.md)