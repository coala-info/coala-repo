---
name: bioconductor-crisprdesign
description: The crisprDesign package provides a comprehensive framework for designing, annotating, and scoring CRISPR guide RNAs across multiple modalities and nucleases. Use when user asks to design gRNAs, perform off-target searches, calculate on-target efficiency scores, or annotate spacers with genomic features and SNPs.
homepage: https://bioconductor.org/packages/release/bioc/html/crisprDesign.html
---

# bioconductor-crisprdesign

name: bioconductor-crisprdesign
description: Comprehensive CRISPR guide RNA (gRNA) design and annotation using the crisprDesign package. Use this skill to design gRNAs for various modalities (knockout, activation, interference, base editing, knockdown), perform off-target searches, calculate on/off-target scores, and annotate gRNAs with gene context, SNPs, and sequence features.

# bioconductor-crisprdesign

## Overview
The `crisprDesign` package is a central component of the crisprVerse ecosystem, providing a unified framework for designing and annotating CRISPR guide RNAs (gRNAs). It supports multiple CRISPR modalities including CRISPRko, CRISPRa, CRISPRi, CRISPRbe (base editing), and CRISPRkd (knockdown). The package integrates with `crisprBase` for nuclease specifications and `crisprScore` for efficiency predictions.

## Core Workflow

### 1. Nuclease and Target Specification
Define the nuclease (e.g., SpCas9, AsCas12a) and the genomic target.

```r
library(crisprDesign)
library(crisprBase)
library(BSgenome.Hsapiens.UCSC.hg38)

# Load a pre-defined nuclease
data(SpCas9, package="crisprBase")

# Define target region (e.g., CDS of a gene)
# Assuming grListExample is loaded from the package
data(grListExample, package="crisprDesign")
gr <- queryTxObject(txObject=grListExample,
                    featureType="cds",
                    queryColumn="gene_symbol",
                    queryValue="IQSEC3")
```

### 2. Finding Spacers
Generate a `GuideSet` object containing all possible gRNAs in the target region.

```r
bsgenome <- BSgenome.Hsapiens.UCSC.hg38
guideSet <- findSpacers(gr[1], 
                        bsgenome=bsgenome, 
                        crisprNuclease=SpCas9)
```

### 3. Annotation and Feature Characterization
Add sequence-level features and genomic context.

```r
# Basic sequence features (GC content, poly-T, self-complementarity)
guideSet <- addSequenceFeatures(guideSet)

# Gene and TSS context
guideSet <- addGeneAnnotation(guideSet, txObject=grListExample)
data(tssObjectExample, package="crisprDesign")
guideSet <- addTssAnnotation(guideSet, tssObject=tssObjectExample)

# Restriction enzymes and SNPs
guideSet <- addRestrictionEnzymes(guideSet)
# vcf_path should point to a local .vcf.gz file
guideSet <- addSNPAnnotation(guideSet, vcf=vcf_path)
```

### 4. Off-target Search and Scoring
Align spacers to the genome to identify potential off-targets and calculate specificity scores.

```r
# Requires bowtie index
guideSet <- addSpacerAlignments(guideSet,
                                txObject=grListExample,
                                aligner_index="path/to/bowtie_index",
                                bsgenome=bsgenome,
                                n_mismatches=2)

# Calculate MIT and CFD scores (SpCas9 specific)
guideSet <- addOffTargetScores(guideSet)

# Calculate on-target efficiency scores (requires crisprScore)
guideSet <- addOnTargetScores(guideSet, methods="crisprater")
```

### 5. Filtering and Ranking
Subset the `GuideSet` based on annotations and rank by quality.

```r
# Filter by GC content and polyT
guideSet <- guideSet[guideSet$percentGC >= 20 & guideSet$percentGC <= 80]
guideSet <- guideSet[!guideSet$polyT]

# Rank spacers using recommended heuristics
guideSet <- rankSpacers(guideSet, tx_id="ENST00000538872")
```

## Specialized Modalities

### CRISPR Base Editing (CRISPRbe)
Predicts edited alleles and functional consequences.

```r
data(BE4max, package="crisprBase")
# Requires a transcript table from getTxInfoDataFrame
guideSet <- addEditedAlleles(guideSet,
                             baseEditor=BE4max,
                             txTable=txTable,
                             editingWindow=c(-20, -8))
```

### CRISPR Knockdown (CRISPRkd)
Design gRNAs targeting mRNA sequences using RNA-targeting nucleases like Cas13d.

```r
data(CasRx, package="crisprBase")
mrnas <- getMrnaSequences(txid="ENST00000538872", bsgenome=bsgenome, txObject=grListExample)
guideSet <- findSpacers(mrnas[[1]], crisprNuclease=CasRx)
```

### Paired gRNA Design
Design pairs of gRNAs for large deletions or dual-targeting.

```r
pairs <- findSpacerPairs(gr, gr, bsgenome=bsgenome, crisprNuclease=SpCas9)
# Access individual guides
first_guides <- first(pairs)
second_guides <- second(pairs)
```

## Tips for Success
- **Memory Management**: For genome-wide off-target searches, use `addSpacerAlignmentsIterative` to curtail searches for highly unspecific spacers.
- **Custom Sequences**: Use `findSpacers` with a character vector of sequences if working with synthesized constructs instead of a reference genome.
- **Non-Targeting Controls**: Use `addNtcs` to append negative control sequences to your `GuideSet` for library design.
- **Data Access**: Use accessor functions like `alignments()`, `onTargets()`, `offTargets()`, and `snps()` to extract detailed DataFrames from the `GuideSet`.

## Reference documentation
- [Introduction to crisprDesign](./references/intro.md)
- [Introduction to crisprDesign (Rmd)](./references/intro.Rmd)