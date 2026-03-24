---
name: sapp-conversion-workflow
description: "This CWL workflow utilizes the Semantic Annotation Platform with Provenance (SAPP) to convert genome annotations and functional data from EMBL, InterProScan, eggNOG-mapper, and KoFamScan into standardized RDF and HDT formats. Use this skill when you need to integrate disparate functional annotations into a unified, semantically enriched knowledge graph to facilitate complex biological queries and ensure data provenance."
homepage: https://workflowhub.eu/workflows/1174
---
# SAPP conversion Workflow

## Overview

This Common Workflow Language (CWL) pipeline automates the conversion of genome annotation data into standardized RDF formats using the [SAPP](https://gitlab.com/sapp) (Semantic Annotation Platform with Provenance) framework. It is designed to integrate disparate bioinformatics outputs into a unified, semantically enriched structure based on the GBOL ontology, facilitating advanced data integration and querying.

The workflow ingests data from multiple sources, including EMBL files and functional annotation results from InterProScan (JSON/TSV), eggNOG-mapper (TSV), and KoFamScan (TSV). These inputs are processed through specific conversion steps that map tool-specific metadata and genomic features into a coherent semantic model while preserving provenance information.

In the final stages, the generated Turtle (TTL) files are transformed into Header Dictionary Triples (HDT) format and compressed. This results in a compact, query-optimized representation of the genome annotations suitable for semantic web applications. The source code and additional CWL components can be found in the [M-UNLOCK GitLab repository](https://gitlab.com/m-unlock/cwl) and on [WorkflowHub](https://workflowhub.eu/workflows/1174).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| genome_fasta | FASTA input file | File? | Genome sequence in FASTA format |
| embl_file |  | File? |  |
| identifier | Identifier | string | Identifier of the sample being converted |
| codon_table | Codon table | int | The codon table used for gene prediction |
| interproscan_output | InterProScan output | File? | InterProScan output file. JSON or TSV (optional) |
| kofamscan_output | kofamscan output | File? | KoFamScan / KoFamKOALA output file. detail-tsv (optional) |
| kofamscan_limit | SAPP kofamscan filter | int? | Limit the number of hits per locus tag to be converted (0=no limit) (optional). Default 0 |
| eggnog_output | eggnog-mapper output | File? | eggnog-mapper output file. Annotations tsv file (optional) |
| threads |  | int? |  |
| destination | Output Destination | string? | Output destination used for cwl-prov reporting. |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| genome_conversion | genome_conversion |  |
| embl_conversion | embl_conversion |  |
| sapp_kofamscan | sapp_kofamscan |  |
| sapp_interproscan | sapp_interproscan |  |
| sapp_eggnog | sapp_eggnog |  |
| turtle_to_hdt | turtle_to_hdt |  |
| compress_hdt | compress_hdt |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| hdt_file |  | File | Output directory |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1174
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
