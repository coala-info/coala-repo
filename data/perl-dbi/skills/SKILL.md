---
name: perl-dbi
description: Perl DBI provides a database-independent interface for connecting Perl applications to various database management systems. Use when user asks to connect to a database, execute SQL queries, fetch result sets, or manage database transactions in Perl.
homepage: http://dbi.perl.org/
---


# perl-dbi

## Overview
The Perl DBI (Database Interface) acts as an abstraction layer between Perl code and underlying database management systems. By using DBI, you can write database-intensive applications that are portable across different database engines without rewriting the core logic. This skill provides the standard patterns for establishing connections, executing SQL statements, and handling result sets efficiently.

## Core Usage Patterns

### 1. Establishing a Connection
Always use the `DBI->connect` method with a Data Source Name (DSN).
```perl
use DBI;

my $dsn = "DBI:mysql:database=$db_name;host=$host";
my $dbh = DBI->connect($dsn, $username, $password, {
    RaiseError => 1,
    AutoCommit => 1,
    PrintErr   => 0,
}) or die $DBI::errstr;
```

### 2. Executing Queries
*   **Non-SELECT (INSERT/UPDATE/DELETE):** Use `do()` for simple statements.
    ```perl
    $dbh->do("INSERT INTO users (name) VALUES (?)", undef, $name);
    ```
*   **SELECT (Fetching Data):** Use `prepare` and `execute` with placeholders to prevent SQL injection.
    ```perl
    my $sth = $dbh->prepare("SELECT id, name FROM users WHERE status = ?");
    $sth->execute("active");

    while (my $row = $sth->fetchrow_hashref) {
        print "ID: $row->{id}, Name: $row->{name}\n";
    }
    ```

### 3. Efficient Data Fetching
For large datasets, use `selectall_arrayref` or `selectcol_arrayref` for concise code:
```perl
# Fetch all rows as an array of hashrefs
my $users = $dbh->selectall_arrayref("SELECT * FROM users", { Slice => {} });
```

## Best Practices
*   **Placeholders:** Always use `?` placeholders. Never interpolate variables directly into SQL strings to avoid SQL injection.
*   **Error Handling:** Enable `RaiseError => 1` in the connection attributes to use `eval` or `Try::Tiny` for exception handling instead of checking every return value.
*   **Statement Handle Cleanup:** Explicitly call `$sth->finish()` if you stop fetching rows before the end of a result set, though it is usually handled automatically on destruction.
*   **Transactions:** For atomic operations, set `AutoCommit => 0`, perform your work, and call `$dbh->commit()`. Use `$dbh->rollback()` in your error handler.

## Installation via Bioconda
If working within a Conda/Bioinformatics environment:
```bash
conda install bioconda::perl-dbi
```

## Reference documentation
- [Perl DBI Home](./references/dbi_perl_org_index.md)
- [Bioconda perl-dbi Overview](./references/anaconda_org_channels_bioconda_packages_perl-dbi_overview.md)