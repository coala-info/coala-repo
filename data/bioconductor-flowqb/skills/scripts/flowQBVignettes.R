# Code example from 'flowQBVignettes' vignette. See references/ for full tutorial.

### R code from vignette source 'flowQBVignettes.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: LoadPackage
###################################################
library("flowQB")
library("flowQBData")


###################################################
### code chunk number 2: FitLED
###################################################
## Example is based on LED data from the flowQBData package
fcs_directory <- system.file("extdata", "SSFF_LSRII", "LED_Series", 
    package="flowQBData")
fcs_file_path_list <- list.files(fcs_directory, "*.fcs", full.names= TRUE)
## We are working with these FCS files:
basename(fcs_file_path_list)

## Various house keeping information
## - Which channels should be ignored, typically the non-fluorescence
##    channels, such as the time and the scatter channels
ignore_channels <- c("Time", 
    "FSC-A", "FSC-W", "FSC-H", 
    "SSC-A", "SSC-W", "SSC-H")
## - Which dyes would you typically use with the detectors
dyes <- c("APC", "APC-Cy7", "APC-H7", "FITC", "PE", "PE-Cy7", "PerCP", 
    "PerCP-Cy55", "V450", "V500-C")
## - What are the corresponding detectors, provide a vector of short channel 
## names, i.e., values of the $PnN FCS keywords.
detectors <- c("APC-A", "APC-Cy7-A", "APC-Cy7-A", "FITC-A", "PE-A", "PE-Cy7-A",
    "PerCP-Cy5-5-A", "PerCP-Cy5-5-A", "Pacific Blue-A", "Aqua Amine-A")
## - The signal type that you are looking at (Area or Height)
signal_type <- "Area"
## - The instrument make/model
instrument_name <- 'LSRII'
## - Set the minimum and maximum values, peaks with mean outsize of this range
## will be ignored
bounds <- list(minimum = -100, maximum = 100000)
## - The minimum number of usable peaks (represented by different FCS files
## in case of an LED pulser) required in order for a fluorescence channel 
## to be included in the fitting. Peaks with mean expression outside of the 
## bounds specified above are omitted and therefore not considered useful.
## Fitting the three quadratic parameters requires three valid points to obtain
## a fit at all, and 4 or more points are needed to obtain error estimates. 
minimum_fcs_files <- 3
## - What is the maximum number of iterations for iterative fitting with
## weight adjustments
max_iterations <- 10 # The default 10 seems to be enough in typical cases

## Now, let's calculate the fitting
led_results <- fit_led(fcs_file_path_list, ignore_channels, dyes,
    detectors, signal_type, instrument_name, bounds = bounds,
    minimum_useful_peaks = minimum_fcs_files, max_iterations = max_iterations)


###################################################
### code chunk number 3: ExploreLEDPeakStats
###################################################
## We have stats for these channels
names(led_results$peak_stats)

## Explore the peak stats for a randomly chosen channel (PE-Cy7-A)
## Showing only the head in order to limit the output for the vignette
head(led_results$peak_stats$`PE-Cy7-A`)


###################################################
### code chunk number 4: ExploreBGStats
###################################################
## Explore bg_stats
led_results$bg_stats

## Explore dye_bg_stats
led_results$dye_bg_stats


###################################################
### code chunk number 5: ExploreFits
###################################################
## Explore dye_fits
## fits are the same rows but columns corresponding to all channels
led_results$dye_fits

## Explore iterated_dye_fits
## iterated_fits are the same rows but columns corresponding to all channels
led_results$iterated_dye_fits


###################################################
### code chunk number 6: ExploreIterationNumbers
###################################################
## Explore iteration numbers
## Showing only the head in order to limit the output for the vignette
head(led_results$iteration_numbers)


###################################################
### code chunk number 7: FitSpherotechExample
###################################################
## Example of fitting bead data based on Sph8 particle sets from Spherotech
fcs_file_path <- system.file("extdata", "SSFF_LSRII", "Other_Tests", 
    "933745.fcs", package="flowQBData")
scatter_channels <- c("FSC-A", "SSC-A")
## Depending on your hardware and input, this may take a few minutes, mainly
## due to the required clustering stage of the algorithm.
spherotech_results <- fit_spherotech(fcs_file_path, scatter_channels, 
    ignore_channels, dyes, detectors, bounds, 
    signal_type, instrument_name, minimum_useful_peaks = 3,
    max_iterations = max_iterations, logicle_width = 1.0)
