---
name: test-imported-from-uploaded-file
description: "This Galaxy workflow automates the extraction, processing, and sharing of biomedical images by retrieving data from XNAT, applying a 2D convolution filter, and uploading the results back to the repository. Use this skill when you need to perform automated image feature extraction or spatial filtering on clinical imaging datasets stored in an XNAT instance for cancer research."
homepage: https://workflowhub.eu/workflows/1381
---

# Test (imported from uploaded file)

## Overview

This Galaxy workflow serves as a demonstrator for the EOSC4Cancer D2.2 project, focusing on analytical methods for the extraction, processing, and sharing of biomedical imaging data. It provides a streamlined pipeline for handling image-based research assets within a cloud-integrated environment.

The workflow automates a three-step process: it first retrieves imaging data from an XNAT repository using the `xnat_download` tool, applies a 2D convolution for image processing, and finally returns the processed results to the repository via the `xnat_upload` tool. This sequence facilitates reproducible image analysis while maintaining data provenance between Galaxy and XNAT.

For a comprehensive understanding of the demonstrator's components and the associated research context, users can refer to the [deliverable report on Zenodo](https://doi.org/10.5281/zenodo.15704480). Detailed instructions regarding data preparation and input requirements are available in the [README.md](README.md) located in the Files section.

## Inputs and data preparation

_None listed._


Ensure your input data consists of compatible biomedical image formats like DICOM or NIfTI, which are typically handled as individual datasets or organized into collections for batch processing through the XNAT importer. When configuring the XNAT tools, verify that your credentials and project identifiers are correctly mapped to avoid connection errors during data extraction. For a comprehensive guide on parameter settings and data preparation requirements, please refer to the project's README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | XNAT data importer | xnat_download | EOSC4Cancer_TCGA_COAD Filter to use for the subjects TCGA-CK-4951 Filter to use for the experiments 10-31-1998-NA-CT-ABDOMEN-W-CO-53300 Filter to use for scans ^(?!.*Topogram).* Filter to use for resources DICOM Level of data to download from scan resource Switch from simple matching to regular expression matching true |
| 1 | Convolution 2D | convolution_2d |  |
| 2 | XNAT data exporter | xnat_upload |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-EOSC4Cancer-2.2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-EOSC4Cancer-2.2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-EOSC4Cancer-2.2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-EOSC4Cancer-2.2.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-EOSC4Cancer-2.2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-EOSC4Cancer-2.2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
