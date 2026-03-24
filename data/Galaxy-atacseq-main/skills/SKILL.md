---
name: atacseq
description: "This workflow processes paired-end ATAC-seq fastq collections through adapter trimming with Cutadapt, Bowtie2 alignment, and rigorous filtering of mitochondrial reads and PCR duplicates before performing MACS2 peak calling and coverage normalization. Use this skill when you need to identify regions of open chromatin, analyze fragment length distributions, and generate normalized bigwig files for epigenetic profiling across a reference genome."
homepage: https://workflowhub.eu/workflows/399
---

# ATACseq

## Overview

This ATACseq workflow provides a comprehensive pipeline for processing paired-end fastq data, closely following the [Galaxy Training Network tutorial](https://training.galaxyproject.org/training-material/topics/epigenetics/tutorials/atac-seq/tutorial.html). It begins with quality control and adapter trimming using Cutadapt, followed by end-to-end mapping with Bowtie2. The pipeline is specifically configured to handle ATAC-seq requirements, such as allowing dovetail alignments and fragment lengths up to 1kb.

Post-alignment, the workflow applies rigorous filtering to ensure data quality, removing mitochondrial reads, unconcordant pairs, and reads with a mapping quality below 30. PCR duplicates are identified and removed via Picard MarkDuplicates. Peak calling is then performed using MACS2, which identifies narrow peaks and generates coverage files. The workflow further processes these results to identify summits and count reads within 1kb regions centered on those summits.

To facilitate comparative analysis, the workflow generates bigWig files using two normalization methods: total million reads and million reads in peaks. It also produces essential quality control metrics, including a fragment length histogram and a comprehensive MultiQC report. For detailed instructions on configuring input parameters such as effective genome size and reference selection, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | PE fastq input | data_collection_input | Should be a paired collection with ATAC-seq fastqs |
| 1 | reference_genome | parameter_input | reference_genome |
| 2 | effective_genome_size | parameter_input | Used by macs2:\nH. sapiens: 2700000000, M. musculus: 1870000000, D. melanogaster: 120000000, C. elegans: 90000000 |
| 3 | bin_size | parameter_input | Bin size for normalized bigwig (usually 50bp is sufficient) |


To ensure successful execution, provide your paired-end sequencing reads as a paired dataset collection of fastqsanger files. You must select a reference genome that is consistently indexed for both Bowtie2 and bedtools SlopBed, while manually specifying the effective genome size and desired bin size for coverage normalization. For high-resolution bigWig outputs, use a smaller bin size, though this will increase file size and processing time. Detailed configuration for these parameters and specific genome availability can be found in the README.md. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/4.9+galaxy1 |  |
| 5 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.3+galaxy1 |  |
| 6 | Filter BAM | toolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/bamFilter/2.5.2+galaxy2 |  |
| 7 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.5 |  |
| 8 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/3.1.1.0 |  |
| 9 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 10 | bedtools BAM to BED | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_bamtobed/2.31.1+galaxy0 |  |
| 11 | Paired-end histogram | toolshed.g2.bx.psu.edu/repos/iuc/pe_histogram/pe_histogram/1.0.1 |  |
| 12 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.20+galaxy3 |  |
| 13 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.2.9.1+galaxy0 |  |
| 14 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.3+galaxy1 |  |
| 15 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 16 | Wig/BedGraph-to-bigWig | wig_to_bigWig |  |
| 17 | bedtools SlopBed | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_slopbed/2.31.1+galaxy0 |  |
| 18 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.3+galaxy1 |  |
| 19 | Parse parameter value | param_value_from_file |  |
| 20 | Apply rules | __APPLY_RULES__ |  |
| 21 | bedtools MergeBED | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_mergebed/2.31.1 |  |
| 22 | bigwigAverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bigwig_average/deeptools_bigwig_average/3.5.4+galaxy0 |  |
| 23 | bedtools Compute both the depth and breadth of coverage | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_coveragebed/2.31.1+galaxy0 |  |
| 24 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 25 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 26 | Concatenate datasets | cat1 |  |
| 27 | Parse parameter value | param_value_from_file |  |
| 28 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 29 | bigwigAverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bigwig_average/deeptools_bigwig_average/3.5.4+galaxy0 | Isolate each bigwig do normalize not average |
| 30 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.24.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | mapping stats | mapping_stats |
| 8 | MarkDuplicates metrics | metrics_file |
| 8 | BAM filtered rmDup | outFile |
| 11 | histogram of fragment length | output1 |
| 13 | MACS2 narrowPeak | output_narrowpeaks |
| 16 | Coverage from MACS2 (bigwig) | out_file1 |
| 18 | MACS2 report | output |
| 21 | 1kb around summits | output |
| 22 | bigwig_norm | outFileName |
| 24 | Nb of reads in summits +-500bp | outfile |
| 29 | bigwig_norm2 | outFileName |
| 30 | MultiQC webpage | html_report |
| 30 | MultiQC on input dataset(s): Stats | stats |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run atacseq.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run atacseq.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run atacseq.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init atacseq.ga -o job.yml`
- Lint: `planemo workflow_lint atacseq.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `atacseq.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
