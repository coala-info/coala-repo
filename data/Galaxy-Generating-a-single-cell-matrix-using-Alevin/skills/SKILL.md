---
name: generating-a-single-cell-matrix-using-alevin
description: This single-cell transcriptomics workflow processes raw sequencing reads, a reference FASTA, and a GTF file using Alevin and DropletUtils to generate a gene-cell count matrix. Use this skill when you need to perform transcript-level quantification and cell barcode demultiplexing for droplet-based single-cell RNA-seq data to produce downstream-ready expression matrices.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# generating-a-single-cell-matrix-using-alevin

## Overview

This Galaxy workflow automates the generation of a single-cell gene expression matrix from raw sequencing data using the [Alevin](https://toolshed.g2.bx.psu.edu/repos/bgruening/alevin/alevin/1.10.1+galaxy0) tool. It processes paired-end reads—where one read contains cell barcodes and UMIs and the other contains the transcript—alongside a reference FASTA and GTF file to quantify gene expression at the single-cell level.

The pipeline begins by preparing the reference transcriptome and gene-to-transcript mappings using **GTF2GeneList**. It then utilizes **Alevin** to perform integrated alignment, pipeline-specific UMI deduplication, and cell barcode error correction. To ensure data quality, the workflow generates droplet barcode rank plots and employs **DropletUtils** to distinguish between ambient RNA and genuine cells via the `emptyDrops` method.

The final outputs include the raw and filtered quantification matrices in MTX format, along with associated row (gene) and column (barcode) metadata. For downstream compatibility, the workflow includes steps to convert these outputs into 10x-compatible formats and [SCEasy](https://toolshed.g2.bx.psu.edu/repos/iuc/sceasy_convert/sceasy_convert/0.0.7+galaxy2) objects, facilitating immediate integration into R or Python-based single-cell analysis environments.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | GTF file | data_input | You can find the file containing the gene information for your species here:  http://www.ensembl.org/info/data/ftp/index.html/ |
| 1 | Reference FASTA | data_input | You can find this file for your species here: http://www.ensembl.org/info/data/ftp/index.html/ |
| 2 | Read 1 - containing cell barcode & UMI | data_input | This should be a fast file containing the shorter read - i.e. the cell barcode and the unique molecular identifier |
| 3 | Read 2 - containing transcript | data_input | This should be the read containing the transcript |


Ensure your input files are in the correct formats, specifically GTF for gene annotations, FASTA for the reference genome, and FASTQ for the paired-end sequencing reads. While individual datasets are listed for Read 1 and Read 2, organizing large-scale single-cell runs into paired dataset collections can significantly streamline the Alevin processing steps. Refer to the accompanying README.md for comprehensive details on parameter settings and specific version requirements for the reference files. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and testing of this Alevin pipeline.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | GTF2GeneList | toolshed.g2.bx.psu.edu/repos/ebi-gxa/gtf2gene_list/_ensembl_gtf2gene_list/1.52.0+galaxy0 |  |
| 5 | GTF2GeneList | toolshed.g2.bx.psu.edu/repos/ebi-gxa/gtf2gene_list/_ensembl_gtf2gene_list/1.52.0+galaxy0 |  |
| 6 | Alevin | toolshed.g2.bx.psu.edu/repos/bgruening/alevin/alevin/1.10.1+galaxy0 |  |
| 7 | Alevin | toolshed.g2.bx.psu.edu/repos/bgruening/alevin/alevin/1.10.1+galaxy0 |  |
| 8 | Droplet barcode rank plot | toolshed.g2.bx.psu.edu/repos/ebi-gxa/droplet_barcode_plot/_dropletBarcodePlot/1.6.1+galaxy2 |  |
| 9 | Droplet barcode rank plot | toolshed.g2.bx.psu.edu/repos/ebi-gxa/droplet_barcode_plot/_dropletBarcodePlot/1.6.1+galaxy2 |  |
| 10 | salmonKallistoMtxTo10x | toolshed.g2.bx.psu.edu/repos/ebi-gxa/salmon_kallisto_mtx_to_10x/_salmon_kallisto_mtx_to_10x/0.0.1+galaxy6 |  |
| 11 | Join two Datasets | join1 |  |
| 12 | Cut | Cut1 |  |
| 13 | DropletUtils Read10x | toolshed.g2.bx.psu.edu/repos/ebi-gxa/dropletutils_read_10x/dropletutils_read_10x/1.0.4+galaxy0 |  |
| 14 | DropletUtils emptyDrops | toolshed.g2.bx.psu.edu/repos/ebi-gxa/dropletutils_empty_drops/dropletutils_empty_drops/1.0.4+galaxy0 |  |
| 15 | SCEasy Converter | toolshed.g2.bx.psu.edu/repos/iuc/sceasy_convert/sceasy_convert/0.0.7+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | fasta_output | fasta_output |
| 5 | feature_annotation | feature_annotation |
| 6 | raw_cb_frequency_txt | raw_cb_frequency_txt |
| 6 | salmon_quant_log | salmon_quant_log |
| 6 | quants_mat_mtx | quants_mat_mtx |
| 6 | quants_mat_cols_txt | quants_mat_cols_txt |
| 6 | quants_mat_rows_txt | quants_mat_rows_txt |
| 7 | quants_mat_rows_txt_1 | quants_mat_rows_txt |
| 7 | quants_mat_mtx_1 | quants_mat_mtx |
| 7 | quants_mat_cols_txt_1 | quants_mat_cols_txt |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run generating-a-single-cell-matrix-using-alevin-archive.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run generating-a-single-cell-matrix-using-alevin-archive.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run generating-a-single-cell-matrix-using-alevin-archive.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init generating-a-single-cell-matrix-using-alevin-archive.ga -o job.yml`
- Lint: `planemo workflow_lint generating-a-single-cell-matrix-using-alevin-archive.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `generating-a-single-cell-matrix-using-alevin-archive.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)