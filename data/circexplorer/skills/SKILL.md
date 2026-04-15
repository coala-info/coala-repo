---
name: circexplorer
description: CIRCexplorer2 identifies, annotates, and characterizes circular RNAs from RNA-seq data by parsing fusion junction reads. Use when user asks to parse aligner outputs for circular RNAs, annotate back-splice junctions, or perform de novo assembly of circular transcripts.
homepage: https://github.com/YangLab/CIRCexplorer2
metadata:
  docker_image: "quay.io/biocontainers/circexplorer:1.1.10--py35_0"
---

# circexplorer

## Overview

CIRCexplorer2 is a specialized toolset designed for the comprehensive analysis of circular RNAs. It functions by identifying back-splice junction reads from RNA-seq alignments and annotating them against known gene models. The tool supports multiple alignment backends and provides modules for de novo assembly of circular transcripts and the characterization of alternative back-splicing (ABS) and alternative splicing (AS) events. Use this skill to navigate the multi-step workflow of parsing aligner outputs, annotating circRNAs, and performing advanced transcriptomic characterization.

## Core Workflow and CLI Patterns

The standard CIRCexplorer2 pipeline typically follows a three-step process: Alignment, Parsing, and Annotation.

### 1. Alignment
Before using CIRCexplorer2, reads must be aligned using a fusion-aware aligner.
- **STAR**: Recommended for high speed. Use `--chimSegmentMin 10` to generate the required `Chimeric.out.junction` file.
- **BWA**: Use `bwa mem -T 19` to capture shorter split hits.
- **TopHat2/TopHat-Fusion**: Use for traditional pipelines.

### 2. Parsing (`CIRCexplorer2 parse`)
Convert the aligner-specific fusion output into a standardized fusion junction file.

```bash
# For STAR output
CIRCexplorer2 parse -t STAR Chimeric.out.junction > fusion_junction.bed

# For BWA output (requires samtools)
CIRCexplorer2 parse -t BWA alignment.sam > fusion_junction.bed
```

### 3. Annotating (`CIRCexplorer2 annotate`)
Annotate the parsed junctions using a gene annotation file (RefSeq, UCSC, or Ensembl) and a reference genome.

```bash
CIRCexplorer2 annotate -r hg19_ref.txt -g hg19.fa fusion_junction.bed > circRNA_known.txt
```

### 4. De Novo Assembly (`CIRCexplorer2 assemble`)
If you need to reconstruct full-length circular RNA transcripts from split-read information:

```bash
CIRCexplorer2 assemble -r hg19_ref.txt -m cufflinks_dir/ fusion_junction.bed
```

## Best Practices and Expert Tips

- **Aligner Selection**: Use STAR for the best balance of speed and sensitivity. Ensure you use the specific parameters required to output chimeric/fusion junctions, as standard BAM files often omit the split-read information CIRCexplorer2 needs.
- **Annotation Files**: The `-r` parameter requires a specific gene prediction format (e.g., UCSC refFlat or similar). You can often use the `fetch_ucsc.py` utility (if available in your environment) to download the correct formatted files for your genome build.
- **Memory Management**: While CIRCexplorer2 is optimized for low memory consumption, the initial alignment step (especially with STAR) requires significant RAM depending on the genome size.
- **Single vs. Paired-End**: The tool supports both, but paired-end sequencing provides higher confidence in identifying novel circular isoforms and characterizing alternative splicing.
- **Output Interpretation**: 
    - `circRNA_known.txt`: Contains coordinates, host genes, and junction read counts.
    - `circularRNA_full.txt`: Generated after assembly, providing the full exon structure of the circular transcript.

## Reference documentation
- [YangLab/CIRCexplorer2 Main Repository](./references/github_com_YangLab_CIRCexplorer2.md)
- [CIRCexplorer2 Issues and Troubleshooting](./references/github_com_YangLab_CIRCexplorer2_issues.md)