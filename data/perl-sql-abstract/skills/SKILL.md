---
name: perl-sql-abstract
description: This tool generates SQL statements from Perl data structures. Use when user asks to generate SQL queries from Perl hashes, build complex WHERE clauses, or create INSERT, UPDATE, and DELETE statements programmatically.
homepage: http://metacpan.org/pod/SQL-Abstract
---


# perl-sql-abstract

## Overview
The `perl-sql-abstract` skill provides a programmatic way to translate Perl nested data structures into syntactically correct SQL statements. Instead of manual string concatenation, which is prone to errors and SQL injection, this tool abstracts the query generation process. It allows for the creation of complex, portable queries where the logic is defined by Perl hashes (for equality/AND logic) and arrays (for OR logic).

## Core Usage Patterns

### Initializing the Object
```perl
use SQL::Abstract;
my $sql = SQL::Abstract->new;
```

### Generating SELECT Statements
To generate a query, pass the table name, an arrayref of columns, and a hashref for the WHERE clause.
```perl
# Returns ($stmt, @bind)
my ($stmt, @bind) = $sql->select($table, \@fields, \%where, \@order);
```

### Complex WHERE Clauses
*   **AND Logic (Hashref):** `{ status => 'active', type => 'admin' }` becomes `WHERE status = ? AND type = ?`.
*   **OR Logic (Arrayref):** `[ { status => 'open' }, { status => 'pending' } ]` becomes `WHERE status = ? OR status = ?`.
*   **Operators:** Use hashrefs with operator keys: `age => { '>=', 21 }` becomes `age >= ?`.
*   **IN Clauses:** Pass an arrayref as a value: `status => [ 'open', 'closed' ]` becomes `status IN (?, ?)`.
*   **Between:** `date => { -between => [ '2023-01-01', '2023-12-31' ] }`.

### Data Manipulation (INSERT/UPDATE)
*   **INSERT:** `my ($stmt, @bind) = $sql->insert($table, \%field_values);`
*   **UPDATE:** `my ($stmt, @bind) = $sql->update($table, \%field_values, \%where);`
*   **DELETE:** `my ($stmt, @bind) = $sql->delete($table, \%where);`

## Expert Tips
*   **Literal SQL:** If you need to bypass the abstraction for a specific clause, use a scalar reference: `where => { date => \'> NOW()' }`.
*   **Consistency:** Always use the returned `@bind` values with your database handle (`$dbh->prepare($stmt); $sth->execute(@bind);`) to prevent SQL injection.
*   **Case Sensitivity:** By default, `SQL::Abstract` quotes identifiers based on the driver configuration. Use the `quote_char` and `name_sep` options in `new()` if working with reserved words or specific schemas.

## Reference documentation
- [SQL::Abstract Documentation](./references/metacpan_org_pod_SQL-Abstract.md)