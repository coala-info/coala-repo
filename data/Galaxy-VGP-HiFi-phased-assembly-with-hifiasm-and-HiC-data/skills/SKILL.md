---
name: vgp-hifi-phased-assembly-with-hifiasm-and-hic-data
description: This Galaxy workflow performs high-quality de novo genome assembly by integrating PacBio HiFi reads with Hi-C data using hifiasm, followed by comprehensive quality assessment with BUSCO, Merqury, and QUAST. Use this skill when you need to generate chromosome-level, haplotype-phased assemblies for complex diploid genomes to support Vertebrate Genomes Project standards.
homepage: https://usegalaxy.eu
metadata:
  docker_image: "N/A"
---

# vgp-hifi-phased-assembly-with-hifiasm-and-hic-data

## Overview

This Galaxy workflow implements the Vertebrate Genomes Project (VGP) pipeline for high-quality, phased genome assembly using PacBio HiFi reads and Hi-C data. By leveraging [hifiasm](https://toolshed.g2.bx.psu.edu/repos/bgruening/hifiasm/hifiasm/0.16.1+galaxy2), the workflow integrates Hi-C proximity ligation information directly into the assembly graph resolution process, producing highly contiguous and accurate haplotype-resolved assemblies.

The pipeline begins by processing raw Hi-C reads and PacBio collections, utilizing [Cutadapt](https://toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/3.5+galaxy1) for adapter trimming and various text-processing tools to prepare input parameters. It incorporates a Meryl database and GenomeScope summary to estimate genome size and complexity, ensuring the assembly parameters are optimized for the specific organism.

Following the assembly phase, the workflow performs comprehensive quality control and evaluation. It converts GFA graph outputs to FASTA format and runs [BUSCO](https://toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy2) to assess gene content completeness, [Merqury](https://toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy1) for k-mer based evaluation of consensus quality and phasing, and [QUAST](https://toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.0.2+galaxy3) for structural assembly statistics.

This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is tagged for VGP and HiFi_assembly projects. It provides a standardized, reproducible environment for generating reference-grade diploid assemblies.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | HiC reverse reads | data_input |  |
| 1 | Meryl Database | data_input | Database Generated from the "Meryl database creation" workflow. |
| 2 | HiC forward reads | data_input |  |
| 3 | Genomescope summary dataset | data_input |  |
| 4 | Pacbio Reads Collection | data_collection_input | Collection of Long reads in fastq format. |
| 5 | Is genome large (> 100Mp) ? | parameter_input | Quast: Use optimal parameters for evaluation of large genomes. Affects speed and accuracy. In particular, imposes --eukaryote --min-contig 3000 --min-alignment 500 --extensive-mis-size 7000 (can be overridden manually with the corresponding options). In addition, this mode tries to identify misassemblies caused by transposable elements and exclude them from the number of misassemblies. (--large) |


To prepare for this workflow, ensure your PacBio HiFi reads are organized into a data collection, while HiC forward and reverse reads should be uploaded as individual fastq.gz datasets. You must also provide a Meryl database and a GenomeScope summary dataset generated from the same HiFi reads to ensure accurate k-mer analysis and genome size estimation. For large genomes exceeding 100Mb, verify that the corresponding boolean parameter is set correctly to optimize hifiasm performance. Refer to the README.md for comprehensive details on parameter tuning and data preprocessing. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 7 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/3.5+galaxy1 |  |
| 8 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.2 |  |
| 9 | Hifiasm | toolshed.g2.bx.psu.edu/repos/bgruening/hifiasm/hifiasm/0.16.1+galaxy2 |  |
| 10 | Convert | Convert characters1 |  |
| 11 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 12 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 13 | Cut | Cut1 |  |
| 14 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy2 |  |
| 15 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy1 |  |
| 16 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy2 |  |
| 17 | Parse parameter value | param_value_from_file |  |
| 18 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.0.2+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | Cutadapt on input dataset(s) | out1 |
| 8 | outfile | outfile |
| 9 | hic_balanced_contig_hap1_graph | hic_balanced_contig_hap1_graph |
| 9 | hic_balanced_contig_hap2_graph | hic_balanced_contig_hap2_graph |
| 9 | log_file | log_file |
| 11 | Hifiasm HiC hap1 | out_fa |
| 12 | Hifiasm HiC hap2 | out_fa |
| 13 | out_file1 | out_file1 |
| 14 | busco_missing | busco_missing |
| 14 | busco_sum | busco_sum |
| 14 | summary_image | summary_image |
| 14 | busco_table | busco_table |
| 15 | png_files | png_files |
| 15 | sizes_files | sizes_files |
| 15 | qv_files | qv_files |
| 15 | stats_files | stats_files |
| 16 | summary_image | summary_image |
| 16 | busco_sum | busco_sum |
| 16 | busco_missing | busco_missing |
| 16 | busco_table | busco_table |
| 17 | Estimated Genome size | integer_param |
| 18 | quast_tabular | quast_tabular |
| 18 | report_html | report_html |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run hifiasm.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run hifiasm.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run hifiasm.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init hifiasm.ga -o job.yml`
- Lint: `planemo workflow_lint hifiasm.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `hifiasm.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)