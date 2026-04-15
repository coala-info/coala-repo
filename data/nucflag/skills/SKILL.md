---
name: nucflag
description: nucflag identifies structural discrepancies and misassemblies in genome assemblies by analyzing read alignment patterns and nucleotide frequencies. Use when user asks to call misassemblies, identify collapsed regions, generate NucFreq-style plots, or calculate assembly quality values.
homepage: https://github.com/logsdon-lab/NucFlag
metadata:
  docker_image: "quay.io/biocontainers/nucflag:0.3.8--pyhdfd78af_0"
---

# nucflag

## Overview

nucflag is a diagnostic tool for genome assemblies that analyzes read alignments to identify structural discrepancies. By examining nucleotide frequencies and coverage patterns, it flags potential misjoins and collapsed regions, providing both tabular data (BED) and visual plots for manual curation. It is particularly effective for high-accuracy long-read data like PacBio HiFi and Oxford Nanopore (ONT) R9/R10.

## Core Workflows

### 1. Prepare Alignments
Before using nucflag, align long reads to the assembly. For HiFi reads, use `minimap2` with the appropriate preset:

```bash
minimap2 -x lr:hqae -I 8G asm.fa.gz reads.fq.gz | samtools view -bh -o asm.bam
samtools index asm.bam
```

### 2. Call Misassemblies
The primary command is `nucflag call`. It requires a BAM file and the reference assembly.

- **Standard Call**:
  `nucflag call -i asm.bam -f asm.fa.gz -o misassemblies.bed`
- **Targeted Regions**:
  `nucflag call -i asm.bam -f asm.fa.gz -b regions.bed -o misassemblies.bed`
- **Technology Presets**: Use the `-x` flag to adjust for specific ONT chemistries:
  - ONT R9: `nucflag call -i ont.bam -f asm.fa.gz -x ont_r9 -o misassemblies.bed`
  - ONT R10: `nucflag call -i ont.bam -f asm.fa.gz -x ont_r10 -o misassemblies.bed`

### 3. Visualization and Plotting
Generate NucFreq-style plots to visually inspect flagged regions.

- **Generate Plots**:
  `nucflag call -i asm.bam -f asm.fa.gz -d plots_directory`
- **Add Annotation Tracks**: Overlay existing BED files (e.g., RepeatMasker, Segmental Duplications) onto the plots:
  `nucflag call -i asm.bam -f asm.fa.gz -d plots --tracks repeats.bed segdups.bed`
- **Export bigWigs**: For use in IGV or other genome browsers:
  `nucflag call -i asm.bam -f asm.fa.gz --output_pileup_dir bigwigs --add_pileup_data cov mismatch mapq`

### 4. Post-Processing and Metrics
- **Assembly Status**: Generate a summary of assembly issues.
  `nucflag status -i misassemblies.bed > status.bed`
- **Breakdown**: Plot the distribution of issue types by length or percentage.
  `nucflag breakdown -i misassemblies.bed -o breakdown_dir -t percent`
- **Estimate QV**: Calculate the assembly Quality Value based on identified errors.
  `nucflag qv -i misassemblies.bed > qv.bed`
- **Consensus Calling**: Intersect calls from multiple technologies (e.g., HiFi + ONT) to find high-confidence errors.
  `nucflag consensus -i hifi_calls.bed ont_calls.bed > consensus.bed`

## Expert Tips

- **Configuration Control**: For fine-tuned detection, generate a template config file using `nucflag config -x [preset] > config.toml` and pass it to the call command with `-c config.toml`.
- **Misassembly Types**:
  - **MISJOIN**: Indicated by a drop in primary coverage or a gap.
  - **COLLAPSE**: Indicated by high secondary base coverage (variants) or high heterozygosity ratios.
  - **HET**: Possible heterozygous sites flagged by the het ratio (second most common base / total coverage).
- **Ideograms**: Use `nucflag ideogram -i misassemblies.bed -o output_dir` to create a whole-genome view of errors. You can add cytobands using the `-c` flag with a formatted BED file.

## Reference documentation
- [NucFlag GitHub Repository](./references/github_com_logsdon-lab_NucFlag.md)
- [NucFlag Wiki](./references/github_com_logsdon-lab_NucFlag_wiki.md)