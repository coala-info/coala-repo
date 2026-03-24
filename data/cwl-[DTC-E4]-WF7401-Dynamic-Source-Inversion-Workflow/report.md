# [DTC-E4] WF7401: Dynamic Source Inversion Workflow CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://dtgeo.eu/
- **Package**: https://workflowhub.eu/workflows/1994
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1994/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 173
- **Last updated**: 2025-10-14
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `WF7401.cwl` (Main Workflow)
- **Project**: WP7 - Earthquakes
- **Views**: 566
- **Creators**: Nico Schliwa, Johannes Kemper

## Description

## Overview
This repository contains the **Common Workflow Language (CWL)** and **RO-Crate metadata** definition for **WF7401**, the **Dynamic Source Inversion** workflow of **DTC-E4**, developed under the [DT-GEO project](https://dtgeo.eu).  

The **WF7401** workflow performs **dynamic source inversion of earthquakes** using seismic and geodetic data. It prepares input data, executes high-performance computing (HPC) inversions, and extracts rupture models to characterize the physical parameters of earthquake sources.

The workflow leverages the **FD3D_TSN** inversion code, combining a quasi-dynamic boundary element solver and a Bayesian inversion framework with Parallel Tempering Monte Carlo to estimate model parameters and uncertainties.

## Workflow Structure

1. **Workflow Inputs**
   - **DT7401 – Dynamic Source Inversion Input**: Input dataset including fault geometry, velocity models, and seismic and geodetic data from arrays of seismic and GPS stations.  

2. **Processing Steps**
   - **ST740101:** Input data preparation and format standardization.  
   - **ST740102:** Configuration of the FD3D_TSN inversion model.  
   - **ST740103:** Execution of HPC-based inversion for rupture dynamics.  
   - **ST740104:** Post-processing and extraction of rupture parameters (prestress, friction, misfits).  
   - **ST740105:** Generation of final model products and metadata export.  

3. **Workflow Outputs**
   - **DT7402 – Dynamic Source Inversion Output**: Model input parameters, rupture characteristics, and misfit statistics in text and binary formats.
