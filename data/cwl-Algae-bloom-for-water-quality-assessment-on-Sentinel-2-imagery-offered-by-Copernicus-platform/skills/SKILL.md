---
name: algae-bloom-for-water-quality-assessment-on-sentinel-2-image
description: This Common Workflow Language pipeline filters Sentinel-2 satellite imagery from the Copernicus platform and performs band calculations to detect algae blooms. Use this skill when you need to monitor aquatic ecosystems for harmful algal blooms or assess surface water quality using multispectral satellite data.
homepage: https://crim.ca
metadata:
  docker_image: "N/A"
---

# algae-bloom-for-water-quality-assessment-on-sentinel-2-image

## Overview

This Common Workflow Language (CWL) workflow automates the assessment of algae blooms for water quality monitoring using Sentinel-2 satellite imagery. It is designed to interface with the Copernicus platform to identify, retrieve, and analyze relevant multispectral data for environmental engineering and data visualization purposes.

The execution logic follows a two-stage process:
* **Product Selection**: The `select_products` step queries the Copernicus catalog using specific filtering parameters to isolate the required Sentinel-2 imagery.
* **Band Calculation**: The `process` step performs mathematical operations on the retrieved image bands to evaluate algae bloom intensity and distribution.

The workflow is hosted on [WorkflowHub](https://workflowhub.eu/workflows/2032) and is licensed under CC-BY-NC-SA-4.0. It provides a standardized approach for researchers to perform repeatable water quality calculations on remote sensing data.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| date |  | string |  |
| delta |  | int? |  |
| aoi |  | File |  |
| collection |  | string |  |
| cloud_cover |  | double? |  |
| s3_access_key | S3 access key required to retrieve products hosted on a protected S3 location. | string | Access key to Copernicus data provider. See https://documentation.dataspace.copernicus.eu/Registration.html  and https://documentation.dataspace.copernicus.eu/APIs/S3.html#generate-secrets for details.  |
| s3_secret_key | S3 secret key required to retrieve products hosted on a protected S3 location. | string | Access key to Copernicus data provider. See https://documentation.dataspace.copernicus.eu/Registration.html  and https://documentation.dataspace.copernicus.eu/APIs/S3.html#generate-secrets for details.  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| select_products | select_products |  |
| process | process |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| chlorophyll_a |  | File[] |  |
| chlorophyll_a_color |  | File[] |  |
| chlorophyll_a_plot |  | File[] |  |
| cyanobacteria |  | File[] |  |
| cyanobacteria_color |  | File[] |  |
| cyanobacteria_plot |  | File[] |  |
| turbidity |  | File[] |  |
| turbidity_color |  | File[] |  |
| turbidity_plot |  | File[] |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/2032
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata