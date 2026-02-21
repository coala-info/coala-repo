# Code example from 'PeacoQC_Vignette' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
collapse=TRUE, 
comment="#>"
)

## ----setup--------------------------------------------------------------------
# install.packages("devtools")
# devtools::install_github("https://github.com/saeyslab/PeacoQC")

library(PeacoQC)


## ----warning=FALSE, fig.show='hide'-------------------------------------------
# Specify flowframe path and read your flowframe
fileName <- system.file("extdata", "111.fcs", package="PeacoQC")
ff <- flowCore::read.FCS(fileName)


# Determine channels on which quality control should be done
channels <- c(1, 3, 5:14, 18, 21)


# Remove margins
# Make sure you do this before any compensation since the internal parameters
# change and they are neccessary for the RemoveMargins function.
# If this is not possible, you can specify the internal parameters in the 
# channel_specifications parameter.

ff <- RemoveMargins(ff=ff, channels=channels, output="frame")


# Compensate and transform the data
ff <- flowCore::compensate(ff, flowCore::keyword(ff)$SPILL)
ff <- flowCore::transform(ff, 
    flowCore::estimateLogicle(ff, colnames(flowCore::keyword(ff)$SPILL)))


# Run PeacoQC and save the cleaned flowframe as an fcs file and plot the results
# of this quality control step.
peacoqc_res <- PeacoQC(
    ff=ff, 
    channels=channels, 
    determine_good_cells="all", 
    save_fcs=TRUE, 
    plot=TRUE,
    output_directory = "PeacoQC_Example1")


# Filtered flowframe is stored in peacoqc_res$FinalFF and can be used for 
# further analysis.
ff <- peacoqc_res$FinalFF



## ----eval = FALSE-------------------------------------------------------------
# # # Example of how the code could look for mass cytometry data
# 
# ff <- flowCore::read.FCS(file)
# 
# # You don't have to remove margin events or compensate the data but you
# # should transform it
# channels <- c(3, 5, 6:53)
# 
# ff <- transform(ff,transformList(colnames(ff)[channels],
#                                     arcsinhTransform(a = 0, b = 1/5, c = 0)))
# 
# # Make sure the parameters are set correctly and that the remove_zeros variable
# # is set to TRUE.
# peacoqc_results <- PeacoQC(ff,
#     channels=channels,
#     IT_limit=0.6,
#     remove_zeros=TRUE,
#     time_units=50000)
# 

## ----warning=FALSE------------------------------------------------------------

# Change IT_limit for one compensated and transformed file. 
# (Higher=more strict, lower=less strict)
# The fcs file should not be saved since we are still optimising the parameters
fileName <- system.file("extdata", "111.fcs", package="PeacoQC")
ff <- flowCore::read.FCS(fileName)

# Determine channels on which quality control should be done
channels <- c(1, 3, 5:14, 18, 21)

# Remove margins
ff <- RemoveMargins(ff=ff, channels=channels, output="frame")

# Compensate and transform the data
ff <- flowCore::compensate(ff, flowCore::keyword(ff)$SPILL)
ff <- flowCore::transform(ff, 
    flowCore::estimateLogicle(ff, colnames(flowCore::keyword(ff)$SPILL)))


# Run PeacoQC and save the cleaned flowframe as an fcs file and plot the results
# of this quality control step.
peacoqc_res <- PeacoQC(
    ff=ff, 
    channels=channels, 
    determine_good_cells="all", 
    save_fcs=FALSE, 
    plot=TRUE,
    output_directory = "PeacoQC_Example2",
    IT_limit = 0.65)



## ----eval = FALSE-------------------------------------------------------------
# 
# # You can also change the MAD parameter to a lower value
# # (to make it more strict) or to a higher value (to make it less strict).
# # Since the MAD analysis does not remove something, this is not neccesary now.
# 
# peacoqc_res <- PeacoQC(
#     ff,
#     channels,
#     determine_good_cells="all",
#     save_fcs=FALSE,
#     plot=TRUE,
#     MAD=8
# )
# 
# 
# # When the correct parameters are chosen you can run the different files in
# # a for loop
# 
# for (file in files){
#     ff <- flowCore::read.FCS(file)
# 
#     # Remove margins
#     ff <- RemoveMargins(ff=ff, channels=channels, output="frame")
# 
#     # Compensate and transform the data
#     ff <- flowCore::compensate(ff, flowCore::keyword(ff)$SPILL)
#     ff <- flowCore::transform(ff,
#                                 flowCore::estimateLogicle(ff,
#                                 colnames(flowCore::keyword(ff)$SPILL)))
#     peacoqc_res <- PeacoQC(
#                             ff,
#                             channels,
#                             determine_good_cells="all",
#                             IT_limit=0.6,
#                             save_fcs=T,
#                             plot=T)
#     }
# 

## ----warning = FALSE----------------------------------------------------------
# Find the path to the report that was created by using the PeacoQC function
location <- system.file("extdata", "PeacoQC_report.txt", package="PeacoQC")

# Make heatmap overview of the quality control run
PeacoQCHeatmap(report_location=location, show_values = FALSE,
               show_row_names = FALSE)

# Make heatmap with only the runs of the last test
PeacoQCHeatmap(report_location=location, show_values = FALSE, 
               latest_tests=TRUE, show_row_names = FALSE)

# Make heatmap with row annotation
PeacoQCHeatmap(report_location=location, show_values = FALSE,
               show_row_names = FALSE,
    row_split=c(rep("r1",7), rep("r2", 55)))


## ----warning=FALSE, fig.show= 'hide'------------------------------------------
# Load in compensated and transformed flowframe

fileName <- system.file("extdata", "111_Comp_Trans.fcs", package="PeacoQC")
ff <- flowCore::read.FCS(fileName)

# Plot only the peaks (No quality control)
PlotPeacoQC(ff, channels, display_peaks=TRUE, prefix = "PeacoQC_peaks_")

# Plot only the dots of the file
PlotPeacoQC(ff, channels, display_peaks=FALSE, prefix = "PeacoQC_nopeaks_")



