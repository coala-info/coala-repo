---
name: data_hacks
description: Data_hacks provides a suite of command-line utilities for performing quick statistical analysis and generating ASCII visualizations from data streams. Use when user asks to generate histograms, create bar charts, calculate the 95th percentile, or sample data directly in the terminal.
homepage: https://github.com/bitly/data_hacks
---


# data_hacks

## Overview

`data_hacks` is a suite of lightweight Python utilities designed for "quick and dirty" data analysis directly in the terminal. It excels at transforming raw streams of data—such as access logs, sensor readings, or database exports—into meaningful statistical summaries and ASCII visualizations. Use this skill to avoid the overhead of heavy data science environments when you need immediate insights from the shell.

## Core Utilities and Usage Patterns

### 1. histogram.py
Generates a text-based histogram from a stream of data points.

*   **Basic usage**: `cat data.txt | histogram.py`
*   **Logarithmic scale**: Use `-l` for data with a wide range of values.
*   **Bounds**: Use `--min` and `--max` to ignore outliers and focus on a specific range.
*   **Percentages**: Add `--percentage` to see the relative distribution of each bucket.
*   **Pre-aggregated data**: If your data is already counted (e.g., from `uniq -c`), use `-a` (count then value) or `-A` (value then count).

### 2. bar_chart.py
Visualizes categorical data or pre-aggregated counts as an ASCII bar chart.

*   **Standard pipe**: `sort data.txt | uniq -c | bar_chart.py -a`
*   **Sorting**: It is often best to sort your data before piping to `bar_chart.py` to ensure the visualization is readable.

### 3. ninety_five_percent.py
Calculates the 95th percentile from a stream of numbers. This is the industry standard for analyzing latency and response times.

*   **Example**: `awk '{print $NF}' access.log | ninety_five_percent.py` (assuming response time is the last column).

### 4. sample.py
Filters a stream to a random sub-sample, useful for processing massive logs that would otherwise overwhelm analysis tools.

*   **Usage**: `cat large_file.log | sample.py 10%`

### 5. run_for.py
Passes data through for a specific duration and then stops. Useful for "spot-checking" live streams.

*   **Usage**: `tail -f live_stream.log | run_for.py 30s | histogram.py`

## Expert Tips

*   **Unix Philosophy**: Always combine these tools with standard utilities like `awk`, `sed`, `grep`, and `cut` to isolate the numeric or categorical columns you want to analyze.
*   **Performance**: For extremely large files, use `sample.py` early in the pipeline to reduce the workload for downstream visualization scripts.
*   **Database Integration**: You can pipe results directly from CLI database clients (like `mysql` or `psql`) into `bar_chart.py -a` to visualize query results without leaving the terminal.
*   **Discovery**: Every script supports the `--help` flag. If a specific formatting or scaling option is needed, check the help output for the specific utility.

## Reference documentation
- [bitly/data_hacks README](./references/github_com_bitly_data_hacks.md)
- [data_hacks source tree](./references/github_com_bitly_data_hacks_tree_master_data_hacks.md)