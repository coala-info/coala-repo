---
name: influenza-a-isolate-subtyping-and-consensus-sequence-generat
description: This workflow performs subtyping and consensus sequence generation for batches of Illumina paired-end Influenza A isolates by using VAPOR, bwa-mem, and iVar to identify and map reads against the best-matching reference segments. Use this skill when you need to determine HA/NA subtypes, generate high-quality consensus genomes from variable viral samples, and perform phylogenetic analysis or SNP visualization across multiple influenza isolates.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# influenza-a-isolate-subtyping-and-consensus-sequence-generat

## Overview

This workflow automates the subtyping and consensus sequence generation for batches of Illumina paired-end sequenced Influenza A isolates. To address the high genomic variability of the virus, it utilizes [VAPOR](https://github.com/connor-lab/vapor) to identify the most suitable reference sequences for each of the eight viral segments from a provided collection. This approach ensures that read mapping is performed against the most relevant genetic background for each specific sample, overcoming the limitations of using a single static reference.

The technical pipeline integrates several industry-standard tools: [fastp](https://github.com/OpenGene/fastp) for read preprocessing, [bwa mem](https://github.com/lh3/bwa) for mapping against the dynamically compiled references, and [ivar consensus](https://andersen-lab.github.io/ivar/html/manualpage.html) for generating final sequences. For batch-level analysis, the workflow employs [MAFFT](https://mafft.cbrc.jp/alignment/software/) for multiple sequence alignment, alongside [Snipit](https://github.com/aineniamh/snipit) and [IQ-Tree](http://www.iqtree.org/) to visualize genetic differences and reconstruct phylogenetic relationships.

Users receive comprehensive outputs including subtyping reports (focused on HA and NA genes), per-segment consensus sequences, and detailed QC metrics from QualiMap. For specific details on required FASTA header formatting and input collection structures, please refer to the [README.md](#) in the Files section. This tool is licensed under AGPL-3.0-or-later and is optimized for avian influenza virus (AIV) research and virology surveillance.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | References per segment collection | data_collection_input | A collection of influenza A reference sequences organized by segment |
| 1 | Sequenced paired-end data | data_collection_input | Paired collection of forward and reverse reads of the sequenced isolate |


This workflow requires a paired-end collection of Illumina reads and a list of FASTA datasets representing each Influenza genome segment. Ensure all reference FASTA headers strictly follow the `>[segment]|[type]/[host]/[region]/[ID]/[year]|subtype|[accession]` format, as colons or the presence of "N" ambiguity symbols will cause errors. Using a list of datasets for references allows VAPOR to identify the best-matching segment for each sample before mapping. For comprehensive details on formatting requirements and available reference collections, refer to the README.md. You can use `planemo workflow_job_init` to generate a `job.yml` for local execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/9.5+galaxy3 |  |
| 3 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 4 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 5 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.1.0+galaxy0 |  |
| 6 | Line/Word/Character count | wc_gnu |  |
| 7 | Line/Word/Character count | wc_gnu |  |
| 8 | Unzip collection | __UNZIP_COLLECTION__ |  |
| 9 | Parse parameter value | param_value_from_file |  |
| 10 | Parse parameter value | param_value_from_file |  |
| 11 | Duplicate file to collection | __DUPLICATE_FILE_TO_COLLECTION__ |  |
| 12 | Duplicate file to collection | __DUPLICATE_FILE_TO_COLLECTION__ |  |
| 13 | Duplicate file to collection | __DUPLICATE_FILE_TO_COLLECTION__ |  |
| 14 | Apply rules | __APPLY_RULES__ |  |
| 15 | Relabel identifiers | __RELABEL_FROM_FILE__ |  |
| 16 | VAPOR | toolshed.g2.bx.psu.edu/repos/iuc/vapor/vapor/1.0.3+galaxy0 |  |
| 17 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 18 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy3 |  |
| 19 | Select first | Show beginning1 |  |
| 20 | seqtk_subseq | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_subseq/1.5+galaxy0 |  |
| 21 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 22 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 23 | Select | Grep1 |  |
| 24 | Select | Grep1 |  |
| 25 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy3 |  |
| 26 | Paste | Paste1 |  |
| 27 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.19 |  |
| 28 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 29 | Filter failed datasets | __FILTER_FAILED_DATASETS__ | bwa mem will fail if no reference for any segment got suggested by vapor, i.e. the reference genome is empty. In that case, we need to skip further analysis of the sample. |
| 30 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy3 |  |
| 31 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.22+galaxy1 |  |
| 32 | Split BAM by reference | toolshed.g2.bx.psu.edu/repos/iuc/bamtools_split_ref/bamtools_split_ref/2.5.2+galaxy2 |  |
| 33 | QualiMap BamQC | toolshed.g2.bx.psu.edu/repos/iuc/qualimap_bamqc/qualimap_bamqc/2.3+galaxy0 |  |
| 34 | Apply rules | __APPLY_RULES__ |  |
| 35 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 36 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 37 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy3 |  |
| 38 | Relabel identifiers | __RELABEL_FROM_FILE__ |  |
| 39 | Apply rules | __APPLY_RULES__ |  |
| 40 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 41 | ivar consensus | toolshed.g2.bx.psu.edu/repos/iuc/ivar_consensus/ivar_consensus/1.4.4+galaxy0 |  |
| 42 | Line/Word/Character count | wc_gnu |  |
| 43 | Apply rules | __APPLY_RULES__ |  |
| 44 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 45 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 46 | Filter | Filter1 |  |
| 47 | Filter | Filter1 |  |
| 48 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy3 |  |
| 49 | Cut | Cut1 |  |
| 50 | Cut | Cut1 |  |
| 51 | Filter collection | __FILTER_FROM_FILE__ |  |
| 52 | MAFFT | toolshed.g2.bx.psu.edu/repos/rnateam/mafft/rbc_mafft/7.526+galaxy2 |  |
| 53 | Filter collection | __FILTER_FROM_FILE__ |  |
| 54 | snipit | toolshed.g2.bx.psu.edu/repos/iuc/snipit/snipit/1.7+galaxy0 |  |
| 55 | IQ-TREE | toolshed.g2.bx.psu.edu/repos/iuc/iqtree/iqtree/2.4.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | fastp reports | report_html |
| 5 | fastp-processed paired collection | output_paired_coll |
| 17 | successful VAPOR runs - closest references | output |
| 25 | Hybrid reference genomes used for mapping | outfile |
| 30 | Subtyping results | outfile |
| 31 | Final read mapping_results | outputsam |
| 33 | QC reports for mapping results | output_html |
| 41 | Per-sample consensus sequences | consensus |
| 48 | Per-segment consensus sequences with samples combined | outfile |
| 52 | Multiple sequence alignments per segment | outputAlignment |
| 54 | Snipit plots per segment | snp_plot |
| 55 | IQ-Tree per-segment report | iqtree |
| 55 | IQ-Tree per-segment ML distance matrix | mldist |
| 55 | IQ-Tree per-segment ML tree | treefile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run influenza-consensus-and-subtyping.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run influenza-consensus-and-subtyping.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run influenza-consensus-and-subtyping.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init influenza-consensus-and-subtyping.ga -o job.yml`
- Lint: `planemo workflow_lint influenza-consensus-and-subtyping.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `influenza-consensus-and-subtyping.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)