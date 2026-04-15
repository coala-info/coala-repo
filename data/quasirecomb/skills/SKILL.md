---
name: quasirecomb
description: QuasiRecomb infers the composition of viral quasispecies from aligned NGS data by accounting for recombination events and point mutations. Use when user asks to reconstruct viral haplotypes, estimate strain frequencies, or analyze viral recombination using a jumping Hidden Markov Model.
homepage: https://github.com/cbg-ethz/QuasiRecomb
metadata:
  docker_image: "quay.io/biocontainers/quasirecomb:1.2--0"
---

# quasirecomb

## Overview
QuasiRecomb is a specialized bioinformatics tool designed to infer the composition of viral quasispecies from aligned NGS data. Unlike standard variant callers, it utilizes a jumping Hidden Markov Model (HMM) to explicitly account for recombination events alongside point mutations. It provides maximum a posteriori estimates of model parameters using an EM algorithm, allowing for the reconstruction of the underlying viral strains (haplotypes) and their relative frequencies.

## Common CLI Patterns

### Basic Reconstruction
The most common usage involves providing a coordinate-sorted BAM or SAM file.
```bash
java -jar QuasiRecomb.jar -i alignment.bam
```

### Targeted Analysis
To focus on a specific gene or genomic region (using reference genome numbering):
```bash
java -jar QuasiRecomb.jar -i alignment.bam -r 790-2292
```

### Model Complexity and Generators
By default, the tool estimates the number of generators. You can fix this number or provide a range for model selection:
- **Fixed number**: `-K 5`
- **Range for selection**: `-K 1-10`

### Quality and Error Handling
- **Incorporate PHRED scores**: Use `-quality` to weight bases by their sequencing quality (recommended for higher accuracy, though slower).
- **Conservative mode**: Use `-conservative` to focus only on major haplotypes and reduce noise.
- **Ignore deletions**: Use `-noGaps` if deletions are suspected to be technical artifacts rather than biological features.

### Sequencing Platform Specifics
- **454/Roche**: Often has non-unique read names. Use `-unpaired` to prevent incorrect merging.
- **Paired-end data**: The tool automatically pairs reads by name unless `-unpaired` is specified.

## Performance and Memory Management
QuasiRecomb is memory-intensive, especially for large datasets or long genomic regions.

### Recommended JVM Flags
For optimal performance on multicore systems with large datasets:
```bash
java -XX:+UseParallelGC -XX:NewRatio=9 -Xms2G -Xmx10G -jar QuasiRecomb.jar -i alignment.bam
```
- `-XX:NewRatio=9`: Minimizes the frequency of full garbage collection cycles.
- `-Xmx10G`: Adjust the heap size based on available system RAM and dataset size.

## Expert Tips
- **Filtering**: If your data has high technical noise, use `-maxDel <INT>` or `-maxPercDel <DOUBLE>` (e.g., `0.1` for 10%) to filter out reads with excessive deletions before processing.
- **Protein Translation**: Add the `-protein` flag to automatically generate amino acid translations for the reconstructed quasispecies in all three reading frames (found in the `support/` directory).
- **Validation**: If recombination is not expected or you want a baseline comparison, use `-noRecomb` to disable the jumping mechanism of the HMM.
- **Subsampling**: For extremely deep coverage where processing is bottlenecked, use the `-subsample <DOUBLE>` flag (e.g., `0.5`) to use only a percentage of the input data.

## Reference documentation
- [QuasiRecomb GitHub Repository](./references/github_com_cbg-ethz_QuasiRecomb.md)
- [QuasiRecomb Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_quasirecomb_overview.md)