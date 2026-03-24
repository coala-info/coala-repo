# Clonal population analysis for TracerX study CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://eosc4cancer.eu
- **Package**: https://workflowhub.eu/workflows/1355
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1355/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 328
- **Last updated**: 2025-05-26
- **GitHub**: https://github.com/elixir-oslo/cbioportal-docker-compose
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-clonal_population.ga` (Main Workflow)
- **Project**: EOSC4Cancer
- **Views**: 2542

## Description

The Galaxy workflow for clonal population analysis was designed to process patient mutation data extracted from cBioPortal, specifically using the TracerX study as an example. This workflow, part of the deliverable D3.2 for EOSC4Cancer developed at UiO, begins with a raw patient mutation table from cBioPortal, where modifications and formatting occur to prepare the data for analysis. Some data, notably the copy number alterations (referred to as "All_CN"), were manually uploaded to Galaxy to complement the mutation data, as this information was missing in cBioPortal.

The workflow facilitates the integration of various datasets by utilizing tools that enable the easy export of processed data back to cBioPortal for comparison and further analysis. Key steps in the workflow include:
* **Data Input**: The raw mutation data from cBioPortal and the uploaded copy number alteration data are ingested.
* **Query Tabular**: This step extracts and formats the necessary data for PyClone-VI, a tool used for inferring clonal population structures.
* **Data Merging and Filtering**: The workflow merges mutation data with copy number data and filters incomplete entries to ensure quality inputs for analysis.
* **Running PyClone-VI**: The formatted data is then analyzed using PyClone-VI to model clonal evolution.
* **Visualization**: Outputs from PyClone-VI are visualized through cellular prevalence graphs to illustrate clonal dynamics over time.
* **Export to cBioPortal**: Finally, the results, along with relevant plots, are exported back to cBioPortal, allowing researchers to link findings directly within the resource.

The design of this workflow enhances the analytical capabilities available to researchers by integrating diverse cancer data and providing a seamless pathway for data management and visualization across platforms, all achieved as part of the EOSC4Cancer initiative.

**Requirements**

To successfully deploy the Galaxy workflow and the associated components, the following requirements must be met:
* **Intermediary Server**: A custom server developed to act as a bridge between cBioPortal and Galaxy. This server handles API requests from cBioPortal and interacts with Galaxy using Bioblend. It is essential for the integration of the two platforms.
* **Docker**: The workflow components can be orchestrated using Docker. 

A full example of the setup can be found at the following repository: https://github.com/elixir-oslo/cbioportal-docker-compose

For more details on the tools and wrappers used in this workflow, please visit our GitHub repositories:
cBioPortal Frontend: https://github.com/cBioPortal/cbioportal-frontend
cBioPortal Backend: https://github.com/cBioPortal/cbioportal/tree/tmr
Wrapper for PyClone-VI: https://github.com/iuc/galaxy-tool-pyclone-vi
Intermediary Server: https://github.com/your-repo/cbioportal-galaxy-connector
Plotting for PyClone-VI Output: https://github.com/your-repo/galaxy-tool-plot-cluster-prevalence
Export Resource Image to cBioPortal: https://github.com/your-repo/galaxy-tool-export-cbioportal-image
Export Timeline Data to cBioPortal: https://github.com/your-repo/galaxy-tool-export-cbioportal-timeline
Galaxy Server with Tools: https://github.com/your-repo/docker-galaxy-pyclone
