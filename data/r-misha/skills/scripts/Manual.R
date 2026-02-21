# Code example from 'Manual' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(misha)
gdb.init_examples()

## ----eval=FALSE---------------------------------------------------------------
# # Set your working database
# gsetroot("/data/my_project")
# 
# # Load additional datasets
# gdataset.load("/shared/ucsc_annotations")
# gdataset.load("/shared/encode_chipseq")
# 
# # List all sources (working db + loaded datasets)
# gdataset.ls()
# 
# # Get detailed information
# gdataset.ls(dataframe = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# # If working_db has "my_track" and dataset1 also has "my_track":
# gdataset.load("dataset1")
# # Error: Cannot load dataset 'dataset1': tracks 'my_track' already exist in working database.
# # Use force=TRUE to override (working db wins).

## ----eval=FALSE---------------------------------------------------------------
# # Working database always wins over datasets
# gdataset.load("dataset1", force = TRUE)
# 
# # For dataset-to-dataset collisions, later-loaded wins
# gdataset.load("dataset2", force = TRUE)
# 
# # Check which source provides a track
# gtrack.dataset("my_track")
# 
# # See all sources where a track exists (for debugging)
# gtrack.dbs("my_track")

## ----eval=FALSE---------------------------------------------------------------
# gsetroot("/data/my_project")
# gdataset.load("/shared/annotations")
# 
# # Extract tracks from different sources in a single call
# result <- gextract(c("my_track", "annotation_track"), gintervals(1, 0, 10000), iterator = 100)
# 
# # Use track expressions across sources
# normalized <- gextract("my_track - annotation_track", gintervals(1, 0, 10000), iterator = 100)
# 
# # Access track attributes from any source
# gtrack.attr.get("my_track", "description")
# gtrack.attr.get("annotation_track", "description")

## ----eval=FALSE---------------------------------------------------------------
# # Create virtual tracks from different sources
# gvtrack.create("vt_signal", "my_track", "avg")
# gvtrack.create("vt_annotation", "annotation_track", "avg")
# 
# # Combine them in expressions
# gextract("vt_signal / vt_annotation", gintervals(1, 0, 10000))

## ----eval=FALSE---------------------------------------------------------------
# # Single track - returns source path
# gtrack.dataset("my_track")
# 
# # All sources containing a track (useful for debugging shadowed tracks)
# gtrack.dbs("my_track")
# 
# # Multiple tracks (vectorized)
# gtrack.dataset(c("track1", "track2", "track3"))
# 
# # Intervals
# gintervals.dataset("my_intervals")
# gintervals.dbs("my_intervals")

## ----eval=FALSE---------------------------------------------------------------
# # List tracks from a specific source only
# gtrack.ls(db = "/shared/annotations")
# 
# # List intervals from working database
# gintervals.ls(db = "/data/my_project")

## ----eval=FALSE---------------------------------------------------------------
# gsetroot("/data/my_project")
# 
# # Create a dataset with selected tracks and intervals
# gdataset.save(
#     path = "/shared/my_chipseq_dataset",
#     description = "ChIP-seq tracks for H3K4me3 and H3K27ac",
#     tracks = gtrack.ls("chip_"), # Pattern matching
#     intervals = c("peaks_h3k4me3", "peaks_h3k27ac")
# )
# 
# # Options:
# # - symlinks = TRUE: Create symlinks instead of copying (saves space)
# # - copy_seq = TRUE: Copy seq/ directory instead of symlinking

## ----eval=FALSE---------------------------------------------------------------
# gdataset.info("/shared/my_chipseq_dataset")
# # Returns: description, author, created date, track/interval counts, genome hash

## ----eval=FALSE---------------------------------------------------------------
# # Create linked database with symlinks to parent's seq and chrom_sizes
# gdb.create_linked("~/my_db", parent = "/shared/hg38")
# 
# # Use as your working database
# gsetroot("~/my_db")
# 
# # Load datasets from the parent
# gdataset.load("/shared/hg38")
# 
# # Create your own tracks
# gtrack.create("my_analysis", "Analysis results", "reference_track * 2")

## ----eval=FALSE---------------------------------------------------------------
# # Unload a dataset (tracks/intervals become unavailable)
# gdataset.unload("/shared/annotations")
# 
# # Safe to call even if not loaded (no error by default)
# gdataset.unload("/nonexistent/path")
# 
# # Error if validate=TRUE and not loaded
# gdataset.unload("/nonexistent/path", validate = TRUE)
# # Error: Dataset '/nonexistent/path' is not loaded

## ----eval=FALSE---------------------------------------------------------------
# # Rename a track
# gtrack.mv("old_name", "new_name")
# 
# # Move to a different namespace (directory)
# gtrack.mv("analysis.track1", "results.track1")

