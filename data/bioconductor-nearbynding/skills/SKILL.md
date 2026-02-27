---
name: bioconductor-nearbynding
description: This tool analyzes the spatial relationship between protein binding sites and RNA secondary structure by correlating CLIP-seq data with structural annotations. Use when user asks to map protein-binding intervals to a concatenated transcriptome, predict RNA structural contexts using CapR, or calculate cross-correlation between binding sites and RNA structures.
homepage: https://bioconductor.org/packages/release/bioc/html/nearBynding.html
---


# bioconductor-nearbynding

name: bioconductor-nearbynding
description: Analysis of RNA structure proximal to protein binding sites using CLIP-seq data. Use when Claude needs to map protein-binding intervals (BAM/BED) and RNA structural contexts (CapR/BED) onto a concatenated transcriptome to calculate cross-correlation, visualize structural landscapes, and determine distances between binding contexts.

# bioconductor-nearbynding

## Overview
The `nearBynding` package facilitates the study of RNA-binding protein (RBP) preferences by correlating protein binding sites (from CLIP-seq) with RNA secondary structure. It automates the process of concatenating transcriptomic regions (like 3'UTRs), folding RNA via CapR, mapping data via liftOver, and calculating cross-correlation using StereoGene.

## Core Workflow

### 1. Transcriptome Concatenation
Before analysis, create a chain file to map specific transcript regions (e.g., 3'UTR, CDS) end-to-end, excluding intergenic regions.

```r
library(nearBynding)

# Create chain file for specific transcript regions
GenomeMappingToChainFile(
  genome_gtf = "path/to/genome.gtf",
  out_chain_name = "target.chain",
  RNA_fragment = "three_prime_utr",
  transcript_list = my_transcripts,
  alignment = "hg38"
)

# Get chromosome sizes for the concatenated transcriptome
getChainChrSize(chain = "target.chain", out_chr = "target.size")
```

### 2. RNA Folding and Structure Annotation
Extract sequences and use CapR to predict structural contexts (stem, hairpin, multibranch, exterior, internal, bulge).

```r
# Extract sequences for folding
ExtractTranscriptomeSequence(
  transcript_list = my_transcripts,
  ref_genome = "genome.fa",
  genome_gtf = "genome.gtf",
  RNA_fragment = "three_prime_utr",
  exome_prefix = "my_analysis"
)

# Run CapR folding (requires CapR in PATH)
runCapR(in_file = "my_analysis.fa")

# Process CapR output into bedGraph files and liftOver to transcriptome
processCapRout(
  CapR_outfile = "my_analysis.out",
  chain = "target.chain",
  output_prefix = "my_analysis",
  chrom_size = "target.size",
  genome_gtf = "genome.gtf",
  RNA_fragment = "three_prime_utr"
)
```

### 3. Mapping Protein Binding
Map CLIP-seq reads (BAM) or peaks (BED) to the same concatenated transcriptome.

```r
# Convert BAM to bedGraph
sorted_bam <- Rsamtools::sortBam("input.bam", "sorted_output")
CleanBAMtoBG(in_bam = sorted_bam)

# LiftOver protein binding to exomic coordinates
liftOverToExomicBG(
  input = "sorted_output.bedGraph",
  chain = "target.chain",
  chrom_size = "target.size",
  output_bg = "protein_liftOver.bedGraph"
)
```

### 4. Cross-Correlation and Visualization
Use StereoGene to calculate the spatial relationship between binding and structure.

```r
# Run StereoGene on all CapR contexts
runStereogeneOnCapR(
  protein_file = "protein_liftOver.bedGraph",
  chrom_size = "target.size",
  name_config = "my_analysis.cfg",
  input_prefix = "my_analysis"
)

# Visualize results (Heatmap or Line plot)
visualizeCapRStereogene(
  CapR_prefix = "my_analysis",
  protein_file = "protein_liftOver",
  heatmap = TRUE,
  out_file = "structure_heatmap",
  x_lim = c(-500, 500)
)
```

### 5. Calculating Context Distance
Quantify the similarity between different binding contexts using Wasserstein distance.

```r
# Compare similarity between two structural contexts (e.g., stem vs hairpin)
dist <- bindingContextDistance(
  RNA_context = "my_analysis_stem_liftOver",
  protein_file = "protein_liftOver",
  RNA_context_2 = "my_analysis_hairpin_liftOver"
)
```

## Implementation Tips
- **External Dependencies**: Ensure `bedtools`, `CapR`, and `StereoGene` are installed and available in the system PATH.
- **Input Order**: When using `runStereogene` manually, the track file order must be: 1) RNA structure, 2) Protein binding. Reversing this will invert the results.
- **Performance**: `runCapR` and `visualizeCapRStereogene` can be computationally intensive for large transcriptomes; consider subsetting to expressed transcripts.
- **Custom Structures**: You can provide your own structural annotations in BED format and use `liftOverToExomicBG` to integrate them into the pipeline.

## Reference documentation
- [nearBynding](./references/nearBynding.md)