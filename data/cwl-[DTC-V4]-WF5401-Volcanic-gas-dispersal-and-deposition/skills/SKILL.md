---
name: dtc-v4-wf5401-volcanic-gas-dispersal-and-deposition
description: "This CWL workflow utilizes the FALL3D atmospheric dispersion model and Bayesian inference via PyMC to estimate eruption source parameters and ground-level sulfur dioxide concentrations from real-time sensor data and meteorological inputs. Use this skill when you need to perform source term estimation, generate probabilistic air quality forecasts, or characterize the environmental impact of volcanic gas emissions during effusive eruption events."
homepage: https://workflowhub.eu/workflows/1982
---
# [DTC-V4] WF5401: Volcanic gas dispersal and deposition

## Overview

The [WF5401 workflow](https://workflowhub.eu/workflows/1982) is a Common Workflow Language (CWL) implementation designed to model volcanic gas dispersal and deposition, specifically focusing on $SO_2$ ground concentrations. To facilitate rapid forecasting and Source Term Estimation (STE), the workflow replaces computationally intensive FALL3D dispersion model runs with a fast "Emulator." This emulator approximates physics-based model outputs at high speeds, allowing the system to perform complex Bayesian inference within a reasonable timeframe.

The workflow follows a philosophy of emulating deterministic physical relationships while sampling stochastic variables. By treating the volcanic state as a parameter space, the system can estimate Eruption Source Parameters (ESPs)—such as plume height and $SO_2$ flux—and generate probabilistic forecasts of air quality and concentration exceedance.

The process is structured into four primary functional stages:

*   **Watch and Fetch (ST540102):** Connects to external APIs (e.g., Environmental Agency of Iceland) to retrieve real-time $SO_2$ ground concentration measurements from local sensor networks.
*   **Emulate (ST540103):** Manages Numerical Weather Prediction (NWP) data from sources like Copernicus or ECMWF and prepares the fast forward models used to approximate atmospheric dispersion.
*   **Infer (ST540104):** Performs Bayesian inference using the PyMC framework. This stage assimilates observations to produce posterior distributions for ESPs and probabilistic forecasts for ground-level gas concentrations.
*   **Visualize (ST540105):** Generates an interactive web-based interface to display results, including violin plots of parameter distributions and maps showing the probability of exceeding specific concentration thresholds.

## Inputs

_None listed._


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| ST540101 | ST540101 |  |
| ST540102 | ST540102 |  |
| ST540103 | ST540103 |  |
| ST540104 | ST540104 |  |
| ST540205 | ST540205 |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT5401 |  | Directory |  |
| DT5402 |  | Directory |  |
| DT5403 |  | Directory |  |
| DT5404 |  | Directory |  |
| DT5405 |  | Directory |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1982
- `WF5401.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
