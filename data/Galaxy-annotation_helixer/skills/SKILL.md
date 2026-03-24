---
name: annotation_helixer
description: "This genome annotation workflow takes a genomic sequence to predict gene models using Helixer and evaluates the results using BUSCO, OMArk, and GFFRead. Use this skill when you need to generate high-quality gene predictions for a newly assembled genome and validate the structural and functional completeness of the resulting annotation."
homepage: https://workflowhub.eu/workflows/1500
---

# annotation_helixer

## Overview

The **annotation_helixer** workflow provides an automated pipeline for genome annotation and comprehensive quality assessment. It begins by using [Helixer](https://toolshed.g2.bx.psu.edu/repos/genouest/helixer/helixer/0.3.3+galaxy1) to generate de novo gene predictions from an input genome sequence. The resulting structural annotations are then processed through [Genome annotation statistics](https://toolshed.g2.bx.psu.edu/repos/iuc/jcvi_gff_stats/jcvi_gff_stats/0.8.4) to generate summary metrics and visual graphs of the gene models.

To evaluate the reliability of the annotation, the workflow performs quality control at both the genomic and proteomic levels. [BUSCO](https://toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.7.1+galaxy0) is utilized twice: first to assess the completeness of the genome annotation and later to evaluate the protein sequences predicted by [gffread](https://toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0). Additionally, [OMArk](https://toolshed.g2.bx.psu.edu/repos/iuc/omark/omark/0.3.0+galaxy2) provides a detailed proteome consistency check against orthologous groups.

The workflow concludes by integrating the results into a [JBrowse](https://toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1) instance, allowing for interactive visualization of the gene models alongside the genomic data. This pipeline is particularly useful for researchers following [GTN](https://training.galaxyproject.org/) standards for genome annotation and is released under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input | data_input | Input dataset containing genomic sequences in FASTA format |


Ensure your primary input is a high-quality genome assembly in FASTA format, as Helixer relies on accurate sequence data for gene prediction. If you are processing multiple assemblies, consider using a dataset collection to streamline the parallel execution of the BUSCO and OMArk evaluation steps. For automated testing or command-line execution, you can initialize a job template using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on parameter tuning and lineage selection for the quality assessment tools.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Helixer | toolshed.g2.bx.psu.edu/repos/genouest/helixer/helixer/0.3.3+galaxy1 | Helixer tool for genomic annotation |
| 2 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.7.1+galaxy0 | Completeness assessment of the genome using the Busco tool |
| 3 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0 | Converts GFF files to other formats, such as FASTA |
| 4 | Genome annotation statistics | toolshed.g2.bx.psu.edu/repos/iuc/jcvi_gff_stats/jcvi_gff_stats/0.8.4 | Generates statistics and graphs for genome annotation |
| 5 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 | JBrowse |
| 6 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.7.1+galaxy0 | Completeness assessment of the genome using the Busco tool |
| 7 | OMArk | toolshed.g2.bx.psu.edu/repos/iuc/omark/omark/0.3.0+galaxy2 | OMArk |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | helixer_output | output |
| 2 | busco_missing_geno | busco_missing |
| 2 | busco_gff_geno | busco_gff |
| 2 | busco_sum_geno | busco_sum |
| 2 | summary_image_geno | summary_image |
| 2 | busco_table_geno | busco_table |
| 3 | gffread_pep | output_pep |
| 4 | summary | summary |
| 4 | graphs | graphs |
| 5 | output | output |
| 6 | busco_gff_pep | busco_gff |
| 6 | summary_image_pep | summary_image |
| 6 | busco_sum_pep | busco_sum |
| 6 | busco_table_pep | busco_table |
| 6 | busco_missing_pep | busco_missing |
| 7 | omark_detail_sum | omark_detail_sum |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run helixer.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run helixer.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run helixer.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init helixer.ga -o job.yml`
- Lint: `planemo workflow_lint helixer.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `helixer.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
