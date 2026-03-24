---
name: covid-19-genomics-3-mrca-analysis
description: "This workflow processes SARS-CoV-2 accession dates to download sequences from NCBI, perform multiple sequence alignment with MAFFT, and generate a phylogenetic tree using FastTree. Use this skill when you need to estimate the date of the most recent common ancestor for viral samples to reconstruct the evolutionary history and early transmission dynamics of an outbreak."
homepage: https://workflowhub.eu/workflows/6
---

# COVID-19 - Genomics [3] MRCA analysis

## Overview

This workflow is designed to estimate the date of the Most Recent Common Ancestor (MRCA) for SARS-CoV-2. It begins by processing a list of accession numbers and dates, which are used to fetch genomic sequences directly from NCBI via the [NCBI Accession Download](https://toolshed.g2.bx.psu.edu/repos/iuc/ncbi_acc_download/ncbi_acc_download/0.2.5+galaxy0) tool.

The pipeline performs several text manipulation and normalization steps, including character conversion and FASTA normalization, to prepare the sequence data for comparative analysis. It then utilizes [MAFFT](https://toolshed.g2.bx.psu.edu/repos/rnateam/mafft/rbc_mafft/7.221.3) to perform multiple sequence alignment, ensuring the genomic data is properly structured for evolutionary modeling.

In the final stage, the aligned sequences are processed by [FastTree](https://toolshed.g2.bx.psu.edu/repos/iuc/fasttree/fasttree/2.1.10+galaxy1) to generate a phylogenetic tree. This output is essential for dating the MRCA and understanding the early evolutionary trajectory of the virus during the COVID-19 pandemic.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | CoV acc date | data_input |  |


The primary input for this workflow is a tabular file containing SARS-CoV-2 accession numbers and their corresponding collection dates to facilitate temporal analysis. Utilizing a dataset collection for the accession list is recommended to streamline the NCBI download and subsequent collection collapse steps. Please consult the `README.md` for precise formatting requirements of the input table and further details on the MRCA estimation parameters. You can also use `planemo workflow_job_init` to create a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Remove beginning | Remove beginning1 |  |
| 2 | Convert | Convert characters1 |  |
| 3 | Cut | Cut1 |  |
| 4 | NCBI Accession Download | toolshed.g2.bx.psu.edu/repos/iuc/ncbi_acc_download/ncbi_acc_download/0.2.5+galaxy0 |  |
| 5 | NormalizeFasta | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_NormalizeFasta/2.18.2.1 |  |
| 6 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/1.1.1 |  |
| 7 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.1 |  |
| 8 | MAFFT | toolshed.g2.bx.psu.edu/repos/rnateam/mafft/rbc_mafft/7.221.3 |  |
| 9 | FASTTREE | toolshed.g2.bx.psu.edu/repos/iuc/fasttree/fasttree/2.1.10+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Genomics-3-MRCA.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Genomics-3-MRCA.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Genomics-3-MRCA.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Genomics-3-MRCA.ga -o job.yml`
- Lint: `planemo workflow_lint Genomics-3-MRCA.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Genomics-3-MRCA.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
