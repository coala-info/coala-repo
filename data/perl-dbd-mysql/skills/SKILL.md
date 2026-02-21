---
name: perl-dbd-mysql
description: The `perl-dbd-mysql` skill provides procedural knowledge for implementing the MySQL driver for the Perl5 Database Interface (DBI).
homepage: https://dbi.perl.org
---

# perl-dbd-mysql

## Overview

The `perl-dbd-mysql` skill provides procedural knowledge for implementing the MySQL driver for the Perl5 Database Interface (DBI). This tool acts as the "glue" between Perl scripts and MySQL servers, allowing for transparent database access. Use this skill to establish database connections, execute SQL queries, handle results, and manage database-specific configurations within a Perl environment.

## Installation and Setup

To use this driver, ensure both the base `DBI` module and the `DBD::mysql` driver are installed.

### Bioconda Installation
The preferred method for bioinformatics and data science environments:
```bash
conda install bioconda::perl-dbd-mysql
```

## Core Usage Patterns

### Establishing a Connection
The connection string (Data Source Name or DSN) follows a specific format for MySQL.

```perl
use DBI;

my $database = "target_db";
my $host = "localhost";
my $port = "3306";
my $dsn = "DBI:mysql:database=$database;host=$host;port=$port";
my $userid = "username";
my $password = "password";

# Connect with error handling enabled
my $dbh = DBI->connect($dsn, $userid, $password, {
    RaiseError => 1,
    AutoCommit => 1,
    mysql_enable_utf8 => 1,
}) or die $DBI::errstr;
```

### Executing Queries
Always use placeholders (`?`) to prevent SQL injection and improve performance through statement caching.

```perl
# 1. Prepare the statement
my $sth = $dbh->prepare("SELECT name, email FROM users WHERE status = ?");

# 2. Execute with parameters
$sth->execute("active");

# 3. Fetch results
while (my @row = $sth->fetchrow_array()) {
    print "User: $row[0], Email: $row[1]\n";
}

# 4. Clean up
$sth->finish();
```

### Non-SELECT Operations (INSERT/UPDATE/DELETE)
For simple operations that do not return rows, use the `do` method:
```perl
my $rows_affected = $dbh->do("UPDATE users SET status = ? WHERE id = ?", undef, "inactive", 123);
```

## Expert Tips & Best Practices

- **Error Handling**: Always use `RaiseError => 1` in the connection attributes. This transforms database errors into Perl exceptions (`die`), which are easier to manage than checking return values for every call.
- **UTF-8 Support**: Explicitly set `mysql_enable_utf8 => 1` in the connection attributes to ensure proper handling of multi-byte characters.
- **Connection Persistence**: For long-running scripts, use `$dbh->ping()` to verify the connection is still alive before executing critical queries, as MySQL servers often timeout idle connections.
- **Portability**: Keep SQL standard-compliant where possible. The DBI layer allows you to switch drivers (e.g., to `DBD::Pg` for PostgreSQL) with minimal changes to the Perl logic, provided the SQL syntax is compatible.

## Reference documentation
- [perl-dbd-mysql Overview](./references/anaconda_org_channels_bioconda_packages_perl-dbd-mysql_overview.md)
- [About DBI](./references/dbi_perl_org_about.md)
- [DBI Documentation Guide](./references/dbi_perl_org_docs.md)