## This is the same as if we were running
## fit_beads(fcs_file_path, scatter_channels, 
##     ignore_channels, 8, dyes, detectors, bounds, 
##     signal_type, instrument_name, minimum_useful_peaks = 3, 
##     max_iterations = max_iterations, logicle_width = 1.0)


###################################################
### code chunk number 8: VisualizeKmeans
###################################################
library("flowCore")
plot(
    exprs(spherotech_results$transformed_data[,"FITC-A"]),
    exprs(spherotech_results$transformed_data[,"Pacific Blue-A"]),
    col=spherotech_results$peak_clusters$cluster, pch='.')


###################################################
### code chunk number 9: ExploreBeadPeakStats
###################################################
## We have stats for these channels
names(spherotech_results$peak_stats)

## Explore the peak stats for a randomly chosen channel (PE-Cy7-A)
spherotech_results$peak_stats$`PE-Cy7-A`


###################################################
### code chunk number 10: ExploreFits2
###################################################
## Explore fits
## Selecting just a few columns to limit the output for the vignette
spherotech_results$fits[,c(1,3,5,7)]

## Explore iterated_fits
spherotech_results$iterated_fits[,c(1,3,5,7)]


###################################################
### code chunk number 11: ExploreIterationNumbers2
###################################################
## Explore iteration numbers
## Showing only the head in order to limit the output for the vignette
head(spherotech_results$iteration_numbers)


###################################################
### code chunk number 12: QBFromFits
###################################################
## 1 QB from both quadratic and linear fits of LED data
qb_from_fits(led_results$iterated_dye_fits)
## 2 QB from quadratic fitting of bead data
qb_from_fits(spherotech_results$iterated_dye_fits)


###################################################
### code chunk number 13: XSLTExample
###################################################
## Example of fitting based on house-keeping information in a spreadsheet
library(xlsx)

## LED Fitting first
inst_xlsx_path <- system.file("extdata", 
    "140126_InstEval_Stanford_LSRIIA2.xlsx", package="flowQBData")
xlsx <- read.xlsx(inst_xlsx_path, 1, headers=FALSE, stringsAsFactors=FALSE)

ignore_channels_row <- 9
ignore_channels <- vector()
i <- 1
while(!is.na(xlsx[[i+4]][[ignore_channels_row]])) {
    ignore_channels[[i]] <- xlsx[[i+4]][[ignore_channels_row]]
    i <- i + 1
}
    
instrument_folder_row <- 9
instrument_folder_col <- 2
instrument_folder <- xlsx[[instrument_folder_col]][[instrument_folder_row]]
folder_column <- 18
folder_row <- 14
folder <- xlsx[[folder_column]][[folder_row]]

fcs_directory <- system.file("extdata", instrument_folder, 
    folder, package="flowQBData")
fcs_file_path_list <- list.files(fcs_directory, "*.fcs", full.names= TRUE)

bounds_min_col <- 6
bounds_min_row <- 7
bounds_max_col <- 7
bounds_max_row <- 7
bounds <- list()

if (is.na(xlsx[[bounds_min_col]][[bounds_min_row]])) {
    bounds$minimum <- -100
} else {
    bounds$minimum <- as.numeric(xlsx[[bounds_min_col]][[bounds_min_row]])
}
if (is.na(xlsx[[bounds_max_col]][[bounds_max_row]])) {
    bounds$maximum <- 100000
} else {
    bounds$maximum <- as.numeric(xlsx[[bounds_max_col]][[bounds_max_row]])
}

signal_type_col <- 3
signal_type_row <- 19
signal_type <- xlsx[[signal_type_col]][[signal_type_row]]
    
instrument_name_col <- 2
instrument_name_row <- 5
instrument_name <- xlsx[[instrument_name_col]][[instrument_name_row]]

channel_cols <- 3:12
dye_row <- 11
detector_row <- 13
dyes <- as.character(xlsx[dye_row,channel_cols])
detectors <- as.character(xlsx[detector_row,channel_cols])

