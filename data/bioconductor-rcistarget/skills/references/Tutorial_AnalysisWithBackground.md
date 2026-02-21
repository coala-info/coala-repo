# Motif enrichment with background

Abstract

This tutorial shows how to use **RcisTarget** with background.

This tutorial requires RcisTarget >= 1.7.1.

```
packageVersion("RcisTarget")
```

```
## [1] '1.29.0'
```

### 1. Select the gene/region set to analyze & the “background”

```
# Genes to analyze:
txtFile <- paste(file.path(system.file('examples', package='RcisTarget')),"hypoxiaGeneSet.txt", sep="/")
geneSets <- list(hypoxia=read.table(txtFile, stringsAsFactors=FALSE)[,1])

# Background:
txtFile <- paste(file.path(system.file('examples', package='RcisTarget')),"randomGeneSet.txt", sep="/") # for the toy example we will use a few random genes
background <- read.table(txtFile, stringsAsFactors=FALSE)[,1]
```

The background should contain the target genes/regions.

If for any reason that is not the case, you can **add** the target genes to the background, or **remove** the target genes missing from the background (depending on what makes more sense in your specific analysis).

```
# A: Add
background <- unique(c(geneSets$hypoxia, background))
# B: Intersect
# geneSets$hypoxia <- intersect(geneSets$hypoxia, background)
```

```
gplots::venn(list(background=background, geneLists=unlist(geneSets)))
```

![](data:image/png;base64...)

### 2. Create the background-ranking

Select the appropriate ranking-database:

```
dbPath <- "~/databases/hg19-500bp-upstream-10species.mc9nr.feather"
```

Load the database and re-rank the genes/motifs (e.g. only within the “background+foreground”)

```
library(RcisTarget)
rankingsDb <- importRankings(dbPath, columns=background)
bgRanking <- reRank(rankingsDb)
```

### 3. Run RcisTarget with this new ranking

Once the “background-ranking” is ready, just use it to run RcisTarget as usual:

> Note: Since the ‘background database’ is typically much smaller than the full database (it has fewer genes or regions), we recommend to use `geneErnMethod = "icistarget"` instead of ‘aprox’.

```
motifEnrichmentTable <- cisTarget(geneSets, bgRanking,
                                  aucMaxRank=0.03*getNumColsInDB(bgRanking),
                                  geneErnMaxRank=getNumColsInDB(bgRanking),
                                  geneErnMethod = "icistarget")
```

```
showLogo(motifEnrichmentTable)
```