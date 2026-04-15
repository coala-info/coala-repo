---
name: introduction-to-dh-in-galaxy
description: This digital humanities workflow processes two plain text files using regex-based cleaning, word counting, and grep-based extraction to facilitate comparative literary analysis. Use this skill when you need to identify thematic differences between two documents through word clouds, side-by-side diff visualizations, and targeted keyword extraction.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# introduction-to-dh-in-galaxy

## Overview

This workflow provides an introductory entry point for Digital Humanities (DH) researchers to explore the [Galaxy platform](https://usegalaxy.org/). It is designed to process two plain text (.txt) files, guiding users through common text-processing tasks such as cleaning, formatting, and basic quantitative analysis.

The pipeline begins by cleaning the input data, removing metadata headers and punctuation via regular expressions to ensure a consistent comparison. It then generates word clouds to visualize thematic frequency and utilizes line, word, and character counts to provide a statistical overview of the documents.

To facilitate deeper analysis, the workflow rearranges the text into a one-word-per-line format, allowing for a side-by-side comparison using the `diff` tool. Finally, it extracts specific passages based on keyword searches, enabling researchers to isolate notable lines for close reading or further computational study.

This resource is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is particularly useful for those following [GTN](https://training.galaxyproject.org/) tutorials. For specific execution details, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Text one | data_input | Upload a text as a .txt file that you want to compare to another text. |
| 1 | Input Text two | data_input | Upload a second text as a .txt file that you want to compare to the first text. |


To run this workflow, upload two plain text files (.txt) as individual datasets to your Galaxy history. Ensure your inputs are formatted with one sentence or paragraph per line, as the cleaning steps rely on regular expressions to strip headers and punctuation before performing word-level comparisons. While this workflow uses discrete datasets, you can refer to the README.md for detailed guidance on specific text patterns and extraction criteria. For automated testing or batch execution, consider using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Remove beginning | Remove beginning1 |  |
| 3 | Remove beginning | Remove beginning1 |  |
| 4 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.5+galaxy2 |  |
| 5 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy2 |  |
| 6 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.5+galaxy2 |  |
| 7 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy2 |  |
| 8 | Line/Word/Character count | wc_gnu |  |
| 9 | Generate a word cloud | toolshed.g2.bx.psu.edu/repos/bgruening/wordcloud/wordcloud/1.9.4+galaxy4 |  |
| 10 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.5+galaxy2 |  |
| 11 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.5+galaxy2 |  |
| 12 | Line/Word/Character count | wc_gnu |  |
| 13 | Generate a word cloud | toolshed.g2.bx.psu.edu/repos/bgruening/wordcloud/wordcloud/1.9.4+galaxy4 |  |
| 14 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.5+galaxy2 |  |
| 15 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.5+galaxy2 |  |
| 16 | diff | toolshed.g2.bx.psu.edu/repos/bgruening/diff/diff/3.10+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | WordCloud01 | output |
| 11 | output01 | output |
| 13 | WordCloud02 | output |
| 15 | output02 | output |
| 16 | html_file | html_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run introduction-to-digital-humanities.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run introduction-to-digital-humanities.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run introduction-to-digital-humanities.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init introduction-to-digital-humanities.ga -o job.yml`
- Lint: `planemo workflow_lint introduction-to-digital-humanities.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `introduction-to-digital-humanities.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)