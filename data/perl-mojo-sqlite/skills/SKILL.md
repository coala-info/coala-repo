---
name: perl-mojo-sqlite
description: Mojo::SQLite is a minimal wrapper around DBD::SQLite that provides a streamlined interface for SQL execution and schema migrations within the Mojolicious ecosystem. Use when user asks to manage SQLite databases, perform CRUD operations using Perl data structures, or handle database migrations and connection pooling.
homepage: https://github.com/Grinnz/Mojo-SQLite
---


# perl-mojo-sqlite

## Overview
Mojo::SQLite is a minimal yet powerful wrapper around DBD::SQLite designed for the Mojolicious ecosystem. It provides a streamlined interface for executing SQL, managing database schemas through a built-in migration system, and performing programmatic CRUD operations. It handles connection pooling and forking safely, making it suitable for both simple scripts and complex web applications.

## Installation
Install the package via Bioconda:
```bash
conda install bioconda::perl-mojo-sqlite
```

## Core Usage Patterns

### Database Connection
Initialize a connection using a DSN or a filename. By default, it uses a temporary database if no path is provided.
```perl
use Mojo::SQLite;

# File-based database
my $sql = Mojo::SQLite->new('sqlite:test.db');

# In-memory database (not shared between connections)
my $sql = Mojo::SQLite->new('sqlite::memory:');

# Shared temporary database
my $sql = Mojo::SQLite->new('sqlite::temp:');
```

### Schema Management with Migrations
Use migrations to define and version your database schema. This is the recommended way to handle table creation and updates.
```perl
$sql->migrations->name('my_app')->from_string(<<EOF)->migrate;
-- 1 up
create table users (
  id integer primary key autoincrement,
  name text,
  email text
);
-- 1 down
drop table users;
EOF
```

### Executing Queries
Use the `db` method to get a database handle from the pool and execute queries.
```perl
my $db = $sql->db;

# Standard SQL with placeholders
my $results = $db->query('select * from users where name = ?', 'Alice');

# Fetching results
while (my $next = $results->hash) {
  say $next->{email};
}
```

### Programmatic CRUD (SQL::Abstract)
Mojo::SQLite integrates with SQL::Abstract::Pg to generate queries from Perl data structures.
```perl
# Insert
$db->insert('users', {name => 'Bob', email => 'bob@example.com'});

# Select
my $user = $db->select('users', ['email'], {name => 'Bob'})->hash;

# Update
$db->update('users', {email => 'new_bob@example.com'}, {name => 'Bob'});

# Delete
$db->delete('users', {name => 'Bob'});
```

### Transactions
Transactions are managed using a guard object. If the `$tx` object goes out of scope without `commit` being called, the transaction is automatically rolled back.
```perl
eval {
  my $tx = $db->begin;
  $db->insert('users', {name => 'Charlie'});
  $db->insert('logs', {action => 'added user'});
  $tx->commit;
};
say "Transaction failed: $@" if $@;
```

## Expert Tips and Best Practices

### JSON Support
Mojo::SQLite handles JSON roundtripping automatically when using the `{json => ...}` bind value and the `expand` method on results.
```perl
# Store JSON
$db->query('insert into settings (data) values (?)', {json => {theme => 'dark'}});

# Retrieve and expand JSON
my $theme = $db->query('select data from settings')
               ->expand(json => 'data')
               ->hash->{data}{theme};
```

### Concurrency and WAL Mode
Write-Ahead Logging (WAL) is enabled by default in Mojo::SQLite. This allows multiple readers and one writer to operate concurrently.
- Use `$sql->wal_mode` to check or set the mode.
- Use `$sql->no_wal(1)` if you must prevent WAL mode on new databases (e.g., for network filesystems where WAL is unsupported).

### Handling Forking
Mojo::SQLite is fork-safe. It automatically detects process forks and refreshes the internal database handles to prevent connection sharing issues between parent and child processes.

### Performance
- **Connection Pooling**: Always use `$sql->db` to get a handle. The handles are cached and reused.
- **Pragmas**: Use the `connection` event to set custom SQLite pragmas for every new connection.
  ```perl
  $sql->on(connection => sub ($sql, $dbh) {
    $dbh->do('pragma cache_size=1000');
  });
  ```

## Reference documentation
- [Mojo::SQLite GitHub Repository](./references/github_com_Grinnz_Mojo-SQLite.md)
- [Bioconda perl-mojo-sqlite Overview](./references/anaconda_org_channels_bioconda_packages_perl-mojo-sqlite_overview.md)