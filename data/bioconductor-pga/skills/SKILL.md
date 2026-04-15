---
name: bioconductor-pga
description: This package provides an automated pipeline for proteogenomics by constructing customized protein databases from RNA-Seq data and performing MS/MS searches. Use when user asks to build customized protein databases from genomic variants or de novo assemblies, perform MS/MS database searches, and identify novel peptides through proteogenomics analysis.
homepage: https://bioconductor.org/packages/3.8/bioc/html/PGA.html
---

# bioconductor-pga

name: bioconductor-pga
description: Construction of customized protein databases from RNA-Seq data and MS/MS proteomics data searching. Use this skill when you need to perform proteogenomics analysis, including: (1) Building customized FASTA databases from VCF (SNVs/Indels), BED (junctions), or GTF (novel transcripts) files; (2) Creating protein databases from de novo RNA-Seq assemblies (e.g., Trinity); (3) Running MS/MS database searches using X!Tandem; (4) Post-processing search results (q-value calculation, protein inference); and (5) Generating HTML reports for novel peptide identification.

## Overview

The PGA (Phylogenomics Analysis) package provides an automated pipeline for proteogenomics. It bridges the gap between transcriptomics and proteomics by generating customized protein databases that include novel sequences (SNVs, Indels, alternative splicing, and novel transcripts) derived from RNA-Seq data. It integrates database construction, MS/MS searching via rTANDEM, and result validation.

## Core Workflows

### 1. Database Construction (Reference-based)
To build a database from genomic coordinates, you need VCF, BED, and GTF files along with a BSgenome object.

```r
library(PGA)
library(BSgenome.Hsapiens.UCSC.hg19)

# Define input files
vcffile <- "path/to/variants.vcf"
bedfile <- "path/to/junctions.bed"
gtffile <- "path/to/transcripts.gtf"
annotation <- "path/to/annotation_folder"

# Create the database
dbfile <- dbCreator(gtfFile=gtffile, 
                    vcfFile=vcffile, 
                    bedFile=bedfile,
                    annotation_path=annotation, 
                    outfile_name="custom_db",
                    genome=Hsapiens, 
                    outdir="db_output",
                    make_decoy=TRUE)
```

### 2. Database Construction (De Novo)
For non-model organisms without a reference genome, use FASTA files from de novo assembly (e.g., Trinity).

```r
transcript_fasta <- "Trinity.fasta"
outdb <- createProDB4DenovoRNASeq(infa=transcript_fasta, 
                                  outfile_name = "denovo_db")
```

### 3. MS/MS Searching
PGA uses the `rTANDEM` package to interface with X!Tandem.

```r
msfile <- "data.mgf"
idfile <- runTandem(spectra = msfile, 
                    fasta = dbfile, 
                    outdir = "./search_results", 
                    cpu = 6,
                    enzyme = "[KR]|[X]", 
                    varmod = "15.994915@M", 
                    fixmod = "57.021464@C", 
                    tol = 10, tolu = "ppm",
                    miss = 2)
```

### 4. Post-processing and Parsing
This step calculates q-values and performs protein inference using the Occam's razor approach.

```r
# Parse X!Tandem results
parserGear(file = idfile, 
           db = dbfile, 
           decoyPrefix="#REV#", 
           xmx=2, # Java heap size in GB
           thread=8,
           outdir = "parser_results")

# Supports other formats: Mascot (.dat) or mzIdentML (.mzid)
# parserGear(file = "mascot.dat", db = dbfile, ...)
```

### 5. Report Generation
Generates an interactive HTML report summarizing identified novel peptides.

```r
reportGear(parser_dir = "parser_results", 
           tab_dir = "db_output", 
           report_dir = "html_report")
```

## Integrated Pipeline
The `easyRun` function executes all steps (Database -> Search -> Post-process -> Report) in a single call.

```r
easyRun(gtfFile=gtffile, vcfFile=vcffile, bedFile=bedfile, 
        spectra=msfile, annotation_path=annotation, 
        genome=Hsapiens, cpu=6, enzyme="[KR]|[X]", 
        varmod="15.994915@M", fixmod="57.021464@C")
```

## Tips and Best Practices
- **Annotation Files**: Use `PrepareAnnotationRefseq2` or `PrepareAnnotationEnsembl2` to generate the required annotation objects before running `dbCreator`.
- **Memory Management**: The `parserGear` function uses Java. Adjust the `xmx` parameter (e.g., `xmx=2` for 2GB) based on your system's RAM and the size of the MS/MS data.
- **Decoy Sequences**: Always ensure `make_decoy=TRUE` (default) during database creation to allow for False Discovery Rate (FDR) estimation during the parsing stage.
- **External Search Engines**: While PGA provides a wrapper for X!Tandem, you can import results from Mascot, MS-GF+, MyriMatch, or OMSSA as long as they are in `.dat` or `.mzid` formats.

## Reference documentation
- [PGA](./references/PGA.md)