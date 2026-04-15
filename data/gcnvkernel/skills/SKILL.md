---
name: gcnvkernel
description: The gcnvkernel package provides the computational engine for denoising read-count data and inferring copy-number states within the GATK germline CNV calling pipeline. Use when user asks to determine contig ploidy, train germline CNV models on a cohort, or perform copy-number variant inference on individual samples.
homepage: https://www.broadinstitute.org/gatk/
metadata:
  docker_image: "quay.io/biocontainers/gcnvkernel:0.9--pyhdfd78af_0"
---

# gcnvkernel

## Overview
The `gcnvkernel` package is the computational engine behind the GATK (Genome Analysis Toolkit) germline CNV calling pipeline. It implements the probabilistic models required to denoise read-count data and infer copy-number states. This skill helps in configuring the kernel parameters, managing the training of model parameters on a cohort of samples, and executing the inference step for individual samples.

## Command Line Usage and Best Practices

### Core Components
The kernel is typically invoked via GATK wrappers, but understanding the underlying logic is essential for troubleshooting and optimization:
- **DetermineGermlineContigPloidy**: Uses the kernel to determine the baseline ploidy of contigs.
- **GermlineCNVCaller**: The primary tool for training models (Cohort mode) or applying existing models (Case mode).

### Common CLI Patterns
When working with the gCNV pipeline, ensure the following arguments are correctly configured for the kernel:

- **Interval Processing**: Always use `PreprocessIntervals` and `AnnotateIntervals` before running the kernel to ensure GC-content and mappability are accounted for.
- **Cohort Training**:
  ```bash
  gatk GermlineCNVCaller \
    --run-mode COHORT \
    --intervals processed.intervals \
    --contig-ploidy-calls ploidy-calls \
    --input sample1.counts.hdf5 \
    --input sample2.counts.hdf5 \
    --output cohort-model-output \
    --output-prefix cohort_name
  ```
- **Case Inference**:
  ```bash
  gatk GermlineCNVCaller \
    --run-mode CASE \
    --intervals processed.intervals \
    --contig-ploidy-calls ploidy-calls \
    --model cohort-model-output \
    --input case_sample.counts.hdf5 \
    --output case-output \
    --output-prefix case_sample
  ```

### Expert Tips for Model Performance
- **Sample Size**: For `COHORT` mode, a minimum of 30 samples is recommended to allow the kernel to accurately learn the noise components. 100+ samples is ideal for high-resolution calling.
- **Memory Management**: The kernel is memory-intensive. If encountering `OutOfMemory` errors, reduce the `--bin-length` or process the genome in smaller shards using the `--intervals` argument.
- **Learning Rate**: If the model fails to converge (visible in the tool logs), consider adjusting the `--learning-rate` (default is usually 0.05).
- **Denoising**: The kernel uses a Variational Autoencoder (VAE) approach. Ensure that the `--num-latent-factors` is set appropriately; typically, 10-20 factors are sufficient for most whole-exome or whole-genome cohorts.

## Reference documentation
- [gcnvkernel Overview](./references/anaconda_org_channels_bioconda_packages_gcnvkernel_overview.md)