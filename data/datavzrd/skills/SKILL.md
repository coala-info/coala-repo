---
name: datavzrd
description: datavzrd creates visual and interactive standalone HTML reports from collections of CSV/TSV tables. Use when user asks to generate interactive data visualizations and reports from tabular data, especially when automatic histogram generation, plot customization, and inter-table linking are desired.
homepage: https://github.com/datavzrd/datavzrd
metadata:
  docker_image: "quay.io/biocontainers/datavzrd:2.23.2"
---

# datavzrd

datavzrd/SKILL.md
```yaml
name: datavzrd
description: A tool to create visual and interactive standalone HTML reports from collections of CSV/TSV tables. Use when Claude needs to generate interactive data visualizations and reports from tabular data, especially when automatic histogram generation, plot customization, and inter-table linking are desired.
```
## Overview
datavzrd is a command-line tool designed to transform your CSV, TSV, JSON, or Parquet files into visually appealing, interactive, and standalone HTML reports. It automatically generates vega-lite histograms for each column and allows for extensive customization of plots and inter-table linking through a configuration file.

## Usage Instructions

datavzrd is primarily used via its command-line interface. The core functionality involves specifying input data files and an optional configuration file to generate an HTML report.

### Basic Command Structure

The fundamental command to generate a report is:

```bash
datavzrd --input <input_files> --output <output_html_file> [--config <config_file>]
```

### Key Arguments

*   `--input` or `-i`: Specifies the input data file(s). This can be a single CSV, TSV, JSON, or Parquet file, or a comma-separated list of files.
    *   Example: `-i data.csv`
    *   Example: `-i table1.tsv,table2.csv`
*   `--output` or `-o`: Specifies the name of the output HTML report file.
    *   Example: `-o my_report.html`
*   `--config` or `-c`: Specifies a configuration file (YAML format) for customizing plots, linkouts, and inter-table linking.
    *   Example: `-c config.yaml`

### Common Patterns and Tips

1.  **Generating a Simple Report:**
    To create a basic HTML report from a single CSV file with default settings:
    ```bash
    datavzrd -i my_data.csv -o report.html
    ```

2.  **Using Multiple Data Files:**
    If you have multiple related tables, you can include them all. datavzrd can handle linking between them if configured.
    ```bash
    datavzrd -i sales.csv -i customers.tsv -o sales_report.html
    ```

3.  **Customizing Plots with a Configuration File:**
    For advanced customization, create a `config.yaml` file. This file can define plot types, colors, axes, and more. Refer to the datavzrd documentation for the full schema.
    ```bash
    datavzrd -i data.csv -o custom_report.html -c my_plot_config.yaml
    ```

4.  **Enabling Inter-Table Linking:**
    Within the `config.yaml`, you can define relationships between tables. For example, linking a `users.csv` table to a `orders.csv` table based on a common `user_id` column. The exact syntax for defining these links is detailed in the datavzrd documentation.

5.  **Automatic Histograms:**
    By default, datavzrd generates vega-lite histograms for each column in your input data. These are automatically included in the report.

6.  **Linkouts:**
    The configuration file allows you to specify URLs that can be linked to from within the report, for example, linking a product ID to an external product page.

### Expert Tips

*   **File Formats:** datavzrd supports CSV, TSV, JSON, and Parquet. Ensure your data is clean and correctly formatted for the best results.
*   **Configuration File:** Invest time in understanding the `config.yaml` structure. It's the key to unlocking the full potential of datavzrd for creating sophisticated and interactive reports.
*   **Standalone HTML:** The generated HTML reports are standalone, meaning they do not require external dependencies to be viewed in a web browser.

## Reference documentation
- [datavzrd GitHub Repository](./references/github_com_datavzrd_datavzrd.md)