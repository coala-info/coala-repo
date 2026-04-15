---
name: dtc-v1-wf5101-volcanic-unrest
description: This geophysics workflow integrates GNSS ground deformation data with physics-based HPC simulations and machine learning models to detect volcanic unrest and invert for magmatic dike source parameters. Use this skill when you need to characterize the spatial probability of magmatic sources from ground deformation patterns to provide early warnings for potential lava flow inundation during volcanic unrest.
homepage: https://dtgeo.eu/
metadata:
  docker_image: "N/A"
---

# dtc-v1-wf5101-volcanic-unrest

## Overview

This CWL workflow, developed as part of the [DT-GEO](https://dtgeo.eu/) project, implements a Digital Twin prototype for monitoring volcanic unrest at Mount Etna. It provides near-real-time identification of magmatic sources, specifically dike intrusions, by analyzing ground deformation patterns captured by GNSS monitoring networks. The system is designed to assist in early warning and volcanic crisis management by offering a robust interpretation of dike propagation and potential lava flow hazards.

The workflow integrates physics-based HPC simulations with machine learning architectures. It utilizes an archive of approximately 10 million numerical simulations, generated using the GALES code, to train an AI model. This model performs an inversion from observed surface displacement data to the endogenous forces that generated the deformation, outputting a spatial probability distribution of the source body.

In its operational phase, the workflow continuously scans multiparametric data streams from the INGV control room to detect anomalous trends indicative of unrest. Once unrest is declared, the AI-based inversion processes the displacement datasets to provide updates every 15–30 minutes. This automated pipeline, available on [WorkflowHub](https://workflowhub.eu/workflows/1728), supports both the training of new models and the near-real-time execution of the operational monitoring component.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT5102 |  | Directory |  |
| DT5104 |  | Directory |  |
| DT5109 |  | Directory |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| ST510101 | ST510101 |  |
| ST510102 | ST510102 |  |
| ST510103 | ST510103 |  |
| ST510107 | ST510107 |  |
| ST510109 | ST510109 |  |
| ST510110 | ST510110 |  |
| ST510111 | ST510111 |  |
| ST510112 | ST510112 |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| DT5101 |  | Directory |  |
| DT5103 |  | Directory |  |
| DT5105 |  | Directory |  |
| DT5110 |  | Directory |  |
| DT5111 |  | Directory |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1728
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata