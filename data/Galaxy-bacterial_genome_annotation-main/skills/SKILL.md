---
name: bacterial-genome-annotation
description: This workflow performs comprehensive annotation of assembled bacterial genomes by integrating Bakta, IntegronFinder, PlasmidFinder, and ISEScan to identify genes, integrons, plasmids, and insertion sequences. Use this skill when you need to characterize the functional landscape of a bacterial isolate, specifically to detect mobile genetic elements and structural features associated with horizontal gene transfer or antimicrobial resistance.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# bacterial-genome-annotation

## Overview

This Galaxy workflow provides a comprehensive pipeline for the functional and structural annotation of assembled bacterial genomes. It is designed to identify essential genomic features, including coding sequences (CDS), small proteins, and various mobile genetic elements that contribute to bacterial evolution and antibiotic resistance.

The pipeline integrates several specialized tools to characterize the input FASTA sequences. It uses [Bakta](https://toolshed.g2.bx.psu.edu/repos/iuc/bakta/bakta/1.9.4+galaxy1) for rapid genome annotation (which can be toggled on or off), [Integron Finder](https://toolshed.g2.bx.psu.edu/repos/iuc/integron_finder/integron_finder/2.0.5+galaxy0) to locate integrons and CALIN elements, [PlasmidFinder](https://toolshed.g2.bx.psu.edu/repos/iuc/plasmidfinder/plasmidfinder/2.1.6+galaxy1) for plasmid typing, and [ISEScan](https://toolshed.g2.bx.psu.edu/repos/iuc/isescan/isescan/1.7.3+galaxy0) for the detection of Insertion Sequence (IS) elements.

In addition to standard GFF3, FASTA, and tabular reports, the workflow utilizes [ToolDistillator](https://toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator/tooldistillator/1.0.4+galaxy0) to aggregate results from all analysis steps into a single, parsable JSON file. This unified output simplifies downstream data processing and comparative genomics, making it a valuable tool for researchers working within the ABRomics framework or general bacterial genomics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input sequence fasta | data_input | Can be any fasta file. |
| 1 | Plasmid detection database | parameter_input | Select a database to identify plasmids with PlasmidFinder. |
| 2 | Bacterial genome annotation database | parameter_input | Select a database to predict CDS and small proteins (sORF) with Bakta. |
| 3 | AMRFinderPlus database | parameter_input | Select a database to annotate AMR genes with Bakta. |
| 4 | Run Bakta | parameter_input | Choose if you want to run bakta or not (can take a long time) |


Ensure your input is a high-quality assembled bacterial genome in FASTA format, as the workflow is optimized for contigs or scaffolds rather than raw reads. You must provide specific database paths for PlasmidFinder, Bakta, and AMRFinderPlus to ensure accurate feature detection and nomenclature. While single datasets are standard, using a dataset collection allows for efficient batch processing of multiple genomes through the annotation pipeline. For comprehensive guidance on parameter settings and database versions, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and reproducible metadata management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | ISEScan | toolshed.g2.bx.psu.edu/repos/iuc/isescan/isescan/1.7.3+galaxy0 | genomic_annotation_insertionelement_isescan |
| 6 | Integron Finder | toolshed.g2.bx.psu.edu/repos/iuc/integron_finder/integron_finder/2.0.5+galaxy0 | genomic_annotation_integron |
| 7 | PlasmidFinder | toolshed.g2.bx.psu.edu/repos/iuc/plasmidfinder/plasmidfinder/2.1.6+galaxy1 | genomic_annotation_plasmid_plasmidfinder |
| 8 | Bakta | toolshed.g2.bx.psu.edu/repos/iuc/bakta/bakta/1.9.4+galaxy1 |  |
| 9 | ToolDistillator | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator/tooldistillator/1.0.4+galaxy0 | ToolDistillator extracts results from tools and creates a JSON file for each tool |
| 10 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 11 | ToolDistillator Summarize | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator_summarize/tooldistillator_summarize/1.0.4+galaxy0 | ToolDistillator summarize groups all JSON file into a unique JSON file |
| 12 | ToolDistillator | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator/tooldistillator/1.0.4+galaxy0 | ToolDistillator extracts results from tools and creates a JSON file for each tool |
| 13 | ToolDistillator Summarize | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator_summarize/tooldistillator_summarize/1.0.4+galaxy0 | ToolDistillator summarize groups all JSON file into a unique JSON file |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | isescan_logfile_text | logfile |
| 5 | isescan_orf_faa | orf_faa |
| 5 | isescan_is_fasta | is_fasta |
| 5 | isescan_results_tabular | all_results |
| 5 | isescan_orf_fasta | orf_fna |
| 5 | isescan_summary_tabular | summary |
| 5 | isescan_annotation_gff3 | annotation |
| 6 | integronfinder2_results_tabular | integrons_table |
| 6 | integronfinder2_logfile_text | integron_log |
| 6 | integronfinder2_summary | summary |
| 7 | plasmidfinder_results_raw | raw_file |
| 7 | plasmidfinder_hit_genome_fasta | hit_file |
| 7 | plasmidfinder_results_tabular | result_file |
| 7 | plasmidfinder_result_json | json_file |
| 7 | plasmidfinder_hit_reference_fasta | plasmid_file |
| 8 | bakta_annotation_tabular | annotation_tsv |
| 8 | bakta_assembly_fasta | annotation_fna |
| 8 | bakta_summary_text | summary_txt |
| 8 | bakta_annotation_plot | annotation_plot |
| 8 | bakta_hypothetical_faa | hypotheticals_faa |
| 8 | bakta_hypothetical_tabular | hypotheticals_tsv |
| 8 | bakta_annotation_embl | annotation_embl |
| 8 | bakta_annotation_gbff | annotation_gbff |
| 8 | bakta_aminoacid_sequence_faa | annotation_faa |
| 8 | bakta_nucleotide_sequence_fasta | annotation_ffn |
| 8 | bakta_annotation_gff3 | annotation_gff3 |
| 9 | tooldistillator_results_annotation_without_bakta | output_json |
| 10 | bakta_annotation_json | data_param |
| 11 | tooldistillator_summarize_annotation_without_bakta | summary_json |
| 12 | tooldistillator_results_annotation_bakta | output_json |
| 13 | tooldistillator_summarize_bakta | summary_json |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run bacterial_genome_annotation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run bacterial_genome_annotation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run bacterial_genome_annotation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init bacterial_genome_annotation.ga -o job.yml`
- Lint: `planemo workflow_lint bacterial_genome_annotation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `bacterial_genome_annotation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)