---
name: proteomics-peptide-and-protein-id-using-openms
description: This proteomics workflow processes mzML mass spectrometry data and FASTA protein sequences to perform peptide and protein identification using OpenMS tools such as XTandemAdapter, PeptideIndexer, and FidoAdapter. Use this skill when you need to identify proteins in a biological sample by matching experimental spectra against a sequence database while controlling for false discovery rates and calculating posterior error probabilities.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# proteomics-peptide-and-protein-id-using-openms

## Overview

This workflow provides a standardized pipeline for peptide and protein identification from mass spectrometry data using the [OpenMS](https://www.openms.de/) framework. It processes raw mass spectrometry files in `mzML` format alongside a protein database in `fasta` format to identify sequences and infer the protein content of a sample.

The analysis begins with signal processing using `PeakPickerHiRes` to centroid the data, followed by peptide identification via the `XTandemAdapter` search engine. The workflow then maps these peptides to the reference database using `PeptideIndexer` and performs statistical validation. This validation includes calculating posterior error probabilities and estimating False Discovery Rates (FDR) to ensure the reliability of the identifications.

To transition from peptide sequences to protein-level results, the pipeline employs the `FidoAdapter` for protein inference. This step groups identified peptides and assigns probabilities to the proteins they represent. The final stages involve secondary FDR filtering and data conversion via `TextExporter`, with additional filtering steps to produce a refined list of identified proteins and peptides.

This workflow is a core component of [Proteomics](https://training.galaxyproject.org/training-material/topics/proteomics/) research within the Galaxy ecosystem and follows established [GTN](https://training.galaxyproject.org/) best practices for high-resolution mass spectrometry analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | mzml input | data_input |  |
| 1 | fasta input | data_input |  |


Ensure your input files are in standard `.mzML` format for mass spectrometry data and `.fasta` for the protein sequence database. For high-throughput analysis of multiple samples, organize your mzML files into a dataset collection to process them simultaneously through the OpenMS tools. Consult the `README.md` for detailed instructions on specific tool parameters and database formatting requirements. You can use `planemo workflow_job_init` to create a `job.yml` file for configuring and automating your workflow runs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | PeakPickerHiRes | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_peakpickerhires/PeakPickerHiRes/2.3.0 |  |
| 3 | XTandemAdapter | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_xtandemadapter/XTandemAdapter/2.6+galaxy0 |  |
| 4 | FileInfo | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_fileinfo/FileInfo/2.6+galaxy0 |  |
| 5 | PeptideIndexer | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_peptideindexer/PeptideIndexer/2.6+galaxy0 |  |
| 6 | IDPosteriorErrorProbability | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_idposteriorerrorprobability/IDPosteriorErrorProbability/2.6+galaxy0 |  |
| 7 | FalseDiscoveryRate | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_falsediscoveryrate/FalseDiscoveryRate/2.6+galaxy0 |  |
| 8 | IDScoreSwitcher | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_idscoreswitcher/IDScoreSwitcher/2.6+galaxy0 |  |
| 9 | FileInfo | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_fileinfo/FileInfo/2.6+galaxy0 |  |
| 10 | FidoAdapter | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_fidoadapter/FidoAdapter/2.6+galaxy0 |  |
| 11 | FalseDiscoveryRate | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_falsediscoveryrate/FalseDiscoveryRate/2.6+galaxy0 |  |
| 12 | FileInfo | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_fileinfo/FileInfo/2.6+galaxy0 |  |
| 13 | TextExporter | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_textexporter/TextExporter/2.6+galaxy0 |  |
| 14 | Select | Grep1 |  |
| 15 | Select | Grep1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | param_out | param_out |
| 3 | out | out |
| 4 | out | out |
| 5 | out | out |
| 6 | out | out |
| 7 | out | out |
| 8 | out | out |
| 9 | out | out |
| 10 | out | out |
| 11 | out | out |
| 12 | out | out |
| 13 | out | out |
| 14 | out_file1 | out_file1 |
| 15 | out_file1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow.ga -o job.yml`
- Lint: `planemo workflow_lint workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)