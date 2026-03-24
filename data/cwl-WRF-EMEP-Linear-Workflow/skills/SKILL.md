---
name: wrf-emep-linear-workflow
description: "This CWL workflow processes ERA5 reanalysis data and geographic inputs using the Weather Research and Forecasting (WRF) and EMEP models to simulate regional meteorology and atmospheric chemistry. Use this skill when characterizing regional air quality, assessing the dispersion of atmospheric pollutants, or investigating the impact of meteorological conditions on chemical transport."
homepage: https://workflowhub.eu/workflows/455
---
# WRF / EMEP Linear Workflow

## Overview

The [WRF / EMEP Linear Workflow](https://workflowhub.eu/workflows/455) is a Common Workflow Language (CWL) pipeline designed to execute the Weather Research and Forecasting (WRF) and EMEP chemistry and transport models in sequence. It is optimized for a single model domain and automates the transition from raw meteorological data to atmospheric chemistry simulations.

The workflow follows a five-stage linear progression:
1.  **ERA5 Data Acquisition:** Downloads meteorological data from the Copernicus Climate Data Store (CDS).
2.  **Geogrid Processing:** Generates terrestrial geography files using WPS.
3.  **WPS Metgrid:** Performs ungribbing of ERA5 data and produces meteorology files.
4.  **WRF Execution:** Runs the REAL initialization program followed by the WRF model.
5.  **EMEP Simulation:** Executes the EMEP model for chemistry and transport analysis using WRF outputs.

Users can execute the full pipeline using `cwltool` or Toil, or run individual steps independently for modular testing. The workflow requires Docker or Singularity for containerized execution and utilizes MPI for parallel processing during the REAL, WRF, and EMEP stages. Example datasets for testing are available via [Zenodo](https://doi.org/10.5281/zenodo.7817216).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| start_year | Year for starting date | int |  |
| start_month | Month for starting date | int |  |
| start_day | Day for starting date | int |  |
| end_year | Year for end date | int |  |
| end_month | Month for end date | int |  |
| end_day | Day for end date | int |  |
| north_latitude | Latitude for top of domain | int |  |
| south_latitude | Latitude for bottom of domain | int |  |
| west_longitude | Longitude for left-edge of domain | int |  |
| east_longitude | Longitude for right-edge of domain | int |  |
| cdskey | API key for CDS service | File |  |
| https_proxy | HTTPS proxy information, if needed | string? |  |
| geodir | Geographic inputs for geogrid | Directory |  |
| namelist_geogrid | Geogrid namelist | File |  |
| geotable | Geogrid data table | File |  |
| namelist_ungrib_atm | Configuration File | File |  |
| vtable_atm | grib variable table | File |  |
| outname_atm |  | string |  |
| namelist_ungrib_sfc | Configuration File | File |  |
| vtable_sfc | grib variable table | File |  |
| outname_sfc |  | string |  |
| namelist_metgrid | metgrid configuration | File |  |
| generate_metdir |  | boolean |  |
| namelist_real | Real preprocessor Configuration File | File |  |
| namelist_wrf | WRF Configuration File | File |  |
| realcores |  | int |  |
| wrfcores |  | int |  |
| generate_rundir |  | boolean |  |
| namelist_emep | EMEP configuration file | File |  |
| inputdir_emep | EMEP Input Files | Directory |  |
| runlabel_emep | EMEP run label, for output files, should match 'runlabel1' in namelist | string |  |
| metdir_name | Directory name for WRF input Files, should match 'meteo' base-directory in namelist | string |  |
| emepcores |  | int |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step1_era5_workflow | step1_era5_workflow |  |
| step2_geogrid_workflow | step2_geogrid_workflow |  |
| step3_wps_workflow | step3_wps_workflow |  |
| step4_wrf_workflow | step4_wrf_workflow |  |
| step5_emep_workflow | step5_emep_workflow |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| wrfout | output files | array |  |
| emepout | output files | array |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/455
- `wrf_emep_full_workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
