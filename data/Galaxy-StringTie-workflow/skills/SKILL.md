---
name: copy-of-genome-wide-alternative-splicing-analysis
description: "This transcriptomics workflow performs genome-wide alternative splicing analysis by processing a reference genome and annotation through RNA STAR for alignment, StringTie for assembly, and IsoformSwitchAnalyzeR for statistical evaluation. Use this skill when you need to identify functional isoform switches and characterize alternative splicing events to understand their biological impact on gene expression and protein diversity."
homepage: https://workflowhub.eu/workflows/483
---

# Copy of Genome-wide alternative splicing analysis

## Overview

This workflow provides a comprehensive pipeline for genome-wide alternative splicing analysis, specifically designed as a training resource for the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/). It begins by aligning raw transcriptomics data to a reference genome using [RNA STAR](https://github.com/alexdobin/STAR), followed by initial transcript assembly and quantification with [StringTie](https://ccb.jhu.edu/software/stringtie/).

To create a consistent set of transcripts across all samples, the workflow utilizes [StringTie merge](https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual#merge) to combine individual assemblies into a unified transcriptome. It then employs [gffread](http://ccb.jhu.edu/software/stringtie/gff.shtml) for annotation processing and performs a second pass of StringTie to refine quantification against the newly merged reference.

The final stages involve data filtering and identifier extraction to prepare the results for [IsoformSwitchAnalyzeR](https://bioconductor.org/packages/release/bioc/html/IsoformSwitchAnalyzeR.html). This tool identifies and visualizes isoform switches with predicted functional consequences, offering deep insights into alternative splicing events. This workflow is shared under a [CC-BY-SA-4.0](https://creativecommons.org/licenses/by-sa/4.0/) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Genome annotation | data_input |  |
| 2 | Reference genome | data_input |  |


Ensure your reference genome is in FASTA format and the genome annotation is a GTF or GFF3 file matching the specific assembly version. For efficient processing, organize your raw RNA-seq reads into a paired-end dataset collection to streamline the transition from STAR alignment to StringTie assembly. Consult the `README.md` for comprehensive details on parameter settings and specific library preparation requirements. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | RNA STAR | toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.10b+galaxy3 |  |
| 3 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.1+galaxy1 |  |
| 4 | StringTie merge | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie_merge/2.2.1+galaxy1 |  |
| 5 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.3+galaxy0 |  |
| 6 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.1+galaxy1 |  |
| 7 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 8 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 9 | Filter collection | __FILTER_FROM_FILE__ |  |
| 10 | IsoformSwitchAnalyzeR | toolshed.g2.bx.psu.edu/repos/iuc/isoformswitchanalyzer/isoformswitchanalyzer/1.20.0+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run stringtie.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run stringtie.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run stringtie.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init stringtie.ga -o job.yml`
- Lint: `planemo workflow_lint stringtie.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `stringtie.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
