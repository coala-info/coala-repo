---
name: perl-uri-db
description: This tool parses, normalizes, and converts database-specific URIs into driver-compatible connection strings. Use when user asks to parse database connection strings, convert URIs to DBI DSNs, or handle database-specific URI metadata for engines like PostgreSQL and SQLite.
homepage: https://search.cpan.org/dist/URI-db/
---


# perl-uri-db

## Overview
This skill provides a specialized interface for handling database-specific URIs. While standard URIs follow generic rules, database URIs often require specific parsing for engines like PostgreSQL, MySQL, SQLite, and Oracle. This tool ensures that connection strings are RFC-compliant while maintaining the metadata required by database drivers (DBI). It is essential for applications that need to abstract database connection logic or dynamically generate connection strings from environment variables.

## Usage Patterns

### Parsing Database URIs
To decompose a connection string into its constituent parts:
```perl
use URI::db;
my $u = URI::db->new('db:pg://postgres:password@localhost:5432/my_db');

print $u->engine;   # pg
print $u->dbname;   # my_db
print $u->host;     # localhost
print $u->port;     # 5432
```

### Converting to DBI DSNs
The primary utility of this tool is converting a portable URI into a driver-specific Data Source Name (DSN) used by Perl's DBI:
```perl
my $dsn = $u->dbi_dsn; 
# Result: dbi:Pg:dbname=my_db;host=localhost;port=5432
```

### Handling SQLite (File-based)
SQLite URIs require specific handling for paths:
- Memory: `db:sqlite:memory` or `db:sqlite:///:memory:`
- Relative path: `db:sqlite:path/to/db.sqlite`
- Absolute path: `db:sqlite:///var/lib/db.sqlite`

### Functional Best Practices
- **Scheme Prefixing**: Always ensure the URI starts with the `db:` prefix to trigger the `URI::db` logic rather than standard `URI`.
- **Engine Mapping**: Use the `engine` method to identify the database type (e.g., `pg`, `mysql`, `sqlite`, `oracle`) before passing parameters to database-specific logic.
- **Canonicalization**: Use `$u->canonical` to normalize URIs (e.g., lowercase hosts, removing default ports) before storing them in configuration files or databases.

## Reference documentation
- [URI::db on MetaCPAN](./references/metacpan_org_release_URI-db.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-uri-db_overview.md)