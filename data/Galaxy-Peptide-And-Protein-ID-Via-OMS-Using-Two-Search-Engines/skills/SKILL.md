---
name: peptide-and-protein-id-via-oms-using-two-search-engines
description: This proteomics workflow processes mzML mass spectrometry data and protein databases to identify peptides and proteins using OpenMS tools including XTandemAdapter, MSGFPlusAdapter, and ConsensusID. Use this skill when you want to improve the reliability of peptide identifications by integrating results from multiple search algorithms and performing statistical validation through posterior error probabilities and false discovery rate analysis.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# peptide-and-protein-id-via-oms-using-two-search-engines

## Overview

This Galaxy workflow provides a robust pipeline for peptide and protein identification by leveraging two complementary search engines: [X!Tandem](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_xtandemadapter/XTandemAdapter/2.2.0.1) and [MS-GF+](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_msgfplusadapter/MSGFPlusAdapter/2.2.0). By processing mzML mass spectrometry data against a human protein database containing decoys, the workflow increases identification sensitivity and confidence through a multi-engine consensus approach.

The pipeline utilizes [OpenMS](https://www.openms.de/) tools to calculate posterior error probabilities for each engine's outputs before merging them. Using [ConsensusID](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_consensusid/ConsensusID/2.2.0), the workflow integrates the search results to improve the reliability of peptide-spectrum matches (PSMs) and resolve discrepancies between the different algorithms.

For higher-level analysis, the workflow performs protein inference using the [FidoAdapter](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_fidoadapter/FidoAdapter/2.2.0.1) and applies rigorous False Discovery Rate (FDR) filtering. The final outputs include filtered identification files and detailed summary reports in both XML and TSV formats, providing a comprehensive overview of the proteomic sample. This workflow is a standard practice in [Proteomics](https://training.galaxyproject.org/training-material/topics/proteomics/) for ensuring high-quality protein identifications.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | mzML_test_dataset | data_input |  |
| 1 | Human_database_including_decoys | data_input |  |


Ensure your mass spectrometry data is in mzML format and your protein database is a FASTA file containing both target and decoy sequences to allow for accurate FDR estimation. For large-scale analyses, organizing mzML files into a dataset collection simplifies the parallel execution of the X!Tandem and MS-GF+ search adapters. Refer to the README.md for comprehensive parameter settings and database preparation requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | XTandemAdapter | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_xtandemadapter/XTandemAdapter/2.2.0.1 |  |
| 3 | MSGFPlusAdapter | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_msgfplusadapter/MSGFPlusAdapter/2.2.0 |  |
| 4 | IDPosteriorErrorProbability | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_idposteriorerrorprobability/IDPosteriorErrorProbability/2.2.0 |  |
| 5 | IDPosteriorErrorProbability | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_idposteriorerrorprobability/IDPosteriorErrorProbability/2.2.0 |  |
| 6 | IDMerger | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_idmerger/IDMerger/2.2.0 |  |
| 7 | ConsensusID | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_consensusid/ConsensusID/2.2.0 |  |
| 8 | PeptideIndexer | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_peptideindexer/PeptideIndexer/2.2.0 |  |
| 9 | FalseDiscoveryRate | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_falsediscoveryrate/FalseDiscoveryRate/2.2.0 |  |
| 10 | IDScoreSwitcher | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_idscoreswitcher/IDScoreSwitcher/2.2.0 |  |
| 11 | FileInfo | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_fileinfo/FileInfo/2.2.0 |  |
| 12 | FidoAdapter | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_fidoadapter/FidoAdapter/2.2.0.1 |  |
| 13 | FalseDiscoveryRate | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_falsediscoveryrate/FalseDiscoveryRate/2.2.0 |  |
| 14 | IDFilter | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_idfilter/IDFilter/2.2.0 |  |
| 15 | FileInfo | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_fileinfo/FileInfo/2.2.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | param_out | param_out |
| 11 | param_out_tsv | param_out_tsv |
| 11 | param_out | param_out |
| 14 | param_out | param_out |
| 15 | param_out_tsv | param_out_tsv |
| 15 | param_out | param_out |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow-two-search-engines.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow-two-search-engines.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow-two-search-engines.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow-two-search-engines.ga -o job.yml`
- Lint: `planemo workflow_lint workflow-two-search-engines.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow-two-search-engines.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)