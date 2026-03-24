# workflow-0 CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://parisbiofoundry.org/the-asu-biofoundry/
- **Package**: https://workflowhub.eu/workflows/1768
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1768/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 235
- **Last updated**: 2025-10-21
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `workflow-0.ga` (Main Workflow)
- **Project**: DNA Foundry
- **Views**: 1735

## Description

# Generate annotated gb for fragments and add them to DB

Automatically generate annotated **GenBank** files for your fragments based on your constraints and store them in your database.

## steps:

_input_: **GenBank** files : If your fragments are not in the database, you can generate GenBank files for each fragment to be used as input for the annotation workflow and then passed to the _evaluate_manufacturability_ tool.
> evaluate_manufacturability
1. Set the constraints for the annotations.
2. Generate annotated GenBank files and pass them to the _seq_to_db_ tool.
> seq_to_db
1. Annotated GenBank files can be saved to the database, depending on the user's choice.
