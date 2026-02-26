---
name: grz-db
description: The grz-db tool manages SQL models and migrations to track genomic study submissions across SQLite and PostgreSQL backends. Use when user asks to sync submissions from an inbox, list or inspect submission records, filter submissions by date, or check quality control status.
homepage: https://github.com/BfArM-MVH/grz-tools
---


# grz-db

## Overview

The `grz-db` package provides the foundational data layer for the GRZ toolset, specifically supporting `grz-cli`, `grzctl`, and `grz-watchdog`. It manages SQL models and Alembic migrations to maintain a consistent schema for tracking genomic study submissions. While it functions as a library, its primary operational interface is typically exposed through the `grzctl db` command suite. It supports both SQLite (for local/testing environments) and PostgreSQL (for production internal submission databases).

## Database Management and CLI Patterns

Most database operations are performed via the `grzctl` utility. Use the following patterns to interact with the submission database:

### Submission Synchronization
To update the database with new files arriving in the submission inbox:
- `grzctl db sync-from-inbox`

### Querying Submissions
Use the list and show commands to audit the database state.
- **List submissions**: `grzctl db submission list`
- **Filter by date**: Use `--since <YYYY-MM-DD>` and `--until <YYYY-MM-DD>` to narrow results.
- **Inspect specific submission**: `grzctl db submission show <SUBMISSION_ID>`
- **JSON Output**: Append `--json` to the show command for machine-readable data.

### Quality Control Logic
The database tracks which submissions require further processing:
- **Check QC status**: `grzctl db should-qc` (Determines if a submission meets the criteria for quality control based on its current state and metadata).

## Best Practices

- **Backend Selection**: Ensure the environment is configured for PostgreSQL when working in production environments, as `grz-db` added explicit support for robust relational backends in version 1.2.0.
- **Date Filtering**: When generating reports or auditing, always use the `--since` and `--until` flags to prevent context overflow and improve query performance on large submission tables.
- **State Management**: Use the `sync-from-inbox` command before performing queries to ensure the database reflects the current filesystem state of the GRZ inbox.
- **Schema Updates**: Since `grz-db` handles Alembic migrations, ensure the package is kept up to date with `grz-pydantic-models` to avoid schema mismatches during validation.

## Reference documentation
- [grz-db Overview](./references/anaconda_org_channels_bioconda_packages_grz-db_overview.md)
- [GRZ Tools Monorepo](./references/github_com_BfArM-MVH_grz-tools.md)
- [GRZ Tools Tags and Releases](./references/github_com_BfArM-MVH_grz-tools_tags.md)