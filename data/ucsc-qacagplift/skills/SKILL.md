---
name: ucsc-qacagplift
description: The `ucsc-qacagplift` tool re-coordinates quality scores from scaffold-level QAC files to chromosome-level QAC files using AGP assembly information. Use when user asks to 're-coordinate quality scores', 'lift quality scores to a new assembly', or 'map quality scores from scaffolds to chromosomes'.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-qacagplift

## Overview
The `ucsc-qacagplift` utility (specifically the `qacAgpLift` binary) is a specialized tool from the UCSC Genome Browser "Kent" suite. It is designed to re-coordinate quality scores stored in QAC files. When a genome is assembled from scaffolds into chromosomes, the coordinate system changes; this tool uses the mapping information in an AGP file to "lift" those quality scores into the new chromosomal context, combining multiple scaffold-level scores into a single per-chromosome file.

## Command Line Usage

The primary binary for this package is `qacAgpLift`.

### Basic Syntax
```bash
qacAgpLift input.agp input.qac output.qac
```

### Argument Definitions
1.  **input.agp**: The assembly file (A Golden Path) that defines how scaffolds or contigs are positioned and oriented within the chromosomes.
2.  **input.qac**: The source quality score file, typically containing data at the scaffold or contig level.
3.  **output.qac**: The resulting quality score file where coordinates have been translated to the chromosome level.

## Expert Tips and Best Practices

### 1. Environment Preparation
If you have downloaded the binary directly from the UCSC servers rather than installing via Conda, you must ensure the file is executable:
```bash
chmod +x qacAgpLift
```

### 2. AGP File Validation
Before running the lift, ensure your AGP file is valid. The scaffold names in the `input.qac` must match the object names (column 6) in the AGP file exactly. If there is a mismatch, the tool will not be able to map the quality scores.

### 3. Handling Multiple Scaffolds
`qacAgpLift` is designed to handle the "many-to-one" relationship where multiple scaffolds are joined to form a single chromosome. The tool automatically handles the offsets and gaps defined in the AGP file to place the quality scores in their correct relative positions.

### 4. Verifying Output
After the lift, it is common practice to use `qacToWig` to convert a portion of the new chromosomal QAC file into a fixed-step wiggle file to verify that the quality scores align with the expected genomic features in a genome browser.

### 5. Troubleshooting "Permission Denied"
If you encounter a "permission denied" error despite using `chmod +x`, ensure that the filesystem where the binary resides is not mounted with the `noexec` flag.

## Reference documentation
- [ucsc-qacagplift Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-qacagplift_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)