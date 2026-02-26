---
name: deepvariant
description: DeepVariant is a deep-learning-based variant calling pipeline that uses convolutional neural networks to identify genetic variants from aligned genomic reads. Use when user asks to call variants, generate VCF or gVCF files, or identify genotypes from WGS, WES, PacBio, or Oxford Nanopore data.
homepage: https://github.com/google/deepvariant
---


# deepvariant

## Overview
DeepVariant is a deep-learning-based variant calling pipeline that replaces traditional statistical callers. It works by converting aligned genomic reads into pileup images, which are then processed by a convolutional neural network (CNN) to classify genotypes. Use this skill when you need to generate VCF or gVCF files from diploid organisms, particularly for human data where its pre-trained models offer state-of-the-art precision.

## Core CLI Usage
The recommended way to run DeepVariant is via Docker to ensure all dependencies and models are correctly configured.

### Standard Execution Pattern
```bash
BIN_VERSION="1.9.0"
docker run \
  -v "INPUT_DIR:/input" \
  -v "OUTPUT_DIR:/output" \
  google/deepvariant:"${BIN_VERSION}" \
  /opt/deepvariant/bin/run_deepvariant \
  --model_type=WGS \
  --ref=/input/reference.fa \
  --reads=/input/aligned_reads.bam \
  --output_vcf=/output/variants.vcf.gz \
  --output_gvcf=/output/variants.g.vcf.gz \
  --num_shards=$(nproc)
```

### Model Selection (`--model_type`)
Choosing the correct model is critical for accuracy. Available types include:
- `WGS`: Illumina Whole Genome Sequencing.
- `WES`: Illumina Whole Exome Sequencing.
- `PACBIO`: PacBio HiFi reads.
- `ONT_R104`: Oxford Nanopore R10.4.1 Simplex reads.
- `HYBRID_PACBIO_ILLUMINA`: Combined data from both platforms.

## Expert Tips and Best Practices

### Parallelization
- **Sharding**: Always set `--num_shards` to the number of available CPU cores to speed up the `make_examples` stage.
- **GPU Acceleration**: If a GPU is available, use the `google/deepvariant:1.9.0-gpu` image. The `call_variants` stage is significantly faster on GPU.

### Handling Sex Chromosomes (Haploid Support)
For male human samples (XY), heterozygous calls on X and Y should be re-genotyped as haploid.
- **GRCh38**: `--haploid_contigs="chrX,chrY" --par_regions_bed="/input/GRCh38_par.bed"`
- **GRCh37**: `--haploid_contigs="X,Y" --par_regions_bed="/input/GRCh37_par.bed"`
*Note: Do not use these flags for female (XX) samples.*

### Quality Control
- **Stats Report**: Set `--vcf_stats_report=true` to generate an HTML report containing variant distributions and quality metrics.
- **Logging**: Use `--logging_dir=/output/logs` to capture detailed logs for each stage (make_examples, call_variants, postprocess_variants), which is essential for debugging large runs.

### Specialized Workflows
- **DeepTrio**: For family-based calling (mother-father-child), use the `deeptrio` binary to improve accuracy by leveraging Mendelian inheritance patterns.
- **DeepSomatic**: For tumor-normal pairs, refer to the DeepSomatic extension for specialized somatic mutation calling.

## Common Troubleshooting
- **Ploidy**: DeepVariant is optimized for diploid organisms. Calling variants in polyploid species or highly aneuploid cancer samples with standard models may yield unreliable results.
- **Memory**: Ensure the Docker container has access to at least 3-4GB of RAM per shard.
- **Storage**: Ensure the output directory has sufficient space for intermediate TFRecord files, which can be large before being converted to VCF.

## Reference documentation
- [DeepVariant GitHub Repository](./references/github_com_google_deepvariant.md)
- [Bioconda DeepVariant Overview](./references/anaconda_org_channels_bioconda_packages_deepvariant_overview.md)