---
name: dtc-agef-wf8101-forecasting-the-long-range-responses-of-geor
description: "This CWL workflow utilizes the EPISODES platform and specialized tools for phase association and catalog homogenization to transform raw seismic data into a standardized earthquake catalog with calculated magnitudes of completeness. Use this skill when you need to forecast the long-range responses of georeservoirs or perform spatial and temporal density analyses based on a consistent and homogenized seismic record."
homepage: https://workflowhub.eu/workflows/1983
---
# [DTC-AGEF] WF8101: Forecasting the long range responses of georeservoirs

## Overview

This CWL workflow, available on [WorkflowHub](https://workflowhub.eu/workflows/1983), is designed to forecast the long-range responses of georeservoirs by constructing an advanced, homogenized earthquake catalog. It integrates existing applications from the EPISODES platform with specialized tools for phase association and catalog standardization.

The pipeline processes seismic data through ten discrete steps (ST810101–ST810110) to ensure consistency across key parameters, including location (X, Y, Z), time (T), and magnitude (M). It standardizes various magnitude measurements—such as moment, local, and duration magnitudes—to maintain uniform features throughout the dataset.

A critical component of the workflow is the calculation of the magnitude of completeness (Mc) using the Maximum Curvature Method. The resulting advanced catalog provides the necessary foundation for subsequent spatial and temporal density analyses of georeservoir activity.

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
| raw_catalog |  | Directory |  |
| relevant_surfaces_points |  | Directory |  |
| simulation_params |  | Directory |  |
| source_rock_density |  | Directory |  |
| source_wave_velocity |  | Directory |  |
| time_window_length |  | Directory |  |
| velocity_model |  | Directory |  |
| waveform_miniseed |  | Directory |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| ST810101 | ST810101 |  |
| ST810102 | ST810102 |  |
| ST810103 | ST810103 |  |
| ST810104 | ST810104 |  |
| ST810105 | ST810105 |  |
| ST810106 | ST810106 |  |
| ST810107 | ST810107 |  |
| ST810108 | ST810108 |  |
| ST810109 | ST810109 |  |
| ST810110 | ST810110 |  |
| ST810111 | ST810111 |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT810101 |  | Directory |  |
| DT810102 |  | Directory |  |
| DT810103 |  | Directory |  |
| DT810104 |  | Directory |  |
| DT810105 |  | Directory |  |
| DT810106 |  | Directory |  |
| DT810107 |  | Directory |  |
| DT810108 |  | Directory |  |
| DT810109 |  | Directory |  |
| DT810110 |  | Directory |  |
| DT810111 |  | Directory |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1983
- `WF8101.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
