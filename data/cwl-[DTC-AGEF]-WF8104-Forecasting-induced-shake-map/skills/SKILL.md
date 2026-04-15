---
name: dtc-agef-wf8104-forecasting-induced-shake-map
description: This Common Workflow Language pipeline generates seismic hazard maps for future anthropogenic seismicity by integrating past activity models and time-varying technological factors through a multi-model ensemble approach. Use this skill when forecasting short-term ground vibrations, such as peak ground acceleration, to assess the potential seismic impact of industrial operations in newly active or future source zones.
homepage: https://dtgeo.eu/
metadata:
  docker_image: "N/A"
---

# dtc-agef-wf8104-forecasting-induced-shake-map

## Overview

The [WF8104: Forecasting induced shake map](https://workflowhub.eu/workflows/1986) workflow generates seismic hazard maps for near-future anthropogenic seismicity (AS) triggered by industrial activities. Unlike natural seismicity, AS is controlled by time-varying technological factors and finite exploitation periods. This workflow implements a short-term ground vibration forecast to estimate Peak Ground Acceleration (PGA) or Spectral Amplitude (SA) for specific future time intervals.

The process utilizes a Multi-Model Ensembles Approach to address uncertainty regarding future seismic activity. Since future zone activity is often unknown, the workflow leverages probabilistic properties from historical seismic zones as activity models. Multiple alternative models are selected, each assigned an a priori probability, to predict the exceedance probability of ground motion in a specified future period.

The workflow is executed through ten sequential steps (ST810401–ST810410) that process historical activity models, calculate time-varying hazard parameters, and output the resulting forecasting shake maps. This technical implementation follows the methodologies established by Lasocki and Orlecka-Sikora for assessing non-stationary seismic hazards in mining and other anthropogenic contexts.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| Mc |  | Directory |  |
| Mmax |  | Directory |  |
| P_phase_threshold |  | Directory |  |
| S_phase_threshold |  | Directory |  |
| acceleration_miniseed |  | Directory |  |
| attribute_range |  | Directory |  |
| blinding |  | Directory |  |
| catalog |  | Directory |  |
| damping_factor |  | Directory |  |
| depth_max |  | Directory |  |
| depth_min |  | Directory |  |
| forecast_length |  | Directory |  |
| frequency_range |  | Directory |  |
| gmm |  | Directory |  |
| grid_cell_size |  | Directory |  |
| ground_motion_params |  | Directory |  |
| injection_model |  | Directory |  |
| injection_rate |  | Directory |  |
| injection_rate_threshold |  | Directory |  |
| inter_event_time_threshold |  | Directory |  |
| kde_method |  | Directory |  |
| lat_max |  | Directory |  |
| lat_min |  | Directory |  |
| lon_max |  | Directory |  |
| lon_min |  | Directory |  |
| map_selection |  | Directory |  |
| model |  | Directory |  |
| model_weights |  | Directory |  |
| network_inventory |  | Directory |  |
| output_uncertainty |  | Directory |  |
| path_char |  | Directory |  |
| site_char |  | Directory |  |
| source_char_param |  | Directory |  |
| source_rock_density |  | Directory |  |
| source_wave_velocity |  | Directory |  |
| time_window_duration |  | Directory |  |
| time_window_length |  | Directory |  |
| velocity_model |  | Directory |  |
| waveform_miniseed |  | Directory |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| ST810401 | ST810401 |  |
| ST810402 | ST810402 |  |
| ST810403 | ST810403 |  |
| ST810404 | ST810404 |  |
| ST810405 | ST810405 |  |
| ST810406 | ST810406 |  |
| ST810407 | ST810407 |  |
| ST810408 | ST810408 |  |
| ST810409 | ST810409 |  |
| ST810410 | ST810410 |  |
| ST810411 | ST810411 |  |
| ST810412 | ST810412 |  |
| ST810413 | ST810413 |  |
| ST810414 | ST810414 |  |
| ST810415 | ST810415 |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT810401 |  | Directory |  |
| DT810402 |  | Directory |  |
| DT810403 |  | Directory |  |
| DT810404 |  | Directory |  |
| DT810405 |  | Directory |  |
| DT810406 |  | Directory |  |
| DT810407 |  | Directory |  |
| DT810408 |  | Directory |  |
| DT810409 |  | Directory |  |
| DT810410 |  | Directory |  |
| DT810411 |  | Directory |  |
| DT810412 |  | Directory |  |
| DT810413 |  | Directory |  |
| DT810414 |  | Directory |  |
| DT810415 |  | Directory |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1986
- `WF8104.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata