---
name: alphafill
description: AlphaFill transplants ligands and co-factors from experimental structures into AlphaFold protein models to provide molecular context. Use when user asks to process mmCIF models, create a structural index, or manage a local AlphaFill database and server.
homepage: https://alphafill.eu
---


# alphafill

## Overview

AlphaFill is a computational tool designed to add molecular context to AlphaFold protein models. While AlphaFold predicts protein coordinates with high accuracy, it often lacks the ligands and co-factors essential for understanding biological function. AlphaFill uses sequence and structural similarity to "transplant" these missing components from experimental structures (PDB and PDB-REDO) into the predicted models. Use this skill to perform local processing of structure files or to manage a local AlphaFill databank and web interface.

## Core Workflows

### 1. Initial Setup and Indexing
Before processing models, you must generate a FastA index of your local PDB/PDB-REDO directory. This index is used by the algorithm to find structural analogues.

```bash
# Build the PDB FastA file based on your configuration
alphafill create-index
```

### 2. Processing AlphaFold Models
The primary function of AlphaFill is to take a predicted model (mmCIF format) and produce a "filled" version containing transplanted ligands.

```bash
# Basic processing command
alphafill process <input-model.cif.gz> <output-filled-model.cif.gz>
```

**Expert Tips for Processing:**
- **Input Format**: AlphaFill specifically works with mmCIF (.cif) files. If your files are compressed (.gz), the tool can handle them directly.
- **Performance**: Most models process in under 2 minutes, though time increases with the number of potential transplants.
- **Validation**: Check the metadata in the resulting mmCIF file to see the Root-Mean-Square deviation (RMSd) values, which indicate the quality of the transplant alignment.

### 3. Server and Database Management
If you are running the AlphaFill web application environment, use these commands to manage the backend.

- **Database Initialization**: After processing files into your `db-dir`, sync the statistics to your PostgreSQL database:
  ```bash
  alphafill rebuild-db
  ```
- **Daemon Control**:
  ```bash
  # Start the server as a daemon
  alphafill server start

  # Run in the foreground (useful for debugging)
  alphafill server start --no-daemon

  # Check status or stop
  alphafill server status
  alphafill server stop
  ```

## Configuration Best Practices

The `alphafill.conf` file (typically located in `/etc/`) must be correctly configured for the CLI to function. Ensure the following paths are defined:

- `pdb-dir`: Path to your local PDB or PDB-REDO structure library.
- `pdb-fasta`: Path where the `create-index` command will store the sequence file.
- `ligands`: Path to the `af-ligands.cif` file (provided with the source) which defines which compounds are eligible for transplantation.

## Data Access and Integration

If you need to fetch data from the public AlphaFill databank instead of running it locally:
- **REST API**: Access structure files at `https://alphafill.eu/v1/aff/${uniprot_id}`.
- **Metadata**: Retrieve transplant metadata in JSON format at `https://alphafill.eu/v1/aff/${uniprot_id}/json`.
- **Bulk Download**: Use rsync to mirror the entire databank:
  ```bash
  rsync -av rsync://rsync.alphafill.eu/alphafill/ local_alphafill_dir/
  ```



## Subcommands

| Command | Description |
|---------|-------------|
| alphafill | AlphaFill is a tool to process AlphaFold structures by enriching them with ligands and co-factors from the PDB. |
| alphafill | AlphaFill is a tool to process AlphaFold structures by filling in missing compounds. It can create indices from PDB files or process AlphaFill structures. |
| create-index | Create an index for AlphaFill using PDB mmCIF files and sequences |
| process | Process AlphaFold models to fill them with ligands and other missing structural information. |

## Reference documentation
- [AlphaFill README](./references/github_com_PDB-REDO_alphafill_blob_trunk_README.md)
- [AlphaFill Manual Pages](./references/alphafill_eu_manual.md)
- [AlphaFill Download and API Guide](./references/alphafill_eu_download.md)