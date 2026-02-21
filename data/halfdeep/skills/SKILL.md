---
name: halfdeep
description: HalfDeep is a specialized bioinformatics suite used to detect genomic intervals covered at half the expected depth by sequenced reads.
homepage: https://github.com/richard-burhans/HalfDeep
---

# halfdeep

## Overview
HalfDeep is a specialized bioinformatics suite used to detect genomic intervals covered at half the expected depth by sequenced reads. In the context of genome assembly, half-depth coverage typically signifies regions where the assembly has correctly separated alleles (haplotypes) or, conversely, where a region should have been collapsed but wasn't. It is a critical tool for assembly curation and quality control. The workflow involves mapping reads to an assembly, calculating depth, and identifying statistical outliers that match the half-depth profile.

## Installation and Dependencies
HalfDeep requires the following tools to be available in your `$PATH`:
- **minimap2**: For read mapping.
- **samtools**: For BAM processing.
- **genodsp** (v0.0.8+): For depth signal processing.

Install via Bioconda:
```bash
conda install bioconda::halfdeep
```

## Core Workflow
The tool expects a specific directory structure similar to the VGP (Vertebrate Genomes Project) pipeline.

### 1. Preparation
Create a File of Filenames (`input.fofn`) containing the paths to your raw sequencing files (e.g., `.fastq.gz`).
```bash
ls pacbio/*.fastq.gz > input.fofn
```

### 2. Mapping and Depth Calculation
Run `bam_depth.sh` for each sequencing file. The second argument is the line number in `input.fofn` to process.
```bash
# Process the first fastq file in input.fofn
bam_depth.sh assembly.fasta 1

# Process the second fastq file
bam_depth.sh assembly.fasta 2
```
**Technology-Specific Scripts:**
- For HiFi reads: Use `bam_depth.hifi.sh`
- For Illumina reads: Use `bam_depth.illumina.sh`
- For specific alignment presets: Use `bam_depth.asm5.sh` or `bam_depth.asm20.sh`

### 3. Interval Detection
Once all individual depth files are generated, run the main detection script to produce the `halfdeep.dat` output.
```bash
halfdeep.sh assembly.fasta
```
For Illumina-specific detection, use `halfdeep.illumina.sh`.

### 4. K-mer Based Analysis
If you prefer k-mer depth analysis over mapping-based depth, use the k-mer variant (requires FastK):
```bash
halfdeep.kmers.sh assembly.fasta
```

## Visualization (R)
HalfDeep includes an R script for plotting results. Load the environment and use the provided functions:

```r
source("path_to_halfdeep/halfdeep.r")

# Load data
scaffolds = read_scaffold_lengths("scaffold_lengths.dat")
scaffoldToOffset = linearized_scaffolds(scaffolds)
depth = read_depth("depth.dat.gz", scaffoldToOffset)
halfDeep = read_halfdeep("halfdeep.dat", scaffoldToOffset)
percentileToValue = read_percentiles("percentile_commands.sh")

# Plot to screen
halfdeep_plot(scaffolds, depth, halfDeep, percentileToValue, "Assembly_Name")

# Plot specific scaffolds to PDF
halfdeep_plot(scaffolds, depth, halfDeep, percentileToValue, "Assembly_Name", 
              plotFilename="output.pdf", 
              scaffoldsToPlot=c("Scaffold_1", "Scaffold_2"))
```

## Expert Tips
- **Parallelization**: The `bam_depth.sh` step is designed to be arrayed on a cluster (SLURM/SGE) using the line index argument to process multiple fastq files simultaneously.
- **Memory Management**: Ensure `genodsp` has enough memory for large assemblies, as it processes the depth signals.
- **Output Format**: The `halfdeep.dat` file uses 1-based closed intervals.

## Reference documentation
- [HalfDeep GitHub Repository](./references/github_com_richard-burhans_HalfDeep.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_halfdeep_overview.md)