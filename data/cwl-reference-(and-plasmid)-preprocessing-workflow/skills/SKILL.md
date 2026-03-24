---
name: reference-and-plasmid-preprocessing-workflow
description: "This bioinformatics workflow processes genomic reference data by fetching GenBank files from NCBI or merging provided plasmid sequences to generate unified FASTA and GFF3 files. Use this skill when preparing comprehensive reference genomes that integrate chromosomal and plasmid sequences for downstream comparative genomics or metabolic modeling."
homepage: https://workflowhub.eu/workflows/1818
---
# reference (and plasmid) preprocessing workflow

## Overview

This Common Workflow Language (CWL) workflow automates the preparation of genomic reference data by consolidating GenBank records and extracting standardized sequence and annotation files. It is designed to handle primary reference genomes alongside optional plasmid sequences, ensuring consistent formatting for downstream bioinformatics pipelines.

The workflow follows a conditional logic based on the provided inputs:
* **Reference Acquisition:** If a local GenBank file is not provided, the workflow fetches the record from NCBI using a specified accession number.
* **Plasmid Integration:** Multiple plasmid GenBank files can be merged into a single entity and subsequently combined with the primary reference genome.
* **Feature Extraction:** From the final consolidated GenBank record, the workflow extracts both a FASTA sequence file and a GFF3 annotation file.

The complete source code for the constituent [tools](https://git.wur.nl/ssb/automated-data-analysis/cwl/-/tree/main/tools) and related [workflows](https://git.wur.nl/ssb/automated-data-analysis/cwl/-/tree/main/workflows) is maintained in the SSB GitLab repository. Additional versioning and metadata can be found on the [WorkflowHub page](https://workflowhub.eu/workflows/1818).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| #main/accession_number | accession number | null, string | accession number, used to download a GenBank file from NCBI, mandatory when not inputting a reference file. |
| #main/fasta_extraction_script | FASTA extraction script | File | Python script that extracts a FASTA file from GenBank Files. Passed externally within the git structure to avoid having to host a new image. |
| #main/gff3_extraction_script | GFF3 extraction script | File | BioPerl script that extracts a GFF3 file from GenBank Files. Passed externally within the git structure to avoid having to host a new image. |
| #main/merging_genbank_script | merging script | File | Python script to merge multiple GenBank Files. Passed externally within the git structure to avoid having to host a new image. |
| #main/plasmids | plasmid file(s) | null, array | Input plasmid GenBank files. |
| #main/reference_file | reference GenBank file | null, File | Reference file in GenBank format. |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| #main/determine_output | determine output | Determines relevant final outputs. |
| #main/extract_fasta | extract FASTA | Extracts FASTA file from input reference file when no plasmids are provided. |
| #main/extract_gff3 | extract GFF3 | Extracts GFF3 annotation file from the (merged) reference. |
| #main/fetch_reference | fetch reference | Downloads the associated GenBank file from the supplied accession number. |
| #main/merge_plasmids | merge plasmids | Merges plasmids when more than one are present. |
| #main/merge_reference | merge plasmid(s) with reference | Merges the plasmid(s) with the reference GenBank file. |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| #main/fasta_final | FASTA output file | File | Final FASTA output file. |
| #main/genbank_final | GenBank output file | File | Final GenBank output file. |
| #main/gff3 | GFF3 output file | File | Final GFF3 output file. |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1818
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
