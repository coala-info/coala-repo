---
name: gravitational-wave-source-cone-search
description: This CWL workflow performs a spatial cone search for gravitational wave sources by querying astronomical databases using sky coordinates and search radii. Use this skill when identifying potential electromagnetic counterparts to gravitational wave events or characterizing the spatial distribution of detected mergers within a specific region of the sky.
homepage: https://github.com/oda-hub
metadata:
  docker_image: "N/A"
---

# gravitational-wave-source-cone-search

## Overview

The [Gravitational Wave source Cone Search](https://workflowhub.eu/workflows/415) workflow is a standardized Common Workflow Language (CWL) implementation designed for astronomical data discovery. It automates the process of performing spatial queries across celestial databases to identify objects or transients located within specific radii of gravitational wave event coordinates.

By adhering to FAIR principles, this workflow ensures reproducible cross-matching between gravitational wave triggers and existing galaxy catalogs or observational data. It is a critical tool for multi-messenger astrophysics, allowing researchers to efficiently filter and identify candidate electromagnetic counterparts for further analysis.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| t1 |  | string |  |
| t2 |  | string |  |
| do_cone_search |  | boolean |  |
| ra |  | int |  |
| dec |  | float |  |
| radius |  | int |  |
| level_threshold |  | int |  |
| contour_levels |  | string |  |


## Steps

_Step list is not in the RO-Crate metadata; open the main workflow CWL below or see WorkflowHub for the diagram._


## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| asciicat |  | string | lines found with the pattern |
| skymap_files |  | string | lines found with the pattern |
| image |  | string | lines found with the pattern |
| contours |  | string | lines found with the pattern |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/415
- `conesearch.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata