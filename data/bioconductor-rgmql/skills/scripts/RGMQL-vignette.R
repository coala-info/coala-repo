# Code example from 'RGMQL-vignette' vignette. See references/ for full tutorial.

## ---- initialization-------------------------------------------------------
library('RGMQL')

## ---- initialization_RGMQLlib----------------------------------------------
library('RGMQLlib')

## ---- init-----------------------------------------------------------------
init_gmql()

## ---- read GMQL dataset----------------------------------------------------
gmql_dataset_path <- system.file("example", "EXON", package = "RGMQL")
data_out = read_gmql(gmql_dataset_path)

## ---- read GRangesList-----------------------------------------------------
library("GenomicRanges")

# Granges Object with one region: chr2 and two metadata columns: score = 5 
# and GC  = 0.45

gr1 <- GRanges(seqnames = "chr2",
    ranges = IRanges(103, 106), strand = "+", score = 5L, GC = 0.45)

# Granges Object with two regions both chr1 and two metadata columns: score = 3
# for the fist region and score = 4 for the second one, GC  = 0.3 and 0.5 
# for the first and second region, respectively

gr2 <- GRanges(seqnames = c("chr1", "chr1"),
    ranges = IRanges(c(107, 113), width = 3), strand = c("+", "-"),
    score = 3:4, GC = c(0.3, 0.5))

grl <- GRangesList("txA" = gr1, "txB" = gr2)
data_out <- read_GRangesList(grl)

## ---- query----------------------------------------------------------------

# These statements define the paths to the folders "EXON" and "MUT" in the 
# subdirectory "example" of the package "RGMQL"

exon_path <- system.file("example", "EXON", package = "RGMQL")
mut_path <- system.file("example", "MUT", package = "RGMQL")

# Read EXON folder as a GMQL dataset named "exon_ds" containing a single 
# sample with exon regions, and MUT folder as a GMQL dataset named "mut_ds" 
# containing multiple samples with mutation regions

exon_ds <- read_gmql(exon_path)
mut_ds <- read_gmql(mut_path)

# Filter out mut_ds based on predicate 

mut = filter(mut_ds, manually_curated__dataType == 'dnaseq' & 
                clinical_patient__tumor_tissue_site == 'breast')

# Filter out exon_ds based on predicate 

exon = filter(exon_ds, annotation_type == 'exons' & 
                    original_provider == 'RefSeq')

# For each mutation sample, count mutations within each exon while 
# mapping the mutations to the exon regions using the map() function 

exon1 <- map(exon, mut)

# Remove exons in each sample that do not contain mutations

exon2 <- filter(exon1, count_left_right >= 1)

# Using the extend() function, count how many exons remain in each sample and
# store the result in the sample metadata as a new attribute-value pair, 
# with exon_count as attribute name 

exon3 <- extend(exon2, exon_count = COUNT())

# Order samples in descending order of the added metadata exon_count 

exon_res = arrange(exon3, list(DESC("exon_count")))

## ---- materialize----------------------------------------------------------
# Materialize the result dataset on disk
collect(exon_res)

## ---- execute, eval = FALSE------------------------------------------------
#  execute()

## ---- take,eval=FALSE------------------------------------------------------
#  g <- take(exon_res, rows = 45)

## ---- init with login------------------------------------------------------
test_url = "http://www.gmql.eu/gmql-rest/"
login_gmql(test_url)

## ---- run, eval = FALSE----------------------------------------------------
#  
#  job <- run_query(test_url, "query_1", "DNA = SELECT() Example_Dataset_1;
#  MATERIALIZE DNA INTO RESULT_DS;", output_gtf = FALSE)
#  

## ---- run_from_file, eval = FALSE------------------------------------------
#  query_path <- system.file("example", "query1.txt", package = "RGMQL")
#  job <- run_query_fromfile(test_url, query_path, output_gtf = FALSE)

## ---- trace, eval = FALSE--------------------------------------------------
#  jod_id <- job$id
#  trace_job(test_url, jod_id)

## ---- download, eval = FALSE-----------------------------------------------
#  name_dataset <- job$datasets[[1]]$name
#  download_dataset(test_url, name_dataset)

## ---- logout---------------------------------------------------------------
logout_gmql(test_url)

## ---- download_as_GRangesList, eval=FALSE----------------------------------
#  name_dataset <- job$datasets[[1]]$name
#  grl = download_as_GRangesList(remote_url, name_dataset)
#  

## ---- login remote, eval = FALSE-------------------------------------------
#  login_gmql(test_url)

## ---- initialize remote----------------------------------------------------
init_gmql(url = test_url)

## ---- change processing mode-----------------------------------------------
remote_processing(TRUE)

## ---- init remote processing-----------------------------------------------
init_gmql(url = test_url, remote_processing = TRUE)

## ---- remote query---------------------------------------------------------

## Read the remote dataset Example_Dataset_1 
## Read the remote dataset Example_Dataset_2 

TCGA_dnaseq <- read_gmql("public.Example_Dataset_1", is_local = FALSE)
HG19_bed_ann <- read_gmql("public.Example_Dataset_2", is_local = FALSE)

