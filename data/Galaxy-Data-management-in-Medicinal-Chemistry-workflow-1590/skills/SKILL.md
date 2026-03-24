---
name: data-management-in-medicinal-chemistry-workflow
description: "This medicinal chemistry workflow processes chemical inputs like benzenesulfonyl chloride and ethylamine using OpenBabel, ChEMBL database searches, and reaction modeling tools. Use this skill when you need to simulate chemical reactions between precursors, identify related substructures in the ChEMBL database, and evaluate the drug-likeness of resulting molecular products."
homepage: https://workflowhub.eu/workflows/1590
---

# Data management in Medicinal Chemistry workflow

## Overview

This Galaxy workflow facilitates essential data management and analysis tasks within a medicinal chemistry context. It begins by importing chemical structures, such as Benzenesulfonyl chloride and Ethylamine, and utilizes [Open Babel](https://toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/3.1.1+galaxy0) for format conversion into SDF files. These inputs serve as the basis for chemical reaction modeling and database searching.

The pipeline integrates with the [ChEMBL database](https://toolshed.g2.bx.psu.edu/repos/bgruening/chembl/chembl/0.10.1+galaxy4) to identify relevant substructures and Lipinski-compliant molecules. A core component of the workflow is the Reaction Maker tool, which simulates chemical reactions between the processed inputs to generate new product molecules.

Final outputs include high-quality SVG visualizations of the reaction products and a comprehensive drug-likeness assessment using [QED (Quantitative Estimate of Drug-likeness)](https://toolshed.g2.bx.psu.edu/repos/bgruening/qed/ctb_silicos_qed/2021.03.4+galaxy0). This workflow is tagged under [GTN](https://training.galaxyproject.org/) and is licensed under CC-BY-4.0, making it a standardized resource for computational chemistry training and research.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Benzenesulfonyl chloride | data_input | First input molecule |
| 1 | Ethylamine | data_input | Second input molecule |


Ensure the input chemical structures are provided in standard formats like SMILES or SDF to facilitate seamless conversion by OpenBabel during the initial steps. When handling multiple chemical entities, organize them into dataset collections to simplify batch processing through the ChEMBL search and reaction maker tools. Consult the README.md for comprehensive details on specific chemical properties and input requirements. For automated execution and testing, you can generate a `job.yml` file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/3.1.1+galaxy0 |  |
| 3 | Search ChEMBL database | toolshed.g2.bx.psu.edu/repos/bgruening/chembl/chembl/0.10.1+galaxy4 |  |
| 4 | Search ChEMBL database | toolshed.g2.bx.psu.edu/repos/bgruening/chembl/chembl/0.10.1+galaxy4 |  |
| 5 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/3.1.1+galaxy0 |  |
| 6 | Reaction maker | toolshed.g2.bx.psu.edu/repos/bgruening/ctb_im_rxn_maker/ctb_im_rxn_maker/1.1.4+galaxy0 |  |
| 7 | Visualisation | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_svg_depiction/openbabel_svg_depiction/3.1.1+galaxy0 |  |
| 8 | Drug-likeness | toolshed.g2.bx.psu.edu/repos/bgruening/qed/ctb_silicos_qed/2021.03.4+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Benzenesulfonyl chloride SDF | outfile |
| 3 | Substructures from ChEMBL database | outfile |
| 4 | Lipinski substructures from ChEMBL database | outfile |
| 5 | Ethylamine SDF | outfile |
| 6 | Reaction product | outfile |
| 6 | Reaction maker logfile | logfile |
| 7 | Visualisation of reaction product | outfile |
| 8 | Drug-likeness of product molecule | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run data-management-in-medicinal-chemistry-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run data-management-in-medicinal-chemistry-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run data-management-in-medicinal-chemistry-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init data-management-in-medicinal-chemistry-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint data-management-in-medicinal-chemistry-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `data-management-in-medicinal-chemistry-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
