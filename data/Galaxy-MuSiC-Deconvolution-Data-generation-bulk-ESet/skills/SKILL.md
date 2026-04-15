---
name: music-deconvolution-data-generation-bulk-eset
description: This transcriptomics workflow processes raw bulk expression matrices and metadata using tools like annotateMyIDs and music_construct_eset to generate standardized ExpressionSet objects. Use this skill when you need to prepare bulk RNA-seq datasets for MuSiC deconvolution by mapping gene identifiers and structuring expression data into compatible R objects.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# music-deconvolution-data-generation-bulk-eset

## Overview

This workflow automates the generation of bulk ExpressionSet (ESet) objects from raw expression matrices and metadata, a critical preprocessing step for transcriptomics deconvolution using the MuSiC framework. It is designed to streamline the transition from raw tabular data to the structured formats required for downstream multi-subject single-cell analysis.

The pipeline begins with data cleaning and refinement, utilizing tools like [Advanced Cut](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0) and [Regex Find And Replace](https://toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.2) to format input files. A key feature is the automated gene identifier mapping, which uses [annotateMyIDs](https://toolshed.g2.bx.psu.edu/repos/iuc/annotatemyids/annotatemyids/3.14.0+galaxy1) and a specialized subworkflow to convert Ensembl IDs to Gene Symbols, ensuring duplicate genes are summed correctly for accurate expression profiling.

The final stage of the workflow employs [music_construct_eset](https://toolshed.g2.bx.psu.edu/repos/bgruening/music_construct_eset/music_construct_eset/0.1.1+galaxy4) to assemble the processed data into an R-compatible ESet object. Subsequent manipulation steps refine the object to ensure compatibility with deconvolution algorithms, outputting both RDS files and tabular summaries.

This workflow is tagged for [GTN](https://training.galaxyproject.org/) training and is highly relevant for researchers working in single-cell and bulk transcriptomics. For detailed configuration and usage instructions, please refer to the README.md in the Files section.

## Inputs and data preparation

_None listed._


Ensure your raw expression matrix and sample metadata are uploaded in tabular format (TSV or CSV), ensuring that gene identifiers like Ensembl IDs are consistent across files. While individual datasets are suitable for single runs, utilizing dataset collections is more efficient when managing multiple bulk samples for batch ESet construction. Refer to the `README.md` for specific column naming conventions and detailed formatting requirements necessary for successful tool execution. You can streamline the configuration of these inputs by using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Remove columns | toolshed.g2.bx.psu.edu/repos/iuc/column_remove_by_header/column_remove_by_header/1.0 | While the EBI data has the gene symbols in it, these are duplicated, so we still need to thin down the duplications. |
| 1 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 2 | annotateMyIDs | toolshed.g2.bx.psu.edu/repos/iuc/annotatemyids/annotatemyids/3.14.0+galaxy1 | Convert EnsemblID to Gene Symbol. Note that some EnsemblID's have multiple Gene Symbols. |
| 3 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.2 |  |
| 4 | Copy of Convert from Ensembl to GeneSymbol, summing duplicate genes | (subworkflow) |  |
| 5 | Construct Expression Set Object | toolshed.g2.bx.psu.edu/repos/bgruening/music_construct_eset/music_construct_eset/0.1.1+galaxy4 |  |
| 6 | Manipulate Expression Set Object | toolshed.g2.bx.psu.edu/repos/bgruening/music_manipulate_eset/music_manipulate_eset/0.1.1+galaxy4 |  |
| 7 | Manipulate Expression Set Object | toolshed.g2.bx.psu.edu/repos/bgruening/music_manipulate_eset/music_manipulate_eset/0.1.1+galaxy4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | output_tabular | output_tabular |
| 1 | output | output |
| 2 | annotateMyIDs on input dataset(s): Annotated IDs | out_tab |
| 3 | out_file1 | out_file1 |
| 5 | out_rds | out_rds |
| 5 | out_txt | out_txt |
| 6 | Manipulate Expression Set Object on input dataset(s): ExpressionSet Object | out_eset |
| 7 | out_eset | out_eset |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run bulk-eset.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run bulk-eset.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run bulk-eset.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init bulk-eset.ga -o job.yml`
- Lint: `planemo workflow_lint bulk-eset.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `bulk-eset.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)