---
name: auspice
description: Auspice is an interactive web-based tool for visualizing phylogenomic data through integrated phylogenetic trees, geographic maps, and temporal genomic data. Use when user asks to visualize pathogen evolution, run a local server to view genomic datasets, compare multiple trees side-by-side, or augment visualizations with private metadata.
homepage: https://docs.nextstrain.org/projects/auspice/
metadata:
  docker_image: "quay.io/biocontainers/auspice:2.66.0--h503566f_2"
---

# auspice

## Overview

Auspice is an interactive web-based tool designed for the visualization of phylogenomic data. As the visualization engine for the Nextstrain project, it enables the exploration of pathogen evolution through integrated views of phylogenetic trees, geographic maps, and temporal genomic data. It is highly modular, allowing users to run local servers to view their own datasets, compare multiple trees side-by-side, and enhance visualizations with private metadata without uploading data to a central server.

## Core CLI Usage

The primary way to interact with Auspice locally is through its command-line interface.

### Running a Local Server
To visualize datasets stored on your machine:
```bash
auspice view --datasetDir <path_to_json_files>
```
*   **Default Port**: The server typically runs on `http://localhost:4000`.
*   **Narratives**: To include narratives (guided tours of data), add `--narrativeDir <path_to_narratives>`.

### Installation
Auspice can be installed via npm or Conda:
```bash
npm install --global auspice
# OR
conda install -c bioconda auspice
```

## Advanced Visualization Patterns

### Tanglegrams (Side-by-Side Trees)
Auspice can compare two datasets by drawing lines between tips with matching names. This is essential for identifying reassortment in segmented viruses (e.g., Influenza).
*   **URL Pattern**: Combine two dataset paths with a colon.
    *   Example: `flu/h3n2/ha:flu/h3n2/na`
*   **Sidebar Toggle**: Use the sidebar to turn off the connecting lines if the view becomes too cluttered.

### Streamtrees
For datasets with tens of thousands of tips, use Streamtrees to summarize clades as streamgraphs (KDE-based ribbons).
*   **Trigger**: Use the `streamLabel` URL query or the sidebar toggle.
*   **Benefit**: Reduces computational overhead and highlights "big picture" trends like geographic jumps that are often lost in dense rectangular trees.

## Metadata Integration

You can augment existing datasets by dragging and dropping CSV, TSV, or XLSX files directly onto the browser window.

### Metadata Schema Requirements
*   **First Column**: Must contain the sample/strain names matching the tree tips.
*   **Header Row**: Defines the metadata trait names.
*   **Custom Colors**: Add a column named `trait__colour` (e.g., `author__colour`) containing hex codes (e.g., `#3498db`).
*   **Geographic Data**: Use columns `latitude` and `longitude` to automatically plot samples on the map.

## Expert URL Query Configuration

Auspice views are highly configurable via URL parameters. This is the preferred method for sharing specific "states" of a visualization.

| Key | Function | Example |
| :--- | :--- | :--- |
| `c` | Set the "Color By" trait | `?c=country` |
| `d` | Select visible panels | `?d=tree,map,entropy` |
| `l` | Change tree layout | `?l=radial` (rect, radial, clock, scatter) |
| `m` | Set x-axis metric | `?m=div` (divergence) or `?m=num_date` (time) |
| `f_<trait>` | Filter data by trait | `?f_region=Africa,Europe` |
| `label` | Zoom to a specific clade/label | `?label=clade:20A` |
| `s` | Select a specific strain | `?s=StrainName_2023` |
| `onlyPanels` | Hide header/footer (for iframes) | `?onlyPanels` |

## Handling Missing Data
Auspice automatically grays out nodes with missing or unknown traits. It recognizes the following strings (case-insensitive) as "missing":
`["unknown", "?", "nan", "na", "n/a", "", "unassigned"]`



## Subcommands

| Command | Description |
|---------|-------------|
| auspice build | Build the client source code bundle. For development, you may want to use "auspice develop" which recompiles code on the fly as changes are made. You may provide customisations (e.g. code, options) to this step to modify the functionality and appearance of auspice. To serve the bundle you will need a server such as "auspice view". |
| auspice convert | Convert auspice dataset JSON file(s) to the most up-to-date schema (currently v2). Note that in auspice v2.x, "auspice view" will convert v1 JSONs to v2 for you (using the same logic as this command). |
| auspice develop | Launch auspice in development mode. This runs a local server and uses  hot-reloading to allow automatic updating as you edit the code. NOTE: there  is a speed penalty for this ability and this should never be used for  production. |
| auspice view | Launch a local server to view locally available datasets & narratives. The handlers for (auspice) client requests can be overridden here (see documentation for more details). If you want to serve a customised auspice client then you must have run "auspice build" in the same directory as you run "auspice view" from. |

## Reference documentation
- [How to Run Auspice](./references/docs_nextstrain_org_projects_auspice_en_stable_introduction_how-to-run.html.md)
- [View Settings and URL Queries](./references/docs_nextstrain_org_projects_auspice_en_stable_advanced-functionality_view-settings.html.md)
- [Adding Extra Metadata](./references/docs_nextstrain_org_projects_auspice_en_stable_advanced-functionality_drag-drop-csv-tsv.html.md)
- [Streamtrees Documentation](./references/docs_nextstrain_org_projects_auspice_en_stable_advanced-functionality_streamtrees.html.md)
- [Displaying Multiple Trees](./references/docs_nextstrain_org_projects_auspice_en_stable_advanced-functionality_second-trees.html.md)