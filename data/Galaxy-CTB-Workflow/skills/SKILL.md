---
name: ctb-workflow
description: "This computational chemistry workflow retrieves online chemical data and utilizes OpenBabel and ChemFP tools to perform molecular cleaning, filtering, and fingerprint-based clustering. Use this skill when you need to prepare a high-quality compound library by removing fragments and duplicates, assessing natural product likeness, or identifying structural relationships between molecules."
homepage: https://workflowhub.eu/workflows/1649
---

# CTB Workflow

## Overview

The CTB Workflow is a comprehensive computational chemistry pipeline designed for the automated processing and analysis of chemical datasets within the [Galaxy](https://usegalaxy.org/) platform. It begins by fetching chemical data from online sources and performing initial preprocessing, such as modifying compound titles and searching for specific molecular substructures.

The workflow prioritizes data integrity through a series of cleaning steps, including the removal of duplicate molecules, counterions, and fragments. These refined datasets are then passed through specialized filters and conversion tools to ensure the molecular formats are standardized for downstream analysis.

For deeper characterization, the pipeline calculates natural product likeness scores and generates molecular fingerprints using the [chemfp](https://chemfp.com/) suite. These fingerprints enable high-performance similarity analysis, culminating in NxN clustering to identify structural relationships within the chemical library.

This workflow serves as a robust [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) unit test, demonstrating the integration of OpenBabel and chemfp tools for reproducible computational chemistry research.

## Inputs and data preparation

_None listed._


Ensure your input chemical libraries are formatted as SMILES or SDF files to ensure compatibility with the OpenBabel and ChemFP processing steps. Utilizing dataset collections is particularly effective for managing large compound batches during the duplication removal and clustering phases. Please consult the README.md for exhaustive documentation on specific tool parameters and data preparation requirements. You may also use `planemo workflow_job_init` to create a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Online data | toolshed.g2.bx.psu.edu/repos/bgruening/chemical_data_sources/ctb_online_data_fetch/0.2 |  |
| 5 | Change Title | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel/ctb_change_title/0.0.1 |  |
| 11 | Compound Search | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel/ctb_obgrep/0.1 |  |
| 13 | Remove duplicated molecules | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel/ctb_remDuplicates/1.0 |  |
| 19 | Remove counterions and fragments | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel/ctb_remIons/1.0 |  |
| 29 | Filter | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel/ctb_filter/1.0 |  |
| 30 | Compound Convert | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel/ctb_compound_convert/0.1 |  |
| 31 | Molecules to Fingerprints | toolshed.g2.bx.psu.edu/repos/bgruening/chemfp/ctb_chemfp_mol2fps/0.2.0 |  |
| 39 | Natural Product | toolshed.g2.bx.psu.edu/repos/bgruening/natural_product_likeness/ctb_np-likeness-calculator/2.1 |  |
| 40 | Molecules to Fingerprints | toolshed.g2.bx.psu.edu/repos/bgruening/chemfp/ctb_chemfp_mol2fps/0.2.0 |  |
| 44 | NxN Clustering | toolshed.g2.bx.psu.edu/repos/bgruening/chemfp/ctb_chemfp_nxn_clustering/0.4 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
