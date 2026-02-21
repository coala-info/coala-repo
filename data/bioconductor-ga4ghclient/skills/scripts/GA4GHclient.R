# Code example from 'GA4GHclient' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(data.frame(
    Method = c(
        "searchDatasets",
        "searchReferenceSets",
        "searchReferences",
        "listReferenceBases",
        "searchVariantSets",
        "searchVariants",
        "searchCallSets",
        "searchVariantAnnotationSets",
        "searchVariantAnnotations",
        "searchFeatureSets",
        "searchFeatures",
        "searchReadGroupSets",
        "searchReads",
        "searchBiosamples",
        "searchIndividuals",
        "searchRnaQuantificationSets",
        "searchRnaQuantifications",
        "searchExpressionLevels",
        "searchPhenotypeAssociationSets",
        "searchPhenotypeAssociations",
        "getDataset",
        "getReferenceSet",
        "getReference",
        "getVariantSet",
        "getVariant",
        "getCallSet",
        "getVariantAnnotationSet",
        "getVariantAnnotation",
        "getFeatureSet",
        "getFeature",
        "getReadGroupSet",
        "getBiosample",
        "getIndividual",
        "getRnaQuantificationSet",
        "getRnaQuantification",
        "getExpressionLevel"
    ),
    Description = c(
        "Search for datasets",
        "Search for reference sets (reference genomes)",
        "Search for references (genome sequences, e.g. chromosomes)",
        "Get the sequence bases of a reference genome by genomic range",
        "Search for for variant sets (VCF files)",
        "Search for variants by genomic ranges (lines of VCF files)",
        "Search for call sets (sample columns of VCF files)",
        "Search for variant annotation sets (annotated VCF files)",
        "Search for annotated variants by genomic range",
        "Search for feature sets (genomic features, e.g. GFF files)",
        "Search for features (lines of genomic feature files)",
        "Search for read group sets (sequence alignement, e.g BAM files)",
        "Search for reads by genomic range (bases of aligned sequences)",
        "Search for biosamples",
        "Search for individuals",
        "Search for RNA quantification sets",
        "Search for RNA quantifications",
        "Search for expression levels",
        "Search for phenotype association sets",
        "Search for phenotype associations",
        "Get a dataset by its ID",
        "Get a reference set by its ID",
        "Get a reference by its ID",
        "Get a variant set by its ID",
        "Get a variant by its ID with all call sets for this variant",
        "Get a call set by its ID",
        "Get a variant annotation set by its ID",
        "Get an annotated variant by its ID",
        "Get a feature set by its ID",
        "Get a feature by its ID",
        "Get a read group set by its ID",
        "Get a biosample by its ID",
        "Get an individual by its ID",
        "Get an RNA quantification set by its ID",
        "Get an RNA quantification by its ID",
        "Get an expression level by its ID"
    ), stringsAsFactors = FALSE
))

## ----message=FALSE------------------------------------------------------------
library(GA4GHclient)
library(org.Hs.eg.db)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(VariantAnnotation)
library(GenomeInfoDb)  # for seqlevelsStyle()

## ----host---------------------------------------------------------------------
host <- "http://1kgenomes.ga4gh.org/"

## ----load-data, include=FALSE-------------------------------------------------
# To avoid internet connection issues, some code of this vignette were 
# previously executed and result data stored within the package.
load(system.file(package = "GA4GHclient", "extdata/vignette.rda"))

## ----search-variants, eval=FALSE----------------------------------------------
# datasets <- searchDatasets(host, nrows = 1)
# datasetId <- datasets$id
# variantSets <- searchVariantSets(host, datasetId, nrows = 1)
# variantSetId <- variantSets$id
# variants <- searchVariants(host, variantSetId, referenceName = "1",
#     start = 15000, end = 16000, nrows = 10)

## ----print-variants-vcf-------------------------------------------------------
variants

## ----search-variants-df, eval=FALSE-------------------------------------------
# variants.df <- searchVariants(host, variantSetId, referenceName = "1",
#     start = 15000, end = 16000, nrows = 10, asVCF = FALSE)

## -----------------------------------------------------------------------------
DT::datatable(as.data.frame(variants.df), options = list(scrollX = TRUE))

## ----search-referencesets, eval=FALSE-----------------------------------------
# referenceSets <- searchReferenceSets(host, nrows = 1)
# referenceSets$name

## -----------------------------------------------------------------------------
head(keys(org.Hs.eg.db, keytype = "SYMBOL"))

## -----------------------------------------------------------------------------
head(genes(TxDb.Hsapiens.UCSC.hg19.knownGene))

## -----------------------------------------------------------------------------
df <- select(org.Hs.eg.db, keys = "SCN1A", columns = c("SYMBOL", "ENTREZID"), keytype = "SYMBOL")
gr <- genes(TxDb.Hsapiens.UCSC.hg19.knownGene, filter=list(gene_id=df$ENTREZID))
seqlevelsStyle(gr) <- "NCBI"

## ----search-variants-by-gene, eval=FALSE--------------------------------------
# variants.scn1a <- searchVariantsByGRanges(host, variantSetId, gr, asVCF = FALSE)

## -----------------------------------------------------------------------------
DT::datatable(as.data.frame(variants.scn1a[[1]]), options = list(scrollX = TRUE))

## -----------------------------------------------------------------------------
variants.scn1a.gr <- makeGRangesFromDataFrame(variants.scn1a[[1]],
    seqnames.field = "referenceName")
seqlevelsStyle(variants.scn1a.gr) <- "UCSC"
locateVariants(variants.scn1a.gr, TxDb.Hsapiens.UCSC.hg19.knownGene,
    CodingVariants())

## ----search-callsets, eval=FALSE----------------------------------------------
# callSetIds <- searchCallSets(host, variantSetId, nrows = 5)$id
# vcf <- searchVariants(host, variantSetId, referenceName = "1",
#     start = 15000, end = 16000, callSetIds = callSetIds, nrows = 10)

## ----print-vcf-vcfheader------------------------------------------------------
vcf
header(vcf)

## ----print-gt-----------------------------------------------------------------
geno(vcf)$GT

## ----eval=FALSE, echo=FALSE---------------------------------------------------
# # The code below saves objects obtained from data server in package.
# # It is only necessary during development.
# save(referenceSets, variantSetId, variants, variants.df, variants.scn1a,
#     vcf, file = "inst/extdata/vignette.rda")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

