---
name: bioconductor-splinter
description: "Bioconductor-splinter analyzes alternative splicing events and predicts their impact on protein sequences and primer design. Use when user asks to analyze alternative splicing events, predict protein-level impacts like nonsense-mediated decay, or design PCR primers for experimental validation."
homepage: https://bioconductor.org/packages/release/bioc/html/SPLINTER.html
---


# bioconductor-splinter

name: bioconductor-splinter
description: Analysis of alternative splicing sites, interpretation of sequence outcomes, and primer design for validation. Use this skill when analyzing transcriptomics data for alternative splicing events (SE, RI, MXE, A5SS, A3SS), predicting the protein-level impact of splicing changes (e.g., NMD, early termination), or designing PCR primers to validate splicing variants.

## Overview

SPLINTER (Splicing Prediction and INTERpretation) is a Bioconductor package designed to bridge the gap between identifying alternative splicing events and experimental validation. It allows users to import splicing data (e.g., from rMATS), visualize events, predict the impact on coding sequences, and automate the design of primers for RT-PCR validation.

## Core Workflow

### 1. Initialization and Data Loading
Load the package and prepare the genome and transcriptome environment.

```r
library(SPLINTER)
library(BSgenome.Mmusculus.UCSC.mm9) # Example genome
library(txdbmaker)

# Load genome
bsgenome <- BSgenome.Mmusculus.UCSC.mm9

# Create TxDb from GTF (ensure compatibility with your splicing analysis)
txdb <- makeTxDbFromGFF("path/to/annotation.gtf", chrominfo = Seqinfo(genome="mm9"))
thecds <- cdsBy(txdb, by="tx", use.names=TRUE)
theexons <- exonsBy(txdb, by="tx", use.names=TRUE)
```

### 2. Importing Splicing Events
SPLINTER natively supports rMATS output but can be adapted for any tool providing exon coordinates.

```r
# Supported types: "SE" (Skipped Exon), "RI" (Retained Intron), "MXE", "A5SS", "A3SS"
mats_file <- "skipped_exons.txt"
splice_data <- extractSpliceEvents(data=mats_file, filetype='mats', splicetype="SE")

# Add gene symbols if using ENSEMBL IDs
splice_data <- addEnsemblAnnotation(data=splice_data, species="mmusculus")
```

### 3. Analyzing a Specific Event
Select a gene of interest and identify compatible transcripts.

```r
# Select a record
single_record <- splice_data$data[splice_data$data$Symbol == "Prmt5", ][1, ]

# Find transcripts containing the gene/event
valid_tx <- findTX(id=single_record$ID, tx=theexons, db=txdb)
valid_cds <- findTX(id=single_record$ID, tx=thecds, db=txdb)

# Construct Region of Interest (ROI)
roi <- makeROI(single_record, type="SE")

# Find transcripts compatible with the specific splicing event
compatible_tx <- findCompatibleEvents(valid_tx, roi=roi)
```

### 4. Simulating Sequence Outcomes
Predict how the splicing event affects the protein sequence.

```r
# Remove the skipped exon from the coding sequence
region_minus_exon <- removeRegion(compatible_cds$hits[[1]], roi)

# Compare sequences (WT vs Spliced)
# direction=TRUE checks for translation; fullseq=FALSE focuses on the change site
event <- eventOutcomeCompare(seq1=compatible_cds$hits[[1]], 
                             seq2=region_minus_exon, 
                             genome=bsgenome, 
                             direction=TRUE)

# Check for Nonsense Mediated Decay (NMD) or early termination
print(event$eventtypes)
```

### 5. Primer Design and PCR Prediction
Generate primers that span the junction of interest.

```r
# Get DNA sequence for the ROI (junction marked with [])
region_dna <- getRegionDNA(roi, bsgenome)

# Design primers (requires Primer3 installed and path defined)
# primers <- callPrimer3(seq=region_dna$seq, sequence_target=region_dna$jstart)

# Predict PCR product sizes for both isoforms
cp <- checkPrimer(primers[1,], bsgenome, roi)
pcr_wt <- getPCRsizes(cp, theexons)
pcr_alt <- getPCRsizes(cp, region_minus_exon)
```

### 6. Visualization
Generate coverage plots and PSI (Percent Spliced In) barplots.

```r
# Plot genomic range and BAM coverage
eventPlot(transcripts=theexons, roi_plot=roi, bams=c("wt.bam", "mt.bam"), 
          names=c('WT', 'Mutant'), annoLabel="GeneName")

# Plot PSI values
psiPlot(single_record)
```

## Tips and Best Practices
- **Genome Compatibility**: Always ensure the `BSgenome` object matches the assembly version used to generate your GTF and BAM files.
- **ROI Types**: `makeROI` creates two representations: Type 1 (usually the inclusion isoform) and Type 2 (usually the exclusion/alternative isoform).
- **Primer3**: The `callPrimer3` function is a wrapper. If Primer3 is not in your system path, you must provide the path to the executable.
- **NMD Prediction**: Use `eventOutcomeCompare` to quickly screen which alternative splicing events are likely to result in non-functional proteins or degraded transcripts.

## Reference documentation
- [SPLINTER Vignette](./references/vignette.md)