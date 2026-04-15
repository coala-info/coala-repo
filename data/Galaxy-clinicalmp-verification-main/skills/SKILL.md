---
name: clinical-metaproteomics-verification-workflow
description: This clinical metaproteomics workflow utilizes PepQuery2 to verify microbial peptides identified in MS/MS datasets against human and contaminant databases using SGPS and MaxQuant reports. Use this skill when you need to statistically validate the presence of specific peptide sequences in complex clinical samples to ensure data accuracy before performing downstream quantitation.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# clinical-metaproteomics-verification-workflow

## Overview

The Clinical Metaproteomics Verification workflow is designed to validate microbial peptides identified during the discovery phase of proteomics research. By utilizing the [PepQuery2](https://toolshed.g2.bx.psu.edu/repos/galaxyp/pepquery2/pepquery2/2.0.2+galaxy2) tool, the workflow ensures the accuracy and biological relevance of detected sequences before proceeding to quantitation. This process is essential for high-confidence metaproteomics analysis, particularly in clinical contexts such as the study of Papanicolaou test samples.

The pipeline integrates tandem mass spectrometry (MS/MS) datasets with peptide reports from SGPS and MaxQuant. It begins by constructing a comprehensive reference database using the [Protein Database Downloader](https://toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.4) to fetch Human UniProt sequences and common contaminants (cRAP). These sequences are merged and filtered to create a background for PepQuery, which then statistically evaluates the peptide-spectrum matches to confirm the presence of specific microbial targets.

Final outputs include verified peptide-to-protein mappings and a refined UniProt ID list. Crucially, the workflow generates a specialized quantitation database for MaxQuant, enabling researchers to move seamlessly into the next stage of the [Clinical Metaproteomics tutorial series](https://training.galaxyproject.org/training-material/topics/proteomics/tutorials/clinical-mp-3-verification/tutorial.html). For detailed information on input preparation and parameter settings, please refer to the [README.md](#) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 2 | Tandem Mass Spectrometry (MS/MS) datasets | data_collection_input | The MGF files from mass spectrometry data. |
| 3 | SGPS peptide report | data_input | The peptide report from SearchGUI/PeptideShaker. |
| 4 | Distinct Peptides for PepQuery | data_input | Microbial peptides that will be used for PepQuery2 analysis. |
| 5 | MaxQuant peptide report | data_input | Peptide report from MaxQuant search. |


Ensure your MS/MS data is organized into a dataset collection to facilitate batch processing through PepQuery2, while the SGPS, MaxQuant, and distinct peptide reports should be uploaded as individual tabular files. Verify that your FASTA databases for Human UniProt and cRAP are correctly formatted, as these are essential for filtering and sequence merging steps. For automated job configuration and parameter testing, you can utilize `planemo workflow_job_init` to generate a `job.yml` file. Detailed instructions on specific search tolerances and digestion settings are available in the README.md. Refer to the project documentation for comprehensive guidance on preparing these pilot datasets for clinical verification.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.4 |  |
| 1 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.4 |  |
| 6 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |
| 7 | Cut | Cut1 |  |
| 8 | Cut | Cut1 |  |
| 9 | PepQuery2 | toolshed.g2.bx.psu.edu/repos/galaxyp/pepquery2/pepquery2/2.0.2+galaxy2 |  |
| 10 | Remove beginning | Remove beginning1 |  |
| 11 | Remove beginning | Remove beginning1 |  |
| 12 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 13 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/9.3+galaxy1 |  |
| 14 | Filter | Filter1 |  |
| 15 | Remove beginning | Remove beginning1 |  |
| 16 | Cut | Cut1 |  |
| 17 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |
| 18 | Remove beginning | Remove beginning1 |  |
| 19 | Group | Grouping1 |  |
| 20 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |
| 21 | UniProt | toolshed.g2.bx.psu.edu/repos/galaxyp/uniprotxml_downloader/uniprotxml_downloader/2.4.0 |  |
| 22 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | Human UniProt+Isoforms FASTA | output_database |
| 1 | cRAP | output_database |
| 6 | Human UniProt+Isoforms+cRAP FASTA | output |
| 17 | Peptide and Protein from Peptide Reports | output |
| 20 | Uniprot ID from verified Peptides | output |
| 22 | Quantitation Database for MaxQuant | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run clinicalmp-verification.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run clinicalmp-verification.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run clinicalmp-verification.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init clinicalmp-verification.ga -o job.yml`
- Lint: `planemo workflow_lint clinicalmp-verification.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `clinicalmp-verification.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)