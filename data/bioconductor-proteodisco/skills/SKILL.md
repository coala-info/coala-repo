---
name: bioconductor-proteodisco
description: ProteoDisco generates customized protein databases for proteogenomics by incorporating genomic and transcriptomic variants into protein sequences. Use when user asks to create FASTA databases from VCF or MAF files, import splice junctions, incorporate genomic variants into transcripts, or identify proteotypic peptides for mass spectrometry.
homepage: https://bioconductor.org/packages/release/bioc/html/ProteoDisco.html
---

# bioconductor-proteodisco

name: bioconductor-proteodisco
description: Generating customized protein databases for proteogenomics by incorporating genomic and transcriptomic variants into protein sequences. Use this skill when you need to create FASTA databases containing variant protein sequences from VCF/MAF files, splice junctions, or manual transcript sequences using the ProteoDisco R package.

# bioconductor-proteodisco

## Overview
ProteoDisco is a Bioconductor package designed for proteogenomics research. It facilitates the generation of novel variant protein sequences and their proteotypic peptides based on observed genomic or transcriptomic variants (SNVs, MNVs, InDels, fusions, and splice events). The package centers around a `ProteoDiscography` object which manages the relationship between reference genome sequences, gene annotations, and observed variants.

## Core Workflow

### 1. Initialize the ProteoDiscography
The `ProteoDiscography` object requires a `TxDb` (transcript annotations) and a `BSgenome` or `DNAStringSet` (genome sequences).

```r
library(ProteoDisco)
library(BSgenome.Hsapiens.UCSC.hg19)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

# Using pre-generated Bioconductor resources
pd <- generateProteoDiscography(
  TxDb = TxDb.Hsapiens.UCSC.hg19.knownGene, 
  genomeSeqs = BSgenome.Hsapiens.UCSC.hg19,
  geneticCode = "Standard"
)
```

### 2. Import Variants
You can import genomic variants (VCF/MAF), manual sequences, or splice junctions.

**Genomic Variants (SNVs/InDels):**
```r
pd <- importGenomicVariants(
  ProteoDiscography = pd,
  files = "path/to/variants.vcf",
  samplenames = "Sample1",
  performAnchorCheck = TRUE # Validates ref allele against genome
)
```

**Splice Junctions:**
```r
pd <- importSpliceJunctions(
  ProteoDiscography = pd,
  inputSpliceJunctions = "path/to/junctions.bed",
  isTopHat = FALSE
)

# Generate models for non-canonical junctions
pd <- generateJunctionModels(pd, skipCanonical = TRUE)
```

**Manual Sequences (e.g., Fusions):**
```r
manual_df <- S4Vectors::DataFrame(
  sample = "Sample1",
  identifier = "Fusion_Event_1",
  gene = "GENE-A",
  Tx.SequenceMut = Biostrings::DNAStringSet("ATGC...")
)
pd <- importTranscriptSequences(pd, transcripts = manual_df)
```

### 3. Incorporate Variants into Transcripts
This step maps the imported genomic variants onto the coding sequences (CDS) defined in the `ProteoDiscography`.

```r
pd <- incorporateGenomicVariants(
  ProteoDiscography = pd,
  aggregateSamples = FALSE,           # Keep samples separate
  aggregateWithinTranscript = TRUE,    # Combine multiple mutations in one transcript
  ignoreOverlappingMutations = TRUE
)
```

### 4. Identify Proteotypic Peptides (Optional)
To reduce search space in MS/MS, identify peptides unique to the mutant sequences.

```r
pd <- checkProteotypicFragments(
  pd,
  enzymUsed = "trypsin",
  missedCleavages = 1,
  checkWithinMutantSeqs = TRUE # Ensure uniqueness among all generated variants
)
```

### 5. Export to FASTA
Export the customized protein database for use in proteomics search engines.

```r
exportProteoDiscography(
  ProteoDiscography = pd,
  outFile = "custom_database.fasta",
  aggregateSamples = TRUE # Combine all samples into one FASTA
)
```

## Utility Functions
- `summary(pd)`: Provides an overview of imported variants and generated mutant transcripts.
- `getDiscography(pd)`: Retrieves the raw imported records.
- `mutantTranscripts(pd)`: Retrieves the generated mutant transcript and amino acid sequences.
- `setMutantTranscripts()`: Manually update or subset the generated mutant transcripts.

## Tips for Success
- **Anchor Checks:** Always keep `performAnchorCheck = TRUE` during import unless you are certain the VCF reference alleles match the `BSgenome` version exactly.
- **Parallelization:** Functions like `incorporateGenomicVariants` and `generateJunctionModels` support a `threads` argument for faster processing.
- **Gene Symbols:** If your `TxDb` uses Entrez IDs, use `org.Hs.eg.db` to map them to Symbols before exporting to make the FASTA headers more readable.
- **Logging:** Use `ParallelLogger` to monitor progress, especially for large VCF files.

## Reference documentation
- [Overview of ProteoDisco](./references/Overview_ProteoDisco.md)