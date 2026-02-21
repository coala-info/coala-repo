# Code example from 'metagene2' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message = FALSE-------------------
BiocStyle::markdown()
library(knitr)

## ----libraryLoad, message = FALSE---------------------------------------------
library(metagene2)

## ----minimalAnalysis----------------------------------------------------------
# metagene objects are created by calling metagene2$new and providing
# regions and bam files:
mg <- metagene2$new(regions = get_demo_regions(), 
                   bam_files = get_demo_bam_files(), 
                   assay='chipseq')

# We can then plot coverage over those regions across all bam files.
mg$produce_metagene(title = "Demo metagene plot")

## ----bamFiles_show------------------------------------------------------------
# We create a vector with paths to the bam files of interest.
bam_files <- get_demo_bam_files()
basename(bam_files)

## ----bamFiles_bai-------------------------------------------------------------
# List .bai matching our specified bam files.
basename(Sys.glob(gsub(".bam", ".ba*", bam_files)))

## ----bamFiles_autoname--------------------------------------------------------
mg <- metagene2$new(regions = get_demo_regions(), bam_files = bam_files)
names(mg$get_params()[["bam_files"]])

## ----bamFiles_explicitname----------------------------------------------------
names(bam_files) = c("a1_1", "a1_2", "a2_1", "a2_2", "ctrl")
mg <- metagene2$new(regions = get_demo_regions(), bam_files = bam_files)
names(mg$get_params()[["bam_files"]])

## ----regionsArgumentFilename--------------------------------------------------
regions <- get_demo_region_filenames()
regions

## ----regionsArgumentFilenameLoad----------------------------------------------
mg <- metagene2$new(regions = get_demo_region_filenames(),
                   bam_files = get_demo_bam_files())
mg$get_regions()

## ----grangeslist_chipseq_regions----------------------------------------------
regions <- get_demo_regions()
regions

## ----grangeslist_chipseq_load-------------------------------------------------
mg <- metagene2$new(regions = regions,
                   bam_files = get_demo_bam_files())
mg$get_regions()

## ----demo_rna_regions---------------------------------------------------------
regions <- get_demo_rna_regions()
regions

## ----demo_stitch_mode---------------------------------------------------------
mg <- metagene2$new(regions = regions,
                   bam_files = get_demo_rna_bam_files(),
                   region_mode="stitch")
mg$get_regions()

## ----genratePromoterGRange, eval=FALSE----------------------------------------
#     # First locate the TxDb package containing the geneset of interest.
#     # Some of the most common TxDb packages include:
#     #  - TxDb.Hsapiens.UCSC.hg38.knownGene
#     #  - TxDb.Hsapiens.UCSC.hg19.knownGene
#     #  - TxDb.Mmusculus.UCSC.mm10.knownGene
#     #  - TxDb.Mmusculus.UCSC.mm10.ensGene
#     library(TxDb.Hsapiens.UCSC.hg38.knownGene)
# 
#     # We'll use the GenomicFeatures package to obtain gene/TSS coordinates
#     # from the TxDb package.
#     library(GenomicFeatures)
# 
#     # The GenomicFeatures::genes function provides us with gene bodies.
#     all_gene_bodies = GenomicFeatures::genes(TxDb.Hsapiens.UCSC.hg38.knownGene)
# 
#     # The GenomicFeatures::promoters function gets a region flanking the TSS.
#     # By using it directly on TxDb.Hsapiens.UCSC.hg38.knownGene, we would get
#     # the TSSes of all transcripts. Here, we use it on the gene_bodies GRanges
#     # we've just created, and limit ourselves to one TSS per gene.
#     all_TSS = GenomicFeatures::promoters(all_gene_bodies,
#                                          upstream=2000, downstream=2000)

## ----design_definition--------------------------------------------------------
example_design <- data.frame(Samples = bam_files,
                             align1 = c(1,1,0,0,2),
                             align2 = c(0,0,1,1,2))
kable(example_design)

## ----design_plot--------------------------------------------------------------
# Initializing the metagene object.
mg <- metagene2$new(regions = get_demo_regions(),
                   bam_files = get_demo_bam_files(),
                   assay='chipseq')

# Plotting while grouping the bam files by design group
mg$produce_metagene(design=example_design)

