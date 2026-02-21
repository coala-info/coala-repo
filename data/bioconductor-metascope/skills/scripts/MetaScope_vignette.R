# Code example from 'MetaScope_vignette' vignette. See references/ for full tutorial.

## ----show_install, eval = FALSE-----------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("MetaScope")

## ----load_packages, eval = TRUE-----------------------------------------------
suppressPackageStartupMessages({
  library(MetaScope)
  library(magrittr)
})

## ----meta_demultiplex, message = FALSE----------------------------------------
# Get barcode, index, and read data locations
barcodePath <-
  system.file("extdata", "barcodes.txt", package = "MetaScope")
indexPath <- system.file("extdata", "virus_example_index.fastq",
                         package = "MetaScope")
readPath <-
  system.file("extdata", "virus_example.fastq", package = "MetaScope")

# Get barcode, index, and read data locations
demult <-
  meta_demultiplex(barcodePath,
                   indexPath,
                   readPath,
                   rcBarcodes = FALSE,
                   hammingDist = 2,
                   location = tempfile())
demult

## ----eval = FALSE-------------------------------------------------------------
# download_accessions(
#   ind_dir = "C:/Users/JohnSmith/ResearchIndices",
#   tmp_dir = file_path(ind_dir, "tmp"),
#   remove_tmp_dir = TRUE,
#   # For NCBI RefSeq or nucleotide database
#   NCBI_accessions_database = TRUE,
#   NCBI_accessions_name = "accessionTaxa.sql",
#   # For SILVA 16S database
#   silva_taxonomy_database = TRUE,
#   silva_taxonomy_name = "all_silva_headers.rds"
# )

## ----taxonomy_db, eval = TRUE, warning = FALSE, message = FALSE---------------
tmp_accession <- system.file("extdata","example_accessions.sql", package = "MetaScope")

## ----target_lib, eval = TRUE, warning = FALSE, message = FALSE----------------
target_ref_temp <- tempfile()
dir.create(target_ref_temp)

all_species <- c("Staphylococcus aureus subsp. aureus Mu50",
                 "Staphylococcus aureus subsp. aureus Mu3",
                 "Staphylococcus aureus subsp. aureus str. Newman",
                 "Staphylococcus aureus subsp. aureus N315",
                 "Staphylococcus aureus RF122", 
                 "Staphylococcus aureus subsp. aureus ST398")
sapply(all_species, download_refseq, 
       reference = FALSE, representative = FALSE, compress = TRUE,
       out_dir = target_ref_temp, caching = TRUE, accession_path = tmp_accession)

## ----filter_lib, warning = FALSE, message = FALSE-----------------------------
filter_ref_temp <- tempfile()
dir.create(filter_ref_temp)

download_refseq(
  taxon = "Staphylococcus epidermidis RP62A",
  representative = FALSE, reference = FALSE,
  compress = TRUE, out_dir = filter_ref_temp,
  caching = TRUE,
  accession_path = tmp_accession)

## ----make_indexes, eval = TRUE------------------------------------------------
# Create temp directory to store the Bowtie2 indices
index_temp <- tempfile()
dir.create(index_temp)

# Create target index
mk_bowtie_index(
  ref_dir = target_ref_temp,
  lib_dir = index_temp,
  lib_name = "target",
  overwrite = TRUE
)

# Create filter index
mk_bowtie_index(
  ref_dir = filter_ref_temp,
  lib_dir = index_temp,
  lib_name = "filter",
  overwrite = TRUE
)

## ----alignment_align----------------------------------------------------------
# Create a temp directory to store output bam file
output_temp <- tempfile()
dir.create(output_temp)

# Get path to example reads
readPath <-
  system.file("extdata", "reads.fastq", package = "MetaScope")

# Align reads to the target genomes
target_map <-
  align_target_bowtie(
    read1 = readPath,
    lib_dir = index_temp,
    libs = "target",
    align_dir = output_temp,
    align_file = "bowtie_target",
    overwrite = TRUE
  )

## ----alignment_filter---------------------------------------------------------
final_map <-
  filter_host_bowtie(
    reads_bam = target_map,
    lib_dir = index_temp,
    libs = "filter",
    make_bam = TRUE, # Set to true to create BAM output
    # Default is to create simplified .csv.gz output
    # The .csv.gz output is much quicker to create!
    overwrite = TRUE,
    threads = 1
  )

## ----bam_primary_alignment----------------------------------------------------
bamFile <- Rsamtools::BamFile(final_map)

param <-
  Rsamtools::ScanBamParam(
    flag = Rsamtools::scanBamFlag(isSecondaryAlignment = FALSE),
    what = c("flag", "rname")
  ) #Gets info about primary alignments

aln <- Rsamtools::scanBam(bamFile, param = param)
accession_all <- aln[[1]]$rname
genome_name_all <- accession_all |> 
  taxonomizr::accessionToTaxa(tmp_accession) |>
  taxonomizr::getTaxonomy(sqlFile = tmp_accession, desiredTaxa = "strain")
read_count_table <- sort(table(genome_name_all), decreasing = TRUE)
knitr::kable(
  read_count_table,
  col.names = c("Genome Assigned", "Read Count"))

## ----bam_secondary_alignment--------------------------------------------------
bamFile <- Rsamtools::BamFile(final_map)

param <-
  Rsamtools::ScanBamParam(
    flag = Rsamtools::scanBamFlag(isSecondaryAlignment = TRUE),
    what = c("flag", "rname")
  ) #Gets info about secondary alignments

aln <- Rsamtools::scanBam(bamFile, param = param)
accession_all <- aln[[1]]$rname
genome_name_all <- accession_all |> 
  taxonomizr::accessionToTaxa(tmp_accession) |>
  taxonomizr::getTaxonomy(sqlFile = tmp_accession, desiredTaxa = "strain")
read_count_table <- sort(table(genome_name_all), decreasing = TRUE)
knitr::kable(
  read_count_table,
  col.names = c("Genome Assigned", "Read Count"))

## ----identification, message = FALSE------------------------------------------
output <- metascope_id(
  final_map,
  input_type = "bam",
  # change input_type to "csv.gz" when not creating a BAM
  aligner = "bowtie2",
  num_species_plot = 0,
  accession_path = tmp_accession
)

knitr::kable(output,
             format = "html",
             digits = 2,
             caption = "Table of MetaScope ID results")

## ----CSV_summary--------------------------------------------------------------
relevant_col <- dirname(final_map) %>%
  file.path("bowtie_target.metascope_id.csv") %>%
  read.csv() %>% dplyr::select(2:4)

relevant_col |>
  dplyr::mutate(
    Genome = stringr::str_replace_all(Genome, ',.*', ''),
    Genome = stringr::str_replace_all(Genome, "(ST398).*", "\\1"),
    Genome = stringr::str_replace_all(Genome, "(N315).*", "\\1"),
    Genome = stringr::str_replace_all(Genome, "(Newman).*", "\\1"),
    Genome = stringr::str_replace_all(Genome, "(Mu3).*", "\\1"),
    Genome = stringr::str_replace_all(Genome, "(RF122).*", "\\1")
  ) |>
  knitr::kable()
unlink(".bowtie2.cerr.txt")

## ----session_info-------------------------------------------------------------
sessionInfo()

