---
name: sciwin-client-demo
description: "This Common Workflow Language pipeline downloads election data, extracts feature information, and utilizes Python scripts and GDAL tools to generate bar plots and choropleth maps from geospatial and tabular datasets. Use this skill when you need to visualize regional voting results, analyze demographic distributions across administrative districts, or characterize spatial patterns in electoral data."
homepage: https://workflowhub.eu/workflows/1808
---
# SciWIn Client Demo

## Overview

The [SciWIn Client Demo](https://workflowhub.eu/workflows/1808) is a Common Workflow Language (CWL) pipeline designed to demonstrate the capabilities of the [SciWIn Client (`s4n`)](https://github.com/fairagro/m4.4_sciwin_client). It automates the process of fetching, processing, and visualizing election data, specifically showcasing how command-line tools can be wrapped and orchestrated into a reproducible workflow.

The workflow follows a multi-stage process:
*   **Data Acquisition & Extraction:** It begins by downloading election data via API calls and extracting feature information (such as party headers) to structure the raw results.
*   **Geospatial Processing:** The pipeline converts spatial data from Shapefile format to GeoJSON to prepare for mapping.
*   **Visualization:** Finally, the workflow generates two primary outputs: a bar plot of election results and a choropleth map visualizing the data geographically.

This demo serves as a practical implementation guide for researchers using the [SciWIn infrastructure](https://fairagro.github.io/m4.4_sciwin_client/), illustrating how to transition from manual Python scripts to containerized CWL steps. Detailed source code and example data can be found in the [official demo repository](https://github.com/fairagro/sciwin_client_demo).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| ags |  | string |  |
| election |  | string |  |
| feature |  | string |  |
| shapes |  | Directory |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| download_election_data | download_election_data |  |
| get_feature_info | get_feature_info |  |
| plot_election | plot_election |  |
| shp2geojson | shp2geojson |  |
| plot_map | plot_map |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| bar |  | File |  |
| map |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1808
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
