---
name: hmmratac
description: HMMRATAC is a specialized peak caller that uses a Hidden Markov Model to identify open chromatin regions from paired-end ATAC-seq data. Use when user asks to call peaks from ATAC-seq fragments, identify nucleosomal states, or analyze chromatin accessibility without a control sample.
homepage: https://github.com/LiuLabUB/HMMRATAC
---


# hmmratac

## Overview
HMMRATAC (Hidden Markov ModeleR for ATAC-seq) is a specialized peak caller that leverages the unique fragment distribution of ATAC-seq data. Unlike standard peak callers, it uses a Hidden Markov Model to integrate various signal tracks—representing different nucleosomal states—to identify open chromatin regions with high sensitivity. It is particularly effective for identifying both broad and narrow peaks without requiring a separate control sample.

## Prerequisites and Input Preparation
HMMRATAC requires three primary inputs. Ensure your data meets these criteria before execution:
1. **Paired-End BAM**: The data must be paired-end. Single-end data is not supported.
2. **Sorted and Indexed**: The BAM file must be coordinate-sorted and have a corresponding `.bai` index.
3. **Genome Information**: A tab-delimited file containing chromosome names and their respective sizes (no header).

### Standard Preparation Workflow
```bash
# 1. Sort the BAM
samtools sort input.bam -o input.sorted.bam

# 2. Index the BAM
samtools index input.sorted.bam

# 3. Generate genome.info from the BAM header
samtools view -H input.sorted.bam | perl -ne 'if(/^@SQ.*?SN:(\w+)\s+LN:(\d+)/){print $1,"\t",$2,"\n"}' > genome.info
```

## Command Line Usage
The basic execution pattern for the Java-based version is:
```bash
java -jar HMMRATAC_V1.2.10_exe.jar -b input.sorted.bam -i input.sorted.bam.bai -g genome.info [options]
```

### Key Parameters and Best Practices
- **Fragment Distribution (-m, -s)**: The default means (`50,200,400,600`) are optimized for human data. For non-human species with different nucleosome spacing, adjust these values.
- **Read Length Adjustment**: If your read length is under 100bp, it is recommended to set the first value of the `-m` parameter to your actual read length.
- **Mapping Quality (-q)**: The default is `30`. Lowering this is generally discouraged as it introduces noise from poorly mapped reads.
- **Training Stringency (-u, -l)**: Use the `--upper` and `--lower` options to set the fold-change range for choosing training regions. Higher ranges result in a more stringent model (higher precision), while lower ranges increase sensitivity (higher recall).
- **EM Training (-f)**: Keep this as `true` (default) for the most accurate model. Only set to `false` if you are re-running a dataset using parameters previously optimized and recorded in a log file.

## Post-Processing and Filtering
HMMRATAC reports all peaks matching the model structure, including weak ones. Filtering by the score (column 13 in gappedPeak, column 5 in summits) is essential for high-quality results.

### Filtering Examples
```bash
# Filter peaks by a score threshold of 10
awk -v OFS="\t" '$13>=10 {print}' output_peaks.gappedPeak > output.filtered.peaks.gappedPeak

# Filter summits by the same threshold
awk -v OFS="\t" '$5>=10 {print}' output_summits.bed > output.filtered.summits.bed
```

## Expert Tips
- **Memory Management**: For large genomes or high-coverage datasets, ensure you allocate sufficient heap space to the JVM (e.g., `java -Xmx16G -jar ...`).
- **MACS3 Integration**: Note that the Java version is no longer actively maintained. For modern pipelines, consider using the `hmmratac` subcommand within the `macs3` suite, which implements the same logic in a more performant environment.
- **Size Selection**: HMMRATAC is designed for "natural" ATAC-seq. If your data was physically or in silico size-selected, use the `--trim` option to account for the missing fragment distributions.



## Subcommands

| Command | Description |
|---------|-------------|
| awk | Pattern scanning and processing language |
| java | Java application launcher |

## Reference documentation
- [HMMRATAC Guide](./references/github_com_LiuLabUB_HMMRATAC_blob_master_HMMRATAC_Guide.md)
- [HMMRATAC README](./references/github_com_LiuLabUB_HMMRATAC_blob_master_README.md)
- [Input Preparation Script](./references/github_com_LiuLabUB_HMMRATAC_blob_master_Make_HMMRATAC_Files.sh.md)