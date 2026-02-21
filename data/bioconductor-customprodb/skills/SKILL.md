---
name: bioconductor-customprodb
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/customProDB.html
---

# bioconductor-customprodb

name: bioconductor-customprodb
description: Generate customized protein databases from NGS data (RNA-Seq/VCF) for proteomics search. Use this skill when you need to create FASTA files containing protein sequences with variations (SNVs, indels), alternative splicing isoforms, or novel peptides from genomic coordinates.

# bioconductor-customprodb

## Overview
`customProDB` is a Bioconductor package designed to bridge the gap between genomics and proteomics. It enables the creation of customized protein databases by incorporating sample-specific genomic variations and transcriptomic information. This is essential for identifying variant peptides or sample-specific isoforms in Mass Spectrometry (MS) data that are missing from standard reference databases like UniProt.

## Core Workflow

### 1. Preparation of Annotation Data
Before generating databases, you must build an annotation model from a specific genome assembly (e.g., hg19, mm10).

```r
library(customProDB)
# Download and prepare annotation from UCSC or Ensembl
# Example for hg19
output_dir <- "db_dir"
PrepareAnnotationRef(genome='hg19', CDSfasta=NULL, pepfasta=NULL, 
                     annotation_path=output_dir, dbsnp=NULL, 
                     transcript_ids=NULL, splice_matrix=FALSE)

# Load the prepared annotation
load(file.path(output_dir, 'exon_anno.RData'))
load(file.path(output_dir, 'ids.RData'))
load(file.path(output_dir, 'proseq.RData'))
```

### 2. Incorporating SNVs and Indels
Use VCF files to generate protein sequences containing non-synonymous amino acid substitutions.

```r
# Read VCF file
vcfFile <- "sample.vcf"
vcf <- InputVcf(vcfFile)

# Annotate variations
# postable contains genomic coordinates and amino acid changes
postable <- PositionToFile(vcf[[1]], annotation_path=output_dir)

# Generate FASTA with variations
# 'variant_type' can be 'snv', 'insertion', or 'deletion'
OutputVarproSeq(postable, proseq, ids, labelfile=vcf[[1]], 
                outfile=file.path(output_dir, "variant_proteins.fasta"))
```

### 3. Incorporating Alternative Splicing
Generate protein sequences for all possible isoforms or sample-specific transcripts identified via RNA-Seq.

```r
# Generate FASTA for all isoforms in the annotation
OutputAbundantTranscript(proseq, ids, 
                         outfile=file.path(output_dir, "isoforms.fasta"))
```

### 4. Junction Peptides and Novel Peptides
To identify novel splice junctions or peptides from unannotated regions:

```r
# Create database for junction peptides
# bedFile usually comes from TopHat/Star junction output
bedFile <- "junctions.bed"
junction_type <- "all" # or "novel"
OutputNovelJun(bedFile, annotation_path=output_dir, 
               outfile=file.path(output_dir, "junctions.fasta"))
```

## Key Functions
- `PrepareAnnotationRef()`: Downloads and formats genome-specific data.
- `InputVcf()`: Parses VCF files for variation analysis.
- `PositionToFile()`: Maps genomic variations to protein-level changes.
- `OutputVarproSeq()`: Exports FASTA files containing mutated protein sequences.
- `OutputNovelJun()`: Creates a database of peptides spanning exon-exon junctions.
- `OutputSharedPeptides()`: Identifies peptides shared across multiple proteins (useful for grouping).

## Tips for Success
- **Genome Matching**: Ensure the genome version used in `PrepareAnnotationRef` matches the version used for NGS alignment (e.g., don't mix hg19 and hg38).
- **Memory Management**: For large VCFs, process by chromosome or use the `vcf` list indexing to handle samples individually.
- **Decoy Databases**: After generating the FASTA, remember to append decoy sequences (e.g., reversed sequences) for False Discovery Rate (FDR) estimation in proteomics search engines.
- **Transcript Filtering**: Use RNA-Seq expression data (RPKM/FPKM) to filter out lowly expressed transcripts before database generation to reduce the search space.

## Reference documentation
- [customProDB Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/customProDB.html)
- [customProDB Vignette](https://bioconductor.org/packages/release/bioc/vignettes/customProDB/inst/doc/customProDB.pdf)