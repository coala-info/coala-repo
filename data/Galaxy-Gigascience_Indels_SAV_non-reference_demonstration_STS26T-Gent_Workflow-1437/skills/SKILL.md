---
name: gigascience_indels_sav_non-reference_demonstration_sts26t-ge
description: This workflow processes RNA-Seq reads and reference GTF data using HISAT2, StringTie, FreeBayes, and CustomProDB to generate a non-reference protein database containing single amino acid variants and indels. Use this skill when you need to identify neoantigens or create customized protein databases from transcriptomic data for proteogenomic discovery in tools like FragPipe.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# gigascience_indels_sav_non-reference_demonstration_sts26t-ge

## Overview

This Galaxy workflow is designed to generate a comprehensive non-reference protein database for neoantigen discovery using the FragPipe platform. By integrating RNA-Seq data with reference genomic information, the pipeline identifies single nucleotide variants (SNVs), insertions/deletions (Indels), and novel transcript isoforms to build a customized search space for proteogenomic analysis.

The process begins by aligning RNA-Seq reads to the GRCh38 reference genome using [HISAT2](https://toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.2.1+galaxy1) and assembling transcripts with [StringTie](https://toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.3+galaxy0). Variant calling is performed via [FreeBayes](https://toolshed.g2.bx.psu.edu/repos/devteam/freebayes/freebayes/1.3.6+galaxy0) to detect sample-specific mutations. These outputs are then processed by [CustomProDB](https://toolshed.g2.bx.psu.edu/repos/galaxyp/custom_pro_db/custom_pro_db/1.22.0), which translates the identified genomic variations into potential protein sequences.

In the final stages, the workflow performs extensive data transformation and filtering to annotate variants and novel transcripts. It utilizes tools like [GffCompare](https://toolshed.g2.bx.psu.edu/repos/iuc/gffcompare/gffcompare/0.12.6+galaxy0) and various regex utilities to refine the protein mappings. The end result is a merged FASTA database containing reference sequences, cRAP contaminants, and non-reference peptides (SNVs, Indels, and RPKM-validated transcripts) ready for mass spectrometry discovery workflows.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Homo_sapiens.GRCh38_canon.106.gtf | data_input | Human reference genome #!genome-build GRCh38.p13 #!genome-version GRCh38 #!genome-date 2013-12 #!genome-build-accession GCA_000001405.28 #!genebuild-last-updated 2021-11 |
| 1 | RNA-Seq_Reads_2.fastq | data_input | Second data set of RNA-seq data |
| 2 | RNA-Seq_Reads_1.fastq | data_input | First data set of RNA-seq data |
| 3 | HUMAN-Uniprot-and-isoforms_and_cRAP-FASTA-Database | data_input | HUMAN Uniprot+isoforms and cRAP FASTA database |


Ensure all primary inputs are correctly formatted, specifically using GTF for genome annotations, FASTQ for RNA-Seq reads, and FASTA for the reference protein database. While this workflow processes individual datasets, you may consider using dataset collections for the paired-end RNA-Seq reads to streamline the HISAT2 alignment step. For comprehensive configuration details and parameter settings, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Convert compressed file to uncompressed. | CONVERTER_gz_to_uncompressed | Uncompressed_RNA_Seq_Reads_2 |
| 5 | Convert compressed file to uncompressed. | CONVERTER_gz_to_uncompressed | Uncompressed_RNA_Seq_Reads_1 |
| 6 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 | Convert_HUMAN_Uniprot_and_CRAP_FASTA_to_tabular |
| 7 | HISAT2 | toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.2.1+galaxy1 | HISAT2_Alignment_BAM |
| 8 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.1 | Filtering_HUMAN_Uniprot_and_cRAP_Accessions_tabular |
| 9 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.3+galaxy0 | StringTie_Alignment_GTF |
| 10 | FreeBayes | toolshed.g2.bx.psu.edu/repos/devteam/freebayes/freebayes/1.3.6+galaxy0 | FreeBayes_variants_VCF |
| 11 | GffCompare | toolshed.g2.bx.psu.edu/repos/iuc/gffcompare/gffcompare/0.12.6+galaxy0 | GffCompare_Annotated_Transcripts_GTF |
| 12 | CustomProDB | toolshed.g2.bx.psu.edu/repos/galaxyp/custom_pro_db/custom_pro_db/1.22.0 | CustomProDB to generate protein FASTAs from BAM and VCF files |
| 13 | Convert gffCompare annotated GTF to BED | toolshed.g2.bx.psu.edu/repos/galaxyp/gffcompare_to_bed/gffcompare_to_bed/0.2.1 | GffCompare_Annotated_GTF_to_BED |
| 14 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 | Convert_INDEL_FASTA_to_tabular |
| 15 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 | Convert-SNV_FASTA_to_tabular |
| 16 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 | Convert-RPKM_FASTA_to_tabular |
| 17 | SQLite to tabular | toolshed.g2.bx.psu.edu/repos/iuc/sqlite_to_tabular/sqlite_to_tabular/2.0.0 | Converting_Genomic_SQLite_to_database_mode |
| 18 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 | Converting_CustomProDB_FASTA_to_tabular |
| 19 | SQLite to tabular | toolshed.g2.bx.psu.edu/repos/iuc/sqlite_to_tabular/sqlite_to_tabular/2.0.0 | Converting_Variant_SQLite_to_database_mode |
| 20 | Translate BED transcripts | toolshed.g2.bx.psu.edu/repos/galaxyp/translate_bed/translate_bed/0.1.0 | Translate_BED_Transcripts |
| 21 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Annotating-INDEL |
| 22 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Annotating-SNV |
| 23 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Annotating-RPKM |
| 24 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Annotating_Genomic_SQLite |
| 25 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.1 | Filtering_RPKM_accessions |
| 26 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 | Annotating_Variant_SQLite |
| 27 | bed to protein map | toolshed.g2.bx.psu.edu/repos/galaxyp/bed_to_protein_map/bed_to_protein_map/0.2.0 | Convert_Translation_BED_to_tabular_for_protein_map |
| 28 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 | Converting_Annotated_Indel_to_FASTA |
| 29 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 | Converting_Annotated_SNV_to_FASTA |
| 30 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 | Converting_Annotated_RPKM_to_FASTA |
| 31 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/9.3+galaxy1 | Not needed for Fragpipe or MaxQuant |
| 32 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 | Variant_input_for_MVP |
| 33 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/9.3+galaxy1 | Concatenate_databases_from_Genomic_SQlite_and_translation_BED_file |
| 34 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 | Merge_Indel_SNV_RPKM_to_make_Non_normal_CustomProDB_FASTA |
| 35 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 | Genomic_input_for_MVP |
| 36 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 | Human + crap + non-reference transcripts dB generation |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Uncompressed_RNA_Seq_Reads_2 | output1 |
| 5 | Uncompressed_RNA_Seq_Reads_1 | output1 |
| 6 | HUMAN_Uniprot_and_CRAP.tabular | output |
| 7 | HISAT2_Alignment_BAM | output_alignments |
| 8 | Filtering_HUMAN_Uniprot_and_cRAP_Accessions_tabular | output |
| 9 | StringTie_Alignment_GTF | output_gtf |
| 10 | FreeBayes_variants_VCF | output_vcf |
| 11 | GffCompare_Annotated_Transcripts_GTF | transcripts_annotated |
| 12 | CustomProDB_INDEL_FASTA | output_indel |
| 12 | CustomProDB_VARIANT_ANNOTATION_RDATA | output_variant_annotation_rdata |
| 12 | CustomProDB_Genomic_SQLlite | output_genomic_mapping_sqlite |
| 12 | CustomProDB_VARIANT_ANNOTATION_SQLite | output_variant_annotation_sqlite |
| 12 | CustomProDB_RPKM_FASTA | output_rpkm |
| 12 | CustomProDB_SNV_FASTA | output_snv |
| 13 | GffCompare_Annotated_GTF_to_BED | output |
| 14 | CustomProDB_INDEL.tabular | output |
| 15 | CustomProDB_SNV.tabular | output |
| 16 | CustomProDB_RPKM.tabular | output |
| 17 | Convert_Genomic_SQLite_to_tabular | query_results |
| 18 | CustomProDB_FASTA_to_tabular | output |
| 19 | Convert_Variant_SQLite_to_tabular | query_results |
| 20 | Translation_FASTA | translation_fasta |
| 20 | Translate_BED_Transcripts | translation_bed |
| 21 | Annotating-INDEL | out_file1 |
| 22 | Annotating-SNV | out_file1 |
| 23 | Annotating-RPKM | out_file1 |
| 24 | Annotating_Genomic_SQLite | out_file1 |
| 25 | Filtering_RPKM_accessions | output |
| 26 | Annotating_Variant_SQLite | out_file1 |
| 27 | Translation_tabular_for_protein_map | output |
| 28 | Converting_Annotated_Indel_to_FASTA | output |
| 29 | Converting_Annotated_SNV_to_FASTA | output |
| 30 | Converting_Annotated_RPKM_to_FASTA | output |
| 31 | Concatenate_HUMAN_Crap_protein-accessions | out_file1 |
| 32 | Variant_input_for_MVP | sqlitedb |
| 33 | Concatenate_databases_from_Genomic_SQlite_and_translation_BED_file | out_file1 |
| 34 | non-reference_CustomProDB_FASTA | output |
| 35 | Genomic_input_for_MVP | sqlitedb |
| 36 | Human_cRAP_Non_normal_transcripts_dB generation | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)