## Now we do the LED fitting
led_results <- fit_led(fcs_file_path_list, ignore_channels, dyes,
    detectors, signal_type, instrument_name, bounds = bounds,
    minimum_useful_peaks = 3, max_iterations = 10)

led_results$iterated_dye_fits
qb_from_fits(led_results$iterated_dye_fits)

## Next we do the bead fitting; this example is with Thermo-fisher beads
folder_column <- 17
folder <- xlsx[[folder_column]][[folder_row]]
filename <- xlsx[[folder_column]][[folder_row+1]]

fcs_file_path <- system.file("extdata", instrument_folder, folder, 
    filename, package="flowQBData")

thermo_fisher_results <- fit_thermo_fisher(fcs_file_path, scatter_channels,
    ignore_channels, dyes, detectors, bounds, 
    signal_type, instrument_name, minimum_useful_peaks = 3, 
    max_iterations = 10, logicle_width = 1.0)
## The above is the same as this:
## N_peaks <- 6
## thermo_fisher_results <- fit_beads(fcs_file_path, scatter_channels,
##     ignore_channels, N_peaks, dyes, detectors, bounds, 
##     signal_type, instrument_name, minimum_useful_peaks = 3, 
##     max_iterations = 10, logicle_width = 1.0)

thermo_fisher_results$iterated_dye_fits
qb_from_fits(thermo_fisher_results$iterated_dye_fits)


