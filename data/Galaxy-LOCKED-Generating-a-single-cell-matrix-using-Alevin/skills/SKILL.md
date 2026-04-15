---
name: locked-generating-a-single-cell-matrix-using-alevin
description: This single-cell RNA-seq workflow processes raw sequencing reads, reference FASTA, and GTF files using Alevin and DropletUtils to generate a quantified gene expression matrix. Use this skill when you need to perform transcript quantification from droplet-based sequencing data, filter out empty droplets, and prepare a standardized AnnData object for downstream single-cell analysis.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# locked-generating-a-single-cell-matrix-using-alevin

## Overview

This workflow automates the generation of a single-cell gene expression matrix from raw sequencing data, following the [Galaxy Training Network (GTN) tutorial](https://training.galaxyproject.org/training-material/topics/single-cell/tutorials/scrna-case_alevin/tutorial.html) for scRNA-seq case studies. It processes raw FASTQ files—specifically Read 1 (barcodes and UMIs) and Read 2 (transcripts)—alongside a reference FASTA and GTF file to produce a filtered count matrix ready for downstream analysis.

The core of the pipeline utilizes `GTF2GeneList` for reference preparation and `Alevin` for the quantification of cell barcodes and UMIs. This stage generates the raw quantification matrix and essential quality control metrics, such as barcode frequency distributions. To ensure data quality, the workflow includes a `Droplet barcode rank plot` to visualize library preparation success.

Post-quantification, the workflow converts results into 10x-compatible formats and employs `DropletUtils` to run the `emptyDrops` algorithm, which distinguishes genuine cells from ambient RNA. The final steps involve converting the data into an AnnData object via `SCEasy` and performing initial inspections and manipulations, providing a seamless transition to single-cell visualization and clustering tools.

This resource is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is tagged for training and single-cell analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Read 1 - containing cell barcode & UMI | data_input | This should be a fast file containing the shorter read - i.e. the cell barcode and the unique molecular identifier |
| 1 | Read 2 - containing transcript | data_input | This should be the read containing the transcript |
| 2 | Reference FASTA | data_input | You can find this file for your species here: http://www.ensembl.org/info/data/ftp/index.html/ |
| 3 | GTF file | data_input | You can find the file containing the gene information for your species here:  http://www.ensembl.org/info/data/ftp/index.html/ |


Ensure your input FASTQ files are correctly assigned, with Read 1 containing cell barcodes and UMIs and Read 2 containing the transcript sequences. Use high-quality reference FASTA and GTF files to ensure accurate gene mapping and feature annotation during the Alevin and GTF2GeneList steps. While individual datasets are used here, organizing large runs into paired-end collections can streamline processing. For automated execution, you can initialize a job configuration using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter settings and data preparation specific to this single-cell training protocol.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | GTF2GeneList | toolshed.g2.bx.psu.edu/repos/ebi-gxa/gtf2gene_list/_ensembl_gtf2gene_list/1.52.0+galaxy0 |  |
| 5 | GTF2GeneList | toolshed.g2.bx.psu.edu/repos/ebi-gxa/gtf2gene_list/_ensembl_gtf2gene_list/1.52.0+galaxy0 |  |
| 6 | Alevin | toolshed.g2.bx.psu.edu/repos/bgruening/alevin/alevin/1.10.1+galaxy2 |  |
| 7 | salmonKallistoMtxTo10x | toolshed.g2.bx.psu.edu/repos/ebi-gxa/salmon_kallisto_mtx_to_10x/_salmon_kallisto_mtx_to_10x/0.0.1+galaxy6 |  |
| 8 | Droplet barcode rank plot | toolshed.g2.bx.psu.edu/repos/ebi-gxa/droplet_barcode_plot/_dropletBarcodePlot/1.6.1+galaxy2 |  |
| 9 | Join two Datasets | join1 |  |
| 10 | Cut | Cut1 |  |
| 11 | DropletUtils Read10x | toolshed.g2.bx.psu.edu/repos/ebi-gxa/dropletutils_read_10x/dropletutils_read_10x/1.0.4+galaxy0 |  |
| 12 | DropletUtils emptyDrops | toolshed.g2.bx.psu.edu/repos/ebi-gxa/dropletutils_empty_drops/dropletutils_empty_drops/1.0.4+galaxy0 |  |
| 13 | SCEasy Converter | toolshed.g2.bx.psu.edu/repos/iuc/sceasy_convert/sceasy_convert/0.0.7+galaxy2 |  |
| 14 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.10.9+galaxy1 |  |
| 15 | Manipulate AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_manipulate/anndata_manipulate/0.10.9+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | feature_annotation | feature_annotation |
| 4 | fasta_output | fasta_output |
| 5 | fasta_output2 | fasta_output |
| 5 | Gene_Information | feature_annotation |
| 6 | quants_mat_mtx_1 | quants_mat_mtx |
| 6 | quants_mat_cols_txt_1 | quants_mat_cols_txt |
| 6 | quants_mat_rows_txt_1 | quants_mat_rows_txt |
| 6 | raw_cb_frequency_txt | raw_cb_frequency_txt |
| 6 | salmon_quant_log | salmon_quant_log |
| 7 | barcodes_out | barcodes_out |
| 7 | matrix_out | matrix_out |
| 7 | genes_out | genes_out |
| 8 | plot_file-raw | plot_file |
| 9 | out_file1 | out_file1 |
| 10 | Annotated_Gene_Table | out_file1 |
| 11 | output_rds | output_rds |
| 12 | output_rdata | output_rdata |
| 13 | output_anndata | output_anndata |
| 14 | var | var |
| 15 | anndata | anndata |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run generating-a-single-cell-matrix-using-alevin.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run generating-a-single-cell-matrix-using-alevin.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run generating-a-single-cell-matrix-using-alevin.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init generating-a-single-cell-matrix-using-alevin.ga -o job.yml`
- Lint: `planemo workflow_lint generating-a-single-cell-matrix-using-alevin.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `generating-a-single-cell-matrix-using-alevin.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)