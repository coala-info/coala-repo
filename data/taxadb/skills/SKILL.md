---
name: taxadb
description: `taxadb` is a specialized tool designed to create and query a local mirror of the NCBI taxonomy database.
homepage: https://github.com/HadrienG/taxadb
---

# taxadb

## Overview

`taxadb` is a specialized tool designed to create and query a local mirror of the NCBI taxonomy database. By moving taxonomy data into a local SQLite, MySQL, or PostgreSQL database, it enables high-performance lookups that bypass the rate limits and latency associated with remote NCBI E-utilities. This skill provides guidance on managing the local database lifecycle and utilizing the Python API for bioinformatics workflows.

## Database Management

Before querying, you must initialize and populate the local database.

### 1. Download NCBI Data
Download the required taxonomy files from the NCBI FTP server:
```bash
taxadb download -o taxadb_data
```

### 2. Create the Local Database
For most local tasks, SQLite is the preferred backend due to its zero-configuration nature:
```bash
taxadb create -i taxadb_data --dbname ncbi_taxonomy.sqlite --dbtype sqlite
```
*Note: For MySQL or PostgreSQL, you must create the database manually in the RDBMS before running the `create` command.*

## Common Python API Patterns

### Taxonomic Lookups by TaxID
Use the `TaxID` class to retrieve names and lineages.
```python
from taxadb.taxid import TaxID

# Initialize connection
taxid = TaxID(dbtype='sqlite', dbname='ncbi_taxonomy.sqlite')

# Get scientific name
name = taxid.sci_name(9606) # Returns 'Homo sapiens'

# Get full lineage
lineage = taxid.lineage_name(9606)
# Returns ['Homo sapiens', 'Homo', 'Hominidae', ..., 'cellular organisms']

# Check ancestry
is_eukaryote = taxid.has_parent(9606, 'Eukaryota') # Returns True
```

### Resolving Names to TaxIDs
Use the `SciName` class to find IDs associated with specific organisms.
```python
from taxadb.names import SciName

names = SciName(dbtype='sqlite', dbname='ncbi_taxonomy.sqlite')
tid = names.taxid('Escherichia coli') # Returns 562
```

### Mapping Accessions to Taxonomy
The `AccessionID` class handles mapping NCBI accession numbers (e.g., GenBank IDs) to TaxIDs.
```python
from taxadb.accessionid import AccessionID

accession = AccessionID(dbtype='sqlite', dbname='ncbi_taxonomy.sqlite')
# Batch processing via generator
for acc, tid in accession.taxid(['X17276', 'Z12029']):
    print(f"Accession {acc} belongs to TaxID {tid}")
```

## Expert Tips

### Configuration Management
Avoid hardcoding database credentials by using a configuration file (`taxadb.ini`) or environment variables.
- **Environment Variable**: `export TAXADB_CONFIG='/path/to/taxadb.cfg'`
- **Initialization**: `accession = AccessionID()` (will automatically read from the environment variable).

### Performance Optimization
- **Batching**: When using `AccessionID.taxid()`, pass a list of accessions rather than calling the function in a loop to reduce database overhead.
- **Lineage Direction**: Use `reverse=True` in `lineage_name` to get the lineage starting from 'cellular organisms' down to the species level.
- **Cleanup**: After a successful `taxadb create` run, you can safely delete the raw files downloaded via `taxadb download` to save disk space.

## Reference documentation
- [taxadb GitHub Repository](./references/github_com_HadrienG_taxadb.md)
- [taxadb Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_taxadb_overview.md)