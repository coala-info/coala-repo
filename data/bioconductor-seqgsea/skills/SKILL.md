---
name: bioconductor-seqgsea
description: SeqGSEA performs gene set enrichment analysis for RNA-Seq data by integrating differential expression and differential splicing signals. Use when user asks to identify enriched biological pathways, integrate differential expression and splicing analysis, or perform gene set enrichment analysis on high-throughput sequencing data.
homepage: https://bioconductor.org/packages/release/bioc/html/SeqGSEA.html
---

# bioconductor-seqgsea

name: bioconductor-seqgsea
description: Gene set enrichment analysis (GSEA) for RNA-Seq data integrating differential expression (DE) and differential splicing (DS). Use this skill when analyzing high-throughput sequencing data to identify enriched biological pathways while accounting for both transcript abundance and alternative splicing events.

# bioconductor-seqgsea

## Overview
SeqGSEA is a Bioconductor package designed to integrate differential expression (DE) and differential splicing (DS) into a unified gene set enrichment analysis. It models RNA-Seq read counts using a negative binomial distribution to account for biological variation and sequencing biases. The package is particularly useful for discovering biological insights that might be missed by looking at gene-level expression alone.

## Core Workflow

### 1. Data Initialization
SeqGSEA uses the `ReadCountSet` class to store exon-level counts.

```R
library(SeqGSEA)
# Create ReadCountSet from exon counts, exon IDs, and gene IDs
RCS <- newReadCountSet(counts, exonIDs, geneIDs)

# Filter low-count exons (default cutoff = 5)
RCS <- exonTestability(RCS, cutoff = 5)
```

### 2. Differential Splicing (DS) Analysis
DS analysis calculates NB-statistics for exons and aggregates them to the gene level.

```R
# Calculate DS statistics
RCS <- estiExonNBstat(RCS)
RCS <- estiGeneNBstat(RCS)

# Permutation for empirical background (recommended: times=1000)
permuteMat <- genpermuteMat(RCS, times = 1000)
RCS <- DSpermute4GSEA(RCS, permuteMat)

# Normalize DS scores
DSscore.normFac <- normFactor(RCS@permute_NBstat_gene)
DSscore <- scoreNormalization(RCS@featureData_gene$NBstat, DSscore.normFac)
DSscore.perm <- scoreNormalization(RCS@permute_NBstat_gene, DSscore.normFac)
```

### 3. Differential Expression (DE) Analysis
DE analysis is performed at the gene level, typically using `DESeq2` internally.

```R
# Aggregate exon counts to gene counts
geneCounts <- getGeneCount(RCS)
label <- label(RCS)

# Run DE analysis
dds <- runDESeq(geneCounts, label)
DEGres <- DENBStat4GSEA(dds)

# Permutation for DE (use same permuteMat as DS)
DEpermNBstat <- DENBStatPermut4GSEA(dds, permuteMat)

# Normalize DE scores
DEscore.normFac <- normFactor(DEpermNBstat)
DEscore <- scoreNormalization(DEGres$NBstat, DEscore.normFac)
DEscore.perm <- scoreNormalization(DEpermNBstat, DEscore.normFac)
```

### 4. Score Integration
Combine DE and DS scores using linear or rank-based methods. The `DEweight` parameter (0 to 1) controls the contribution of expression vs. splicing.

```R
# Linear integration (e.g., 30% DE, 70% DS)
gene.score <- geneScore(DEscore, DSscore, method="linear", DEweight = 0.3)
gene.score.perm <- genePermuteScore(DEscore.perm, DSscore.perm, method="linear", DEweight = 0.3)

# Rank-based integration (often more robust)
combine <- rankCombine(DEscore, DSscore, DEscore.perm, DSscore.perm, DEweight = 0.3)
gene.score <- combine$geneScore
gene.score.perm <- combine$genePermuteScore
```

### 5. Gene Set Enrichment Analysis
Load gene sets (GMT format) and run the enrichment analysis.

```R
# Load gene sets (supports MSigDB symbols or Ensembl IDs)
gene.set <- loadGenesets(gmtFile, geneIDs, geneID.type = "ensembl")

# Run GSEA
gene.set <- GSEnrichAnalyze(gene.set, gene.score, gene.score.perm)

# View top results
topGeneSets(gene.set, n = 10)
```

## Visualization and Results
*   `plotGeneScore(gene.score, gene.score.perm)`: Visualize the distribution of integrated scores.
*   `plotES(gene.set)`: Plot the distribution of Normalized Enrichment Scores (NES).
*   `plotSigGeneSet(gene.set, index, gene.score)`: Detailed running ES plot for a specific gene set.
*   `GSEAresultTable(gene.set)`: Generate a summary table of results.

## Performance Tips
*   **Parallelization**: Use `doParallel` to speed up permutations.
    ```R
    library(doParallel)
    cl <- makeCluster(parallel::detectCores())
    registerDoParallel(cl)
    ```
*   **One-Step Analysis**: For a standard pipeline, use the wrapper function `runSeqGSEA`.

## Reference documentation
- [SeqGSEA](./references/SeqGSEA.md)