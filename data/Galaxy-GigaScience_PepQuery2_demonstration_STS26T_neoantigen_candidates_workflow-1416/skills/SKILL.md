---
name: gigascience_pepquery2_demonstration_sts26t_neoantigen_candid
description: "This proteomics workflow validates candidate neoantigens from FragPipe discovery by processing raw mass spectrometry data through PepQuery2 and NCBI BLAST+ against reference proteomes. Use this skill when you need to confirm the presence of predicted neoantigen candidates in mass spectrometry datasets and verify their novelty against known protein databases."
homepage: https://workflowhub.eu/workflows/1416
---

# GigaScience_PepQuery2_demonstration_STS26T_neoantigen_candidates_workflow

## Overview

This Galaxy workflow is designed to validate neoantigen candidates originally identified through FragPipe discovery. By utilizing [PepQuery2](https://toolshed.g2.bx.psu.edu/repos/galaxyp/pepquery2/pepquery2/2.0.2+galaxy2), the pipeline performs a targeted "novel search" to verify peptide-spectrum matches against raw mass spectrometry data, ensuring that candidate sequences are supported by experimental evidence.

The process begins by converting raw data using [msconvert](https://toolshed.g2.bx.psu.edu/repos/galaxyp/msconvert/msconvert/3.0.20287.2) and processing the sequences alongside a reference proteome (UniProt and cRAP). Following the initial PepQuery validation, the workflow employs [Query Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2) to filter results and [NCBI BLAST+ blastp](https://toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/2.14.1+galaxy2) to assess the novelty of the peptides against known protein databases.

The final outputs include a ranked list of validated PSMs and a refined collection of novel peptides. This workflow is licensed under GPL-3.0-or-later and serves as a demonstration for neoantigen research within the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Candidate_Neoantigens | data_input | Candidate Neoantigens from Fragpipe Workflow |
| 1 | HUMAN_Uniprot_and_CRAP.fasta | data_input | Known human and contaminant protein fasta database |
| 2 | Input Raw-files | data_input | RAW File |
| 3 | Human-TAX-ID | data_input | this is for blastP taxid restrictions- homo sapiens-9606 |


Ensure your input raw mass spectrometry files are provided as a dataset collection to facilitate batch processing through msconvert, while the candidate neoantigens must be in a tabular format. The reference proteome should be a FASTA file containing both UniProt sequences and common contaminants to ensure accurate peptide validation. Provide the specific NCBI Taxonomy ID as a text input to correctly configure the PepQuery2 search parameters for the target organism. Consult the included README.md for comprehensive instructions on formatting the candidate peptide list and managing large-scale raw data uploads. You can automate the configuration of these inputs by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | msconvert | toolshed.g2.bx.psu.edu/repos/galaxyp/msconvert/msconvert/3.0.20287.2 | Converting Raw to MGF |
| 5 | PepQuery2 | toolshed.g2.bx.psu.edu/repos/galaxyp/pepquery2/pepquery2/2.0.2+galaxy2 | PepQuery against HUMAN and contaminants to know filter peptides that doesn't match to anything in the known Uniprot database |
| 6 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 | Extract Peptides with the confident column as "Yes" |
| 7 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |
| 8 | NCBI BLAST+ blastp | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/2.14.1+galaxy2 | BLAST-Protein against swissprot, ref seq and NCBI NR and filtering for HUMAN only results |
| 9 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 | Extracting Novel peptides after BlastP |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | PepQuery_psm_rank_txt | psm_rank_txt |
| 6 | PepQuery_Validated_Peptides | output |
| 7 | BLAST-P-READY-Peptides | output |
| 8 | BlastP-output | output1 |
| 9 | Novel_Peptides_from_PepQuery | output |


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
