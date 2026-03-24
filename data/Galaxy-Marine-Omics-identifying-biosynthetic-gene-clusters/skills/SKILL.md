---
name: marine-omics-identifying-biosynthetic-gene-clusters
description: "This marine omics workflow processes nucleotide FASTA files to identify and annotate secondary metabolite biosynthetic gene clusters using Prodigal, InterProScan, and Sanntis neural networks. Use this skill when you need to discover novel bioactive compounds or characterize the secondary metabolic potential of marine microorganisms from genomic sequences."
homepage: https://workflowhub.eu/workflows/1663
---

# Marine Omics identifying biosynthetic gene clusters

## Overview

This workflow is designed for the identification and annotation of Secondary Metabolite Biosynthetic Gene Clusters (SMBGCs) within marine genomic data. Starting from a FASTA nucleotide file, the pipeline utilizes [Prodigal](https://toolshed.g2.bx.psu.edu/repos/iuc/prodigal/prodigal/2.6.3+galaxy0) to predict protein-coding genes, which serve as the foundation for downstream functional analysis.

The core of the process involves a multi-stage annotation approach. It integrates [InterProScan](https://toolshed.g2.bx.psu.edu/repos/bgruening/interproscan/interproscan/5.59-91.0+galaxy3) to identify protein domains and signatures, alongside [Sanntis](https://toolshed.g2.bx.psu.edu/repos/ecology/sanntis_marine/sanntis_marine/0.9.3.5+galaxy1), which employs neural networks trained on Interpro signatures to accurately detect biosynthetic clusters. A regex-based cleaning step is included to ensure protein headers remain compatible across different tools.

The final outputs provide a comprehensive view of the genomic potential for secondary metabolism, including protein sequences, Genbank files, and detailed SMBGC annotations. This workflow is a valuable resource for marine omics research and is maintained as part of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) under a CC-BY-4.0 license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Fasta nucelotide file | data_input | BGC0001472.fna |


Ensure the input FASTA nucleotide file contains high-quality genomic or metagenomic sequences, as this serves as the foundation for gene prediction and cluster identification. For large-scale marine omics studies involving multiple samples, organizing your data into dataset collections is highly recommended to streamline the execution of the Prodigal and Sanntis tools. Detailed instructions on parameter settings and tool dependencies are provided in the accompanying README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` file for efficient workflow configuration and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Prodigal Gene Predictor | toolshed.g2.bx.psu.edu/repos/iuc/prodigal/prodigal/2.6.3+galaxy0 | Create the protein fasta file |
| 2 | Sanntis biosynthetic gene clusters | toolshed.g2.bx.psu.edu/repos/ecology/sanntis_marine/sanntis_marine/0.9.3.5+galaxy1 | Use of Sanntis |
| 3 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 | Remove useless * in the protein fasta file |
| 4 | InterProScan | toolshed.g2.bx.psu.edu/repos/bgruening/interproscan/interproscan/5.59-91.0+galaxy3 | Create TSV file for Sanntis |
| 5 | Sanntis biosynthetic gene clusters | toolshed.g2.bx.psu.edu/repos/ecology/sanntis_marine/sanntis_marine/0.9.3.5+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | Protein fasta file | output_faa |
| 2 | Genbank file | output_sanntis_gb |
| 3 | Clean protein fasta file | out_file1 |
| 4 | Tabular file (.tsv) | outfile_tsv |
| 5 |  SMBGC Annotation | output_sanntis |


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
