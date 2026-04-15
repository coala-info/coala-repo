---
name: encyclopedia-gtn
description: This proteomics workflow processes GPF and experimental DIA RAW files using msconvert and EncyclopeDIA to generate chromatogram libraries and protein quantitation reports. Use this skill when you need to perform library-based quantification of proteins and peptides from complex data-independent acquisition mass spectrometry datasets.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# encyclopedia-gtn

## Overview

This workflow provides a comprehensive pipeline for DIA (Data-Independent Acquisition) metaproteomics analysis using the EncyclopeDIA toolset. Developed in alignment with [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) standards, it is designed to process complex mass spectrometry data by leveraging Gas Phase Fractionation (GPF) to improve peptide identification and quantification accuracy.

The process begins by converting raw GPF and experimental wide-window DIA datasets into the mzML format using [msconvert](https://toolshed.g2.bx.psu.edu/repos/galaxyp/msconvert/msconvert/3.0.20287.2). These converted files are then integrated with a spectral or Prosit library and a background protein FASTA file. The `SearchToLib` tool processes these inputs to generate a site-specific chromatogram library, which serves as a refined reference for subsequent quantification.

In the final stages, the workflow employs `EncyclopeDIA Quantify` to map the experimental samples against the generated chromatogram library. This results in high-confidence peptide and protein quantitation outputs, along with detailed logs and library files. This automated approach ensures reproducible proteomics discovery and is particularly suited for metaproteomics research requiring deep proteome coverage.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | GPF DIA RAW Files (Dataset collection) | data_collection_input | encyclopedia- Gas phase fractionation files for library |
| 1 | EXPERIMENTAL DIA RAW FILES (WIDE) | data_collection_input | Input raw files |
| 2 | SPECTRAL OR PROSIT LIBRARY | data_input | Library from Prosit |
| 3 | BACKGROUND PROTEIN FASTA FILE | data_input | Input Protein Database file |


Ensure your GPF and experimental DIA raw files are organized into dataset collections to facilitate batch processing through the msconvert steps. The spectral or Prosit library should be provided as a single dataset, while the background protein database must be in FASTA format. For comprehensive details on parameter settings and library requirements, consult the README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined job submission.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | msconvert | toolshed.g2.bx.psu.edu/repos/galaxyp/msconvert/msconvert/3.0.20287.2 | convert to mzml for encyclopedia |
| 5 | msconvert | toolshed.g2.bx.psu.edu/repos/galaxyp/msconvert/msconvert/3.0.20287.2 |  |
| 6 | SearchToLib | toolshed.g2.bx.psu.edu/repos/galaxyp/encyclopedia_searchtolib/encyclopedia_searchtolib/1.2.2+galaxy0 | Searching the mzml files against the Prosit library and the protein FASTA database. |
| 7 | EncyclopeDIA Quantify | toolshed.g2.bx.psu.edu/repos/galaxyp/encyclopedia_quantify/encyclopedia_quantify/1.2.2+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | GPF_MZML | output |
| 5 | Experimental-dataset-MZML | output |
| 6 | CHROMATOGRAM LIBRARY | elib |
| 6 | LOG | log |
| 7 | Quant-LOG | log |
| 7 | QUANT LIBRARY | elib |
| 7 | PEPTIDE QUANTITATION OUTPUT | peptides |
| 7 | PROTEIN QUANTITATION OUTPUT | proteins |


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