## Filter out TCGA_dnaseq based on predicate 

mut = filter(TCGA_dnaseq, manually_curated__dataType == 'dnaseq' & 
                clinical_patient__tumor_tissue_site == 'breast')

# Filter out HG19_bed_ann based on predicate 

exon = filter(HG19_bed_ann, annotation_type == 'exons' & 
                    original_provider == 'RefSeq')

# For each mutation sample, count mutations within each exon while 
# mapping the mutations to the exon regions using the map() function 

exon1 <- map(exon, mut)

# Remove exons in each sample that do not contain mutations

exon2 <- filter(exon1, count_left_right >= 1)

# Using the extend() function, count how many exons remain in each sample and
# store the result in the sample metadata as a new attribute-value pair, 
# with exon_count as attribute name 

exon3 <- extend(exon2, exon_count = COUNT())

# Order samples in descending order of the added metadata exon_count 

exon_res = arrange(exon3, list(DESC("exon_count")))

## ---- remote materialize, eval = FALSE-------------------------------------
#  collect(exon_res,"exon_res")

## ---- remote execute, eval = FALSE-----------------------------------------
#  execute()

## ---- download_as_GRangesList_2, eval=FALSE--------------------------------
#  name_dataset <- job$datasets[[1]]$name
#  grl = download_as_GRangesList(remote_url, name_dataset)

## ---- download_2, eval = FALSE---------------------------------------------
#  name_dataset <- job$datasets[[1]]$name
#  download_dataset(test_url, name_dataset)

## ---- logout_2, eval=FALSE-------------------------------------------------
#  logout_gmql(test_url)

## ---- switch mode----------------------------------------------------------
remote_processing(TRUE)

## ---- mixed query----------------------------------------------------------


# This statement defines the path to the folder "MUT" in the subdirectory 
# "example" of the package "RGMQL"

mut_path <- system.file("example", "MUT", package = "RGMQL")

# Read MUT folder as a GMQL dataset named "mut_ds" containing a single 
# sample with mutation regions

mut_ds <- read_gmql(mut_path, is_local = TRUE)

# Read the remote dataset Example_Dataset_2 

HG19_bed_ann <- read_gmql("public.Example_Dataset_2", is_local = FALSE)

# Filter out based on predicate

mut = filter(mut_ds, manually_curated__dataType == 'dnaseq' & 
                clinical_patient__tumor_tissue_site == 'breast')

exon = filter(HG19_bed_ann, annotation_type == 'exons' & 
                    original_provider == 'RefSeq')

# For each mutation sample, count mutations within each exon while 
# mapping the mutations to the exon regions using the map() function 

exon1 <- map(exon, mut)

# Remove exons in each sample that do not contain mutations

exon2 <- filter(exon1, count_left_right >= 1)

# Using the extend() function, count how many exons remain in each sample and
# store the result in the sample metadata as a new attribute-value pair, 
# with exon_count as attribute name 

exon3 <- extend(exon2, exon_count = COUNT())

# Order samples in descending order of the added metadata exon_count 

exon_res = arrange(exon3, list(DESC("exon_count")))


## ---- mixed materialize, eval = FALSE--------------------------------------
#  collect(exon_res,"exon_res")

## ---- mixed execute, eval = FALSE------------------------------------------
#  execute()

## ---- import---------------------------------------------------------------
# This statement defines the path to the folder "EXON" in the subdirectory 
# "example" of the package "RGMQL"

dataset_path <- system.file("example", "EXON", package = "RGMQL")

# Import the GMQL dataset EXON as GRangesList

imported_data <- import_gmql(dataset_path, is_gtf = FALSE)
imported_data

# and its metadata

metadata(imported_data)


## ---- export---------------------------------------------------------------
# This statement defines the path to the subdirectory "example" of the 
# package "RGMQL"

dir_out <- system.file("example", package = "RGMQL")

# Export the GRangesList 'data' as GMQL dataset called 'example' at destination 
# path

export_gmql(imported_data, dir_out, is_gtf = TRUE)


## ---- filter_extract-------------------------------------------------------
# This statement defines the path to the folder "TEAD" in the subdirectory 
# "example" of the package "RGMQL"

data_in <- system.file("example", "TEAD", package = "RGMQL")

matrix <- filter_and_extract(data_in, metadata = NULL, region_attributes = c("count"))
matrix


## ---- metadata-------------------------------------------------------------
# This statement defines the path to the folder "DATASET_META" in the 
# subdirectory "example" of the package "RGMQL"

dataset_path <- system.file("example", "DATASET_META", package = "RGMQL")

# Import the GMQL dataset DATASET_META as GRangesList

grl_data <- import_gmql(dataset_path, is_gtf = FALSE)
grl_data

# and its metadata

metadata(grl_data)


## ---- retrieve_value-------------------------------------------------------

# store metadata on variable a

a = metadata(grl_data)

# get disease value of sample S_00000

a$S_00000$disease


## ---- retrieve_values------------------------------------------------------

# get all disease values of sample S_00000

a$S_00000[which(names(a$S_00000) %in% "disease")]


