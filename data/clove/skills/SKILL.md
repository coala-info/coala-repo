---
name: clove
description: Clove refines and classifies genomic structural variation calls by integrating multiple algorithm outputs and validating them against read depth information. Use when user asks to classify complex structural variations, merge calls from different SV detection algorithms, or validate fusion calls using BAM file read depth.
homepage: https://github.com/PapenfussLab/clove
metadata:
  docker_image: "quay.io/biocontainers/clove:0.17--hdfd78af_2"
---

# clove

## Overview

Clove is a specialized post-processing tool designed to refine the output of genomic structural variation detection algorithms. It works by scanning fusion calls for patterns that indicate complex, higher-order variations (such as balanced translocations) and summarizing them accordingly. Beyond classification, Clove performs a secondary validation step by cross-referencing variants with read depth information from the original alignment (BAM) file to distinguish between high-confidence events and potential artifacts.

## Execution and CLI Patterns

Clove is a Java-based application (requires Java 1.8+). The primary interface is the JAR file, which requires several mandatory parameters to define the input sources and expected coverage metrics.

### Basic Command Structure
```bash
java -jar clove.jar -i <breakpoints_file> <algorithm> -b <alignment.bam> -c <mean_cov> <cov_var> -o <output.vcf>
```

### Supported Algorithms
When providing the `-i` flag, you must specify the source algorithm so Clove can parse the format correctly. Supported values include:
- `Socrates`
- `Delly`
- `Crest`
- `Gustaf`
- `BEDPE`
- `GRIDSS`
- `Lumpy`

### Multi-Algorithm Integration
Clove can merge and classify events from multiple different callers simultaneously by repeating the `-i` flag:
```bash
java -jar clove.jar \
  -i results_socrates.txt socrates \
  -i results_delly.vcf delly \
  -b sorted_indexed.bam \
  -c 40 10 \
  -o combined_calls.vcf
```

## Expert Tips and Best Practices

### Performance Optimization
- **Skip Read Depth Checks**: If you only need the classification logic and want to speed up the run, use the `-r` flag (available in v0.16+) to omit the read depth validation.
- **BAM Requirements**: The input BAM file **must** be sorted and indexed. Clove uses random access to fetch depth information; unsorted files will cause significant performance degradation or errors.

### Interpreting Results
- **Filtering**: Clove populates the `FILTER` field in the output VCF. 
    - `PASS`: Variants that were classified correctly and passed the read depth check.
    - `FAIL`: Variants that failed classification or depth criteria.
- **Support Count**: The `SUP` field in the VCF INFO column indicates how many input calls contributed to a specific merged event.
- **Redundancy**: Clove automatically discards redundant events (fusions connecting the same nodes with the same SV type). If your output has fewer records than your input, check the command line log for "Events merged: X".

### Coverage Parameters
The `-c` parameter takes two values: `mean coverage` and `coverage variance`. 
- The variance is used to establish an interval around the mean. 
- Read depths falling significantly below this interval are flagged as potential deletions, while those above are flagged as duplications.

## Reference documentation
- [github_com_PapenfussLab_clove.md](./references/github_com_PapenfussLab_clove.md)
- [github_com_PapenfussLab_clove_tags.md](./references/github_com_PapenfussLab_clove_tags.md)