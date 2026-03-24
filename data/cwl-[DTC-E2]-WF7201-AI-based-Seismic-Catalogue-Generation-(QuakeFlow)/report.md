# [DTC-E2] WF7201: AI-based Seismic Catalogue Generation (QuakeFlow) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://dtgeo.eu/
- **Package**: https://workflowhub.eu/workflows/1991
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1991/ro_crate?version=1
- **Source repository (git):** https://github.com/AI4EPS/QuakeFlow
- **Conda**: N/A
- **Total Downloads**: 88
- **Last updated**: 2025-10-14
- **GitHub**: https://github.com/AI4EPS/QuakeFlow
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `WF7201.cwl` (Main Workflow)
- **Project**: WP7 - Earthquakes
- **Views**: 615
- **Creators**: Margarita Segou, Johannes Kemper

## Description

## Overview
This repository contains the **Common Workflow Language (CWL)** and **RO-Crate metadata** definition for **WF7201**, the **AI-based Seismic Catalogue Generation** workflow of **DTC-E2**, developed under the [DT-GEO project](https://dtgeo.eu).  

**WF7201** integrates advanced machine learning models for seismic signal detection and catalog generation within a unified, scalable computational framework. It builds upon **[QuakeFlow](https://github.com/AI4EPS/QuakeFlow)** — a deep-learning-based earthquake monitoring pipeline — to automate waveform ingestion, event detection, association, location, and catalog generation.

The workflow enables near-real-time seismic catalogue creation from waveform data, supporting downstream digital twin components for earthquake analysis and forecasting.

## Workflow Structure

The workflow integrates several sequential stages for data ingestion, AI-driven detection, and catalog production:

1. **Workflow Inputs**
   - **WAVEFORMS** – Continuous seismic waveform data from multiple stations.  
   - **DT7205 (AlpArray Catalogue)** – Example dataset from the *AlpArray Network* (EIDA download via ObsPy).  

2. **Processing Steps**
   - **ST720101:** Waveform ingestion and pre-processing (e.g., filtering, normalization).  
   - **ST720102:** AI-based phase picking using neural network models from QuakeFlow.  
   - **ST720103:** Event association to link picks to potential earthquake events.  
   - **ST720104:** Event location and magnitude estimation.  
   - **ST720105:** High-resolution catalogue generation and export.  

3. **Workflow Output**
   - **HIGH_RESOLUTION_CATALOG** – AI-generated earthquake catalogue containing high-precision event locations and magnitudes.
