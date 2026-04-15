---
name: bioconductor-annmap
description: The annmap package provides an R interface to the Annmap database for cross-mapping genomic features and Affymetrix probeset annotations. Use when user asks to map between genomic coordinates and transcripts, filter probesets by genomic specificity, or retrieve Ensembl-based gene and exon details.
homepage: https://bioconductor.org/packages/release/bioc/html/annmap.html
---

# bioconductor-annmap

## Overview
The `annmap` package provides a powerful R interface to the Annmap database, offering extensive cross-mapping capabilities for genomic features. It is designed as a base layer for interrogating genome and probeset annotation, supporting species-specific databases (primarily Ensembl-based). It is particularly useful for Affymetrix microarray analysis and integrating genomic coordinates with transcriptomics data.

## Core Workflow

### 1. Connection and Setup
`annmap` requires a connection to a MySQL database or the use of a web service.

```r
library(annmap)

# Connect via web service (easiest for testing)
annmapConnect(use.webservice = TRUE)

# Connect to a local database (requires databases.txt configuration)
# See INSTALL.md for database setup details
annmapConnect('human66') 

# Check/Set the current array type for probeset mappings
arrayType() # List available
arrayType('HuEx-1_0')

# Disconnect when finished
annmapDisconnect()
```

### 2. Finding Features by Name or ID
Functions follow a consistent naming convention: `[type]Details` or `[from]To[to]`.

```r
# Get gene details by symbol
gene = symbolToGene('PTEN')

# Map Gene to Transcripts
transcripts = geneToTranscript(gene)

# Map Gene to Exons
exons = geneToExon(gene)

# Get all chromosomes
chrs = allChromosomes()
```

### 3. Coordinate-Based Queries
Use `InRange` functions to find features within specific genomic boundaries.

```r
# Find genes in a region (Chr, Start, End, Strand)
# Strand: 1 (forward), -1 (reverse), or '*' (both)
genes = geneInRange('7', 1000000, 1060000, 1)

# Map exons in a range to their symbols
exons = exonInRange('10', 89622870, 89731687, 1)
symbols = exonToSymbol(exons)
```

### 4. Affymetrix Probeset Filtering
Probesets are categorized by their genomic hit specificity.

*   **Exonic**: All probes hit a single location within an exon.
*   **Intronic**: All probes hit a single location within a gene, but at least one misses an exon.
*   **Intergenic**: All probes hit a single location, but at least one misses all known genes.
*   **Unreliable**: Probes hit multiple locations or fail to map.

```r
ps = geneToProbeset(symbolToGene('TP53'), as.vector = TRUE)

# Filter by specificity
ex_ps = exonic(ps)
in_ps = intronic(ps)
un_ps = unreliable(ps)

# Get probesets hitting UTRs
utr_ps = utrProbesets(ps, end='3') # 3' UTR
```

### 5. Coordinate Conversion
Convert between Genomic, Transcript (spliced mRNA), and Protein coordinates.

```r
# Genomic to Transcript
genomeToTranscriptCoords(start(gene), transcripts)

# Transcript to Genomic (cds=TRUE accounts for UTRs)
transcriptCoordsToGenome(transcripts, 1, cds = TRUE)

# Map probes to mature mRNA offsets (spliced coordinates)
transcriptToTranslatedprobes('ENST00000462694')
```

### 6. Visualization
`annmap` provides built-in plotting for genomic regions and NGS data.

```r
# Basic genomic plot
range = symbolToGene('MPI')
genomicPlot(range, draw.opposite.strand = TRUE)

# Plot NGS data (BAM files) alongside gene models
# Requires bridge data format (see cookbook.md)
gene = symbolToGene('SHH')
ngsBridgePlot(gene, bamfileData)

# Gviz integration
atrack = geneToGeneRegionTrack(gene, genome = 'hg19')
```

## Tips and Best Practices
*   **Output Formats**: Most functions accept `as.vector = TRUE` to return IDs, or `as.data.frame = TRUE` for tabular data. By default, they return `GRanges` objects.
*   **The IN1 Column**: When mapping (e.g., `geneToExon`), the result contains an `IN1` column. This maps the output row back to the specific input ID that generated it, which is essential for merging data.
*   **Caching**: For large loops, use `annmapToggleCaching()` to speed up specificity filters.
*   **Commutativity**: Note that mappings involving probesets are NOT always commutative (Gene -> Probeset -> Gene may return extra genes if a probeset hits overlapping regions).

## Reference documentation
- [Installation and Database Configuration](./references/INSTALL.md)
- [Annmap Base Component Overview](./references/annmap.md)
- [The annmap Cookbook: Examples and Patterns](./references/cookbook.md)