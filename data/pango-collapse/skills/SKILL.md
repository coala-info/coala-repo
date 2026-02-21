---
name: pango-collapse
description: pango-collapse is a bioinformatics utility designed to map granular SARS-CoV-2 sublineages back to their ancestral "parent" lineages.
homepage: https://github.com/MDU-PHL/pango-collapse
---

# pango-collapse

## Overview
pango-collapse is a bioinformatics utility designed to map granular SARS-CoV-2 sublineages back to their ancestral "parent" lineages. This tool is essential for epidemiological reporting where tracking every minor sub-variant is less important than monitoring major groups (e.g., collapsing all BA.5 sub-variants into a single "BA.5" category). It transforms standard lineage CSVs by adding uncompressed, expanded, and collapsed "family" columns, making genomic data significantly easier to query and visualize.

## Installation
Install via pip or conda:
- `pip install pango-collapse`
- `conda install -c bioconda pango-collapse`

## Core CLI Usage

### Basic Collapsing
To collapse lineages based on a specific list of parents:
```bash
pango-collapse input.csv -p BA.5 -p BQ.1 -o output.csv
```

### Using a Collapse File
Instead of passing multiple `-p` flags, use a text file containing one parent lineage per line:
```bash
pango-collapse input.csv --collapse-file lineages_to_track.txt -o output.csv
```

### Processing Nextclade Outputs
Nextclade uses a specific column name for lineages. Use the `-l` flag to target it:
```bash
pango-collapse nextclade.tsv -l Nextclade_pango -c collapse.txt -o collapsed_results.tsv
```

### Strict Mode
Use `--strict` to filter your output. In strict mode, if a lineage cannot be collapsed into one of your defined parents, the `Lineage_family` column will be left empty rather than falling back to the original lineage.
```bash
pango-collapse input.csv -c voc_list.txt --strict -o strict_report.csv
```

## Expert Tips and Best Practices

### Remote Collapse Files
You can point directly to a URL (like a GitHub raw file) for the `--collapse-file`. This allows pipelines to stay updated with the latest Variant of Concern (VOC) definitions without local file changes:
```bash
pango-collapse input.csv -c https://raw.githubusercontent.com/AusTrakka/VOC-watch/master/collapse_files/cdc.txt -o cdc_report.csv
```

### Handling Recombinants
The tool recognizes a special `Recombinant` keyword. Including this in your collapse list will group all recombinant lineages (XBB, XBF, etc.) into a single "Recombinant" category.

### Understanding Expanded Format
The `Lineage_expanded` column uses a colon (`:`) delimiter to show the hierarchy (e.g., `B.1.1.529:BA.5.3.1:BE.1`). 
- To find all sub-lineages of a parent in the output, use grep on the expanded column: `grep ":BA.5" output.csv`.
- To get the full uncompressed dot-notation, refer to the `Lineage_full` column.

### Updating Data
Use the `--latest` flag to ensure the tool uses the most recent alias data from the Pango designations GitHub repository at runtime.

## Reference documentation
- [github_com_MDU-PHL_pango-collapse.md](./references/github_com_MDU-PHL_pango-collapse.md)
- [anaconda_org_channels_bioconda_packages_pango-collapse_overview.md](./references/anaconda_org_channels_bioconda_packages_pango-collapse_overview.md)