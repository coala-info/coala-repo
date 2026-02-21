# Code example from 'MQmetrics' vignette. See references/ for full tutorial.

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----install, eval = FALSE----------------------------------------------------
#  # install.packages("devtools")
#  devtools::install_github("svalvaro/MQmetrics")

## ----MQPathCombined-----------------------------------------------------------
MQPathCombined <- '/home/alvaro/Documents/MaxQuant/example5/combined/'

## ----report, message=FALSE----------------------------------------------------
library(MQmetrics)

## ----report_question_mark, eval=FALSE-----------------------------------------
#  ?generateReport

## ----parameters, eval=FALSE---------------------------------------------------
#  generateReport(MQPathCombined = , # directory to the combined folder
#                 output_dir = , # directory to store the resulting pdf
#                 long_names = , # If your samples have long names set it to TRUE
#                 sep_names = , # Indicate the separator of those long names
#                 UniprotID = , # Introduce the UniprotID of a protein of interest
#                 intensity_type = ,) # Intensity or LFQ
#  
#  # The only mandatory parameter is MQPathCombined, the rest are optional.

## ----example,eval=FALSE-------------------------------------------------------
#  # If you're using a Unix-like OS use forward slashes.
#  MQPathCombined <- '/home/alvaro/Documents/MaxQuant/example5/'
#  
#  # If you're using Windows use backslashes:
#  MQPathCombined <- "D:\Documents\MaxQuant_results\example5\combined\ "
#  
#  #Use the generateReport function.
#  generateReport(MQPathCombined)

## ---- message=FALSE, warning=FALSE--------------------------------------------

# To create the vignettes and examples I use data that is in the package itself:
MQPathCombined <- system.file('extdata/combined/', package = 'MQmetrics')


# make_MQCombined will read the tables needed for creating the outputs.
MQCombined <- make_MQCombined(MQPathCombined, remove_contaminants = TRUE) 


## ----ExperimentDuration, comment= NA------------------------------------------
MaxQuantAnalysisInfo(MQCombined) 

## ----PlotProteins,fig.height=5, fig.width=7.2---------------------------------
PlotProteinsIdentified(MQCombined,
                       long_names = TRUE,
                       sep_names = '_',
                       intensity_type = 'LFQ',
                       palette = 'Set2')

## ----PeptidesIdentified, warning=FALSE , fig.height=5, fig.width=7.2----------
PlotPeptidesIdentified(MQCombined, 
                       long_names = TRUE,
                       sep_names = '_', 
                       palette = 'Set3')

## ----ratio, warning=FALSE , fig.height=5, fig.width=7.2-----------------------

PlotProteinPeptideRatio(MQCombined,
                        intensity_type = 'LFQ',
                        long_names = TRUE,
                        sep_names =  '_')


## ----PlotMSMS, fig.height=5, fig.width=7.2------------------------------------
PlotMsMs(MQCombined,
         long_names = TRUE, 
         sep_names = '_',
         position_dodge_width = 1,
         palette = 'Set2')

## ----PlotPeaks, fig.height=5, fig.width=7.2-----------------------------------
PlotPeaks(MQCombined,
          long_names = TRUE,
          sep_names = '_',
          palette = 'Set2')

## ----isotope, fig.height=5, fig.width=7.2-------------------------------------
PlotIsotopePattern(MQCombined,
                   long_names = TRUE,
                   sep_names = '_',
                   palette = 'Set2')

## ----Charg, warning=FALSE, message=FALSE, fig.height=10, fig.width=7.2--------
PlotCharge(MQCombined, 
           palette = 'Set2',
           plots_per_page = 6)

## ----missed_cleavages,fig.height=10, fig.width=7.2----------------------------
PlotProteaseSpecificity(MQCombined, 
                        palette = 'Set2',
                        plots_per_page = 6)

## ----PlotHydrophobicity, warning= F, message= F,fig.height=10, fig.width=7.2----
PlotHydrophobicity(MQCombined,
                   show_median =  TRUE,
                   binwidth = 0.1, 
                   size_median = 1.5, 
                   palette = 'Set2',
                   plots_per_page = 6)


## ----AndromedaScore, message = F, warning = FALSE,fig.height=10, fig.width=7.2----
PlotAndromedaScore(MQCombined,
                   palette = 'Set2',
                   plots_per_page = 6)

## ----IdentificationType,message = F, warning = F, fig.height=5, fig.width=7.2----
PlotIdentificationType(MQCombined,
                       long_names = TRUE, 
                       sep_names = '_', 
                       palette = 'Set2')  


## ----PlotIntensity, warning = FALSE, fig.height=5, fig.width=7.2--------------
PlotIntensity(MQCombined, 
              split_violin_intensity = TRUE, 
              intensity_type = 'LFQ', 
              log_base = 2, 
              long_names = TRUE, 
              sep_names = '_', 
              palette = 'Set2')


## ----PlotPCA, warning = FALSE, fig.height=5, fig.width=7.2--------------------
PlotPCA(MQCombined,
        intensity_type = 'LFQ',
        palette = 'Set2')

## ----DynamicRange, fig.height=5, fig.width=7.2--------------------------------
PlotCombinedDynamicRange(MQCombined,
                         show_shade = TRUE,
                         percent_proteins = 0.90)

## ----DynamicRangeAll, fig.height=10, fig.width=7.2----------------------------
PlotAllDynamicRange(MQCombined,
                    show_shade = TRUE, 
                    percent_proteins = 0.90)

## ----protein_coverage_all, fig.height=7.2, fig.width=7.2----------------------
PlotProteinOverlap(MQCombined)

## ----protein_degradation,fig.height=10, fig.width=7.2-------------------------
PlotProteinCoverage(MQCombined,
                    UniprotID = "P55072",
                    log_base = 2,
                    segment_width = 1,
                    palette = 'Set2',
                    plots_per_page = 6)

## ----irt_peps1, warning = FALSE, message= FALSE, fig.height=10, fig.width=7.2----
PlotiRT(MQCombined, 
        show_calibrated_rt = FALSE,
        tolerance = 0.001)

## ----irt_peps2, warning = FALSE, message= FALSE, fig.height=10, fig.width=7.2----
PlotiRTScore(MQCombined, 
             tolerance = 0.001)

## ----TotalIonCurrent, fig.height=10, fig.width=7.2----------------------------
PlotTotalIonCurrent(MQCombined,
                    show_max_value = TRUE,
                    palette = 'Set2',
                    plots_per_page = 6)

## ----Pn, fig.height= 10, warning=F, message=F,fig.height=10, fig.width=7.2----
PlotAcquisitionCycle(MQCombined, 
                     palette = 'Set2',
                     plots_per_page = 6)

## ----PTM, fig.height=8, fig.width=7.2-----------------------------------------
PlotPTM(MQCombined,
        peptides_modified = 1,
        plot_unmodified_peptides = FALSE,
        palette = 'Set2',
        plots_per_page = 6)

## ----report_tables, message=FALSE---------------------------------------------

ReportTables(MQCombined,
             log_base = 2,
             intensity_type = 'Intensity')


## ----add_session_info---------------------------------------------------------
sessionInfo()

