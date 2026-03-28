---
name: solvebio
description: SolveBio is a unified data platform for storing, indexing, and querying large-scale molecular and clinical life sciences data. Use when user asks to manage vaults and datasets, ingest genomic data, perform server-side aggregations, or harmonize entities across datasets.
homepage: https://github.com/solvebio/solvebio-python
---

# solvebio

## Overview

SolveBio is a unified data platform designed for life sciences R&D. It provides a specialized infrastructure for storing, indexing, and querying large-scale molecular and clinical data. This skill enables the management of "Vaults" (hierarchical storage), "Datasets" (structured, indexed records), and "Beacons" (entity discovery endpoints). Use this skill to programmatically handle genomic data ingestion, schema definition, and high-performance data aggregation.

## Core Workflows

### 1. Dataset Management
Datasets are the primary unit of structured data. They require a full path in the format `<domain>:<vault>:<path>` or `~/path` for personal vaults.

*   **Creation**: Use `Dataset.get_or_create_by_full_path()` to initialize a dataset.
*   **Capacity**: Set `capacity` ('small', 'medium', 'large') at creation. This cannot be changed later.
*   **Fields**: Define schemas using `DatasetField`. While SolveBio detects types automatically, explicit templates prevent data type mismatches.

```python
from solvebio import Dataset
# Create a dataset with a specific capacity
dataset = Dataset.get_or_create_by_full_path('~/my_genomic_data', capacity='medium')
```

### 2. Data Ingestion and Activity
Operations like imports and migrations are asynchronous tasks.

*   **Importing**: Supports JSONL (preferred), CSV, TSV, and Excel.
*   **Monitoring**: Always check the activity status to ensure tasks are complete before querying.
*   **Waiting**: Use `follow=True` in the activity method to block until a dataset is idle.

```python
# Wait for all pending tasks to complete
dataset.activity(follow=True, sleep_seconds=5)
```

### 3. Querying and Aggregations (Facets)
SolveBio uses "facets" to perform server-side statistics and summaries without downloading raw data.

*   **Terms**: Get the most common values (e.g., top mutated genes).
*   **Stats**: Get min, max, avg, and sum for numeric fields.
*   **Histograms**: Bin numeric data (e.g., quality scores or genomic positions).
*   **Nested Aggregations**: Nest facets to see distributions within categories (e.g., age distribution per cancer type).

```python
query = dataset.query()
# Get top 10 genes and their counts
results = query.facets('gene_symbol', limit=10)
```

### 4. Entity Labeling
Entities are special labels (e.g., `gene`, `variant`, `sample`, `literature`) that enable cross-dataset harmonization and specialized explorers.

*   **Labeling**: Assign `entity_type` to a field to enable Beacon discovery and entity-specific filtering.
*   **Harmonization**: Use `entity_ids` expressions to normalize identifiers across different sources.

### 5. Data Migrations and Transformations
Use migrations to move data between datasets or apply `expressions` for real-time transformation.

*   **Expressions**: Powerful Python-like syntax for data cleaning during migration.
*   **Transient Fields**: Use `is_transient=True` for intermediate calculation fields that shouldn't be stored permanently.

## Expert Tips

*   **Storage Classes**: Use `Essential` for mission-critical pipeline data to prevent automatic archiving. Use `Temporary` for scratch data to ensure it archives after 48 hours of inactivity.
*   **Flattening**: Be aware that CSV/Excel exports flatten list fields (e.g., `tags: ["a", "b"]` becomes `tags.0: "a", tags.1: "b"`).
*   **Global Beacons**: For "have we seen this before" queries across the entire organization, use Global Beacons instead of querying individual datasets.



## Subcommands

| Command | Description |
|---------|-------------|
| solvebio create-dataset | Create a new dataset |
| solvebio download | Downloads files from SolveBio. |
| solvebio import | Import files into SolveBio datasets. |
| solvebio login | Log in to SolveBio |
| solvebio logout | Logs out of the SolveBio CLI. |
| solvebio ls | List files and folders in the SolveBio vault |
| solvebio queue | Show the status of tasks in the queue. |
| solvebio shell | Interactive SolveBio shell |
| solvebio tag | Apply tag updates to files, folders, or datasets. |
| solvebio upload | Upload local files or directories to SolveBio. |
| solvebio whoami | Show the current user and their permissions. |

## Reference documentation

- [Datasets Overview](./references/docs_solvebio_com_datasets.md)
- [Creating Datasets](./references/docs_solvebio_com_datasets_creating.md)
- [Aggregating Datasets](./references/docs_solvebio_com_datasets_aggregating.md)
- [Dataset Activity](./references/docs_solvebio_com_datasets_activity.md)
- [Entities](./references/docs_solvebio_com_datasets_entities.md)
- [Beacons](./references/docs_solvebio_com_datasets_beacons.md)