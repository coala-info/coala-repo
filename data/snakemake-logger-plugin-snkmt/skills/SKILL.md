---
name: snakemake-logger-plugin-snkmt
description: This plugin captures Snakemake workflow events and stores execution metadata in a SQLite database for monitoring and auditing. Use when user asks to log workflow events to a database, track job execution history, or provide data for the snkmt dashboard.
homepage: https://github.com/cademirch/snakemake-logger-plugin-snkmt
---


# snakemake-logger-plugin-snkmt

## Overview
The snakemake-logger-plugin-snkmt is a specialized logging extension for the Snakemake workflow management system. It captures workflow events—such as job starts, completions, and errors—and stores them in a SQLite database. This is particularly useful for users who need to monitor complex pipelines over time, maintain an audit trail of executions, or feed data into the snkmt dashboard. Unlike standard Snakemake logging which primarily targets the console, this plugin ensures that execution metadata is preserved in a queryable format.

## Installation and Setup
To use the plugin, it must be installed in the same environment as Snakemake:

```bash
# Via pip
pip install snakemake-logger-plugin-snkmt

# Via Conda/Mamba
conda install -c bioconda snakemake-logger-plugin-snkmt
```

## Command Line Usage
To activate the logger during a Snakemake run, use the `--logger` flag followed by the plugin name `snkmt`.

### Basic Execution
```bash
snakemake --logger snkmt --cores 1
```

### Specifying the Database Path
By default, the plugin will create a database to store logs. You can explicitly define the location of the SQLite database using the plugin-specific option:

```bash
snakemake --logger snkmt --logger-snkmt-db ./path/to/workflow_logs.db --cores all
```

## Expert Tips and Best Practices
- **Dual Logging**: Note that enabling this plugin does not suppress standard Snakemake console output. Logs will continue to be written to `stderr`, allowing you to monitor the live terminal output while the plugin handles the database persistence.
- **Persistent Monitoring**: Use a consistent database path across multiple runs of the same workflow to build a comprehensive execution history. This is essential for the `snkmt` monitoring tool to track performance trends.
- **Environment Management**: If developing or testing the plugin itself, the project uses `pixi`. You can run a demonstration workflow using `pixi run demo` to see the database generation in action.
- **Database Locking**: Since SQLite is used, ensure the database file is stored on a filesystem that supports file locking if running in a high-concurrency or distributed environment.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-logger-plugin-snkmt_overview.md)
- [GitHub Repository README](./references/github_com_cademirch_snakemake-logger-plugin-snkmt.md)