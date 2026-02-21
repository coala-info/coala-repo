---
name: tophat-recondition
description: TopHat-Recondition is a specialized post-processor designed to resolve compatibility issues between TopHat's unmapped read output and standard bioinformatics suites.
homepage: https://github.com/cbrueffer/tophat-recondition
---

# tophat-recondition

## Overview
TopHat-Recondition is a specialized post-processor designed to resolve compatibility issues between TopHat's unmapped read output and standard bioinformatics suites. TopHat frequently produces `unmapped.bam` files with non-standard SAM flags, incorrect mapping quality (MAPQ) values, and trailing read-name suffixes (e.g., /1, /2) that trigger failures in modern validation tools. This skill provides the procedural knowledge to repair these files, ensuring they are standard-compliant for variant calling, read group addition, or other downstream BAM manipulations.

## Usage and CLI Patterns

The tool requires a directory containing both the mapped (`accepted_hits.bam`) and unmapped (`unmapped.bam`) files.

### Basic Execution
The most common usage involves pointing the tool at a TopHat output directory. It will automatically locate the default BAM files and generate a fixed version.

```bash
python tophat-recondition.py /path/to/tophat_output_dir
```

### Custom File Names
If your BAM files have been renamed or are stored outside the standard TopHat structure, use the `-m` and `-u` flags:

```bash
python tophat-recondition.py -m custom_mapped.bam -u custom_unmapped.bam /path/to/tophat_output_dir
```

### Output Management
By default, the tool writes `unmapped_fixup.bam` to the input directory. Use the `-r` flag to specify a different output location:

```bash
python tophat-recondition.py -r /path/to/processed_results /path/to/tophat_output_dir
```

## Expert Tips and Best Practices

### Memory Considerations
**Critical:** The tool reads the entire unmapped BAM file into memory. Ensure the execution environment has enough RAM to accommodate the size of your `unmapped.bam` file. If processing large datasets on a cluster, request memory at least 1.5x the size of the unmapped file to be safe.

### Downstream Compatibility Fixes
The tool performs several specific modifications that are essential for tool-specific errors:
- **Picard Compatibility:** It unsets mate-related flags (0x1, 0x2, 0x8, etc.) for unmapped reads whose mates are missing from the mapped file. This prevents "Mate not found" errors in Picard's `ValidateSamFile` or `AddOrReplaceReadGroups`.
- **MAPQ Correction:** It changes MAPQ from 255 (TopHat default) to 0. While 255 is technically valid (meaning "not available"), many GATK and Picard tools prefer 0 for unmapped reads to avoid ambiguity.
- **Read Name Cleaning:** It strips `/1` and `/2` suffixes. Modern aligners and downstream tools expect identical QNAMEs for paired-end reads; keeping these suffixes often causes tools to treat pairs as mismatched singletons.

### Verification
After running the tool, the resulting `unmapped_fixup.bam` should be used in place of the original `unmapped.bam` for any merging or downstream analysis. You can verify the fix by running `samtools flags` on the new file to ensure the 0x8 ("mate is unmapped") flag is correctly set for paired unmapped reads.

## Reference documentation
- [TopHat-Recondition README and Usage](./references/github_com_cbrueffer_tophat-recondition.md)