---
name: deg-part-ref-based-rna-seq-transcriptomics-gtn
description: This transcriptomics workflow processes RNA-Seq count collections and GTF annotations using DESeq2, goseq, and Pathview to identify differentially expressed genes and enriched biological pathways. Use this skill when you need to determine the statistical significance of gene expression changes across experimental conditions and visualize the resulting functional enrichment through heatmaps and pathway diagrams.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# deg-part-ref-based-rna-seq-transcriptomics-gtn

## Overview

This workflow performs differential gene expression (DEG) analysis on reference-based RNA-Seq data, following the standards established by the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/). It utilizes a dataset collection and a reference GTF (specifically configured for *Drosophila melanogaster*) to identify statistically significant changes in gene expression using [DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html).

The pipeline automates functional annotation and enrichment analysis by calculating gene length and GC content to support [goseq](https://bioconductor.org/packages/release/bioc/html/goseq.html). This allows for the identification of overrepresented and underrepresented Gene Ontology (GO) terms and KEGG pathways, providing biological context to the expression data.

The workflow generates a comprehensive suite of outputs, including annotated result tables, normalized counts, and Z-scores. Visualization tools are integrated throughout, producing DESeq2 diagnostic plots, [Pathview](https://pathview.uncc.edu/) pathway maps, and high-quality heatmaps via `ggplot2` to illustrate expression patterns across experimental conditions.

This transcriptomics tool is released under the MIT license and is designed for researchers requiring a robust, reproducible path from count data to functional biological insights.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Dataset Collection | data_collection_input | Counts obtained by Feature counts |
| 1 | Drosophila_melanogaster.BDGP6.32.109_UCSC.gtf.gz | data_input | gene annotation |
| 2 | header | data_input | header for annotated DESeq2 output |
| 3 | KEGG pathways to plot | data_input | selected KEGG pathways to plot |


Ensure your input dataset collection contains count files with consistent element identifiers to facilitate proper sample grouping in DESeq2. The reference annotation must be a GTF file, while the KEGG pathways and header files should be provided as tabular datasets to ensure correct tool execution. For automated job configuration, you can use `planemo workflow_job_init` to generate a `job.yml` template. Refer to the README.md for comprehensive details on specific parameter settings and data preparation requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 5 | Gene length and GC content | toolshed.g2.bx.psu.edu/repos/iuc/length_and_gc_content/length_and_gc_content/0.1.2 |  |
| 6 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.5+galaxy2 |  |
| 7 | Change Case | ChangeCase |  |
| 8 | Tag elements | __TAG_FROM_FILE__ |  |
| 9 | DESeq2 | toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.8+galaxy0 |  |
| 10 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 11 | Annotate DESeq2/DEXSeq output tables | toolshed.g2.bx.psu.edu/repos/iuc/deg_annotate/deg_annotate/1.1.0+galaxy1 |  |
| 12 | Table Compute | toolshed.g2.bx.psu.edu/repos/iuc/table_compute/table_compute/1.2.4+galaxy2 |  |
| 13 | Cut | Cut1 |  |
| 14 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/9.5+galaxy2 |  |
| 15 | Table Compute | toolshed.g2.bx.psu.edu/repos/iuc/table_compute/table_compute/1.2.4+galaxy2 |  |
| 16 | Change Case | ChangeCase |  |
| 17 | Filter | Filter1 |  |
| 18 | goseq | toolshed.g2.bx.psu.edu/repos/iuc/goseq/goseq/1.50.0+galaxy0 |  |
| 19 | goseq | toolshed.g2.bx.psu.edu/repos/iuc/goseq/goseq/1.50.0+galaxy0 |  |
| 20 | Cut | Cut1 |  |
| 21 | Filter | Filter1 |  |
| 22 | Filter | Filter1 |  |
| 23 | Filter | Filter1 |  |
| 24 | Filter | Filter1 |  |
| 25 | Filter | Filter1 |  |
| 26 | Pathview | toolshed.g2.bx.psu.edu/repos/iuc/pathview/pathview/1.34.0+galaxy0 |  |
| 27 | Join two Datasets | join1 |  |
| 28 | Group | Grouping1 |  |
| 29 | Group | Grouping1 |  |
| 30 | Cut | Cut1 |  |
| 31 | heatmap2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap2/ggplot2_heatmap2/3.2.0+galaxy1 |  |
| 32 | heatmap2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_heatmap2/ggplot2_heatmap2/3.2.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | DESeq2_normalized_counts | counts_out |
| 9 | DESeq2_plots | plots |
| 14 | DESeq2_annotated_results_with_header | out_file1 |
| 15 | z_score | table |
| 18 | go_genes | cat_genes_tab |
| 18 | go_plot | top_plot |
| 18 | go_terms | wallenius_tab |
| 19 | kegg_genes | cat_genes_tab |
| 19 | kegg_pathways | wallenius_tab |
| 22 | go_underrepresented | out_file1 |
| 23 | go_overrepresented | out_file1 |
| 24 | kegg_underrepresented | out_file1 |
| 25 | kegg_overrepresented | out_file1 |
| 26 | pathview_plot | multiple_kegg_native |
| 28 | go_underrepresented_categories | out_file1 |
| 29 | go_overrepresented_categories | out_file1 |
| 31 | heatmap_log | output1 |
| 32 | heatmap_zscore | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run deg-analysis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run deg-analysis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run deg-analysis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init deg-analysis.ga -o job.yml`
- Lint: `planemo workflow_lint deg-analysis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `deg-analysis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)