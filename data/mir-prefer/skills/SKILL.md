---
name: mir-prefer
description: miR-PREFeR is a specialized bioinformatics tool for the accurate and efficient prediction of plant microRNAs.
homepage: https://github.com/hangelwen/miR-PREFeR
---

# mir-prefer

## Overview
miR-PREFeR is a specialized bioinformatics tool for the accurate and efficient prediction of plant microRNAs. It leverages small RNA-seq expression profiles and follows established plant miRNA annotation criteria. The pipeline is particularly useful when you need a high-sensitivity, low-memory solution for genome-wide miRNA discovery that works with one or more small RNA-seq samples from the same species.

## Environment and Dependencies
Before running the pipeline, ensure the following environment requirements are met:
- **Python Version**: Requires Python 2.6.x or 2.7.x. It is **not** compatible with Python 3.
- **ViennaRNA**: Must have `RNALfold` installed and available in your PATH. Use the latest version to avoid segmentation faults in sequences without valid folding.
- **Samtools**: Version 0.1.15 or later is required (specifically for the `samtools depth` command).
- **Aligner**: You must pre-align your small RNA-seq reads to the reference genome using an aligner like Bowtie to produce the required SAM input files.

## Core CLI Usage
The primary entry point for the pipeline is the `miR_PREFeR.py` script.

### Basic Execution
```bash
python miR_PREFeR.py -c <config_file>
```

### Common Configuration and Options
While the tool relies on a configuration file for most parameters, several command-line adjustments and options have been introduced in recent versions:
- **Temporary Files**: Use the option to specify a custom temporary folder if working with large datasets or restricted `/tmp` directories.
- **GFF Output**: The tool produces GFF files for predicted loci. Use the `GFF_FILE_INCLUDE` option to control the level of detail in the output.
- **Sequence IDs**: The tool supports sequence identifiers containing any non-white space characters.

## Expert Tips and Best Practices
- **Input Preparation**: Ensure your SAM files are properly formatted. The pipeline uses `samtools` to manipulate these files, so valid headers and alignment records are critical.
- **Multi-Sample Analysis**: miR-PREFeR can process multiple small RNA-seq samples simultaneously to improve prediction accuracy by looking for consistent expression patterns across libraries.
- **Structural Validation**: Since the tool uses `RNALfold`, ensure your reference genome is accessible. The pipeline predicts miRNAs based on the thermodynamic stability of the predicted hairpin structure.
- **Troubleshooting**: If a region is not predicted as a miRNA, check the output logs; the tool is designed to provide specific reasons why a candidate region failed to meet the annotation criteria.

## Reference documentation
- [miR-PREFeR Main Documentation](./references/github_com_hangelwen_miR-PREFeR.md)