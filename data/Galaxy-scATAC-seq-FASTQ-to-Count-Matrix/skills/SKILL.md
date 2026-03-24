---
name: scatac-seq-fastq-to-count-matrix
description: "This single-cell ATAC-seq workflow processes raw FASTQ files into a cell-by-peak count matrix using BWA-MEM for alignment, MACS2 for peak calling, and EpiScanpy for AnnData generation. Use this skill when you need to transform raw 10x Genomics chromatin accessibility data into a standardized format for downstream clustering and cell type identification."
homepage: https://workflowhub.eu/workflows/1506
---

# scATAC-seq FASTQ to Count Matrix

## Overview

This Galaxy workflow processes raw 10x single-cell ATAC-seq (scATAC-seq) data to generate a cell-by-peak count matrix. It begins by integrating cell barcodes from the R2 FASTQ file into the read headers of the forward (R1) and reverse (R3) reads using **Sinto**. The processed reads are then mapped to a reference genome using **BWA-MEM**, followed by quality assessment with **Falco**.

The downstream analysis involves generating a position-sorted fragments file and performing peak calling with **MACS2** to identify accessible chromatin regions. Finally, the workflow utilizes the **EpiScanpy** tool suite to construct an AnnData (h5ad) object, providing a structured count matrix of cells and unique narrow peaks for further single-cell analysis.

For a detailed guide on the underlying concepts and specific tool parameters, refer to the associated Galaxy [tutorial](https://gxy.io/GTN:T00335). This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is tagged for single-cell and GTN applications.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Barcodes FASTQ (R2) | data_input | FASTQ containing all cell barcode sequences, usually R2. Please check the sequence lengths before selecting the correct file. |
| 1 | Forward reads FASTQ (R1) | data_input | FASTQ containing forward reads, usually R1. Please check the sequence lengths before selecting the correct file. |
| 2 | Reverse reads FASTQ (R3) | data_input | FASTQ containing reverse reads, usually R3. Please check the sequence lengths before selecting the correct file. |


Ensure your input files are in FASTQ format, specifically identifying the barcode (R2), forward (R1), and reverse (R3) reads as required by the 10x Genomics protocol. While individual datasets can be used, organizing these into a paired-end collection with a separate barcode file simplifies batch processing. Refer to the README.md for comprehensive details on parameter settings and specific tool configurations. You can automate the setup of these inputs by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Sinto barcode | toolshed.g2.bx.psu.edu/repos/iuc/sinto_barcode/sinto_barcode/0.10.1+galaxy0 |  |
| 4 | Falco | toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0 |  |
| 5 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.19 |  |
| 6 | Falco | toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0 |  |
| 7 | Sinto fragments | toolshed.g2.bx.psu.edu/repos/iuc/sinto_fragments/sinto_fragments/0.10.1+galaxy0 |  |
| 8 | bedtools SortBED | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_sortbed/2.31.1+galaxy0 |  |
| 9 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.2.9.1+galaxy0 |  |
| 10 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/9.5+galaxy2 |  |
| 11 | Build count matrix | toolshed.g2.bx.psu.edu/repos/iuc/episcanpy_build_matrix/episcanpy_build_matrix/0.3.2+galaxy1 |  |
| 12 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy1 |  |
| 13 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy1 |  |
| 14 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Falco on R1 | html_file |
| 6 | Falco on R2 | html_file |
| 11 | Anndata object | anndata_out |
| 14 | Anndata info | general |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run scatac-seq-fastq-to-count-matrix.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run scatac-seq-fastq-to-count-matrix.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run scatac-seq-fastq-to-count-matrix.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init scatac-seq-fastq-to-count-matrix.ga -o job.yml`
- Lint: `planemo workflow_lint scatac-seq-fastq-to-count-matrix.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `scatac-seq-fastq-to-count-matrix.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
