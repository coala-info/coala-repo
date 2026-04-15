---
name: proteogenomics-1-database-creation
description: This proteogenomics workflow integrates RNA-seq reads, reference genomes, and protein databases using tools like HISAT2, FreeBayes, and CustomProDB to construct customized FASTA databases. Use this skill when you need to create a comprehensive search database that includes sample-specific variants, indels, and novel transcripts for identifying non-canonical peptides in mass spectrometry data.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# proteogenomics-1-database-creation

## Overview

This Galaxy workflow is designed for proteogenomics research, specifically for generating customized protein sequence databases from RNA-Seq data. By integrating genomic and transcriptomic information, the pipeline enables the identification of sample-specific protein variants that are often absent from standard reference databases. This workflow follows [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) best practices for reproducible bioinformatics.

The process begins by aligning trimmed RNA-Seq reads to a reference genome using [HISAT2](https://daehwankimlab.github.io/hisat2/), followed by variant calling with [FreeBayes](https://github.com/freebayes/freebayes) and transcript assembly via [StringTie](https://ccb.jhu.edu/software/stringtie/). These steps identify Single Amino Acid Variants (SAVs), insertions/deletions (indels), and novel splice junctions. [GffCompare](https://ccb.jhu.edu/software/stringtie/gffcompare.shtml) is then used to annotate these transcripts against known reference structures.

In the final stages, [CustomProDB](https://bioconductor.org/packages/release/bioc/html/customProDB.html) translates the identified genomic variations into potential protein sequences. The workflow merges these custom sequences with standard reference databases, such as UniProt and cRAP (common Repository of Adventitious Proteins), while filtering for unique sequences. The output is a comprehensive FASTA database and associated SQLite mapping files, providing the necessary foundation for downstream tandem mass spectrometry (MS/MS) protein identification.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Trimmed_ref_5000_uniprot_cRAP.fasta | data_input |  |
| 1 | FASTQ_ProB_22LIST.fastqsanger | data_input |  |
| 2 | Reference Annotation | data_input |  |
| 3 | Reference Genome | parameter_input |  |
| 4 | Reference Genome Annotation for CustomProDB | parameter_input |  |


Ensure your RNA-seq reads are in `fastqsanger` format and that your reference genome and GTF annotations are compatible with the specific requirements of CustomProDB and HISAT2. While reference files are typically handled as individual datasets, organizing your sequencing reads into a dataset collection will streamline the mapping and variant calling steps. Please consult the `README.md` for comprehensive instructions on preparing the reference database and specific metadata requirements. You can also use `planemo workflow_job_init` to create a `job.yml` for managing these inputs programmatically.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.1 |  |
| 6 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.5+galaxy0 |  |
| 7 | HISAT2 | toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.2.1+galaxy1 |  |
| 8 | FreeBayes | toolshed.g2.bx.psu.edu/repos/devteam/freebayes/freebayes/1.3.9+galaxy0 |  |
| 9 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.3+galaxy0 |  |
| 10 | CustomProDB | toolshed.g2.bx.psu.edu/repos/galaxyp/custom_pro_db/custom_pro_db/1.22.0 |  |
| 11 | GffCompare | toolshed.g2.bx.psu.edu/repos/iuc/gffcompare/gffcompare/0.12.6+galaxy0 |  |
| 12 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |
| 13 | SQLite to tabular | toolshed.g2.bx.psu.edu/repos/iuc/sqlite_to_tabular/sqlite_to_tabular/3.2.1 |  |
| 14 | SQLite to tabular | toolshed.g2.bx.psu.edu/repos/iuc/sqlite_to_tabular/sqlite_to_tabular/3.2.1 |  |
| 15 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 |  |
| 16 | Convert gffCompare annotated GTF to BED | toolshed.g2.bx.psu.edu/repos/galaxyp/gffcompare_to_bed/gffcompare_to_bed/0.2.1 |  |
| 17 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.1 |  |
| 18 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 19 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 20 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.1 |  |
| 21 | Translate BED transcripts | toolshed.g2.bx.psu.edu/repos/galaxyp/translate_bed/translate_bed/0.1.0 |  |
| 22 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 23 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |
| 24 | Concatenate multiple datasets | toolshed.g2.bx.psu.edu/repos/artbio/concatenate_multiple_datasets/cat_multi_datasets/1.4.3 |  |
| 25 | bed to protein map | toolshed.g2.bx.psu.edu/repos/galaxyp/bed_to_protein_map/bed_to_protein_map/0.2.0 |  |
| 26 | Tabular-to-FASTA | toolshed.g2.bx.psu.edu/repos/devteam/tabular_to_fasta/tab2fasta/1.1.1 |  |
| 27 | Concatenate multiple datasets | toolshed.g2.bx.psu.edu/repos/artbio/concatenate_multiple_datasets/cat_multi_datasets/1.4.3 |  |
| 28 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |
| 29 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | Reference Annotation fixed.gtf | outfile |
| 7 | HISAT_Output.BAM | output_alignments |
| 9 | Stringtie_output.gtf | output_gtf |
| 11 | transcripts_annotated | transcripts_annotated |
| 12 | Merged and Filtered FASTA from CustomProDB | output |
| 13 | genomic_mapping_sqlite | query_results |
| 14 | variant_annotation_sqlite | query_results |
| 18 | SAV_INDEL | out_file1 |
| 19 | variant_annotation | out_file1 |
| 21 | Translate cDNA_minus_CDS | translation_bed |
| 23 | Variant_annotation_sqlitedb | sqlitedb |
| 26 | CustomProDB Merged Fasta | output |
| 27 | Genomic_Protein_map | out_file1 |
| 28 | Uniprot_cRAP_SAV_indel_translatedbed | output |
| 29 | genomic_mapping_sqlitedb | sqlitedb |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-mouse-rnaseq-dbcreation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-mouse-rnaseq-dbcreation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-mouse-rnaseq-dbcreation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-mouse-rnaseq-dbcreation.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-mouse-rnaseq-dbcreation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-mouse-rnaseq-dbcreation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)