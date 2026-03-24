---
name: trio-analysis-tutorial
description: "This workflow performs trio-based variant analysis on genomic data using pedigree files and VCFs processed through the EGA Download Client, bcftools, SnpEff, and GEMINI. Use this skill when you need to identify candidate pathogenic mutations in rare disease cases by evaluating inheritance patterns across family members."
homepage: https://workflowhub.eu/workflows/1636
---

# Trio Analysis Tutorial

## Overview

This Galaxy workflow facilitates the identification of disease-causing variants through trio analysis using synthetic datasets from the [RD-Connect GPAP](https://rd-connect.eu/). It automates the retrieval of genomic data via the EGA Download Client, followed by a rigorous preprocessing pipeline that includes VCF normalization with `bcftools norm`, header corrections, and the merging of individual samples into a unified trio dataset.

The downstream analysis focuses on functional annotation and inheritance modeling. The workflow utilizes `SnpEff` for variant annotation and `GEMINI` to load the data into a queryable database, allowing for the identification of specific inheritance patterns (e.g., autosomal recessive, de novo). Results are further enriched with visual exploration using the `gene.iobio` tool to assist in the prioritization of candidate genes.

This pipeline is based on established [GTN](https://training.galaxyproject.org/) training materials for variant analysis and is licensed under the MIT license. It provides a standardized approach for researchers to move from raw EGA-hosted VCFs to filtered, interpretable lists of variants relevant to rare disease diagnostics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 2 | pedigree | data_input |  |


For successful execution, ensure your pedigree file follows the standard PED format and that you have valid EGA credentials for the initial data retrieval steps. The workflow is designed to handle VCF files within a dataset collection, which facilitates efficient batch processing during the normalization and merging stages. Detailed instructions on configuring the EGA client and specific pedigree requirements are available in the README.md. To automate the setup of these parameters, you can use `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | EGA Download Client | toolshed.g2.bx.psu.edu/repos/iuc/ega_download_client/pyega3/5.0.2+galaxy0 |  |
| 1 | EGA Download Client | toolshed.g2.bx.psu.edu/repos/iuc/ega_download_client/pyega3/5.0.2+galaxy0 |  |
| 3 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 4 | EGA Download Client | toolshed.g2.bx.psu.edu/repos/iuc/ega_download_client/pyega3/5.0.2+galaxy0 |  |
| 5 | Convert compressed file to uncompressed. | CONVERTER_gz_to_uncompressed |  |
| 6 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.1 | Add chr prefix |
| 7 | bcftools norm | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_norm/bcftools_norm/1.9+galaxy1 |  |
| 8 | Filter | Filter1 |  |
| 9 | bcftools merge | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_merge/bcftools_merge/1.10 |  |
| 10 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy1 |  |
| 11 | Convert uncompressed file to compressed | CONVERTER_uncompressed_to_gz |  |
| 12 | gene.iobio visualisation | toolshed.g2.bx.psu.edu/repos/iuc/geneiobio/gene_iobio_display_generation_iframe/4.7.1 |  |
| 13 | GEMINI load | toolshed.g2.bx.psu.edu/repos/iuc/gemini_load/gemini_load/0.20.1+galaxy2 |  |
| 14 | GEMINI inheritance pattern | toolshed.g2.bx.psu.edu/repos/iuc/gemini_inheritance/gemini_inheritance/0.20.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | EGA Download Client: authorized datasets | authorized_datasets |
| 1 | List of files in EGAD00001008392 | dataset_file_list |
| 3 | List of Case 5 VCFs | output |
| 4 | Case 5 VCFs.gz | downloaded_file_collection |
| 5 | Case 5 VCFs | output1 |
| 6 | Case 5 VCFs (Fixed Header and Chr) | out_file1 |
| 7 | Case 5 Normalized VCFs | output_file |
| 8 | Case 5 Normalized VCFs (Removed <NON_REF>) | out_file1 |
| 9 | Case 5 Merged VCF | output_file |
| 10 | statsFile | statsFile |
| 10 | Case 5 SnpEff Annotated vcf | snpeff_output |
| 11 | SnpEff Annotated vcf_bgzip | output1 |
| 12 | Case 5 gene.iobio results | outfile |
| 13 | GEMINI Database | outfile |
| 14 | Case 5 GEMINI results | outfile |


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
