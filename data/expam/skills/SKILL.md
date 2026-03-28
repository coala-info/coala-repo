---
name: expam
description: expam performs taxonomic and phylogenetic characterization of metagenomic samples using phylogeny-aware mapping. Use when user asks to characterize metagenomic samples, map reads to taxonomic lineages, generate phylogenetic trees, or convert phylogenetic results into taxonomic summaries.
homepage: https://github.com/seansolari/expam
---

# expam

## Overview

expam (Extended Phylogeny-Aware Metagenomics) is a specialized tool for the taxonomic and phylogenetic characterization of metagenomic samples. Unlike traditional classifiers that rely solely on taxonomic labels, expam utilizes phylogenetic trees to provide more nuanced mapping, distinguishing between single-leaf (SL) and multi-leaf (ML) assignments. It is particularly useful for researchers needing to reconcile metagenomic reads with specific NCBI taxonomic lineages or custom phylogenetic structures.

## Installation and Setup

The recommended installation method is via Bioconda to ensure all C-extensions and dependencies (like HDF5) are correctly linked.

```bash
# Recommended installation with ETE3 for tree plotting
conda create -n expam -c conda-forge -c bioconda -c etetoolkit expam ete3
```

**Critical Version Note**: Ensure you are using version 1.4.0.0 or higher. Previous versions contained a critical bug regarding "environmental samples" in the NCBI taxonomy mapping.

## Common CLI Patterns

### Database Management
After a successful database build, you must manually specify Taxonomic IDs for input sequences.
- Locate `accession_ids.csv` in your database directory.
- Fill the third column with the appropriate NCBI TaxIDs.

### Classification and Mapping
To convert phylogenetic results into taxonomic summaries:
```bash
expam to_taxonomy <project_name>
```

### Phylogenetic Analysis
To generate or interact with phylogenetic trees, especially when using Sourmash signatures:
```bash
expam tree <project_name> --sourmash
```

### Filtering and Cutoffs
As of version 1.2, the `--cutoff` flag has been deprecated. Use Counts Per Million (CPM) for automated filtering:
```bash
# Apply a CPM-based cutoff to sample outputs
expam <command> --cpm <value>
```

## Expert Tips and Best Practices

### Memory Management (OOM Prevention)
expam makes extensive use of shared memory (`/dev/shm`). On high-core systems, using too many processes can trigger the OOM (Out Of Memory) killer.
- **Process Limit**: For large databases on high-memory machines, stick to 10–30 processes.
- **Resource Limiting**: Use the `expam_limit` utility to set hard bounds on memory consumption.
- **Shared Memory Check**: If the program crashes ungracefully, check for orphaned shared memory segments using `df -h /dev/shm`.

### Troubleshooting ETE3/Qt
If you encounter `ImportError: cannot import name 'NodeStyle'`, it is usually a Qt5 linking issue.
- **Mac**: Install `qt5` via brew and then install the matching `pyqt5` version via pip (e.g., `pip install pyqt5==5.15` if brew installed 5.15.x).
- **Linux**: Install `qt5-default` via apt and match the `pyqt5` pip package to the system version.

### Output Interpretation
- **SL vs. ML**: Single-leaf (SL) counts represent unique assignments, while Multi-leaf (ML) counts represent assignments to internal nodes (uncertainty).
- **Total Counts**: Version 1.4+ includes a 'total' column that combines SL and ML counts for a simplified view.
- **Cumulative Summaries**: expam generates summary files that combine all samples into a single table after accumulation and cutoffs are applied.



## Subcommands

| Command | Description |
|---------|-------------|
| expam add | Add sequence to the database. |
| expam build | Start building database. |
| expam create | Initialise database. |
| expam cutoff | Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS! |
| expam download_taxonomy | Download taxonomic information for reference sequences. |
| expam draw_tree | Draw the reference tree. |
| expam make_reads | Uniformly sample reads of length l from some input sequence. This is for testing purposes only, and is not a replacement for actual read generating software. |
| expam mashtree | Create mashtree from current sequences and add to database. |
| expam phylotree | Draw results on phylotree. |
| expam print | Print current database parameters. |
| expam quickrun | Initialise, set parameters and start building db (assumes sequences all lie in the same folder). |
| expam remove | Remove sequence from database (only impacts future db builds). |
| expam run | Run reads against database. |
| expam set | Set database build parameters. |
| expam to_taxonomy | Convert results to taxonomic setting. |

## Reference documentation
- [expam GitHub README](./references/github_com_seansolari_expam_blob_main_README.md)
- [expam Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_expam_overview.md)