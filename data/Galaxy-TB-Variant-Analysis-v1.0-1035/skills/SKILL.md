---
name: tb-variant-analysis-v10
description: "This workflow processes Illumina sequence reads and a reference genome to identify Mycobacterium tuberculosis variants and drug resistance profiles using tools like fastp, snippy, Kraken2, and TB-Profiler. Use this skill when you need to characterize genetic diversity, detect lineage-specific mutations, or predict antibiotic susceptibility from clinical or environmental tuberculosis samples."
homepage: https://workflowhub.eu/workflows/1035
---

# TB Variant Analysis v1.0

## Overview

This workflow provides a comprehensive pipeline for analyzing *Mycobacterium tuberculosis* sequence data from Illumina platforms. It automates the process of predicting genetic variants and identifying drug resistance markers by integrating raw read preprocessing, taxonomic classification, and specialized variant calling. Users provide sequencing reads and a reference genome, with the ability to tune parameters for minimum depth of coverage and variant allele frequency.

The analysis begins with quality control and trimming using [fastp](https://github.com/OpenGene/fastp), followed by contamination detection via [Kraken2](https://github.com/DerrickWood/kraken2). Core variant calling is handled by [snippy](https://github.com/tseemann/snippy), while [TB-Profiler](https://github.com/jodyphelan/TB-Profiler) is employed to characterize drug resistance profiles and lineage information. The workflow also incorporates [QualiMap](http://qualimap.conesalab.org/) and [mosdepth](https://github.com/brentp/mosdepth) to assess mapping quality and coverage depth across the genome.

To ensure high-confidence results, the pipeline applies [TB Variant Filter](https://github.com/i-u-c/galaxy-tools/tree/master/tools/tb_variant_filter) to the identified mutations. The final outputs include an annotated VCF file, a consensus genome sequence, and several interactive reports. These include a [MultiQC](https://multiqc.info/) summary and detailed [TB Variant Reports](https://github.com/i-u-c/galaxy-tools/tree/master/tools/tbvcfreport) that visualize drug resistance and variant data for clinical or research interpretation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Reads | data_collection_input | List of paired Illumina reads (set format to fastqsanger or fastqsanger.gz as appropriate) |
| 1 | Reference Genome | data_input | M. tuberculosis reference genome (must be in H37Rv coordinates. The M. tuberculosis inferred ancestral genome is recommended) |
| 2 | Minimum depth of coverage | parameter_input | Minimum depth of coverage for a position on the genome |
| 3 | Minimum variant allele frequency | parameter_input | Minimum proportion of reads that must support a variant for it to be called |
| 4 | Additional BWA-MEM options | parameter_input | Increasing the minimum seed length (-k) parameter can help eliminate matches from contaminants. If used this should be set to 2/3rds of the read length, i.e. the string "-k 100" should be used for 150 base pair reads |


For successful execution, provide Illumina sequencing reads as a paired-end dataset collection and the reference genome in FASTA or GenBank format. Ensure that the minimum depth and allele frequency parameters are calibrated to your specific library prep and sequencing depth. Detailed guidance on parameter selection and input formatting is available in the accompanying README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated or batch job configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.4+galaxy0 |  |
| 6 | seqret | toolshed.g2.bx.psu.edu/repos/devteam/emboss_5/EMBOSS: seqret84/5.0.0 |  |
| 7 | snippy | toolshed.g2.bx.psu.edu/repos/iuc/snippy/snippy/4.6.0+galaxy0 |  |
| 8 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.1+galaxy1 |  |
| 9 | QualiMap BamQC | toolshed.g2.bx.psu.edu/repos/iuc/qualimap_bamqc/qualimap_bamqc/2.2.2c+galaxy1 |  |
| 10 | mosdepth | toolshed.g2.bx.psu.edu/repos/iuc/mosdepth/mosdepth/0.3.8+galaxy0 |  |
| 11 | TB Variant Filter | toolshed.g2.bx.psu.edu/repos/iuc/tb_variant_filter/tb_variant_filter/0.4.0+galaxy0 |  |
| 12 | TB-Profiler Profile | toolshed.g2.bx.psu.edu/repos/iuc/tbprofiler/tb_profiler_profile/6.2.1+galaxy0 |  |
| 13 | TB Variant Filter | toolshed.g2.bx.psu.edu/repos/iuc/tb_variant_filter/tb_variant_filter/0.4.0+galaxy0 |  |
| 14 | Flatten collection | __FLATTEN__ |  |
| 15 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 | bcftools consensus requires a region file of low coverage regions in 1 based coordinates, mosdepth produces one in BED format with LOW and PASS for low coverage and non-low coverage regions. This converts from the one format to the other. |
| 16 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/9.3+galaxy1 |  |
| 17 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 |  |
| 18 | bcftools consensus | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_consensus/bcftools_consensus/1.15.1+galaxy3 | Compute consensus genome with single nucleotide variants inserted, suitable for use in building a phylogeny |
| 19 | TB Variant Report | toolshed.g2.bx.psu.edu/repos/iuc/tbvcfreport/tbvcfreport/1.0.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | output | output |
| 8 | report_output | report_output |
| 12 | output_txt | output_txt |
| 16 | Final annotated VCF | output |
| 17 | html_report | html_report |
| 18 | consensus_genome | output_file |
| 19 | drug_resistance_report_html | drug_resistance_report_html |
| 19 | variants_report_html | variants_report_html |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-TB_Variant_Analysis_v1.0.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-TB_Variant_Analysis_v1.0.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-TB_Variant_Analysis_v1.0.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-TB_Variant_Analysis_v1.0.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-TB_Variant_Analysis_v1.0.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-TB_Variant_Analysis_v1.0.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
