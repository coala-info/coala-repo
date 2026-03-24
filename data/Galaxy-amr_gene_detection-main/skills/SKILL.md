---
name: amr-gene-detection
description: "This workflow identifies antimicrobial resistance genes, point mutations, and virulence factors in assembled bacterial genomes using StarAMR, AMRFinderPlus, and ABRicate. Use this skill when you need to characterize the genetic basis of antibiotic resistance and pathogenicity in bacterial isolates for genomic surveillance or clinical research."
homepage: https://workflowhub.eu/workflows/1049
---

# AMR Gene Detection

## Overview

This workflow is designed for the comprehensive detection of antimicrobial resistance (AMR) and virulence genes from assembled bacterial genomes. It integrates multiple specialized tools to identify resistance markers, point mutations, and plasmid sequences, providing a detailed genomic profile of bacterial isolates.

The analysis pipeline utilizes [staramr](https://toolshed.g2.bx.psu.edu/repos/iuc/staramr/staramr_search/0.11.0+galaxy3) to query ResFinder, PointFinder, and PlasmidFinder databases, alongside [AMRFinderPlus](https://toolshed.g2.bx.psu.edu/repos/iuc/amrfinderplus/amrfinderplus/3.12.8+galaxy0) for robust gene and mutation identification. Additionally, [ABRicate](https://toolshed.g2.bx.psu.edu/repos/iuc/abricate/abricate/1.0.1) is employed to screen for virulence factors using the VFDB database.

To streamline downstream analysis, the workflow incorporates [ToolDistillator](https://toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator/tooldistillator/1.0.4+galaxy0) to aggregate disparate tool outputs into standardized, parsable JSON formats. This results in a consolidated summary of AMR genes, MLST typing, and virulence profiles. For detailed instructions on input preparation and file descriptions, please refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input sequence fasta | data_input | Can be any fasta file. |
| 1 | StarAMR database | parameter_input | Select the database for StarAMR (ResFinder, PoinFinder, PlasmidFinder) |
| 2 | Species for point mutation analysis using PointFinder | parameter_input | Select species for point mutation analysis using PointFinder database |
| 3 | Taxonomy group point mutation | parameter_input | Select the database to identify resistance-associated point mutations with AMRFinderPlus. |
| 4 | AMR genes detection database | parameter_input | Select the database to identify AMR genes with AMRFinderPlus. |
| 5 | Virulence genes detection database | parameter_input | Select the database to identify virulence genes with ABRicate. |


Ensure your input sequences are in FASTA format, typically representing assembled bacterial genomes. For large-scale analysis, organize your FASTA files into a dataset collection to process multiple samples simultaneously through the StarAMR and AMRFinderPlus steps. It is crucial to select the appropriate species and taxonomy parameters to ensure accurate point mutation detection. Refer to the README.md for comprehensive details on database versions and specific parameter configurations. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | staramr | toolshed.g2.bx.psu.edu/repos/iuc/staramr/staramr_search/0.11.0+galaxy3 | staramr_amr_genes |
| 7 | AMRFinderPlus | toolshed.g2.bx.psu.edu/repos/iuc/amrfinderplus/amrfinderplus/3.12.8+galaxy0 | amrfinderplus_point_mutation |
| 8 | ABRicate | toolshed.g2.bx.psu.edu/repos/iuc/abricate/abricate/1.0.1 | abricate_virulence |
| 9 | ToolDistillator | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator/tooldistillator/1.0.4+galaxy0 | ToolDistillator extracts results from tools and creates a JSON file for each tool |
| 10 | ToolDistillator Summarize | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator_summarize/tooldistillator_summarize/1.0.4+galaxy0 | ToolDistillator summarize groups all JSON file into a unique JSON file |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | staramr_pointfinder_report | pointfinder |
| 6 | staramr_mlst_report | mlst |
| 6 | staramr_summary | summary |
| 6 | staramr_resfinder_report | resfinder |
| 6 | staramr_detailed_summary | detailed_summary |
| 6 | staramr_settings | settings |
| 6 | staramr_plasmidfinder_report | plasmidfinder |
| 6 | staramr_excel_report | excel |
| 6 | staramr_blast_hits | blast_hits |
| 7 | amrfinderplus_nucleotide | nucleotide_output |
| 7 | amrfinderplus_mutation | mutation_all_report |
| 7 | amrfinderplus_report | amrfinderplus_report |
| 8 | abricate_virulence_report | report |
| 9 | tooldistillator_results_amr | output_json |
| 10 | tooldistillator_summarize_amr | summary_json |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run amr_gene_detection.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run amr_gene_detection.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run amr_gene_detection.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init amr_gene_detection.ga -o job.yml`
- Lint: `planemo workflow_lint amr_gene_detection.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `amr_gene_detection.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
