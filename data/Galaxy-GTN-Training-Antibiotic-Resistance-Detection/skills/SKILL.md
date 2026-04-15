---
name: copy-of-gtn-training-antibiotic-resistance-detection
description: This metagenomics workflow processes Nanopore plasmid sequencing data using tools like NanoPlot, Unicycler, PlasFlow, and staramr to assemble sequences and identify antibiotic resistance genes. Use this skill when you need to characterize plasmid-borne antimicrobial resistance genes and reconstruct plasmid sequences from long-read metagenomic datasets.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# copy-of-gtn-training-antibiotic-resistance-detection

## Overview

This workflow is designed for the detection of antibiotic resistance genes within plasmid metagenomics data generated via Nanopore sequencing. It begins with initial quality control of raw reads using [NanoPlot](https://github.com/wdecoster/NanoPlot) and read mapping with [minimap2](https://github.com/lh3/minimap2) to prepare the data for assembly.

The core processing involves de novo assembly using both [Unicycler](https://github.com/rrwick/Unicycler) and [miniasm](https://github.com/lh3/miniasm). To evaluate the quality and structure of these assemblies, the workflow utilizes [Bandage](https://rrwick.github.io/Bandage/) for assembly graph visualization, allowing users to inspect the connectivity of potential plasmid sequences.

For functional analysis, the pipeline employs [PlasFlow](https://github.com/smaegol/PlasFlow) to identify and filter plasmid-derived contigs from metagenomic backgrounds. These sequences are then scanned by [staramr](https://github.com/phac-nml/staramr) to detect antimicrobial resistance (AMR) genes and plasmid replicon types.

The final stages focus on refinement and polishing. The workflow converts assembly graphs to FASTA format, performs secondary quality checks, and uses [Racon](https://github.com/isovic/racon) to improve the consensus accuracy of the assembled sequences. This comprehensive approach is ideal for metagenomics researchers characterizing the resistome of environmental or clinical samples.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Plasmids | data_collection_input |  |


Ensure your Nanopore sequencing reads are in FASTQ format and organized into a list collection to facilitate the automated batch processing of multiple plasmid samples. Using collections instead of individual datasets ensures that downstream assembly and AMR detection steps via staramr maintain sample associations correctly throughout the pipeline. For comprehensive details on parameter tuning and data pre-processing, consult the `README.md` file. You may also use `planemo workflow_job_init` to create a `job.yml` for rapid configuration of these input parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.25.0+galaxy1 |  |
| 2 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.17 |  |
| 3 | Create assemblies with Unicycler | toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.7.0 |  |
| 4 | miniasm | toolshed.g2.bx.psu.edu/repos/iuc/miniasm/miniasm/0.2+galaxy0 |  |
| 5 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy0 |  |
| 6 | PlasFlow | toolshed.g2.bx.psu.edu/repos/iuc/plasflow/PlasFlow/1.0 |  |
| 7 | staramr | toolshed.g2.bx.psu.edu/repos/nml/staramr/staramr_search/0.5.1 |  |
| 8 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy0 |  |
| 9 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.0 |  |
| 10 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.25.0+galaxy1 |  |
| 11 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.17 |  |
| 12 | Racon | toolshed.g2.bx.psu.edu/repos/bgruening/racon/racon/1.3.1.1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Workflow-plasmid-metagenomics-nanopore.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Workflow-plasmid-metagenomics-nanopore.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Workflow-plasmid-metagenomics-nanopore.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Workflow-plasmid-metagenomics-nanopore.ga -o job.yml`
- Lint: `planemo workflow_lint Workflow-plasmid-metagenomics-nanopore.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Workflow-plasmid-metagenomics-nanopore.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)