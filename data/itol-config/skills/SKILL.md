---
name: itol-config
description: This tool converts CSV datasets into configuration files for iTOL phylogenetic tree annotations. Use when user asks to generate iTOL annotation templates, create color strips for tree nodes, or map metadata onto a phylogenetic tree.
homepage: https://github.com/jodyphelan/itol-config
---


# itol-config

## Overview

The `itol-config` tool simplifies the process of preparing metadata for iTOL tree visualizations. Instead of manually constructing complex, tab-delimited configuration files required by the iTOL web interface, this tool converts standard CSV datasets into valid iTOL annotation templates. It is particularly useful for high-throughput genomic studies where multiple metadata columns (like geographic origin, host, or resistance markers) need to be mapped onto a phylogenetic tree.

## CLI Usage Patterns

The primary interface is the `itol-config` command. It processes an input CSV and generates one configuration file per data column.

### Basic Command Structure
```bash
itol-config --input metadata.csv --out output_prefix --id Sample_ID --type colour_strip
```

### Key Arguments
- `--input`: Path to your source CSV file.
- `--id`: The column name in your CSV that matches the leaf/node IDs in your phylogenetic tree.
- `--type`: The iTOL annotation format to generate. Currently supported:
    - `colour_strip`: Creates a colored strip outside the tree.
    - `text_label`: Adds text annotations to specific nodes.
- `--out`: Prefix for the resulting `.txt` files.

## Advanced Configuration

### Custom Color Mapping
By default, the tool assigns colors automatically. To enforce a specific color scheme, use a TOML configuration file with the `--colour-conf` flag.

**Example `colors.toml`:**
```toml
[Country]
UK = "#ff0000"
USA = "#0000ff"
France = "#00ff00"

[Status]
Resistant = "red"
Sensitive = "green"
```

**Command with colors:**
```bash
itol-config --input data.csv --id id --type colour_strip --colour-conf colors.toml --out my_tree
```

## Python API Integration

For custom workflows or dynamic data generation, use the `get_config_writer` factory function.

```python
from itol_config import get_config_writer

# Data must be a dictionary: { 'node_id': 'value' }
data_map = {"Node_1": "Group_A", "Node_2": "Group_B"}

writer = get_config_writer(
    config_type="colour_strip",
    data=data_map,
    label="My_Metadata_Layer"
)

writer.write("itol_annotation_layer.txt")
```

## Expert Tips
- **ID Matching**: Ensure the values in your `--id` column exactly match the labels in your Newick/Nexus tree file. iTOL is case-sensitive and sensitive to hidden whitespace.
- **Annotation Types**: If you need to display categorical data (like lineage), `colour_strip` is usually the most readable. Use `text_label` sparingly to avoid cluttering the tree visualization.
- **Batch Processing**: The CLI generates a separate file for every column in the CSV (excluding the ID column). This allows you to drag and drop multiple layers into iTOL simultaneously to build complex visualizations.



## Subcommands

| Command | Description |
|---------|-------------|
| colour_strip | Generates an iTOL configuration file for colouring tree branches based on sequence metadata. |
| itol_config | Configuration tool for ITOL |
| itol_config | Configuration tool for ITOL |
| itol_config binary_data | Generates an iTOL configuration file for binary data from a CSV input. |
| itol_config text_label | Generates an iTOL text label configuration file from a CSV file. |

## Reference documentation
- [itol-config README](./references/github_com_jodyphelan_itol-config_blob_main_README.md)