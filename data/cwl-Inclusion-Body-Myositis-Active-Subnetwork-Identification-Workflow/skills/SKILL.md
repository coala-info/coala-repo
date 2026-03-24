---
name: inclusion-body-myositis-active-subnetwork-identification-wor
description: "This CWL workflow integrates transcriptomic data with STRING protein-protein interactions and miRTarBase regulatory networks to identify disease-specific active subnetworks using the MOGAMUN algorithm. Use this skill when you need to identify significant molecular modules and regulatory drivers associated with Inclusion Body Myositis to better understand its underlying pathological mechanisms."
homepage: https://workflowhub.eu/workflows/681
---
# Inclusion Body Myositis Active Subnetwork Identification Workflow

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/681) pipeline is designed for Inclusion Body Myositis (IBM) research, focusing on the identification of active biological subnetworks. It automates the construction of a comprehensive disease network by integrating transcriptomics data with known molecular interactions to highlight significant functional modules.

The workflow begins by importing and mapping data from the [STRING](https://string-db.org/) database for protein-protein interactions and [miRTarBase](https://mirtarbase.cuhk.edu.cn/) for microRNA-target interactions. These datasets are integrated into a unified network structure, providing a multi-omic foundation for downstream analysis.

The core analysis utilizes [MOGAMUN](https://github.com/elperdomo/MOGAMUN), a multi-objective genetic algorithm tailored for active subnetwork identification. The pipeline handles the conversion of network data into compatible igraph formats, executes the MOGAMUN algorithm, and performs post-processing to extract and visualize the most relevant disease-related subnetworks.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| stringdb_input_file | STRING data | File | Table with Protein - protein interaction data as downloaded from STRING |
| mirtarbase_input_file | miRTarBase data | File | Table with miRNA - mRNA target data as downloaded from |
| entrez2string | STRING identifier mapping | File | Table with entrez mappings from STRING protein idenfitiers as downloaded from STRING |
| bridgedb | BridgeDB cache | Directory | directory with cached BridgeDB data |
| mRNA-mRNA_bicor | mRNA expression correlation | File | Tab separated edge list with Ensembl gene ID's in the first two columns, and their bi-weight midcorrelation as defined by Langelder et al. in the third column |
| miRNA-mRNA_bicor | miRNA mRNA correlation | File | Tab separated edge list with Ensembl gene ID's in the first column, miRBase ID's in the second column. and their bi-weight midcorrelation as defined by Langelder et al. in the third column |
| de_mRNA | Differential gene expression | File | Output of differential mRNA expression testing from DESeq2, with Ensembl gene ID's concatened with gene symbols with ";" inbetween in the first column |
| de_miRNA | Differential miRNA expression | File | Output of differential miRNA expression testing from DESeq2, with miRBase ID's in the first column |
| variant_burden | Variant Burden | File | Output of variant burden testing using SKAT in the rvtests package, with HGNC symbols in the first column |
| stringdb_number_of_edges | STRING limit | int | The number of STRING edges to use, USE FOR TESTING ONLY |
| stringdb_min_weight | STRING filter | int | The minimum score for a STRING edge to be included in the analysis |
| mirtarbase_number_of_edges | miRTarBase limit | int | The number of miRTarBase edges to use, USE FOR TESTING ONLY |
| max_cor_edges | Correlation limit | int | The number of correlation edges to use, USE FOR TESTING ONLY |
| mogamun_generations | MOGAMUN generations | int | The number of generation to let the genetic algorithm in MOGAMUN evolve |
| mogamun_runs | MOGAMUN runs | int | The number of parallel runs to let MOGAMUN do, these parallel runs are combined in postprocessing |
| mogamun_cores | MOGAMUN cores | int | The number of cores to let MOGAMUN use |
| mogamun_min_size | Minimum subnetwork size | int | The minimum size of subnetworks during postprocessing |
| mogamun_max_size | Maximum subnetwork size | int | The maximum size of subnetworks during postprocessing |
| mogamun_merge_threshold | Subnetwork merge threshold | int | the minimum Jaccard Index overlap between two subnetworks to allow them to be merged |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| import_stringdb | Import STRING | Imports STRING database file |
| import_mirtarbase | Import miRTarBase | Imports miRTarBase database file |
| map_stringdb | Map STRING | Maps STRING identifiers to identifiers consistent with datasets |
| map_mirtarbase | Map miRTarBase | Maps miRTarBase identifiers to identifiers consistent with datasets |
| integrate_graph | Integrate network | Integrates all datasources into a single disease network |
| igraph_to_mogamun | Convert igraph to MOGAMUN | Converts the igraph network format to the MOGAMUN input format |
| run_mogamun | Run MOGAMUN | runs the MOGAMUN software with selected paramters |
| postprocess_mogamun | Postprocess MOGAMUN | processes output from MOGAMUN, and merges overlapping subnetwork |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| full_graph | Full network | File | The full disease network, which combines all data sources |
| subnetworks | Subnetworks | Directory | Folder with the resulting subnetworks and generation statistics |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/681
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
