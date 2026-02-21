---
name: r-tigger
description: "Infers the V genotype of an individual from immunoglobulin (Ig)     repertoire sequencing data (AIRR-Seq, Rep-Seq). Includes detection of      any novel alleles. This information is then used to correct existing V      allele calls from among the sample sequences."
homepage: https://cran.r-project.org/web/packages/tigger/index.html
---

# r-tigger

## Overview
The `tigger` (Tool for Immunoglobulin Genotype Elucidation via Rep-Seq) package provides methods for identifying novel V gene alleles and inferring personalized IGHV genotypes. This is critical for AIRR-seq analysis because standard germline databases (like IMGT) may not contain all alleles present in a specific individual, leading to misalignments or ambiguous calls.

## Installation
```R
install.packages("tigger")
library(tigger)
```

## Core Workflow

### 1. Input Data Requirements
TIgGER requires two main inputs:
- **Repertoire Data**: A data frame in AIRR or Change-O format. Key columns include `sequence_alignment` (IMGT gapped), `v_call`, `j_call`, `junction`, and `junction_length`.
- **Germline Database**: A set of known V sequences in FASTA format, gapped according to IMGT numbering.

### 2. Detecting Novel Alleles
Use `findNovelAlleles` to identify potential polymorphisms.
```R
# novel is a data.frame containing evidence for new alleles
novel <- findNovelAlleles(AIRRDb, SampleGermlineIGHV, nproc=1)

# Extract only the rows where a novel allele was successfully identified
novel_rows <- selectNovel(novel)

# Visualize evidence (mutation frequency vs. y-intercept)
plotNovel(AIRRDb, novel[1, ])
```

### 3. Inferring Genotypes
You can infer the genotype using either a frequency-based approach or a Bayesian approach.
```R
# Frequency approach (requires 7/8 sequences to be explained)
geno <- inferGenotype(AIRRDb, germline_db=SampleGermlineIGHV, novel=novel, find_unmutated=TRUE)

# Bayesian approach (provides confidence estimates/Bayes factors)
geno_bayesian <- inferGenotypeBayesian(AIRRDb, germline_db=SampleGermlineIGHV, novel=novel)

# Visualize the genotype
plotGenotype(geno)
```

### 4. Creating a Personalized Germline Database
Convert the inferred genotype into a FASTA-formatted vector for downstream reassignment.
```R
genotype_db <- genotypeFasta(geno, SampleGermlineIGHV, novel)
```

### 5. Reassigning Allele Calls
Correct the original V calls using the personalized genotype to reduce ambiguity and eliminate non-existent alleles.
```R
# sample_db will contain a new column 'v_call_genotyped'
sample_db <- reassignAlleles(AIRRDb, genotype_db)
```

## Key Functions Reference
- `findNovelAlleles()`: Scans for polymorphisms based on mutation patterns.
- `selectNovel()`: Filters the output of `findNovelAlleles` for high-confidence hits.
- `plotNovel()`: Generates diagnostic plots showing y-intercept and J-gene distribution.
- `inferGenotype()`: Determines which alleles are present in the individual's genome.
- `reassignAlleles()`: Updates sequence metadata to match the inferred genotype.
- `generateEvidence()`: Creates a summary table of metrics supporting the novel allele calls.

## Tips for Success
- **Gapping**: Ensure your input sequences and germline database are IMGT-gapped. Use `alakazam::gap() ` if necessary.
- **Unmutated Sequences**: Novel allele detection is most reliable when using unmutated or low-mutation sequences. Set `find_unmutated=TRUE` in genotyping functions.
- **Filtering**: Before running TIgGER, it is often beneficial to filter for functional sequences to reduce noise from pseudogenes.

## Reference documentation
- [Polymorphism detection and genotyping](./references/Tigger-Vignette.Rmd)