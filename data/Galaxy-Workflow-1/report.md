# Workflow-1 CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://parisbiofoundry.org/the-asu-biofoundry/
- **Package**: https://workflowhub.eu/workflows/1877
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1877/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 219
- **Last updated**: 2025-08-19
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Unnamed_Workflow.ga` (Main Workflow)
- **Project**: DNA Foundry
- **Views**: 1552

## Description

# Cloning simulation workflow for sequences present in DB

Run the GoldenGate cloning simulation for a list of constructs in a CSV file and interact with a database

## steps:

_input: csv file (without header)_ : The **CSV** file should contain the constraints line by line in the first column, along with their associated fragments on each line. This data will be passed to the _seq_from_DB_ tool.

>_workflow_1 Parameter_Maystro_

1. Distribute workflow parameters on the workflow tools
2. Parameters can be set as a JSON file in input (optional)
3.  Parameters can be manually instate of JSON file

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
