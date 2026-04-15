---
name: genetic-design
description: This synthetic biology workflow processes rpSBML and GEM SBML files using tools like Selenzyme, Parts Genie, and DNA Weaver to automate the design of genetic constructs for metabolic pathways. Use this skill when you need to select optimal enzymes for a metabolic route, design genetic parts for pathway expression, and generate assembly plans for DNA synthesis.
homepage: https://www.ibisba.eu
metadata:
  docker_image: "N/A"
---

# genetic-design

## Overview

This Galaxy workflow provides an automated pipeline for the genetic design and assembly of metabolic pathways. It begins by processing metabolic models in rpSBML and GEM SBML formats, using [Selenzyme](https://selenzyme.synbiochem.ac.uk/) to identify and rank candidate enzymes for specific reactions based on taxonomic relevance and sequence similarity.

The pipeline converts these metabolic designs into the Synthetic Biology Open Language (SBOL) standard using [rpSBMLtoSBOL](https://github.com/brsynth/rpSBMLtoSBOL). It then integrates [Parts Genie](https://github.com/synbiochem/PartsGenie) and [OptDoE](https://github.com/brsynth/rpOptBioDes) to optimize the selection of genetic parts and apply Design of Experiments (DoE) principles, ensuring the most efficient biological configurations are selected for downstream construction.

In the final stages, the workflow facilitates the physical implementation of the designed sequences. [DNA Weaver](https://github.com/Edinburgh-Genome-Foundry/DnaWeaver) is used to determine the optimal assembly strategy, while [LCR Genie](https://github.com/synbiochem/LCRGenie) generates the necessary instructions for Ligase Cycling Reaction (LCR) assembly. This end-to-end process bridges the gap between computational pathway design and laboratory-ready DNA construction protocols.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | rpSBML TAR | data_input |  |
| 1 | GEM SBML | data_input |  |
| 2 | Max (UNIPROT) enzymes per reactions | parameter_input |  |
| 3 | Top pathways to convert to SBOL | parameter_input |  |
| 4 | List of genetic parts | data_input |  |


Ensure the rpSBML input is provided as a valid TAR archive and the Genome-Scale Model (GEM) is in standard SBML format to avoid tool execution errors. When handling multiple pathways, utilizing Galaxy collections for the SBOL outputs can significantly streamline the downstream DNA assembly and LCR Genie steps. For precise formatting requirements regarding the genetic parts list and specific parameter constraints, refer to the `README.md` file. You may also use `planemo workflow_job_init` to create a `job.yml` for automated execution and testing of the design pipeline.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Extract Taxonomy | extractTaxonomy |  |
| 6 | Selenzyme | rpSelenzyme |  |
| 7 | SBML to SBOL | rpSBMLtoSBOL |  |
| 8 | Parts Genie | PartsGenie |  |
| 9 | OptDoE | rpOptBioDes |  |
| 10 | DNA Weaver | DNAWeaver |  |
| 11 | LCR Genie | LCRGenie |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | output | output |
| 7 | output | output |
| 8 | output | output |
| 9 | Pathway SBOLs | output |
| 10 | output | output |
| 11 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Genetic_Design.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Genetic_Design.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Genetic_Design.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Genetic_Design.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Genetic_Design.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Genetic_Design.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)