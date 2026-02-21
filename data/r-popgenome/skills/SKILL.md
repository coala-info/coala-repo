---
name: r-popgenome
description: R package popgenome (documentation from project home).
homepage: https://cran.r-project.org/web/packages/popgenome/index.html
---

# r-popgenome

name: r-popgenome
description: Efficient population genetics data analysis in R. Use this skill when performing evolutionary genomics tasks, including calculating neutrality tests, linkage disequilibrium, FST, and diversity statistics across individual loci or whole-genome data.

# r-popgenome

## Overview
PopGenome is a comprehensive R package designed for population genomic analysis. It acts as a "Swiss army knife" for evolutionary genetics, capable of processing large datasets (including whole genomes) by using a sliding window approach or analyzing specific loci. It is optimized for speed through C integration and supports various input formats like VCF, FASTA, and HapMap.

## Installation
To install the package from CRAN:
```R
install.packages("PopGenome")
library(PopGenome)
```

## Core Workflow

### 1. Data Loading
PopGenome works by reading data from a directory. Each locus (or chromosome) should be in its own file within that directory.
- `readData("path/to/dir", format="VCF")`: Load VCF files.
- `readData("path/to/dir", format="FASTA")`: Load FASTA alignment files.
- `readData("path/to/dir", format="HapMap")`: Load HapMap files.

### 2. Defining Populations
Statistics are calculated based on defined groups of individuals.
```R
# Define populations using a list of individual names
genome <- set.populations(genome, list(pop1_names, pop2_names))
# Set outgroup
genome <- set.outgroup(genome, c("Outgroup_Ind1"))
```

### 3. Calculating Statistics
PopGenome uses a two-step process: first, call the calculation function, then access the results.
- `genome <- neutrality.stats(genome)`: Tajima's D, Fu and Li's F and D.
- `genome <- diversity.stats(genome)`: Nucleotide diversity (Pi), Watterson's Theta.
- `genome <- F_ST.stats(genome)`: Fixation indices (FST) and gene flow.
- `genome <- linkage.stats(genome)`: Linkage disequilibrium (r^2, D').
- `genome <- MK.test(genome)`: McDonald-Kreitman test.

### 4. Sliding Window Analysis
For genomic scans, transform the data into windows:
```R
# Create sliding windows of 10kb moving by 5kb
genome_sw <- sliding.window.transform(genome, width=10000, jump=5000, type=2)
# Calculate stats on the windows
genome_sw <- neutrality.stats(genome_sw)
```

### 5. Accessing Results
Results are stored in slots within the PopGenome object.
- `get.sum.data(genome)`: Summary of the data.
- `genome@Tajima.D`: Access Tajima's D values directly.
- `show.statistic(genome)`: Display calculated statistics.

## Tips
- **Memory Management**: For very large VCFs, use the `tidyr` or `vcfR` packages to pre-process or ensure the directory contains indexed files.
- **Missing Data**: Use `set.filter` to exclude sites with too much missing data or low quality.
- **GFF/GTF**: Use `get.gff.info` to incorporate feature information (exons, introns) into the analysis.

## Reference documentation
- [Home Page](./references/home_page.md)