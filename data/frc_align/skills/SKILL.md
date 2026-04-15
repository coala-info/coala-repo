---
name: frc_align
description: frc_align assesses the quality of de novo genome assemblies by analyzing the distribution of assembly features and generating Feature Response Curves. Use when user asks to evaluate assembly quality, identify potential assembly errors, or compare different genome assembly versions.
homepage: https://github.com/vezzi/FRC_align
metadata:
  docker_image: "quay.io/biocontainers/frc:5b3f53e--boost1.64_0"
---

# frc_align

## Overview

The `frc_align` skill (utilizing the `FRCbam` tool) provides a robust framework for assessing the quality of de novo genome assemblies. Instead of relying solely on continuity metrics like N50, it analyzes the distribution of "features" (potential assembly errors) derived from read alignments. By plotting the Feature Response Curve, users can visualize the trade-off between the fraction of the assembly covered and the number of allowed features, allowing for a more nuanced ranking of different assembly versions or tools.

## Installation and Setup

To build the tool from source:

1. Create a build directory: `mkdir build && cd build`
2. Run configuration: `cmake ..`
3. Compile: `make`
4. Binaries are located in the `bin` directory.

*Note: Ensure the Boost library is installed locally, as it is a common dependency requirement.*

## Basic Usage Pattern

To generate a standard FRCurve, you must first align your reads to the assembly and sort/index the resulting BAM files.

### Mandatory Requirements
- A sorted and indexed BAM file for a Paired-End (PE) library.
- Estimated genome size (highly recommended for comparing different assemblies).

### Standard Command
```bash
FRCbam --pe-sam assembly_PE.bam \
       --pe-min-insert 200 \
       --pe-max-insert 500 \
       --genome-size 300000000 \
       --output assembly_eval
```

### Recommended Command (with Mate-Pairs)
Including Mate-Pair (MP) libraries significantly improves the detection of long-range scaffolding errors.
```bash
FRCbam --pe-sam assembly_PE.bam \
       --pe-min-insert 200 \
       --pe-max-insert 500 \
       --mp-sam assembly_MP.bam \
       --mp-min-insert 2000 \
       --mp-max-insert 5000 \
       --genome-size 300000000 \
       --output assembly_eval
```

## Advanced Usage: CE-stats Tuning

Compression/Expansion (CE) statistics identify insertion and deletion events. Default parameters may produce false positives, so a two-step tuning process is recommended.

1. **Initial Run**: Execute `FRCbam` with default parameters to generate `_CEstats_PE.txt` and `_CEstats_MP.txt`.
2. **Analysis**: Plot the distribution of CE values from these files to identify the optimal thresholds for your specific library.
3. **Refined Run**: Re-run the tool with the calculated thresholds:
   ```bash
   FRCbam --pe-sam assembly_PE.bam [other_args] \
          --CEstats-PE-min <MIN_VAL> \
          --CEstats-PE-max <MAX_VAL> \
          --CEstats-MP-min <MIN_VAL> \
          --CEstats-MP-max <MAX_VAL>
   ```

## Output Files

- `_FRC.txt`: The primary data file for plotting the FRCurve.
- `_Features.txt`: Human-readable list of identified features (contig, start, end, type).
- `Features.gff`: Feature descriptions in GFF format for visualization in genome browsers (e.g., IGV).
- `_featureType.txt`: Specific FRCurves for individual feature types (e.g., only mis-assemblies).

## Best Practices

- **Library Selection**: Use the PE library with the highest vertical coverage and the MP library with the largest spanning (horizontal) coverage.
- **Comparability**: Always specify the same `--genome-size` when comparing different assemblers. If omitted, the tool uses the assembly length, which varies between tools and makes comparisons invalid.
- **Input Preparation**: BAM files must be sorted by coordinate and indexed.
- **Typo Warning**: Be aware that in some versions, `--pe-max-insert` may have parsing issues; verify output logs to ensure parameters are correctly recognized.

## Reference documentation
- [FRC_align README](./references/github_com_vezzi_FRC_align.md)