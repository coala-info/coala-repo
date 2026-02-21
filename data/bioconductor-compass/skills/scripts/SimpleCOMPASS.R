# Code example from 'SimpleCOMPASS' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
options(tinytex.verbose = TRUE)

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----install_readxl, eval=FALSE-----------------------------------------------
# library(BiocManager)
# # install.packages("readxl")

## ----load_readxl--------------------------------------------------------------
library(COMPASS)
# library(readxl)

## ----find_data----------------------------------------------------------------
# retrieve the path to the data file in the package installation directory
example_data_path = 
  system.file("extdata",
              "SimpleCOMPASSExamples.csv",
              package = "COMPASS")

## ----load_data----------------------------------------------------------------
compass_data = read.csv(example_data_path, check.names=FALSE)

## ----glimpse------------------------------------------------------------------
dim(compass_data)
colnames(compass_data)[1:5]

## -----------------------------------------------------------------------------
metadata = compass_data[,2:4]
metadata = as.data.frame(metadata)

## -----------------------------------------------------------------------------
# Take the remaining columns
counts = as.matrix(compass_data[,5:261])
dim(counts) 
# NOTE that we still have too many columns. 
# We should have 256, not 257.
# We'll fix this. The first column is the total. We'd need this for COMPASS, but not for SimpleCOMPASS.

# drop the total count
counts = counts[,-1L] 
dim(counts)

## ----split_counts-------------------------------------------------------------
unique(metadata$Stimulation)

# Which entries have the typos
typos = which(metadata$Stimulation=="UnStimulated")

#Correct them
metadata$Stimulation[typos] = "Unstimulated"
# Better
unique(metadata$Stimulation)

# old school R 
n_u = subset(counts, metadata$Stimulation == "Unstimulated")
n_s = subset(counts, metadata$Stimulation == "ESAT6/CFP10")

## ----unique_id----------------------------------------------------------------
metadata$unique_id = metadata$`PATIENT ID`

## -----------------------------------------------------------------------------
# assign consistent row names to n_u and n_s
rownames(n_u) = subset(metadata$unique_id,
       metadata$Stimulation=="Unstimulated")

rownames(n_s) = subset(metadata$unique_id,
       metadata$Stimulation=="ESAT6/CFP10")

# Now all matrices have the same dimensions and appropriate rownames
metadata = subset(metadata,
       metadata$Stimulation=="ESAT6/CFP10")

## -----------------------------------------------------------------------------
colnames(n_s)[1]

## -----------------------------------------------------------------------------
# remove the path
nms = basename(colnames(n_s))
# translate the marker names to a COMPASS compatible format.
nms = COMPASS:::translate_marker_names(nms)
sample(nms,2)
colnames(n_s) = nms

nms = basename(colnames(n_u))
# translate the marker names to a COMPASS compatible format.
nms = COMPASS:::translate_marker_names(nms)
sample(nms,2)
colnames(n_u) = nms

## ----rename_markers-----------------------------------------------------------
#2 to IL2
colnames(n_s) = gsub("([&!])2([&!])","\\1IL2\\2",colnames(n_s))
#10 to IL10
colnames(n_s) = gsub("([&!])10([&!])","\\1IL10\\2",colnames(n_s))
# 17A to IL17A
colnames(n_s) = gsub("([&!])17A([&!])","\\1IL17A\\2",colnames(n_s))

# 17F to IL17F
colnames(n_s) = gsub("([&!])17F([&!])","\\1IL17F\\2",colnames(n_s))

# 22 to IL22
colnames(n_s) = gsub("([&!])22([&!])","\\1IL22\\2",colnames(n_s))


## ----rename_function----------------------------------------------------------
rename_cytokines = function(nms){
  #2 to IL2
  nms = gsub("([&!])2([&!])", 
       "\\1IL2\\2", nms)
  #10 to IL10
   nms = gsub("([&!])10([&!])",
        "\\1IL10\\2", nms)
  # 17A to IL17A
 nms = gsub("([&!])17A([&!])", 
      "\\1IL17A\\2", nms)
  # 17F to IL17F
 nms = gsub("([&!])17F([&!])", 
      "\\1IL17F\\2", nms)
 # 22 to IL22
 nms = gsub("([&!])22([&!])", 
      "\\1IL22\\2", nms)
}

## ----rename_markers_with_function---------------------------------------------
colnames(n_s) = rename_cytokines(colnames(n_s))
colnames(n_u) = rename_cytokines(colnames(n_u))

## -----------------------------------------------------------------------------
colnames(n_s)[ncol(n_s)]
colnames(n_u)[ncol(n_u)]

## -----------------------------------------------------------------------------
args(COMPASS::SimpleCOMPASS)

## ----fit_model, cache = TRUE--------------------------------------------------
fit = COMPASS::SimpleCOMPASS(n_s = n_s,
                       n_u = n_u, 
                       meta = metadata,
                       individual_id = "unique_id",
                       iterations = 1000,
                       replications = 3)

## ----scores-------------------------------------------------------------------
library(ggplot2)
library(dplyr)
scores(fit) %>%
  ggplot() + 
  geom_boxplot(outlier.colour = NA) +
  geom_jitter() +
  aes(y = FS, x = GROUP)

## -----------------------------------------------------------------------------
plot(fit,"GROUP")

