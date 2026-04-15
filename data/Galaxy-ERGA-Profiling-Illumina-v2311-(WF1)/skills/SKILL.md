---
name: erga-profiling-illumina-v2311-wf1
description: This workflow processes trimmed Illumina sequencing collections using Meryl, Smudgeplot, and GenomeScope to perform k-mer based genomic profiling. Use this skill when you need to estimate genome size, heterozygosity, and ploidy levels to assess sample complexity before proceeding with de novo genome assembly.
homepage: https://www.erga-biodiversity.eu/
metadata:
  docker_image: "N/A"
---

# erga-profiling-illumina-v2311-wf1

## Overview

The **ERGA Profiling Illumina v2311 (WF1)** workflow is designed for the initial genomic profiling of species using Illumina sequencing data. It focuses on estimating key genomic characteristics such as genome size, heterozygosity, and ploidy levels, which are essential for informing downstream assembly strategies. This workflow is a core component of the [ERGA](https://www.erga-biodiversity.eu/) (European Reference Genome Atlas) sequencing pipelines.

The process begins by utilizing [Meryl](https://github.com/marbl/meryl) to generate and merge k-mer databases from trimmed Illumina collections. These databases serve as the foundation for k-mer frequency analysis. The workflow then employs [GenomeScope](https://github.com/schatzlab/genomescope) to model the k-mer distribution, providing statistical estimates of genome size and repeat content. Simultaneously, [Smudgeplot](https://github.com/KamilSJaron/smudgeplot) is used to visualize and infer the ploidy level of the organism based on k-mer pairs.

In the final stages, the workflow performs automated text processing and parameter parsing to extract critical metrics. Key outputs include the merged Meryl database, calculated genome size, and specific depth parameters (transition and max depth). These results provide a comprehensive profile of the sample's genomic architecture, ensuring data quality and guiding subsequent assembly steps.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Trimmed Illumina collection | data_collection_input |  |
| 1 | kmer length | parameter_input | Kmer length for calculating kmer spectra |
| 2 | Ploidy | parameter_input | Default ploidy: 2 |


Ensure your input is a paired-end list collection of trimmed Illumina reads in fastq.gz format to maintain sample associations throughout the Meryl and GenomeScope steps. Verify that the k-mer length and ploidy parameters match your specific organism's profile for accurate smudgeplot generation. For automated execution, you can initialize your environment using `planemo workflow_job_init` to generate a template `job.yml` file. Refer to the included README.md for comprehensive details on parameter tuning and data preparation requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 4 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 5 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 6 | Smudgeplot | toolshed.g2.bx.psu.edu/repos/galaxy-australia/smudgeplot/smudgeplot/0.2.5+galaxy3 |  |
| 7 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0+galaxy2 |  |
| 8 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.4 |  |
| 9 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0 |  |
| 10 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.4 |  |
| 11 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0 |  |
| 12 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 13 | Cut | Cut1 |  |
| 14 | Cut | Cut1 |  |
| 15 | Convert | Convert characters1 |  |
| 16 | Parse parameter value | param_value_from_file |  |
| 17 | Parse parameter value | param_value_from_file |  |
| 18 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.1.0 |  |
| 19 | Parse parameter value | param_value_from_file |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Merged Meryl DB | read_db |
| 16 | transition_parameter | integer_param |
| 17 | max_depth | integer_param |
| 19 | genome_size | integer_param |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ERGA_Profiling_Illumina_v2311_(WF1).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ERGA_Profiling_Illumina_v2311_(WF1).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ERGA_Profiling_Illumina_v2311_(WF1).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ERGA_Profiling_Illumina_v2311_(WF1).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ERGA_Profiling_Illumina_v2311_(WF1).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ERGA_Profiling_Illumina_v2311_(WF1).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)