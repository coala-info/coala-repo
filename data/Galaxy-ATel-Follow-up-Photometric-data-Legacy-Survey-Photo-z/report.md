# ATel Follow-up Photometric data Legacy Survey Photo-z CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://eurosciencegateway.eu/
- **Package**: https://workflowhub.eu/workflows/1353
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1353/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 548
- **Last updated**: 2025-08-14
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-ATel_Follow-up_Photometric_data_Legacy_Survey_Photo-z.ga` (Main Workflow)
- **Project**: EuroScienceGateway
- **Views**: 2986
- **Creators**: Andrei Variu

## Description

This workflow analyses a given astrophysics text (e.g. Astronomer's Telegram https://astronomerstelegram.org/). It extracts positions of mentioned astronomical sources and provides possible optical counter-parts with photometric data. The corresponding photometric data can be further used to estimate the redshit of the optical sources, that is a measure of the distance between the Earth and the optical source.

Given the fact that the the tool that estimates the photometric redshift is still in staging mode on a local instance, due to non-standard package channels, the entire workflow can be found on the local galaxy instance:
https://galaxy.odahub.fr/u/andreiv/w/atel-follow-up-photometric-data-legacy-survey-photoz

The workflow withtout the last tool can be found on the usegalaxy.eu instance:
https://usegalaxy.eu/u/avariu/w/atel-follow-up-photometric-data-legacy-survey
