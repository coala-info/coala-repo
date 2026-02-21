# Fission yeast time course

Here we provide the code which was used to contruct the
*RangedSummarizedExperiment* object of the *fission* experiment data
package. The count matrix was provided by the first author of the
publication:

Leong HS, Dawson K, Wirth C, Li Y, Connolly Y, Smith DL, Wilkinson CR,
Miller CJ. *A global non-coding RNA system modulates fission yeast
protein levels in response to stress*. **Nat Commun** 2014 May
23;5:3947.
PMID: [24853205](http://www.ncbi.nlm.nih.gov/pubmed/24853205).
GEO: [GSE56761](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE56761).

The following is quoted from the GEO series:

“Global transcription profiles of fission yeast
wild type (WT) and atf21del strains over an osmotic stress time course
following treatment with 1M sorbitol at 0, 15, 30, 60, 120 and 180
mins. Strand-specific single end sequencing of total RNA was performed
in biological triplicates on the Applied Biosystems SOLiD 5500xl
Genetic Analyzer System.”

“Sequencing reads were aligned to the fission yeast genome (PomBase
database release 11) using SHRiMP2 aligner with default
parameters. Total number of reads that can be aligned to the genome at
exactly one locus per sample range from 7.5 to 20.1 millions. These
uniquely mapped reads were used to identify stretches of unambiguous
transcription. Reads that aligned to more than one locus (generally
paralogous regions in the genome) were discarded. Adjacent unambiguous
transcription regions with minimum peak height of two and located
within 50 bases of each other were merged to yield an extensive
transcription map of S. pombe. These regions were then positioned
relative to known annotation and labelled according to the gene(s)
they overlapped with using the Bioconductor package annmap.”

# Object construction

The following code was used to read in the phenotypic data from GEO.

```
library("GEOquery")
gse <- getGEO(filename="GSE56761_series_matrix.txt")
pdata <- pData(gse)[,grepl("characteristics",names(pData(gse)))]
```

The *data.frame* was cleaned by replacing long character strings with
shorter ones, and turning the minute variable into a factor with the
correctly ordered levels.

```
names(pdata) <- c("strain","treatment","time","replicate")
pdataclean <- data.frame(strain=ifelse(grepl("wild type",pdata$strain),"wt","mut"),
                         minute=sub("time  \\(min\\): (.*)","\\1",pdata$time),
                         replicate=paste0("r",sub("replicate: (.*)","\\1",pdata$replicate)),
                         row.names=rownames(pdata))
pdataclean$id <- paste(pdataclean$strain,pdataclean$minute,pdataclean$replicate,sep="_")
pdataclean$strain <- relevel(pdataclean$strain, "wt")
pdataclean$minute <- factor(pdataclean$minute, levels=c("0","15","30","60","120","180"))
```

The rownames and colnames of the *RangedSummarizedExperiment* were confirmed
to line up with the gene annotations and phenotypic data table.

```
load("GSE56761_count_data.Rdata")
stopifnot(all.equal(rownames(reads.GSE56761), as.character(gene.annotations$pombase_id)))
colnames(reads.GSE56761) <- tolower(colnames(reads.GSE56761))
stopifnot(all.equal(colnames(reads.GSE56761), pdataclean$id))
colnames(reads.GSE56761) <- rownames(pdataclean)
library("SummarizedExperiment")
coldata <- DataFrame(pdataclean)
```

The gene annotation table was used to construct a *GRanges* object.

```
genes <- gene.annotations
rowranges <- GRanges(seqnames=genes$chromosome,
                     ranges=IRanges(genes$start,
                       genes$end),
                     strand=genes$strand,
                     genes[,6:7])
mcols(rowranges)$symbol <- as.character(mcols(rowranges)$symbol)
names(rowranges) <- genes$pombase_id
```

The Pubmed ID was used to generated a *MIAME* object to described the experiment.

```
library("annotate")
metadata <- pmid2MIAME("24853205")
metadata@url <- "http://www.ncbi.nlm.nih.gov/pubmed/24853205"
```

Finally the component parts were combined as a *RangedSummarizedExperiment*
and saved as an RData file.

```
fission <- SummarizedExperiment(SimpleList(counts=reads.GSE56761),
                                rowRanges=rowranges,
                                colData=coldata,
                                metadata=list(metadata))
save(fission, file="fission.RData")
```