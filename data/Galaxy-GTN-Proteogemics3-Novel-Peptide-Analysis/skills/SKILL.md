---
name: gtn-proteogemics3-novel-peptide-analysis
description: This proteogenomics workflow identifies and characterizes novel peptides by processing PSM reports and peptide sequences using NCBI BLAST+, Query Tabular, and PepPointer against genomic and proteomic reference data. Use this skill when you need to validate potential novel peptide sequences, map them to their genomic locations, and distinguish between known proteins and unannotated genomic regions in mouse proteogenomic studies.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# gtn-proteogemics3-novel-peptide-analysis

## Overview

This Galaxy workflow is designed for the third stage of a proteogenomics pipeline, specifically focusing on the identification and characterization of novel peptides in *Mus musculus*. It integrates mass spectrometry data with genomic information to validate peptide sequences that do not match standard protein databases, helping researchers discover previously unannotated protein-coding regions.

The analysis begins by performing an [NCBI BLAST+ blastp](https://toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/2.16.0+galaxy0) search to filter out known sequences. Using multiple [Query Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2) steps, the workflow processes PSM reports and SQLite databases to isolate high-confidence novel peptide candidates from the experimental data.

Once identified, these candidates are mapped back to the genome using [Peptide Genomic Coordinate](https://toolshed.g2.bx.psu.edu/repos/galaxyp/peptide_genomic_coordinate/peptide_genomic_coordinate/1.0.0). The [PepPointer](https://toolshed.g2.bx.psu.edu/repos/galaxyp/pep_pointer/pep_pointer/0.1.3+galaxy1) tool then provides functional annotation by determining the genomic location of each peptide. The final output is a comprehensive summary that links novel peptides to their specific genomic coordinates, facilitating further biological interpretation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Edited_Mus_Musculus.GRCm38.86 | data_input |  |
| 1 | peptides for blast | data_input |  |
| 2 | PSM Report | data_input |  |
| 3 | mz_sqlite | data_input |  |
| 4 | genomic mapping sqlite db | data_input |  |


Ensure your input files are correctly formatted, specifically using FASTA for the reference proteome and tabular formats for the PSM reports and peptide lists. The workflow requires specific SQLite databases for genomic mapping and mass spectrometry data, so verify these are properly indexed and compatible with the Query Tabular tools before execution. While individual datasets are standard for this analysis, using collections can streamline the processing if you are handling multiple PSM reports simultaneously. Refer to the `README.md` for comprehensive details on database schema requirements and specific tool parameters. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | NCBI BLAST+ blastp | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/2.16.0+galaxy0 |  |
| 6 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |
| 7 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |
| 8 | Peptide Genomic Coordinate | toolshed.g2.bx.psu.edu/repos/galaxyp/peptide_genomic_coordinate/peptide_genomic_coordinate/1.0.0 |  |
| 9 | PepPointer | toolshed.g2.bx.psu.edu/repos/galaxyp/pep_pointer/pep_pointer/0.1.3+galaxy1 |  |
| 10 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | BLASTP_results | output1 |
| 6 | PSM_Novel_Peptides | output |
| 7 | Novel_Peptides | output |
| 8 | Peptide Genomic Coodinate on input dataset(s) | peptide_bed |
| 9 | PepPointer on input dataset(s) | classified |
| 10 | Final_Summary_Novel_Peptides | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-mouse-novel-peptide-analysis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-mouse-novel-peptide-analysis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-mouse-novel-peptide-analysis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-mouse-novel-peptide-analysis.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-mouse-novel-peptide-analysis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-mouse-novel-peptide-analysis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)