---
name: bioconductor-casper
description: "Bioconductor-casper quantifies isoform expression and performs experimental design for RNA-seq data using Bayesian models. Use when user asks to estimate transcript-level expression, simulate RNA-seq data for power analysis, or analyze differential isoform usage."
homepage: https://bioconductor.org/packages/release/bioc/html/casper.html
---


# bioconductor-casper

name: bioconductor-casper
description: Statistical methods for quantifying isoform expression from RNA-seq data, including de novo prediction, experimental design, and differential expression analysis. Use this skill when you need to estimate transcript-level expression (RPKM), simulate RNA-seq data for power analysis, or compare isoform usage across samples using Bayesian models.

# bioconductor-casper

## Overview
The `casper` (Characterization of Alternative Splicing based on Paired-end Reads) package provides a comprehensive framework for analyzing alternative splicing from paired-end RNA-seq data. It uses a Bayesian model to estimate isoform expression by considering "exon paths" (the sequence of exons visited by a read pair) rather than simple pairwise connections. It also includes specialized tools for experimental design, allowing users to simulate data to determine optimal sequencing depth, read length, and sample size.

## Core Workflow: Quantifying Known Isoforms

The most common task is quantifying expression for a set of known transcripts.

### 1. Genome Annotation Pre-processing
Before analysis, you must process the genome annotation into a format `casper` understands.
```r
library(casper)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

# Create the genome database object
hg19DB <- procGenome(TxDb.Hsapiens.UCSC.hg19.knownGene, genome='hg19')
```

### 2. Single-Sample Pipeline (`wrapKnown`)
The `wrapKnown` function automates the entire pipeline from a BAM file to an `ExpressionSet`.
```r
bamFile <- "path/to/sorted_indexed.bam"
ans <- wrapKnown(bamFile = bamFile, 
                 genomeDB = hg19DB, 
                 readLength = 101, 
                 mc.cores.int = 4)

# Access expression estimates (log-RPKM)
expData <- ans$exp
head(exprs(expData))
```

### 3. Multi-Sample Integration
After processing individual samples, merge them and normalize.
```r
# Combine multiple wrapKnown outputs
x <- mergeExp(sample1$exp, sample2$exp, sampleNames=c("S1", "S2"), keep=c('transcript','gene'))

# Quantile normalization
xnorm <- quantileNorm(x)
```

## Experimental Design and Simulation

`casper` allows for sequential experimental design by simulating data based on pilot studies.

### Single Sample Design (MAE Calculation)
Evaluate how different sequencing setups (N reads, read length r, insert size f) affect estimation error.
```r
# Setup experimental parameters to test
n_reads <- c(2e7, 5e7)
r_length <- c(76, 101)
f_size <- c(200, 300)

# Simulate and calculate Mean Absolute Error
sims <- simMAE(nsim=5, nreads=n_reads, readLength=r_length, 
               fragLength=f_size, pc=pilotData$pc, 
               distr=pilotData$distr, genomeDB=hg19DB)
```

### Multiple Sample Design (Power Analysis)
Simulate future experiments to predict differential expression (DE) discovery power.
```r
# Simulate 3 samples per group with 12M reads each
gse.sim <- simMultSamples(nsim=5, nsamples=c(3,3), nreads=12e6,
                          readLength=101, fragLength=200, 
                          x=pilotExpSet, groups='group', 
                          distrs=pilotDistrs, genomeDB=hg19DB)

# Analyze simulated data for DE
pp <- probNonEquiv(gse.sim, groups='group', logfc=log(3))
```

## De Novo Isoform Discovery
If you suspect the presence of unannotated transcripts, use `wrapDenovo`.
```r
# Returns expression estimates and posterior probability of existence
denovo_ans <- wrapDenovo(bamFile=bamFile, genomeDB=hg19DB, readLength=101)

# Probability that the isoform is expressed
post_probs <- fData(denovo_ans$exp)$postProb
```

## Visualization
Visualize transcripts and read alignments to inspect splicing patterns.
```r
# Plot gene island with estimated expression
genePlot(islandid="463", genomeDB=hg19DB, reads=pbam0, exp=eset)
```

## Key Functions Reference
- `procGenome`: Converts TxDb or GTF to `annotatedGenome`.
- `getDistrs`: Estimates fragment length and read start distributions from BAM.
- `pathCounts`: Summarizes BAM alignments into exon path counts.
- `calcExp`: The core estimation engine for RPKM/relative expression.
- `probNonEquiv`: Bayesian test for differential expression (equivalence testing).
- `mergeBatches`: Combines pilot and simulated data with batch adjustment.

## Reference documentation
- [Supplementary manual. Sequential design of RNA-seq experiments](./references/DesignRNASeq.md)
- [Manual for the R casper package](./references/casper.md)