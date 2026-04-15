---
name: polars
description: Polars is a high-performance analytical query engine designed for efficient data processing and manipulation of large datasets. Use when user asks to process large datasets, optimize data pipelines with lazy execution, perform fast analytical queries, or handle data that exceeds memory limits using streaming.
homepage: https://github.com/pola-rs/polars
metadata:
  docker_image: "quay.io/biocontainers/polars:0.18.15"
---

# polars

## Overview
Polars is a blazingly fast analytical query engine designed for efficient data processing. It excels at handling large datasets that exceed memory limits through its streaming capabilities and provides a powerful expression API that optimizes queries before execution. Use this skill to implement data pipelines that require high throughput, low memory overhead, and parallel execution.

## Installation and Setup
Choose the appropriate installation based on your hardware and data requirements:

- **Standard**: `pip install polars`
- **Large Datasets (>4.2 billion rows)**: `pip install polars[rt64]` (enables 64-bit indexing).
- **Legacy Hardware**: `pip install polars[rtcompat]` (for CPUs without AVX support).
- **Verification**: Use `pl.show_versions()` to check the current version and optional dependencies.

## Core Paradigms

### Lazy vs. Eager Execution
- **Eager**: Operations are executed immediately. Use for interactive exploration on small datasets.
- **Lazy**: Operations are queued into a query plan. Polars optimizes the plan (predicate pushdown, projection pushdown) before execution. Always prefer Lazy for production pipelines.
  - Start a lazy query with `.lazy()` or by using `scan_*` methods (e.g., `scan_parquet`, `scan_csv`).
  - Execute the plan with `.collect()`.

### Streaming Engine
For datasets that do not fit in RAM, use the streaming engine to process data in "morsels":
```python
df.lazy().filter(...).group_by(...).collect(engine='streaming')
```

## Performance Best Practices
- **Prefer Expressions over UDFs**: Avoid using `.map_elements()` or `.map_batches()` with Python functions. Use the native Polars Expression API (e.g., `pl.col("a").sum()`) to stay in the fast Rust/SIMD layer.
- **Scan, Don't Read**: Use `pl.scan_parquet()` or `pl.scan_csv()` instead of `read_*` to allow Polars to only load necessary columns and rows from disk.
- **Schema Handling**: Explicitly define schemas when scanning CSVs to avoid expensive type inference.
- **Memory Management**: If encountering memory issues, check `POLARS_IDEAL_MORSEL_SIZE` or use `pl.Config.reload_env_vars()` to adjust runtime behavior.

## Expert Tips
- **SQL Interface**: Polars supports SQL queries directly on DataFrames and LazyFrames using `pl.SQLContext()`.
- **Fast Joins**: Polars is highly optimized for joins. For time-series data, use `join_asof` for "nearest" match joins.
- **Categorical Data**: Use `pl.Categorical` for string columns with low cardinality to reduce memory usage and speed up joins/group-bys.

## Reference documentation
- [Polars README](./references/github_com_pola-rs_polars.md)
- [Security Policy](./references/github_com_pola-rs_polars_security.md)