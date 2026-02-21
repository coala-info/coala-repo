# Code example from 'snapcount_vignette' vignette. See references/ for full tutorial.

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
library(snapcount)
## Track time spent on making the vignette
startTime <- Sys.time()

## ----'install', eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("snapcount")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----'gene', eval = TRUE------------------------------------------------------

##Query coverage for gene, exon, and annotated junctions across all
#in the region of the CD99 gene
#from GTEx v6 sample compilation
#CD99 is chosen for its size
sb <- QueryBuilder(compilation="gtex", regions="CD99")
cd99.gene <- query_gene(sb)
dim(cd99.gene)
head(cd99.gene)

## ----'jx', eval = TRUE--------------------------------------------------------

##Query all exon-exon splice junctions within the region of gene CD99
cd99.jx.all <- query_jx(sb)
dim(cd99.jx.all)
cd99.jx.all

## ----'jx2', eval = TRUE-------------------------------------------------------

#now subfilter by sample tissue
#GTEx samples that are labeled with tissue type "Brain"
sb <- set_column_filters(sb, SMTS == "Brain")
cd99.jx.all <- query_jx(sb)
dim(cd99.jx.all)
head(cd99.jx.all)

## ----'exon', eval = TRUE------------------------------------------------------

cd99.exon <- query_exon(sb)
dim(cd99.exon)
head(cd99.exon)

## ----'jx3', eval = TRUE-------------------------------------------------------

###Only query junctions which are fully annotated---both left and
#right splice sites are found together in one or more of the
#Snaptron sourced annotations
sb <- set_row_filters(sb, annotated == 1)
cd99.jx <- query_jx(sb)
dim(cd99.jx)
head(cd99.jx)

## ----'md', eval = TRUE--------------------------------------------------------

##Metadata is stored directly in the RSE object.
#For example the library insert size can be retrieved
#across all runs  in the RSE
head(cd99.jx.all$InsertSize)

## ----'psi', eval = TRUE-------------------------------------------------------
#Build new query against GTEx
#left inclusion query
lq <- QueryBuilder(compilation="gtex", regions="chr19:45297955-45298142")
lq <- set_row_filters(lq, strand == "+")
lq <- set_coordinate_modifier(lq, Coordinates$Exact)
#right inclusion query
rq <- QueryBuilder(compilation="gtex", regions="chr19:45298223-45299810")
rq <- set_row_filters(rq, strand == "+")
rq <- set_coordinate_modifier(rq, Coordinates$Exact)
#exclusion query
ex <- QueryBuilder(compilation="gtex", regions="chr19:45297955-45299810")
ex <- set_row_filters(ex, strand == "+")
ex <- set_coordinate_modifier(ex, Coordinates$Exact)

psi <- percent_spliced_in(list(lq), list(rq), list(ex))
#order by psi descending
psi <- psi[order(-psi),]
head(psi)

## ----'jir', eval = TRUE-------------------------------------------------------
#groupA
A <- QueryBuilder(compilation="srav2", regions="chr2:29446395-30142858")
A <- set_row_filters(A, strand == "-")
A <- set_coordinate_modifier(A, Coordinates$Within)

#groupB
B <- QueryBuilder(compilation="srav2", regions="chr2:29416789-29446394")
B <- set_row_filters(B, strand == "-")
B <- set_coordinate_modifier(B, Coordinates$Within)

jir <- junction_inclusion_ratio(list(A),
                              list(B),
                              group_names=c("groupA","groupB"))
head(jir)

## ----'ssc', eval = TRUE-------------------------------------------------------
## We define the left/right splice junction supports of 3
#cassette exons for the following 3 genes:

## "left"/"right" is relative to the forward strand,
#reference genome coordinates,
#we use this terminology instead of 5' or 3'
#since the gene may be on the reverse strand.

###GNB1
GNB1l <- QueryBuilder(compilation="gtex", regions="chr1:1879786-1879786")
GNB1l <- set_row_filters(GNB1l, strand == "-")
GNB1l <- set_coordinate_modifier(GNB1l, Coordinates$EndIsExactOrWithin)

