---
name: bioconductor-crisprseek
description: This tool designs and analyzes guide RNAs for CRISPR-based genome editing systems including Cas9, base editors, and prime editors. Use when user asks to identify gRNAs in target sequences, perform genome-wide off-target searches, score off-target effects, find paired gRNAs for double nickases, or annotate hits with genomic features.
homepage: https://bioconductor.org/packages/release/bioc/html/CRISPRseek.html
---

# bioconductor-crisprseek

name: bioconductor-crisprseek
description: Design and analyze guide RNAs (gRNAs) for CRISPR-based genome editing (Cas9, Base Editors, Prime Editors). Use this skill to identify gRNAs in target sequences, perform genome-wide off-target searches, score off-target effects, find paired gRNAs for double nickases, and annotate hits with genomic features (exons, restriction sites).

## Overview

CRISPRseek is a comprehensive Bioconductor package for gRNA design and off-target analysis. It streamlines the process of finding potential targets, evaluating their specificity against a reference genome, and ranking them based on efficacy and off-target risk. It supports standard Cas9, Base Editing (CBE/ABE), and Prime Editing (PE) workflows.

## Core Workflow: offtargetAnalysis

The primary interface is the `offtargetAnalysis()` function, which acts as a one-stop wrapper for the entire pipeline.

### Basic Usage
```r
library(CRISPRseek)
library(BSgenome.Hsapiens.UCSC.hg38)

results <- offtargetAnalysis(
  inputFilePath = "path/to/sequence.fa",
  BSgenomeName = Hsapiens,
  chromToSearch = "chrX", # Use "all" for whole genome
  outputDir = getwd(),
  overwrite = TRUE
)
```

### Key Parameters
- `inputFilePath`: Path to FASTA or a `DNAStringSet` object.
- `findgRNAs`: Set to `FALSE` if providing a list of pre-designed gRNAs.
- `max.mismatch`: Maximum mismatches for off-target search (default 3; >3 is slow).
- `scoring.method`: Default is "Hsu-Zhuang". Use "CFDscore" for more recent mismatch/type modeling.
- `rule.set`: Efficacy calculation method (e.g., "Root_RuleSet1_2014", "Root_RuleSet2_2016", "CRISPRscan").

## Specialized Workflows

### 1. Genomic Annotation
To determine if off-targets fall within exons, provide `TxDb` and `OrgDb` objects:
```r
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(org.Hs.eg.db)

res <- offtargetAnalysis(...,
  annotateExon = TRUE,
  txdb = TxDb.Hsapiens.UCSC.hg38.knownGene,
  orgAnn = org.Hs.egSYMBOL
)
```

### 2. Paired gRNAs (Double Nickases)
To find pairs in the correct orientation (Reverse-Forward) with specific spacing:
```r
res <- offtargetAnalysis(...,
  findPairedgRNAOnly = TRUE,
  min.gap = 0,
  max.gap = 20
)
```

### 3. Base Editing (CBE/ABE)
Optimize gRNAs for base editors by defining the editing window:
```r
res <- offtargetAnalysis(...,
  baseEditing = TRUE,
  targetBase = "C",
  editingWindow = 4:8
)
```

### 4. Prime Editing (pegRNA Design)
Requires `primeEditing = TRUE` and specific parameters for the PBS and RT template:
```r
res <- offtargetAnalysis(...,
  primeEditing = TRUE,
  PBS.length = 15,
  RT.template.length = 8:30,
  target.start = 20,
  target.end = 20,
  corrected.seq = "T",
  paired.orientation = "PAMin"
)
```

### 5. Allele-Specific Targeting
Use `compare2Sequences()` to find gRNAs that target one allele (e.g., a SNP) while avoiding the other:
```r
res <- compare2Sequences(file1, file2, outputDir = getwd())
# Look for high scoreForSeq1 and low scoreForSeq2
```

## Bulge Analysis
CRISPRseek supports DNA and RNA bulges via Cas-OFFinder integration.
- Set `findOffTargetsWithBulge = TRUE`.
- Use `DNA_bulge` and `RNA_bulge` to set limits (default 2).
- Requires `pocl-opencl-icd` on some systems for the underlying tool.

## Interpreting Results
The function returns a list and writes files to `outputDir`:
- **Summary.xlsx**: Ranked gRNAs with topN off-target scores and efficacy.
- **OfftargetAnalysis.xlsx**: Detailed alignment and scores for every potential off-target.
- **REcutDetails.xlsx**: Restriction enzyme sites overlapping the gRNAs.
- **pairedgRNAs.xlsx**: Valid pairs for nickase applications.

## Reference documentation
- [CRISPRseek: design of guide RNA and off-target analysis](./references/CRISPRseek.md)