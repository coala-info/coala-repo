# Domestication and cloning simulation workflow CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://parisbiofoundry.org/the-asu-biofoundry/
- **Package**: https://workflowhub.eu/workflows/2001
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/2001/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 144
- **Last updated**: 2025-10-17
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Domestication_and_cloning_simulation_workflow_v2.ga` (Main Workflow)
- **Project**: DNA Foundry
- **Views**: 1100

## Description

# Domestication of new parts and cloning simulation
Add new parts to your sequences before the cloning simulation and interact with the database.

## input:

* _input: csv file (without header)_ : The **CSV** file should contain the constraints line by line in the first column, along with their associated fragments on each line. This data will be passed to the seq_from_DB tool.
* _JSON parameters file (optional)_ : The **JSON** file should contain the the parameters used in workflow tools. If this input is not set, user should set the parameters mannualy in the maystro tool.
* _Missing Fragments (optional)_ : The **collection** of GenBank files that are not present in the database ( [make collection](https://training.galaxyproject.org/training-material/topics/galaxy-interface/tutorials/collections/tutorial.html)). If a fragment is listed in the Assembly Plan CSV but missing from the database, it must be provided through this input.
* _Assembly Standard_ : The **CSV** file is crutial for the working of domestication tool.
* _New fragments for cloning similation (optional)_ : The **collection** of GenBank files ( [make collection](https://training.galaxyproject.org/training-material/topics/galaxy-interface/tutorials/collections/tutorial.html)). This applies only when the user wishes to incorporate additional fragments into the cloning simulation that are not part of the domestication process.

## steps:

>_workflow_2 Parameter_Maystro_

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

> _sculpt_sequences_

1. Set the constraints for the sculpt.
2. Generate sculpted and unsculpted sequences and pass all GenBank files to _domestication_of_new_parts_ tool.

> _domestication_of_new_parts_

1. Import new parts from a CSV file.
2. Perform domestication of the new parts in the sequences, generate reports, and create domesticated GenBank files and pass them to _seq_to_db_ tool.

 >_clonning_simulation_

1. GoldenGate cloning simulation based on constraints.
2. Generate GenBank files for each simulated constraint.

>_seq_to_db_

1. Constraint GenBank files can be saved to the database, depending on the user's choice.
