---
name: mmvc
description: mmvc (Multinomial Mixture Variant Caller) is a bioinformatics tool designed to identify genetic variants by applying a Bayesian multinomial mixture model.
homepage: https://github.com/veg/mmvc
---

# mmvc

## Overview
mmvc (Multinomial Mixture Variant Caller) is a bioinformatics tool designed to identify genetic variants by applying a Bayesian multinomial mixture model. It is particularly effective at distinguishing true biological variations from sequencing noise. The tool is implemented in Julia and is typically used in research pipelines where a probabilistic approach to variant calling is required.

## Installation and Environment
The tool is available via Bioconda and requires a specific Julia environment.

- **Conda Installation**: `conda install bioconda::mmvc`
- **Legacy Compatibility**: The tool is optimized for Julia v0.6.x. Ensure the environment has the following Julia packages installed: `ArgParse`, `FastaIO`, `JSON`, and `Test`.

## Command Line Usage
The primary interface is the `mmvc.jl` script.

### Basic Syntax
```bash
julia mmvc.jl [options] <input.fasta>
```

### Common Arguments
- `--chain-length <int>`: Sets the number of iterations for the Bayesian MCMC chain. A common value for robust results is `2000000`.
- `--json-report <file>`: Specifies the output path for the results in JSON format.
- `--filter <msa_file>`: Provides a Multiple Sequence Alignment (MSA) file to be used as a filter during the calling process.
- `--version`: Displays the current version of the tool.

### Example Workflow
To call variants from a FASTA file with a high iteration count and a filter:
```bash
julia mmvc.jl --chain-length 2000000 --json-report results.json --filter reference_filter.msa input_data.fasta
```

## Best Practices
- **Chain Convergence**: Bayesian models require sufficient iterations to converge. If results seem inconsistent, increase the `--chain-length`.
- **Input Validation**: Ensure the input FASTA file is properly formatted and matches the expected sequence alignment if using the `--filter` option.
- **Output Analysis**: The JSON report contains the posterior probabilities and mixture weights; use a JSON parser or specialized downstream scripts to interpret the variant confidence levels.

## Reference documentation
- [mmvc Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mmvc_overview.md)
- [mmvc GitHub README](./references/github_com_veg_mmvc_blob_master_README.md)