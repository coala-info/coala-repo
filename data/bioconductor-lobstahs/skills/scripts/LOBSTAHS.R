# Code example from 'LOBSTAHS' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("xcms")
# BiocManager::install("CAMERA")

## ----eval = FALSE-------------------------------------------------------------
# install.packages("devtools")

## ----eval = FALSE-------------------------------------------------------------
# library("devtools")
# install_github("vanmooylipidomics/LOBSTAHS", build_vignettes = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# ## install dataset 'PtH2O2lipids'
# ## see LOBSTAHS documentation for examples
# 
# install_github("vanmooylipidomics/PtH2O2lipids")

## ----eval = FALSE-------------------------------------------------------------
# system(paste("msconvert Exactive_data.raw --mzXML --filter \"peakPicking true 1-\" -o mzXML_ms1_two_mode -v"))

## ----eval = FALSE-------------------------------------------------------------
# system(paste("msconvert mzXML_ms1_two_mode/Exactive_data.mzXML --mzXML --filter \"polarity positive\" -o mzXML_ms1_pos_mode -v"))
# system(paste("msconvert mzXML_ms1_two_mode/Exactive_data.mzXML --mzXML --filter \"polarity negative\" -o mzXML_ms1_neg_mode -v"))

## ----warning = FALSE, message = FALSE, eval = FALSE---------------------------
# library(xcms)
# library(CAMERA)
# library(LOBSTAHS)
# 
# # first, a necessary workaround to avoid a import error; see
# # https://support.bioconductor.org/p/69414/
# 
# imports = parent.env(getNamespace("CAMERA"))
# unlockBinding("groups", imports)
# imports[["groups"]] = xcms::groups
# lockBinding("groups", imports)
# 
# # create annotated xset using wrapper annotate(), allowing us to perform all
# # CAMERA tasks at once
# 
# xsA = annotate(ptH2O2lipids$xsAnnotate@xcmsSet,
# 
#                quick=FALSE,
#                sample=NA, # use all samples
#                nSlaves=1, # set to number of available cores or processors if
#                           # > 1
# 
#                # group FWHM settings (defaults)
# 
#                sigma=6,
#                perfwhm=0.6,
# 
#                # groupCorr settings (defaults)
# 
#                cor_eic_th=0.75,
#                graphMethod="hcs",
#                pval=0.05,
#                calcCiS=TRUE,
#                calcIso=TRUE,
#                calcCaS=FALSE,
# 
#                # findIsotopes settings
# 
#                maxcharge=4,
#                maxiso=4,
#                minfrac=0.5,
# 
#                # adduct annotation settings
# 
#                psg_list=NULL,
#                rules=NULL,
#                polarity="positive", # the PtH2O2lipids xcmsSet contains
#                                     # positive-mode data
#                multiplier=3,
#                max_peaks=100,
# 
#                # common to multiple tasks
# 
#                intval="into",
#                ppm=2.5,
#                mzabs=0.0015
# 
#                )
# #> Start grouping after retention time.
# #> Created 113 pseudospectra.
# #> Generating peak matrix!
# #> Run isotope peak annotation
# #>  % finished: 10  20  30  40  50  60  70  80  90  100
# #> Found isotopes: 5692
# #> Start grouping after correlation.
# #> Generating EIC's ..
# #>
# #> Calculating peak correlations in 113 Groups...
# #>  % finished: 10  20  30  40  50  60  70  80  90  100
# #>
# #> Calculating isotope assignments in 113 Groups...
# #>  % finished: 10  20  30  40  50  60  70  80  90  100
# #> Calculating graph cross linking in 113 Groups...
# #>  % finished: 10  20  30  40  50  60  70  80  90  100
# #> New number of ps-groups:  5080
# #> xsAnnotate has now 5080 groups, instead of 113
# #> Generating peak matrix for peak annotation!
# #>
# #> Calculating possible adducts in 5080 Groups...
# #>  % finished: 10  20  30  40  50  60  70  80  90  100

## ----warning = FALSE, message = FALSE-----------------------------------------
library(LOBSTAHS)
data(default.LOBdbase)

default.LOBdbase$positive # default positive mode database

default.LOBdbase$negative # default negative mode database

## ----warning = FALSE, message = FALSE, eval = FALSE---------------------------
# data(default.acylRanges)
# data(default.oxyRanges)
# data(default.componentCompTable)
# data(default.adductHierarchies)

## ----eval = FALSE-------------------------------------------------------------
# LOBdb = generateLOBdbase(polarity = c("positive","negative"), gen.csv = FALSE,
#                  component.defs = NULL, AIH.defs = NULL, acyl.ranges = NULL,
#                  oxy.ranges = NULL)
# 

## ----eval = FALSE-------------------------------------------------------------
# data(default.rt.windows)

## ----eval = FALSE-------------------------------------------------------------
# myPtH2O2LOBSet = doLOBscreen(ptH2O2lipids$xsAnnotate, polarity = "positive",
#                              database = NULL, remove.iso = TRUE,
#                              rt.restrict =  TRUE, rt.windows = NULL,
#                              exclude.oddFA = TRUE, match.ppm = 2.5,
#                              retain.unidentified = FALSE)

## ----warning = FALSE, message = FALSE, eval = FALSE---------------------------
# ptH2O2lipids$LOBSet
# #> A positive polarity "LOBSet" containing LC-MS peak data. Compound assignments
# #> and adduct ion hierarchy screening annotations applied to 16 samples using the
# #> "LOBSTAHS" package.
# #>
# #> No. individual peaks with LOBSTAHS compound assignments: 21869
# #> No. peak groups with LOBSTAHS compound assignments: 1595
# #> No. LOBSTAHS compound assignments: 1969
# #> m/z range of features identified using LOBSTAHS: 551.425088845409-1269.09515435315
# #>
# #> Identified peak groups having possible regisomers: 556
# #> Identified peak groups having possible structural functional isomers: 375
# #> Identified peak groups having isobars indistinguishable within ppm matching
# #>  tolerance: 84
# #>
# #> Restrictions applied prior to conducting adduct ion hierarchy screening:
# #>  remove.iso, rt.restrict, exclude.oddFA
# #>
# #> Match tolerance used for LOBSTAHS database assignments: 2.5 ppm
# #>
# #> Memory usage: 1.26 MB

## ----warning = FALSE, message = FALSE, eval = FALSE---------------------------
# LOBscreen_diagnostics(ptH2O2lipids$LOBSet)
# #>                     peakgroups  peaks assignments parent_compounds
# #> initial                  18314 251545          NA               NA
# #> post_remove_iso          12146 163938          NA               NA
# #> initial_assignments       5077  67862       15929            14076
# #> post_rt_restrict          4451  60070       13504            11779
# #> post_exclude_oddFA        3871  52337        7458             6283
# #> post_AIHscreen            1595  21869        2056             1969

## ----warning = FALSE, message = FALSE, eval = FALSE---------------------------
# LOBisoID_diagnostics(ptH2O2lipids$LOBSet)
# #>                      peakgroups parent_compounds assignments features
# #> C3r_regio.iso               556              352         750     7591
# #> C3f_funct.struct.iso        375              577         752     5057
# #> C3c_isobars                  84              162         195     1137

