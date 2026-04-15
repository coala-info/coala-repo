---
name: longdust
description: This tool identifies long, highly repetitive DNA sequences like STRs, VNTRs, and satellite DNA in a genome. Use when user asks to find long repetitive DNA sequences, analyze low-complexity regions, or detect repeats with long repeat units.
homepage: https://github.com/lh3/longdust
metadata:
  docker_image: "quay.io/biocontainers/longdust:1.4--h577a1d6_0"
---

# longdust

longdust/SKILL.md
```yaml
name: longdust
description: Identifies long highly repetitive DNA sequences such as STRs, VNTRs, and satellite DNA in a genome. Use when analyzing genomic data for low-complexity regions, especially those with long repeat units that other tools might miss.
```
## Overview
The `longdust` tool is designed to detect long, highly repetitive DNA sequences, including Short Tandem Repeats (STRs), Variable Number Tandem Repeats (VNTRs), and satellite DNA. It is particularly useful for identifying low-complexity regions (LCRs) in genomes that may have long repeat units, complementing tools that are limited to shorter repeat patterns.

## Usage Instructions

`longdust` is a command-line tool. The primary input is a FASTA file containing the genome sequence.

### Basic Usage

The most common way to run `longdust` is by providing the input FASTA file.

```bash
longdust <in.fa>
```

This will output the identified repetitive regions to standard output.

### Output Format

The output consists of lines, each describing a detected repeat. The format is generally:

`chromosome:start-end (repeat_unit_length) repeat_sequence`

*Note: The exact output format may vary slightly based on the version and specific parameters used. Refer to the tool's documentation for precise details.*

### Key Parameters and Options

While `longdust` has a core function, understanding its parameters can help refine the analysis.

*   **`-d <float>`**: Minimum score threshold. Adjusting this can control the sensitivity of repeat detection. A lower value will detect more regions, potentially including more false positives, while a higher value will be more stringent.
*   **`-w <int>`**: Window size. This parameter influences how the tool scans the genome.
*   **`-m <int>`**: Minimum repeat unit length. This is crucial for focusing on longer repeat units, which is a key strength of `longdust`.
*   **`-o <file>`**: Output file. Redirect the results to a specified file instead of standard output.

**Example with parameters:**

```bash
longdust -m 100 -d 0.8 input_genome.fa -o repeats.txt
```
This command will search for repeats with a minimum unit length of 100, a score threshold of 0.8, and save the output to `repeats.txt`.

### Expert Tips

*   **Focus on `-m`**: For identifying *long* repeats, the `-m` (minimum repeat unit length) parameter is your most important tool. Experiment with different values based on the expected repeat lengths in your organism of interest.
*   **Score Threshold (`-d`)**: The `-d` parameter is critical for balancing sensitivity and specificity. If you are getting too many results, increase `-d`. If you are missing expected repeats, decrease it.
*   **Input File Format**: Ensure your input FASTA file is correctly formatted. `longdust` expects standard FASTA format.
*   **Complementary Tools**: `longdust` excels at *long* repeats. For shorter STRs or more specific tandem repeat analysis, consider using tools like TRF, TANTAN, or ULTRA in conjunction with `longdust`. The preprint mentioned in the documentation ([Li H and Li B (2025) Finding low-complexity DNA sequences with longdust. arXiv:2509.07357](https://arxiv.org/abs/2509.07357)) provides comparisons.

## Reference documentation
- [GitHub Repository](https://github.com/lh3/longdust)
- [Finding low-complexity DNA sequences with longdust. arXiv:2509.07357](https://arxiv.org/abs/2509.07357)