## ----eval=FALSE---------------------------------------------------------------
# # Copy a track within the same database
# gtrack.copy("source_track", "copy_track")
# 
# # Copy from a loaded dataset to the working database
# gsetroot("/data/my_project")
# gdataset.load("/shared/annotations")
# gtrack.copy("annotation_track", "my_local_copy") # Copy to working db

## ----eval=FALSE---------------------------------------------------------------
# gsetroot("/data/my_project")
# gdataset.load("/shared/annotations")
# 
# # Create virtual track referencing track from working db
# gvtrack.create("vt1", "my_local_track", "avg")
# 
# # Create virtual track referencing track from dataset
# gvtrack.create("vt2", "annotation_track", "max")
# 
# # Use both in same expression
# gextract("vt1 + vt2", gintervals(1, 0, 10000))

## ----eval=FALSE---------------------------------------------------------------
# gsetroot("single_database") # Works unchanged
# gdb.init("single_database") # Equivalent, also works

## ----eval=FALSE---------------------------------------------------------------
# # Convert a track to indexed format
# gtrack.convert_to_indexed("my_track")
# 
# # Check track format
# info <- gtrack.info("my_track")
# print(info$format) # "indexed" or "per-chromosome"

## ----eval=FALSE---------------------------------------------------------------
# # Convert 1D interval set to indexed format
# gintervals.convert_to_indexed("my_intervals")
# 
# # Convert 2D interval set to indexed format
# gintervals.2d.convert_to_indexed("my_2d_intervals")
# 
# # Convert and remove old per-chromosome files
# gintervals.convert_to_indexed("my_intervals", remove.old = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# # 'annotations' is an intervals set saved in Genomic Database
# gintervals.intersect("annotations", gintervals(2))

## ----eval=FALSE---------------------------------------------------------------
# gvtrack.create("myvtrack", "dense_track")

## ----eval=FALSE---------------------------------------------------------------
# gvtrack.create("myvtrack", "dense_track", "global.percentile")

## ----eval=FALSE---------------------------------------------------------------
# gvtrack.create("myvtrack", "array_track", "sum")
# gvtrack.array.slice("myvtrack", c("col2", "col5"), "max")

## ----eval=FALSE---------------------------------------------------------------
# gvtrack.iterator("myvtrack", sshift = -100, eshift = 200)

## ----eval=FALSE---------------------------------------------------------------
# gvtrack.create("myvtrack", "dense_track")
# gvtrack.iterator("myvtrack", dim = 2)

## ----eval=FALSE---------------------------------------------------------------
# gvtrack.create("myvtrack", "annotations", "distance")
# intervs <- gscreen("dense_track > 0.45")
# gextract("myvtrack", .misha$ALLGENOME, iterator = intervs)

## ----eval=FALSE---------------------------------------------------------------
# # Create a data frame with intervals and numeric values
# intervals_with_values <- data.frame(
#     chrom = "chr1",
#     start = c(100, 300, 500),
#     end = c(200, 400, 600),
#     score = c(10, 20, 30)
# )
# 
# # Use as value-based sparse track
# gvtrack.create("myvtrack", intervals_with_values, "avg")
# gvtrack.create("myvtrack_max", intervals_with_values, "max")

## ----eval = FALSE-------------------------------------------------------------
# options(gbuf.size = 1)

## ----eval=FALSE---------------------------------------------------------------
# gextract("dense_track", gintervals(2, 340, 520))

## ----eval=FALSE---------------------------------------------------------------
# intervs <- gintervals.2d(1, 200, 800, 1, 100, 1000)
# intervs <- rbind(intervs, gintervals.2d(1, 900, 950, 1, 0, 200))
# intervs <- rbind(intervs, gintervals.2d(1, 0, 100, 1, 0, 400))
# intervs <- rbind(intervs, gintervals.2d(1, 900, 950, 2, 0, 200))
# intervs

## ----eval=FALSE---------------------------------------------------------------
# intervs <- gintervals.2d(1, c(100, 400), c(300, 490), 1, c(120, 180), c(200, 500))
# gtrack.2d.create("test2d", "test 2D track", intervs, c(10, 20))
# gextract("test2d", .misha$ALLGENOME)
# gextract("test2d", .misha$ALLGENOME, iterator = gintervals.2d(1, 0, 1000, 1, 0, 1000))
# gintervals.2d.band_intersect(intervs, band = c(150, 1000))
# gextract("test2d", .misha$ALLGENOME, iterator = gintervals.2d(1, 0, 1000, 1, 0, 1000), band = c(150, 1000))
# gtrack.rm("test2d", force = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# set.seed(60427)
# r1 <- gsample("dense_track", 10)
# r2 <- gsample("dense_track", 10) # r2 differs from r1
# set.seed(60427)
# r3 <- gsample("dense_track", 10) # r3 == r1

