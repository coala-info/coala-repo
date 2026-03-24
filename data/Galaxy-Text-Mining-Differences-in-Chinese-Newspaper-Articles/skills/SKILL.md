---
name: text-mining-differences-in-chinese-newspaper-articles
description: "This digital humanities workflow compares censored and uncensored Chinese newspaper articles using text processing, diff comparison, and word cloud generation tools to identify textual discrepancies. Use this skill when you need to analyze patterns of censorship or editorial changes between different versions of Chinese-language news media."
homepage: https://workflowhub.eu/workflows/1623
---

# Text-Mining Differences in Chinese Newspaper Articles

## Overview

This workflow is designed for Digital Humanities research to identify and analyze textual variations between different versions of Chinese newspaper articles, specifically focusing on differences between censored and uncensored texts. By automating the comparison process, it allows researchers to efficiently pinpoint editorial changes, omissions, or substitutions in large-scale Chinese-language datasets.

The pipeline begins by cleaning and normalizing the input texts using [Replace Text](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.5+galaxy0) tools. It then utilizes the [diff](https://toolshed.g2.bx.psu.edu/repos/bgruening/diff/diff/3.10+galaxy1) tool to isolate specific discrepancies between the two versions. These results are further processed through filtering, column computation, and data aggregation via [Datamash](https://toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.8+galaxy0) to quantify the nature of the textual shifts.

The final outputs include a sorted CSV file detailing the frequency of specific changes and a [word cloud](https://toolshed.g2.bx.psu.edu/repos/bgruening/wordcloud/wordcloud/1.9.4+galaxy1) for visual exploration of the most prominent differences. This workflow is a [GTN](https://training.galaxyproject.org/) resource and is provided under a CC-BY-4.0 license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input censored text | data_input | Upload the censored text containing replacement characters like ‘×’. |
| 1 | Input uncensored text | data_input | Upload the uncensored text without replacement characters. |


Ensure your censored and uncensored newspaper articles are uploaded as plain text (.txt) files to maintain character encoding integrity for Chinese text processing. While the workflow is configured for individual dataset inputs, you can adapt it for batch processing by using dataset collections for larger archives. Refer to the README.md for comprehensive details on character normalization and the specific preprocessing steps required for accurate text comparison. You may also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.5+galaxy0 | This step uses Regular Expressions to delete all empty spaces (\s) and show only one character per line (\1\n).  The result is a cleaned and reformatted text showing only one character per line. |
| 3 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.5+galaxy0 | This step uses Regular Expressions to delete all empty spaces (\s) and show only one character per line (\1\n).  The result is a cleaned and reformatted text showing only one character per line. |
| 4 | diff | toolshed.g2.bx.psu.edu/repos/bgruening/diff/diff/3.10+galaxy1 | The diff tool compares the two cleaned texts. This version (HTML version) creates an HTML file, which colour codes differences as additions (green) or extractions (red) when comparing the texts. |
| 5 | diff | toolshed.g2.bx.psu.edu/repos/bgruening/diff/diff/3.10+galaxy1 | The diff tool compares the two cleaned texts. This version of the output (raw output) is used for the further steps of the analysis. It is less intuitive for users. Therefore, the second diff below includes a more visual version of the output (HTML). |
| 6 | Filter | Filter1 | This step selects all lines from the diff file that contain the censorship symbol ×. The condition "ord(c1) == 215" means that lines in column c1, which contain the censored text, are selected if they match ×. The symbol × is unspecific, therefore, the Unicode identifier of the character (215) is used for clarity in this condition.  This step does not show an output. If the filtered symbol is empty in the second text, this file lacks columns to compute the following steps. This is invisible for users but would cause a technical error. The compute step covers this and makes sure all necessary columns exist. It shows the output for both steps (Extracting and Compute) correctly.  Add another Unicode here if you want to select a different character, for example, '□' or '△'. You can get the respective code, for example, on this website: https://www.mauvecloud.net/charsets/CharCodeFinder.html Copy the character you want to filter in the "input" window and select "Decimal Character Codes" as an output. If you do this for symbol ×, you get 215. |
| 7 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 | This step unifies the formatting and adds potentially missing columns, should lines extracted before coming up empty in the second text. This ensures the proper number of columns and allows the smooth running of the next steps. |
| 8 | Cut | Cut1 | This step selects only column 9, which contains the uncensored characters from text two. The result is only one column with different rows of Chinese characters.   This step allows scaling words by frequency the word cloud in the next step. meaning characters that appear more often appear bigger, making the results evident at first sight. |
| 9 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.8+galaxy0 | This step sums up how often which character appeared in the table before. |
| 10 | Generate a word cloud | toolshed.g2.bx.psu.edu/repos/bgruening/wordcloud/wordcloud/1.9.4+galaxy1 | This step shows, which characters were censored in the first text. The bigger the word, the more often it appeared in the text. |
| 11 | Sort | sort1 | Sorts the quantified results from those appearing most to those appearing least. |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 10 | output_graphic | output |
| 11 | output_csv | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
