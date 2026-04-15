---
name: dtc-e2-wf7201-ai-based-seismic-catalogue-generation-quakeflo
description: This CWL workflow utilizes the QuakeFlow deep-learning pipeline to process continuous seismic waveform data for automated earthquake detection, phase picking, and event location. Use this skill when you need to generate high-resolution earthquake catalogues or characterize regional seismicity for seismic hazard assessment and forecasting.
homepage: https://dtgeo.eu/
metadata:
  docker_image: "N/A"
---

# dtc-e2-wf7201-ai-based-seismic-catalogue-generation-quakeflo

## Overview

WF7201 is a Common Workflow Language (CWL) implementation designed for AI-based seismic catalogue generation. Developed as part of the [DT-GEO project](https://dtgeo.eu), it leverages the [QuakeFlow](https://github.com/AI4EPS/QuakeFlow) pipeline to automate the transition from raw seismic waveforms to high-precision earthquake catalogs. The workflow provides a scalable framework for near-real-time monitoring and digital twin earthquake analysis.

The processing pipeline consists of five sequential stages:
* **Data Ingestion:** Waveform ingestion and pre-processing (ST720101).
* **AI Detection:** Phase picking using deep learning models (ST720102).
* **Association & Location:** Linking picks to specific events (ST720103) and estimating spatial locations and magnitudes (ST720104).
* **Export:** Final high-resolution catalogue generation (ST720105).

This workflow, available on [WorkflowHub](https://workflowhub.eu/workflows/1991), integrates machine learning models to improve the accuracy and efficiency of seismic event detection. It is designed to handle continuous data streams, such as those from the AlpArray Network, producing standardized outputs for downstream geophysical research.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| WAVEFORMS |  | File | Seismic waveform data (EPOS/EIDA) or Alparray data as in DT7205 |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| ST720101 | ST720101 | Waveform ingestion from EPOS/EIDA |
| ST720102 | ST720102 | AI-based picking of seismic phases |
| ST720103 | ST720103 | Association of picks into seismic events |
| ST720104 | ST720104 | Locate events, compute magnitudes and focal mechanisms |
| ST720105 | ST720105 | Generate high-resolution event catalog |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| HIGH_RESOLUTION_CATALOG |  | File | Final high-resolution seismic event catalog |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1991
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata