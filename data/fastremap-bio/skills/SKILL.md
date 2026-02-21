---
name: fastremap-bio
description: FastRemap is a high-performance C++ implementation designed to convert genomic coordinates between assembly versions.
homepage: https://github.com/CMU-SAFARI/FastRemap
---

# fastremap-bio

## Overview
FastRemap is a high-performance C++ implementation designed to convert genomic coordinates between assembly versions. It serves as a faster, more memory-efficient alternative to the widely used CrossMap tool. By utilizing UCSC chain files, it allows researchers to migrate legacy datasets to newer reference genomes or compare data across different assembly builds while maintaining high fidelity in read mapping information.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::fastremap-bio
```

## Core CLI Usage
The basic syntax requires specifying the file format, the conversion chain, and the input/output paths.

```bash
FastRemap -f <format> -c <chain_file> -i <input_file> -o <output_mapped> -u <output_unmapped>
```

### Required Arguments
- `-f`: Input file type. Must be one of: `bam`, `sam`, or `bed`.
- `-c`: The UCSC chain file (e.g., `hg19ToHg38.over.chain`) describing the mapping between assemblies.
- `-i`: The source file containing coordinates to be remapped.
- `-o`: The destination path for successfully remapped elements.
- `-u`: The destination path for elements that could not be remapped (unmapped).

### Optional Parameters for BAM/SAM
When remapping paired-end reads in BAM or SAM format, you can tune the insert size parameters:
- `-a`: Append tags to the output BAM file.
- `-m`: Set the mean insert size.
- `-s`: Set the insert size standard deviation.
- `-t`: Set the insert size fold (times).

## Best Practices and Expert Tips
- **Performance Advantage**: Use FastRemap over CrossMap when processing large-scale BAM files; it typically offers up to a 7x speedup and uses significantly less peak memory.
- **Chain Files**: Always ensure your chain file matches the direction of conversion (e.g., use `ce6ToCe10` to move from ce6 to ce10, not the reverse).
- **Unmapped Reads**: Always inspect the `-u` (unmapped) output. Reads often fail to remap because they fall into regions that were deleted, heavily rearranged, or significantly changed between assembly versions.
- **Validation**: If you need to verify the integrity of the remapping against CrossMap, use the provided validation script:
  ```bash
  python validation/compare_outputs.py output_sam1.sam output_sam2.sam
  ```
- **Compiler Requirements**: If building from source on older systems, ensure `gcc 10` or higher is used, or include the `span` library manually.

## Reference documentation
- [FastRemap GitHub Repository](./references/github_com_CMU-SAFARI_FastRemap.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_fastremap-bio_overview.md)