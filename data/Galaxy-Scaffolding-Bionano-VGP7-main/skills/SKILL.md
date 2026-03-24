---
name: scaffolding-bionano-vgp7
description: "This workflow performs genome scaffolding by integrating Bionano optical map data with phased GFA assemblies using the Bionano Hybrid Scaffold tool and gfastats for quality assessment. Use this skill when you need to improve the continuity and structural accuracy of a de novo genome assembly by resolving conflicts and bridging gaps with high-resolution physical maps."
homepage: https://workflowhub.eu/workflows/643
---

# Scaffolding-BioNano-VGP7

## Overview

This workflow performs genome scaffolding using Bionano optical map data, following the standards of the Vertebrate Genomes Project (VGP). It integrates phased assembly sequences (GFA) with Bionano maps (CMAP) to bridge gaps and orient contigs. The process utilizes the [Bionano Hybrid Scaffold](https://toolshed.g2.bx.psu.edu/repos/bgruening/bionano_scaffold/bionano_scaffold/3.7.0+galaxy3) tool to resolve conflicts and generate high-quality scaffolds.

The pipeline includes comprehensive quality control and assessment steps. It uses [gfastats](https://toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0) to calculate assembly statistics and generates visual reports, including Nx plots and size distribution plots via ggplot2. The final outputs provide the reconciled assembly in GFA, FASTA, and AGP formats, ensuring compatibility with downstream curation and analysis.

This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is part of the `VGP_curated` collection. For detailed information on input preparation and file specifications, please refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Bionano Data | data_input |  |
| 1 | Estimated genome size - Parameter File | data_input |  |
| 2 | Input GFA | data_input |  |
| 3 | Conflict resolution files | data_input |  |


Ensure your input GFA1 assembly and Bionano CMAP data are correctly formatted, as these primary files drive the hybrid scaffolding process. The estimated genome size should be provided as a simple text file to facilitate parameter parsing, while conflict resolution files can be used to refine the scaffolding logic. For large-scale runs, you can automate the setup using `planemo workflow_job_init` to generate a `job.yml` template. Refer to the README.md for comprehensive details on file specifications and data preparation requirements. All inputs should be uploaded as individual datasets rather than collections to match the workflow's expected structure.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Parse parameter value | param_value_from_file |  |
| 5 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 6 | Bionano Hybrid Scaffold | toolshed.g2.bx.psu.edu/repos/bgruening/bionano_scaffold/bionano_scaffold/3.7.0+galaxy3 |  |
| 7 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 8 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 9 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 10 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 11 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.3+galaxy1 |  |
| 12 | gfastats_data_prep | (subworkflow) |  |
| 13 | Cut | Cut1 |  |
| 14 | Cut | Cut1 |  |
| 15 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/3.4.0+galaxy1 |  |
| 16 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/3.4.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | Scaffolds: agp | ngs_contigs_scaffold_agp |
| 7 | Bionano scaffolds reconciliated: gfa | output |
| 8 | Bionano scaffolds reconciliated: fasta | output |
| 9 | Assembly Statistics for s1 | stats |
| 11 | clean_stats | outfile |
| 15 | Nx Plot | output1 |
| 16 | Size Plot | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Scaffolding-BioNano-VGP7.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Scaffolding-BioNano-VGP7.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Scaffolding-BioNano-VGP7.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Scaffolding-BioNano-VGP7.ga -o job.yml`
- Lint: `planemo workflow_lint Scaffolding-BioNano-VGP7.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Scaffolding-BioNano-VGP7.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