GNB1r <- QueryBuilder(compilation="gtex", regions="chr1:1879903-1879903")
GNB1r <- set_row_filters(GNB1r, strand == "-")
GNB1r <- set_coordinate_modifier(GNB1r, Coordinates$StartIsExactOrWithin)

###PIK3CD
PIK3l <- QueryBuilder(compilation="gtex", regions="chr1:9664595-9664595")
PIK3l <- set_row_filters(PIK3l, strand == "+")
PIK3l <- set_coordinate_modifier(PIK3l, Coordinates$EndIsExactOrWithin)

PIK3r <- QueryBuilder(compilation="gtex", regions="chr1:9664759-9664759")
PIK3r <- set_row_filters(PIK3r, strand == "+")
PIK3r <- set_coordinate_modifier(PIK3r, Coordinates$StartIsExactOrWithin)

###TAP2
T2l <- QueryBuilder(compilation="gtex", regions="chr6:32831148-32831148")
T2l <- set_row_filters(T2l, strand == "-")
T2l <- set_coordinate_modifier(T2l, Coordinates$EndIsExactOrWithin)

T2r <- QueryBuilder(compilation="gtex", regions="chr6:32831182-32831182")
T2r <- set_row_filters(T2r, strand == "-")
T2r <- set_coordinate_modifier(T2r, Coordinates$StartIsExactOrWithin)

ssc_func <- shared_sample_counts
ssc <- ssc_func(list(GNB1l, GNB1r),
              list(PIK3l, PIK3r),
              list(T2l, T2r),
              group_names=c("validated","not validated","validated"))
ssc


## ----'ts1', eval = TRUE-------------------------------------------------------
A <- QueryBuilder(compilation="gtex", regions="chr4:20763023-20763023")
A <- set_row_filters(A, strand == "-")
A <- set_coordinate_modifier(A, Coordinates$EndIsExactOrWithin)

ts <- tissue_specificity(list(A))
head(ts)

## ----'ts2', eval = TRUE-------------------------------------------------------
A <- QueryBuilder(compilation="gtex", regions="chr4:20763023-20763023")
A <- set_row_filters(A, strand == "-")
A <- set_coordinate_modifier(A, Coordinates$EndIsExactOrWithin)

B <- QueryBuilder(compilation="gtex", regions="chr4:20763098-20763098")
B <- set_row_filters(B, strand == "-")
B <- set_coordinate_modifier(B, Coordinates$StartIsExactOrWithin)

ts <- tissue_specificity(list(A, B))
head(ts)

## ----'jm', eval = TRUE--------------------------------------------------------
gtex <- QueryBuilder(compilation="gtex", regions="chr1:1879786-1879786")
gtex <- set_row_filters(gtex, strand == "-")
gtex <- set_coordinate_modifier(gtex, Coordinates$EndIsExactOrWithin)

tcga <- QueryBuilder(compilation="tcga", regions="chr1:1879786-1879786")
tcga <- set_row_filters(tcga, strand == "-")
tcga <- set_coordinate_modifier(tcga, Coordinates$EndIsExactOrWithin)

gtex_tcga_union <- junction_union(gtex,tcga)
dim(gtex_tcga_union)
head(gtex_tcga_union)

## ----'ji', eval = TRUE--------------------------------------------------------
gtex <- QueryBuilder(compilation="gtex", regions="chr1:1879786-1879786")
gtex <- set_row_filters(gtex, strand == "-")
gtex <- set_coordinate_modifier(gtex, Coordinates$EndIsExactOrWithin)

tcga <- QueryBuilder(compilation="tcga", regions="chr1:1879786-1879786")
tcga <- set_row_filters(tcga, strand == "-")
tcga <- set_coordinate_modifier(tcga, Coordinates$EndIsExactOrWithin)

gtex_tcga_intersection <- junction_intersection(gtex,tcga)
dim(gtex_tcga_intersection)
head(gtex_tcga_intersection)

