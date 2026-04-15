---
name: pypints
description: pypints is a bioinformatics tool designed to identify nascent transcription start sites and active regulatory elements from high-resolution RNA sequencing data. Use when user asks to call peaks from bigWig or BAM files, identify divergent or bidirectional transcription signatures, or annotate transcription start sites with epigenomic data.
homepage: https://pints.yulab.org
metadata:
  docker_image: "quay.io/biocontainers/pypints:1.2.1--pyh7e72e81_0"
---

# pypints

## Overview
pypints (Peak Identifier for Nascent Transcript Starts) is a specialized bioinformatics tool designed to pinpoint the exact locations where nascent transcription begins. Unlike standard ChIP-seq peak callers, pypints is optimized for the high-resolution nature of nascent RNA sequencing, allowing for the discovery of active enhancers and promoters by identifying divergent or bidirectional transcription signatures. It supports a wide array of experimental protocols and provides automated merging of replicates and epigenomic annotation for human (hg38) datasets.

## Core CLI Patterns

### Peak Calling from bigWig Files
Use this when you have pre-processed strand-specific signal files.
```bash
pints_caller --bw-pl forward_strand.bw \
             --bw-mn reverse_strand.bw \
             --save-to ./results \
             --file-prefix experiment_name \
             --thread 16
```

### Peak Calling from BAM Files
When starting from alignments, you must specify the experiment type to help the tool identify the relevant RNA ends.
```bash
pints_caller --bam-file input.bam \
             --exp-type PROcap \
             --save-to ./output \
             --thread 8
```

### Handling Different Experimental Protocols
If your assay is not a standard "cap" protocol, use the `--exp-type` flag to define which read end represents the TSS:
- `R_5` / `R_3`: 5' or 3' of single-end reads.
- `R1_5` / `R1_3`: 5' or 3' of Read 1 (paired-end).
- `R2_5` / `R2_3`: 5' or 3' of Read 2 (paired-end).
- **Note**: Use `--reverse-complement` for libraries like PRO-seq where the read is the reverse complement of the original RNA.

### Advanced Annotation and Replicates
- **Epigenomic Annotation**: For hg38, use `--epig-annotation <biosample>` (e.g., `K562`) to pull regulatory data from the PINTS server.
- **Replicate Merging**: By default, PINTS merges multiple BAM files provided to `--bam-file`. To process them individually, add the `--dont-merge-reps` flag.
- **FDR Control**: Adjust sensitivity using `--relaxed-fdr-target` when using epigenomic annotations to recover marginal peaks that overlap known regulatory regions.

## Output Interpretation
PINTS generates three primary BED files:
1. `_divergent_peaks.bed`: High-confidence divergent TREs.
2. `_bidirectional_peaks.bed`: Combined divergent and convergent transcription.
3. `_unidirectional_peaks.bed`: Single-strand peaks, often representing e-lncRNAs or distal TSSs.

**Column 4 (Confidence)** in divergent/bidirectional outputs:
- `Stringent(qval)`: Both strands are statistically significant.
- `Stringent(pval)`: One strand is significant by q-value, the other by p-value.
- `Relaxed`: Only one strand in the pair is significant.
- `Marginal`: Peak passes a relaxed FDR and overlaps an epigenomic annotation.

## Expert Tips
- **Resource Management**: Always specify `--thread` to utilize multi-core environments, as peak calling on large BAM files is computationally intensive.
- **Control Samples**: If you have an "Input" or "Control" library, provide it via `--ct-bam` or `--ct-bw-pl`/`--ct-bw-mn` to reduce false positives from background noise.
- **TSS Resolution**: The output BED files for divergent TREs include specific columns (5 and 6) for Major TSS positions on both strands, which are more precise than the broad peak boundaries.



## Subcommands

| Command | Description |
|---------|-------------|
| pints_caller | Peak Identifier for Nascent Transcripts Starts |
| pints_visualizer | Visualize BAM files with PINTs. |

## Reference documentation
- [PINTS: Peak Identifier for Nascent Transcript Starts](./references/github_com_hyulab_PINTS_blob_main_README.md)
- [pypints setup and scripts](./references/github_com_hyulab_PINTS_blob_main_setup.py.md)