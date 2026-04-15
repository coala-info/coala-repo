---
name: bioconductor-cytoml
description: CytoML facilitates the exchange of flow cytometry gating hierarchies and data between R and commercial platforms like FlowJo and Cytobank. Use when user asks to import FlowJo workspaces, convert Cytobank experiments to GatingSets, or export R gating hierarchies to FlowJo and Cytobank formats.
homepage: https://bioconductor.org/packages/release/bioc/html/CytoML.html
---

# bioconductor-cytoml

## Overview
The `CytoML` package provides a computational bridge between the R/Bioconductor flow cytometry ecosystem (specifically `flowWorkspace` and `openCyto`) and commercial software platforms like FlowJo and Cytobank. It allows for the lossless exchange of gating hierarchies, compensations, and transformations, enabling users to perform automated gating in R and visualize results in FlowJo, or vice versa.

## Core Workflows

### 1. Importing FlowJo Workspaces
To bring a FlowJo analysis into R, use the `flowjo_to_gatingset` function.

```r
library(CytoML)

# Open the workspace file
ws <- open_flowjo_xml("path/to/workspace.wsp")

# View available sample groups
fj_ws_get_sample_groups(ws)

# Import a specific group into a GatingSet
gs <- flowjo_to_gatingset(ws, name = "T-cell", path = "path/to/fcs_files")

# Advanced: Import without loading heavy FCS data (metadata only)
gs_meta <- flowjo_to_gatingset(ws, name = 1, execute = FALSE)
```

### 2. Importing Cytobank Experiments
Cytobank analyses are typically handled via ACS (Archive Cytobank) files.

```r
# Open the ACS bundle
acs <- open_cytobank_experiment("experiment.acs")

# Convert to GatingSet
gs <- cytobank_to_gatingset(acs)

# Access specific metadata from the experiment
ce_get_markers(acs)
ce_get_compensations(acs)
```

### 3. Exporting GatingSets
You can export R-generated gating results for use in other software.

```r
# Export to Cytobank-compatible GatingML
gatingset_to_cytobank(gs, outFile = "my_analysis.xml")

# Export to FlowJo-compatible workspace
gatingset_to_flowjo(gs, outFile = "my_analysis.wsp")
```

## Key Functions and Tips

### Workspace Inspection
- `fj_ws_get_samples(ws)`: List samples within a workspace.
- `fj_ws_get_keywords(ws, sampleID)`: Retrieve FCS keywords stored in the XML.
- `fj_ws_get_sample_groups(ws)`: Identify group names for the `name` argument in parsing.

### Handling Parsing Issues
- **Faulty Gates**: If a workspace contains a gate with a channel name not present in the FCS file, use `skip_faulty_gate = TRUE` to continue importing the rest of the tree.
- **Custom Extensions**: If your FCS files don't end in `.fcs` (e.g., `.B08`), use `fcs_file_extension = ".B08"`.
- **Sample Naming**: By default, `CytoML` appends `$TOT` (event count) to sample names to ensure uniqueness. Control this with `additional.keys = NULL`.
- **Performance**: For large datasets, use `mc.cores = N` to enable parallel parsing of samples.

### Requirements for Export
For a `GatingSet` to export correctly, compensations and transformations **must** be applied directly to the `GatingSet` object (using `compensate()` and `transform()`) rather than the underlying `flowSet` or `cytoset`.

## Reference documentation
- [How to export a GatingSet to GatingML](./references/HowToExportGatingSet.md)
- [How to import Cytobank into a GatingSet](./references/cytobank2GatingSet.md)
- [Import FlowJo workspace to R](./references/flowjo_to_gatingset.md)