---
name: genome-annotation-with-braker3
description: "This Galaxy workflow performs automated genome annotation by integrating a masked genome sequence, RNA-seq alignments, and protein evidence using Braker3, BUSCO, and JBrowse. Use this skill when you need to generate high-quality structural gene predictions for a newly sequenced eukaryotic genome and visualize the results alongside comprehensive quality assessment metrics."
homepage: https://workflowhub.eu/workflows/1509
---

# Genome annotation with Braker3

## Overview

This workflow performs automated genome annotation using [BRAKER3](https://toolshed.g2.bx.psu.edu/repos/genouest/braker3/braker3/3.0.8+galaxy0), a pipeline that integrates RNA-seq alignments and protein sequence data to predict gene structures. It requires a masked genome sequence, RNA-seq evidence, and a set of reference protein sequences as primary inputs to generate high-quality gene models.

The pipeline begins by generating [Fasta Statistics](https://toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0) and performing an initial [BUSCO](https://toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.7.1+galaxy0) analysis to assess the quality and completeness of the input genome. Following the core annotation by BRAKER3, the workflow utilizes [gffread](https://toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0) to extract predicted protein sequences from the resulting GFF file.

Final outputs include the annotated gene models, predicted protein sequences, and a second BUSCO assessment to evaluate the completeness of the predicted proteome. For interactive exploration, the workflow generates a [JBrowse](https://toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1) instance to visualize the gene models alongside the genomic data. This workflow is licensed under MIT and follows [GTN](https://training.galaxyproject.org/) standards for genome annotation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | BUSCO lineage | parameter_input | BUSCO lineage |
| 1 | Genome sequence masked | data_input | Genome sequence |
| 2 | Alignments from RNA-seq | data_input | Alignments from RNA-seq |
| 3 | Protein sequences | data_input | Protein sequences |


Ensure the genome sequence is provided in FASTA format and properly masked, while RNA-seq alignments should be uploaded as BAM files and protein sequences as FASTA. For large-scale projects, organizing your RNA-seq data into dataset collections can simplify the input selection process within the workflow. Consult the README.md for exhaustive documentation on specific BUSCO lineage parameters and tool configurations. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution and input management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0 | Fasta Statistics on the genome |
| 5 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.7.1+galaxy0 | Completeness assessment of the genome using the Busco tool |
| 6 | BRAKER3 | toolshed.g2.bx.psu.edu/repos/genouest/braker3/braker3/3.0.8+galaxy0 | Genome annotation with Braker3 |
| 7 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0 | Converts GFF files to other formats, such as FASTA |
| 8 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 |  |
| 9 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.7.1+galaxy0 | Completeness assessment of the genome using the Busco tool |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | fasta stats genome | stats_output |
| 5 | busco table genome | busco_table |
| 5 | busco sum genome | busco_sum |
| 5 | busco image genome | summary_image |
| 5 | busco missing genome | busco_missing |
| 5 | busco gff genome | busco_gff |
| 6 | braker gff | output_gff |
| 7 | predicted proteins | output_pep |
| 8 | jbrowse | output |
| 9 | busco image predicted proteins | summary_image |
| 9 | busco gff predicted proteins | busco_gff |
| 9 | busco sum predicted proteins | busco_sum |
| 9 | busco missing predicted proteins | busco_missing |
| 9 | busco table predicted proteins | busco_table |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run braker.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run braker.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run braker.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init braker.ga -o job.yml`
- Lint: `planemo workflow_lint braker.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `braker.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
