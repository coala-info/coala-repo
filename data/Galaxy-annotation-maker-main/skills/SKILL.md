---
name: genome-annotation-with-maker
description: This workflow performs comprehensive genome annotation by integrating genome sequences, protein evidence, and ab-initio training data using Maker, BUSCO, and JBrowse. Use this skill when you need to generate high-quality gene models for a newly assembled genome, evaluate the completeness of predicted gene sets, and visualize the resulting annotations in an interactive browser.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# genome-annotation-with-maker

## Overview

This workflow provides a comprehensive pipeline for eukaryotic or prokaryotic genome annotation using the [Maker](https://toolshed.g2.bx.psu.edu/repos/iuc/maker/maker/2.31.11+galaxy2) pipeline. It integrates genome sequences with protein evidence and ab initio gene predictions from SNAP and Augustus to generate high-quality consensus gene models. The process reconciles various evidence signals to determine precise genetic structures across the assembly.

Quality control and evaluation are integrated at multiple stages. The workflow utilizes [Fasta Statistics](https://toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0) to assess the initial assembly and [BUSCO](https://toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.7.1+galaxy0) to evaluate the completeness of both the genome and the resulting protein predictions. Detailed annotation metrics are generated via [Genome annotation statistics](https://toolshed.g2.bx.psu.edu/repos/iuc/jcvi_gff_stats/jcvi_gff_stats/0.8.4) to provide graphical and textual summaries of the gene models.

Post-processing steps refine the raw output for downstream use and interpretation. The workflow uses [gffread](https://toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0) to extract protein sequences and [Map annotation ids](https://toolshed.g2.bx.psu.edu/repos/iuc/maker_map_ids/maker_map_ids/2.31.11) to standardize gene naming conventions. Finally, all results are compiled into a [JBrowse](https://toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1) instance, allowing for interactive visualization of the annotated genome and its supporting evidence.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | BUSCO lineage | parameter_input | BUSCO lineage |
| 1 | Genome sequence | data_input | Genome sequence |
| 2 | Genome assembly | data_input | Genome assembly |
| 3 | Protein sequences | data_input | Protein sequences |
| 4 | Augustus training | data_input | Augustus training |
| 5 | SNAP training | data_input | SNAP training |


Ensure your genome and protein sequences are in FASTA format, while training files for SNAP and Augustus should be provided as specific model files or datasets as required by the tool parameters. If you are processing multiple assemblies, consider using dataset collections to streamline the Maker execution. For comprehensive guidance on formatting evidence files and configuring ab-initio predictors, refer to the README.md. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and reproducible execution. One paragraph only.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0 | Fasta Statistics on the genome |
| 7 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.7.1+galaxy0 | Completeness assessment of the genome using the Busco tool |
| 8 | Maker | toolshed.g2.bx.psu.edu/repos/iuc/maker/maker/2.31.11+galaxy2 | Annotation with Maker |
| 9 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0 |  |
| 10 | Genome annotation statistics | toolshed.g2.bx.psu.edu/repos/iuc/jcvi_gff_stats/jcvi_gff_stats/0.8.4 | Genome annotation statistics on the maker's annotation |
| 11 | Map annotation ids | toolshed.g2.bx.psu.edu/repos/iuc/maker_map_ids/maker_map_ids/2.31.11 |  |
| 12 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.7.1+galaxy0 | Completeness assessment of the genome using the Busco tool |
| 13 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | fasta stats genome | stats_output |
| 7 | busco image genome | summary_image |
| 7 | busco sum genome | busco_sum |
| 7 | busco table genome | busco_table |
| 7 | busco gff genome | busco_gff |
| 7 | busco missing genome | busco_missing |
| 8 | maker full | output_full |
| 8 | maker gff | output_gff |
| 8 | maker evidences | output_evidences |
| 9 | gffread exons | output_exons |
| 10 | graphs genome | graphs |
| 10 | summary genome | summary |
| 11 | renamed gff3 | renamed |
| 11 | id map | id_map |
| 12 | busco missing predicted proteins | busco_missing |
| 12 | busco table predicted proteins | busco_table |
| 12 | busco gff predicted proteins | busco_gff |
| 12 | busco sum predicted proteins | busco_sum |
| 12 | busco image predicted proteins | summary_image |
| 13 | jbrowse | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Genome_annotation_with_maker_short.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Genome_annotation_with_maker_short.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Genome_annotation_with_maker_short.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Genome_annotation_with_maker_short.ga -o job.yml`
- Lint: `planemo workflow_lint Genome_annotation_with_maker_short.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Genome_annotation_with_maker_short.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)