---
name: exome-seq-training-pre-mapped-w-cached-ref
description: This workflow processes pre-mapped exome sequencing data from a family trio using Samtools, FreeBayes, SnpEff, and GEMINI to identify and annotate genetic variants. Use this skill when you need to identify candidate pathogenic mutations in a proband by analyzing inheritance patterns across a family trio to diagnose potential genetic disorders.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# exome-seq-training-pre-mapped-w-cached-ref

## Overview

This Galaxy workflow provides a streamlined approach for exome sequencing data analysis, specifically designed for diagnosing genetic diseases using a trio-based approach (Father, Mother, and Proband). As a shortened version of the standard [GTN](https://training.galaxyproject.org/) exome sequencing tutorial, it begins with pre-mapped reads to accelerate the variant discovery process.

The pipeline processes input BAM files through `Samtools` and `RmDup` to filter and remove PCR duplicates. Variants are then called using `FreeBayes` and processed via `bcftools norm` for normalization. Functional annotation is performed by `SnpEff`, which provides detailed variant statistics and annotated VCF files.

In the final stages, the workflow utilizes the `GEMINI` framework to integrate the variant calls with pedigree (PED) data. By loading the data into a GEMINI database, it automates the identification of candidate mutations based on specific inheritance patterns. The primary outputs include annotated variant files and a filtered list of candidate mutations relevant to the clinical diagnosis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Father data | data_input | Pre-mapped reads of the father sample |
| 1 | Mother data | data_input | Pre-mapped reads of the mother sample |
| 2 | Proband data | data_input | Pre-mapped reads of the child/proband sample |
| 3 | PEDigree data | data_input | Family tree with sex and phenotype information in PED format |


Ensure your input sequencing data for the father, mother, and proband are in BAM format, while the pedigree information must be provided as a PED file. Since this workflow processes individual samples, you can upload them as separate datasets or organize them into a collection for easier management during the initial Samtools steps. Refer to the `README.md` for specific details on the expected metadata and reference genome versions required for successful variant calling. You can use `planemo workflow_job_init` to generate a `job.yml` template for automating these inputs. For a comprehensive guide on the biological context and parameter settings, consult the full documentation.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.15.1+galaxy0 |  |
| 5 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.15.1+galaxy0 |  |
| 6 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.15.1+galaxy0 |  |
| 7 | RmDup | toolshed.g2.bx.psu.edu/repos/devteam/samtools_rmdup/samtools_rmdup/2.0.1 |  |
| 8 | RmDup | toolshed.g2.bx.psu.edu/repos/devteam/samtools_rmdup/samtools_rmdup/2.0.1 |  |
| 9 | RmDup | toolshed.g2.bx.psu.edu/repos/devteam/samtools_rmdup/samtools_rmdup/2.0.1 |  |
| 10 | FreeBayes | toolshed.g2.bx.psu.edu/repos/devteam/freebayes/freebayes/1.3.6+galaxy0 |  |
| 11 | bcftools norm | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_norm/bcftools_norm/1.15.1+galaxy3 |  |
| 12 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy2 |  |
| 13 | GEMINI load | toolshed.g2.bx.psu.edu/repos/iuc/gemini_load/gemini_load/0.20.1+galaxy2 |  |
| 14 | GEMINI inheritance pattern | toolshed.g2.bx.psu.edu/repos/iuc/gemini_inheritance/gemini_inheritance/0.20.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 12 | snpeff_variant_stats | statsFile |
| 12 | normalized_snpeff_annotated_variants | snpeff_output |
| 14 | candidate_mutations | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow-exome-seq-from-premapped.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow-exome-seq-from-premapped.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow-exome-seq-from-premapped.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow-exome-seq-from-premapped.ga -o job.yml`
- Lint: `planemo workflow_lint workflow-exome-seq-from-premapped.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow-exome-seq-from-premapped.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)