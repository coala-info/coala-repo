---
name: bioconductor-orfhunter
description: This tool identifies and annotates open reading frames in RNA sequences using a machine learning-based framework. Use when user asks to identify true ORFs, predict coding potential, detect premature termination codons, or perform in silico translation of transcript sequences.
homepage: https://bioconductor.org/packages/release/bioc/html/ORFhunteR.html
---

# bioconductor-orfhunter

name: bioconductor-orfhunter
description: Automatic determination and annotation of open reading frames (ORFs) in RNA molecules using machine learning. Use this skill when analyzing human transcriptomes (NCBI RefSeq or Ensembl) to identify true ORFs, detect premature termination codons (PTCs), and perform in silico translation and basic ORF annotation.

# bioconductor-orfhunter

## Overview

The `ORFhunteR` package provides a machine learning-based framework for identifying and annotating Open Reading Frames (ORFs) within large sets of RNA sequences. It utilizes a Random Forest classifier trained on vectorized sequence features (mono-, di-, and trinucleotide frequencies, Bao model entropy values, and ORF length) to distinguish between true coding ORFs and pseudo-ORFs. It is particularly useful for biomedical research involving normal or cancerous human transcriptomes.

## Core Workflow

### 1. Data Loading
Load transcript sequences from FASTA, GTF, or GFF files.
```r
library(ORFhunteR)
# From FASTA
trans_path <- system.file("extdata", "Set.trans_sequences.fasta", package = "ORFhunteR")
seq_set <- loadTrExper(tr = trans_path)

# From GTF (requires a BSgenome package)
# seq_set <- loadTrExper(tr = "path/to/file.gtf", genome = "BSgenome.Hsapiens.UCSC.hg38")
```

### 2. Identifying ORF Candidates
Find all possible in-frame ORFs starting with a specific codon (usually "ATG").
```r
x <- "AAAATGGCTGCGTAATGCAAAATGGCTGCGAATGCAAAATGGCTGCGAATGCCGGCACGTTGCTACGT"
orf_matrix <- findORFs(x, codStart = "ATG")
```

### 3. Predicting True ORFs
Use a pre-trained Random Forest model to identify the most likely true ORF for each transcript.
```r
# model can be a path to an RDS file or a URL
model_path <- "http://www.sstcenter.com/download/ORFhunteR/classRFmodel_1.rds"
predicted_orfs <- predictORF(tr = trans_path, model = model_path, prThr = 0.9)
# Returns a data.frame with transcript_id, start, end, length, and probability
```

### 4. Sequence Extraction and Translation
Extract the nucleotide sequences of identified ORFs and translate them into proteins.
```r
# Extract sequences (requires coordinates file from predictORF)
seq_orfs <- getSeqORFs(orfs = "coords.txt", tr = trans_path)

# In silico translation
prot_seqs <- translateORFs(seqORFs = "orf_sequences.fasta")
```

### 5. Annotation and PTC Detection
Annotate ORFs with features like molecular weight, isoelectric point, and identify premature termination codons (PTCs).
```r
# Detect PTCs
ptc_data <- findPTCs(orfs = "coords.txt", gtf = "structure.gtf")

# Comprehensive annotation
final_anno <- annotateORFs(
  orfs = "coords.txt",
  tr = trans_path,
  gtf = "structure.gtf",
  prts = "prot_sequences.fasta"
)
```

## Training a Custom Model
If the default model is not suitable, you can train a new classifier using known pseudo-ORFs (from lncRNAs) and true ORFs (from mRNAs).
```r
clt <- classifyORFsCandidates(
  ORFLncRNAs = list_of_pseudo_orfs,
  ORFmRNAs = list_of_true_orfs,
  pLearn = 0.75,
  nTrees = 500,
  showAccuracy = TRUE
)
```

## Tips and Best Practices
- **Probability Threshold (`prThr`)**: A threshold of 0.9 is generally effective for discriminating between true ORFs and pseudo-ORFs in human mRNA.
- **File Formats**: When using GTF/GFF files, ensure the corresponding `BSgenome` package (e.g., `BSgenome.Hsapiens.UCSC.hg38`) is installed.
- **Vectorization**: The `vectorizeORFs` function can be used independently to extract 104 sequence features for custom machine learning workflows.

## Reference documentation
- [The ORFhunteR package: User’s manual](./references/ORFhunteR.Rmd)
- [The ORFhunteR package: User’s manual](./references/ORFhunteR.md)