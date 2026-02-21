Code

* Show All Code
* Hide All Code

# Basic checks of BioPlex PPI data

#### 6 March 2022

#### Package

BioPlex 1.0.2

# 1 Setup

```
library(BioPlex)
library(AnnotationDbi)
library(AnnotationHub)
library(graph)
```

Connect to
[AnnotationHub](http://bioconductor.org/packages/AnnotationHub):

```
ah <- AnnotationHub::AnnotationHub()
```

Connect to
[ExperimentHub](http://bioconductor.org/packages/ExperimentHub):

```
eh <- ExperimentHub::ExperimentHub()
```

OrgDb package for human:

```
orgdb <- AnnotationHub::query(ah, c("orgDb", "Homo sapiens"))
orgdb <- orgdb[[1]]
orgdb
#> OrgDb object:
#> | DBSCHEMAVERSION: 2.1
#> | Db type: OrgDb
#> | Supporting package: AnnotationDbi
#> | DBSCHEMA: HUMAN_DB
#> | ORGANISM: Homo sapiens
#> | SPECIES: Human
#> | EGSOURCEDATE: 2021-Sep13
#> | EGSOURCENAME: Entrez Gene
#> | EGSOURCEURL: ftp://ftp.ncbi.nlm.nih.gov/gene/DATA
#> | CENTRALID: EG
#> | TAXID: 9606
#> | GOSOURCENAME: Gene Ontology
#> | GOSOURCEURL: http://current.geneontology.org/ontology/go-basic.obo
#> | GOSOURCEDATE: 2021-09-01
#> | GOEGSOURCEDATE: 2021-Sep13
#> | GOEGSOURCENAME: Entrez Gene
#> | GOEGSOURCEURL: ftp://ftp.ncbi.nlm.nih.gov/gene/DATA
#> | KEGGSOURCENAME: KEGG GENOME
#> | KEGGSOURCEURL: ftp://ftp.genome.jp/pub/kegg/genomes
#> | KEGGSOURCEDATE: 2011-Mar15
#> | GPSOURCENAME: UCSC Genome Bioinformatics (Homo sapiens)
#> | GPSOURCEURL:
#> | GPSOURCEDATE: 2021-Jul20
#> | ENSOURCEDATE: 2021-Apr13
#> | ENSOURCENAME: Ensembl
#> | ENSOURCEURL: ftp://ftp.ensembl.org/pub/current_fasta
#> | UPSOURCENAME: Uniprot
#> | UPSOURCEURL: http://www.UniProt.org/
#> | UPSOURCEDATE: Wed Sep 15 18:21:59 2021
keytypes(orgdb)
#>  [1] "ACCNUM"       "ALIAS"        "ENSEMBL"      "ENSEMBLPROT"  "ENSEMBLTRANS"
#>  [6] "ENTREZID"     "ENZYME"       "EVIDENCE"     "EVIDENCEALL"  "GENENAME"
#> [11] "GENETYPE"     "GO"           "GOALL"        "IPI"          "MAP"
#> [16] "OMIM"         "ONTOLOGY"     "ONTOLOGYALL"  "PATH"         "PFAM"
#> [21] "PMID"         "PROSITE"      "REFSEQ"       "SYMBOL"       "UCSCKG"
#> [26] "UNIPROT"
```

# 2 Check: identify CORUM complexes that have a subunit of interest

Get core set of complexes:

```
core <- getCorum(set = "core", organism = "Human")
```

Turn the CORUM complexes into a list of graph instances,
where all nodes of a complex are connected to all other nodes of that complex
with undirected edges.

```
core.glist <- corum2graphlist(core, subunit.id.type = "UNIPROT")
```

Identify complexes that have a subunit of interest:

```
has.cdk2 <- hasSubunit(core.glist,
                       subunit = "CDK2",
                       id.type = "SYMBOL")
```

Check the answer:

```
table(has.cdk2)
#> has.cdk2
#> FALSE  TRUE
#>  2408     9
cdk2.glist <- core.glist[has.cdk2]
lapply(cdk2.glist, function(g) unlist(graph::nodeData(g, attr = "SYMBOL")))
#> $CORUM311_Cell_cycle_kinase_complex_CDK2
#>   P12004   P24385   P24941   P38936
#>   "PCNA"  "CCND1"   "CDK2" "CDKN1A"
#>
#> $`CORUM1003_RC_complex_(Replication_competent_complex)`
#>  P09884  P20248  P24941  P35249  P35250  P35251  P40937  P40938  Q14181
#> "POLA1" "CCNA2"  "CDK2"  "RFC4"  "RFC2"  "RFC1"  "RFC5"  "RFC3" "POLA2"
#>
#> $`CORUM1004_RC_complex_during_S-phase_of_cell_cycle`
#>  P09874  P09884  P11387  P15927  P18858  P20248  P24941  P27694  P28340  P35244
#> "PARP1" "POLA1"  "TOP1"  "RPA2"  "LIG1" "CCNA2"  "CDK2"  "RPA1" "POLD1"  "RPA3"
#>  P35250  P35251  Q07864
#>  "RFC2"  "RFC1"  "POLE"
#>
#> $`CORUM1656_p27-cyclinE-CDK2_complex`
#>   P24864   P24941   P46527
#>  "CCNE1"   "CDK2" "CDKN1B"
#>
#> $`CORUM3015_p27-cyclinE-Cdk2_-_Ubiquitin_E3_ligase_(SKP1A,_SKP2,_CUL1,_CKS1B,_RBX1)_complex`
#>   P24864   P24941   P46527   P61024   P62877   P63208   Q13309   Q13616
#>  "CCNE1"   "CDK2" "CDKN1B"  "CKS1B"   "RBX1"   "SKP1"   "SKP2"   "CUL1"
#>
#> $`CORUM5556_CDK2-CCNA2_complex`
#>  P20248  P24941
#> "CCNA2"  "CDK2"
#>
#> $`CORUM5559_CDC2-CCNA2-CDK2_complex`
#>  P06493  P20248  P24941
#>  "CDK1" "CCNA2"  "CDK2"
#>
#> $`CORUM5560_CDK2-CCNE1_complex`
#>  P24864  P24941
#> "CCNE1"  "CDK2"
#>
#> $`CORUM6589_E2F-1-DP-1-cyclinA-CDK2_complex`
#>  P24941  P78396  Q01094  Q14186
#>  "CDK2" "CCNA1"  "E2F1" "TFDP1"
```

We can then also inspect the graph with plotting utilities from the
[Rgraphviz](https://bioconductor.org/packages/Rgraphviz)
package:

```
plot(cdk2.glist[[1]], main = names(cdk2.glist)[1])
```

# 3 Check: extract BioPlex PPIs for a CORUM complex

Get the latest version of the 293T PPI network:

```
bp.293t <- getBioPlex(cell.line = "293T", version = "3.0")
```

Turn the BioPlex PPI network into one big graph where bait and prey relationship
are represented by directed edges from bait to prey.

```
bp.gr <- bioplex2graph(bp.293t)
```

Now we can also easily pull out a BioPlex subnetwork for a CORUM complex
of interest:

```
n <- graph::nodes(cdk2.glist[[1]])
bp.sgr <- graph::subGraph(n, bp.gr)
bp.sgr
#> A graphNEL graph with directed edges
#> Number of Nodes = 4
#> Number of Edges = 5
```

# 4 Check: identify interacting domains for a PFAM domain of interest

Add PFAM domain annotations to the node metadata:

```
bp.gr <- BioPlex::annotatePFAM(bp.gr, orgdb)
```

Create a map from PFAM to UNIPROT:

```
unip2pfam <- graph::nodeData(bp.gr, graph::nodes(bp.gr), "PFAM")
pfam2unip <- stack(unip2pfam)
pfam2unip <- split(as.character(pfam2unip$ind), pfam2unip$values)
head(pfam2unip, 2)
#> $PF00001
#>  [1] "P28566" "P25106" "P23945" "Q9HBX9" "P16473" "P04201" "Q9HC97" "P30968"
#>  [9] "Q9Y2T6" "Q14330" "P46089" "Q15391" "Q9BXA5" "Q13304" "P61073" "P21462"
#> [17] "P25090" "Q99679" "P21730" "P30556" "P43088" "P32246" "P32249" "Q9Y2T5"
#> [25] "Q7Z602" "P43657" "O00398" "Q9H244" "Q86VZ1" "Q9NPB9" "Q99788" "P51684"
#> [33] "P35414" "O00590" "Q9H1Y3" "P55085" "O15218" "Q9GZQ4" "P25101" "Q9NS66"
#> [41] "Q9NQS5" "P21453" "P14416" "P24530" "P32239" "Q16581" "O00421" "Q9UHM6"
#> [49] "Q8N6U8" "P20309" "O15354" "Q9BXC0" "P47775" "P30550" "P49146" "P47900"
#> [57] "Q8TDU9" "P25103" "P35372" "P41597" "Q9P296" "P28335" "O95136" "P08173"
#> [65] "P29371" "P41146" "P43119" "O95977" "Q9HBW0" "Q99677" "Q9BXB1" "Q8WXD0"
#> [73] "O43193" "P30989" "Q8NGU9" "P47901" "P22888" "Q9GZN0" "P21917" "O60755"
#> [81] "Q8TDV0" "O43614" "Q9NS67" "P08912" "Q9UPC5" "Q8TDV2" "Q92633" "Q9NQ55"
#> [89] "Q13585" "Q9UBY5" "Q9H228" "P28222"
#>
#> $PF00002
#>  [1] "Q8IZP9" "P41587" "Q8IZF4" "P49190" "P32241" "P47871" "P48960" "Q8IZF5"
#>  [9] "O14514" "Q03431" "Q9NYQ6" "Q9HCU4" "Q8WXG9" "Q9NYQ7" "O60242" "O60241"
#> [17] "Q9HAR2" "O94910" "Q8IWK6" "O95490" "Q96PE1" "Q86SQ4"
```

Let’s focus on [PF02023](http://pfam.xfam.org/family/PF02023), corresponding to the
zinc finger-associated SCAN domain. For each protein containing the SCAN domain,
we now extract PFAM domains connected to the SCAN domain by an edge in the BioPlex network.

```
scan.unip <- pfam2unip[["PF02023"]]
getIAPfams <- function(n) graph::nodeData(bp.gr, graph::edges(bp.gr)[[n]], "PFAM")
unip2iapfams <- lapply(scan.unip, getIAPfams)
unip2iapfams <- lapply(unip2iapfams, unlist)
names(unip2iapfams) <- scan.unip
```

Looking at the top 5 PFAM domains most frequently connected to the SCAN domain
by an edge in the BioPlex network …

```
pfam2iapfams <- unlist(unip2iapfams)
sort(table(pfam2iapfams), decreasing = TRUE)[1:5]
#> pfam2iapfams
#> PF02023 PF00096 PF01352 PF06467 PF00249
#>     208     169      99      14       8
```

… we find [PF02023](http://pfam.xfam.org/family/PF02023), the SCAN domain itself,
and [PF00096](http://pfam.xfam.org/family/PF00096), a C2H2 type zinc finger domain.
This finding is consistent with results reported in the
[BioPlex 3.0 publication](https://doi.org/10.1016/j.cell.2021.04.011).

See also the
[PFAM domain-domain association analysis vignette](https://ccb-hms.github.io/BioPlexAnalysis/articles/PFAM.html)
for a more comprehensive analysis of PFAM domain associations in the BioPlex network.

# 5 Check: expressed genes are showing up as prey (293T cells)

Get RNA-seq data for HEK293 cells from GEO:
[GSE122425](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE122425)

```
se <- getGSE122425()
se
#> class: SummarizedExperiment
#> dim: 57905 6
#> metadata(0):
#> assays(2): raw rpkm
#> rownames(57905): ENSG00000223972 ENSG00000227232 ... ENSG00000231514
#>   ENSG00000235857
#> rowData names(4): SYMBOL KO GO length
#> colnames(6): GSM3466389 GSM3466390 ... GSM3466393 GSM3466394
#> colData names(41): title geo_accession ... passages.ch1 strain.ch1
```

Inspect expression of prey genes:

```
bait <- unique(bp.293t$SymbolA)
length(bait)
#> [1] 8995
prey <- unique(bp.293t$SymbolB)
length(prey)
#> [1] 10419
```

```
ind <- match(prey, rowData(se)$SYMBOL)
par(las = 2)
boxplot(log2(assay(se, "rpkm") + 0.5)[ind,],
        names = se$title,
        ylab = "log2 RPKM")
```

![](data:image/png;base64...)

How many prey genes are expressed (raw read count > 0) in all 3 WT reps:

```
# background: how many genes in total are expressed in all three WT reps
gr0 <- rowSums(assay(se)[,1:3] > 0)
table(gr0 == 3)
#>
#> FALSE  TRUE
#> 33842 24063
# prey: expressed in all three WT reps
table(gr0[ind] == 3)
#>
#> FALSE  TRUE
#>   599  9346
# prey: expressed in at least one WT rep
table(gr0[ind] > 0)
#>
#> FALSE  TRUE
#>   305  9640
```

Are prey genes overrepresented in the expressed genes?

```
exprTable <-
     matrix(c(9346, 1076, 14717, 32766),
            nrow = 2,
            dimnames = list(c("Expressed", "Not.expressed"),
                            c("In.prey.set", "Not.in.prey.set")))
exprTable
#>               In.prey.set Not.in.prey.set
#> Expressed            9346           14717
#> Not.expressed        1076           32766
```

Test using hypergeometric test (i.e. one-sided Fisher’s exact test):

```
fisher.test(exprTable, alternative = "greater")
#>
#>  Fisher's Exact Test for Count Data
#>
#> data:  exprTable
#> p-value < 2.2e-16
#> alternative hypothesis: true odds ratio is greater than 1
#> 95 percent confidence interval:
#>  18.29105      Inf
#> sample estimates:
#> odds ratio
#>   19.34726
```

Alternatively: permutation test, i.e. repeatedly sample number of prey genes
from the background, and assess how often we have as many or more than 9346 genes
expressed:

```
permgr0 <- function(gr0, nr.genes = length(prey))
{
    ind <- sample(seq_along(gr0), nr.genes)
    sum(gr0[ind] == 3)
}
```

```
perms <- replicate(permgr0(gr0), 1000)
summary(perms)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>    1000    1000    1000    1000    1000    1000
(sum(perms >= 9346) + 1) / 1001
#> [1] 0.000999001
```

# 6 Check: is there a relationship between prey frequency and prey expression level?

Check which genes turn up most frequently as prey:

```
prey.freq <- sort(table(bp.293t$SymbolB), decreasing = TRUE)
preys <- names(prey.freq)
prey.freq <- as.vector(prey.freq)
names(prey.freq) <- preys
head(prey.freq)
#> HSPA5 HSPA8 TUBB8   UBB  YBX1 YWHAH
#>   199   192   176   173   139   132
summary(prey.freq)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>    1.00    2.00    6.00   11.34   16.00  199.00
hist(prey.freq, breaks = 50, main = "", xlab = "Number of PPIs", ylab = "Number of genes")
```

![](data:image/png;base64...)

Prey genes are involved 11 PPIs on average.

There doesn’t seem to be a strong correlation between expression level and the
frequency of gene to turn up as prey:

```
ind <- match(names(prey.freq), rowData(se)$SYMBOL)
rmeans <- rowMeans(assay(se, "rpkm")[ind, 1:3])
log.rmeans <- log2(rmeans + 0.5)
par(pch = 20)
plot( x = prey.freq,
      y = log.rmeans,
      xlab = "prey frequency",
      ylab = "log2 RPKM")
```

![](data:image/png;base64...)

```
cor(prey.freq,
    log.rmeans,
    use = "pairwise.complete.obs")
#> [1] 0.2035977
```

See also the [BioNet maximum scoring subnetwork analysis vignette](https://ccb-hms.github.io/BioPlexAnalysis/articles/BioNet.html)
for a more comprehensive analysis of the 293T transcriptome data from GSE122425
when mapped onto BioPlex PPI network.

# 7 Check: differential protein expression (HEK293 vs. HCT116)

Get the relative protein expression data comparing 293T and HCT116 cells
from Supplementary Table S4A of the BioPlex 3 paper:

```
bp.prot <- getBioplexProteome()
bp.prot
#> class: SummarizedExperiment
#> dim: 9604 10
#> metadata(0):
#> assays(1): exprs
#> rownames(9604): P0CG40 Q8IXZ3-4 ... Q9H3S5 Q8WYQ3
#> rowData names(5): ENTREZID SYMBOL nr.peptides log2ratio adj.pvalue
#> colnames(10): HCT1 HCT2 ... HEK4 HEK5
#> colData names(1): cell.line
rowData(bp.prot)
#> DataFrame with 9604 rows and 5 columns
#>             ENTREZID      SYMBOL nr.peptides log2ratio  adj.pvalue
#>          <character> <character>   <integer> <numeric>   <numeric>
#> P0CG40     100131390         SP9           1 -2.819071 6.66209e-08
#> Q8IXZ3-4      221833         SP8           3 -3.419888 6.94973e-07
#> P55011          6558     SLC12A2           4  0.612380 4.85602e-06
#> O60341         23028       KDM1A           7 -0.319695 5.08667e-04
#> O14654          8471        IRS4           4 -5.951096 1.45902e-06
#> ...              ...         ...         ...       ...         ...
#> Q9H6X4         80194     TMEM134           2 -0.379342 7.67195e-05
#> Q9BS91         55032     SLC35A5           1 -2.237634 8.75523e-05
#> Q9UKJ5         26511       CHIC2           1 -0.614932 1.78756e-03
#> Q9H3S5         93183        PIGM           1 -1.011397 8.91589e-06
#> Q8WYQ3        400916     CHCHD10           1  0.743852 1.17163e-03
```

A couple of quick sanity checks:

1. The relative abundances are scaled to sum up to 100% for each protein:

```
rowSums(assay(bp.prot)[1:5,])
#>    P0CG40  Q8IXZ3-4    P55011    O60341    O14654
#>  99.99994  99.99991  99.99996 100.00011 100.00006
```

2. The `rowData` column `log2ratio` corresponds to the mean of the five HEK samples,
   divided by the mean of the five HCT samples (and then taking log2 of it):

```
ratio <- rowMeans(assay(bp.prot)[1:5, 1:5]) / rowMeans(assay(bp.prot)[1:5, 6:10])
log2(ratio)
#>     P0CG40   Q8IXZ3-4     P55011     O60341     O14654
#> -2.8190710 -3.4198879  0.6123799 -0.3196953 -5.9510960
```

3. The `rowData` column `adj.pvalue` stores Benjamini-Hochberg adjusted *p*-values
   from a *t*-test between the five HEK samples and the five HCT samples:

```
t.test(assay(bp.prot)[1, 1:5], assay(bp.prot)[1, 6:10])
#>
#>  Welch Two Sample t-test
#>
#> data:  assay(bp.prot)[1, 1:5] and assay(bp.prot)[1, 6:10]
#> t = -27.898, df = 7.5779, p-value = 6.482e-09
#> alternative hypothesis: true difference in means is not equal to 0
#> 95 percent confidence interval:
#>  -16.29035 -13.78047
#> sample estimates:
#> mean of x mean of y
#>  2.482288 17.517700
```

The [Transcriptome-Proteome analysis vignette](https://ccb-hms.github.io/BioPlexAnalysis/articles/TranscriptomeProteome.html) also explores the agreement between differential gene expression and
differential protein expression when comparing HEK293 against HCT116 cells.

# 8 SessionInfo

```
sessionInfo()
#> R version 4.1.2 (2021-11-01)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 20.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.14-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.14-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] graph_1.72.0                AnnotationHub_3.2.2
#>  [3] BiocFileCache_2.2.1         dbplyr_2.1.1
#>  [5] AnnotationDbi_1.56.2        BioPlex_1.0.2
#>  [7] SummarizedExperiment_1.24.0 Biobase_2.54.0
#>  [9] GenomicRanges_1.46.1        GenomeInfoDb_1.30.1
#> [11] IRanges_2.28.0              S4Vectors_0.32.3
#> [13] BiocGenerics_0.40.0         MatrixGenerics_1.6.0
#> [15] matrixStats_0.61.0          BiocStyle_2.22.0
#>
#> loaded via a namespace (and not attached):
#>  [1] bitops_1.0-7                  bit64_4.0.5
#>  [3] filelock_1.0.2                httr_1.4.2
#>  [5] tools_4.1.2                   bslib_0.3.1
#>  [7] utf8_1.2.2                    R6_2.5.1
#>  [9] DBI_1.1.2                     withr_2.5.0
#> [11] tidyselect_1.1.2              bit_4.0.4
#> [13] curl_4.3.2                    compiler_4.1.2
#> [15] cli_3.2.0                     xml2_1.3.3
#> [17] DelayedArray_0.20.0           bookdown_0.24
#> [19] sass_0.4.0                    readr_2.1.2
#> [21] rappdirs_0.3.3                stringr_1.4.0
#> [23] digest_0.6.29                 rmarkdown_2.12
#> [25] R.utils_2.11.0                GEOquery_2.62.2
#> [27] XVector_0.34.0                pkgconfig_2.0.3
#> [29] htmltools_0.5.2               highr_0.9
#> [31] fastmap_1.1.0                 limma_3.50.1
#> [33] rlang_1.0.2                   RSQLite_2.2.10
#> [35] shiny_1.7.1                   jquerylib_0.1.4
#> [37] generics_0.1.2                jsonlite_1.8.0
#> [39] dplyr_1.0.8                   R.oo_1.24.0
#> [41] RCurl_1.98-1.6                magrittr_2.0.2
#> [43] GenomeInfoDbData_1.2.7        Matrix_1.4-0
#> [45] Rcpp_1.0.8                    fansi_1.0.2
#> [47] lifecycle_1.0.1               R.methodsS3_1.8.1
#> [49] stringi_1.7.6                 yaml_2.3.5
#> [51] zlibbioc_1.40.0               grid_4.1.2
#> [53] blob_1.2.2                    promises_1.2.0.1
#> [55] ExperimentHub_2.2.1           crayon_1.5.0
#> [57] lattice_0.20-45               Biostrings_2.62.0
#> [59] hms_1.1.1                     KEGGREST_1.34.0
#> [61] knitr_1.37                    pillar_1.7.0
#> [63] glue_1.6.2                    BiocVersion_3.14.0
#> [65] evaluate_0.15                 data.table_1.14.2
#> [67] BiocManager_1.30.16           png_0.1-7
#> [69] vctrs_0.3.8                   tzdb_0.2.0
#> [71] httpuv_1.6.5                  purrr_0.3.4
#> [73] tidyr_1.2.0                   assertthat_0.2.1
#> [75] cachem_1.0.6                  xfun_0.30
#> [77] mime_0.12                     xtable_1.8-4
#> [79] later_1.3.0                   tibble_3.1.6
#> [81] memoise_2.0.1                 ellipsis_0.3.2
#> [83] interactiveDisplayBase_1.32.0
```