---
name: gtn_differential_isoform_expression
description: "This transcriptomics workflow processes RNA-seq data and genome annotations using RNA STAR, StringTie, and IsoformSwitchAnalyzeR to identify differential isoform usage and functional switches. Use this skill when you need to characterize how alternative splicing or promoter usage changes protein domains, coding potential, and biological functions between different experimental conditions."
homepage: https://workflowhub.eu/workflows/1688
---

# GTN_differential_isoform_expression

## Overview

This workflow provides a comprehensive pipeline for identifying and analyzing differential isoform expression and isoform switching from RNA-seq data. It begins with quality control and preprocessing using [fastp](https://github.com/OpenGene/fastp) and [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/), followed by read alignment to a reference genome using [RNA STAR](https://github.com/alexdobin/STAR).

Transcript assembly and quantification are performed using the [StringTie](https://ccb.jhu.edu/software/stringtie/) suite, which includes merging individual assemblies into a non-redundant transcriptome. The workflow incorporates extensive validation steps, utilizing [GffCompare](https://ccb.jhu.edu/software/stringtie/gff.shtml#gffcompare) and [rnaQUAST](https://github.com/ablab/rnaquast) for assembly evaluation, alongside [RSeQC](http://rseqc.sourceforge.net/) for assessing read distribution, junction saturation, and strand specificity.

The core analysis is driven by [IsoformSwitchAnalyzeR](https://bioconductor.org/packages/release/bioc/html/IsoformSwitchAnalyzeR.html), which identifies isoform switches and predicts their functional consequences. To enrich this analysis, the pipeline integrates [PfamScan](https://www.ebi.ac.uk/Tools/pfa/pfamscan/) for protein domain identification and [CPAT](https://cpat.readthedocs.io/) for coding potential assessment. The final outputs include detailed summaries of splicing enrichment and a prioritized list of isoforms with the most significant switching events.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | RNA-seq data collection | data_collection_input | input fastqs |
| 1 | Genome annotation | data_input | gene annotation file |
| 2 | Reference genome | data_input | genome reference fasta file |
| 3 | Pfam-A HMM library | data_input | Pfam-A.hmm.gz from EMBL-EBI |
| 4 | Pfam-A HMM Stockholm file | data_input | Pfam-A.hmm.dat.gz from EMBL-EBI |
| 5 | Active sites dataset | data_input | active_site.dat.gz from EMBL-EBI |
| 6 | CPAT header | data_input | header |


To ensure successful execution, organize your raw RNA-seq reads into a paired-end or single-end data collection, while providing the reference genome and annotation in FASTA and GTF/GFF3 formats respectively. Specialized inputs including the Pfam-A HMM library, Stockholm file, and CPAT header are essential for the functional protein domain and coding potential assessments performed by IsoformSwitchAnalyzeR. Verify that all dataset metadata, particularly chromosome naming conventions, are consistent across the genome and annotation files to prevent tool errors during alignment and quantification. For automated environment setup and testing, you can use `planemo workflow_job_init` to generate a `job.yml` template. Detailed configuration for each tool step and specific parameter requirements can be found in the accompanying README.md.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | Flatten collection | __FLATTEN__ |  |
| 8 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.4+galaxy1 |  |
| 9 | Convert GTF to BED12 | toolshed.g2.bx.psu.edu/repos/iuc/gtftobed12/gtftobed12/357 |  |
| 10 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.3+galaxy1 |  |
| 11 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.3+galaxy1 |  |
| 12 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 13 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 |  |
| 14 | RNA STAR | toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.11a+galaxy1 |  |
| 15 | Gene BED To Exon/Intron/Codon BED | gene2exon1 |  |
| 16 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0 |  |
| 17 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0 |  |
| 18 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 |  |
| 19 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/9.3+galaxy1 |  |
| 20 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/2.1 |  |
| 21 | Filter | Filter1 |  |
| 22 | Sort | sort1 |  |
| 23 | Cut | Cut1 |  |
| 24 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 25 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 26 | Sort | sort1 |  |
| 27 | Unique lines | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_uniq_tool/9.3+galaxy1 |  |
| 28 | RNA STAR | toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.11a+galaxy1 |  |
| 29 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.3+galaxy0 |  |
| 30 | Infer Experiment | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_infer_experiment/5.0.3+galaxy0 |  |
| 31 | Gene Body Coverage (BAM) | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_geneBody_coverage/5.0.3+galaxy0 |  |
| 32 | Junction Saturation | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_junction_saturation/5.0.3+galaxy0 |  |
| 33 | Junction Annotation | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_junction_annotation/5.0.3+galaxy0 |  |
| 34 | Inner Distance | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_inner_distance/5.0.3+galaxy0 |  |
| 35 | Read Distribution | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_read_distribution/5.0.3+galaxy0 |  |
| 36 | StringTie merge | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie_merge/2.2.3+galaxy0 |  |
| 37 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0 |  |
| 38 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 |  |
| 39 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.3+galaxy0 |  |
| 40 | GffCompare | toolshed.g2.bx.psu.edu/repos/iuc/gffcompare/gffcompare/0.12.6+galaxy0 |  |
| 41 | pyGenomeTracks | toolshed.g2.bx.psu.edu/repos/iuc/pygenometracks/pygenomeTracks/3.8+galaxy2 |  |
| 42 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.4+galaxy0 |  |
| 43 | pyGenomeTracks | toolshed.g2.bx.psu.edu/repos/iuc/pygenometracks/pygenomeTracks/3.8+galaxy2 |  |
| 44 | pyGenomeTracks | toolshed.g2.bx.psu.edu/repos/iuc/pygenometracks/pygenomeTracks/3.8+galaxy2 |  |
| 45 | rnaQUAST | toolshed.g2.bx.psu.edu/repos/iuc/rnaquast/rna_quast/2.2.3+galaxy0 |  |
| 46 | Extract element identifiers | toolshed.g2.bx.psu.edu/repos/iuc/collection_element_identifiers/collection_element_identifiers/0.0.2 |  |
| 47 | Filter | Filter1 |  |
| 48 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.3+galaxy1 |  |
| 49 | Filter collection | __FILTER_FROM_FILE__ |  |
| 50 | IsoformSwitchAnalyzeR | toolshed.g2.bx.psu.edu/repos/iuc/isoformswitchanalyzer/isoformswitchanalyzer/1.20.0+galaxy5 |  |
| 51 | IsoformSwitchAnalyzeR | toolshed.g2.bx.psu.edu/repos/iuc/isoformswitchanalyzer/isoformswitchanalyzer/1.20.0+galaxy5 |  |
| 52 | PfamScan | toolshed.g2.bx.psu.edu/repos/bgruening/pfamscan/pfamscan/1.6+galaxy0 |  |
| 53 | CPAT | toolshed.g2.bx.psu.edu/repos/bgruening/cpat/cpat/3.0.5+galaxy1 |  |
| 54 | Cut | Cut1 |  |
| 55 | Add column | toolshed.g2.bx.psu.edu/repos/devteam/add_value/addValue/1.0.1 |  |
| 56 | Remove beginning | Remove beginning1 |  |
| 57 | Concatenate datasets | cat1 |  |
| 58 | IsoformSwitchAnalyzeR | toolshed.g2.bx.psu.edu/repos/iuc/isoformswitchanalyzer/isoformswitchanalyzer/1.20.0+galaxy5 |  |
| 59 | IsoformSwitchAnalyzeR | toolshed.g2.bx.psu.edu/repos/iuc/isoformswitchanalyzer/isoformswitchanalyzer/1.20.0+galaxy5 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 59 | consequencesSummary | consequencesSummary |
| 59 | consequencesEnrichment | consequencesEnrichment |
| 59 | splicingEnrichment | splicingEnrichment |
| 59 | mostSwitching | mostSwitching |
| 59 | splicingSummary | splicingSummary |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
