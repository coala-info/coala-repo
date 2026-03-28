---
name: svaba
description: SvABA identifies structural variants and indels by performing genome-wide local assembly and realignment. Use when user asks to call somatic or germline structural variants, detect indels using local assembly, or convert breakpoint files to VCF format.
homepage: https://github.com/walaj/svaba
---

# svaba

## Overview

SvABA (formerly Snowman) is a specialized tool for identifying structural variants and indels by performing genome-wide local assembly. Unlike traditional alignment-based callers, SvABA uses a custom implementation of the String Graph Assembler (SGA) and BWA-MEM to assemble contigs from discordant, clipped, and unmapped reads. It then realigns these contigs to the reference genome to pinpoint breakpoints with high accuracy. It is particularly effective for detecting complex rearrangements and indels that are often missed by standard mapping-based methods.

## Common CLI Patterns

### Somatic SV and Indel Detection
To call somatic variants using a tumor/normal pair, use the `-t` (tumor) and `-n` (normal) flags.
```bash
svaba run -t tumor.bam -n normal.bam -G reference.fasta -a somatic_output
```

### Germline SV and Indel Detection
For single-sample germline analysis, provide the sample with the `-t` flag.
```bash
svaba run -t blood_sample.bam -G reference.fasta -a germline_output
```

### Targeted (Exome) Detection
When working with exome or targeted panels, provide a BED file of the target regions to focus the assembly.
```bash
svaba run -t tumor.bam -n normal.bam -G reference.fasta -L targets.bed -a exome_output
```

### Performance Tuning
Use the `-p` flag to specify the number of threads.
```bash
svaba run -p 8 -t tumor.bam -n normal.bam -G reference.fasta -a fast_run
```

## Expert Tips and Best Practices

- **Reference Indexing**: The reference genome (`-G`) must be indexed with BWA-MEM. SvABA relies on these indices for contig realignment.
- **ASCII Alignment Inspection**: The `*.alignments.txt.gz` file contains ASCII representations of the contig-to-reference and read-to-contig alignments. This is the most powerful tool for manual validation. To inspect a specific variant, find the contig ID (SCTG) from the VCF and grep it:
  `gunzip -c id.alignments.txt.gz | grep "contig_name" > inspection.txt`
- **Contig Visualization**: The `*.contigs.bam` file contains the assembled contigs. To view them in IGV, you must sort and index the BAM:
  `samtools sort id.contigs.bam -o id.contigs.sorted.bam && samtools index id.contigs.sorted.bam`
- **Filtering and Refiltering**: The `*.bps.txt.gz` file contains raw, unfiltered breakpoints. If you need to adjust sensitivity or specificity after a run, use `svaba refilter` on this file rather than re-running the entire assembly.
- **Memory Management**: Local assembly is memory-intensive. If the process crashes on high-coverage regions, consider using the `-L` flag to restrict analysis to specific chromosomes or regions of interest.



## Subcommands

| Command | Description |
|---------|-------------|
| svaba refilter | Refilter SVABA results |
| svaba run | SV and indel detection using rolling SGA assembly and BWA-MEM realignment |
| svaba tovcf | Convert a *bps.txt.gz file to a *vcf file |

## Reference documentation
- [SvABA README](./references/github_com_walaj_svaba_blob_master_README.md)
- [SvABA Repository Overview](./references/github_com_walaj_svaba.md)