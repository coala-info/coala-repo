# Code example from 'EuPathDB' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis', message=FALSE--------------------
BiocStyle::markdown()

## ----eval = FALSE--------------------------------------------------------
#  install.packages("BiocManager")
#  BiocManager::install("AnnotationHub")

## ------------------------------------------------------------------------
library('AnnotationHub')

# create an AnnotationHub connection
ah <- AnnotationHub()

# search for all EuPathDB resources
meta <- query(ah, "EuPathDB")

length(meta)
head(meta)

# types of EuPathDB data available
table(meta$rdataclass)

# distribution of resources by specific databases
table(meta$dataprovider)

# list of organisms for which resources are available
length(unique(meta$species))
head(unique(meta$species))

## ------------------------------------------------------------------------
res <- query(ah, c('Leishmania major strain Friedlin', 'OrgDb', 'EuPathDB'))
res

## ------------------------------------------------------------------------
orgdb <- res[['AH65089']]
class(orgdb)

## ------------------------------------------------------------------------
# list available fields to retrieve
columns(orgdb)

# create a vector containing all gene ids for the organism
gids <- keys(orgdb, keytype='GID')
head(gids)

# retrieve the chromosome, description, and biotype for each gene
dat <- select(orgdb, keys=gids, keytype='GID', columns=c('CHR', 'TYPE', 'GENEDESCRIPTION'))

head(dat)

table(dat$TYPE)
table(dat$CHR)

# create a gene / GO term mapping 
gene_go_mapping <- select(orgdb, keys=gids, keytype='GID', columns=c('GO_ID', 'GO_TERM_NAME', 'ONTOLOGY'))
head(gene_go_mapping)

# retrieve KEGG, etc. pathway annotations
gene_pathway_mapping <- select(orgdb, keys=gids, keytype='GID', columns=c('PATHWAY', 'PATHWAY_SOURCE'))
table(gene_pathway_mapping$PATHWAY_SOURCE)
head(gene_pathway_mapping)

## ------------------------------------------------------------------------
# query AnnotationHub
res <- query(ah, c('Leishmania major strain Friedlin', 'GRanges', 'EuPathDB'))
res

# retrieve a GRanges instance associated with the result record
gr <- res[['AH65354']]
gr

## ------------------------------------------------------------------------
# chromosome names
seqnames(gr)

# strand information
strand(gr)

# feature widths
width(gr)

## ------------------------------------------------------------------------
# list of location types in the resource
table(gr$type)

## ------------------------------------------------------------------------
# get the first three ranges
gr[1:3]

# get all gene entries on chromosome 4
gr[gr$type == 'gene' & seqnames(gr) == 'LmjF.04']

## ------------------------------------------------------------------------
sessionInfo()

