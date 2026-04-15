---
name: clustering-in-machine-learning
description: This machine learning workflow processes numeric datasets like iris, circles, and moon using scikit-learn clustering algorithms and visualizes the results with ggplot2 scatterplots. Use this skill when you need to identify natural groupings within multi-dimensional data and compare the effectiveness of different clustering methods like K-means, DBSCAN, and hierarchical clustering.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# clustering-in-machine-learning

## Overview

This workflow provides a comprehensive demonstration of unsupervised machine learning by applying various clustering algorithms to three classic datasets: Iris, circles, and moons. It begins by converting raw CSV inputs into a tabular format, ensuring the data is ready for processing within the Galaxy environment.

The core analysis utilizes [scikit-learn numeric clustering](https://toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_numeric_clustering) to execute three distinct algorithms: K-Means, Hierarchical (Agglomerative), and DBSCAN. By applying these methods to datasets with different geometric properties—such as the concentric rings of the "circles" data or the non-linear "moon" shapes—the workflow illustrates the strengths and limitations of each clustering approach.

To evaluate the results, the workflow generates a series of scatterplots using [ggplot2](https://toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point). These visualizations allow for a direct comparison of how each algorithm partitions the data, making it an excellent resource for those following [GTN](https://training.galaxyproject.org/) tutorials or exploring statistical patterns in machine learning.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | iris | data_input |  |
| 1 | circles | data_input |  |
| 2 | moon | data_input |  |


Ensure your input files for iris, circles, and moon datasets are in CSV format, as the workflow includes an initial step to convert these into the tabular format required for scikit-learn tools. You should upload these as individual datasets rather than collections to match the workflow's expected input ports. For automated execution and parameter mapping, you can use `planemo workflow_job_init` to generate a `job.yml` file. Detailed configuration for each clustering algorithm and specific column selections can be found in the README.md.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Convert CSV to tabular | csv_to_tabular |  |
| 4 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2 |  |
| 5 | Numeric Clustering | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_numeric_clustering/sklearn_numeric_clustering/1.0.8.1 |  |
| 6 | Numeric Clustering | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_numeric_clustering/sklearn_numeric_clustering/1.0.8.1 |  |
| 7 | Numeric Clustering | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_numeric_clustering/sklearn_numeric_clustering/1.0.8.1 |  |
| 8 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2 |  |
| 9 | Numeric Clustering | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_numeric_clustering/sklearn_numeric_clustering/1.0.8.1 |  |
| 10 | Numeric Clustering | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_numeric_clustering/sklearn_numeric_clustering/1.0.8.1 |  |
| 11 | Numeric Clustering | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_numeric_clustering/sklearn_numeric_clustering/1.0.8.1 |  |
| 12 | Numeric Clustering | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_numeric_clustering/sklearn_numeric_clustering/1.0.8.1 |  |
| 13 | Numeric Clustering | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_numeric_clustering/sklearn_numeric_clustering/1.0.8.1 |  |
| 14 | Numeric Clustering | toolshed.g2.bx.psu.edu/repos/bgruening/sklearn_numeric_clustering/sklearn_numeric_clustering/1.0.8.1 |  |
| 15 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2 |  |
| 16 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2 |  |
| 17 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2 |  |
| 18 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2 |  |
| 19 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2 |  |
| 20 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2 |  |
| 21 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2 |  |
| 22 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2 |  |
| 23 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/2.2.1+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 15 | heirarchical_clustering_circles | output1 |
| 16 | kmeans_clustering_circles | output1 |
| 17 | dbscan_clustering_circles | output1 |
| 18 | heirarchical_clustering_moon | output1 |
| 19 | dbscan_clustering_moon | output1 |
| 20 | kmeans_clustering_moon | output1 |
| 21 | heirarchical_clustering_iris | output1 |
| 22 | kmeans_clustering_iris | output1 |
| 23 | dbscan_clustering_iris | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run clustering.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run clustering.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run clustering.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init clustering.ga -o job.yml`
- Lint: `planemo workflow_lint clustering.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `clustering.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)