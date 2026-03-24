# Cloning Simulation workflow CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://parisbiofoundry.org/the-asu-biofoundry/
- **Package**: https://workflowhub.eu/workflows/2000
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/2000/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 162
- **Last updated**: 2025-10-17
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Cloning_Simulation_workflow_v2.ga` (Main Workflow)
- **Project**: DNA Foundry
- **Views**: 1117

## Description

# Cloning simulation workflow for sequences present in DB

Run the GoldenGate cloning simulation for a list of constructs in a CSV file and interact with a database

## inputs:

* _Assmbly Plan (without header)_ : The **CSV** file should contain the constraints line by line in the first column, along with their associated fragments on each line. This data will be passed to the _seq_from_DB_ tool.
* _JSON parameters file (optional)_ : The **JSON** file should contain the the parameters used in workflow tools. If this input is not set, user should set the parameters mannualy in the maystro tool.
* _Missing Fragments (optional)_ : The **collection** of GenBank files that are not present in the database ( [make collection](https://training.galaxyproject.org/training-material/topics/galaxy-interface/tutorials/collections/tutorial.html)). If a fragment is listed in the Assembly Plan CSV but missing from the database, it must be provided through this input.

## steps:

>_workflow_1 Parameter_Maystro_

1. Distribute workflow parameters on the workflow tools
2. Parameters can be set as a JSON file in input (optional)
3.  Parameters can be manually instate of JSON file
4.  For the first use, it is recommended to set the parameters manually in the tool. A JSON file will then be generated automatically for use in subsequent runs.

>_seq_from_DB_

1. Extract the fragments associated with each constraint from the CSV file.
2. Check if all fragments are present in the database.
        
>_evaluate_manufacturability_
        
1. If any fragment is missing it will serve from the unannotated Genbenk provided to annotate them and add them to the finale gb collection
2. If all fragments are present in the database, GenBank files for each fragment will be passed to the cloning_simulation tool.

 >_clonning_simulation_

1. GoldenGate cloning simulation based on constraints.
2. Generate GenBank files for each simulated constraint.

>_seq_to_db_

1. Constraint GenBank files can be saved to the database, depending on the user's choice.
