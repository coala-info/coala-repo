---
name: vgp-hifi-phased-assembly-with-hifiasm-and-hic-data
description: "This Galaxy workflow performs phased genome assembly using PacBio HiFi reads, Hi-C data, and Meryl databases with the hifiasm assembler, followed by quality evaluation using BUSCO, Merqury, and QUAST. Use this skill when you need to produce high-fidelity, haplotype-resolved reference genomes for diploid organisms to accurately represent allelic diversity and structural variation."
homepage: https://workflowhub.eu/workflows/318
---

# VGP HiFi phased assembly with hifiasm and HiC data

## Overview

This workflow implements the Vertebrate Genomes Project ([VGP](https://vertebrategenomesproject.org/)) standard for high-quality, phased diploid genome assembly. It utilizes [Hifiasm](https://github.com/chhylp123/hifiasm) to integrate PacBio HiFi long reads with Hi-C data, enabling the generation of chromosome-scale, haplotype-resolved assemblies that distinguish between maternal and paternal lineages.

The pipeline begins by preprocessing Hi-C reads with [Cutadapt](https://cutadapt.readthedocs.io/) and utilizing k-mer databases (Meryl) and [GenomeScope](http://qb.cshl.edu/genomescope/) estimates to guide the assembly process. Hifiasm then performs the primary assembly, generating phased contig graphs which are subsequently converted from GFA to FASTA format for downstream analysis.

Comprehensive quality assessment is integrated into the workflow to validate the assembly. It employs [BUSCO](https://busco.ezlab.bio/) to evaluate gene content completeness, [Merqury](https://github.com/marbl/merqury) for k-mer based consensus quality (QV) and phasing assessment, and [QUAST](http://quast.sourceforge.net/quast) for general assembly statistics. These steps ensure the final outputs meet the rigorous standards required for VGP-level genomic resources.

This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is specifically tagged for **VGP** and **HiFi_assembly** projects. For detailed execution instructions, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Pacbio Reads Collection | data_collection_input | Collection of Long reads in fastq format. |
| 1 | HiC forward reads | data_input |  |
| 2 | HiC reverse reads | data_input |  |
| 3 | Meryl Database | data_input | Database Generated from the "Meryl database creation" workflow. |
| 4 | Genomescope summary dataset | data_input |  |
| 5 | Is genome large (> 100Mp) ? | parameter_input | Quast: Use optimal parameters for evaluation of large genomes. Affects speed and accuracy. In particular, imposes --eukaryote --min-contig 3000 --min-alignment 500 --extensive-mis-size 7000 (can be overridden manually with the corresponding options). In addition, this mode tries to identify misassemblies caused by transposable elements and exclude them from the number of misassemblies. (--large) |


Ensure your PacBio HiFi reads are organized into a list collection of fastq.gz files, while the Hi-C forward and reverse reads should be provided as individual datasets. The Meryl database and GenomeScope summary must be pre-computed to provide the necessary k-mer statistics for hifiasm and Merqury. For large genomes exceeding 100Mb, ensure the corresponding boolean parameter is set to true to optimize resource allocation. Refer to the README.md for comprehensive details on parameter tuning and k-mer preparation. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/3.5+galaxy1 |  |
| 7 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 8 | Hifiasm | toolshed.g2.bx.psu.edu/repos/bgruening/hifiasm/hifiasm/0.16.1+galaxy2 |  |
| 9 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.2 |  |
| 10 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 11 | GFA to FASTA | toolshed.g2.bx.psu.edu/repos/iuc/gfa_to_fa/gfa_to_fa/0.1.2 |  |
| 12 | Convert | Convert characters1 |  |
| 13 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy2 |  |
| 14 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.2.2+galaxy2 |  |
| 15 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy1 |  |
| 16 | Cut | Cut1 |  |
| 17 | Parse parameter value | param_value_from_file |  |
| 18 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.0.2+galaxy3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | Cutadapt on input dataset(s) | out1 |
| 8 | log_file | log_file |
| 8 | hic_balanced_contig_hap1_graph | hic_balanced_contig_hap1_graph |
| 8 | hic_balanced_contig_hap2_graph | hic_balanced_contig_hap2_graph |
| 9 | outfile | outfile |
| 10 | Hifiasm HiC hap2 | out_fa |
| 11 | Hifiasm HiC hap1 | out_fa |
| 13 | busco_sum | busco_sum |
| 13 | summary_image | summary_image |
| 13 | busco_table | busco_table |
| 13 | busco_missing | busco_missing |
| 14 | summary_image | summary_image |
| 14 | busco_table | busco_table |
| 14 | busco_missing | busco_missing |
| 14 | busco_sum | busco_sum |
| 15 | sizes_files | sizes_files |
| 15 | png_files | png_files |
| 15 | stats_files | stats_files |
| 15 | qv_files | qv_files |
| 16 | out_file1 | out_file1 |
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
