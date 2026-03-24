---
name: goseq-go-kegg-enrichment-analysis
description: "This Galaxy workflow performs GO and KEGG enrichment analysis using the goseq tool by processing differential expression results, gene lengths, and pathway annotations. Use this skill when you need to identify overrepresented biological processes, molecular functions, or metabolic pathways in a set of differentially expressed genes while accounting for gene length bias."
homepage: https://workflowhub.eu/workflows/1194
---

# Goseq GO-KEGG Enrichment Analysis

## Overview

This workflow performs Gene Ontology (GO) and KEGG pathway enrichment analysis using the [goseq](https://toolshed.g2.bx.psu.edu/repos/iuc/goseq/goseq/1.50.0+galaxy0) tool suite. It is specifically designed to account for gene length bias, a common issue in RNA-seq data where longer genes are more likely to be identified as differentially expressed.

The analysis requires several inputs, including a differential expression result file (gene symbols and boolean status), a gene length file, and a KEGG pathway mapping file. Users must also specify the target genome and gene ID format, such as Ensembl, Entrez, or Symbol. For detailed instructions on preparing these datasets using tools like [featureCounts](https://usegalaxy.eu/?tool_id=toolshed.g2.bx.psu.edu%2Frepos%2Fiuc%2Ffeaturecounts%2Ffeaturecounts%2F2.0.6%2Bgalaxy0&version=latest), please refer to the README.md in the Files section.

The workflow generates comprehensive results across three GO categories—Cellular Component, Biological Process, and Molecular Function—as well as KEGG pathways. For each category, it produces an enrichment table, a visualization of top categories, and a list of differentially expressed genes associated with each term.

This resource is released under the [MIT](https://opensource.org/licenses/MIT) license and provides a streamlined approach for functional annotation and pathway analysis in transcriptomics studies.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Select genome to use | parameter_input | Select which genome your data is from |
| 1 | Differential expression result | data_input | input1: table with two columns. 1 gene 2 T/F based on Differential Expression Analysis |
| 2 | Select gene ID format | parameter_input | Select the format of your genes |
| 3 | gene length | data_input | input2: table with two columns. 1 gene 2 gene length |
| 4 | KEGG pathways | data_input | a table with two columns: 1. Pathway ID 2. Pathway name like: ID            Name 01100	Metabolic pathways - mmus 01200	Carbon metabolism - mmus  you can get it from KEGG https://rest.kegg.jp/list/pathway/mmu |


Ensure your differential expression and gene length inputs are tabular files with gene symbols in the first column, specifically using boolean values for DEG status and numeric values for lengths. You can generate the required gene length file using the "Gene length and GC content" tool or by enabling the length output in featureCounts. For KEGG analysis, provide a two-column tabular mapping of pathway IDs to names sourced from the KEGG REST API for your specific organism. Refer to the README.md for detailed formatting examples and tool configurations. You can use `planemo workflow_job_init` to create a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | goseq | toolshed.g2.bx.psu.edu/repos/iuc/goseq/goseq/1.50.0+galaxy0 | input1: table with two columns. 1 gene 2 T/F based on DEA  input2: table with two columns. 1 gene 2 gene length |
| 6 | goseq | toolshed.g2.bx.psu.edu/repos/iuc/goseq/goseq/1.50.0+galaxy0 | input1: table with two columns. 1 gene 2 T/F based on DEA (is it DEG?)  input2: table with two columns. 1 gene 2 gene length |
| 7 | goseq | toolshed.g2.bx.psu.edu/repos/iuc/goseq/goseq/1.50.0+galaxy0 | input1: table with two columns. 1 gene 2 T/F based on DEA (is it DEG?)  input2: table with two columns. 1 gene 2 gene length |
| 8 | goseq | toolshed.g2.bx.psu.edu/repos/iuc/goseq/goseq/1.50.0+galaxy0 | input1: table with two columns. 1 gene 2 T/F based on DEA (is it DEG?)  input2: table with two columns. 1 gene 2 gene length |
| 9 | Join two Datasets | join1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | goseq Enrichment Table (Cellular Component) | wallenius_tab |
| 5 | goseq Top Categories plot (Cellular Component) | top_plot |
| 5 | goseq Differential Genes in each Category (Cellular Component) | cat_genes_tab |
| 6 | goseq Enrichment Table (Biological Process) | wallenius_tab |
| 6 | goseq Differential Genes in each Category (Biological Process) | cat_genes_tab |
| 6 | goseq Top Categories plot (Biological Process) | top_plot |
| 7 | goseq Top Categories plot (Molecular Function) | top_plot |
| 7 | goseq Differential Genes in each Category (Molecular Function) | cat_genes_tab |
| 7 | goseq Enrichment Table (Molecular Function) | wallenius_tab |
| 8 | goseq Differential Genes in each Category (KEGG) | cat_genes_tab |
| 9 | goseq Enrichment Table (KEGG) | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run goseq-go-kegg-enrichment-analsis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run goseq-go-kegg-enrichment-analsis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run goseq-go-kegg-enrichment-analsis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init goseq-go-kegg-enrichment-analsis.ga -o job.yml`
- Lint: `planemo workflow_lint goseq-go-kegg-enrichment-analsis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `goseq-go-kegg-enrichment-analsis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
