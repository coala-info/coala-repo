---
name: copy-of-gtn-training-antibiotic-resistance-detection
description: This microbiome workflow processes Nanopore plasmid sequencing data using tools like Unicycler for assembly, PlasFlow for classification, and staramr for antibiotic resistance gene detection. Use this skill when you need to assemble long-read plasmid sequences and characterize the presence of antimicrobial resistance determinants within microbial communities.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# copy-of-gtn-training-antibiotic-resistance-detection

## Overview

This workflow is designed for the detection and characterization of antibiotic resistance genes within plasmid metagenomics data, specifically optimized for long-read Oxford Nanopore sequencing. It begins with initial quality control using [NanoPlot](https://github.com/wdecoster/NanoPlot) to assess the raw input reads before proceeding to downstream assembly and analysis.

The core of the pipeline performs de novo assembly using [Unicycler](https://github.com/rrwick/Unicycler) and [miniasm](https://github.com/lh3/miniasm). To ensure high-quality results, the workflow incorporates [Racon](https://github.com/isovic/racon) for sequence polishing and [Bandage](https://rrwick.github.io/Bandage/) for the visualization of assembly graphs, allowing users to inspect the connectivity and structure of the assembled plasmids.

For functional identification, the workflow utilizes [PlasFlow](https://github.com/smaegol/PlasFlow) to classify sequences as plasmid or chromosomal origin. Finally, [staramr](https://github.com/phac-nml/staramr) is used to scan the assemblies against the ResFinder and PointFinder databases to identify specific antimicrobial resistance (AMR) genes and chromosomal mutations, providing a comprehensive profile of the resistome within the sample.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Plasmids | data_collection_input |  |


Ensure your input is provided as a data collection of Nanopore long reads, typically in fastq or fastq.gz format, to facilitate batch processing through the assembly and AMR detection steps. Using a collection instead of individual datasets is essential for tools like staramr and PlasFlow to handle multiple samples efficiently within this workflow. For automated testing and job configuration, you can generate a template using `planemo workflow_job_init` to create your `job.yml` file. Detailed instructions on parameter tuning and reference database selection are available in the accompanying README.md.

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
planemo run workflow-plasmid-metagenomics-nanopore.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow-plasmid-metagenomics-nanopore.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow-plasmid-metagenomics-nanopore.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow-plasmid-metagenomics-nanopore.ga -o job.yml`
- Lint: `planemo workflow_lint workflow-plasmid-metagenomics-nanopore.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow-plasmid-metagenomics-nanopore.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)