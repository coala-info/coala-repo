---
name: bacterial-genome-annotation
description: This bacterial genomics workflow processes assembly contigs to perform comprehensive structural and functional annotation using Bakta, ISEScan, PlasmidFinder, and Integron Finder. Use this skill when you need to characterize the genetic landscape of a bacterial isolate by identifying protein-coding genes, insertion sequences, integrons, and plasmids.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# bacterial-genome-annotation

## Overview

This workflow provides a comprehensive pipeline for the structural and functional annotation of bacterial genomes. Starting from genomic **contigs**, it integrates multiple specialized tools to identify diverse genetic elements, moving beyond standard gene prediction to provide a detailed genomic landscape.

The pipeline utilizes [Bakta](https://github.com/oschwengers/bakta) for rapid, standardized annotation of coding sequences and non-coding RNAs. To enhance the genomic context, it simultaneously runs [ISEScan](https://github.com/xiezhq/ISEScan) to detect insertion sequences, [PlasmidFinder](https://bitbucket.org/genomicepidemiology/plasmidfinder/src/master/) for plasmid identification, and [Integron Finder](https://github.com/gem-pasteur/Integron_Finder) to locate integrons and gene cassettes.

Following the primary analysis, the workflow performs several data manipulation steps, including text processing and table-to-GFF3 conversion, to consolidate the findings. The final outputs include detailed summaries of the identified mobile genetic elements and a [JBrowse](https://jbrowse.org/) instance for interactive visualization of the annotated features.

This [GTN](https://training.galaxyproject.org/)-aligned workflow is licensed under AGPL-3.0-or-later and is designed for researchers requiring a robust, automated solution for bacterial genome characterization within the Galaxy ecosystem.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | contigs | data_input | contigs |


Ensure your input contigs are in FASTA format, as tools like Bakta and ISEScan require high-quality assembly files for accurate feature prediction. While single datasets are supported, using a dataset collection is highly recommended if you are annotating multiple bacterial genomes simultaneously to streamline the workflow execution. Refer to the `README.md` for comprehensive details on required database versions and specific tool parameters. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing or execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | ISEScan | toolshed.g2.bx.psu.edu/repos/iuc/isescan/isescan/1.7.2.3+galaxy1 |  |
| 2 | PlasmidFinder | toolshed.g2.bx.psu.edu/repos/iuc/plasmidfinder/plasmidfinder/2.1.6+galaxy1 |  |
| 3 | Integron Finder | toolshed.g2.bx.psu.edu/repos/iuc/integron_finder/integron_finder/2.0.5+galaxy0 |  |
| 4 | Bakta | toolshed.g2.bx.psu.edu/repos/iuc/bakta/bakta/1.9.3+galaxy0 |  |
| 5 | Group | Grouping1 |  |
| 6 | Group | Grouping1 |  |
| 7 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy1 |  |
| 8 | Select last | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_tail_tool/9.3+galaxy1 |  |
| 9 | Table to GFF3 | toolshed.g2.bx.psu.edu/repos/iuc/tbl2gff3/tbl2gff3/1.2 |  |
| 10 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | isescan_results | all_results |
| 2 | plasmidfinder_results | result_file |
| 3 | integronfinder_summary | summary |
| 4 | bakta_summary | summary_txt |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run bacterial-genome-annotation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run bacterial-genome-annotation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run bacterial-genome-annotation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init bacterial-genome-annotation.ga -o job.yml`
- Lint: `planemo workflow_lint bacterial-genome-annotation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `bacterial-genome-annotation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)