---
name: diploid
description: This workflow performs variant calling and annotation for diploid systems using BAM alignments and tabular metadata as inputs, utilizing FreeBayes for discovery and GEMINI for downstream analysis. Use this skill when you need to identify genomic variants from sequence alignments and perform functional annotation or complex queries to understand the genetic basis of traits in diploid populations.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# diploid

## Overview

This workflow is designed for variant analysis in diploid systems, specifically optimized for processing human genomic data such as the Genome in a Bottle (GIAB) Ashkenazim Trio. It accepts aligned sequencing reads in BAM format and associated sample metadata to identify and annotate genetic variations.

The pipeline begins with variant calling using [FreeBayes](https://toolshed.g2.bx.psu.edu/repos/devteam/freebayes/freebayes/1.3.9+galaxy0), followed by VCF normalization through [VcfAllelicPrimitives](https://toolshed.g2.bx.psu.edu/repos/devteam/vcfallelicprimitives/vcfallelicprimitives/1.0.0_rc3+galaxy0) to decompose complex variants into individual components. Functional annotation is then performed using [SnpEff](https://toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/5.2+galaxy0) to predict the biological impact of the identified variants.

For downstream exploration and data mining, the workflow integrates the GEMINI framework. It utilizes [GEMINI load](https://toolshed.g2.bx.psu.edu/repos/iuc/gemini_load/gemini_load/0.20.1+galaxy2) to create a searchable database of the annotated variants, which is then processed through multiple [GEMINI query](https://toolshed.g2.bx.psu.edu/repos/iuc/gemini_query/gemini_query/0.20.1+galaxy2) steps to extract specific biological insights and database statistics.

This workflow is categorized under Variant-analysis and follows [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) standards. It is released under the AGPL-3.0-or-later license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | GIAB-Ashkenazim-Trio-hg19.bam | data_input | Bam file |
| 1 | GIAB-Ashkenazim-Trio.tabular | data_input |  |


Ensure your input BAM files are coordinate-sorted and indexed, while sample metadata should be provided in a standard tabular format to facilitate downstream GEMINI integration. For multi-sample analysis, organizing your BAM files into a dataset collection will streamline the variant calling process through FreeBayes. Refer to the README.md for comprehensive details on genome builds and specific tool parameters required for diploid systems. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | FreeBayes | toolshed.g2.bx.psu.edu/repos/devteam/freebayes/freebayes/1.3.9+galaxy0 |  |
| 3 | VcfAllelicPrimitives: | toolshed.g2.bx.psu.edu/repos/devteam/vcfallelicprimitives/vcfallelicprimitives/1.0.0_rc3+galaxy0 |  |
| 4 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/5.2+galaxy0 |  |
| 5 | GEMINI load | toolshed.g2.bx.psu.edu/repos/iuc/gemini_load/gemini_load/0.20.1+galaxy2 |  |
| 6 | GEMINI query | toolshed.g2.bx.psu.edu/repos/iuc/gemini_query/gemini_query/0.20.1+galaxy2 |  |
| 7 | GEMINI database info | toolshed.g2.bx.psu.edu/repos/iuc/gemini_db_info/gemini_db_info/0.20.1 |  |
| 8 | GEMINI query | toolshed.g2.bx.psu.edu/repos/iuc/gemini_query/gemini_query/0.20.1+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run diploid.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run diploid.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run diploid.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init diploid.ga -o job.yml`
- Lint: `planemo workflow_lint diploid.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `diploid.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)