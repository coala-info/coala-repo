---
name: taxadb
description: "taxadb creates and queries a local mirror of the NCBI taxonomy database for high-throughput taxonomic lookups. Use when user asks to download taxonomy dumps, build a local taxonomic database, resolve TaxIDs to scientific names, retrieve lineage information, or map sequence accessions to taxonomic IDs."
homepage: https://github.com/HadrienG/taxadb
---


# taxadb

## Overview
taxadb is a Python-based utility designed to create and query a local mirror of the NCBI taxonomy database. It supports SQLite, MySQL, and PostgreSQL backends. By using a local database, it enables high-throughput taxonomic lookups that are significantly faster and more reliable than remote web service queries. It is particularly useful for bioinformatics pipelines requiring TaxID resolution for large sets of sequence accessions or scientific names.

## Installation and Setup
Install the core package via pip. For SQLite support (default), no additional drivers are needed.
```bash
pip install taxadb
```
*Note: For MySQL or PostgreSQL, install `pymysql` or `psycopg2` respectively.*

### Database Initialization
You must build the local database before querying. This is a two-step process:
1. **Download**: Fetch the latest taxonomy dumps from NCBI.
   ```bash
   taxadb download -o taxadb_data
   ```
2. **Create**: Parse the files and populate the local database.
   ```bash
   # For SQLite
   taxadb create -i taxadb_data --dbname my_taxonomy.sqlite
   
   # For MySQL/PostgreSQL (Database must already exist)
   taxadb create -i taxadb_data --dbname taxadb --dbtype mysql --username user --password pass
   ```

## Common CLI Patterns
The `taxadb` command-line interface is primarily used for database management. Querying is typically performed via the Python API, but the following patterns are essential for maintenance:

- **Update Database**: Rerunning the `download` and `create` commands will refresh the local data.
- **Custom Configuration**: Use a `.ini` file to store database credentials to avoid passing them in the CLI.
  ```bash
  taxadb create -i data --config taxadb.ini
  ```

## Python API Usage
The most efficient way to use taxadb is through its Python modules.

### TaxID and Lineage Lookups
Use the `TaxID` class to retrieve names and hierarchical information.
```python
from taxadb.taxid import TaxID

# Initialize connection
taxid = TaxID(dbtype='sqlite', dbname='my_taxonomy.sqlite')

# Get scientific name
name = taxid.sci_name(9606) # Returns 'Homo sapiens'

# Get full lineage names
lineage = taxid.lineage_name(9606, reverse=True)
# Returns ['cellular organisms', 'Eukaryota', ..., 'Homo sapiens']
```

### Accession to TaxID Mapping
The `AccessionID` class handles mapping sequence identifiers to taxonomic IDs.
```python
from taxadb.accessionid import AccessionID

accession = AccessionID(dbtype='sqlite', dbname='my_taxonomy.sqlite')
my_accessions = ['X17276', 'Z12029']

# Returns a generator of (accession, taxid) tuples
for acc, tid in accession.taxid(my_accessions):
    print(f"{acc} -> {tid}")
```

### Name to TaxID Mapping
Use `SciName` to find the TaxID associated with a specific organism name.
```python
from taxadb.names import SciName

names = SciName(dbtype='sqlite', dbname='my_taxonomy.sqlite')
tid = names.taxid('Escherichia coli') # Returns 562
```

## Expert Tips
- **Memory Management**: The `accession.taxid()` method returns a generator. When processing millions of accessions, iterate through the generator rather than converting it to a list to keep memory usage low.
- **Environment Variables**: Set `TAXADB_CONFIG` to the path of your `taxadb.ini` file. This allows you to initialize classes like `TaxID()` or `AccessionID()` without arguments, making code more portable across environments.
- **Database Choice**: Use **SQLite** for local, single-user scripts or small-scale analysis. Use **PostgreSQL or MySQL** for shared lab environments or when multiple concurrent processes need to query the taxonomy simultaneously.
- **Cleanup**: After a successful `taxadb create` run, you can delete the `taxadb_data` directory (containing the raw `.dmp` files) to save disk space.



## Subcommands

| Command | Description |
|---------|-------------|
| taxadb_create | build the database |
| taxadb_download | download the files required to create the database |

## Reference documentation
- [Taxadb GitHub Repository](./references/github_com_HadrienG_taxadb.md)
- [Taxadb ReadTheDocs Index](./references/taxadb_readthedocs_io_en_latest_index.html.md)
- [TaxID API Reference](./references/taxadb_readthedocs_io_en_latest_taxadb_taxid.html.md)
- [AccessionID API Reference](./references/taxadb_readthedocs_io_en_latest_taxadb_accessionid.html.md)