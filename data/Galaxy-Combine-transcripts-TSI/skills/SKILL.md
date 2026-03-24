---
name: combine-transcripts-tsi
description: "This workflow merges multiple tissue-specific transcriptome GTF files using StringTie, extracts sequences with bedtools, and employs CPAT to identify and filter for high-probability coding transcripts. Use this skill when you need to create a unified, high-confidence coding transcriptome from multiple tissue-specific assemblies while filtering out non-coding sequences."
homepage: https://workflowhub.eu/workflows/878
---

# Combine transcripts - TSI

## Overview

This Galaxy workflow integrates multiple tissue-specific transcriptomes into a single, filtered fasta file of coding sequences. It begins by using [StringTie merge](https://toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie_merge/2.2.1+galaxy1) to combine a collection of GTF files into a unified transcriptome, applying specific thresholds for minimum length (-m 30) and minimum input transcript abundance (-F 0.1).

The merged transcriptome is then converted from GTF to BED12 format to facilitate sequence extraction. Using [bedtools getfasta](https://toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_getfastabed/2.30.0+galaxy1), the workflow extracts the corresponding sequences from the provided genome fasta, maintaining strandedness and name attributes.

To ensure the quality of the final output, the workflow employs [CPAT](https://toolshed.g2.bx.psu.edu/repos/bgruening/cpat/cpat/3.0.5+galaxy0) to assess coding probability. The sequences are processed through a series of text transformation and filtering steps to remove non-coding transcripts, resulting in a final dataset of filtered, merged transcriptome sequences in fasta format.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Collection of transcriptome.gtf files | data_collection_input |  |
| 1 | genome.fasta | data_input |  |
| 2 | coding_seqs.fasta | data_input |  |
| 3 | non_coding_seqs.fasta | data_input |  |


Ensure all input transcriptome GTFs are organized into a single data collection to facilitate the StringTie merge process, while the genome and training sequences should be provided as individual FASTA datasets. Verify that your FASTA headers match the chromosome names in the GTF files to prevent errors during the bedtools getfasta step. For automated execution, you can initialize a job template using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter tuning for CPAT and StringTie. Always validate that your coding and non-coding training sets are representative of your target organism for accurate transcript filtering.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | StringTie merge | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie_merge/2.2.1+galaxy1 |  |
| 5 | Convert GTF to BED12 | toolshed.g2.bx.psu.edu/repos/iuc/gtftobed12/gtftobed12/357 |  |
| 6 | bedtools getfasta | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_getfastabed/2.30.0+galaxy1 |  |
| 7 | CPAT | toolshed.g2.bx.psu.edu/repos/bgruening/cpat/cpat/3.0.5+galaxy0 | The table of best probabilities is called orf_seqs_prob_best; converted this to tabular |
| 8 | Filter | Filter1 | skipping 1 header line |
| 9 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy0 |  |
| 10 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/9.3+galaxy0 | part of the headers have become capitalized, this reverts everything after the :: to lowercase. May need to be changed if headers don't have the same format with a :: in them. |
| 11 | Filter sequences by ID | toolshed.g2.bx.psu.edu/repos/peterjc/seq_filter_by_id/seq_filter_by_id/0.2.9 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | out_gtf | out_gtf |
| 5 | bed_file | bed_file |
| 6 | output | output |
| 7 | orf_seqs_prob_best | orf_seqs_prob_best |
| 7 | orf_seqs | orf_seqs |
| 7 | no_orf_seqs | no_orf_seqs |
| 7 | orf_seqs_prob | orf_seqs_prob |
| 8 | out_file1 | out_file1 |
| 11 | output_pos | output_pos |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Combine-transcripts-TSI.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Combine-transcripts-TSI.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Combine-transcripts-TSI.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Combine-transcripts-TSI.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Combine-transcripts-TSI.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Combine-transcripts-TSI.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
