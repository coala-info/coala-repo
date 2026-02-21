---
name: somaticseq
description: SomaticSeq is a meta-caller that integrates outputs from various somatic mutation detection tools to produce a more accurate final call set.
homepage: http://bioinform.github.io/somaticseq/
---

# somaticseq

## Overview
SomaticSeq is a meta-caller that integrates outputs from various somatic mutation detection tools to produce a more accurate final call set. It functions by extracting features from the alignment files (BAMs) and the candidate VCFs provided by individual callers. It can operate in three modes: a simple majority-vote consensus, a training mode to build site-specific machine learning models, or a prediction mode that uses pre-existing classifiers to score and filter variants.

## Common CLI Patterns

### Tumor-Normal Paired Mode
Use the `paired` subcommand to merge results from a tumor and a matched normal sample. You must provide the BAM files for both and the VCF outputs from the individual callers used.

```bash
somaticseq_parallel.py \
    --output-directory $OUTPUT_DIR \
    --genome-reference GRCh38.fa \
    --inclusion-region genome.bed \
    --threads 8 \
    paired \
    --tumor-bam-file tumor.bam \
    --normal-bam-file matched_normal.bam \
    --mutect2-vcf MuTect2.vcf \
    --varscan-snv VarScan2.snp.vcf \
    --varscan-indel VarScan2.indel.vcf \
    --vardict-vcf VarDict.vcf \
    --strelka-snv Strelka.snv.vcf \
    --strelka-indel Strelka.indel.vcf
```

### Tumor-Only (Single) Mode
Use the `single` subcommand when a matched normal sample is unavailable.

```bash
somaticseq_parallel.py \
    --output-directory $OUTPUT_DIR \
    --genome-reference GRCh38.fa \
    --inclusion-region genome.bed \
    single \
    --bam-file tumor.bam \
    --mutect2-vcf MuTect2.vcf \
    --varscan-vcf VarScan2.vcf \
    --vardict-vcf VarDict.vcf
```

### Training Mode
To build a machine learning model, add the training flags before the `paired` or `single` subcommand. This requires ground truth VCFs.

```bash
somaticseq_parallel.py \
    --output-directory $TRAINING_OUT \
    --genome-reference reference.fa \
    --somaticseq-train \
    --truth-snv truth_snvs.vcf \
    --truth-indel truth_indels.vcf \
    paired [ARGS...]
```

### Prediction Mode
To apply a previously trained classifier to new data, provide the `.RData` or model files before the subcommand.

```bash
somaticseq_parallel.py \
    --output-directory $PREDICT_OUT \
    --genome-reference reference.fa \
    --classifier-snv trained_snv.RData \
    --classifier-indel trained_indel.RData \
    paired [ARGS...]
```

## Expert Tips and Best Practices

- **Identical Sorting**: Ensure the genome reference FASTA, all input BAM files, and all input VCF files are sorted identically (e.g., all by coordinate using the same dictionary).
- **Parallelization**: Always use the `--threads` parameter to speed up processing. This requires `bedtools` to be in your PATH, as it splits the inclusion BED file into chunks for parallel execution.
- **Input Flexibility**: SomaticSeq accepts both uncompressed `.vcf` and compressed `.vcf.gz` files.
- **Region Filtering**: Use `--inclusion-region` (BED format) to restrict calling to specific areas like the whole exome capture kit targets to reduce computation time and false positives in off-target regions.
- **Default Behavior**: If neither `--somaticseq-train` nor `--classifier-snv/indel` are specified, the tool defaults to a majority-vote consensus mode.
- **Tool Selection**: While SomaticSeq supports many callers (MuTect2, VarScan2, JointSNVMix2, SomaticSniper, VarDict, MuSE, LoFreq, Scalpel, Strelka2), you do not need to provide all of them. It will process whatever subset of supported VCFs you provide.

## Reference documentation
- [SomaticSeq Home](./references/bioinform_github_io_somaticseq.md)
- [SomaticSeq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_somaticseq_overview.md)