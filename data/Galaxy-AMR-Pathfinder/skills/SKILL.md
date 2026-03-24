---
name: amr-pathfinder-v47
description: "This Galaxy workflow integrates multiple antimicrobial resistance (AMR) detection tools, including AbritAMR, SRST2, and StarAMR, to analyze paired-end FASTQ sequencing data and genome assemblies against the CARD and ResFinder databases. Use this skill when you need to benchmark different AMR gene detection methods or generate a consensus report of resistance genes and their percent identity across diverse bacterial isolates."
homepage: https://workflowhub.eu/workflows/1189
---

# AMR-Pathfinder v4.7

## Overview

AMR-Pathfinder v4.7 is a comprehensive Galaxy workflow designed for benchmarking and aggregating antimicrobial resistance (AMR) gene detection. It integrates multiple specialized sub-workflows and tools from the [Seq4AMR](https://workflowhub.eu/projects/110) project, including [AbritAMR / AMRFinderPlus](https://workflowhub.eu/workflows/634), [SRST2](https://workflowhub.eu/workflows/407), and [StarAMR](https://workflowhub.eu/workflows/470). By processing both raw sequencing data (FASTQ) and genome assemblies (FASTA), the workflow provides a unified platform to compare results across different AMR analysis engines.

The pipeline utilizes [hamronize](https://github.com/pha4ge/hamronize) to standardize outputs from various tools, addressing the common challenge of inconsistent gene nomenclature. It performs data cleaning, assembly via Shovill, and gene identification through multiple databases like CARD, ResFinder, and ARG-annot. The final stages involve sophisticated data reshaping to generate comparative reports that highlight presence/absence patterns and identity scores across the different tools.

The primary outputs are two consolidated tables: a **Binary Comparison** table, which reports the discovery or absence of specific AMR genes, and a **% Identity Scored Outputs** table, which captures the highest sequence identity reported for each detected gene. These outputs allow researchers to easily identify consensus or discrepancies between tools, making it a valuable resource for AMR benchmarking and surveillance. This workflow is released under the MIT license and is tagged for AMR benchmarking.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Genome Assemblies | data_collection_input | Collection of .fasta or .fasta.gz files |
| 1 | RGI CARD Database | parameter_input | Please provide a recent CARD database. |
| 2 | FASTQ Sequencing Data | data_collection_input | Collection of .fastq / .fastq.gz files  The identifiers used in this collection (the top level identifiers) **MUST** match the Genome Assemblies collection or the results will be incorrect. |
| 3 | ResFinder.fasta | data_input | Obtain from https://github.com/katholt/srst2/raw/refs/heads/master/data/ResFinder.fasta |
| 4 | ARGannot_r2.fasta | data_input | Obtain from: https://github.com/katholt/srst2/raw/refs/heads/master/data/ARGannot_r2.fasta |


To ensure successful execution, provide genome assemblies as a FASTA collection and sequencing data as a paired-end FASTQ collection, ensuring both use identical element identifiers for proper cross-referencing. You must also supply the RGI CARD database and specific reference files in FASTA format (ResFinder and ARGannot_r2) as individual datasets. For automated testing or command-line execution, you can initialize the environment using `planemo workflow_job_init` to generate a `job.yml` template. Detailed configuration requirements and database setup instructions are available in the README.md. Refer to the README.md for comprehensive guidance on locale settings and database building.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/1.1.0 |  |
| 6 | Sanitise Filename | (subworkflow) |  |
| 7 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 8 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.4 |  |
| 9 | benchAMRking: wf1 | (subworkflow) |  |
| 10 | benchAMRking: wf3b | (subworkflow) |  |
| 11 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.2 |  |
| 12 | Add column | addValue |  |
| 13 | Add column | addValue |  |
| 14 | Relabel identifiers | __RELABEL_FROM_FILE__ |  |
| 15 | WF3: SRST2 :: AMR - SeqSero2/SISTR | (subworkflow) |  |
| 16 | Shovill | toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy1 |  |
| 17 | Add column | addValue |  |
| 18 | ABRicate | toolshed.g2.bx.psu.edu/repos/iuc/abricate/abricate/1.0.1 |  |
| 19 | staramr | toolshed.g2.bx.psu.edu/repos/nml/staramr/staramr_search/0.10.0+galaxy1 |  |
| 20 | Select | Grep1 |  |
| 21 | hamronize | toolshed.g2.bx.psu.edu/repos/iuc/hamronize_tool/hamronize_tool/1.0.3+galaxy1 |  |
| 22 | hamronize | toolshed.g2.bx.psu.edu/repos/iuc/hamronize_tool/hamronize_tool/1.0.3+galaxy1 |  |
| 23 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 24 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.4 |  |
| 25 | hamronize summarize: | toolshed.g2.bx.psu.edu/repos/iuc/hamronize_summarize/hamronize_summarize/1.1.4+galaxy0 |  |
| 26 | hamronize: summarize | toolshed.g2.bx.psu.edu/repos/iuc/hamronize_summarize/hamronize_summarize/1.0.3+galaxy2 |  |
| 27 | hamronize: summarize | toolshed.g2.bx.psu.edu/repos/iuc/hamronize_summarize/hamronize_summarize/1.0.3+galaxy2 |  |
| 28 | Select | Grep1 |  |
| 29 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_on_column/tp_split_on_column/0.2 |  |
| 30 | Cut | Cut1 |  |
| 31 | Select | Grep1 |  |
| 32 | Add column | addValue |  |
| 33 | Merge collections | __MERGE_COLLECTION__ |  |
| 34 | Apply rules | __APPLY_RULES__ |  |
| 35 | Concatenate multiple datasets | toolshed.g2.bx.psu.edu/repos/artbio/concatenate_multiple_datasets/cat_multi_datasets/1.4.3 |  |
| 36 | Cut | Cut1 |  |
| 37 | Cut | Cut1 |  |
| 38 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.8+galaxy0 |  |
| 39 | Add column | addValue |  |
| 40 | Concatenate datasets | cat1 |  |
| 41 | Concatenate datasets | cat1 |  |
| 42 | cast | toolshed.g2.bx.psu.edu/repos/iuc/reshape2_cast/cast/1.4.2 |  |
| 43 | cast | toolshed.g2.bx.psu.edu/repos/iuc/reshape2_cast/cast/1.4.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 14 | output | output |
| 18 | report | report |
| 33 | output | output |
| 41 | scoreless | out_file1 |
| 42 | scored_comp | output |
| 43 | binary_comp | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-AMR-Pathfinder_v4.7.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-AMR-Pathfinder_v4.7.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-AMR-Pathfinder_v4.7.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-AMR-Pathfinder_v4.7.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-AMR-Pathfinder_v4.7.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-AMR-Pathfinder_v4.7.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
