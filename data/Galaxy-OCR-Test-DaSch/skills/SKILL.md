---
name: ocr-test-dasch
description: "This workflow processes historical German newspaper images from DaSch using Tesseract OCR, regex cleaning tools, and wordcloud visualization to transform visual text into machine-readable data. Use this skill when you need to digitize archival documents, remove noise and punctuation from extracted text, and identify prominent themes through visual word frequency analysis."
homepage: https://workflowhub.eu/workflows/2014
---

# OCR Test DaSch

## Overview

This workflow demonstrates how to process archival material from DaSch within the Galaxy ecosystem. Specifically, it provides a pipeline for performing Optical Character Recognition (OCR) on historical documents, such as German newspapers, to transform them into machine-readable and searchable formats.

The process begins by taking an input image and a custom list of stopwords. It utilizes [Tesseract](https://toolshed.g2.bx.psu.edu/repos/iuc/tesseract/tesseract/5.5.1+galaxy0) to extract raw text, which is then refined through several cleaning steps. Tools such as [Regex Find And Replace](https://toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3) and [Replace Text](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.5+galaxy2) are employed to strip punctuation and normalize the text data.

The final outputs include a cleaned text file and a visual [word cloud](https://toolshed.g2.bx.psu.edu/repos/bgruening/wordcloud/wordcloud/1.9.4+galaxy3) that highlights the most frequent terms in the document. This workflow is licensed under CC-BY-4.0 and serves as a practical example for researchers working with DaSch data and OCR-based text analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Image | data_input | Upload of images to make OCR readable |
| 1 | Upload Stopwords | data_input |  |


Ensure the input image is provided in a standard format such as PNG, TIFF, or JPEG for optimal Tesseract performance, while the stopwords should be uploaded as a plain text file. If you are processing multiple newspaper pages simultaneously, consider organizing your inputs into a data collection to streamline the tool execution. For comprehensive guidance on specific parameter settings and data formatting, please refer to the accompanying README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Tesseract | toolshed.g2.bx.psu.edu/repos/iuc/tesseract/tesseract/5.5.1+galaxy0 |  |
| 3 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 | Remove single items shown at the beginning or end of the line |
| 4 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.5+galaxy2 |  |
| 5 | Generate a word cloud | toolshed.g2.bx.psu.edu/repos/bgruening/wordcloud/wordcloud/1.9.4+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | out_file1 | out_file1 |
| 5 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-example.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-example.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-example.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-example.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-example.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-example.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