###################################################
### code chunk number 14: FlowRepositoryRExample (eval = FALSE)
###################################################
## library("FlowRepositoryR")
## ## 1) Specify your credentials to work with FlowRepository, this will not
## ##    be required once the data is publicly available; see the 
## ##    FlowRepositoryR vignette for further details.
## setFlowRepositoryCredentials(email="your@email.com", password="password")
## ##
## ## 2) Get the dataset from FlowRepository
## ##    Note that this does not download the data. You could download all
## ##    data by running 
## ##    qbDataset <- download(flowRep.get("FR-FCM-ZZTF"))
## ##    but note that this will download about 3 GB of data
## qbDataset <- flowRep.get("FR-FCM-ZZTF")
## ##
## summary(qbDataset)
## ## A flowRepData object (FlowRepository dataset) Asilomar Instrument 
## ## Standardization
## ## 911 FCS files, 36 attachments, NOT downloaded
## ##
## ## 3) See which of the files are MS Excell spredsheets
## spreadsheet_indexes <- which(unlist(lapply(qbDataset@attachments, 
##     function(a) { endsWith(a@name, ".xlsx") })))
## ##
## ## 4) Download a random spreadsheet, say the 5th spreadsheet
## ## This is a bit ugly at this point since the data is not public
## ## plus we don't want to download everythink, just one of the files
## library(RCurl)
## h <- getCurlHandle(cookiefile="")
## FlowRepositoryR:::flowRep.login(h)
## ## Once the data is public, only this line and without the curlHandle
## ## argument will be needed:
## qbDataset@attachments[[spreadsheet_indexes[5]]] <- xslx5 <- download(
##     qbDataset@attachments[[spreadsheet_indexes[5]]], curlHandle=h)
## ## File 140126_InstEval_NIH_Aria_B2.xlsx downloaded.
## ##
## ## 5) Read the spreadsheet
## library(xlsx)
## xlsx <- read.xlsx(xslx5@localpath, 1, headers=FALSE, stringsAsFactors=FALSE)
## ##
## ## 6) Which FCS file contains the Spherotech data?
## ##    This is based on how we create the Excel spreadsheets and 
## ##    the FCS file names.
## instrument_row <- 9
## instrument_col <- 2
## instrument_name <- xlsx[[instrument_folder_col]][[instrument_folder_row]]
## fol_col <- 16
## fol_row <- 14
## fol_name <- xlsx[[fol_col]][[fol_row]]
## fcsFilename <- paste(instrument_name, fol_name, 
##     xlsx[[fol_col]][[fol_row+1]], sep="_")
## fcsFilename
## ## [1] "NIH Aria_B 140127_Other Tests_BEADS_Spherotech Rainbow1X_012.fcs"
## ##
## ## 7) Let's locate the file in our dataset and let's download it
## ##    Again, the curlHandle is only needed since the file is not public yet
## fcsFileIndex = which(unlist(lapply(qbDataset@fcs.files, function(f) { 
##     f@name == fcsFilename })))
## qbDataset@fcs.files[[fcsFileIndex]] <- fcsFile <- download(
##     qbDataset@fcs.files[[fcsFileIndex]], curlHandle=h)
## # File NIH Aria_B 140127_Other Tests_BEADS_Spherotech Rainbow1X_012.fcs 
## # downloaded.
## ##
## ## 8) Read in some more metadata from the spreadsheet
## scatter_channels <- c(
##     xlsx[[fol_col]][[fol_row+2]], 
##     xlsx[[fol_col]][[fol_row+3]])
## ignore_channels_row <- 9
## ignore_channels <- vector()
## i <- 1
## while(!is.na(xlsx[[i+4]][[ignore_channels_row]])) {
##     ignore_channels[[i]] <- xlsx[[i+4]][[ignore_channels_row]]
##     i <- i + 1
## }
## bounds_min_col <- 6
## bounds_min_row <- 7
## bounds_max_col <- 7
## bounds_max_row <- 7
## bounds <- list()
## if (is.na(xlsx[[bounds_min_col]][[bounds_min_row]])) {
##     bounds$minimum <- -100
## } else {
##     bounds$minimum <- as.numeric(xlsx[[bounds_min_col]][[bounds_min_row]])
## }
## if (is.na(xlsx[[bounds_max_col]][[bounds_max_row]])) {
##     bounds$maximum <- 100000
## } else {
##     bounds$maximum <- as.numeric(xlsx[[bounds_max_col]][[bounds_max_row]])
## }
## signal_type_col <- 3
## signal_type_row <- 19
## signal_type <- xlsx[[signal_type_col]][[signal_type_row]]
## channel_cols <- 3:12
## dye_row <- 11
## detector_row <- 13
## dyes <- as.character(xlsx[dye_row,channel_cols])
## detectors <- as.character(xlsx[detector_row,channel_cols])
## ##
## ## 9) Let's calculate the fits
## multipeak_results <- fit_spherotech(fcsFile@localpath, scatter_channels, 
##     ignore_channels, dyes, detectors, bounds, 
##     signal_type, instrument_name)
## ##
## ## 10) And same as before, we can extract Q, B and CV0 from the fits
## qb_from_fits(multipeak_results$iterated_dye_fits)
## #         APC          APC-Cy7      APC-H7       FITC        PE         
## # q_QI    0.2406655    0.1291517    0.1291517    0.2034718   0.9014326  
## # q_BSpe  34.33642     21.47796     21.47796     21.57055    812.5968   
## # q_CV0sq 0.0006431427 0.0004931863 0.0004931863 0.001599552 0.001065658
## #         PE-Cy7      PerCP       PerCP-Cy55  V450        V500-C     
## # q_QI    0.2754679   0.08987149  0.08987149  0.07051216  0.192678   
## # q_BSpe  11.15762    8.167175    8.167175    24.81647    63.4188    
## # q_CV0sq 0.001286111 0.001622208 0.001622208 0.005127177 0.004315592


###################################################
### code chunk number 15: LEDFCSFileIndexesExample (eval = FALSE)
###################################################
## LEDfcsFileIndexes <- which(unlist(lapply(qbDataset@fcs.files, function(f) 
## { 
##     f@name %in% paste(instrument_name, xlsx[14, 3:12], xlsx[15, 3:12], sep="_")
## })))
## # [1] 173 174 175 176 177 178 179 180 181 182


###################################################
### code chunk number 16: LEDExampleRepositoryContinued (eval = FALSE)
###################################################
## dir <- tempdir()
## cwd <- getwd()
## setwd(dir)
## lapply(LEDfcsFileIndexes, function(i) {
##     qbDataset@fcs.files[[i]] <- download(qbDataset@fcs.files[[i]], 
##         curlHandle=h)
## })
## setwd(cwd)
## fcs_file_path_list <- list.files(dir, "*.fcs", full.names= TRUE)
## 
## led_results <- fit_led(fcs_file_path_list, ignore_channels, dyes,
##     detectors, signal_type, instrument_name, bounds = bounds)


###################################################
### code chunk number 17: SessionInfo
###################################################
## This vignette has been created with the following configuration
sessionInfo()


