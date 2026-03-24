---
name: genetic-design-basic-assembly
description: "This synthetic biology workflow automates the design of plasmids for metabolic pathways using SBML files, taxon IDs, and linkers via Selenzyme, BasicDesign, and DNA-Bot. Use this skill when you need to translate predicted biochemical pathways into physical genetic constructs and generate executable instructions for automated DNA assembly using the BASIC method."
homepage: https://workflowhub.eu/workflows/1576
---

# Genetic Design (BASIC Assembly)

## Overview

This workflow automates the design of plasmids for metabolic pathways using the [Biopart Assembly Standard for Idempotent Cloning (BASIC)](https://doi.org/10.1021/sb500356d) method. It streamlines the transition from a theoretical metabolic pathway to actionable laboratory instructions, supporting high-throughput synthetic biology projects.

The process begins by taking a pathway in SBML format and identifying optimal enzyme sequences via [Selenzyme](https://toolshed.g2.bx.psu.edu/repos/tduigou/selenzy/selenzy-wrapper/0.2.0). This tool ranks candidates based on taxonomic distance to the host and sequence similarity. Following selection, [BasicDesign](https://toolshed.g2.bx.psu.edu/repos/tduigou/rpbasicdesign/rpbasicdesign/0.3.4) generates standardized genetic constructs by integrating user-provided parts and linkers, outputting SBOL files and detailed plate maps.

In the final stage, [DNA-Bot](https://toolshed.g2.bx.psu.edu/repos/tduigou/dnabot/dnabot/3.1.0) translates these designs into executable scripts for liquid-handling robots. This ensures that the computational designs are ready for physical assembly in the lab. This workflow is a key component of the [GTN](https://training.galaxyproject.org/) framework for automated synthetic biology design.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Pathway (SBML) | data_input |  |
| 1 | Host taxon ID | parameter_input |  |
| 2 | Enzyme taxon IDs | parameter_input | Comma separated values |
| 3 | Linkers and user parts | data_input |  |
| 4 | DNA-Bot settings | data_input |  |


Ensure the pathway is provided in SBML format and that linkers and user parts are formatted as CSV files compatible with the BASIC assembly protocol. While initial inputs are individual datasets, the workflow generates complex outputs like SBOL directories that are best managed as collections for high-throughput design. Consult the README.md for precise details on taxon ID syntax and the specific JSON structure required for DNA-Bot settings. For automated execution and testing, you can use planemo workflow_job_init to generate a job.yml file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Selenzyme | toolshed.g2.bx.psu.edu/repos/tduigou/selenzy/selenzy-wrapper/0.2.0 | Performs enzyme selection from a reaction query. |
| 6 | BasicDesign | toolshed.g2.bx.psu.edu/repos/tduigou/rpbasicdesign/rpbasicdesign/0.3.4 | Extracts enzyme IDs from rpSBML files. |
| 7 | DNA-Bot | toolshed.g2.bx.psu.edu/repos/tduigou/dnabot/dnabot/3.1.0 | DNA assembly using BASIC on OpenTrons. |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | uniprot_ids_csv | uniprot_ids_csv |
| 5 | Uniprot IDs | uniprot_ids |
| 6 | Constructs | Constructs |
| 6 | User parts plate | User parts plate |
| 6 | sbol_dir | sbol_dir |
| 6 | Biolegio plate | Biolegio plate |
| 7 | dnabot_scripts | dnabot_scripts |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run genetic-design-basic-assembly.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run genetic-design-basic-assembly.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run genetic-design-basic-assembly.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init genetic-design-basic-assembly.ga -o job.yml`
- Lint: `planemo workflow_lint genetic-design-basic-assembly.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `genetic-design-basic-assembly.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
