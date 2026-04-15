---
name: biosql
description: BioSQL provides a unified relational database schema for storing biological sequences and metadata across different programming frameworks. Use when user asks to initialize a sequence database schema, load NCBI taxonomy data, or set up a cross-platform storage layer for genomic records.
homepage: https://github.com/biosql/biosql
metadata:
  docker_image: "biocontainers/biosql:v1.68dfsg-3-deb-py2_cv1"
---

# biosql

## Overview
BioSQL is a specialized relational database schema designed to provide a unified storage layer for biological sequences and their associated metadata (such as GenBank or SwissProt entries). Its primary value lies in its cross-platform compatibility, allowing different "Bio*" language frameworks to read and write to the same database. This skill provides the necessary patterns for database initialization and the execution of core maintenance scripts.

## Schema Instantiation
To use BioSQL, you must first create a database in your RDBMS of choice and then pipe the appropriate DDL (Data Definition Language) file into your SQL shell.

### MySQL
Ensure you are using the InnoDB engine for transaction support.
```bash
mysql -u [username] -p [database_name] < sql/biosqldb-mysql.sql
```
*Note: For MySQL 8+, ensure the schema handles the `rank` keyword correctly as it is a reserved word.*

### PostgreSQL
```bash
psql -U [username] -d [database_name] -f sql/biosqldb-pg.sql
```

### SQLite
```bash
sqlite3 [database_file].db < sql/biosqldb-sqlite.sql
```

## Loading NCBI Taxonomy
The repository includes a Perl script to populate the taxonomy tables from NCBI's data dumps. This is often a prerequisite for loading sequences that require taxonomic cross-referencing.

1. Download `taxdump.tar.gz` from NCBI FTP.
2. Extract `names.dmp` and `nodes.dmp`.
3. Run the loader:
```bash
perl scripts/load_ncbi_taxonomy.pl --dbname [db_name] --driver [mysql|Pg|SQLite] --dbuser [user] --dbpass [pass] --download
```
*Tip: Use the `--download` flag to let the script fetch the files automatically, or provide the path to local files if already downloaded.*

## Common CLI Patterns
- **Loading Sequences**: While specific to the language framework (e.g., BioPerl's `load_seqdatabase.pl`), the general pattern involves pointing the loader to a directory of GenBank/EMBL files and specifying the BioSQL database details.
- **Environment Proxies**: If running `load_ncbi_taxonomy.pl` behind a firewall, ensure your environment variables (`http_proxy`, `https_proxy`) are set, as the script supports environment-based proxies.

## Expert Tips
- **Engine Selection**: In MySQL, always verify that tables are created as `ENGINE=INNODB`. Older versions of BioSQL used `TYPE=INNODB`, which is deprecated.
- **Primary Keys**: If using SQLAlchemy or other ORMs to interact with BioSQL, ensure your schema version includes explicit primary keys on association tables (like `taxon_name`), as some older versions of the schema lacked them.
- **SQLite Limitations**: SQLite support is newer and primarily utilized by BioPython. If your workflow involves BioPerl or BioJava, prefer PostgreSQL or MySQL for full feature compatibility.

## Reference documentation
- [BioSQL Main README](./references/github_com_biosql_biosql.md)
- [BioSQL Commits (MySQL 8 and Script Updates)](./references/github_com_biosql_biosql_commits_master.md)
- [BioSQL Issues (Script usage and identifiers)](./references/github_com_biosql_biosql_issues.md)