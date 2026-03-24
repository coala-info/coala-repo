---
name: query-a-metaplasmidome-database-to-identify-and-annotate-pla
description: "This metagenomics workflow maps raw sequencing data against a metaplasmidome database using minimap2 to identify plasmid sequences and annotate them with KEGG Orthologs and PFAM domains. Use this skill when you need to characterize the mobile genetic element profile of a microbial community by detecting known plasmids and determining their functional potential through gene annotation."
homepage: https://workflowhub.eu/workflows/1469
---

# Query a metaplasmidome database to identify and annotate plasmids in metagenomes

## Overview

This Galaxy workflow identifies and annotates plasmid sequences within raw metagenomic data by querying them against a specialized metaplasmidome database. It utilizes [minimap2](https://toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.28+galaxy0) to map metagenomic reads or assemblies against known metaplasmidome sequences, effectively isolating genetic material of extrachromosomal origin.

The pipeline performs comprehensive functional characterization by integrating predicted coding sequences (CDS) with KEGG Ortholog (KO) and PFAM annotations. Through a series of data transformation steps—including joining datasets, filtering by keywords, and grouping features—the workflow links identified plasmid sequences to their respective gene functions and protein families.

The final outputs provide a detailed overview of the metaplasmidome profile, including FASTA files of identified plasmid sequences and tabular reports of annotated CDS. These results allow researchers to quantify plasmid diversity and functional potential within complex microbial communities. This workflow is licensed under the MIT license and is tagged for use in Metagenomics and [microgalaxy](https://usegalaxy.eu) environments.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Metaplasmidome sequences | data_input | FASTA sequences of the metaplasmidome database |
| 1 | Raw metagenomics data | data_input | FASTA files of the raw metagenomics data |
| 2 | Metaplasmidome predicted CDS | data_input | GFF file with predicted CDS |
| 3 | KEGG Ortogolog | data_input | Tabular file with non-redundant KEGG Orthologs and CDS IDs |
| 4 | PFAM | data_input | Tabular file with non-redundant PFAM and CDS IDs |


Ensure all input files are correctly formatted, specifically using FASTA for metaplasmidome sequences and raw metagenomics data, while providing tabular files for predicted CDS, KEGG Orthologs, and PFAM annotations. For large-scale analyses, organize your raw metagenomic reads into a dataset collection to streamline the mapping process with minimap2. Refer to the README.md for comprehensive details on database preparation and specific column requirements for the annotation files. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and reproducible parameter management. One paragraph only.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.28+galaxy0 |  |
| 6 | Convert FASTA to Tabular | CONVERTER_fasta_to_tabular |  |
| 7 | Count GFF Features | toolshed.g2.bx.psu.edu/repos/devteam/count_gff_features/count_gff_features/0.2 |  |
| 8 | Cut | Cut1 |  |
| 9 | Cut | Cut1 |  |
| 10 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 11 | Histogram with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_histogram/ggplot2_histogram/3.4.0+galaxy0 |  |
| 12 | Cut | Cut1 |  |
| 13 | Histogram | toolshed.g2.bx.psu.edu/repos/devteam/histogram/histogram_rpy/1.0.4 |  |
| 14 | Filter | Filter1 |  |
| 15 | Histogram with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_histogram/ggplot2_histogram/3.4.0+galaxy0 |  |
| 16 | Filter | Filter1 |  |
| 17 | Cut | Cut1 |  |
| 18 | Cut | Cut1 |  |
| 19 | Histogram with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_histogram/ggplot2_histogram/3.4.0+galaxy0 |  |
| 20 | Join two Datasets | join1 |  |
| 21 | Cut | Cut1 |  |
| 22 | Cut | Cut1 |  |
| 23 | Add Header | toolshed.g2.bx.psu.edu/repos/estrain/add_column_headers/add_column_headers/0.1.3 |  |
| 24 | Sort | sort1 |  |
| 25 | Join two Datasets | join1 |  |
| 26 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/9.3+galaxy1 |  |
| 27 | Cut | Cut1 |  |
| 28 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |
| 29 | Group | Grouping1 |  |
| 30 | Filter | Filter1 |  |
| 31 | Cut | Cut1 |  |
| 32 | Filter by keywords and/or numerical value | toolshed.g2.bx.psu.edu/repos/proteore/proteore_filter_keywords_values/MQoutputfilter/2021.04.19.1 |  |
| 33 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy1 |  |
| 34 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy1 |  |
| 35 | Add Header | toolshed.g2.bx.psu.edu/repos/estrain/add_column_headers/add_column_headers/0.1.3 |  |
| 36 | Concatenate datasets | cat1 |  |
| 37 | Join two Datasets | join1 |  |
| 38 | Cut | Cut1 |  |
| 39 | Join two Datasets | join1 |  |
| 40 | Cut | Cut1 |  |
| 41 | Select last | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_tail_tool/9.3+galaxy1 |  |
| 42 | Add Header | toolshed.g2.bx.psu.edu/repos/estrain/add_column_headers/add_column_headers/0.1.3 |  |
| 43 | Filter | Filter1 |  |
| 44 | Filter | Filter1 |  |
| 45 | Group | Grouping1 |  |
| 46 | Group | Grouping1 |  |
| 47 | Group | Grouping1 |  |
| 48 | Select last | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_tail_tool/9.3+galaxy1 |  |
| 49 | Sort | sort1 |  |
| 50 | Sort | sort1 |  |
| 51 | Add Header | toolshed.g2.bx.psu.edu/repos/estrain/add_column_headers/add_column_headers/0.1.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 23 | Metagenomes identified as plasmids | Data Table |
| 28 | Metagenome sequences identified as plasmids | output |
| 36 | CDS in metagenomes identified as plasmids | out_file1 |
| 42 | CDS in metagenomes identified as plasmids + KO + PFAM | Data Table |
| 51 | CDS annotation overview per metagenomic sequences | Data Table |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run metaplasmidome.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run metaplasmidome.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run metaplasmidome.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init metaplasmidome.ga -o job.yml`
- Lint: `planemo workflow_lint metaplasmidome.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `metaplasmidome.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
