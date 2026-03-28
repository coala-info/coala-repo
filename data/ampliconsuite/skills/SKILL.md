---
name: ampliconsuite
description: AmpliconSuite reconstructs and characterizes the architecture of focal genomic amplifications to identify extrachromosomal DNA and complex structural variations from sequencing data. Use when user asks to identify ecDNA, analyze focal amplifications, classify amplification mechanisms, or visualize genomic cycles and breakpoint graphs.
homepage: https://github.com/AmpliconSuite
---

# ampliconsuite

## Overview

AmpliconSuite is a specialized bioinformatics ecosystem designed to reconstruct and characterize the architecture of focal genomic amplifications. It is primarily used to identify extrachromosomal DNA (ecDNA) and other complex structural variations from whole-genome sequencing (WGS) data. The suite integrates structural variation (SV) detection with copy number (CN) analysis to produce breakpoint graphs, which are then decomposed into genomic paths and cycles.

## Core Workflow: AmpliconSuite-pipeline

The recommended way to use the suite is through the `AmpliconSuite-pipeline` wrapper. This handles the complex orchestration of input preparation, seed interval detection, and the execution of both AmpliconArchitect and AmpliconClassifier.

### 1. Input Preparation
Before running the pipeline, ensure you have:
- A coordinate-sorted and indexed BAM file.
- A reference genome (e.g., hg19, GRCh38).
- A CNV seed file (typically a BED file of high-copy number regions).

### 2. Running the Pipeline
Use `PrepareAA.py` to initiate the full analysis. This script automates the filtering of seed regions and ensures they meet the requirements for AA.

```bash
python PrepareAA.py \
    --samples sample_list.txt \
    --bam sample.bam \
    --output_directory ./output \
    --ref GRCh38 \
    --cnv_bed seeds.bed
```

### 3. Classification with AmpliconClassifier
If running AA standalone, you must manually invoke `amplicon_classifier.py` to predict the mechanism of amplification (e.g., ecDNA, BFB, or Linear).

```bash
python amplicon_classifier.py \
    --input_list aa_output_files.txt \
    --ref GRCh38 \
    --output_prefix sample_classification
```

## Tool-Specific Best Practices

### AmpliconArchitect (AA)
- **Seed Selection**: AA is sensitive to the quality of input seeds. Use `PrepareAA.py` to apply recommended filters rather than passing raw CNV calls directly to AA.
- **Performance**: Version 1.5+ includes caching of discordant read pairs. If processing samples with extremely high SV counts, ensure you are using the latest version to benefit from the ~2x speedup.
- **Viral Integration**: For samples with viral content, use the `GRCh38_viral` reference to prevent graph decomposition failures at contig boundaries.

### AmpliconClassifier (AC)
- **Bulk vs. Subclonal**: Note that AC reports bulk estimated copy numbers, not subclonal distributions.
- **Complexity Scores**: Use the complexity and similarity scores provided in the AC output table to prioritize amplicons for manual review or visualization.

### Visualization with CycleViz
To generate circular plots of identified ecDNA or cycles:
```bash
python CycleViz.py \
    --cycle_file sample_amplicon1_cycles.txt \
    --graph_file sample_amplicon1_graph.txt \
    --ref hg19 \
    --output_prefix sample_viz
```

## Expert Tips
- **Memory Management**: AA can be memory-intensive for highly rearranged genomes. Ensure your environment has sufficient RAM (typically 32GB+) for complex breakpoint graphs.
- **Downsampling**: AA uses downsampling for coverage calculations in high-depth regions. If results seem inconsistent across runs, check the logging for the fraction of amplicon weight decomposed.
- **Integration**: For long-read data (Nanopore/PacBio), consider using **CoRAL** instead of the standard AA pipeline for better reconstruction of candidate structures.



## Subcommands

| Command | Description |
|---------|-------------|
| AmpliconSuite-pipeline.py | A pipeline wrapper for AmpliconArchitect, invoking alignment CNV calling and CNV filtering prior. Can launch AA, as well as downstream amplicon classification. |
| amplicon_classifier.py | Classify AA amplicon type |

## Reference documentation
- [AmpliconSuite Overview](./references/github_com_AmpliconSuite_.github_blob_main_profile_README.md)
- [AmpliconArchitect Documentation](./references/github_com_AmpliconSuite_AmpliconArchitect.md)
- [AmpliconSuite-pipeline Guide](./references/github_com_AmpliconSuite_AmpliconSuite-pipeline.md)
- [AmpliconClassifier Details](./references/github_com_AmpliconSuite_AmpliconClassifier.md)