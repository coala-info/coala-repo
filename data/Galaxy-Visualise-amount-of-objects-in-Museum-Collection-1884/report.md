# Visualise amount of objects in Museum Collection CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://training.galaxyproject.org
- **Package**: https://workflowhub.eu/workflows/1884
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1884/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 220
- **Last updated**: 2025-08-25
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Visualise_amount_of_objects_in_Museum_Collection.ga` (Main Workflow)
- **Project**: Galaxy Training Network
- **Views**: 1710
- **Creators**: Daniela Schneider

## Description

This workflow applies text mining to a museum collection in tabular format to extract from which year most objects derive and what they are.
The first steps are filtering and data cleaning to put the data in correct format. 
Datamash allows showing how many documents from what year the museum catalogue contains.
The output is a chronological table which is visualised as a bar chart.
From that, the year where most items derived from is extracted. The next step filters items only from that year.
The object description from all of those items is extracted to visualise what content the museum own from that year.
