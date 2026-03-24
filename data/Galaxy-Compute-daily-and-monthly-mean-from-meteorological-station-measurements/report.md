# Compute daily and monthly mean from meteorological station measurements CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://workflowhub.eu/workflows/123
- **Package**: https://workflowhub.eu/workflows/123
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/123/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 888
- **Last updated**: 2023-01-16
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: GPL-3.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Compute_daily_and_monthly_mean_from_meteorological_station_measurements.ga` (Main Workflow)
- **Project**: Galaxy Climate
- **Views**: 7371

## Description

This workflow is used to process timeseries from meteorological stations in Finland but can be applied to any timeseries according it follows the same format.

Take a temperature timeseries from any meteorological station. Input format is csv and it must be standardized with 6 columns:

1. Year	(ex: 2021)
2. month	(ex: 1)
3. day	(ex: 15) 
4. Time	(ex: 16:56)
5. Time zone	(such as UTC)
6. Air temperature (degC)
