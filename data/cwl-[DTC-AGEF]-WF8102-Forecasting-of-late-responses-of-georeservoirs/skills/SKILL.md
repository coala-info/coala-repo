---
name: dtc-agef-wf8102-forecasting-of-late-responses-of-georeservoi
description: This Common Workflow Language workflow generates an advanced earthquake catalog by integrating EPISODES platform applications with specialized tools for phase association and catalog homogenization. Use this skill when forecasting the late seismic responses of georeservoirs or assessing long-term geological stability following subsurface industrial activities.
homepage: https://dtgeo.eu/
metadata:
  docker_image: "N/A"
---

# dtc-agef-wf8102-forecasting-of-late-responses-of-georeservoi

## Overview

This CWL workflow, [WF8102](https://workflowhub.eu/workflows/1984), is designed to forecast the late responses of georeservoirs by constructing an advanced earthquake catalog. It provides a standardized pipeline for seismic data processing, enabling researchers to analyze long-term reservoir behavior and potential delayed seismic activity.

The workflow integrates established applications from the EPISODES platform with specialized tools for data refinement. The process includes initial catalog building (steps 1, 3, and 4), a dedicated application for phase association (step 2), and a specific module for catalog homogenization (step 5).

The complete pipeline consists of ten sequential steps (ST810201 through ST810210) licensed under Apache-2.0. By automating the transition from raw seismic phases to a homogenized catalog, the workflow ensures the data consistency required for accurate georeservoir forecasting and risk assessment.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| P_phase_threshold |  | Directory |  |
| S_phase_threshold |  | Directory |  |
| blinding |  | Directory |  |
| depth_max |  | Directory |  |
| depth_min |  | Directory |  |
| frequency_range |  | Directory |  |
| lat_max |  | Directory |  |
| lat_min |  | Directory |  |
| lon_max |  | Directory |  |
| lon_min |  | Directory |  |
| model |  | Directory |  |
| model_weights |  | Directory |  |
| network_inventory |  | Directory |  |
| source_rock_density |  | Directory |  |
| source_wave_velocity |  | Directory |  |
| time_window_length |  | Directory |  |
| velocity_model |  | Directory |  |
| waveform_miniseed |  | Directory |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| ST810201 | ST810201 |  |
| ST810202 | ST810202 |  |
| ST810203 | ST810203 |  |
| ST810204 | ST810204 |  |
| ST810205 | ST810205 |  |
| ST810206 | ST810206 |  |
| ST810207 | ST810207 |  |
| ST810208 | ST810208 |  |
| ST810209 | ST810209 |  |
| ST810210 | ST810210 |  |
| ST810211 | ST810211 |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT810201 |  | Directory |  |
| DT810202 |  | Directory |  |
| DT810203 |  | Directory |  |
| DT810204 |  | Directory |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1984
- `WF8102.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata