---
name: genetic-design-basic-assembly
description: "This workflow automates the design of genetic constructs for metabolic pathways using Selenzyme for enzyme selection, BasicDesign for assembly planning, and DNA-Bot for generating laboratory automation scripts from SBML and taxonomic inputs. Use this skill when you need to translate a theoretical metabolic pathway into physical DNA assembly instructions and robotic liquid handling scripts for BASIC assembly in a specific host organism."
homepage: https://workflowhub.eu/workflows/2009
---

# Genetic Design (BASIC Assembly)

## Overview

This workflow automates the transition from a metabolic pathway to physical genetic constructs using the Biopart Assembly Standard for Idempotent Cloning (BASIC) method. It begins with [Selenzyme](https://toolshed.g2.bx.psu.edu/repos/tduigou/selenzy/selenzy-wrapper/0.2.0), which performs enzyme selection by ranking protein sequences based on their taxonomic distance to a target host and their catalytic relevance to the input SBML pathway.

Following enzyme selection, [BasicDesign](https://toolshed.g2.bx.psu.edu/repos/tduigou/rpbasicdesign/rpbasicdesign/0.3.4) generates combinatorial genetic constructs. It integrates user-provided linkers and parts to create standardized assembly instructions, outputting data in formats such as SBOL and CSV plate maps (Biolegio and User parts) necessary for laboratory execution.

The final stage utilizes [DNA-Bot](https://toolshed.g2.bx.psu.edu/repos/tduigou/dnabot/dnabot/3.1.0) to translate these designs into actionable instructions for liquid-handling robots. The workflow produces a comprehensive set of outputs, including Uniprot IDs for selected enzymes and the specific Python scripts required to automate the physical assembly of the genetic constructs. This toolset is tagged for **brs** and **assembly** applications.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Pathway (SBML) | data_input |  |
| 1 | Host taxon ID | parameter_input |  |
| 2 | Enzyme taxon IDs | parameter_input |  |
| 3 | Linkers and user parts | data_input |  |
| 4 | DNA-Bot settings | data_input |  |


Ensure the pathway is provided in SBML format, while linkers and user parts should be formatted as CSV files compatible with BASIC assembly standards. Use individual datasets for the SBML and settings files, but consider using collections if you are processing multiple pathway variants through the design pipeline. Taxon IDs must be valid NCBI identifiers to ensure Selenzyme correctly filters enzyme candidates for the specified host and source organisms. Refer to the included README.md for comprehensive details on CSV formatting and specific DNA-Bot configuration parameters. You can automate the execution setup by generating a `job.yml` file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Selenzyme | toolshed.g2.bx.psu.edu/repos/tduigou/selenzy/selenzy-wrapper/0.2.0 |  |
| 6 | BasicDesign | toolshed.g2.bx.psu.edu/repos/tduigou/rpbasicdesign/rpbasicdesign/0.3.4 |  |
| 7 | DNA-Bot | toolshed.g2.bx.psu.edu/repos/tduigou/dnabot/dnabot/3.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | Uniprot IDs | uniprot_ids |
| 5 | uniprot_ids_csv | uniprot_ids_csv |
| 6 | Constructs | Constructs |
| 6 | User parts plate | User parts plate |
| 6 | sbol_dir | sbol_dir |
| 6 | Biolegio plate | Biolegio plate |
| 7 | dnabot_scripts | dnabot_scripts |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Genetic_Design_(BASIC_Assembly).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Genetic_Design_(BASIC_Assembly).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Genetic_Design_(BASIC_Assembly).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Genetic_Design_(BASIC_Assembly).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Genetic_Design_(BASIC_Assembly).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Genetic_Design_(BASIC_Assembly).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
