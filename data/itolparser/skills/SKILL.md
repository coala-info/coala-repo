---
name: itolparser
description: `itolparser` is a specialized utility designed to bridge the gap between raw tabular metadata and the Interactive Tree Of Life (iTOL) visualization platform.
homepage: https://github.com/boasvdp/itolparser
---

# itolparser

---

## Overview
`itolparser` is a specialized utility designed to bridge the gap between raw tabular metadata and the Interactive Tree Of Life (iTOL) visualization platform. It automates the creation of colorstrip annotation files, which are used to display metadata as colored bars next to phylogenetic tree leaves. Instead of manually formatting iTOL templates, this tool parses your data columns, assigns colors, and generates ready-to-upload files.

## Command Line Usage

### Basic Conversion
The simplest usage takes a table (CSV, TSV, or Excel) and generates categorical colorstrips for every column.
```bash
itolparser metadata_table.csv
```

### Handling Continuous Data
By default, all columns are treated as categorical. To map numerical values to a color gradient, specify the column names.
```bash
itolparser metadata_table.csv --continuous "Concentration,GrowthRate"
```

### Filtering High-Cardinality Data
For columns with many unique values (like Sequence Types or Strain IDs), use `--maxcategories` to prevent a cluttered legend.
```bash
itolparser metadata_table.csv --maxcategories 10
```
**Note**: This generates an additional file suffixed with `_filtered` where the top 10 categories are colored and the rest are grouped as "other" in grey.

### Visual Customization
You can set the initial layout parameters for the colorstrips, though these can also be adjusted within the iTOL web interface later.
```bash
itolparser metadata_table.csv --margin 25 --stripwidth 40
```

### Excluding Columns
To prevent specific metadata columns from being processed into annotation files:
```bash
itolparser metadata_table.csv --ignore "Internal_ID,Comments"
```

## Expert Tips
- **Color Logic**: The tool uses a predefined palette for up to 18 categories. If a column exceeds 18 unique values, it switches to random color generation.
- **Excel Support**: Recent versions support `.xlsx` files directly, removing the need to export to CSV/TSV first.
- **Output Directory**: The tool creates a directory containing individual annotation files for each column in your table, making it easy to selectively upload only the metadata you want to visualize.
- **ST Typing**: The `--maxcategories` flag is specifically optimized for MLST (Multi-Locus Sequence Typing) data where a few STs dominate the dataset and the rest are rare.

## Reference documentation
- [itolparser Overview](./references/anaconda_org_channels_bioconda_packages_itolparser_overview.md)
- [itolparser GitHub Repository](./references/github_com_boasvdp_itolparser.md)