## ----design_metadata----------------------------------------------------------
# Initializing the metagene object.
mg <- metagene2$new(regions = get_demo_regions(),
                   bam_files = get_demo_bam_files()[1:4],
                   assay='chipseq')

design_meta = data.frame(design=mg$get_design_group_names(),
                         Align=c("Align1", "Align1", "Align2", "Align2"),
                         Rep=c(1, 2, 1, 2))
                             
mg$produce_metagene(design_metadata=design_meta, facet_by=Align~Rep, group_by="region")

## ----group_region_grangeslist-------------------------------------------------
# Create a GRangesList of regions to be grouped together.
regions_grl <- get_demo_regions()

# We now have a named GRangesList with two set of 50 regions.
regions_grl
lapply(regions_grl, length)

# Initializing the metagene object.
mg <- metagene2$new(regions = regions_grl,
                   bam_files = get_demo_bam_files(),
                   assay='chipseq')

# When plotting the final metagene, our regions are grouped according to
# their membership in the initial GRangesList object.
mg$plot(facet_by=~region, group_by="design")

## ----group_region_metadata----------------------------------------------------
# First, we load the regions.
regions_gr <- unlist(get_demo_regions())

# We then define some metadata.
# The examples here are nonsensical. Real metadata could include factor
# binding status, differential expression, etc.
demo_metadata = data.frame(BedName=names(regions_gr),
                           EvenStart=ifelse((start(regions_gr) %% 2) == 0, "Even", "Odd"),
                           Strand=strand(regions_gr))
head(demo_metadata)

# Initializing the metagene object, passing in region metadata.
mg <- metagene2$new(regions = get_demo_regions(),
                   region_metadata=demo_metadata,
                   bam_files = get_demo_bam_files(),
                   assay='chipseq')

# When plotting the metagene, our regions are grouped according to
# the specified metadata columns.
mg$produce_metagene(split_by=c("EvenStart", "Strand"), facet_by=EvenStart~Strand, group_by="design")

## ----getParams----------------------------------------------------------------
mg <- get_demo_metagene()
names(mg$get_params())

mg$get_params()[["bin_count"]]

## ----setParamsConstructor-----------------------------------------------------
mg <- metagene2$new(regions=get_demo_regions(), 
                   bam_files=get_demo_bam_files(),
                   bin_count=50)
mg$produce_metagene(alpha=0.01, title="Set parameters on produce_metagene")

## ----changeSingleParamProduceMetagene-----------------------------------------
mg$produce_metagene(bin_count=100)

## ----showPlot-----------------------------------------------------------------
mg$plot(title = "Demo plot subset")

## ----getParams2---------------------------------------------------------------
mg <- get_demo_metagene()
names(mg$get_params())

mg$get_params()[c("bin_count", "alpha", "normalization")]

## ----getBamCount--------------------------------------------------------------
mg <- get_demo_metagene()
mg$get_bam_count(mg$get_params()[["bam_files"]][1])

## ----getRegions---------------------------------------------------------------
# Out demo regions are a GRangesList of two elements containing 50 ranges each.
get_demo_regions()

# When we initialize the metagene object, those regions will be pre-processed,
# flattening the list into a single GRanges object and adding a region_name
# column for tracking.
mg <- metagene2$new(regions = get_demo_regions(),
                   bam_files = get_demo_bam_files())

# get_regions allows us to see those post-processed regions.
mg$get_regions()

## ----getRawCoverages----------------------------------------------------------
coverages <- mg$get_raw_coverages()
coverages[[1]]
length(coverages)

## ----copyMetagene-------------------------------------------------------------
mg_copy <- mg$clone(deep=TRUE)

## ----plotMetagene-------------------------------------------------------------
mg1 <- metagene2$new(bam_files = get_demo_bam_files(), 
                     regions = get_demo_regions()[1])
mg2 <- metagene2$new(bam_files = get_demo_bam_files(),
                     regions = get_demo_regions()[2])
plot_metagene(rbind(mg1$add_metadata(), mg2$add_metadata()),
              facet_by=.~region_name)

## ----metagene_heatmap_default_order-------------------------------------------
mg <- get_demo_metagene()
metagene2_heatmap(mg)

## ----metagene_heatmap_decreasing_order----------------------------------------
mg <- get_demo_metagene()
metagene2_heatmap(mg, coverage_order(mg, "align1_rep1"))

