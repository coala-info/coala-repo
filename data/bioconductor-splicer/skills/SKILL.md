---
name: bioconductor-splicer
description: bioconductor-splicer classifies alternative splicing events and predicts the coding potential and nonsense-mediated decay susceptibility of RNA-seq transcript isoforms. Use when user asks to identify splicing classes like exon skipping or intron retention, annotate premature termination codons, or analyze transcript data from Cufflinks and GRanges objects.
homepage: https://bioconductor.org/packages/3.5/bioc/html/spliceR.html
---

# bioconductor-splicer

name: bioconductor-splicer
description: Expert guidance for the spliceR R package to classify alternative splicing events and predict coding potential (NMD/PTC) from RNA-seq data. Use this skill when analyzing transcript isoforms from Cufflinks (via cummeRbund) or generic GRanges objects to identify splicing classes (ESI, MESI, ISI, A5/A3, ATSS/ATTS, MEE) and annotate nonsense-mediated decay (NMD) susceptibility.

## Overview

spliceR is a Bioconductor package designed for the downstream analysis of RNA-seq isoform data. It transforms transcript-level assemblies into classified alternative splicing events and provides functional annotations regarding coding potential. It primarily operates on a `SpliceRList` object, which contains transcript and exon features.

## Core Workflow

### 1. Data Preparation

Data can be imported from Cufflinks or created manually from GRanges.

**From Cufflinks (via cummeRbund):**
```R
library(spliceR)
library(cummeRbund)

# Ensure the GTF used for Cufflinks is provided to readCufflinks
cuffDB <- readCufflinks(dir="path/to/cuffdiff_out", gtf="transcripts.gtf", genome="hg19")

# Convert to SpliceRList
# fixCufflinksAnnotationProblem=TRUE (default) corrects gene expression for multi-gene cuff-ids
cuffDB_spliceR <- prepareCuff(cuffDB)
```

**From Generic GRanges:**
You must provide two `GRanges` objects: `transcript_features` (with metadata columns like `spliceR.isoform_id`, `spliceR.gene_id`) and `exon_features`.
```R
mySpliceRList <- SpliceRList(
  transcript_features = knownGeneTranscripts,
  exon_features = knownGeneExons,
  assembly_id = "hg19",
  source = "granges",
  conditions = c("Control", "Treatment")
)
```

### 2. Filtering (Optional but Recommended)
Pre-filtering removes low-confidence or non-expressed transcripts to speed up processing.
```R
cuffDB_spliceR_filtered <- preSpliceRFilter(
  cuffDB_spliceR,
  filters = c("expressedIso", "isoOK", "expressedGenes", "geneOK")
)
```

### 3. Alternative Splicing Classification
The `spliceR()` function identifies splicing events.
*   `compareTo="preTranscript"`: Compares isoforms to a hypothetical pre-RNA (union of all exons).
*   `compareTo="sample_name"`: Compares isoforms to the major isoform of a specific sample.

```R
mySpliceRList <- spliceR(
  cuffDB_spliceR_filtered,
  compareTo = "preTranscript",
  filters = c("expressedGenes", "isoOK", "isoClass"),
  useProgressBar = FALSE
)
```

### 4. PTC and NMD Annotation
Annotate transcripts for Premature Termination Codons (PTC) and susceptibility to Nonsense Mediated Decay (NMD).
```R
# 1. Get CDS information from UCSC
ucscCDS <- getCDS(selectedGenome="hg19", repoName="UCSC")

# 2. Load the corresponding BSgenome
library(BSgenome.Hsapiens.UCSC.hg19)

# 3. Annotate PTC
# PTCDistance=50 is the standard rule (STOP > 50nt from last junction)
mySpliceRList <- annotatePTC(
  mySpliceRList, 
  cds = ucscCDS, 
  bsgenome = Hsapiens, 
  PTCDistance = 50
)
```

## Visualization and Export

### Plotting Splicing Events
Generate Venn diagrams comparing splicing events across conditions.
```R
# Plot average number of transcripts per gene
mySpliceRList <- spliceRPlot(mySpliceRList, evaluate="nr_transcript_pr_gene")

# Plot specific AS types (e.g., Exon Skipping Inclusion - ESI)
mySpliceRList <- spliceRPlot(mySpliceRList, evaluate="mean_AS_transcript", asType="ESI")
```

### Exporting to GTF
Export results for viewing in genome browsers (IGV/UCSC). Transcripts are color-coded by expression.
```R
generateGTF(
  mySpliceRList, 
  filters = c("geneOK", "isoOK", "expressedIso"),
  scoreMethod = "local" # Scores relative to highest expressed isoform in gene
)
```

## Key Splicing Classes
*   **ESI/MESI**: Single/Multiple Exon Skipping or Inclusion.
*   **ISI**: Intron Retention/Inclusion.
*   **A5/A3**: Alternative 5' or 3' splice sites.
*   **ATSS/ATTS**: Alternative Transcription Start/Termination Sites.
*   **MEE**: Mutually Exclusive Exons.

## Reference documentation
- [spliceR: An R package for classification of alternative splicing and prediction of coding potential from RNA-seq data](./references/spliceR.md)