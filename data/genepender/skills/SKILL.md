---
name: genepender
description: Genepender annotates variants in VCF files with genomic features and functional contexts defined in BED files. Use when user asks to annotate VCF files with BED regions, determine the functional context of variants, or prepare gene maps for annotation.
homepage: https://github.com/BioTools-Tek/genepender
---


# genepender

## Overview
Genepender is a specialized bioinformatics tool designed to bridge the gap between variant calls (VCF) and genomic annotations (BED). It is particularly useful for researchers who need to determine the functional context of a variant—such as whether it falls within a specific gene, an exon, or an intergenic region. Unlike simpler intersection tools, genepender is optimized to handle overlapping BED regions, ensuring that variants are correctly associated with all relevant genomic features defined in the reference set.

## Usage Patterns

### Basic Annotation
The primary workflow involves taking a VCF file and a BED file (often referred to as a "genemap" or "bedtarget") to produce an annotated VCF.

```bash
genepender -v input.vcf -b annotations.bed > annotated_output.vcf
```

### Preparing Annotation Maps
The tool often relies on pre-processed BED files. If you have raw gene definitions, you may need to use the included utility scripts to format them correctly for the main engine.
- Use `makegenemaps.sh` to convert standard gene definitions into the specific format required by genepender.
- Use `appendgenecol.py` if you need to manually append specific gene columns to an existing dataset before processing.

### Handling Genomic Contexts
Genepender categorizes overlaps into specific types. When running the tool, consider the following logic:
- **Exonic/Intronic**: Variants falling within gene boundaries are checked against exon coordinates.
- **Intergenic**: Variants that do not overlap with any defined BED region are flagged as intergenic.
- **Overlapping Regions**: If a variant hits multiple BED entries (e.g., overlapping genes), genepender reports these overlaps to provide a complete functional context.

## Best Practices
- **BED Sorting**: Ensure your BED file is coordinate-sorted (e.g., using `sort -k1,1 -k2,2n`) to improve processing speed and prevent mapping errors.
- **VCF Compatibility**: The tool is designed for standard VCF formats. Ensure your VCF headers are intact, as genepender typically preserves header information while appending annotation tags.
- **Memory Management**: For very large VCFs or dense BED files (like whole-genome annotations), ensure you have sufficient RAM, as the tool builds an internal map of the BED regions for fast lookup.

## Reference documentation
- [genepender - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_genepender_overview.md)
- [mtekman/genepender: Annotates BED-defined regions to variants in a VCF file](./references/github_com_mtekman_genepender.md)