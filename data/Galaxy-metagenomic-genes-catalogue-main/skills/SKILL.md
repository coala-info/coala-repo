---
name: metagenomic-genes-catalogue-analysis
description: "This workflow processes trimmed metagenomic reads through assembly with MEGAHIT, gene prediction via Prodigal, and comprehensive annotation using tools like MMseqs2, eggNOG-mapper, and AMRFinderPlus. Use this skill when you need to construct a non-redundant gene catalogue from environmental or clinical samples to characterize taxonomic composition, functional potential, and antimicrobial resistance profiles."
homepage: https://workflowhub.eu/workflows/2024
---

# Metagenomic Genes Catalogue Analysis

## Overview

This Galaxy workflow performs comprehensive metagenomic analysis, transforming raw reads into a functional and taxonomic gene catalogue. It begins by assembling contigs using [MEGAHIT](https://github.com/voutcn/megahit) and assessing assembly quality with [QUAST](https://github.com/ablab/quast). Following assembly, [Prodigal](https://github.com/hyattpd/Prodigal) is employed to predict Coding DNA Sequences (CDS) across the generated contigs.

The workflow features a dual-path logic based on user requirements. It can either generate a complete genes catalogue by clustering all potential genes with [MMseqs2](https://github.com/soedinglab/MMseqs2), or focus specifically on antibiotic resistance genes (ARGs). In the latter case, the pipeline isolates CDSs located on the same contigs as detected ARGs to provide a targeted functional and taxonomic context for resistance elements.

Comprehensive annotation is provided through several specialized tools. Functional annotation is performed via [eggNOG-mapper](https://github.com/eggnogdb/eggnog-mapper), while taxonomic assignments are handled by [MMseqs2](https://github.com/soedinglab/MMseqs2). Antimicrobial resistance (AMR) and virulence detection are integrated using a suite of tools including [ABRicate](https://github.com/tseemann/abricate), [AMRFinderPlus](https://github.com/ncbi/amr), [starAMR](https://github.com/phac-nml/staramr), and [argNorm](https://github.com/BigDataBiology/argNorm).

Final outputs include abundance estimations per sample calculated with [CoverM](https://github.com/wwood/CoverM), interactive [Krona](https://github.com/marbl/Krona) charts for taxonomy visualization, and a consolidated [MultiQC](https://multiqc.info/) report. This workflow is licensed under GPL-3.0-or-later and is tagged for Metagenomics and ABRomics applications.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Metagenomics Trimmed reads | data_collection_input | Input for this workflow is a paired collection from metagenomics trimmed reads |
| 1 | AMR genes detection database | parameter_input | Select the database to identify AMR genes with AMRFinderPlus. |
| 2 | Full genes catalogue | parameter_input | Set it to Yes if you want to have the full gene catalogue. Functionnal and taxonomical annotation are made on full clustered CDS |
| 3 | Virulence genes detection database | parameter_input | Select the database to identify virulence genes with ABRicate. |
| 4 | starAMR database | parameter_input | Select the database to identify AMR elements with starAMR. |
| 5 | mmseqs2 taxonomy DB | parameter_input | Select the database to identify taxonomy with mmseqs2 |
| 6 | eggNOG database | parameter_input | Select the database to identify genes function with eggnogmapper |


This workflow requires quality-filtered, host-removed metagenomic reads provided as a paired-end data collection to ensure accurate assembly and abundance estimation. You must also provide several reference databases for AMR detection, taxonomy, and functional annotation, typically in tabular or specific database formats as required by tools like MMseqs2 and eggNOG-mapper. The analysis path branches based on the "Full genes catalogue" boolean parameter, so verify this setting to determine if the workflow clusters the entire gene set or focuses specifically on antibiotic resistance genes. For comprehensive instructions on database versions and input preparation, refer to the README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` template for managing these multiple inputs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | MEGAHIT | toolshed.g2.bx.psu.edu/repos/iuc/megahit/megahit/1.2.9+galaxy2 |  |
| 8 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 9 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 | Convert to tabular format to make it easier to modify the contig ID. |
| 10 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.3.0+galaxy1 |  |
| 11 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 12 | Add input name as column | toolshed.g2.bx.psu.edu/repos/mvdbeek/add_input_name_as_column/addName/0.2.0 | Adds the sample name to the column corresponding to the initial ID. Allows you to create a unique ID for each sample. |
| 13 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 | Return to the fasta format with unique IDs. |
| 14 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/9.5+galaxy2 | Concatenate contigs from each sample |
| 15 | Prodigal Gene Predictor | toolshed.g2.bx.psu.edu/repos/iuc/prodigal/prodigal/2.6.3+galaxy0 |  |
| 16 | MMseqs2 Sequence Clustering | toolshed.g2.bx.psu.edu/repos/iuc/mmseqs2_easy_linclust_clustering/mmseqs2_easy_linclust_clustering/17-b804f+galaxy0 |  |
| 17 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 18 | AMRFinderPlus | toolshed.g2.bx.psu.edu/repos/iuc/amrfinderplus/amrfinderplus/3.12.8+galaxy0 |  |
| 19 | ABRicate | toolshed.g2.bx.psu.edu/repos/iuc/abricate/abricate/1.0.1 |  |
| 20 | staramr | toolshed.g2.bx.psu.edu/repos/iuc/staramr/staramr_search/0.11.0+galaxy3 |  |
| 21 | argNorm | toolshed.g2.bx.psu.edu/repos/iuc/argnorm/argnorm/1.0.0+galaxy0 |  |
| 22 | table rename column | toolshed.g2.bx.psu.edu/repos/recetox/table_pandas_rename_column/table_pandas_rename_column/2.2.3+galaxy1 |  |
| 23 | Remove columns | toolshed.g2.bx.psu.edu/repos/iuc/column_remove_by_header/column_remove_by_header/1.0 |  |
| 24 | Genes catalogue AMR specific part | (subworkflow) | Workflow for retrieving the IDs of contigs and CDSs of antibiotic resistance genes and filtering Prodigal output to retrieve a catalogue of antibiotic resistance genes and potential genes present on the same contig as the ARG. |
| 25 | Remove beginning | Remove beginning1 |  |
| 26 | Remove columns | toolshed.g2.bx.psu.edu/repos/iuc/column_remove_by_header/column_remove_by_header/1.0 |  |
| 27 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 28 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 29 | Remove columns | toolshed.g2.bx.psu.edu/repos/iuc/column_remove_by_header/column_remove_by_header/1.0 |  |
| 30 | MMseqs2 Sequence Clustering | toolshed.g2.bx.psu.edu/repos/iuc/mmseqs2_easy_linclust_clustering/mmseqs2_easy_linclust_clustering/17-b804f+galaxy0 |  |
| 31 | SeqKit translate | toolshed.g2.bx.psu.edu/repos/iuc/seqkit_translate/seqkit_translate/2.12.0+galaxy0 |  |
| 32 | eggNOG Mapper | toolshed.g2.bx.psu.edu/repos/galaxyp/eggnog_mapper/eggnog_mapper/2.1.8+galaxy4 |  |
| 33 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 34 | MMseqs2 Taxonomy Assignments | toolshed.g2.bx.psu.edu/repos/iuc/mmseqs2_taxonomy_assignment/mmseqs2_taxonomy_assignment/17-b804f+galaxy0 |  |
| 35 | table rename column | toolshed.g2.bx.psu.edu/repos/recetox/table_pandas_rename_column/table_pandas_rename_column/2.2.3+galaxy1 |  |
| 36 | CoverM contig | toolshed.g2.bx.psu.edu/repos/iuc/coverm_contig/coverm_contig/0.7.0+galaxy0 |  |
| 37 | Krakentools: Convert kraken report file | toolshed.g2.bx.psu.edu/repos/iuc/krakentools_kreport2krona/krakentools_kreport2krona/1.2.1+galaxy0 |  |
| 38 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 39 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 |  |
| 40 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.33+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | Megahit Contigs Output | output |
| 10 | Report Tabular Meta | report_tabular_meta |
| 10 | Report HTML Meta | report_html_meta |
| 14 | Concatenate Datasets | out_file1 |
| 15 | Prodigal Genes Sequences | output_fnn |
| 15 | Prodigal Genes Translation | output_faa |
| 18 | AMRFinderplus Report | amrfinderplus_report |
| 19 | Abricate Virulence Report | report |
| 20 | Detailed Summary | detailed_summary |
| 20 | Plasmidfinder | plasmidfinder |
| 20 | Resfinder | resfinder |
| 21 | Argnorm AMRfinderplus Report | output |
| 31 | Seqkit Protein Translation | output |
| 32 | Eggnog Report Orthologs | annotations_orthologs |
| 32 | Eggnog Seed Orthologs | seed_orthologs |
| 32 | Eggnog Annotations | annotations |
| 33 | MMseqs2 representative sequences | data_param |
| 34 | MMseqs2 Taxonomy Tabular | output_taxonomy_tsv |
| 34 | MMseqs2 Taxonomy Kraken | output_taxonomy_kraken |
| 38 | CoverM contig | tabular_output |
| 39 | MMseqs2 Taxonomy Krona | output |
| 40 | MultiQC Report | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run metagenomic-genes-catalogue.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run metagenomic-genes-catalogue.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run metagenomic-genes-catalogue.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init metagenomic-genes-catalogue.ga -o job.yml`
- Lint: `planemo workflow_lint metagenomic-genes-catalogue.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `metagenomic-genes-catalogue.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
