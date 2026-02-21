# Code example from 'chimeraviz-vignette' vignette. See references/ for full tutorial.

## ----message = FALSE----------------------------------------------------------
# Load chimeraviz
library(chimeraviz)

# Get reference to results file from deFuse
defuse833ke <- system.file(
"extdata",
"defuse_833ke_results.filtered.tsv",
package="chimeraviz")

# Load the results file into a list of fusion objects
fusions <- import_defuse(defuse833ke, "hg19")

## ----message = FALSE----------------------------------------------------------
length(fusions)

## ----message = FALSE----------------------------------------------------------
# Find a specific fusion event
fusion <- get_fusion_by_id(fusions, 5267)

# Show information about this fusion event
fusion

# Show information about the upstream fusion partner
upstream_partner_gene(fusion)

# Show information about the downstream fusion partner
downstream_partner_gene(fusion)

## ----echo = FALSE, message = FALSE, fig.height = 8, fig.width = 8, dev='png'----
# Load SOAPfuse data
soapfuse833ke <- system.file(
  "extdata",
  "soapfuse_833ke_final.Fusion.specific.for.genes",
  package = "chimeraviz")
fusions <- import_soapfuse(soapfuse833ke, "hg38", 10)
# Plot!
plot_circle(fusions)

## -----------------------------------------------------------------------------
# Load SOAPfuse data
if(!exists("soapfuse833ke"))
  soapfuse833ke <- system.file(
    "extdata",
    "soapfuse_833ke_final.Fusion.specific.for.genes",
    package = "chimeraviz")
fusions <- import_soapfuse(soapfuse833ke, "hg38", 10)

## ----message = FALSE, fig.height = 8, fig.width = 8, dev='png'----------------
plot_circle(fusions)

## ----echo = FALSE, message = FALSE, fig.height = 3, fig.width = 50, dev='png'----
# Load data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package="chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Find the specific fusion we have aligned reads for
fusion <- get_fusion_by_id(fusions, 5267)
if(!exists("bamfile5267"))
  bamfile5267 <- system.file(
    "extdata",
    "5267readsAligned.bam",
    package="chimeraviz")
# Add the bam file of aligned fusion reads to the fusion object
fusion <- add_fusion_reads_alignment(fusion, bamfile5267)
# Plot!
plot_fusion_reads(fusion)

## -----------------------------------------------------------------------------
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package = "chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose example fusion event
fusion <- get_fusion_by_id(fusions, 5267)

## -----------------------------------------------------------------------------
fastq1 <- system.file(
  "extdata",
  "reads_supporting_defuse_fusion_5267.1.fq",
  package = "chimeraviz")
fastq2 <- system.file(
  "extdata",
  "reads_supporting_defuse_fusion_5267.2.fq",
  package = "chimeraviz")

## -----------------------------------------------------------------------------
referenceFilename <- "reference.fa"
write_fusion_reference(fusion = fusion, filename = referenceFilename)

## ----eval=FALSE---------------------------------------------------------------
# # First load the bowtie functions
# source(system.file(
#   "scripts",
#   "bowtie.R",
#   package="chimeraviz"))
# # Then create index
# bowtie_index(
#   bowtie_build_location = "/path/to/bowtie-build",
#   reference_fasta = reference_filename)
# # And align
# bowtie_align(
#   bowtie_location = "/path/to/bowtie",
#   reference_name = reference_filename,
#   fastq1 = fastq1,
#   fastq2 = fastq2,
#   output_bam_filename = "fusion_alignment")

## ----eval=FALSE---------------------------------------------------------------
# # First load the rsubread functions
# source(system.file(
#   "scripts",
#   "rsubread.R",
#   package="chimeraviz"))
# # Then create index
# rsubread_index(reference_fasta = reference_filename)
# # And align
# rsubread_align(
#   reference_name = reference_filename,
#   fastq1 = fastq1,
#   fastq2 = fastq2,
#   output_bam_filename = "fusion_alignment")

## -----------------------------------------------------------------------------
if(!exists("bamfile5267"))
  bamfile5267 <- system.file(
    "extdata",
    "5267readsAligned.bam",
    package="chimeraviz")

## -----------------------------------------------------------------------------
# Add bamfile of fusion reads to the fusion oject
fusion <- add_fusion_reads_alignment(fusion, bamfile5267)

## ----message = FALSE, fig.height = 3, fig.width = 50, dev='png'---------------
plot_fusion_reads(fusion)

## ----echo = FALSE, message = FALSE, fig.height = 7, fig.width = 10, dev='png'----
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package = "chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Load edb
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# bamfile with reads in the regions of this fusion event
if(!exists("fusion5267and11759reads"))
  fusion5267and11759reads <- system.file(
   "extdata",
   "fusion5267and11759reads.bam",
   package = "chimeraviz")
# Plot!
plot_fusion(
 fusion = fusion,
 bamfile = fusion5267and11759reads,
 edb = edb,
 non_ucsc = TRUE)

## ----echo = FALSE, message = FALSE, fig.height = 5, fig.width = 10, dev='png'----
# Plot!
plot_fusion(
 fusion = fusion,
 bamfile = fusion5267and11759reads,
 edb = edb,
 non_ucsc = TRUE,
 reduce_transcripts = TRUE)

## -----------------------------------------------------------------------------
# First find the example data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package = "chimeraviz")
# Then load the fusion events
fusions <- import_defuse(defuse833ke, "hg19", 1)

## -----------------------------------------------------------------------------
# See if we can find any fusions involving RCC1
get_fusion_by_gene_name(fusions, "RCC1")

## -----------------------------------------------------------------------------
# Extract the specific fusion
fusion <- get_fusion_by_id(fusions, 5267)

## -----------------------------------------------------------------------------
# First find our example EnsDb file
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
# Then load it
edb <- ensembldb::EnsDb(edbSqliteFile)

## ----eval = FALSE-------------------------------------------------------------
# # Create EnsDb from a downloaded .gtf file
# edbSqliteFile <- ensDbFromGtf(gtf = "Homo_sapiens.GRCh37.74.gtf")
# # The function above create a .sqlite file, like the one that is included with
# # chimeraviz. The path to the file is stored in the edbSqliteFile variable. To
# # load the database, do this:
# edb <- ensembldb::EnsDb(edbSqliteFile)

## ----eval = FALSE-------------------------------------------------------------
# # Create an edb object directly from the .sqlite file
# edb <- ensembldb::EnsDb("Homo_sapiens.GRCh37.74.sqlite")

## -----------------------------------------------------------------------------
if(!exists("fusion5267and11759reads"))
  fusion5267and11759reads <- system.file(
    "extdata",
    "fusion5267and11759reads.bam",
    package = "chimeraviz")

## ----message = FALSE, fig.height = 7, fig.width = 10, dev='png'---------------
plot_fusion(
 fusion = fusion,
 bamfile = fusion5267and11759reads,
 edb = edb,
 non_ucsc = TRUE)

## ----message = FALSE, fig.height = 5, fig.width = 10, dev='png'---------------
plot_fusion(
 fusion = fusion,
 bamfile = fusion5267and11759reads,
 edb = edb,
 non_ucsc = TRUE,
 reduce_transcripts = TRUE)

## ----message = FALSE, fig.height = 5, fig.width = 10, dev='png'---------------
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package = "chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Load edb
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# Plot!
plot_transcripts(
  fusion = fusion,
  edb = edb)

## ----message = FALSE, fig.height = 5, fig.width = 10, dev='png'---------------
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Load edb
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# Get reference to the .BAM file
if(!exists("fusion5267and11759reads"))
  fusion5267and11759reads <- system.file(
    "extdata",
    "fusion5267and11759reads.bam",
    package="chimeraviz")
# Plot!
plot_transcripts(
  fusion = fusion,
  edb = edb,
  bamfile = fusion5267and11759reads,
  non_ucsc = TRUE)

## ----message = FALSE, fig.height = 5, fig.width = 10, dev='png'---------------
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
  "extdata",
  "defuse_833ke_results.filtered.tsv",
  package="chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Load edb
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# Get reference to the .BAM file
if(!exists("fusion5267and11759reads"))
  fusion5267and11759reads <- system.file(
    "extdata",
    "fusion5267and11759reads.bam",
    package="chimeraviz")
# Plot!
plot_transcripts(
  fusion = fusion,
  edb = edb,
  bamfile = fusion5267and11759reads,
  non_ucsc = TRUE,
  reduce_transcripts = TRUE,
  ylim = c(0,1000))

## ----message = FALSE, fig.height = 2, fig.width = 10, dev='png'---------------
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package="chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Load edb
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# Plot!
plot_fusion_transcript(
  fusion,
  edb)

## ----message = FALSE, fig.height = 4, fig.width = 10, dev='png'---------------
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package="chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Load edb
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# Get reference to the .BAM file
if(!exists("fusion5267and11759reads"))
  fusion5267and11759reads <- system.file(
    "extdata",
    "fusion5267and11759reads.bam",
    package="chimeraviz")
# Plot!
plot_fusion_transcript(
  fusion,
  edb,
  fusion5267and11759reads)

## ----message = FALSE, fig.height = 2, fig.width = 10, dev='png'---------------
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package="chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Select transcripts
gene_upstream_transcript <- "ENST00000434290"
gene_downstream_transcript <- "ENST00000370031"
# Load edb
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# bamfile with reads in the regions of this fusion event
if(!exists("fusion5267and11759reads"))
  fusion5267and11759reads <- system.file(
    "extdata",
    "fusion5267and11759reads.bam",
    package="chimeraviz")
# bedfile with protein domains for the transcripts in this example
if(!exists("bedfile"))
  bedfile <- system.file(
    "extdata",
    "protein_domains_5267.bed",
    package="chimeraviz")
# Plot!
plot_fusion_transcript_with_protein_domain(
      fusion = fusion,
      edb = edb,
      bamfile = fusion5267and11759reads,
      bedfile = bedfile,
      gene_upstream_transcript = gene_upstream_transcript,
      gene_downstream_transcript = gene_downstream_transcript,
      plot_downstream_protein_domains_if_fusion_is_out_of_frame = TRUE)

## ----echo = FALSE, message = FALSE, results = 'asis'--------------------------
bedfile <- system.file(
  "extdata",
  "protein_domains_5267.bed",
  package="chimeraviz")
bedfile_contents <- data.table::fread(
  input = bedfile,
  showProgress = FALSE
)
knitr::kable(bedfile_contents)

## ----message = FALSE, fig.height = 5, fig.width = 10, dev='png'---------------
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package="chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Plot!
plot_fusion_transcripts_graph(
  fusion,
  edb)

## ----message = FALSE----------------------------------------------------------
# Get reference to results file from deFuse
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package="chimeraviz")

# Load the results file into a list of fusion objects
fusions <- import_defuse(defuse833ke, "hg19")

## ----message = FALSE----------------------------------------------------------
# Get a specific fusion object by id
get_fusion_by_id(fusions, 5267)

# Get all fusions with a matching gene name
length(get_fusion_by_gene_name(fusions, "RCC1"))

# Get all fusions on a specific chromosome
length(get_fusion_by_chromosome(fusions, "chr1"))

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# # Load SOAPfuse data
# if(!exists("soapfuse833ke"))
#   soapfuse833ke <- system.file(
#     "extdata",
#     "soapfuse_833ke_final.Fusion.specific.for.genes",
#     package = "chimeraviz")
# fusions <- import_soapfuse(soapfuse833ke, "hg38", 10)
# # Create report!
# create_fusion_report(fusions, "output.html")

## ----echo = FALSE, message = FALSE, fig.height = 7, fig.width = 7, fig.align='center', dev='png'----
# Load SOAPfuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package="chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19")
# Plot!
plot_circle(fusions)

## ----echo = FALSE-------------------------------------------------------------
# with the as.data.frame.Fusion function above, we can use ldply() from the plyr package to create a data frame of our fusion objects:
dfFusions <- plyr::ldply(fusions, fusion_to_data_frame)

# with this data frame, we can use datatable() from the DT package to create an html sortable table:
DT::datatable(dfFusions, filter = 'top')

## -----------------------------------------------------------------------------
sessionInfo()

