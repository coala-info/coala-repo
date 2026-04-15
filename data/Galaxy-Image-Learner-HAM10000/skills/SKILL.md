---
name: image-learner-ham10000
description: This Galaxy workflow utilizes the Image Learner tool to perform deep learning classification on skin lesion datasets using HAM10000 image metadata and resized image archives. Use this skill when you need to automate the identification and categorization of pigmented skin lesions from dermatoscopic imagery for medical imaging research.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# image-learner-ham10000

## Overview

This workflow is designed for deep learning-based image classification, specifically targeting skin lesion analysis using the [HAM10000 dataset](https://doi.org/10.7910/DVN/DBW86T). It leverages the [Image Learner](https://toolshed.g2.bx.psu.edu/view/goeckslab/image_learner/) tool within the Galaxy ecosystem to automate the training and evaluation process for medical imaging tasks.

The pipeline requires two primary inputs: a ZIP archive containing resized images (96x96 pixels) and a corresponding CSV file containing augmented metadata. These datasets are processed by the Image Learner tool, which facilitates the application of deep learning models to classify dermatoscopic images into various diagnostic categories.

Developed as part of the [Gleam](https://gleam.eu/) project and aligned with [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) standards, this workflow provides a reproducible environment for researchers. It is licensed under AGPL-3.0-or-later and serves as a practical implementation of automated skin lesion classification.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | selected_HAM10000_img_metadata_aug.csv | data_input | \| Column \| Description \| \| `lesion_id` \| Lesion identifier used to group original and augmented images from the same lesion. \| \| `image_id` \| Image identifier from the source dataset (shared by original and flipped versions). \| \| `dx` \| Diagnosis label (target class). \| \| `dx_type` \| Diagnosis confirmation method (for example, `histo`). \| \| `age` \| Patient age in years. \| \| `sex` \| Patient sex (`male`/`female`/`unknown`). \| \| `localization` \| Anatomical site of the lesion. \| \| `image_path` \| Image filename within the image ZIP. \| |
| 1 | selected_HAM10000_img_96_size.zip | data_input | - Total dataset: 1,400 images - Generated 200 images per class - Resized all images to 96×96 pixels - Standardized format as PNG for consistent processing |


Ensure the image archive is uploaded as a `.zip` file and the metadata as a `.csv` file, verifying that the filenames listed in the spreadsheet correspond exactly to the images within the archive. While this workflow processes these as individual datasets, maintaining consistent naming conventions is critical for the Image Learner tool to map labels correctly. Please consult the `README.md` for comprehensive details on the required metadata schema and data preparation. For automated testing or execution, you may use `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Image Learner | toolshed.g2.bx.psu.edu/repos/goeckslab/image_learner/image_learner/0.1.5 |  |


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