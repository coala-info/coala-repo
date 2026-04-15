---
name: gatk-framework
description: The Genome Analysis Toolkit identifies variants in high-throughput sequencing data and executes standardized genomic workflows. Use when user asks to identify germline or somatic variants, mark duplicates, recalibrate base quality scores, or perform joint genotyping.
homepage: https://gatk.broadinstitute.org/
metadata:
  docker_image: "quay.io/biocontainers/gatk-framework:3.6.24--4"
---

# gatk-framework

## Overview
The Genome Analysis Toolkit (GATK) is the industry standard for identifying variants in high-throughput sequencing data. This skill enables the configuration and execution of GATK4 workflows, which now integrate the Picard toolkit for seamless data manipulation. It focuses on "Best Practices" workflows—standardized protocols developed by the Broad Institute to ensure reproducibility and accuracy in genomic research across various organisms and ploidy levels.

## Core CLI Patterns
GATK4 uses a unified command-line syntax. All tools, including integrated Picard tools, are invoked through the main `gatk` executable.

### Basic Syntax
```bash
gatk [--java-options "-Xmx4G"] ToolName \
    -I input.bam \
    -R reference.fasta \
    -O output.vcf \
    --optional-argument value
```

### Common Global Arguments
- `-R / --reference`: Path to the reference genome (requires `.dict` and `.fai` files).
- `-I / --input`: Input file (BAM, SAM, CRAM, or VCF depending on the tool).
- `-O / --output`: Path for the resulting file.
- `-L / --intervals`: Limit processing to specific genomic regions (e.g., `chr1` or `intervals.list`).
- `--tmp-dir`: Specify a directory for temporary files to avoid filling up `/tmp`.

## Best Practices Workflows

### 1. Data Preprocessing
Before variant calling, reads must be mapped and cleaned.
- **Alignment**: Use `BWA-MEM` (external to GATK) or `DRAGMAP` for DRAGEN-GATK workflows.
- **Mark Duplicates**: Use `MarkDuplicates` to identify PCR or optical duplicates.
- **Base Quality Score Recalibration (BQSR)**:
  1. `BaseRecalibrator`: Generates a recalibration table based on known sites of variation.
  2. `ApplyBQSR`: Outputs a new BAM file with adjusted quality scores.

### 2. Germline Short Variant Discovery (SNPs + Indels)
- **HaplotypeCaller**: Call variants per-sample in `GVCF` mode for scalability.
  ```bash
  gatk HaplotypeCaller -R ref.fa -I sample.bam -O sample.g.vcf -ERC GVCF
  ```
- **Joint Genotyping**: Combine multiple GVCFs using `CombineGVCFs` or `GenomicsDBImport`, then run `GenotypeGVCFs`.

### 3. Somatic Variant Discovery
- **Mutect2**: Used for identifying somatic mutations. Requires a "Panel of Normals" (PoN) and a germline resource (e.g., gnomAD) to filter out common variants and sequencing artifacts.

## DRAGEN-GATK Optimization
For users requiring high speed and functional equivalence to Illumina's DRAGEN platform:
- Use the `--dragen-mode` flag in supported tools (like `HaplotypeCaller`).
- Utilize `DRAGMAP` for alignment to ensure the most accurate input for the DRAGEN-GATK pipeline.

## Expert Tips
- **Memory Management**: Always specify `-Xmx` via `--java-options` to prevent Java heap space errors, especially for memory-intensive tools like `HaplotypeCaller` or `MarkDuplicates`.
- **Spark Tools**: For tools with "Spark" in the name (e.g., `PrintReadsSpark`), use them to leverage multi-core local processing or cluster environments for significant speedups.
- **Validation**: Use `ValidateSamFile` on input BAMs if you encounter cryptic errors; GATK is strict about BAM formatting and header consistency.
- **Index Files**: Ensure all input files (BAM, VCF, Fasta) are properly indexed (`.bai`, `.tbi`/`.idx`, `.fai`). GATK will fail if indices are missing or outdated.

## Reference documentation
- [DRAGEN-GATK](./references/gatk_broadinstitute_org_hc_en-us_articles_360045944831-DRAGEN-GATK.md)
- [GATK Overview and Best Practices](./references/gatk_broadinstitute_org_hc_en-us.md)