---
name: pox-virus-tiled-amplicon-ref-masking
description: This workflow utilizes a reference FASTA and a primer scheme with Datamash and EMBOSS maskseq to generate two masked half-genome references for pox virus sequencing analysis. Use this skill when analyzing tiled amplicon data from pox viruses to account for inverted terminal repeats that can interfere with accurate read mapping and variant detection.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# pox-virus-tiled-amplicon-ref-masking

## Overview

This workflow is designed for pox virus sequencing data analysis, specifically addressing the challenges posed by Inverted Terminal Repeats (ITRs) when using tiled amplicon schemes. By taking a reference FASTA and a primer scheme as primary inputs, the pipeline automates the preparation of specialized reference files required for accurate downstream variant calling.

The process involves calculating sequence lengths and parsing primer coordinates using tools such as `Datamash` and `Grep`. These coordinates are used to drive the `maskseq` tool from the [EMBOSS](https://galaxyproject.org/toolshed/) suite, which generates two distinct masked half-genome references. This masking strategy is essential for ITR-aware analysis, ensuring that reads from different amplicon pools are correctly attributed to their respective genomic regions.

The resulting outputs, `masked_ref_pool1` and `masked_ref_pool2`, facilitate more reliable mapping in highly repetitive terminal regions. This workflow is particularly useful for researchers following [GTN](https://training.galaxyproject.org/) protocols for viral surveillance and variant analysis. The project is released under an MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Primer Scheme | data_input | The workflow expects a primer scheme split into two separate sequencing pools. These pools must be denoted as pool1/pool2 in the BED score column. The pool ids may, optionally, be followed by indicators of the subpool for tiled PCR amplification (e.g., pool1a/pool1b/pool2a/pool2b) |
| 1 | Reference FASTA | data_input | The viral reference sequence to map sequenced reads against |


Ensure your Reference FASTA is properly formatted and the Primer Scheme is provided as a tab-separated BED file containing the coordinates for the tiled amplicon set. Since this workflow processes individual reference files to generate masked versions, you should upload these as single datasets rather than collections. Consult the included README.md for specific details on primer scheme formatting and how the masking logic handles inverted terminal repeats. You can automate the execution of this workflow by defining your input paths in a job.yml file and using planemo workflow_job_init.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Select | Grep1 |  |
| 3 | Select | Grep1 |  |
| 4 | Compute sequence length | toolshed.g2.bx.psu.edu/repos/devteam/fasta_compute_length/fasta_compute_length/1.0.3 |  |
| 5 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0+galaxy2 |  |
| 6 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0+galaxy2 |  |
| 7 | Cut | Cut1 |  |
| 8 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.0 |  |
| 9 | Parse parameter value | param_value_from_file |  |
| 10 | Parse parameter value | param_value_from_file |  |
| 11 | Parse parameter value | param_value_from_file |  |
| 12 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 13 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 14 | maskseq | toolshed.g2.bx.psu.edu/repos/devteam/emboss_5/EMBOSS: maskseq51/5.0.0 |  |
| 15 | maskseq | toolshed.g2.bx.psu.edu/repos/devteam/emboss_5/EMBOSS: maskseq51/5.0.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 14 | masked_ref_pool2 | out_file1 |
| 15 | masked_ref_pool1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run pox-virus-tiled-amplicon-ref-masking.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run pox-virus-tiled-amplicon-ref-masking.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run pox-virus-tiled-amplicon-ref-masking.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init pox-virus-tiled-amplicon-ref-masking.ga -o job.yml`
- Lint: `planemo workflow_lint pox-virus-tiled-amplicon-ref-masking.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `pox-virus-tiled-amplicon-ref-masking.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)