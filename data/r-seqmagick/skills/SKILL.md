---
name: r-seqmagick
description: The r-seqmagick package provides utilities for sequence manipulation, file conversion, and alignment processing within the R environment. Use when user asks to download sequences from GenBank, convert between FASTA and PHYLIP formats, filter sequences by pattern, or generate consensus sequences from alignments.
homepage: https://cran.r-project.org/web/packages/seqmagick/index.html
---


# r-seqmagick

## Overview
The `seqmagick` package provides a suite of utilities for sequence manipulation in R. It bridges the gap between various sequence formats and provides a streamlined workflow for filtering, aligning, and converting sequence data. It integrates well with the `Biostrings` package and supports piped workflows using `%>%`.

## Installation
```r
install.packages("seqmagick")
```

## Core Workflows

### 1. Downloading Sequences
Retrieve sequences directly from NCBI GenBank using accession numbers.
```r
library(seqmagick)

# Download as GenBank format
download_genbank(acc='AB115403', format='genbank', outfile='sequence.gb')

# Download as FASTA format
download_genbank(acc='AB115403', format='fasta', outfile='sequence.fa')
```

### 2. File Conversion
`seqmagick` handles the nuances of interleaved and sequential formats for both FASTA and PHYLIP files.

**FASTA to PHYLIP (Aligned sequences only):**
```r
# Convert FASTA to PHYLIP sequential
fas2phy("input.fas", "output.phy", type = 'sequential')

# Convert PHYLIP to FASTA interleaved
phy2fas("input.phy", "output.fas", type = 'interleaved')
```

**Layout Conversion:**
```r
# Change a PHYLIP file from sequential to interleaved
phy_read("sequential.phy") %>% 
    phy_write("interleaved.phy", type = "interleaved")
```

### 3. Sequence Manipulation
The package uses `bs_` prefix functions to operate on `XStringSet` objects (from Biostrings).

**Filtering and Alignment:**
```r
# Read FASTA and filter by a specific sequence pattern
bs <- fa_read("input.fasta")
filtered_bs <- bs_filter(bs, 'ATGAAAGTAAAA', by='sequence')

# Perform alignment on the filtered set
aln <- bs_aln(filtered_bs, quiet=TRUE)
```

**Consensus Sequences:**
```r
# Calculate the consensus sequence from an alignment
consensus_seq <- bs_consensus(aln)
```

## Tips for Success
- **Piping:** Use the `magrittr` pipe `%>%` to chain `fa_read`, `bs_filter`, and `fa_write` for clean code.
- **PHYLIP Constraint:** Remember that PHYLIP format is strictly for aligned sequences of equal length.
- **Interleaved vs. Sequential:** If a downstream tool fails to read your file, try toggling the `type` parameter between `'interleaved'` and `'sequential'`.
- **Large Files:** For very large FASTA files, `fa_read` is optimized for memory efficiency within the R environment.

## Reference documentation
- [seqmagick introduction](./references/seqmagick.Rmd)