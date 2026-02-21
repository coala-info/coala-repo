# Code example from 'Database-Formats' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(misha)

## ----eval = FALSE-------------------------------------------------------------
# # Create database from FASTA file
# gdb.create("mydb", "/path/to/genome.fa")
# 
# # Or download pre-built genome
# gdb.create_genome("hg38", path = "/path/to/install")

## ----eval = FALSE-------------------------------------------------------------
# # Set option before creating database
# options(gmulticontig.indexed_format = FALSE)
# gdb.create("mydb", "/path/to/genome.fa")

## ----eval = FALSE-------------------------------------------------------------
# gsetroot("/path/to/mydb")
# info <- gdb.info()
# print(info$format) # "indexed" or "per-chromosome"

## ----eval = FALSE-------------------------------------------------------------
# info <- gdb.info()
# # $path
# # [1] "/path/to/mydb"
# #
# # $is_db
# # [1] TRUE
# #
# # $format
# # [1] "indexed"
# #
# # $num_chromosomes
# # [1] 24
# #
# # $genome_size
# # [1] 3095693983

## ----eval = FALSE-------------------------------------------------------------
# gsetroot("/path/to/mydb")
# gdb.convert_to_indexed()

## ----eval = FALSE-------------------------------------------------------------
# gtrack.convert_to_indexed("mytrack")

## ----eval = FALSE-------------------------------------------------------------
# # 1D intervals
# gintervals.convert_to_indexed("myintervals")
# 
# # 2D intervals
# gintervals.2d.convert_to_indexed("my2dintervals")

## ----eval = FALSE-------------------------------------------------------------
# # Create backup of important database
# system("cp -r /path/to/mydb /path/to/mydb.backup")

## ----eval = FALSE-------------------------------------------------------------
# gsetroot("/path/to/mydb")
# info <- gdb.info()
# print(paste("Current format:", info$format))

## ----eval = FALSE-------------------------------------------------------------
# gdb.convert_to_indexed()

## ----eval = FALSE-------------------------------------------------------------
# # Check format changed
# info <- gdb.info()
# print(paste("New format:", info$format))
# 
# # Test a few operations
# result <- gextract("mytrack", gintervals(1, 0, 1000))
# print(head(result))

## ----eval = FALSE-------------------------------------------------------------
# # After thorough testing
# system("rm -rf /path/to/mydb.backup")

## ----eval = FALSE-------------------------------------------------------------
# # Export from source database
# gsetroot("/path/to/source_db")
# gextract("mytrack", gintervals.all(),
#     iterator = "mytrack",
#     file = "/tmp/mytrack.txt"
# )
# 
# # Import to target database (format auto-detected)
# gsetroot("/path/to/target_db")
# gtrack.import("mytrack", "Copied track", "/tmp/mytrack.txt", binsize = 0)
# # Automatically converted to target database format!

## ----eval = FALSE-------------------------------------------------------------
# # Copy multiple tracks
# tracks <- c("track1", "track2", "track3")
# 
# for (track in tracks) {
#     # Export
#     gsetroot("/path/to/source_db")
#     file_path <- sprintf("/tmp/%s.txt", track)
#     gextract(track, gintervals.all(), iterator = track, file = file_path)
# 
#     # Import
#     gsetroot("/path/to/target_db")
#     info <- gtrack.info(track) # Get description
#     gtrack.import(track, info$description, file_path, binsize = 0)
#     unlink(file_path)
# }

## ----eval = FALSE-------------------------------------------------------------
# # Work with both formats in same session
# gsetroot("/path/to/legacy_db")
# data1 <- gextract("track1", gintervals(1, 0, 1000))
# 
# gsetroot("/path/to/indexed_db")
# data2 <- gextract("track2", gintervals(1, 0, 1000))

## ----eval = FALSE-------------------------------------------------------------
# gdb.convert_to_indexed()

## ----eval = FALSE-------------------------------------------------------------
# gdb.reload()

## ----eval = FALSE-------------------------------------------------------------
# # Convert one track at a time
# gtrack.convert_to_indexed("track1")
# gtrack.convert_to_indexed("track2")
# # etc.

