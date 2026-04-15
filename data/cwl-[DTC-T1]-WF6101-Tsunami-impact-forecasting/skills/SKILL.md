---
name: dtc-t1-wf6101-tsunami-impact-forecasting
description: This CWL workflow performs probabilistic tsunami impact forecasting by integrating real-time earthquake, sea level, and GNSS data with topo-bathymetric grids using simulation tools like Tsunami-HySEA and SeisSol. Use this skill when providing operational tsunami early warning, generating probabilistic hazard maps, or conducting rapid post-event assessments of earthquake-induced tsunami impacts on coastal regions.
homepage: https://dtgeo.eu/
metadata:
  docker_image: "N/A"
---

# dtc-t1-wf6101-tsunami-impact-forecasting

## Overview

The [DTC-T1 WF6101](https://workflowhub.eu/workflows/1231) workflow provides probabilistic tsunami impact forecasting following tsunamigenic earthquake events. Developed as part of the DT-GEO Digital Twin, it integrates real-time seismic data with long-term regional hazard models to generate an ensemble of earthquake scenarios. Each scenario is weighted by probability to produce hazard curves and maps that calculate exceedance probabilities for tsunami intensities at specific coastal points.

The workflow is designed for (near-)real-time operation at Tsunami Warning Centres and for rapid post-event assessment. It follows a modular structure:
*   **Data Acquisition & Processing:** Listeners evaluate earthquake (EQ), sea level (SL), and GNSS data to initialize the execution and provide observational baselines.
*   **Ensemble Management:** An ensemble of scenarios is generated and passed to modeling engines (such as Tsunami-HySEA or SeisSol) to compute tsunami intensities and ground deformation.
*   **Evaluation & Aggregation:** A misfit evaluator compares simulations against real-time observations to update scenario probabilities, which are then aggregated into hazard curves.
*   **Visualization:** The final stage converts hazard data into Alert Levels (AL) and probabilistic visual maps for operational forecasting.

This CWL implementation supports high-performance computing (HPC) environments, utilizing tools like PyCOMPSs for job submission on clusters such as Leonardo (CINECA). It can also handle landslide-triggered tsunamis by incorporating shake maps into the scenario management process.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT6102 |  | Directory | NEAMTHM18 |
| DT6103 |  | Directory | EIDA seismic data archive |
| DT6104 |  | Directory | SLSMF sea level data |
| DT6105 |  | Directory | GNSS displacements |
| DT6109 |  | Directory | topo-bathymetric grids |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| ST610101 | ST610101 | SS6101 |
| ST610102 | ST610102 | SS6102 |
| ST610103 | ST610103 | SS6103 |
| ST610104 | ST610104 | SS6104 |
| ST610105 | ST610105 | SS6105 |
| ST610106 | ST610106 |  |
| ST610107 | ST610107 | SS6113 |
| ST610108 | ST610108 | SS6114 |
| ST610109 | ST610109 |  |
| ST610110 | ST610110 | SS6117 |
| ST610111 | ST610111 | SS6118 |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT6101 |  | Directory | Scenario Library |
| DT6106 |  | Directory | list of earthquake scenarios |
| DT6107 |  | Directory | list of scenario probabilities |
| DT6108 |  | Directory | list of landslide scenarios |
| DT6110 |  | Directory | Tsunami intensities |
| DT6111 |  | Directory | Ground deformation |
| DT6112 |  | Directory | Tsunami hazard curves |
| DT6113 |  | Directory | Hazard visual products |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1231
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata