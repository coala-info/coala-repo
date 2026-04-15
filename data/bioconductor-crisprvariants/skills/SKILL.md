---
name: bioconductor-crisprvariants
description: This tool analyzes and visualizes the spectrum of variants introduced by CRISPR-Cas9 mutagenesis experiments. Use when user asks to process BAM files to quantify indel frequencies, calculate mutation efficiency, or generate alignment plots and frequency heatmaps for genome editing studies.
homepage: https://bioconductor.org/packages/release/bioc/html/CrispRVariants.html
---

# bioconductor-crisprvariants

name: bioconductor-crisprvariants
description: Analyze and visualize CRISPR-Cas9 mutagenesis experiments. Use this skill to process BAM files, quantify indel frequencies, visualize variant alignments, and calculate mutation efficiency for genome editing studies.

# bioconductor-crisprvariants

## Overview
The `CrispRVariants` package provides tools for summarizing and plotting the spectrum of variants introduced by CRISPR-Cas9 or similar genome editing experiments. It centers on the `CrisprSet` class, which stores aligned reads trimmed to a target region and annotates insertions and deletions relative to a specific cut site.

## Core Workflow

### 1. Define Target and Reference
Identify the genomic region of interest and the reference sequence.
- **Target**: A `GenomicRanges::GRanges` object matching the BAM file coordinates.
- **Reference**: A `Biostrings::DNAString` object containing the sequence at the target location.
- **Target Location (target.loc)**: The index within the reference sequence representing the cut site (base zero). For a 23bp guide+PAM, this is typically 17.

### 2. Create a CrisprSet
Use `readsToTarget` to process BAM files into a `CrisprSet` object.
```r
library(CrispRVariants)
# reads can be bam filenames, GAlignments, or GAlignmentsList
crispr_set <- readsToTarget(
  reads = bam_files,
  target = target_gr,
  reference = ref_dna,
  target.loc = 17,
  names = sample_names,
  collapse.pairs = TRUE # Set TRUE for paired-end data
)
```

### 3. Visualization
Generate summary plots including transcripts, alignments, and frequency heatmaps.
```r
# Basic summary plot
plotVariants(crispr_set)

# Include transcript database (TxDb) to show guide location relative to exons
plotVariants(crispr_set, txdb = txdb)
```

## Key Analysis Functions

### Mutation Efficiency
Calculate the proportion of reads containing insertions or deletions.
- Use `mutationEfficiency(crispr_set)` to get percentages per sample.
- Filter specific variants (e.g., variants found in control samples) using `filter.cols` or `filter.vars`.

### Consensus Sequences
Retrieve the DNA sequences for the observed alleles.
- `consensusSeqs(crispr_set)` returns a `DNAStringSet`.
- By default, sequences are reverse complemented if the guide is on the negative strand.

### Chimeric Alignments
Analyze large deletions or rearrangements that result in chimeric (split) mappings.
- Use `getChimeras(crispr_set, sample = "SampleName")` to extract chimeric reads.
- Use `plotChimeras(chimeric_reads)` to visualize the mapping locations.
- To include large deletions in efficiency counts, increase `chimera.to.target` during initialization.

## Plot Customization

### Alignment Plots (`plotAlignments`)
- **ins.size**: Adjust the size of insertion symbols.
- **max.insertion.size**: Collapse insertions larger than this value (default 20).
- **highlight.pam**: Boolean to toggle the PAM box.
- **codon.frame**: Add a frame to visualize potential amino acid changes.

### Frequency Heatmaps (`plotFreqHeatmap`)
- **type**: Set to "counts" or "proportions".
- **group**: Provide a factor to color x-axis labels by experimental group.
- **top.n**: Limit the plot to the N most frequent variants.

### Allele Barplots (`barplotAlleleFreqs`)
- Use to classify variants as frameshift or in-frame.
- Requires a `TxDb` object for functional classification.
```r
barplotAlleleFreqs(crispr_set, txdb = txdb, palette = "bluered")
```

## Reference documentation
- [CrispRVariants User Guide](./references/user_guide.md)
- [CrispRVariants Vignette 2](./references/vignette_2.md)