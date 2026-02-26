---
name: perl
description: Perl is a high-level programming language used here to run the MySQLTuner script for auditing database health and performance. Use when user asks to analyze database configuration, optimize MySQL or MariaDB performance, and identify security vulnerabilities or memory allocation issues.
homepage: https://github.com/major/MySQLTuner-perl
---


# perl

## Overview
MySQLTuner is a high-utility Perl script designed to provide a rapid overview of a database server's health. It retrieves current configuration variables and status data to suggest adjustments for increased stability and performance. It is particularly effective for identifying issues with InnoDB/MyISAM storage engines, Galera clusters, and memory allocation.

## Execution and Basic Usage
The script requires Perl 5.6 or later and should be run on the same host as the database for the most accurate OS-level metrics.

- **Standard Run**: Execute the script to begin the automated audit.
  ```bash
  perl mysqltuner.pl
  ```
- **Authenticated Run**: Specify credentials if the script cannot access the local socket automatically.
  ```bash
  perl mysqltuner.pl --user root --pass your_password
  ```
- **Manual Memory Override**: Use this if the script incorrectly detects physical RAM (common in containers or virtualized environments).
  ```bash
  perl mysqltuner.pl --forcemem 4096
  ```

## Expert Best Practices
- **Uptime Requirement**: Never run MySQLTuner on a freshly restarted server. For the statistics to be meaningful, the database must have at least 24 hours of continuous uptime.
- **Performance Schema**: For advanced diagnostics (like statement analysis), ensure `performance_schema` is enabled in your `my.cnf`.
  ```ini
  [mysqld]
  performance_schema = ON
  ```
- **Security Auditing**: Pay attention to the "Security Recommendations" section. It identifies weak passwords, anonymous users, and insecure networking configurations.
- **Staging Validation**: Always test recommended changes (e.g., adjusting `innodb_buffer_pool_size` or `query_cache_size`) in a staging environment before applying them to production.
- **CVE Detection**: The script can check for known vulnerabilities if provided with a `vulnerabilities.csv` file in the same directory.

## Common Troubleshooting
- **Connection Failures**: If the script fails to connect, verify the MySQL socket path or use the `--host` and `--port` flags to specify the connection target.
- **OS Metrics**: Root access is recommended to allow the script to read system-level memory and swap usage accurately.
- **MariaDB 11+**: Ensure you are using the latest version of the script to avoid "InnoDB chunk breakdown" calculation errors specific to newer MariaDB versions.

## Reference documentation
- [MySQLTuner README](./references/github_com_major_MySQLTuner-perl.md)
- [Known Issues and Bug Reports](./references/github_com_major_MySQLTuner-perl_issues.md)