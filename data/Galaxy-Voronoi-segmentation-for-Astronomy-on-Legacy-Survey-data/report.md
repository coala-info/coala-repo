# Voronoi segmentation for Astronomy on Legacy Survey data CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://eurosciencegateway.eu/
- **Package**: https://workflowhub.eu/workflows/1730
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1730/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 350
- **Last updated**: 2025-07-11
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Voronoi_segmentation_for_Astronomy_on_Legacy_Survey_data.ga` (Main Workflow)
- **Project**: EuroScienceGateway
- **Views**: 2324
- **Creators**: Andrei Variu, Riccardo Massei, Even Moa  Myklebust

## Description

Modified workflow to perform Voronoi segmentation, based on https://usegalaxy.eu/published/workflow?id=23030421cd9fcfb2.

Input requirements: 
* RA: 
-- right ascension in degrees as a float number.
* Dec: 
-- Declination in degrees as a float number
* Radius: 
-- the radius of the cone to be queried in arcminutes as a float number
* Pixel size: 
-- the size of the pixel in arcseconds
* Band: 
-- the band (channel) of the image: g, r, z, i
