---
name: trajectory-analysis-using-monocle3-full-tutorial-workflow
description: This transcriptomics workflow performs single-cell trajectory analysis by processing AnnData inputs through the Monocle3 suite to reconstruct developmental lineages and calculate pseudotime. Use this skill when you need to identify branching points in cell differentiation, discover genes that change along a developmental path, or visualize the progression of single cells through biological processes.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# trajectory-analysis-using-monocle3-full-tutorial-workflow

## Overview

This workflow performs a comprehensive single-cell RNA-seq trajectory analysis using [Monocle3](https://cole-trapnell-lab.github.io/monocle3/), starting from AnnData objects. It begins by extracting and cleaning cell and gene annotations, filtering specific populations (such as removing macrophages), and transposing expression matrices to prepare a compatible CellDataSet (CDS) object.

The core pipeline handles preprocessing, dimensionality reduction, and clustering. It generates a suite of visualizations to inspect the data across various metadata dimensions, including cell type, genotype, batch, and sex. Additionally, the workflow identifies top marker genes for each cluster, providing both statistical tables and representative plots.

In the final stages, the workflow learns the principal graph to infer cell trajectories and calculates pseudotime by ordering cells along the learned paths. It concludes with a differential expression analysis to identify genes that change significantly across the trajectory, producing a final pseudotime plot and a detailed table of differentially expressed genes. This workflow is tagged for [transcriptomics](https://training.galaxyproject.org/training-material/topics/transcriptomics/) and [single-cell analysis](https://training.galaxyproject.org/training-material/topics/single-cell/) and is licensed under CC-BY-4.0.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | AnnData to extract genes & cells annotations | data_input |  |
| 1 | AnnData before processing to extract clean expression matrix | data_input |  |


This workflow requires two primary AnnData files as input: one containing processed cell and gene annotations and another containing the raw, unprocessed expression matrix. Ensure your datasets are in the h5ad format to allow the `anndata_inspect` tool to correctly extract the necessary metadata and expression components for Monocle3. While this workflow processes individual datasets, you can use dataset collections if handling multiple samples simultaneously. For comprehensive guidance on parameter settings and data preparation, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 3 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 |  |
| 4 | Inspect AnnData | toolshed.g2.bx.psu.edu/repos/iuc/anndata_inspect/anndata_inspect/0.7.5+galaxy1 | Unprocessed means here before normalisation or dimensionality reduction. For this step, must have cell IDs as rownames. |
| 5 | Filter | Filter1 | Double-check the cell_type column number |
| 6 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.2 | Check the number of the column with genes names (using column) and its header (Find Regex) |
| 7 | Cut | Cut1 |  |
| 8 | Cut | Cut1 |  |
| 9 | Join two Datasets | join1 |  |
| 10 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 11 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.1.0+galaxy2 |  |
| 12 | Join two Datasets | join1 |  |
| 13 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 14 | Monocle3 create | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_create/monocle3_create/0.1.4+galaxy2 | Check the data format that you're using. |
| 15 | Monocle3 preprocess | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_preprocess/monocle3_preprocess/0.1.4+galaxy0 | You might want to change the dimensionality of the reduced space here. |
| 16 | Monocle3 reduceDim | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_reducedim/monocle3_reduceDim/0.1.4+galaxy0 | UMAP/tSNE/PCA/LSI. However for further steps you need to use UMAP. |
| 17 | Monocle3 partition | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_partition/monocle3_partition/0.1.4+galaxy0 | You might want to change resolution  (affects clusters) and/or q-value (affects partitions). |
| 18 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 19 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 20 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 21 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 22 | Monocle3 top markers | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_topmarkers/monocle3_topmarkers/0.1.5+galaxy0 |  |
| 23 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 24 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 25 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 26 | Monocle3 learnGraph | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_learngraph/monocle3_learnGraph/0.1.4+galaxy0 |  |
| 27 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 28 | Monocle3 orderCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_ordercells/monocle3_orderCells/0.1.4+galaxy0 |  |
| 29 | Monocle3 diffExp | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_diffexp/monocle3_diffExp/0.1.4+galaxy1 |  |
| 30 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Extracted cell annotations (obs) | obs |
| 3 | Extracted gene annotations (var) | var |
| 4 | Unprocessed expression matrix | X |
| 5 | Cells without macrophages | out_file1 |
| 6 | Genes table with gene_short_name colname | out_file1 |
| 7 | Filtered cells IDs  | out_file1 |
| 8 | Genes IDs | out_file1 |
| 9 | Pre-filtered matrix (by cells) | out_file1 |
| 10 | Filtered matrix (by cells)  | output |
| 11 | filtered matrix (by cells) transposed | out_file |
| 12 | Pre-filtered matrix (by cells & genes) | out_file1 |
| 13 | Filtered matrix (by cells & genes) | output |
| 14 | Monocle3 create on input dataset(s): cds3 | output_rds |
| 15 | Monocle3 preprocess on input dataset(s): cds3 | output_rds |
| 16 | Monocle3 reduceDim on input dataset(s): cds3 | output_rds |
| 17 | Monocle3 partition on input dataset(s): cds3 | output_rds |
| 18 | Cell type plot | output_tsv |
| 19 | Genotype plot | output_tsv |
| 20 | Batch plot | output_tsv |
| 21 | Sex plot | output_tsv |
| 22 | top_markers_plot | top_markers_plot |
| 22 | top_markers_table | top_markers_table |
| 23 | Gene expression plot | output_tsv |
| 24 | Partition plot | output_tsv |
| 25 | Cluster plot | output_tsv |
| 26 | Monocle3 learnGraph on input dataset(s): cds3 | output_rds |
| 27 | Cell types & learned trajectory path plot | output_tsv |
| 28 | Monocle3 orderCells on input dataset(s): cds3 | output_rds |
| 29 | Differential expression of genes - table | output_tsv |
| 30 | Pseudotime plot | output_tsv |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run trajectory-analysis-using-monocle3---full-tutorial-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run trajectory-analysis-using-monocle3---full-tutorial-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run trajectory-analysis-using-monocle3---full-tutorial-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init trajectory-analysis-using-monocle3---full-tutorial-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint trajectory-analysis-using-monocle3---full-tutorial-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `trajectory-analysis-using-monocle3---full-tutorial-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)