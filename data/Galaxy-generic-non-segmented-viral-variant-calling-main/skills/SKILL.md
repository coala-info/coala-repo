---
name: variant-calling-and-consensus-construction-from-paired-end-s
description: "This workflow performs variant calling and consensus sequence generation for non-segmented viruses from Illumina paired-end data using fastp, BWA-MEM, iVar, and SnpEff. Use this skill when you need to identify genomic variants, annotate their functional effects, and reconstruct consensus genomes for viral isolates like Morbilliviruses using either ampliconic or non-ampliconic sequencing approaches."
homepage: https://workflowhub.eu/workflows/1876
---

# Variant calling and consensus construction from paired end short read data of non-segmented viral genomes

## Overview

This Galaxy workflow provides an automated pipeline for variant calling and consensus sequence generation from Illumina paired-end (PE) reads of non-segmented viruses with stable genome structures, such as Morbilliviruses. It is designed to handle both ampliconic and non-ampliconic sequencing data. If an optional primer scheme is provided, the workflow automatically performs primer trimming and filters reads mapping beyond amplicon boundaries using [ivar trim](https://andersen-lab.github.io/ivar/html/manualpage.html).

The analysis begins with preprocessing via [fastp](https://github.com/OpenGene/fastp) and mapping to a reference genome using [BWA-MEM](http://bio-bwa.sourceforge.net/). Mapped reads are filtered for quality and realigned around indels using [Lofreq](https://csb5.github.io/lofreq/). Variant calling and consensus construction are performed in parallel by [iVar](https://andersen-lab.github.io/ivar/html/manualpage.html), with functional annotations added by [SnpEff](https://pcingola.github.io/SnpEff/) based on a user-provided reference annotation.

Comprehensive quality control is integrated throughout the process, utilizing [Samtools stats](http://www.htslib.org/doc/samtools-stats.html), [Qualimap BamQC](http://qualimap.genesilico.pl/), and [MultiQC](https://multiqc.info/) to aggregate results. The workflow outputs include per-sample and combined consensus genomes, annotated VCF files, and a flattened tabular variant report for batch analysis. Users should ensure that the reference genome, annotation, and primer scheme are perfectly synchronized to avoid misannotation or tool failures.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Paired collection of sequencing data | data_collection_input | The PE sequencing data for your batch of samples organized as a list of pairs collection |
| 1 | Reference annotation | data_input | Needs to be provided in GTF format. Please make sure it is matching your reference genome sequence! |
| 2 | Fasta reference genome | data_input | A reference sequence for your virus |
| 3 | Primer scheme (optional) | data_input | If provided, indicates ampliconic data and will trigger primer trimming and removal of reads that extend beyond amplicon boundaries. Please make sure the scheme matches your reference sequence and that the format of the dataset is set to bed! |
| 4 | Supporting read fraction to call variant | parameter_input | Specify what fraction of variant-supporting reads is minimally needed at a site to call that variant (a floating point value between 0.05 and 0.25). |
| 5 | Minimum quality score to consider base for variant calling | parameter_input | The same threshold applies for variant calling and consensus generation. |


To prepare your data, upload your paired-end Illumina reads as a **paired dataset collection** and provide the reference genome in **FASTA** format along with a matching annotation in **GTF** format. If your data is ampliconic, you must provide a primer scheme in **BED** format; otherwise, the workflow defaults to a non-ampliconic pipeline. Ensure that the sequence identifiers across the FASTA, GTF, and BED files are identical to prevent tool failures during primer trimming or variant annotation. For a comprehensive guide on primer naming conventions and parameter settings, refer to the **README.md** file. You can also initialize a local configuration for testing using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.0.1+galaxy3 |  |
| 7 | SnpEff build: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff_build_gb/5.2+galaxy1 |  |
| 8 | Map parameter value | toolshed.g2.bx.psu.edu/repos/iuc/map_param_value/map_param_value/0.2.0 |  |
| 9 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 10 | Calculate numeric parameter value | toolshed.g2.bx.psu.edu/repos/iuc/calculate_numeric_param/calculate_numeric_param/0.1.0 |  |
| 11 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.19 |  |
| 12 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.8 |  |
| 13 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.22+galaxy1 |  |
| 14 | QualiMap BamQC | toolshed.g2.bx.psu.edu/repos/iuc/qualimap_bamqc/qualimap_bamqc/2.3+galaxy0 |  |
| 15 | Realign reads | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_viterbi/lofreq_viterbi/2.1.5+galaxy0 |  |
| 16 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 17 | ivar trim | toolshed.g2.bx.psu.edu/repos/iuc/ivar_trim/ivar_trim/1.4.4+galaxy1 |  |
| 18 | Flatten collection | __FLATTEN__ |  |
| 19 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 20 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.24.1+galaxy0 |  |
| 21 | ivar variants | toolshed.g2.bx.psu.edu/repos/iuc/ivar_variants/ivar_variants/1.4.4+galaxy0 |  |
| 22 | ivar consensus | toolshed.g2.bx.psu.edu/repos/iuc/ivar_consensus/ivar_consensus/1.4.4+galaxy0 |  |
| 23 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/5.2+galaxy1 |  |
| 24 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/9.5+galaxy2 |  |
| 25 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/9.5+galaxy2 |  |
| 26 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/9.5+galaxy2 |  |
| 27 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 |  |
| 28 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 15 | Processed mapped reads (filtered and realigned) | realigned |
| 17 | Processed mapped reads (filtered, realigned, primers trimmed | output_bam |
| 20 | Quality control report | html_report |
| 24 | Per-sample consensus genomes | output |
| 25 | SnpEff-annotated variants | outfile |
| 26 | Combined consensus genomes for all samples | out_file1 |
| 28 | Combined variant report for all samples | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run pe-illumina-simple-virus-calling-and-consensus.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run pe-illumina-simple-virus-calling-and-consensus.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run pe-illumina-simple-virus-calling-and-consensus.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init pe-illumina-simple-virus-calling-and-consensus.ga -o job.yml`
- Lint: `planemo workflow_lint pe-illumina-simple-virus-calling-and-consensus.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `pe-illumina-simple-virus-calling-and-consensus.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
