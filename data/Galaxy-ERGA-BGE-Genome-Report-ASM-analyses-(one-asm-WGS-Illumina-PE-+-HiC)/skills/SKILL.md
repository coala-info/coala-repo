---
name: erga-bge-genome-report-asm-analyses-one-asm-wgs-illumina-pe
description: "This Galaxy workflow performs comprehensive quality assessment of a genome assembly using NCBI accessions for the assembly, Illumina WGS paired-end reads, and Hi-C data through tools like BUSCO, BlobToolKit, Merqury, and HiCExplorer. Use this skill when you need to generate standardized genome reports for eukaryotic species to validate assembly completeness, identify potential contaminants, and visualize Hi-C contact maps for structural accuracy."
homepage: https://workflowhub.eu/workflows/1103
---

# ERGA-BGE Genome Report ASM analyses (one-asm WGS Illumina PE + HiC)

## Overview

This Galaxy workflow is designed for the European Reference Genome Atlas (ERGA) and Biodiversity Genomics Europe (BGE) initiatives to generate standardized genome assembly reports. It automates the retrieval of genomic data from NCBI, including the assembly itself, Illumina whole-genome sequencing (WGS) paired-end reads, and HiC data using tools like [NCBI Datasets](https://toolshed.g2.bx.psu.edu/repos/iuc/ncbi_datasets/datasets_download_genome/16.20.0+galaxy0) and [SRA Tools](https://toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/3.1.1+galaxy0).

The pipeline performs rigorous quality assessment and assembly evaluation. It utilizes [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.4+galaxy0) for read preprocessing, followed by [BUSCO](https://toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.5.0+galaxy0) for gene completeness and [gfastats](https://toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0) for scaffold metrics. K-mer based evaluations are conducted via [Merqury](https://toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy3), [GenomeScope](https://toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0+galaxy2), and [Smudgeplot](https://toolshed.g2.bx.psu.edu/repos/galaxy-australia/smudgeplot/smudgeplot/0.2.5+galaxy3) to estimate ploidy and assembly consistency.

To identify potential contamination and assess coverage, the workflow integrates [BlobToolKit](https://toolshed.g2.bx.psu.edu/repos/bgruening/blobtoolkit/blobtoolkit/4.0.7+galaxy2) using [BWA-MEM2](https://toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1) alignments and [Diamond](https://toolshed.g2.bx.psu.edu/repos/bgruening/diamond/bg_diamond/2.0.15+galaxy0) searches. Finally, HiC data is processed through [pairtools](https://toolshed.g2.bx.psu.edu/repos/iuc/pairtools_parse/pairtools_parse/1.1.0+galaxy1) and [HiCExplorer](https://toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicplotmatrix/hicexplorer_hicplotmatrix/3.7.2+galaxy0) to generate contact matrices and plots, providing a visual validation of the assembly's scaffolding and chromosomal structure.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Species Taxonomy ID number | parameter_input | Get the NCBI taxonomy number here: https://www.ncbi.nlm.nih.gov/taxonomy |
| 2 | NCBI Genome assembly accession code | parameter_input | Should start with GCA or GCF, e.g.: GCA_963556495.2 |
| 3 | BUSCO Lineage | parameter_input | Choose the (eukaryotic) BUSCO lineage that corresponds to the assembled species, e.g.: mammalia_odb10 |
| 4 | NCBI Illumina WGS PE reads accession code | parameter_input | Comma-separated accession code of the reads. Must start with SRR, DRR or ERR, e.g. SRR925743, ERR343809 |
| 5 | NCBI HiC reads accession code | parameter_input | Comma-separated accession code of the reads. Must start with SRR, DRR or ERR, e.g. SRR925743, ERR343809 |
| 6 | Multiple HiC paired-end files? | parameter_input | IMPORTANT! If you entered more than one accession code, select Yes |
| 7 | Ploidy | parameter_input | Default value: 2 |
| 8 | kmer length | parameter_input | Default value: 21 |
| 9 | Run Smudgeplot? | parameter_input |  |


This workflow primarily requires NCBI accession codes for the genome assembly, Illumina WGS paired-end reads, and Hi-C data to automate data retrieval via SRA and NCBI Datasets. Ensure that the BUSCO lineage and taxonomy ID are correctly specified to match your target organism for accurate ortholog analysis and BlobToolKit filtering. While the workflow handles automated downloads, you can manage complex multi-file Hi-C inputs by organizing them into paired-end collections before execution. For a comprehensive guide on parameter settings and metadata requirements, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/9.3+galaxy1 |  |
| 10 | downloads | lftp |  |
| 11 | NCBI Datasets Genomes | toolshed.g2.bx.psu.edu/repos/iuc/ncbi_datasets/datasets_download_genome/16.20.0+galaxy0 |  |
| 12 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/3.1.1+galaxy0 |  |
| 13 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/3.1.1+galaxy0 |  |
| 14 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 15 | Flatten collection | __FLATTEN__ |  |
| 16 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.4+galaxy0 |  |
| 17 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.4+galaxy0 |  |
| 18 | Extract dataset | __EXTRACT_DATASET__ |  |
| 19 | Flatten collection | __FLATTEN__ |  |
| 20 | BlobToolKit | toolshed.g2.bx.psu.edu/repos/bgruening/blobtoolkit/blobtoolkit/4.0.7+galaxy2 |  |
| 21 | gfastats | toolshed.g2.bx.psu.edu/repos/bgruening/gfastats/gfastats/1.3.6+galaxy0 |  |
| 22 | Diamond | toolshed.g2.bx.psu.edu/repos/bgruening/diamond/bg_diamond/2.0.15+galaxy0 |  |
| 23 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 24 | Busco | toolshed.g2.bx.psu.edu/repos/iuc/busco/busco/5.5.0+galaxy0 |  |
| 25 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 26 | Convert FASTA to fai file | CONVERTER_fasta_to_fai |  |
| 27 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 28 | Merge BAM Files | toolshed.g2.bx.psu.edu/repos/devteam/sam_merge/sam_merge2/1.2.0 |  |
| 29 | Sambamba merge | toolshed.g2.bx.psu.edu/repos/bgruening/sambamba_merge/sambamba_merge/1.0.1+galaxy1 |  |
| 30 | Extract dataset | __EXTRACT_DATASET__ |  |
| 31 | Cut | Cut1 |  |
| 32 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 33 | BlobToolKit | toolshed.g2.bx.psu.edu/repos/bgruening/blobtoolkit/blobtoolkit/4.0.7+galaxy2 |  |
| 34 | BAM/SAM Mapping Stats | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_bam_stat/5.0.3+galaxy0 |  |
| 35 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 36 | bedtools MakeWindowsBed | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_makewindowsbed/2.31.1 |  |
| 37 | Merqury | toolshed.g2.bx.psu.edu/repos/iuc/merqury/merqury/1.3+galaxy3 |  |
| 38 | Meryl | toolshed.g2.bx.psu.edu/repos/iuc/meryl/meryl/1.3+galaxy6 |  |
| 39 | BlobToolKit | toolshed.g2.bx.psu.edu/repos/bgruening/blobtoolkit/blobtoolkit/4.0.7+galaxy2 |  |
| 40 | BlobToolKit | toolshed.g2.bx.psu.edu/repos/bgruening/blobtoolkit/blobtoolkit/4.0.7+galaxy2 |  |
| 41 | Pairtools parse | toolshed.g2.bx.psu.edu/repos/iuc/pairtools_parse/pairtools_parse/1.1.0+galaxy1 |  |
| 42 | Sambamba flagstat | toolshed.g2.bx.psu.edu/repos/bgruening/sambamba_flagstat/sambamba_flagstat/1.0.1+galaxy1 |  |
| 43 | Smudgeplot | toolshed.g2.bx.psu.edu/repos/galaxy-australia/smudgeplot/smudgeplot/0.2.5+galaxy3 |  |
| 44 | GenomeScope | toolshed.g2.bx.psu.edu/repos/iuc/genomescope/genomescope/2.0+galaxy2 |  |
| 45 | Pairtools sort | toolshed.g2.bx.psu.edu/repos/iuc/pairtools_sort/pairtools_sort/1.1.0+galaxy1 |  |
| 46 | Pairtools dedup | toolshed.g2.bx.psu.edu/repos/iuc/pairtools_dedup/pairtools_dedup/1.1.0+galaxy1 |  |
| 47 | Pairtools split | toolshed.g2.bx.psu.edu/repos/iuc/pairtools_split/pairtools_split/1.1.0+galaxy1 |  |
| 48 | cooler csort with tabix | toolshed.g2.bx.psu.edu/repos/lldelisle/cooler_csort_tabix/cooler_csort_tabix/0.8.11+galaxy1 |  |
| 49 | cooler_cload_tabix | toolshed.g2.bx.psu.edu/repos/lldelisle/cooler_cload_tabix/cooler_cload_tabix/0.8.11+galaxy1 |  |
| 50 | hicMergeMatrixBins | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicmergematrixbins/hicexplorer_hicmergematrixbins/3.7.2+galaxy0 |  |
| 51 | hicMergeMatrixBins | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicmergematrixbins/hicexplorer_hicmergematrixbins/3.7.2+galaxy0 |  |
| 52 | hicMergeMatrixBins | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicmergematrixbins/hicexplorer_hicmergematrixbins/3.7.2+galaxy0 |  |
| 53 | hicPlotMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicplotmatrix/hicexplorer_hicplotmatrix/3.7.2+galaxy0 |  |
| 54 | hicPlotMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicplotmatrix/hicexplorer_hicplotmatrix/3.7.2+galaxy0 |  |
| 55 | hicPlotMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicplotmatrix/hicexplorer_hicplotmatrix/3.7.2+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 24 | Busco on input dataset(s): short summary | busco_sum |
| 24 | Busco on input dataset(s): full table | busco_table |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ERGA-BGE_Genome_Report_ASM_analyses_(one-asm_WGS_Illumina_PE___HiC).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ERGA-BGE_Genome_Report_ASM_analyses_(one-asm_WGS_Illumina_PE___HiC).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ERGA-BGE_Genome_Report_ASM_analyses_(one-asm_WGS_Illumina_PE___HiC).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ERGA-BGE_Genome_Report_ASM_analyses_(one-asm_WGS_Illumina_PE___HiC).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ERGA-BGE_Genome_Report_ASM_analyses_(one-asm_WGS_Illumina_PE___HiC).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ERGA-BGE_Genome_Report_ASM_analyses_(one-asm_WGS_Illumina_PE___HiC).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
