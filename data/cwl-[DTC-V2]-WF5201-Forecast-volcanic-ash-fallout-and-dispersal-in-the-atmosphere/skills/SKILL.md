---
name: dtc-v2-wf5201-forecast-volcanic-ash-fallout-and-dispersal-in
description: This Common Workflow Language workflow integrates meteorological data and eruption source parameters to simulate the atmospheric dispersal and deposition of volcanic ash using the FALL3D transport model. Use this skill when you need to generate deterministic and probabilistic forecasts of volcanic ash clouds and ground fallout to assess environmental hazards or mitigate risks to aviation and infrastructure.
homepage: https://dtgeo.eu/
metadata:
  docker_image: "N/A"
---

# dtc-v2-wf5201-forecast-volcanic-ash-fallout-and-dispersal-in

## Overview

This workflow automates the atmospheric dispersal and fallout forecasting of volcanic ash using the [FALL3D](https://workflowhub.eu/workflows/1230) transport model. It is designed to handle the inherent uncertainties in Eruption Source Parameters (ESP) by configuring and executing an ensemble of model realizations. By perturbing critical inputs—such as eruption column height, mass eruption rate, and grain size distribution—within their uncertainty ranges, the workflow generates both deterministic (ensemble mean) and probabilistic forecasts.

The execution process follows a four-stage pipeline:
*   **Data Acquisition:** Retrieves meteorological data from Numerical Weather Prediction (NWP) models (forecasts or reanalyses) and gathers ESPs from monitoring sources like State Volcano Observatories (SVO).
*   **Model Configuration:** Sets up the FALL3D ensemble, assigning ranked priorities to available ESP data and defining perturbation ranges for the ensemble members.
*   **Simulation:** Executes the ensemble simulations on high-performance computing (HPC) resources, such as the FENIX RI or the Leonardo supercomputer at CINECA.
*   **Post-processing:** Aggregates results to produce hazard maps and atmospheric concentration forecasts, accounting for processes like wind advection, turbulent diffusion, and particle sedimentation.

This CWL implementation, identified as [WF5201](https://workflowhub.eu/workflows/1230), ensures a reproducible approach to volcanic hazard assessment, allowing for the assimilation of ground-based or satellite observations to refine dispersal accuracy.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT5210 |  | Directory |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| ST520101 | ST520101 |  |
| SS5202 | SS5202 | ST520102 |
| SS5203 | SS5203 | ST520103 |
| SS5204 | SS5204 | ST520104 |
| SS5205 | SS5205 | ST520105 |
| SS5206 | SS5206 | ST520106 |
| SS5207 | SS5207 | ST520107 |
| SS5208 | SS5208 | ST520108 |
| SS5209 | SS5209 | ST520109 |
| SS5210 | SS5210 | ST520110 |
| SS5211 | SS5211 | ST520111 |
| SS5212 | SS5212 | ST520112 |
| SS5213 | SS5213 | ST520113 |
| SS5214 | SS5214 | ST520114 |
| SS5215 | SS5215 | ST520115 |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT5201 |  | File[] |  |
| DT5202 |  | Directory |  |
| DT5203 |  | Directory |  |
| DT5204 |  | Directory |  |
| DT5205 |  | Directory |  |
| DT5206 |  | Directory |  |
| DT5207 |  | Directory |  |
| DT5208 |  | Directory |  |
| DT5209 |  | Directory[] |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1230
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata