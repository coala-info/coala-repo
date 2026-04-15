---
name: single-cell-rna-seq-preprocessing-10x-genomics-cellplex-mult
description: This workflow processes multiplexed 10X Genomics CellPlex data by integrating gene expression FASTQs and Cell Multiplexing Oligo (CMO) sequences using STARsolo, CITE-seq-Count, and DropletUtils. Use this skill when you need to demultiplex pooled single-cell samples, perform genomic alignment, and generate analysis-ready expression and CMO matrices compatible with Seurat or Scanpy.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# single-cell-rna-seq-preprocessing-10x-genomics-cellplex-mult

## Overview

This workflow provides a comprehensive pipeline for preprocessing 10X Genomics CellPlex multiplexed single-cell RNA-seq data. It simultaneously processes gene expression (GEX) and Cell Multiplexing Oligo (CMO) FASTQ files to generate analysis-ready matrices. By integrating alignment, cell filtering, and barcode demultiplexing, it streamlines the transition from raw sequencing data to downstream analysis.

Gene expression reads are aligned and quantified using STARsolo, followed by cell barcode filtering via DropletUtils to remove empty droplets. For multiplexing, the workflow utilizes CITE-seq-Count to assign CMO reads. A critical step includes CellPlex-specific barcode translation, ensuring that CMO-derived cellular barcodes correctly match the GEX barcodes as described in [this 10X Genomics technical note](https://kb.10xgenomics.com/hc/en-us/articles/360031133451-Why-is-there-a-discrepancy-in-the-3M-february-2018-txt-barcode-whitelist-).

The final outputs are organized into collections containing matrix, gene, and barcode files compatible with the `Read10X` function used in Seurat or Scanpy. This structure is inspired by [Galaxy training materials](https://training.galaxyproject.org/training-material/topics/single-cell/tutorials/scrna-preprocessing-tenx/tutorial.html) and supports both Galaxy-based post-processing and local analysis. 

For detailed instructions on input preparation, including CMO sequence collections and reference requirements, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | fastq PE collection GEX | data_collection_input | reads containing genes |
| 1 | reference genome | parameter_input | Choose your reference genome |
| 2 | gtf | data_input | Gene annotations |
| 3 | cellranger_barcodes_3M-february-2018.txt | data_input | Available at https://zenodo.org/record/3457880/files/3M-february-2018.txt.gz |
| 4 | Barcode Size is same size of the Read | parameter_input | Barcode Size is same size of the Read |
| 5 | fastq PE collection CMO | data_collection_input | reads containing CMO |
| 6 | sample name and CMO sequence collection | data_collection_input | csv: first column is the sequence and second column is the name |
| 7 | Number of expected cells | parameter_input | Used by CITE-seq-Count, does not really seem to impact result. You can use 24000. |


Ensure your gene expression (GEX) and Cell Multiplexing Oligo (CMO) data are organized into paired-end list collections, maintaining an identical sample order across both collections and the CMO sequence CSVs. Use a GTF file for gene annotations and the specific 10X 3M-february-2018.txt whitelist for barcode validation. Set the "Barcode Size" parameter to true only if your R1 length exactly matches the combined cell barcode and UMI length without trailing sequences. For comprehensive guidance on formatting the CMO translation tables and reference genome requirements, refer to the README.md. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 8 | scRNA-seq_preprocessing_10X_v3_Bundle | (subworkflow) |  |
| 9 | CITE-seq-Count | toolshed.g2.bx.psu.edu/repos/iuc/cite_seq_count/cite_seq_count/1.4.4+galaxy0 |  |
| 10 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 11 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy3 |  |
| 12 | Re-organize-STAR-solo-output | (subworkflow) |  |
| 13 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | CITE-seq-Count report | report |
| 10 | Renamed Seurat input for gene expression (filtered) | data_param |
| 13 | Renamed Seurat input for CMO (UMI) | data_param |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run scrna-seq-fastq-to-matrix-10x-cellplex.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run scrna-seq-fastq-to-matrix-10x-cellplex.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run scrna-seq-fastq-to-matrix-10x-cellplex.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init scrna-seq-fastq-to-matrix-10x-cellplex.ga -o job.yml`
- Lint: `planemo workflow_lint scrna-seq-fastq-to-matrix-10x-cellplex.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `scrna-seq-fastq-to-matrix-10x-cellplex.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)