---
name: music-deconvolution-data-generation-sc-metadata
description: "This single-cell transcriptomics workflow retrieves data from the EBI Single Cell Expression Atlas and applies text processing tools to generate the metadata necessary for creating ESet objects. Use this skill when you need to prepare reference datasets for cell type deconvolution analysis to estimate cell proportions in bulk RNA-seq samples."
homepage: https://workflowhub.eu/workflows/1552
---

# MuSiC-Deconvolution: Data generation | sc | metadata

## Overview

This workflow automates the retrieval and preparation of single-cell transcriptomics data from the [EBI Single Cell Expression Atlas (SCXA)](https://www.ebi.ac.uk/gxa/sc/home). It is specifically designed to generate the necessary metadata and structural components required to build an ExpressionSet (ESet) object, a prerequisite for performing cell-type deconvolution using the MuSiC framework.

The process begins by fetching raw data components, including the expression matrix, gene identifiers, barcodes, and experimental design files. It then utilizes a series of text-processing tools—such as regex find-and-replace, dataset joining, and advanced cutting—to clean and format the metadata. These steps ensure that the experimental design aligns correctly with the sequencing data.

By streamlining the transition from public repositories to analysis-ready formats, this workflow supports [GTN](https://training.galaxyproject.org/) training materials and reproducible research in deconvolution. The final outputs provide a standardized foundation for researchers to estimate cell type proportions in bulk RNA-seq datasets using single-cell references.

## Inputs and data preparation

_None listed._


Ensure you have the correct EBI SCXA accession ID to retrieve the required MTX and TSV files, specifically the expression matrix, gene identifiers, and cell barcodes. While the retrieval tool outputs individual datasets, organizing these into a structured history ensures the metadata joins correctly during the text processing steps. Refer to the `README.md` for comprehensive details on specific column requirements and metadata formatting necessary for successful ESet object construction. You can automate the configuration of these input parameters by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | EBI SCXA Data Retrieval | toolshed.g2.bx.psu.edu/repos/ebi-gxa/retrieve_scxa/retrieve_scxa/v0.0.1+galaxy1 |  |
| 1 | Cut | Cut1 |  |
| 2 | Add line to file | toolshed.g2.bx.psu.edu/repos/bgruening/add_line_to_file/add_line_to_file/0.1.0 |  |
| 3 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.2 | Adjust this step as necessary |
| 4 | Join two Datasets | join1 | Experimental designs often include extra stuff (likely the barcodes not meeting the EBI pre-processing criteria), so this way we streamline down to only those barcodes in the barcodes file. |
| 5 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 | Gets rid of the duplicated columns |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | matrix_mtx | matrix_mtx |
| 0 | genes_tsv | genes_tsv |
| 0 | barcode_tsv | barcode_tsv |
| 0 | design_tsv | design_tsv |
| 1 | out_file1 | out_file1 |
| 2 | outfile | outfile |
| 3 | out_file1 | out_file1 |
| 4 | out_file1 | out_file1 |
| 5 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run sc-metadata.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run sc-metadata.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run sc-metadata.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init sc-metadata.ga -o job.yml`
- Lint: `planemo workflow_lint sc-metadata.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `sc-metadata.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
