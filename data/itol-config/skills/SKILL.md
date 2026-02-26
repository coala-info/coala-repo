---
name: itol-config
description: This tool generates iTOL annotation files by mapping CSV metadata to specific visual styles like color strips, text labels, and matrices. Use when user asks to create iTOL configuration files, map metadata to phylogenetic trees, or generate tree annotation templates from CSV data.
homepage: https://github.com/jodyphelan/itol-config
---


# itol-config

## Overview

The `itol-config` tool simplifies the process of creating annotation files for iTOL. Instead of manually constructing the complex header and data blocks required by iTOL, this tool parses standard CSV files and maps metadata to specific visual styles. It is ideal for researchers who need to project metadata (like geographic origin, antibiotic resistance, or species labels) onto large phylogenetic trees.

## Installation

Install the package directly from the source:

```bash
pip install git+https://github.com/jodyphelan/itol-config.git
```

## CLI Usage Patterns

The primary interface is the `itol-config` command. It generates a separate configuration file for each column in your input CSV (excluding the ID column).

### Basic Command Structure
```bash
itol-config --input <input.csv> --out <prefix> --id <id_column> --type <annotation_type>
```

### Parameters
- `--input`: Path to the CSV file containing your metadata.
- `--out`: Prefix for the generated output files (e.g., `my_tree_annotations`).
- `--id`: The name of the column in the CSV that matches the leaf/node IDs in your tree file.
- `--type`: The iTOL annotation class to generate. Supported types include:
    - `colour_strip`: Creates a colored bar next to the tree leaves.
    - `text_label`: Adds text annotations to the leaves.
    - `matrix`: Creates a multi-column heatmap/matrix.
    - `binary_matrix`: Creates a presence/absence matrix.

### Customizing Colors
By default, the tool assigns colors automatically. To use specific hex codes or color names for categorical values, provide a TOML configuration file:

```bash
itol-config --input data.csv --out out --id SampleID --type colour_strip --colour-conf colors.toml
```

**TOML Format (`colors.toml`):**
```toml
[Column_Name_1]
ValueA = "#FF0000"
ValueB = "blue"

[Column_Name_2]
High = "#00FF00"
Low = "#CCCCCC"
```

## Expert Tips

- **ID Matching**: Ensure the values in your `--id` column match the leaf names in your Newick or Nexus tree file exactly. iTOL is case-sensitive and sensitive to special characters.
- **Batch Processing**: Since the tool generates a file for every column in the CSV, it is often more efficient to create a "master" CSV with all metadata and run the command once per annotation type.
- **Layer Management**: Use the `--out` prefix to keep your workspace organized. For example, using `--out phenotypic_` will result in files like `phenotypic_ColumnName.txt`, which can be dragged and dropped directly into the iTOL web interface.
- **Programmatic Access**: For complex workflows, you can import the writer directly in Python:
  ```python
  from itol_config import get_config_writer
  writer = get_config_writer(config_type="colour_strip", data=my_dict, label="MyLabel")
  writer.write("output_config.txt")
  ```

## Reference documentation
- [Main README and Usage Guide](./references/github_com_jodyphelan_itol-config.md)