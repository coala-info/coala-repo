---
name: microbial-meta-genome-annotation
description: This Common Workflow Language pipeline performs comprehensive microbial genome and metagenome annotation using fasta sequence inputs and tools including Bakta, KofamScan, InterProScan 5, and eggNOG-mapper. Use this skill when you need to characterize the functional potential of microbial isolates or metagenomic assemblies by identifying genes and assigning biological roles to protein sequences.
homepage: https://m-unlock.com
metadata:
  docker_image: "N/A"
---

# microbial-meta-genome-annotation

## Overview

This CWL workflow provides a comprehensive pipeline for the functional annotation of microbial genomes and metagenomes. It accepts a genomic sequence in FASTA format as the primary input and utilizes [Bakta](https://github.com/oschwengers/bakta) as the core engine for rapid, standardized annotation.

Users can further enrich the annotation by enabling several optional functional analysis components:
* **KofamScan**: For KEGG Ortholog (KO) assignment.
* **InterProScan 5**: For protein domain and family identification.
* **eggNOG-mapper**: For orthology-based functional annotation.

By default, the workflow includes an optional step to convert the resulting annotations into RDF format using the [SAPP conversion workflow](https://workflowhub.eu/workflows/1174/). The complete source code and CWL definitions are maintained in the [m-unlock GitLab repository](https://gitlab.com/m-unlock/cwl).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| threads | Number of threads | int? | Number of threads to use for computational processes. Default 4 |
| genome_fasta | Genome fasta file | File | Genome fasta file used for annotation (required) |
| codon_table | Codon table | int | Codon table 11/4. Default = 11 |
| bakta_db | Bakta DB | Directory? | Bakta database directory (default bakta-db_v5.1-light built in the container) (optional)  |
| metagenome | metagenome | boolean | Run in metagenome mode. Affects only protein prediction. Default false |
| skip_bakta_plot | Skip plot | boolean | Skip Bakta plotting |
| skip_bakta_crispr | Skip bakta CRISPR array prediction using PILER-CR | boolean | Skip CRISPR prediction |
| interproscan_directory | InterProScan 5 directory | Directory? | Directory of the (full) InterProScan 5 program. When not given InterProscan will not run. (optional) |
| interproscan_applications | Interproscan applications | string | Comma separated list of analyses: FunFam,SFLD,PANTHER,Gene3D,Hamap,PRINTS,ProSiteProfiles,Coils,SUPERFAMILY,SMART,CDD,PIRSR,ProSitePatterns,AntiFam,Pfam,MobiDBLite,PIRSF,NCBIfam default Pfam,SFLD,SMART,AntiFam,NCBIfam  |
| eggnog_dbs |  | null, record |  |
| run_kofamscan | Run kofamscan | boolean | Run with KEGG KO KoFamKOALA annotation. Default false |
| kofamscan_limit_sapp | SAPP kofamscan filter | int? | Limit max number of entries of kofamscan hits per locus in SAPP. Default 5 |
| run_eggnog | Run eggNOG-mapper | boolean | Run with eggNOG-mapper annotation. Requires eggnog database files. Default false |
| run_interproscan | Run InterProScan | boolean | Run with eggNOG-mapper annotation. Requires InterProScan v5 program files. Default false |
| compress_output |  | boolean | Compress output files. Default false |
| sapp_conversion |  | boolean | Run SAPP (Semantic Annotation Platform with Provenance) on the annotations. Default true |
| destination | Output Destination (prov only) | string? | Not used in this workflow. Output destination used in cwl-prov reporting only. |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| bakta | Bakta | Bacterial genome annotation tool |
| kofamscan | KofamScan |  |
| interproscan | InterProScan 5 |  |
| eggnogmapper | eggNOG-mapper |  |
| compress_bakta | Compress Bakta |  |
| compressed_other | Compressed other | Compress files when compression is true |
| uncompressed_other | Uncompressed other | Gather files when compression is false |
| workflow_sapp_conversion | workflow_sapp_conversion |  |
| bakta_to_folder | Bakta to folder | Move all Bakta files to a folder |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| bakta_folder |  | Directory |  |
| compressed_other_files |  | File[] |  |
| uncompressed_other_files |  | File[]? |  |
| sapp_hdt_file |  | File? |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1170
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata