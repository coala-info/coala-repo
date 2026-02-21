# Code example from 'regutools' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## For links
library("BiocStyle")

## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    AnnotationDbi = citation("AnnotationDbi"),
    AnnotationHub = citation("AnnotationHub"),
    BiocFileCache = citation("BiocFileCache"),
    BiocStyle = citation("BiocStyle"),
    Biostrings = citation("Biostrings"),
    DBI = citation("DBI"),
    GenomicRanges = citation("GenomicRanges"),
    Gviz = citation("Gviz"),
    IRanges = citation("IRanges"),
    knitr = citation("knitr")[3],
    RCy3 = citation("RCy3"),
    RefManageR = citation("RefManageR")[1],
    regutools = citation("regutools")[1],
    regutoolsPaper = citation("regutools")[2],
    rmarkdown = citation("rmarkdown")[1],
    RSQLite = citation("RSQLite"),
    S4Vectors = citation("S4Vectors"),
    sessioninfo = citation("sessioninfo"),
    testthat = citation("testthat")
)

## ----'install', eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#       install.packages("BiocManager")
#   }
# 
# BiocManager::install("regutools")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----'citation'---------------------------------------------------------------
## Citation info
citation("regutools")

## ----'connect_db', echo = TRUE, message=FALSE---------------------------------
library("regutools")

## Other packages used
library("Biostrings")

## Connect to the RegulonDB database
regulondb_conn <- connect_database()

## Build a regulondb object
e_coli_regulondb <-
    regulondb(
        database_conn = regulondb_conn,
        organism = "E.coli",
        database_version = "1",
        genome_version = "1"
    )

e_coli_regulondb

## ----'list_datasets', echo = TRUE---------------------------------------------
list_datasets(e_coli_regulondb)

## ----'list_attr'--------------------------------------------------------------
head(list_attributes(e_coli_regulondb, "GENE"), 8)

## ----'get_dataset', echo = TRUE-----------------------------------------------
get_dataset(
    regulondb = e_coli_regulondb,
    dataset = "GENE",
    attributes = c("posleft", "posright", "strand", "name"),
    filters = list("name" = c("araC", "crp", "lacI"))
)

## ----'get_dataset_interval', echo = TRUE--------------------------------------
get_dataset(
    e_coli_regulondb,
    attributes = c("posright", "name"),
    filters = list("posright" = c(1, 5000)),
    interval = "posright",
    dataset = "GENE"
)

## ----'get_dataset_DF'---------------------------------------------------------
res <- get_dataset(
    regulondb = e_coli_regulondb,
    dataset = "GENE",
    attributes = c("posleft", "posright", "strand", "name"),
    filters = list("name" = c("araC", "crp", "lacI"))
)
slotNames(res)

## ----'convert_granges'--------------------------------------------------------
convert_to_granges(res)

## ----'get_dataset_GRanges'----------------------------------------------------
get_dataset(
    regulondb = e_coli_regulondb,
    dataset = "GENE",
    attributes = c("posleft", "posright", "strand", "name"),
    filters = list("name" = c("araC", "crp", "lacI")),
    output_format = "GRanges"
)

## ----'dnastring_res'----------------------------------------------------------
res_dnastring <- get_dataset(
    regulondb = e_coli_regulondb,
    dataset = "GENE",
    attributes = c("posleft", "posright", "strand", "name", "dna_sequence"),
    filters = list("name" = c("araC", "crp", "lacI"))
)
res_dnastring <-
    convert_to_biostrings(res_dnastring, seq_type = "DNA")
res_dnastring
GenomicRanges::mcols(res_dnastring)

## ----'product_seq'------------------------------------------------------------
res_prodstring <- get_dataset(
    regulondb = e_coli_regulondb,
    dataset = "GENE",
    attributes = c("posleft", "posright", "strand", "name", "product_sequence"),
    filters = list("name" = c("araC", "crp", "lacI"))
)
res_prodstring <-
    convert_to_biostrings(res_prodstring, seq_type = "product")
mcols(res_prodstring)

## ----'partial_match', echo = TRUE---------------------------------------------
get_dataset(
    e_coli_regulondb,
    attributes = c("posright", "name"),
    filters = list("name" = "ara"),
    partialmatch = "name",
    dataset = "GENE"
)

## ----'position_interval', echo = TRUE-----------------------------------------
get_dataset(
    e_coli_regulondb,
    attributes = c("name", "strand", "posright", "product_name"),
    dataset = "GENE",
    filters = list(posright = c("2000", "4000000")),
    interval = "posright"
)

## ----'genomic_elements', echo = TRUE------------------------------------------
get_dna_objects(e_coli_regulondb)

## ----'especific_ranges', echo = TRUE------------------------------------------
grange <- GenomicRanges::GRanges(
    "chr",
    IRanges::IRanges(5000, 10000)
)
get_dna_objects(e_coli_regulondb, grange)

## ----'aditional_elements', echo = TRUE----------------------------------------
grange <- GenomicRanges::GRanges(
    "chr",
    IRanges::IRanges(5000, 10000)
)
get_dna_objects(e_coli_regulondb, grange, elements = c("gene", "promoter"))

## ----'plot_elements', echo = TRUE---------------------------------------------
e_coli_regulondb <-
    regulondb(
        database_conn = regulondb_conn,
        organism = "chr",
        database_version = "1",
        genome_version = "1"
    )

grange <- GenomicRanges::GRanges("chr", IRanges::IRanges(5000, 10000))
plot_dna_objects(e_coli_regulondb, grange, elements = c("gene", "promoter"))

## ----'complex_filter'---------------------------------------------------------
nrow(
    get_dataset(
        e_coli_regulondb,
        attributes = c("name", "strand", "posright", "product_name"),
        dataset = "GENE",
        filters = list(
            name = c("ARA"),
            product_name = c("Ara"),
            strand = c("forward"),
            posright = c("2000", "4000000")
        ),
        and = FALSE,
        partialmatch = c("name", "product_name"),
        interval = "posright"
    )
)

## ----'complex_filter_2'-------------------------------------------------------
nrow(
    get_dataset(
        e_coli_regulondb,
        attributes = c("name", "strand", "posright", "product_name"),
        dataset = "GENE",
        filters = list(
            name = c("ARA"),
            product_name = c("Ara"),
            strand = c("forward"),
            posright = c("2000", "4000000")
        ),
        and = TRUE,
        partialmatch = c("name", "product_name"),
        interval = "posright"
    )
)

## ----'gene_regulators', echo = TRUE-------------------------------------------
get_gene_regulators(e_coli_regulondb, c("araC", "fis", "crp"))

## ----'regulatory_network', echo = TRUE----------------------------------------
head(get_regulatory_network(e_coli_regulondb))

## ----'regulatory_summary'-----------------------------------------------------
get_regulatory_summary(e_coli_regulondb,
    gene_regulators = c("araC", "modB")
)

## ----'prep_cyto', eval=FALSE--------------------------------------------------
# get_regulatory_network(e_coli_regulondb, cytograph = TRUE)

## ----'binding_sites'----------------------------------------------------------
get_binding_sites(e_coli_regulondb, transcription_factor = "AraC")
get_binding_sites(e_coli_regulondb,
    transcription_factor = "AraC",
    output_format = "Biostrings"
)

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("regutools.Rmd"))
# 
# ## Extract the R code
# library("knitr")
# knit("regutools.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE---------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE---------------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results = 'asis', echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

