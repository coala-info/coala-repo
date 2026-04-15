---
name: gigascience_peptide_annotation_demonstration_sts26t_neoantig
description: This workflow processes novel peptides and Fragpipe reports against genomic GTF and BED files using Query Tabular and PepPointer to perform comprehensive proteogenomic annotation. Use this skill when you need to identify and characterize neoantigen candidates by mapping mass spectrometry-derived novel peptides back to their genomic locations and reference protein sequences.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# gigascience_peptide_annotation_demonstration_sts26t_neoantig

## Overview

This Galaxy workflow is designed for the comprehensive annotation of novel peptides, specifically focusing on identifying neoantigen candidates from STS26T datasets. It integrates proteomic results with genomic reference data to characterize peptide sequences and determine their genomic origins. The workflow is licensed under [GPL-3.0-or-later](https://spdx.org/licenses/GPL-3.0-or-later.html) and is tagged for use in neoantigen research and [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorials.

The process begins by ingesting novel peptide lists, Fragpipe reports, and genomic annotation files (GTF and BED). It utilizes a series of [Query Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2) and regex manipulation steps to filter and format data, converting tabular peptide information into FASTA format for downstream compatibility. These steps facilitate the mapping of peptides to specific protein annotations and genomic coordinates.

A critical component of the workflow is the use of [PepPointer](https://toolshed.g2.bx.psu.edu/repos/galaxyp/pep_pointer/pep_pointer/0.1.3+galaxy1), which automates the localization of peptides within the genome. By cross-referencing the input sequences against the provided human reference genome (GRCh38), the workflow generates detailed BED files and a final neoantigen summary. This output provides researchers with a clear overview of peptide locations and their potential relevance as immunotherapeutic targets.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Novel_Peptides | data_input | Candidate Neoantigens from Fragpipe Workflow |
| 1 | Fragpipe-Peptide-Report | data_input | Peptide report from Fragpipe workflow |
| 2 | Annotated-GffCompared-GTFtoBED | data_input | Annotated GffCompared GTF to BED |
| 3 | Homo_sapiens.GRCh38_canon.106.gtf | data_input | Homo_sapiens.GRCh38_canon.106.gtf |


Ensure all input files are correctly formatted, specifically using tabular formats for peptide reports and GTF/BED files for genomic annotations to maintain compatibility with Query Tabular and PepPointer steps. Verify that the GTF file matches the reference genome version used in your upstream analysis to ensure accurate peptide mapping. While this workflow primarily handles individual datasets, ensure that column headers in your tabular inputs align with the SQL queries defined in the tool parameters. For automated execution and parameter testing, you can use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on specific column requirements and data preparation.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 | Extracting the information from Fragpipe for the Novel peptides |
| 5 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 | FASTA file for IEDB |
| 6 | Convert | Convert characters1 | converting pipes to columns |
| 7 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Modifying-string-name |
| 8 | Convert | Convert characters1 | converting colons to columns |
| 9 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 | Extracting-info-from-GFFtobed |
| 10 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 | multiplying start and stop of the peptide location with 3 to calculate genomic coordinates |
| 11 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 | calculation genomic coordinates looking at peptide location |
| 12 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 | Extracting bed file for Peppointer |
| 13 | PepPointer | toolshed.g2.bx.psu.edu/repos/galaxyp/pep_pointer/pep_pointer/0.1.3+galaxy1 | PepPointer to add annotation to the peptides at Genomic level |
| 14 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 | Summary file for Neoantigen |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Peptide_to_Protein_Annotation | output |
| 5 | FASTA-IEDB | output |
| 6 | Table-processing-1 | out_file1 |
| 7 | Modified-string-name | out_file1 |
| 8 | Table-processing-2 | out_file1 |
| 9 | Extracting-info-from-GFFtobed | output |
| 10 | Table-processing-3 | output |
| 11 | Peptide-location-generation | output |
| 12 | BED-File-for-PepPointer | output |
| 13 | PepPointer-Annotated-Peptides | classified |
| 14 | Neoantigen_summary | output |


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