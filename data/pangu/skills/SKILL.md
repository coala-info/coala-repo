---
name: pangu
description: Pangu is a specialized star-typer designed specifically for the CYP2D6 gene, leveraging the unique length and accuracy of PacBio HiFi reads.
homepage: https://github.com/PacificBiosciences/pangu
---

# pangu

## Overview

Pangu is a specialized star-typer designed specifically for the CYP2D6 gene, leveraging the unique length and accuracy of PacBio HiFi reads. It identifies complex structural variants (SVs) and produces PharmVar-compatible definitions. This tool is essential for PGx research where standard short-read callers often fail due to the highly polymorphic nature and structural diversity (e.g., gene conversions, deletions, and duplications) of the CYP2D6 locus.

## Core CLI Usage

The primary command is `pangu`. All runs require an output prefix and at least one input BAM file containing HiFi reads aligned to GRCh38.

### Basic Calling
For standard Whole Genome Sequencing (WGS) data:
```bash
pangu -p output_dir/sample_name --verbose input.bam
```

### Using External Variants for Phasing
To improve phasing accuracy, provide a VCF (e.g., from DeepVariant) to restrict variant positions:
```bash
pangu -p output_dir/sample_name --vcf input.vcf input.bam
```

### Processing Multiple Samples
Pangu supports batch processing via wildcards or a File of Filenames (fofn):
```bash
# Wildcard approach
pangu -p output_dir/batch_name --verbose path/to/data/*.bam

# FOFN approach (recommended for large cohorts)
pangu -p output_dir/batch_name --bamFofn bams.fofn
```

## Execution Modes

Select the appropriate mode based on your library preparation:
- `wgs`: Default mode for whole genome data.
- `capture`: For targeted enrichment data.
- `amplicon`: For PCR-based targeted sequencing.
- `consensus`: For high-accuracy consensus sequences.

Example for amplicon data:
```bash
pangu -p output_dir/sample_name --mode amplicon --verbose input.bam
```

## Visualization and Debugging

### Labeled BAM Generation
Use the `-x` flag to export a BAM file where reads are labeled by allele and colored by haplotype. This is highly useful for manual inspection in IGV.
```bash
pangu -p output_dir/sample_name -x input.bam
```
*Tip: Use `--grayscale` if you prefer non-colored haplotype labels.*

### Detailed Logging
If a diplotype call is unexpected or missing, increase the log level to inspect the internal phasing and calling logic:
```bash
pangu -p output_dir/sample_name --logLevel DEBUG input.bam
```

## Interpreting Outputs

1.  **`<prefix>_call.log`**: Contains the final diplotype call (e.g., `CYP2D6 *4x2/*5`).
2.  **`<prefix>_report.json`**: The most detailed output. It includes:
    - `diplotype`: The final call.
    - `copynumber`: Total gene copy number detected.
    - `haplotypes`: Detailed breakdown of each haplotype, including read counts, mean coverage, and associated rsIDs.
    - `warnings`: Critical alerts such as low coverage regions in variant sites.
3.  **PharmCAT TSV**: Pangu generates a TSV formatted specifically for downstream PharmCAT analysis.

## Expert Tips

- **Reference Genome**: Pangu expects alignments to GRCh38. If your BAM uses a different reference, you must realign to GRCh38 (specifically chr22) for the tool to function correctly.
- **Coverage Requirements**: Pay close attention to the `warnings` field in the JSON report. A warning like `bases in variant region with coverage < 3` suggests the call may be unreliable.
- **Hybrid Alleles**: Pangu is particularly adept at identifying CYP2D6/CYP2D7 hybrids. If the tool detects a hybrid, it will typically label it with the "upstream" component in the diplotype string.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_PacificBiosciences_pangu.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_pangu_overview.md)