---
name: plant2human-workflow
description: This CWL workflow utilizes Foldseek, EMBOSS, and TogoID to perform structural similarity searches between plant protein sequences and the human proteome using AlphaFold Protein Structure Database data. Use this skill when you need to infer the function of understudied plant genes by identifying human orthologs with high structural similarity despite low sequence conservation.
homepage: https://bonohu.hiroshima-u.ac.jp/index_en.html
metadata:
  docker_image: "N/A"
---

# plant2human-workflow

## Overview

The [plant2human workflow](https://workflowhub.eu/workflows/1206) is a Common Workflow Language (CWL) pipeline designed to identify functional orthologs between plants and humans by comparing protein structures. By leveraging [Foldseek](https://github.com/steineggerlab/foldseek) and the [AlphaFold Protein Structure Database (AFDB)](https://alphafold.ebi.ac.uk/), the workflow enables the discovery of understudied plant genes that share high structural similarity with well-characterized human proteins, even when primary sequence similarity is low.

The process begins with a structural similarity search using `foldseek easy-search`, followed by data extraction steps to isolate human target hits and relevant species metadata. The workflow then retrieves sequences via the [EMBOSS package](https://www.ebi.ac.uk/Tools/psa/) and performs ID conversion through [TogoID](https://togoid.dbcls.jp/). Finally, the pipeline utilizes [Papermill](https://github.com/nteract/papermill) to execute Jupyter notebooks, generating comparative visualizations such as "structural similarity vs. sequence similarity" scatter plots to facilitate functional analysis.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| INPUT_DIRECTORY | input protein structure files directory | Directory | query protein structure file (default: mmCIF) directory for foldseek easy-search input. |
| FILE_MATCH_PATTERN | structure file match pattern | string | file match pattern for listing input files. default: *.cif |
| FOLDSEEK_INDEX | foldseek index files | File | "foldseek index files for foldseek easy-search input. default: ../index/index_swissprot/swissprot Note: At this time (2025/02/02), the process of acquiring and indexing index files for execution has not been incorporated into the workflow. Therefore, we would like you to execute the following commands in advance. example: `foldseek databases Alphafold/Swiss-Prot index_swissprot/swissprot tmp --threads 8` "  |
| OUTPUT_FILE_NAME1 | output file name (foldseek easy-search) | string | output file name for foldseek easy-search result. Currently, this workflow only supports TSV file output. |
| EVALUE | e-value (foldseek easy-search) | double | e-value threshold for foldseek easy-search. workflowdefault: 0.1 |
| ALIGNMENT_TYPE | alignment type (foldseek easy-search) | int | alignment type for foldseek easy-search. default: 2 (3Di + AA: local alignment) for detailed information, see foldseek GitHub repository. |
| THREADS | threads (foldseek easy-search) | int | threads for foldseek easy-search. default: 16 |
| SPLIT_MEMORY_LIMIT | split memory limit (foldseek easy-search) | string | split memory limit for foldseek easy-search. default: 120G |
| OUTPUT_FILE_NAME2 | output file name (extract target species) | string | output file name for extract target species (default: human) python script. |
| WF_COLUMN_NUMBER_QUERY_SPECIES | column number of query species | int | column number of query species. default: 1 (UniProt ID list) |
| OUTPUT_FILE_NAME_QUERY_SPECIES | output file name (extract query species column) | string | output file name for extract query species column python script. default: foldseek_result_query_species.txt |
| WF_COLUMN_NUMBER_HIT_SPECIES | column number of hit species | int | column number of hit species. default: 2 (UniProt ID list) |
| OUTPUT_FILE_NAME_HIT_SPECIES | output file name (extract hit species column) | string | output file name for extract hit species column python script. default: foldseek_result_hit_species.txt |
| BLAST_INDEX_FILES | blast index files (blastdbcmd) | File | blast index files for blastdbcmd |
| ROUTE_DATASET | route dataset (ID conversion using togoID) | string | route dataset for ID conversion. This operation selects the UniProt ID of the target species (human) for which cross-references exist (final destination is HGNC gene symbol). default: uniprot,ensembl_protein,ensembl_transcript,ensembl_gene,hgnc,hgnc_symbol |
| OUTPUT_FILE_NAME3 | output file name (ID conversion using togoID) | string | output file name for ID conversion. default: foldseek_hit_species_togoid_convert.tsv |
| OUT_NOTEBOOK_NAME | output notebook name (papermill process) | string | output notebook name for papermill.  After the analysis workflow is output, it can be freely customized such as changing the parameter values. default: plant2human_report.ipynb |
| QUERY_IDMAPPING_TSV | query idmapping tsv (papermill process) | File | query idmapping tsv file. Retrieve files in advance. default: rice UniProt ID mapping file |
| QUERY_GENE_LIST_TSV | query gene list tsv (papermill process) | File | query gene list tsv file. Retrieve files in advance. default: rice random gene list |
| FOLDSEEK_RESULT_PARSE_NOTEBOOK | jupyter notebook for parse workflow results | File | jupyter notebook template for parsing workflow results (Stringent Mode) |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| sub_workflow_foldseek_easy_search | foldseek easy-search sub-workflow process | "Execute foldseek easy-search using foldseek using BioContainers docker image. This workflow supports only TSV file output. Step 1: listing files Step 2: foldseek easy-search process"  |
| extract_target_species | extract target species (human) process | Extract target species (human) from foldseek easy-search result. execute: ../Tools/12_extract_target_species.cwl |
| extract_query_species_column | extract query species column process | Extract query species column (UniProt ID list) from foldseek easy-search result. execute: ../Tools/13_extract_id.cwl |
| extract_hit_species_column | extract hit species column process | Extract hit species column (UniProt ID list) from foldseek easy-search result. execute: ../Tools/13_extract_id.cwl |
| sub_workflow_retrieve_sequence_query_species | retrieve sequence sub-workflow process using EMBOSS package | "Perform pairwise alignment of protein sequences for pairs identified by structural similarity search. Step 1: blastdbcmd: ../Tools/14_blastdbcmd.cwl Step 2: seqretsplit: ../Tools/15_seqretsplit.cwl Step 3: needle (Global alignment): ../Tools/16_needle.cwl Step 4: water (Local alignment): ../Tools/16_water.cwl "  |
| togoid_convert | togoid convert process | retrieve UniProt ID to HGNC gene symbol using togoID python script. execute: ../Tools/17_togoid_convert.cwl |
| papermill | papermill process | output notebook using papermill. This process allows you to create a scatter plot of structural similarity vs. sequence similarity. execute: ../Tools/18_papermill.cwl |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| TSVFILE1 | output file (foldseek easy-search result) | File | output file for foldseek easy-search all hit result. |
| TSVFILE2 | output file (extract target species) | File | extract target species foldseek result file. (in this workflow, human result only) |
| IDLIST1 | output file (extract query species column) | File | extract query species column UniProt ID list file. |
| IDLIST2 | output file (extract hit species column) | File | extract hit species column UniProt ID list file. |
| BLASTDBCMD_RESULT1 | blastdbcmd result (query species) | File | blastdbcmd result file for query species. |
| BLASTDBCMD_RESULT2 | blastdbcmd result (hit species) | File | blastdbcmd result file for hit species. |
| LOGFILE1 | logfile (blastdbcmd query species) | File | logfile for blastdbcmd query species. |
| LOGFILE2 | logfile (blastdbcmd hit species) | File | logfile for blastdbcmd hit species. |
| DIR1 | directory (seqretsplit query species) | Directory | directory for seqretsplit query species. |
| FASTA_FILES1 | split fasta files (seqretsplit query species) | File[] | split fasta files using seqretsplit for pairwise sequence alignment. |
| DIR2 | directory (seqretsplit hit species) | Directory | directory for seqretsplit hit species. |
| FASTA_FILES2 | split fasta files (seqretsplit hit species) | File[] | split fasta files using seqretsplit for pairwise sequence alignment. |
| DIR3 | needle result directory | Directory | needle (global alignment) result directory. |
| NEEDLE_RESULT_FILE | needle result file (.needle) | File[] | needle (global alignment) result files. suffix is .needle. |
| DIR4 | water result directory | Directory | water (local alignment) result directory. |
| WATER_RESULT_FILE | water result file (.water) | File[] | water (local alignment) result files. suffix is .water. |
| TSVFILE3 | output file (togoid convert) | File | output file for togoid convert. |
| REPORT_NOTEBOOK | output notebook (papermill) | File | output notebook using papermill. notebook name is `plant2human_report.ipynb`. |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1206
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata