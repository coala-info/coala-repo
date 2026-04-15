---
name: bioconductor-memes
description: bioconductor-memes provides a tidy R interface for performing motif analysis using the MEME Suite. Use when user asks to perform de-novo motif discovery, test for motif enrichment, scan sequences for motif occurrences, or compare motifs against databases.
homepage: https://bioconductor.org/packages/release/bioc/html/memes.html
---

# bioconductor-memes

name: bioconductor-memes
description: Motif analysis using the MEME Suite via the memes R package. Use this skill to perform de-novo motif discovery (DREME), motif enrichment testing (AME), motif scanning (FIMO), and motif comparison (TomTom) directly within R. Ideal for analyzing ChIP-seq, ATAC-seq, or other genomic sequence data.

# bioconductor-memes

## Overview
The `memes` package provides a "tidy" R interface to the MEME Suite. It allows users to transition seamlessly between genomic ranges (GRanges), DNA sequences (XStringSet), and motif data (universalmotif) while leveraging powerful motif analysis algorithms.

## Core Workflow

### 1. Setup and Installation
Ensure the MEME Suite is installed on the system. `memes` detects the installation automatically or via options.
```r
library(memes)
library(magrittr)
library(GenomicRanges)

# Verify installation
check_meme_install()

# Optional: Set default motif database
options(meme_db = "path/to/motifs.meme")
```

### 2. Preparing Sequences
Use `get_sequence()` to extract DNA sequences from a genome based on genomic coordinates. Motif analysis is most effective in small windows (e.g., 100bp) around peak summits.
```r
# Resize peaks to 100bp around center
peaks_100bp <- peaks %>% 
  plyranges::anchor_center() %>% 
  plyranges::mutate(width = 100)

# Get sequences
dm.genome <- BSgenome.Dmelanogaster.UCSC.dm3::BSgenome.Dmelanogaster.UCSC.dm3
seqs <- get_sequence(peaks_100bp, dm.genome)
```

### 3. Motif Enrichment (AME)
Test if known motifs are enriched in your sequences compared to a control (shuffled or specific background).
```r
# Run AME
ame_res <- runAme(seqs, control = "shuffle")

# Visualize results
plot_ame_heatmap(ame_res)
```

### 4. De-novo Discovery (DREME)
Discover novel motifs within sequences.
```r
# Discover motifs
dreme_res <- runDreme(seqs, control = "shuffle")

# View discovered motifs
universalmotif::view_motifs(to_list(dreme_res))
```

### 5. Motif Comparison (TomTom)
Compare discovered or known motifs against a database to identify the transcription factors they represent.
```r
# Compare DREME results to database
tomtom_res <- runTomTom(dreme_res)

# View best matches
view_tomtom_hits(tomtom_res, top_n = 3)
```

### 6. Motif Scanning (FIMO)
Locate specific motif occurrences within sequences.
```r
# Scan for a specific motif
fimo_res <- runFimo(seqs, motif_object)

# fimo_res is a GRanges object; easily join with original peak metadata
annotated_hits <- plyranges::join_overlap_left(fimo_res, peaks_100bp)
```

## Tips for Success
- **Input Formats**: Most `run*` functions accept `XStringSet`, paths to `.fasta` files, or lists of sequences for multi-group analysis.
- **Tidy Integration**: `memes` outputs are typically `data.frame` or `GRanges` objects, making them compatible with `dplyr`, `ggplot2`, and `plyranges`.
- **Database Filtering**: Filter your motif databases (e.g., using RNA-seq data) before running AME to reduce the multiple-testing burden and improve biological relevance.
- **Matched Sequences**: In FIMO, use `add_sequence()` to recover the actual DNA sequence under a motif hit if `skip_matched_sequence = TRUE` was used for speed.

## Reference documentation
- [Motif Enrichment Testing using AME](./references/core_ame.md)
- [Denovo Motif Discovery Using DREME](./references/core_dreme.md)
- [Motif Scanning using FIMO](./references/core_fimo.md)
- [Motif Comparison using TomTom](./references/core_tomtom.md)
- [Install MEME](./references/install_guide.md)
- [ChIP-seq Analysis](./references/integrative_analysis.md)
- [Tidy Motif Manipulation](./references/tidy_motifs.md)