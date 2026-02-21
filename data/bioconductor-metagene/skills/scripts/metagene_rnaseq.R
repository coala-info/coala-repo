# Code example from 'metagene_rnaseq' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message = FALSE----------------
BiocStyle::markdown()
library(knitr)

## ----libraryLoad, message = FALSE------------------------------------------
library(metagene)

## ----bamFiles--------------------------------------------------------------
bam_files <- 
c(system.file("extdata/cyto4.bam", package="metagene"),
  system.file("extdata/cyto3.bam", package="metagene"),
  system.file("extdata/nuc4.bam", package="metagene"),
  system.file("extdata/nuc3.bam", package="metagene"))

## ----regionsArgument-------------------------------------------------------
regions <- 
c(system.file("extdata/DPM1.bed", package="metagene"),
system.file("extdata/NDUFAB1.bed", package="metagene"))

## ----DesignCraft-----------------------------------------------------------
Samples <- c("cyto4.bam",
            "cyto3.bam",
            "nuc4.bam",
            "nuc3.bam")
cyto <- c(1,1,0,0)
nucleo <- c(0,0,1,1)
mydesign <- cbind(Samples, cyto, nucleo)
mydesign <- data.frame(mydesign)
#to make cyto and nucleo colums numeric variables
mydesign$cyto <- cyto
mydesign$nucleo <- nucleo

## ----new metagene_rnaseq object, warnings = FALSE--------------------------
bam_files <- 
c(system.file("extdata/nuc4.bam", package="metagene"))
regions <- 
c(system.file("extdata/DPM1.bed", package="metagene"))
# Initialization
mg <- metagene$new(regions = regions, 
                    bam_files = bam_files, 
                    assay = 'rnaseq', 
                    paired_end = TRUE)
mg$produce_table(normalization = 'RPM')
mg$produce_data_frame()
mg$plot(title = 'DPM1')

## ----initialization, warnings = FALSE--------------------------------------
bam_files <- 
c(system.file("extdata/cyto4.bam", package="metagene"),
  system.file("extdata/cyto3.bam", package="metagene"),
  system.file("extdata/nuc4.bam", package="metagene"),
  system.file("extdata/nuc3.bam", package="metagene"))
regions <- 
c(system.file("extdata/DPM1.bed", package="metagene"),
system.file("extdata/NDUFAB1.bed", package="metagene"))
mg <- metagene$new(regions = regions, 
                    bam_files = bam_files, 
                    assay = 'rnaseq', 
                    paired_end = TRUE)

## ----showProduceTable, warnings = FALSE------------------------------------
mg$produce_table(flip_regions = TRUE, normalization = 'RPM')
tab <- mg$get_table()

## ----produceDataFrame------------------------------------------------------
mg$produce_data_frame()

## ----produceDataFrame2, warnings = FALSE-----------------------------------
bam_files <- 
c(system.file("extdata/cyto4.bam", package="metagene"))
region <- 
c(system.file("extdata/NDUFAB1.bed", package="metagene"))
mg <- metagene$new(regions = region, bam_files = bam_files, assay = 'rnaseq')
mg$produce_table(flip_regions = TRUE, normalization = 'RPM')
mg$plot(title = 'with all normalized values')
mg$produce_data_frame(avoid_gaps = TRUE,
                        bam_name = "cyto4",
                        gaps_threshold = 30)
mg$plot(title = 'without normalized values under 30')

## ----showPlot, warnings = FALSE--------------------------------------------
bam_files <- 
c(system.file("extdata/cyto4.bam", package="metagene"),
  system.file("extdata/cyto3.bam", package="metagene"),
  system.file("extdata/nuc4.bam", package="metagene"),
  system.file("extdata/nuc3.bam", package="metagene"))
regions <- 
c(system.file("extdata/DPM1.bed", package="metagene"),
system.file("extdata/NDUFAB1.bed", package="metagene"))
mg <- metagene$new(regions = regions, 
                    bam_files = bam_files, 
                    assay = 'rnaseq', 
                    paired_end = TRUE)
mg$produce_table(normalization = 'RPM')
mg$produce_data_frame(avoid_gaps = TRUE,
                        bam_name = "cyto4",
                        gaps_threshold = 30)
mg$plot(region_names = "DPM1", title = "Demo plot subset RNA-Seq")

## ----memory, collapse=TRUE, warnings = FALSE, eval=FALSE-------------------
#  regions <-
#  c(system.file("extdata/DPM1.bed", package="metagene"),
#  system.file("extdata/NDUFAB1.bed", package="metagene"))
#  bam_files <-
#  c(system.file("extdata/cyto4.bam", package="metagene"),
#    system.file("extdata/cyto3.bam", package="metagene"),
#    system.file("extdata/nuc4.bam", package="metagene"),
#    system.file("extdata/nuc3.bam", package="metagene"))
#  mg1 <- metagene$new(bam_files = bam_files[1:2], regions = regions,
#  							assay = 'rnaseq', paired_end = TRUE)
#  mg1$produce_data_frame()
#  mg2 <- metagene$new(bam_files = bam_files[3:4], regions = regions,
#  							assay = 'rnaseq', paired_end = TRUE)
#  mg2$produce_data_frame()

## ----extractDF, eval=FALSE-------------------------------------------------
#  df1 <- mg1$get_data_frame()
#  df2 <- mg2$get_data_frame()
#  df <- rbind(df1, df2)

## ----out.width="px", out.height="400px", eval=FALSE------------------------
#  p <- plot_metagene(df)
#  p + ggplot2::ggtitle("Managing large datasets")
#  

## ----extract_subtables, warnings = FALSE-----------------------------------
mg <- metagene$new(bam_files = bam_files, regions = regions, 
							assay = 'rnaseq', paired_end = TRUE)
mg$produce_table(design = mydesign, normalization = 'RPM')
tab <- mg$get_table()
tab0 <- metagene:::avoid_gaps_update(tab, 
       bam_name = 'cyto4', gaps_threshold = 10)
tab0 <- tab0[which(tab0$region == "NDUFAB1"),]
tab1 <- tab0[which(tab0$design == "cyto"),]
tab2 <- tab0[which(tab0$design == "nucleo"),]

## ----similaRpeak-----------------------------------------------------------
library(similaRpeak)
perm_fun <- function(profile1, profile2) {
    sim <- similarity(profile1, profile2)
    sim[["metrics"]][["RATIO_INTERSECT"]]
}

## ----calculateRNI----------------------------------------------------------
ratio_intersect <- 
  perm_fun(tab1[, .(moy=mean(value)), by=nuc]$moy, 
           tab2[, .(moy=mean(value)), by=nuc]$moy)
ratio_intersect

## ----permTest--------------------------------------------------------------
permutation_results <- permutation_test(tab1, tab2, sample_size = 2,
                                        sample_count = 1000, FUN = perm_fun)

## ----perm_pval-------------------------------------------------------------
sum(ratio_intersect >= permutation_results) / 
                                length(permutation_results)
mg$plot(region_names = 'NDUFAB1', title='NDUFAB1')

