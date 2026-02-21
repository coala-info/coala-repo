---
name: kipoi_veff
description: The `kipoi_veff` plugin extends the Kipoi framework to provide specialized tools for variant effect prediction.
homepage: https://github.com/kipoi/kipoi-veff
---

# kipoi_veff

## Overview

The `kipoi_veff` plugin extends the Kipoi framework to provide specialized tools for variant effect prediction. It allows users to take a VCF file and a compatible DNA-sequence model to calculate how specific mutations alter model outputs. It supports various scoring metrics such as simple differences, logit differences, and deep-learning specific scores. This tool is particularly useful for researchers looking to prioritize variants or interpret the functional impact of non-coding mutations.

## Installation and Environment Setup

To use `kipoi_veff` effectively, the environment must be prepared with the plugin included.

- **Conda Installation**: `conda install -c bioconda kipoi_veff`
- **Environment Creation**: When creating a Kipoi model environment, always include the `--vep` flag to ensure the plugin and its dependencies are installed:
  `kipoi create env <model_name> --vep`

## Command Line Interface (CLI) Patterns

The primary command is `kipoi veff score_variants`.

### Basic VCF Annotation
Annotate a VCF with default scores for a specific model:
`kipoi veff score_variants <model_name> -i input.vcf -o output_annotated.vcf`

### Specifying Scoring Methods
By default, `diff` is usually available. You can specify multiple scores:
`kipoi veff score_variants <model_name> -i input.vcf -o output.vcf -s diff logit_ref logit_alt logit`

### Handling Dataloader Arguments
If the model's dataloader requires specific files (like a reference genome FASTA), pass them as a JSON string:
`kipoi veff score_variants <model_name> -i input.vcf -o output.vcf --dataloader_args '{"fasta_file": "path/to/genome.fa"}'`

### Performance and Filtering
- **Batch Size**: Increase for faster processing if GPU memory allows: `--batch_size 512`
- **Parallelism**: Use multiple workers for data loading: `-n 4`
- **Region Restriction**: Limit analysis to specific genomic regions to save time: `-r regions.bed`
- **Standardized IDs**: Use `--std_var_id` to ensure variant IDs in the output VCF are unique and standardized.

### Extra Output Formats
For large-scale predictions where VCF headers might become unwieldy, export results to tabular or binary formats:
`kipoi veff score_variants <model_name> -i input.vcf -o output.vcf -e results.tsv`
`kipoi veff score_variants <model_name> -i input.vcf -o output.vcf -e results.h5`

## Python API Usage

For integration into bioinformatics pipelines, use the `score_variants` function directly.

```python
from kipoi_veff import score_variants

score_variants(
    model='DeepBind/Homsap/TF/D00328.003_SELEX_SREBF1',
    dl_args={'fasta_file': 'data/genome.fa'},
    input_vcf='data/input.vcf',
    output_vcf='data/output.vcf',
    scores=['diff', 'logit'],
    batch_size=32
)
```

## Expert Tips

- **Model Compatibility**: Ensure the model has a `postprocessing > variant_effects` section in its configuration. If it is missing, you may need to manually point to a model template or use the `kipoi-veff2` rewrite for newer models.
- **Sequence Length**: If a model accepts variable input lengths but the dataloader doesn't provide a default, you must specify it using `-l <length>`.
- **Memory Management**: When working with very large VCFs, prefer `-e results.h5` as HDF5 is more efficient for storing high-dimensional model outputs than the VCF format.

## Reference documentation
- [Kipoi-veff GitHub Repository](./references/github_com_kipoi_kipoi-veff.md)
- [Kipoi-veff Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kipoi_veff_overview.md)