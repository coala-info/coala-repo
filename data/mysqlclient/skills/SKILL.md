---
name: mysqlclient
description: mysqlclient is a high-performance Python interface for MySQL and MariaDB that provides a C-extension for database connectivity. Use when user asks to install database drivers, connect to MySQL or MariaDB from Python, or resolve C-extension build errors.
homepage: https://github.com/PyMySQL/mysqlclient-python
metadata:
  docker_image: "quay.io/biocontainers/mysqlclient:1.3.10--py36_0"
---

# mysqlclient

## Overview
mysqlclient is the optimized C-extension interface for MySQL and MariaDB in Python. As a fork of the original MySQLdb1, it provides full Python 3 support and superior performance compared to pure-Python drivers. This skill provides guidance on environment-specific installation, connection management, and critical thread-safety constraints required to build stable database-driven applications.

## Installation and Build Configuration
Because mysqlclient is a C-extension, it requires MySQL/MariaDB development headers to be present on the system before installation via pip.

### System Dependencies
- **Debian/Ubuntu**: `sudo apt-get install python3-dev default-libmysqlclient-dev build-essential pkg-config`
- **Red Hat/CentOS**: `sudo yum install python3-devel mysql-devel pkgconfig`
- **macOS (Homebrew)**: `brew install mysql pkg-config` (or `mysql-client` for client-only headers)

### Customizing the Build
If headers are in non-standard locations, use environment variables to guide the compiler:
```bash
export MYSQLCLIENT_CFLAGS=`pkg-config mysqlclient --cflags`
export MYSQLCLIENT_LDFLAGS=`pkg-config mysqlclient --libs`
pip install mysqlclient
```

## Usage Best Practices

### Basic Connection Pattern
Always use a context manager or ensure connections are closed to prevent leakages.
```python
import MySQLdb

# Connect to the database
db = MySQLdb.connect(
    host="localhost",
    user="user",
    passwd="password",
    db="database_name",
    charset="utf8mb4"
)

try:
    with db.cursor() as cursor:
        cursor.execute("SELECT VERSION()")
        result = cursor.fetchone()
        print(f"Database version: {result}")
finally:
    db.close()
```

### Thread Safety Warning
**CRITICAL**: Do not share a single Connection object across multiple threads simultaneously. While the extension module itself is thread-compatible (and supports free-threading in v2.2.8+), simultaneous operations on the same Connection object result in undefined behavior. 
- **Correct Pattern**: Create a unique Connection object for each thread or use a connection pool.

### Character Sets
Always prefer `charset="utf8mb4"` in your connection parameters to ensure full Unicode support (including emojis and supplementary characters), matching modern MySQL defaults.

## Troubleshooting
- **Windows**: Building from source is complex. Use binary wheels if available. If building from source, the MariaDB C Connector must be installed in the default location or pointed to via the `MYSQLCLIENT_CONNECTOR` environment variable.
- **macOS Linker Errors**: If using `mysql-client` (keg-only), you must explicitly set the `PKG_CONFIG_PATH`:
  `export PKG_CONFIG_PATH="$(brew --prefix)/opt/mysql-client/lib/pkgconfig"`

## Reference documentation
- [GitHub Repository Overview](./references/github_com_PyMySQL_mysqlclient.md)
- [Anaconda/Bioconda Package Info](./references/anaconda_org_channels_bioconda_packages_mysqlclient_overview.md)
- [macOS Installation Wiki](./references/github_com_PyMySQL_mysqlclient_wiki.md)