---
name: pandas
description: Pandas provides high-performance data structures and tools for manipulating, cleaning, and analyzing relational or labeled datasets in Python. Use when user asks to load data from various formats, handle missing values, transform dataframes, or perform complex data aggregations and merges.
homepage: https://github.com/pandas-dev/pandas
---


# pandas

## Overview

Pandas is the foundational Python library for data science, providing high-performance, easy-to-use data structures like the DataFrame and Series. It is designed to handle "relational" or "labeled" data intuitively. Use this skill to transform raw, messy datasets into structured formats through alignment, slicing, and reshaping. It excels at handling missing data, merging disparate datasets, and performing complex "split-apply-combine" operations.

## Installation and Environment

To use pandas, ensure it is installed in your Python environment.

- **Conda (Recommended for data science)**: `conda install -c conda-forge pandas`
- **PyPI**: `pip install pandas`
- **Verification**: Check the installed version and dependencies via Python:
  ```python
  import pandas as pd
  print(pd.__version__)
  pd.show_versions()
  ```

## Core Best Practices

### 1. Vectorization Over Looping
Never iterate over a DataFrame using `for` loops or `iterrows()` if a vectorized solution exists. Vectorized operations in pandas are implemented in C and are orders of magnitude faster.
- **Bad**: `for i, row in df.iterrows(): df.at[i, 'total'] = row['a'] + row['b']`
- **Good**: `df['total'] = df['a'] + df['b']`

### 2. Memory Optimization
For large datasets, default data types (dtypes) are often inefficient.
- **Downcast Numerics**: Use `pd.to_numeric(df['col'], downcast='integer')`.
- **Categoricals**: Convert low-cardinality string columns to the `category` dtype to save memory and speed up operations.
- **Load only needed columns**: Use the `usecols` parameter in `read_csv` or `read_parquet`.

### 3. Handling Missing Data
Pandas uses `NaN` (Not a Number), `NA`, or `NaT` (for timestamps) to represent missing values.
- **Detection**: `df.isna()` or `df.isnull()`.
- **Removal**: `df.dropna(subset=['important_column'])`.
- **Imputation**: `df.fillna(value)` or `df.ffill()` / `df.bfill()`.

### 4. Avoiding SettingWithCopyWarning
This warning occurs when you try to modify a slice of a DataFrame that might be a view or a copy.
- **Rule**: Use `.loc[row_indexer, col_indexer]` for assignment instead of chained indexing like `df[df['a'] > 1]['b'] = 5`.
- **Explicit Copy**: If you need a standalone slice, use `df_sub = df[df['a'] > 1].copy()`.

### 5. Efficient I/O
- **Parquet/HDF5**: For large datasets, use `df.to_parquet()` or `df.to_hdf()` instead of CSV. These formats preserve dtypes and offer significantly faster read/write speeds.
- **Chunking**: For files larger than RAM, use the `chunksize` parameter in `read_csv` to process the data in segments.

## Expert Tips

- **Method Chaining**: Wrap your data processing in parentheses to chain methods together for cleaner, more readable code.
  ```python
  df_clean = (df
      .query('age > 18')
      .assign(full_name = lambda x: x['first'] + ' ' + x['last'])
      .groupby('city')
      .agg({'salary': 'mean'})
  )
  ```
- **Query and Eval**: Use `df.query("column > 10")` for more readable filtering. Note that `query()` and `eval()` do not provide a security boundary against untrusted input.
- **Explode**: Use `df.explode('column_with_lists')` to transform list-like entries into separate rows.
- **Styling**: For presentation in Jupyter, use `df.style.background_gradient()` or `df.style.highlight_max()`.

## Reference documentation

- [pandas: A Powerful Python Data Analysis Toolkit](./references/github_com_pandas-dev_pandas.md)
- [pandas Security Policy](./references/github_com_pandas-dev_pandas_security.md)