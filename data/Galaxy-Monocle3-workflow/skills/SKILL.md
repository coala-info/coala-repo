---
name: monocle3-workflow
description: This transcriptomics workflow performs single-cell RNA-seq trajectory analysis using Monocle3 tools to process expression matrices alongside gene and cell annotations. Use this skill when you need to reconstruct developmental lineages, identify branching points in cell differentiation, or calculate pseudotime to understand gene expression dynamics across biological transitions.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# monocle3-workflow

## Overview

This Galaxy workflow performs comprehensive single-cell RNA-seq (scRNA-seq) trajectory analysis using the [Monocle3](https://cole-trapnell-lab.github.io/monocle3/) toolkit. It automates the transition from raw data to biological insight by integrating three primary inputs: an expression matrix, cell annotations, and gene annotations.

The pipeline begins with data preprocessing and dimensionality reduction, followed by cell partitioning and clustering. It generates a wide array of diagnostic and exploratory visualizations, including plots categorized by cell type, genotype, batch, and sex. Additionally, the workflow identifies top marker genes for each cluster, providing both tabular data and visual summaries to characterize cell populations.

For advanced [trajectory analysis](https://training.galaxyproject.org/training-material/topics/transcriptomics/), the workflow learns the principal graph of the data to model developmental pathways. It orders cells along these paths to calculate pseudotime and performs differential expression analysis to identify genes that change across the trajectory. The final outputs include detailed pseudotime maps and trajectory plots, facilitating a deep understanding of cellular dynamics in [transcriptomics](https://training.galaxyproject.org/training-material/topics/transcriptomics/) research.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Expression matrix input | data_input |  |
| 1 | Cell annotations input | data_input |  |
| 2 | Gene annotations input | data_input |  |


Ensure your expression matrix, gene annotations, and cell annotations are formatted as tab-separated (TSV) files to ensure compatibility with the Monocle3 create tool. These inputs should be uploaded as individual datasets rather than collections, as the workflow expects three distinct files to initialize the CellDataSet object. Refer to the README.md for specific column naming requirements and detailed preprocessing instructions. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Monocle3 create | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_create/monocle3_create/0.1.4+galaxy2 | Check the data format that you're using. |
| 4 | Monocle3 preprocess | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_preprocess/monocle3_preprocess/0.1.4+galaxy0 | You might want to change the dimensionality of the reduced space here. |
| 5 | Monocle3 reduceDim | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_reducedim/monocle3_reduceDim/0.1.4+galaxy0 | UMAP/tSNE/PCA/LSI. However for further steps you need to use UMAP. |
| 6 | Monocle3 partition | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_partition/monocle3_partition/0.1.4+galaxy0 | You might want to change resolution  (affects clusters) and/or q-value (affects partitions). |
| 7 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 8 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 9 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 10 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 11 | Monocle3 top markers | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_topmarkers/monocle3_topmarkers/0.1.5+galaxy0 |  |
| 12 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 13 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 14 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 15 | Monocle3 learnGraph | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_learngraph/monocle3_learnGraph/0.1.4+galaxy0 |  |
| 16 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |
| 17 | Monocle3 orderCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_ordercells/monocle3_orderCells/0.1.4+galaxy0 |  |
| 18 | Monocle3 diffExp | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_diffexp/monocle3_diffExp/0.1.4+galaxy1 |  |
| 19 | Monocle3 plotCells | toolshed.g2.bx.psu.edu/repos/ebi-gxa/monocle3_plotcells/monocle3_plotCells/0.1.5+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | Monocle3 create on input dataset(s): cds3 | output_rds |
| 4 | Monocle3 preprocess on input dataset(s): cds3 | output_rds |
| 5 | Monocle3 reduceDim on input dataset(s): cds3 | output_rds |
| 6 | Monocle3 partition on input dataset(s): cds3 | output_rds |
| 7 | Cell type plot | output_tsv |
| 8 | Genotype plot | output_tsv |
| 9 | Batch plot | output_tsv |
| 10 | Sex plot | output_tsv |
| 11 | top_markers_table | top_markers_table |
| 11 | top_markers_plot | top_markers_plot |
| 12 | Gene expression plot | output_tsv |
| 13 | Partition plot | output_tsv |
| 14 | Cluster plot | output_tsv |
| 15 | Monocle3 learnGraph on input dataset(s): cds3 | output_rds |
| 16 | Cell types & learned trajectory path plot | output_tsv |
| 17 | Monocle3 orderCells on input dataset(s): cds3 | output_rds |
| 18 | Differential expression of genes - table | output_tsv |
| 19 | Pseudotime plot | output_tsv |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-monocle3-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-monocle3-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-monocle3-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-monocle3-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-monocle3-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-monocle3-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)