# workflow-2 CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://parisbiofoundry.org/the-asu-biofoundry/
- **Package**: https://workflowhub.eu/workflows/1784
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1784/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 223
- **Last updated**: 2025-07-01
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-workflow-2.ga` (Main Workflow)
- **Project**: DNA Foundry
- **Views**: 1757

## Description

# Domestication of new parts before cloning simulation
Add new parts to your sequences before the cloning simulation and interact with the database.
## steps:
_input: csv file (without header)_ : The CSV file should contain the constraints line by line in the first column, along with their associated fragments on each line. This data will be passed to the seq_from_DB tool.
> seq_from_DB
1. Extract the fragments associated with each constraint from the CSV file.
2. Check if all fragments are present in the database. If any fragment is missing, an error will be raised --> [workflow-0](https://workflowhub.eu/workflows/1768))
3. If all fragments are present in the database, GenBank files for each fragment will be generated and passed to the _sculpt_sequences_ tool.
> sculpt_sequences
1. Set the constraints for the sculpt.
2. Generate sculpted and unsculpted sequences and pass all GenBank files to _domestication_of_new_parts_ tool.
> domestication_of_new_parts
1. Import new parts from a CSV file.
2. Perform domestication of the new parts in the sequences, generate reports, and create domesticated GenBank files and pass them to _seq_to_db_ tool.
> seq_to_db
1. Domesticated GenBank files can be saved to the database, depending on the user's choice.
