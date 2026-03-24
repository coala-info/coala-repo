---
name: generate-nx-and-size-plots-for-multiple-assemblies
description: "This bioinformatics workflow processes a collection of FASTA genome assemblies using gfastats and ggplot2 to generate comparative Nx and size distribution plots. Use this skill when you need to evaluate and visualize the improvement of assembly contiguity and quality across different stages of the scaffolding process."
homepage: https://workflowhub.eu/workflows/1057
---

# Generate Nx and Size plots for multiple assemblies

## Overview

This Galaxy workflow automates the generation of Nx and Size plots to compare assembly quality across multiple genomic datasets. It is specifically designed to visualize the evolution of assembly metrics during the scaffolding process, allowing researchers to track improvements in contiguity and scale.

The pipeline processes a collection of FASTA files using [gfastats](https://toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy0) to extract essential assembly statistics. It then utilizes a series of text processing tools, including [Datamash](https://toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.9+galaxy0) and [awk](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy2), to reformat and normalize the data. The workflow automatically incorporates the input dataset names as labels to ensure clear identification within the final visualizations.

The final outputs are generated using [ggplot2](https://toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/3.5.1+galaxy2), producing high-quality scatterplots for both Nx distribution and assembly size. These plots provide a direct visual comparison of how different assembly versions or scaffolding strategies impact the overall quality of the genome reconstruction.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Collection of genomes to plot | data_collection_input | Name the items inside the collection with the names you want to appear on the plot |


Upload your assemblies as a list collection of FASTA files, ensuring each dataset is named exactly as you want it to appear in the final plot legends. Using a collection is required for the workflow to correctly iterate through multiple genomes and aggregate the statistics for comparative visualization. For automated testing or local execution, you can initialize your environment using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on file preparation and specific naming conventions.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.11+galaxy0 |  |
| 2 | Sort | sort1 |  |
| 3 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy2 |  |
| 4 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.9+galaxy0 |  |
| 5 | Add column | toolshed.g2.bx.psu.edu/repos/devteam/add_value/addValue/1.0.1 |  |
| 6 | Parse parameter value | param_value_from_file |  |
| 7 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 8 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 9 | Add input name as column | toolshed.g2.bx.psu.edu/repos/mvdbeek/add_input_name_as_column/addName/0.2.0 |  |
| 10 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 11 | Cut | Cut1 |  |
| 12 | Cut | Cut1 |  |
| 13 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/3.5.1+galaxy2 |  |
| 14 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/3.5.1+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | gfastats data for plotting | out_file1 |
| 13 | Nx Plot | output1 |
| 14 | Size Plot | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Generate-Nx-and-Size-plots-for-multiple-assemblies.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Generate-Nx-and-Size-plots-for-multiple-assemblies.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Generate-Nx-and-Size-plots-for-multiple-assemblies.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Generate-Nx-and-Size-plots-for-multiple-assemblies.ga -o job.yml`
- Lint: `planemo workflow_lint Generate-Nx-and-Size-plots-for-multiple-assemblies.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Generate-Nx-and-Size-plots-for-multiple-assemblies.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
