---
name: dtc-agef-wf8103-forecasting-maximum-magnitude
description: This CWL workflow integrates raw seismic waveform data and hydraulic injection parameters using tools like TRMLoc and multiple deterministic and probabilistic models to forecast maximum earthquake magnitude. Use this skill when assessing seismic hazard risks and forecasting the potential for large-magnitude earthquakes induced by fluid injection activities.
homepage: https://dtgeo.eu/
metadata:
  docker_image: "N/A"
---

# dtc-agef-wf8103-forecasting-maximum-magnitude

## Overview

The [WF8103 workflow](https://workflowhub.eu/workflows/1985) is a Common Workflow Language (CWL) implementation designed to estimate maximum earthquake magnitude using a variety of deterministic and statistical models. The process is divided into two primary phases: the continuous generation of an advanced seismic catalog and the subsequent assessment of magnitude based on that catalog and hydraulic injection data.

The first four steps (ST810305 through ST810403) focus on catalog development by picking raw waveform data, performing phase association, and determining earthquake locations via the TRMLoc module. These steps culminate in the calculation of basic source parameters, providing a perpetually updated dataset for seismic analysis.

The final stage (ST810404) integrates the seismic catalog with hydraulic parameters, such as injection rates and timing, to compute maximum magnitude estimates. This step utilizes several established models, including McGarr (2014), Hallo et al. (2014), Li et al. (2022), van der Elst et al. (2016), and Shapiro et al. (2013). Users can configure the workflow to use different Gutenberg-Richter b-value estimators, such as maximum-likelihood or "b-positive" methods, to refine the results.

The workflow outputs comprehensive time-series data, including seismogenic indices, b-values, and maximum magnitude estimates with corresponding standard errors. It also provides supplementary metrics essential for monitoring induced seismicity, such as cumulative fluid injection totals and seismic efficiency ratios.

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
| ST810305 | ST810305 |  |
| ST810401 | ST810401 |  |
| ST810402 | ST810402 |  |
| ST810403 | ST810403 |  |
| ST810404 | ST810404 |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT810401 |  | Directory |  |
| DT810402 |  | Directory |  |
| DT810403 |  | Directory |  |
| DT810404 |  | Directory |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1985
- `WF8103.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata