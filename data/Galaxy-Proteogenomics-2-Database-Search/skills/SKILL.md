---
name: proteogenomics-2-database-search
description: "This Galaxy workflow performs proteogenomic database searching by matching MGF mass spectrometry data against a custom FASTA database containing variants and contaminants using Search GUI and Peptide Shaker. Use this skill when you need to identify novel peptides from RNA-Seq derived sequences and filter out known reference proteins to isolate potential neoantigens or uncharacterized protein-coding regions."
homepage: https://workflowhub.eu/workflows/1429
---

# Proteogenomics 2: Database Search

## Overview

This workflow represents the second stage of a proteogenomics pipeline, focusing on the identification of novel peptides by searching mass spectrometry data against customized protein databases. It utilizes a FASTA database containing UniProt sequences, common contaminants (cRAP), and potential novel sequences derived from genomic variations like SAVs and indels. The primary inputs include the MGF peak list collection and a list of reference protein accessions used for downstream filtering.

The core analysis is driven by [Search GUI](https://toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/search_gui/4.0.41+galaxy1) and [Peptide Shaker](https://toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/peptide_shaker/2.0.33+galaxy1), which together manage search engine execution and the subsequent validation of peptide-to-spectrum matches. The workflow automates the configuration of identification parameters and converts the resulting data into an SQLite database to facilitate complex data manipulation and reporting.

In the final stages, the workflow employs [Query Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2) to refine the results. It specifically filters out known reference proteins to isolate novel sequences and applies a length filter to retain only peptides between 7 and 29 amino acids. The final output is a FASTA file of these candidate peptides, formatted specifically for subsequent BlastP analysis to verify their biological significance.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Uniprot_cRAP_SAV_indel_translatedbed.FASTA | data_input |  |
| 1 | MGF Collection | data_collection_input |  |
| 2 | Reference Protein Accessions | data_input |  |


Ensure your protein database is in FASTA format and your mass spectrometry data is organized as an MGF collection to enable efficient batch processing through SearchGUI and PeptideShaker. The reference protein accessions should be provided as a tabular or text file to facilitate the filtering of known sequences in later steps. Using a dataset collection for the MGF files is essential for maintaining the relationship between spectra and search results across the workflow. Consult the README.md for comprehensive details on database construction and specific parameter configurations. You can automate the setup of these inputs using `planemo workflow_job_init` to generate a job.yml file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Identification Parameters | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/ident_params/4.0.41+galaxy1 |  |
| 4 | Search GUI | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/search_gui/4.0.41+galaxy1 |  |
| 5 | Peptide Shaker | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/peptide_shaker/2.0.33+galaxy1 |  |
| 6 | mz to sqlite | toolshed.g2.bx.psu.edu/repos/galaxyp/mz_to_sqlite/mz_to_sqlite/2.1.1+galaxy0 |  |
| 7 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |
| 8 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |
| 9 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Search GUI on input dataset(s) | searchgui_results |
| 5 | output_certificate | output_certificate |
| 5 | mzidentML | mzidentML |
| 5 | output_psm | output_psm |
| 6 | Mz to sqlite | sqlite_db |
| 7 | Removing reference proteins | output |
| 8 | Selecting sequence with length >6 and <30 | output |
| 9 | Peptides_for_BlastP_analysis | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-mouse-rnaseq-dbsearch.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-mouse-rnaseq-dbsearch.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-mouse-rnaseq-dbsearch.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-mouse-rnaseq-dbsearch.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-mouse-rnaseq-dbsearch.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-mouse-rnaseq-dbsearch.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
