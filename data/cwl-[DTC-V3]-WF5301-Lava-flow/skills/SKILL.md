---
name: dtc-v3-wf5301-lava-flow
description: This CWL workflow utilizes topographic datasets and eruption source parameters to model the progression and spatial distribution of lava flows. Use this skill when assessing volcanic hazards or planning emergency responses by determining the potential inundation areas of active or future eruptions.
homepage: https://dtgeo.eu/
metadata:
  docker_image: "N/A"
---

# dtc-v3-wf5301-lava-flow

## Overview

The **[DTC-V3] WF5301: Lava flow** workflow is a [Common Workflow Language (CWL)](https://www.commonwl.org/) implementation designed to model or process lava flow data. This workflow is part of a larger repository of computational workflows enriched with [RO-Crate](https://www.researchobject.org/ro-crate/) metadata to ensure provenance, reproducibility, and adherence to the Workflow Run RO-Crate profile.

The process is structured into five distinct computational steps (**ST530101** through **ST530105**). These steps are connected via data dependencies, where the outputs of upstream operations serve as inputs for subsequent tools, allowing for parallel execution where dependencies permit. The workflow utilizes the `Operation` class to abstract underlying execution details, focusing on the high-level data flow between datasets and software components.

Detailed metadata, authorship, and licensing information for this workflow can be found on its [WorkflowHub page](https://workflowhub.eu/workflows/1786). Users can validate the workflow structure using `cwltool` or inspect the associated research object metadata using the [RO-Crate Validator](https://github.com/crs4/rocrate-validator).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT5301 |  | Directory |  |
| DT5302 |  | Directory |  |
| DT5303 |  | Directory |  |
| DT5304 |  | Directory |  |
| DT5308 |  | Directory |  |
| DT5309 |  | Directory |  |
| DT5311 |  | Directory |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| ST530101 | ST530101 |  |
| ST530102 | ST530102 |  |
| ST530103 | ST530103 |  |
| ST530104 | ST530104 |  |
| ST530105 | ST530105 |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT5305 |  | Directory |  |
| DT5306 |  | Directory |  |
| DT5307 |  | Directory |  |
| DT5310 |  | Directory |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1786
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata