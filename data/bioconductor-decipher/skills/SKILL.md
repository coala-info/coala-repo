---
name: bioconductor-decipher
description: DECIPHER is a comprehensive R package for the manipulation, alignment, and analysis of biological sequences. Use when user asks to perform multiple sequence alignment, classify sequences taxonomically using IDTAXA, cluster large sequence datasets, or analyze genomic synteny.
homepage: https://bioconductor.org/packages/release/bioc/html/DECIPHER.html
---


# bioconductor-decipher

name: bioconductor-decipher
description: Expert guidance for using the DECIPHER R package for sequence alignment, taxonomic classification, clustering, and genomic analysis. Use this skill when performing bioinformatics tasks in R such as multiple sequence alignment (MSA), IDTAXA taxonomic classification, large-scale sequence clustering, synteny analysis, or primer/probe design.

# bioconductor-decipher

## Overview
DECIPHER is a comprehensive R package for the manipulation and analysis of biological sequences. It is designed to handle large datasets efficiently, offering tools for sequence alignment, taxonomic classification (IDTAXA), clustering (Clusterize), and genomic analysis. It utilizes Biostrings objects (DNAStringSet, RNAStringSet, AAStringSet) and can interact with SQLite databases for memory-efficient processing of millions of sequences.

## Core Workflows

### 1. Multiple Sequence Alignment (MSA)
DECIPHER provides several functions for alignment depending on the sequence type and goal.

*   **General Alignment:** Use `AlignSeqs()` for DNA, RNA, or Amino Acid sequences.
*   **Protein-Coding DNA:** Use `AlignTranslation()` to align DNA based on its amino acid translation, which maintains the reading frame and improves accuracy.
*   **Non-coding RNA:** Use `AlignSeqs()` with an `RNAStringSet` to automatically incorporate secondary structure predictions.
*   **Large Alignments:** Use `AlignDB()` to align sequences stored in a database without loading them all into memory.
*   **Post-processing:** 
    *   `AdjustAlignment()`: Automatically shifts gaps to refine an existing alignment.
    *   `StaggerAlignment()`: Separates non-homologous regions to reduce false homologies for phylogenetics.
    *   `BrowseSeqs()`: View alignments in a web browser with highlighting.

### 2. Taxonomic Classification (IDTAXA)
The IDTAXA algorithm provides high-accuracy classification with a focus on minimizing false positives.

*   **Training:** Use `LearnTaxa()` on a training set of sequences with known taxonomy. It is recommended to iterate this process to remove "problem sequences" that are mislabeled in the training data.
*   **Classification:** Use `IdTaxa()` on test sequences.
    *   `threshold`: 60% is cautious/recommended for nucleotides; 50% for proteins.
    *   `strand`: Set to "top" if orientation is known to double speed.
*   **Results:** The output is a `Taxa` object. Use `plot(ids, trainingSet)` to visualize results as a pie chart and taxonomic tree.

### 3. Large-Scale Clustering
`Clusterize()` is designed for "supersized" clustering problems where traditional distance matrices are too large.

*   **Basic Usage:** `Clusterize(dna, cutoff = 0.05)` clusters sequences at 95% similarity.
*   **Linkage:** Default is center-linkage (representative-based). Set `singleLinkage = TRUE` for single-linkage clustering.
*   **Memory Management:** For millions of sequences, process in batches by sorting sequences by length and iteratively adding them to the clustering.
*   **Representative Selection:** Set `invertCenters = TRUE` to easily identify cluster representatives (returned as negative integers).

### 4. Synteny and Genome Analysis
For non-collinear sequences or whole genomes:

*   **Find Synteny:** `FindSynteny(dbConn)` finds homologous blocks between genomes in a database.
*   **Align Synteny:** `AlignSynteny(synteny, dbConn)` aligns the identified blocks.
*   **Visualization:** `pairs(synteny)` creates a dot plot matrix of genomic hits.

## Tips for Performance
*   **Database Usage:** For datasets exceeding available RAM, use `Seqs2DB()` to store sequences in an SQLite database and functions like `SearchDB()` or `AlignDB()` to process them.
*   **Parallelization:** Most DECIPHER functions include a `processors` argument. Set this to `NULL` to use all available cores.
*   **Sequence Orientation:** Use `OrientNucleotides()` before alignment or classification if sequences are in mixed orientations.
*   **De-replication:** Use `unique()` and `match()` to align only unique sequences, then map the alignment back to the original set to save time.

## Reference documentation
- [The Art of Multiple Sequence Alignment in R](./references/ArtOfAlignmentInR.md)
- [Classify Sequences in R](./references/ClassifySequences.md)
- [Upsize your clustering with Clusterize](./references/ClusteringSequences.md)
- [DECIPHERing](./references/DECIPHERing.md)
- [Design Microarrays](./references/DesignMicroarray.md)
- [Design Primers](./references/DesignPrimers.md)
- [Design Probes](./references/DesignProbes.md)
- [Design Signatures](./references/DesignSignatures.md)
- [Find Chimeras](./references/FindChimeras.md)
- [Finding Genes](./references/FindingGenes.md)
- [Finding Non-Coding RNAs](./references/FindingNonCodingRNAs.md)
- [Growing Trees](./references/GrowingTrees.md)
- [Population Genetics](./references/PopulationGenetics.md)
- [Repeat Repeat](./references/RepeatRepeat.md)
- [Search For Research](./references/SearchForResearch.md)