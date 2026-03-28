---
name: ale
description: ALE evaluates the accuracy of genomic assemblies by calculating a likelihood score based on read mapping and sequencing data. Use when user asks to assess assembly quality, identify misassembled regions, or convert ALE output to wiggle format for visualization.
homepage: https://github.com/sc932/ALE
---


# ale

## Overview
ALE (Assembly Likelihood Estimator) is a reference-independent tool for assessing the accuracy of genomic assemblies. It calculates a likelihood score by integrating multiple lines of evidence from the sequencing data, including read mapping quality, mate-pair orientations, insert size distributions, and depth of coverage. By analyzing these factors, ALE provides a quantitative measure of how well the assembly represents the underlying read data, helping researchers identify specific regions that require further polishing or manual intervention.

## Usage and CLI Patterns

### Core Command
The primary execution requires a reference assembly and a corresponding alignment file.
```bash
ale <assembly.fasta> <alignments.bam> <output.ale>
```

### Common Options and Flags
Based on the tool's development history, the following flags are used to modify behavior:
- `-h`: Display help and usage information.
- `--realign`: Perform local realignment of reads to improve accuracy around indels or complex regions.
- `--SNPreport`: Generate a report specifically focusing on single nucleotide polymorphisms and potential base errors.
- `--pl`: Enable specific placement likelihood calculations.

### Post-Processing and Visualization
ALE output is typically stored in a `.ale` format, which contains the likelihood scores. For visual inspection in tools like IGV (Integrative Genomics Viewer):
1. **Convert to Wiggle**: Use the provided utility script to transform the raw scores into a standard genomic track format.
   ```bash
   python ale2wiggle.py <output.ale>
   ```
2. **BigWig Conversion**: For large genomes, it is recommended to convert the resulting `.wig` files to `.bw` (BigWig) format using `wigToBigWig` to improve loading performance in genome browsers.

## Best Practices
- **BAM Preparation**: Ensure your BAM file is properly indexed. While ALE can sometimes autodetect sorting orders, coordinate-sorted BAMs are the standard for most downstream analysis.
- **Read Validation**: ALE is sensitive to secondary alignments. For the most accurate likelihood estimation, use BAM files where primary alignments are clearly defined.
- **Visual Inspection**: Always load the assembly FASTA, the BAM file, and the converted ALE Wiggle tracks into IGV simultaneously. Look for sharp drops in the ALE score, as these typically correlate with assembly breakpoints or misjoined contigs.
- **Environment**: ALE relies on specific Python libraries for its plotting utilities (`plotter4.py`), including `numpy`, `matplotlib`, and `pymix`. Ensure these are available in your environment if generating automated plots.



## Subcommands

| Command | Description |
|---------|-------------|
| ALE | Assembly Likelihood Estimator for evaluating genome assemblies using read alignments. |
| ale2wiggle.py | Converts ALE (Assembly Likelihood Evaluation) output files to Wiggle format. |

## Reference documentation
- [ALE Repository Overview](./references/github_com_sc932_ALE.md)
- [ALE Commit History and Flag Updates](./references/github_com_sc932_ALE_commits_master.md)