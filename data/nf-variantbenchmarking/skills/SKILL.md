---
name: variantbenchmarking
description: This pipeline evaluates the accuracy of genomic variant calling by comparing test VCF files against truth sets using specialized benchmarking tools for small variants, structural variants, and copy number variations. Use when validating germline or somatic variant calling methods against gold standards like Genome in a Bottle or SEQC2, or when performing concordance analysis between different callers.
homepage: https://github.com/nf-core/variantbenchmarking
---

## Overview
The nf-core/variantbenchmarking pipeline is designed to evaluate and validate the accuracy of variant calling methods in genomic research. It provides a standardized framework for comparing test variant calls against established truth sets, supporting a wide range of variant types including SNVs, INDELs, Structural Variants (SVs), and Copy Number Variations (CNVs).

The workflow handles the complexities of variant comparison by providing subworkflows for VCF standardization, normalization, and coordinate liftover. It generates comprehensive statistical reports and comparative metrics, allowing researchers to identify true positives, false positives, and false negatives across different calling strategies and genomic regions.

## Data preparation
The pipeline requires a samplesheet and specific truth set parameters defined in a configuration file or via the command line.

**Samplesheet requirements:**
A CSV file with the following columns:
- `id`: Unique identifier for the test sample.
- `test_vcf`: Path to the VCF or BCF file to be benchmarked.
- `caller`: Name of the variant caller used (e.g., gatk, delly, cnvkit).

Example `samplesheet.csv`:
```csv
id,test_vcf,caller
sample1,sample1.vcf.gz,gatk
sample2,sample2.vcf.gz,delly
```

**Reference and Truth files:**
- **Reference Genome:** FASTA (`--fasta`) and FAI (`--fai`) files, or an iGenomes identifier (`--genome`).
- **Truth Set:** A truth VCF (`--truth_vcf`) and its corresponding sample ID (`--truth_id`) are mandatory.
- **Optional Regions:** BED files for high-confidence regions (`--regions_bed`) or specific targets (`--targets_bed`).

## How to run
Run the pipeline using `nextflow run`. You must specify the analysis type (germline or somatic), the variant type, and the benchmarking method.

```bash
nextflow run nf-core/variantbenchmarking \
   -profile <docker/singularity/institute> \
   -r 1.0.0 \
   --input samplesheet.csv \
   --outdir ./results \
   --genome GRCh38 \
   --analysis germline \
   --variant_type small \
   --method happy,rtgtools \
   --truth_id HG002 \
   --truth_vcf HG002_truth.vcf.gz
```

Key parameters:
- `--analysis`: Either `germline` or `somatic`.
- `--variant_type`: One of `small`, `snv`, `indel`, `structural`, or `copynumber`.
- `--method`: Comma-separated list of tools (e.g., `happy`, `rtgtools`, `truvari`, `wittyer`, `svanalyzer`).
- `-resume`: Use this to restart a run from the last cached step.

## Outputs
Results are saved in the directory specified by `--outdir`.

- **MultiQC:** A summary report (`multiqc/multiqc_report.html`) visualizing benchmarking metrics and variant statistics across all samples.
- **Benchmarking Metrics:** Tool-specific folders (e.g., `truvari/`, `happy/`) containing summary statistics, VCFs of categorized variants (TP, FP, FN), and performance curves.
- **Standardized VCFs:** Normalized and filtered versions of the input test and truth files used for the comparison.
- **Plots:** Visualizations of variant length distributions, upset plots for caller intersections, and precision-recall metrics.

For detailed output descriptions, refer to the official [nf-core/variantbenchmarking output documentation](https://nf-co.re/variantbenchmarking/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/testcases.md`](references/docs/testcases.md)
- [`references/docs/truth.md`](references/docs/truth.md)
- [`references/docs/usage.md`](references/docs/usage.md)
