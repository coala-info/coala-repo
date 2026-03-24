---
name: dtc-e4-wf7401-dynamic-source-inversion-workflow
description: "This CWL workflow performs dynamic source inversion of earthquakes by processing seismic and geodetic data using the FD3D_TSN inversion code and a Bayesian framework. Use this skill when you need to characterize the physical parameters of earthquake ruptures, estimate model uncertainties, or determine the stress and friction properties of seismic sources."
homepage: https://workflowhub.eu/workflows/1994
---
# [DTC-E4] WF7401: Dynamic Source Inversion Workflow

## Overview

WF7401 is a Common Workflow Language (CWL) implementation designed for the dynamic source inversion of earthquakes. Developed as part of the [DT-GEO project](https://dtgeo.eu), this workflow integrates seismic and geodetic data to characterize physical earthquake source parameters. The complete definition and associated RO-Crate metadata are hosted on [WorkflowHub](https://workflowhub.eu/workflows/1994).

The workflow utilizes the **FD3D_TSN** inversion code, which employs a quasi-dynamic boundary element solver. It applies a Bayesian inversion framework using Parallel Tempering Monte Carlo to estimate model parameters and quantify uncertainties. This approach allows for the detailed modeling of rupture dynamics, including prestress, friction, and misfit statistics.

The execution process follows a structured pipeline:
* **Preparation:** Standardizes input datasets, including fault geometry, velocity models, and station data (ST740101, ST740102).
* **Execution:** Leverages high-performance computing (HPC) resources to perform the computationally intensive inversion (ST740103).
* **Post-Processing:** Extracts rupture parameters and generates final model products and metadata (ST740104, ST740105).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT7401 |  | Directory | Fault geometry, velocity model, waveforms data or geodetic data for dynamic inversion. |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| ST740101 | ST740101 | Prepare dynamic inversion data. |
| ST740102 | ST740102 | Perform dynamic source inversion using HPC. |
| ST740103 | ST740103 | Generate data-driven dynamic rupture model. |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT7402 |  | Directory | Data-driven dynamic rupture model. |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1994
- `WF7401.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
