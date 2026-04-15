---
name: qiime2-ia-multiplexed-data-single-end
description: This workflow imports single-end multiplexed FASTQ sequences and barcode files into QIIME2 using the Earth Microbiome Project protocol and demultiplexes them based on provided metadata. Use this skill when you have raw microbiome sequencing data where all samples are contained in a single file and require separation into individual samples using barcode sequences before downstream taxonomic analysis.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# qiime2-ia-multiplexed-data-single-end

## Overview

This workflow is designed to import and demultiplex single-end sequencing data following the Earth Microbiome Project (EMP) protocol. It handles raw multiplexed sequences where barcodes are provided in a separate file, transforming them into QIIME2 artifacts ready for downstream microbiome analysis.

The process requires three primary inputs: the raw sequences, the barcode file, and a metadata table. Users must also specify the metadata column containing the barcode sequences and indicate whether to use the reverse complement of those barcodes. For detailed guidance on file preparation and naming conventions, refer to the [README.md](README.md) in the Files section.

The workflow utilizes `qiime2 tools import` to bring the sequences and metadata into the QIIME2 environment, followed by `qiime2 demux emp-single` to assign reads to samples. The final outputs include a demultiplexed sequence artifact (.qza) and a visualization summary (.qzv) generated via `qiime2 demux summarize`, which provides essential quality metrics for the demultiplexing results.

This workflow is released under the [MIT](https://opensource.org/licenses/MIT) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Sequences | data_input | Single-end sequences |
| 1 | Barcodes | data_input | Barcode sequences |
| 2 | Metadata | data_input | A tab separated metadata file |
| 3 | Metadata parameter | parameter_input | Column name of the metadata to be used for demultiplexing |
| 4 | Reverse complement barcodes | parameter_input | If reverse complement of barcodes is necessary for the analysis, choose Yes. |


Ensure your sequences and barcodes are uploaded as `fastqsanger.gz` files, while the metadata should be a tabular file containing a column for barcode sequences. This workflow processes multiplexed data as individual datasets rather than collections, requiring you to manually specify the metadata column name and whether to reverse complement the barcodes. For automated testing or batch execution, you can initialize the environment using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for specific naming conventions and detailed preparation steps for the EMP protocol. Detailed instructions on data formatting and parameter selection are available in the project documentation.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | qiime2 tools import | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2_core__tools__import/qiime2_core__tools__import/2024.10.0+dist.h3d8a7e27 | qiime2 tools input This step allows the input of the files to be analysed and then generate a qza output, necessary for the QIIME2 pipeline. |
| 6 | qiime2 tools import | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2_core__tools__import/qiime2_core__tools__import/2024.10.0+dist.h3d8a7e27 | Import the metadata as artifact |
| 7 | qiime2 demux emp-single | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2__demux__emp_single/qiime2__demux__emp_single/2024.10.0+q2galaxy.2024.10.0 | qiime2 demux emp-single Demultiplex sequence data generated with the EMP protocol. |
| 8 | qiime2 demux summarize | toolshed.g2.bx.psu.edu/repos/q2d2/qiime2__demux__summarize/qiime2__demux__summarize/2024.10.0+q2galaxy.2024.10.0 | qiime2 demux summarize Summarize counts per sample. (Galaxy Version 2023.5.0+q2galaxy.2023.5.0.2) |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | Demultiplexed single-end data | per_sample_sequences |
| 8 | Summary of the demultiplexing | visualization |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run QIIME2-Ia-multiplexed-data-single-end.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run QIIME2-Ia-multiplexed-data-single-end.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run QIIME2-Ia-multiplexed-data-single-end.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init QIIME2-Ia-multiplexed-data-single-end.ga -o job.yml`
- Lint: `planemo workflow_lint QIIME2-Ia-multiplexed-data-single-end.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `QIIME2-Ia-multiplexed-data-single-end.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)