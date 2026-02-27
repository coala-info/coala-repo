---
name: bioconductor-mitoclone2
description: This tool identifies clonal populations and reconstructs phylogenetic trees from mitochondrial variants in single-cell sequencing data. Use when user asks to count mitochondrial alleles from BAM files, filter variants using exclusion lists or cohorts, cluster mutations into clones, and infer phylogenetic relationships between cells.
homepage: https://bioconductor.org/packages/release/bioc/html/mitoClone2.html
---


# bioconductor-mitoclone2

name: bioconductor-mitoclone2
description: Clonal population identification and phylogenetic tree reconstruction using mitochondrial (and nuclear) variants from single-cell sequencing data (RNA-seq, ATAC-seq, or DNA-seq). Use this skill to process BAM files into nucleotide counts, filter for somatic variants using exclusion lists or cohort-based comparisons, cluster mutations into clones, and infer phylogenetic relationships.

# bioconductor-mitoclone2

## Overview
The `mitoClone2` package is designed to leverage the high mutation rate and heteroplasmy of mitochondrial DNA to track clonal lineages in single-cell datasets. It provides a complete workflow from raw BAM files to phylogenetic tree reconstruction and cell-to-clone assignment. It is particularly effective when comparing multiple samples (cohorts) to filter out technical noise and RNA editing sites.

## Core Workflow

### 1. Data Input and Nucleotide Counting
The package starts by counting alleles at specific genomic sites from BAM files.

```r
library(mitoClone2)

# Option A: From a list of individual BAM files (one per cell)
bam_list <- list.files("path/to/bams", pattern = ".bam$", full.names = TRUE)
baseCounts <- baseCountsFromBamList(bamfiles = bam_list, sites = "chrM:1-16569", ncores = 4)

# Option B: From a multiplexed 10x Genomics BAM file (using CB tag)
baseCounts <- bam2R_10x(file = "possorted_genome_bam.bam", sites = "chrM:1-16569")
```

### 2. Variant Calling and Filtering
You can identify variants using two primary strategies:

**Strategy 1: Exclusion List (Single Sample)**
Removes known artifacts, homopolymers, and RNA editing sites.
```r
# Works best for hg38; requires manual liftOver for other genomes
mutCalls <- mutationCallsFromExclusionlist(baseCounts, 
                                           min.af = 0.2, 
                                           min.num.samples = 5,
                                           lim.cov = 20)
```

**Strategy 2: Cohort Filtering (Multiple Samples)**
The most powerful method; it identifies variants unique to a patient by comparing against others in the cohort to eliminate shared technical noise.
```r
# 'patient_vector' labels each cell in baseCounts with a patient ID
mutCallsCohort <- mutationCallsFromCohort(baseCounts, 
                                          patient = patient_vector,
                                          MINFRAC = 0.1, 
                                          MINCELLS.PATIENT = 10)
```

### 3. Phylogenetic Tree Reconstruction
Use `varCluster` to compute the most likely tree. This requires external tools like SCITE (standard) or PhISCS (requires Gurobi).

```r
# SCITE is the default method
tmp_dir <- tempdir()
mutCalls <- varCluster(mutCalls, tempfolder = tmp_dir, method = 'SCITE')
```

### 4. Clonal Clustering and Assignment
Group mutations into "metaclones" based on tree likelihoods and assign cells to these clones.

```r
# Cluster mutations into clones
mutCalls <- clusterMetaclones(mutCalls, min.lik = 1)

# Visualize the results
plotClones(mutCalls)

# Access cell-to-clone assignments
assignments <- mutCalls@cell2clone
```

## Advanced Usage and Tips

### Manual Refinement
If the automated clustering merges clones that should be distinct (e.g., for differential expression), you can manually overwrite the assignments:
```r
# Get current mutation-to-clone mapping
m2c <- mitoClone2:::getMut2Clone(mutCalls)

# Manually assign specific mutations to a new clone ID
m2c[c("X2537GA", "X14462GA")] <- as.integer(6)

# Update the object
mutCalls_new <- mitoClone2:::overwriteMetaclones(mutCalls, m2c)
```

### Genome Considerations
- **hg38/hg19/mm10**: Built-in support.
- **Mitochondrial Lengths**: UCSC hg38 (16569 bp), UCSC hg19 (16571 bp), UCSC mm10 (16299 bp).
- **Reference Consistency**: Ensure the `sites` parameter and the `genome` argument match the reference used for BAM alignment.

## Reference documentation
- [Computation of phylogenetic trees and clustering of mutations](./references/clustering.md)
- [Variant Calling Overview and Filtering](./references/overview.md)