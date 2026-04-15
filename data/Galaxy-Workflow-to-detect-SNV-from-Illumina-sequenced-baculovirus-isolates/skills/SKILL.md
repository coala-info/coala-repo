---
name: workflow-to-detect-snv-from-illumina-sequenced-baculovirus-i
description: This Galaxy workflow identifies single nucleotide variants in baculovirus isolates by processing Illumina sequencing data and NCBI reference genomes using BWA-MEM and bcftools. Use this skill when you need to characterize genetic diversity, identify specific mutations, or analyze intra-isolate variation within Baculoviridae populations.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow-to-detect-snv-from-illumina-sequenced-baculovirus-i

## Overview

This Galaxy workflow is designed to identify Single Nucleotide Variants (SNVs) in baculovirus isolates sequenced via Illumina platforms. It automates the entire bioinformatic pipeline, from raw data acquisition to variant visualization, specifically tailored for the genomic analysis of the *Baculoviridae* family and related viruses like Naldavirus.

The process begins by downloading reference sequences and raw sequencing reads directly from NCBI and the SRA. The workflow performs essential preprocessing, including quality trimming with [Trim Galore!](https://github.com/FelixKrueger/TrimGalore) and dataset management. Cleaned reads are then aligned to the reference genome using [BWA-MEM](https://github.com/lh3/bwa) to ensure accurate mapping for downstream variant detection.

Variant calling is executed using the [bcftools](https://samtools.github.io/bcftools/) suite, specifically utilizing `mpileup` and `call` to pinpoint SNV positions. The resulting VCF files are transformed into tab-delimited tables and undergo several rounds of filtering and text reformatting via `awk` and other text processing tools to isolate high-confidence variants and specific allele frequencies.

In the final stages, the workflow generates multiple scatterplots using [ggplot2](https://ggplot2.tidyverse.org/) to visualize SNV distribution and specificity. This provides researchers with both structured tabular data and graphical summaries of the viral population's genetic diversity. The workflow is available under the [MIT License](https://opensource.org/licenses/MIT) and is tagged for use within the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/).

## Inputs and data preparation

_None listed._


Ensure your input data consists of valid NCBI accessions for the reference genome and SRA run identifiers for the Illumina reads, as the workflow automates the download process. For local data, provide reference sequences in FASTA format and raw reads as fastqsanger or fastqsanger.gz, ideally organized into paired-end collections to streamline the mapping and variant calling steps. Consult the README.md for comprehensive details on parameter tuning and specific filtering thresholds used for baculovirus SNV detection. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | NCBI Accession Download | toolshed.g2.bx.psu.edu/repos/iuc/ncbi_acc_download/ncbi_acc_download/0.2.8+galaxy0 | Exactly one reference genome. |
| 1 | Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fastq_dump/3.1.1+galaxy1 | Provide a dataset list of paired (forward and reverse) reads in fastq format. |
| 2 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 | NCBI Download accepts multiple accession numbers and creates a list as output. Therefore, the Fasta files can contain multiple records. For this analysis just one reference genome is required and the list needs to be converted into one file. |
| 3 | Trim Galore! | toolshed.g2.bx.psu.edu/repos/bgruening/trim_galore/trim_galore/0.6.7+galaxy0 |  |
| 4 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/9.3+galaxy1 | Provide a descriptive and unique name for the reference sequence. |
| 5 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.18 |  |
| 6 | bcftools mpileup | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_mpileup/bcftools_mpileup/1.15.1+galaxy4 |  |
| 7 | bcftools call | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_call/bcftools_call/1.15.1+galaxy5 |  |
| 8 | VCFtoTab-delimited: | toolshed.g2.bx.psu.edu/repos/devteam/vcf2tsv/vcf2tsv/1.0.0_rc1+galaxy0 | The VCF is converted to an easier to read table format. |
| 9 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 | The DPR value is further decomposed for each position and isolate and attached to the table. Four additional columns are added to the table: ALLELE, DPR.ALLELE, REL.ALT and REL.ALT.0.05. |
| 10 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/9.3+galaxy1 |  |
| 11 | Filter | Filter1 | In this step the dataset is reduced to the first alternative nucleotide (ALT1) only. |
| 12 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/3.4.0+galaxy1 | A general overview to access the isolates overall heterogeneity/homogeneity. |
| 13 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 | The DPR value is further decomposed for each position and sample and attached to the table. Four additional columns are added to the table: ALLELE, DPR.ALLELE, REL.ALT and REL.ALT.0.05. |
| 14 | Filter | Filter1 |  |
| 15 | Filter | Filter1 |  |
| 16 | Filter | Filter1 |  |
| 17 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/3.4.0+galaxy1 | Creates a ggplot2 SNV plot for each SNV specificity. |
| 18 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/3.4.0+galaxy1 | Creates a ggplot2 SNV plot for each SNV specificity. |
| 19 | Scatterplot with ggplot2 | toolshed.g2.bx.psu.edu/repos/iuc/ggplot2_point/ggplot2_point/3.4.0+galaxy1 | Creates a ggplot2 SNV plot for each SNV specificity. |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | bcftools_call_output | output_file |
| 10 | vcf_table | outfile |
| 11 | vcf_table_ALT1 | out_file1 |
| 13 | vcf_table_ALT1_specificity | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow-to-detect-snv-from-illumina-sequenced-baculovirus-isolates.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow-to-detect-snv-from-illumina-sequenced-baculovirus-isolates.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow-to-detect-snv-from-illumina-sequenced-baculovirus-isolates.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow-to-detect-snv-from-illumina-sequenced-baculovirus-isolates.ga -o job.yml`
- Lint: `planemo workflow_lint workflow-to-detect-snv-from-illumina-sequenced-baculovirus-isolates.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow-to-detect-snv-from-illumina-sequenced-baculovirus-isolates.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)