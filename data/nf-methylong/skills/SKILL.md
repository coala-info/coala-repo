---
name: methylong
description: nf-core/methylong processes Oxford Nanopore and PacBio HiFi long-read data from raw Pod5 or BAM formats to generate methylation calls, alignments, and differential methylation regions using a provided reference genome. Use when analyzing 5mC, 5hmC, or m6A modifications, performing SNV calling and phasing, or conducting haplotype-level and population-scale DMR analysis for long-read sequencing projects.
homepage: https://github.com/nf-core/methylong
---

## Overview
nf-core/methylong is a bioinformatics pipeline tailored for long-read methylation calling. It handles Oxford Nanopore (ONT) and PacBio HiFi data, supporting various input formats including modification-basecalled BAMs, raw Pod5 reads, and raw BAMs. The pipeline automates the transition from raw sequencing data to downstream analysis results like phased variants and differential methylation regions.

In practice, the pipeline performs platform-specific preprocessing, genome alignment using tools like dorado, pbmm2, or minimap2, and methylation extraction into BED or BEDGRAPH formats. It also includes a downstream workflow for SNV calling with Clair3, phasing with WhatsHap, and DMR analysis using DSS or modkit. Fiberseq data processing for m6A calling and nucleosome inference is also supported.

## Data preparation
The pipeline requires a CSV samplesheet and a reference genome in FASTA format. The samplesheet must contain five columns: `group`, `sample`, `path`, `ref`, and `method`.

*   **group**: Group identifier for the sample (no spaces).
*   **sample**: Unique sample name (no spaces).
*   **path**: Path to the input file (must be `.bam`, `.pod5`, or a directory).
*   **ref**: Path to the assembly FASTA file (`.fa`, `.fasta`, or `.fna`, optionally gzipped).
*   **method**: Sequencing platform, either `ont` or `pacbio`.

Example `samplesheet.csv`:
```csv
group,sample,path,ref,method
test,Col_0,ont_modbam.bam,Col_0.fasta,ont
```

If input BAM files are already aligned, use the `--reset` parameter to remove previous alignment information. Trimming in the ONT workflow can be skipped using `--no_trim`.

## How to run
Run the pipeline using the `nextflow run` command. Specify the samplesheet with `--input` and the results directory with `--outdir`.

```bash
nextflow run nf-core/methylong \
   -profile <docker/singularity/conda/...> \
   --input samplesheet.csv \
   --outdir ./results \
   -r 2.0.0
```

Key parameters include:
*   `-profile`: Hardware/software environment (e.g., `docker`, `singularity`).
*   `-resume`: Restarts the pipeline from the last cached step.
*   `--ont_aligner`: Choose between `dorado` (default) or `minimap2`.
*   `--pacbio_aligner`: Choose between `pbmm2` (default) or `minimap2`.
*   `--pacbio_modcall`: Enable modification calling for PacBio data.
*   `--dmr_population_scale`: Enable population-scale DMR analysis.

## Outputs
Results are organized into subfolders by platform and sample name within the directory specified by `--outdir`.

*   **Alignment**: `alignment/aligned.bam` and `.flagstat` files.
*   **Methylation Calls**: `pileup/modkit/pileup.bed.gz` (bedMethyl) and optional `bedgraph/` folders.
*   **Variants and Phasing**: `snvcall/SNV_PASS.vcf` and `phase/phased.vcf`.
*   **DMR Analysis**: `dmr_haplotype_level/dss/DSS_callDMR.txt` and population-scale results if enabled.
*   **Reports**: `multiqc/multiqc_report.html` provides a summary of FastQC and alignment statistics.

For detailed interpretation of results, refer to the official [output documentation](https://nf-co.re/methylong/output). Detailed usage instructions are available in the [usage documentation](https://nf-co.re/methylong/usage).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
