# Code example from 'metagene' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message = FALSE----------------
BiocStyle::markdown()
library(knitr)

## ----libraryLoad, message = FALSE------------------------------------------
library(metagene)

## ----bamFiles--------------------------------------------------------------
bam_files <- get_demo_bam_files()
bam_files

## ----namedBamFiles---------------------------------------------------------
named_bam_files <- bam_files
names(named_bam_files) <- letters[seq_along(bam_files)]
named_bam_files

## ----regionsArgument-------------------------------------------------------
regions <- get_demo_regions()
regions

## ----showDatasets----------------------------------------------------------
data(promoters_hg19)
promoters_hg19

## ----designFile------------------------------------------------------------
fileDesign <- system.file("extdata/design.txt", package="metagene")
design <- read.table(fileDesign, header=TRUE, stringsAsFactors=FALSE)
design$Samples <- paste(system.file("extdata", package="metagene"),
                        design$Samples, sep="/")
kable(design)

## ----alternateDesign-------------------------------------------------------
design <- data.frame(Samples = c("align1_rep1.bam", "align1_rep2.bam",
                    "align2_rep1.bam", "align2_rep2.bam", "ctrl.bam"),
                    align1 = c(1,1,0,0,2), align2 = c(0,0,1,1,2))
design$Samples <- paste0(system.file("extdata", package="metagene"), "/",
                        design$Samples)
kable(design)

## ----minimalAnalysis-------------------------------------------------------
regions <- get_demo_regions()
bam_files <- get_demo_bam_files()
# Initialization
mg <- metagene$new(regions = regions, bam_files = bam_files)
# Plotting
mg$plot(title = "Demo metagene plot")

## ----initialization--------------------------------------------------------
regions <- get_demo_regions()
bam_files <- get_demo_bam_files()
mg <- metagene$new(regions = regions, bam_files = bam_files)

## ----showProduceTable------------------------------------------------------
mg$produce_table()

## ----produceTableDesign----------------------------------------------------
mg$produce_table(design = design)

## ----produceDataFrame------------------------------------------------------
mg$produce_data_frame()

## ----showPlot--------------------------------------------------------------
mg$plot(region_names = "list1", title = "Demo plot subset")

## ----getTable--------------------------------------------------------------
mg <- get_demo_metagene()
mg$produce_table()
mg$get_table()

## ----getMatrices-----------------------------------------------------------
mg <- get_demo_metagene()
mg$produce_table()
m <- mg$get_matrices()
# m$list1$ctrl$input to access to region 'list1' and 'ctrl' design

## ----getDataFrame----------------------------------------------------------
mg <- get_demo_metagene()
mg$produce_table()
mg$produce_data_frame()
mg$get_data_frame()

## ----getParams-------------------------------------------------------------
mg <- get_demo_metagene()
mg$get_params()

## ----getDesign-------------------------------------------------------------
mg$produce_table(design = get_demo_design())
## Alternatively, it is also possible to add a design without producing the
## table:
mg$add_design(get_demo_design())
mg$get_design()

## ----getBamCount-----------------------------------------------------------
mg$get_bam_count(bam_files[1])

## ----getRegions------------------------------------------------------------
mg$get_regions()

## ----getRegionsSubset------------------------------------------------------
mg$get_regions(region_names = c(regions[1]))

## ----getRawCoverages-------------------------------------------------------
coverages <- mg$get_raw_coverages()
coverages[[1]]
length(coverages)

## ----getRawCoveragesSubset-------------------------------------------------
coverages <- mg$get_raw_coverages(filenames = bam_files[1:2])
length(coverages)

## ----showChain-------------------------------------------------------------
rg <- get_demo_regions()
bam <- get_demo_bam_files()
d <- get_demo_design()
title <- "Show chain"
mg <- metagene$new(rg, bam)$produce_table(design = d)$plot(title = title)

## ----copyMetagene----------------------------------------------------------
mg_copy <- mg$clone()

## ----memory, collapse=TRUE-------------------------------------------------
mg1 <- metagene$new(bam_files = bam_files, regions = regions[1])
mg1$produce_data_frame()
mg2 <- metagene$new(bam_files = bam_files, regions = regions[2])
mg2$produce_data_frame()

## ----extractDF-------------------------------------------------------------
df1 <- mg1$get_data_frame()
df2 <- mg2$get_data_frame()
df <- rbind(df1, df2)

## ----plotMetagene----------------------------------------------------------
p <- plot_metagene(df)
p + ggplot2::ggtitle("Managing large datasets")

## ----extract_subtables-----------------------------------------------------
tab <- mg$get_table()
tab0 <- tab[which(tab$region == "list1"),]
tab1 <- tab0[which(tab0$design == "align1"),]
tab2 <- tab0[which(tab0$design == "align2"),]

## ----similaRpeak-----------------------------------------------------------
library(similaRpeak)
perm_fun <- function(profile1, profile2) {
    sim <- similarity(profile1, profile2)
    sim[["metrics"]][["RATIO_NORMALIZED_INTERSECT"]]
}

## ----calculateRNI----------------------------------------------------------
ratio_normalized_intersect <- 
 perm_fun(tab1[, .(moy=mean(value)), by=bin]$moy, 
        tab2[, .(moy=mean(value)), by=bin]$moy)
ratio_normalized_intersect

## ----permTest--------------------------------------------------------------
permutation_results <- permutation_test(tab1, tab2, sample_size = 50,
                                        sample_count = 1000, FUN = perm_fun)

## ----perm_pval-------------------------------------------------------------
sum(ratio_normalized_intersect >= permutation_results) / 
                                length(permutation_results)

