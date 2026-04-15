---
name: gapcloser
description: TGS-GapCloser bridges gaps in genomic scaffolds by utilizing long-read sequencing data to fill "N" regions with high-confidence sequences. Use when user asks to fill gaps in a draft assembly, bridge genomic scaffolds using TGS reads, or perform hybrid gap-filling with both long and short reads.
homepage: https://github.com/BGI-Qingdao/TGS-GapCloser
metadata:
  docker_image: "biocontainers/gapcloser:v1.12-r6_cv3"
---

# gapcloser

## Overview
TGS-GapCloser is a bioinformatics tool designed to bridge gaps in genomic scaffolds by utilizing the long-range information provided by TGS reads. It identifies reads that span "N" regions in a draft assembly and uses them to fill those gaps with high-confidence sequences. The tool is highly flexible, allowing for various error-correction strategies including Racon for long-read polishing and Pilon for hybrid polishing using short-read NGS data.

## Core CLI Usage

The basic syntax for TGS-GapCloser requires draft scaffolds, TGS reads, and an output prefix:

```bash
tgsgapcloser --scaff <SCAFF_FILE> --reads <TGS_READS_FILE> --output <OUT_PREFIX> [options...]
```

### Common Workflow Patterns

**1. Using Pre-corrected Long Reads**
If your TGS reads are already error-corrected, use the `--ne` flag to skip the internal error correction module and save time.
```bash
tgsgapcloser --scaff assembly.fasta --reads corrected_reads.fasta --output gapfilled_assembly --ne
```

**2. Raw ONT Reads with Racon Polishing**
For raw Oxford Nanopore reads, specify the path to the Racon executable.
```bash
tgsgapcloser --scaff assembly.fasta --reads raw_ont.fasta --output ont_filled --racon /path/to/bin/racon
```

**3. Raw PacBio Reads with Racon Polishing**
When using PacBio, you must explicitly set the TGS type to `pb`.
```bash
tgsgapcloser --scaff assembly.fasta --reads raw_pb.fasta --output pb_filled --tgstype pb --racon /path/to/bin/racon
```

**4. Hybrid Polishing (TGS + NGS)**
To achieve higher accuracy using short reads, provide the NGS data and paths to Pilon, Java, and Samtools.
```bash
tgsgapcloser --scaff assembly.fasta --reads raw_tgs.fasta --output hybrid_filled \
  --pilon /path/to/pilon.jar \
  --ngs short_reads.fastq.gz \
  --samtools /path/to/samtools \
  --java /path/to/java
```

## Expert Tips and Best Practices

*   **Input Format Restriction**: TGS reads **must** be in FASTA format. Providing FASTQ files for the `--reads` parameter will cause the program to crash.
*   **Minimap2 Customization**: Use the `--minmap_arg` flag to pass specific presets to the internal minimap2 call. This is critical for performance and memory management:
    *   For HiFi reads: `--minmap_arg '-x asm20'`
    *   To avoid massive PAF files: Use specific alignment presets rather than default all-to-all.
*   **Memory Management**: Pilon is memory-intensive. The default is 300G. Adjust this based on your hardware using `--pilon_mem` (e.g., `--pilon_mem 64G`).
*   **Gap Size Validation**: Use the `--g_check` option to enable a gap size difference check, which helps ensure the inserted sequence length is consistent with the estimated gap size in the scaffold.
*   **Filtering Candidates**: If you have low coverage or very noisy reads, consider adjusting `--min_idy` (identity) and `--min_match` (length) to be more or less stringent. Defaults are 0.3/300bp for ONT and 0.2/200bp for PacBio.

## Output Interpretation

*   **`<prefix>.scaff_seq`**: The final gap-filled assembly in FASTA format.
*   **`<prefix>.gap_fill_details`**: A text file describing the source of every segment in the final assembly.
    *   `S`: Segment from the original input scaffold.
    *   `N`: Remaining N-gap that could not be filled.
    *   `F`: Filled sequence derived from TGS reads.

## Reference documentation
- [TGS-GapCloser Main Documentation](./references/github_com_BGI-Qingdao_TGS-GapCloser.md)