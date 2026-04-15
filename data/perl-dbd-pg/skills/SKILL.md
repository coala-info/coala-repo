---
name: perl-dbd-pg
description: This tool provides the Perl DBI driver for connecting to and interacting with PostgreSQL databases. Use when user asks to connect to a Postgres database from Perl, execute SQL statements, or perform high-performance bulk data loading using the COPY command.
homepage: http://search.cpan.org/dist/DBD-Pg/
metadata:
  docker_image: "quay.io/biocontainers/perl-dbd-pg:3.18.0--pl5321h3a0becb_3"
---

# perl-dbd-pg

## Overview
The `DBD::Pg` driver is the essential bridge between Perl's Database Interface (DBI) and PostgreSQL servers. It allows for efficient database operations, leveraging PostgreSQL-specific optimizations that standard SQL drivers might miss. This skill provides the necessary syntax and procedural patterns for establishing connections, executing statements, and managing data transfers specifically within the Perl/Postgres ecosystem.

## Connection Patterns
To connect to a PostgreSQL database, use the standard DBI `connect` method with the `Pg` designator.

```perl
use DBI;

my $dbh = DBI->connect("dbi:Pg:dbname=$dbname;host=$host;port=$port", $username, $password, {
    AutoCommit => 1,
    RaiseError => 1,
    PrintError => 0,
    pg_enable_utf8 => 1, # Recommended for modern applications
});
```

## High-Performance Data Loading
For bulk inserts, avoid individual `INSERT` statements. Use the PostgreSQL `COPY` command via the driver's built-in support for maximum throughput.

```perl
$dbh->do("COPY my_table (col1, col2) FROM STDIN");
$dbh->pg_putline("val1\tval2\n");
$dbh->pg_putline("val3\tval4\n");
$dbh->pg_endcopy();
```

## Working with Placeholders
Always use placeholders to prevent SQL injection and allow the driver to use server-side prepared statements.

- **Standard:** `$sth = $dbh->prepare("SELECT * FROM users WHERE id = ?");`
- **Named (Postgres style):** `$sth = $dbh->prepare("SELECT * FROM users WHERE id = :userid");`

## Expert Tips
- **Data Types:** `DBD::Pg` can map complex Postgres types (arrays, JSONB, geometric types) to Perl scalars or references. Use `pg_type` attributes if you need to force specific OID mapping.
- **Asynchronous Queries:** Use the `pg_async` attribute in `do()` or `execute()` to run queries in the background, then check `pg_ready` to see if results are available.
- **Server-Side Preparations:** By default, `DBD::Pg` prepares statements on the server after a certain threshold of executions. Adjust `pg_prepare_now` if you want immediate server-side preparation.
- **Transaction Handling:** When `AutoCommit` is 0, always ensure a `commit` or `rollback` is called to prevent "idle in transaction" locks on the Postgres server.

## Reference documentation
- [DBD::Pg - PostgreSQL driver for the DBI module](./references/metacpan_org_release_DBD-Pg.md)
- [Bioconda perl-dbd-pg Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-dbd-pg_overview.md)