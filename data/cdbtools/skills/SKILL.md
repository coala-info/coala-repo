---
name: cdbtools
description: "cdbtools provides utilities for creating, querying, and dumping high-performance constant databases. Use when user asks to create a database from structured text, retrieve values by key with support for duplicates, or deconstruct a database into a portable format."
homepage: https://github.com/philpennock/cdbtools
---


# cdbtools

## Overview

`cdbtools` is a collection of Go-based utilities that replicate the functionality of Daniel J. Bernstein's original Constant Database (CDB) tools. CDB is designed for high-performance, read-only lookups where the database is created once and queried many times. This skill provides the procedural knowledge to build databases from structured text, retrieve specific records with support for duplicate keys, and deconstruct existing databases into a portable format.

## Command Line Usage

### Creating a Database (cdbmake)
`cdbmake` creates a database from a specifically formatted input stream. It requires a temporary file to ensure the final database is created atomically.

**Pattern:**
`cdbmake <output_file> <temp_file>`

**Input Format:**
The input must follow the standard CDB format: `+klen,vlen:key->value` followed by a newline. The input stream must end with an additional empty newline.

**Example:**
```bash
# Create a database mapping usernames to IDs
echo "+4,2:user->10" | cdbmake users.cdb users.tmp
```

### Retrieving Values (cdbget)
`cdbget` searches for a key in a CDB file and prints the associated value to stdout.

**Pattern:**
`cdbget <key> [skip_count] < <database_file>`

**Key Features:**
- **Skip Count:** If multiple records exist for the same key, provide a numeric `skip_count` to skip the first *n* instances and print the value of the next matching record.
- **Exit Codes:** 
  - `0`: Success (key found).
  - `100`: Key not found.
  - `111`: Error (e.g., file not found or corrupted).

### Inspecting Databases (cdbdump)
`cdbdump` converts the entire contents of a CDB file back into the `+klen,vlen:key->value` format, making it easy to pipe into another `cdbmake` command or inspect via text tools.

**Pattern:**
`cdbdump < <database_file>`

## Expert Tips and Best Practices

- **Atomic Updates:** Always use `cdbmake` with a temporary file on the same filesystem as the target database. This allows the tool to use `rename()`, ensuring that readers never see a partially written database.
- **Handling Duplicate Keys:** Unlike many key-value stores, CDB supports multiple records for the same key. Use the `skip_count` parameter in `cdbget` to iterate through these values.
- **Shell Integration:** Since `cdbtools` reads from stdin and writes to stdout, they are ideal for pipeline processing. For example, you can use `cdbdump` piped through `grep` to filter a database before rebuilding it with `cdbmake`.
- **Binary Safety:** CDB is binary-safe. Keys and values can contain any byte sequence, including null bytes, though the `cdbtools` implementation in Go may have specific behaviors regarding non-string byte sequences during output.

## Reference documentation

- [cdbtools README](./references/github_com_phil_pennock_cdbtools_blob_main_README.md)