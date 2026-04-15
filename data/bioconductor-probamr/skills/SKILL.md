---
name: bioconductor-probamr
description: This tool maps shotgun proteomics peptide-spectrum matches to genomic coordinates and converts them into SAM or BAM format. Use when user asks to map peptides to the genome, convert proteomics results to BAM format, or integrate proteomics data with genomic visualization tools.
homepage: https://bioconductor.org/packages/release/bioc/html/proBAMr.html
---

# bioconductor-probamr

name: bioconductor-probamr
description: Map shotgun proteomics peptide-spectrum matches (PSMs) to genomic coordinates in BAM format. Use this skill to integrate proteomics data with genomic/transcriptomic frameworks, enabling visualization in genome browsers (like IGV) and co-analysis with other -omics data.

# bioconductor-probamr

## Overview

The `proBAMr` package facilitates the conversion of shotgun proteomics results into the standard SAM/BAM format used in genomics. By mapping peptides to their genomic locations, it allows researchers to treat proteomics "reads" (PSMs) similarly to NGS reads. This is particularly useful for proteogenomics, alternative isoform analysis, and identifying the genomic origin of identified peptides.

## Workflow

### 1. Preparing Annotation Files
Before mapping PSMs, you must prepare genomic annotation files. `proBAMr` provides a specific function for GENCODE, while RefSeq and ENSEMBL annotations are typically handled via the `customProDB` package.

```r
library(proBAMr)

# Define paths to GENCODE files (GTF, CDS Fasta, Protein Fasta)
gtfFile <- "path/to/gencode.gtf"
CDSfasta <- "path/to/gencode.coding_seq.fasta"
pepfasta <- "path/to/gencode.pro_seq.fasta"
annotation_path <- "./annotation_dir"

# Generate annotation RData files
PrepareAnnotationGENCODE(gtfFile, CDSfasta, pepfasta, 
                         annotation_path, dbsnp=NULL, 
                         splice_matrix=FALSE, COSMIC=FALSE)
```

### 2. Preparing the PSM Table
You need a tabular representation of identified PSMs. While `pepXMLTab` is often used to extract this from pepXML files, any data frame with the following information is acceptable:
- `spectrum`: Spectrum identifier.
- `peptide`: Amino acid sequence.
- `protein`: Protein identifier (matching the annotation).
- `modification`: Variable modifications.
- `charge`: Precursor charge.

```r
# Load your PSM data
passedPSM <- read.table("passedPSM.tab", sep='\t', header=TRUE)
```

### 3. Generating the SAM File
The core function `PSMtab2SAM` maps the peptides to the genome using the previously prepared annotation objects.

```r
# 1. Load the annotation objects created in Step 1
load(file.path(annotation_path, "exon_anno.RData"))
load(file.path(annotation_path, "proseq.RData"))
load(file.path(annotation_path, "procodingseq.RData"))

# 2. Convert PSM table to SAM format
# XScolumn specifies which score column to use for the 'XS' tag in SAM
SAM <- PSMtab2SAM(passedPSM, XScolumn='mvh', exon, proteinseq, procodingseq)

# 3. Write to file
write.table(SAM, file='output.sam', sep='\t', quote=FALSE, 
            row.names=FALSE, col.names=FALSE)
```

## Key Functions and Parameters

- **`PrepareAnnotationGENCODE`**: Parses GENCODE files to create mapping references. Ensure the version of the GTF and Fasta files match exactly.
- **`PSMtab2SAM`**:
    - `passedPSM`: Data frame of PSMs.
    - `XScolumn`: The name of the column in `passedPSM` containing the search engine score (e.g., 'xcorr', 'mvh').
    - `exon`, `proteinseq`, `procodingseq`: The objects loaded from the annotation step.

## Tips for Success

- **Coordinate Consistency**: Ensure that the genome version used for annotation (e.g., hg38 vs hg19) matches any other genomic data you intend to co-visualize.
- **Protein IDs**: The protein identifiers in your `passedPSM` table must match the identifiers in the annotation files (e.g., ENSEMBL transcript IDs).
- **Post-Processing**: After generating the `.sam` file, you must use external tools like `samtools` to add a header, convert to `.bam`, sort, and index the file for use in genome browsers.
- **CIGAR Strings**: `proBAMr` uses 'M' for matches/mismatches and 'N' for skipped regions (introns).

## Reference documentation
- [proBAMr](./references/proBAMr.md)