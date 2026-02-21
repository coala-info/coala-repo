---
name: auspice
description: Auspice is the visualization engine for the Nextstrain project, designed to render large-scale phylogenetic trees, geographic maps, and genomic entropy panels.
homepage: https://docs.nextstrain.org/projects/auspice/
---

# auspice

## Overview
Auspice is the visualization engine for the Nextstrain project, designed to render large-scale phylogenetic trees, geographic maps, and genomic entropy panels. This skill provides the procedural knowledge required to manage local dataset servers, customize the web interface, and manipulate URL parameters for sharing specific data views.

## Core CLI Patterns

### Running the Visualization Server
The primary command to view datasets locally is `auspice view`.

```bash
# View datasets from a specific directory
auspice view --datasetDir ./datasets

# View datasets and narratives simultaneously
auspice view --datasetDir ./datasets --narrativeDir ./narratives
```

### Building and Development
Use these commands when customizing the look and feel or when installing from source.
- `auspice build`: Rebuilds the client source code bundle. Required after editing source code or to create a customized version.
- `auspice develop`: Launches a local server with hot-reloading for active client-side development.

### Data Conversion
Auspice v2 is backward compatible with v1, but you can explicitly convert older formats:
```bash
auspice convert --input auspice_v1_tree.json --output auspice_v2.json
```

## Dataset Configuration

### Input File Requirements
- **Auspice v2 JSON**: A single file containing both `tree` (nested JSON) and `metadata`.
- **Auspice v1 JSON**: Requires two files: `[prefix]_tree.json` and `[prefix]_meta.json`.
- **Side-by-Side Trees**: Load two datasets for comparison (tanglegrams) by joining paths with a colon:
  `auspice view --datasetDir .` then navigate to `http://localhost:4000/pathogen/v1:pathogen/v2`.

### Drag-and-Drop Metadata
You can add private metadata to a running Auspice instance by dragging CSV/TSV/XLSX files onto the browser.
- **Format**: First column must match the `strain` or `name` in the tree.
- **Special Columns**: 
  - `latitude` / `longitude`: Enables geographic mapping.
  - `[trait]__colour`: Defines specific hex codes for a trait (e.g., `secret__colour`).

## URL Query Parameters for Sharing Views
Auspice encodes the current view state into the URL. Use these keys to programmatically define views:

| Key | Description | Example |
|:---|:---|:---|
| `c` | Color by trait | `?c=author` |
| `m` | X-axis metric | `?m=div` (divergence) or `?m=num_date` |
| `l` | Tree layout | `?l=radial`, `?l=unrooted`, `?l=clock` |
| `d` | Panels to display | `?d=tree,map,entropy` |
| `f_` | Filter by trait | `?f_region=Africa,Asia` |
| `s` | Select specific strain | `?s=Strain_Name` |
| `label` | Zoom to specific node | `?label=clade:20A` |

## Expert Tips
- **Missing Data**: Auspice automatically grays out nodes with values like `unknown`, `nan`, `n/a`, or `?`.
- **Streamtrees**: For massive datasets (>10k tips), use `stream_labels` in the JSON metadata to toggle "Streamtree" mode, which renders clades as density ribbons instead of individual branches.
- **GISAID Integration**: If the dataset JSON contains GISAID data provenance, Auspice automatically enables specialized acknowledgment tables and links to GISAID EPI ISL records.

## Reference documentation
- [How to Run Auspice](./references/docs_nextstrain_org_projects_auspice_en_stable_introduction_how-to-run.html.md)
- [View Settings and URL Queries](./references/docs_nextstrain_org_projects_auspice_en_stable_advanced-functionality_view-settings.html.md)
- [Adding Extra Metadata](./references/docs_nextstrain_org_projects_auspice_en_stable_advanced-functionality_drag-drop-csv-tsv.html.md)
- [Streamtrees for Large Data](./references/docs_nextstrain_org_projects_auspice_en_stable_advanced-functionality_streamtrees.html.md)