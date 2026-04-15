---
name: virify
description: This CWL workflow detects, annotates, and classifies viral contigs in metagenomic and metatranscriptomic assemblies using a suite of tools including VirFinder, VirSorter, PPR-Meta, and ViPhOG-based HMM searches. Use this skill when you need to identify viral sequences within complex environmental samples, characterize the taxonomic diversity of a virome, or detect specific RNA viruses in metatranscriptomic data.
homepage: https://www.ebi.ac.uk/metagenomics/
metadata:
  docker_image: "N/A"
---

# virify

## Overview

[VIRify](https://workflowhub.eu/workflows/26) is a pipeline designed for the detection, annotation, and taxonomic classification of viral contigs within metagenomic and metatranscriptomic assemblies. Developed as part of the [MGnify](https://www.ebi.ac.uk/metagenomics/) analysis services, the workflow is implemented in Common Workflow Language (CWL) and is optimized for identifying viral signals in complex environmental samples, including COVID-19 related data.

The workflow follows a multi-stage process to ensure high-confidence viral identification:
*   **Detection:** Initial filtering of contigs followed by parallel execution of VirFinder, VirSorter, and PPR-Meta to identify potential viral sequences.
*   **Annotation:** Prediction of protein-coding genes using Prodigal, followed by functional annotation via `hmmscan`.
*   **Classification:** Taxonomic assignment based on the detection of ViPhOGs (Viral Phylogenetically-informative Orthologous Groups), a set of over 22,000 taxon-specific profile hidden Markov models (HMMs).
*   **Evaluation:** Final results are refined through ratio and e-value evaluations to provide a confident taxonomic lineage for each detected viral contig.

While primarily benchmarked for metagenomics, VIRify can be applied to metatranscriptomic assemblies to detect RNA viruses. Users working with fragmented transcriptomic data should consider higher length thresholds (e.g., >2 kb) during the initial filtering step to reduce false positives and improve the reliability of the ViPhOG-based classification.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| input_fasta_file |  | File |  |
| virsorter_virome |  | boolean | Set this parameter if the input fasta is mostly viral. See: https://github.com/simroux/VirSorter/issues/50  |
| virsorter_data_dir |  | Directory | VirSorter supporting database files.  |
| add_hmms_tsv |  | File | Additonal metadata tsv  |
| hmmscan_database_dir |  | Directory | HMMScan Viral HMM (databases/vpHMM/vpHMM_database). NOTE: it needs to be a full path.  |
| ncbi_tax_db_file |  | File | ete3 NCBITaxa db https://github.com/etetoolkit/ete/blob/master/ete3/ncbi_taxonomy/ncbiquery.py http://etetoolkit.org/docs/latest/tutorial/tutorial_ncbitaxonomy.html This file was manually built and placed in the corresponding path (on databases)  |
| img_blast_database_dir |  | Directory | Downloaded from: https://genome.jgi.doe.gov/portal/IMG_VR/IMG_VR.home.html  |
| mashmap_reference_file |  | File? | MashMap Reference file. Use MashMap to   |
| pprmeta_simg |  | File | PPR-Meta singularity simg file  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| fasta_rename | Filter contigs |  |
| length_filter | Filter contigs | Default lenght 1kb https://github.com/EBI-Metagenomics/emg-virify-scripts/issues/6 |
| virfinder | VirFinder |  |
| virsorter | VirSorter |  |
| pprmeta | PPR-Meta |  |
| parse_pred_contigs | Combine |  |
| prodigal | Prodigal |  |
| hmmscan | hmmscan |  |
| ratio_evalue | ratio evalue ViPhOG |  |
| annotation | ViPhOG annotations |  |
| assign | Taxonomic assign |  |
| krona | krona plots |  |
| fasta_restore_name_hc | Restore fasta names |  |
| fasta_restore_name_lc | Restore fasta names |  |
| fasta_restore_name_pp | Restore fasta names |  |
| imgvr_blast | Blast in a database of viral sequences including metagenomes |  |
| mashmap | MashMap |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| filtered_contigs |  | File |  |
| virfinder_output |  | File |  |
| virsorter_output_fastas |  | File[] |  |
| high_confidence_contigs |  | File? |  |
| low_confidence_contigs |  | File? |  |
| parse_prophages_contigs |  | File? |  |
| high_confidence_faa |  | File? |  |
| low_confidence_faa |  | File? |  |
| prophages_faa |  | File? |  |
| taxonomy_assignations |  | array |  |
| krona_plots |  | array |  |
| krona_plot_all |  | File |  |
| blast_results |  | File[] |  |
| blast_result_filtereds |  | File[] |  |
| blast_merged_tsvs |  | File[] |  |
| mashmap_hits |  | null, array |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/26
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata