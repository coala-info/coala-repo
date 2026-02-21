---
name: jasminesv
description: Jasmine (Jointly Accurate Sv Merging with Intersample Network Edges) is a high-performance tool designed to consolidate structural variants across individuals.
homepage: https://github.com/mkirsche/Jasmine
---

# jasminesv

## Overview
Jasmine (Jointly Accurate Sv Merging with Intersample Network Edges) is a high-performance tool designed to consolidate structural variants across individuals. It represents SVs as a network and employs a modified minimum spanning forest algorithm to determine the optimal way to merge variants. This ensures that each merged record represents a set of analogous variants occurring across different samples, preserving position, type, and strand information.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::jasminesv
```

## Core Usage Patterns

### Basic Merging
To merge multiple VCF files, first create a text file containing the paths to each VCF (one per line), then run:
```bash
jasmine file_list=filelist.txt out_file=merged.vcf
```

### Post-processing and Conversion
Jasmine can convert duplications to insertions or perform other post-processing tasks on an already merged VCF:
```bash
jasmine --dup_to_ins --postprocess_only out_file=merged.vcf
```

### Breakpoint Refinement with Iris
When working with high-error long reads (e.g., PacBio CLR or ONT), use the Iris module to refine insertion sequences and breakpoints. This requires `samtools`, `minimap2`, and `racon` to be in your PATH.
```bash
jasmine file_list=filelist.txt out_file=merged.vcf iris_args="--genome=ref.fa"
```

### IGV Visualization
Automate the creation of IGV screenshots for merged variants using the `igv_jasmine` module:
```bash
igv_jasmine bam_list=bams.txt ref=genome.fa vcf=merged.vcf out_dir=screenshots/
```
*Note: This generates a `.bat` script that must be run within the IGV GUI (Tools -> Run Batch Script).*

## Expert Tips and Best Practices

- **Input Preparation**: Ensure all input VCFs are unzipped. Jasmine may throw errors or fail to parse headers correctly if passed gzipped (`.gz`) files directly.
- **Distance Thresholds**: By default, Jasmine uses a linear distance threshold for merging. For specific edge cases, you can adjust the `min_dist` parameter; setting `min_dist=-1` can be used to clarify specific merging behaviors in the usage menu.
- **Translocations**: If processing a very large number of samples, use the splitting utility to reduce overhead by keeping translocations together or splitting by chromosome:
  ```bash
  split_jasmine file_list=filelist.txt out_dir=split_files/
  ```
- **Missing Genotypes**: If you need to represent absent variants as `0|0` rather than missing, check the version-specific flags for absent genotype support.
- **Memory Management**: For extremely large datasets, monitor memory usage. Recent updates have optimized the KD-tree search to be non-recursive and removed redundant INFO fields (like old support vectors) to prevent quadratic scaling of memory.

## Reference documentation
- [Jasmine: SV Merging Across Samples](./references/github_com_mkirsche_Jasmine.md)
- [jasminesv - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_jasminesv_overview.md)