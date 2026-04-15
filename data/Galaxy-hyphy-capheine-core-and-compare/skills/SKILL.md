---
name: capheine-combined-hyphy-core-and-compare
description: This workflow performs codon-aware alignment and evolutionary selection analysis on viral coding sequences using HyPhy tools like MEME, BUSTED, and FEL, with optional branch-specific comparisons via Contrast-FEL and RELAX. Use this skill when you need to identify sites under diversifying selection or compare evolutionary pressures between specific foreground and background lineages in a multi-gene dataset.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# capheine-combined-hyphy-core-and-compare

## Overview

CAPHEINE is a comprehensive evolutionary analysis pipeline that orchestrates codon-aware preprocessing and selection analysis. Inspired by the [veg/capheine](https://github.com/veg/capheine) Nextflow implementation, it automates a multi-step workflow including fasta cleanup, alignment via cawlign, tree construction with IQ-TREE, and core [HyPhy](https://github.com/veg/hyphy) analyses such as FEL, MEME, PRIME, and BUSTED.

The workflow features an optional branch-comparison module that is triggered when foreground sequence identifiers are provided via regular expressions or a specific list. When active, the pipeline performs branch labeling to run Contrast-FEL for site-level comparisons and RELAX to test for intensified or relaxed selection pressure between foreground and background sets.

Designed primarily for viral datasets, the workflow handles multi-gene reference files and collections of unaligned sequences. Users should exercise caution with bacterial or eukaryotic datasets, as internal stop codons or recombination can impact the reliability of the HyPhy estimates. Detailed information on input configuration and file preparation can be found in the [README.md](README.md).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | reference cds | data_input | reference cds |
| 1 | unaligned sequences | data_collection_input | unaligned sequences |
| 2 | foreground regexp (optional) | parameter_input | Regular expression to match foreground sequence names for branch labeling. |
| 3 | foreground list (optional) | data_input | File containing list of foreground sequence names (one per line). Leave empty to skip foreground sequence selection. |


This workflow requires a multi-gene reference CDS file and a list collection of unaligned FASTA sequences, one per sample, to initiate the codon-aware alignment and selection analysis. To enable the branch-comparison module, provide either a regular expression or a text file containing specific sequence identifiers to be labeled as foreground. Ensure all FASTA headers are consistent across datasets to avoid mapping errors during the labeling and tree-building stages. Refer to the README.md for comprehensive details on input formatting and the logic governing foreground selection. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | HyPhy: Core | (subworkflow) | Subworkflow step |
| 5 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/9.5+galaxy3 | Save RegEx to File |
| 6 | Select | Grep1 | Collect Sequence Identifiers |
| 7 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy3 | This step makes sure the regex is whitespace-trimmed, blank lines are dropped, and anything outside [0-9A-Za-z_] becomes _ to match HyPhy CLN behavior. |
| 8 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 9 | Line/Word/Character count | wc_gnu | Count characters in RegEx |
| 10 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/9.5+galaxy3 |  |
| 11 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy3 | Check is RegEx Empty |
| 12 | Trim | trimmer |  |
| 13 | Parse parameter value | param_value_from_file | (Boolean) Continue Foreground Sequence List Creation |
| 14 | Select | Grep1 | Build Foreground Sequence List from RegEx |
| 15 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 | Choose Foreground Sequences |
| 16 | Line/Word/Character count | wc_gnu | This counts the number of lines in the provided list of foreground sequences. If the count is &gt; 0 RELAX and Contrast-FEL will also run. |
| 17 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy3 | This will return 'true' if the count of foreground sequences is &gt; 0 and 'false' otherwise |
| 18 | Parse parameter value | param_value_from_file | (Boolean) Continue foreground comparison |
| 19 | HyPhy: Compare | (subworkflow) | Subworkflow step |
| 20 | DRHIP | toolshed.g2.bx.psu.edu/repos/iuc/drhip/drhip/0.1.4+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 20 | combined_summary | combined_summary |
| 20 | combined_sites | combined_sites |
| 20 | combined_comparison_summary | combined_comparison_summary |
| 20 | combined_comparison_site | combined_comparison_site |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run capheine-core-and-compare.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run capheine-core-and-compare.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run capheine-core-and-compare.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init capheine-core-and-compare.ga -o job.yml`
- Lint: `planemo workflow_lint capheine-core-and-compare.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `capheine-core-and-compare.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)