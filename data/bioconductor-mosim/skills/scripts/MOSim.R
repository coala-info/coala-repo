# Code example from 'MOSim' vignette. See references/ for full tutorial.

## ----figure1, echo=FALSE, eval=TRUE, warning=FALSE----------------------------
library(ggplot2)
library(gridExtra)

# Define the data for lines
line_data <- data.frame(
  x = c(5, 5, 5, 5, 5),
  xend = c(6, 6, 6, 5.5, 5.5),
  y = c(0, -1.8, -2.7, -4.8, -5.7),
  yend = c(0, -1.2, -3.3, -4.2, -6.3),
  curve = c(FALSE, FALSE, FALSE, TRUE, TRUE)
)

# Create plot
p <- ggplot() +
  geom_segment(data = subset(line_data, !curve),
               aes(x = x, y = y, xend = xend, yend = yend),
               color = "red", size = 1) +
  geom_curve(data = subset(line_data, curve),
             aes(x = x, y = y, xend = xend, yend = yend),
             curvature = 0.5, color = "red", size = 1) +
  annotate("text", x = 0, y = 0, label = "Flat", hjust = 0) +
  annotate("text", x = 0, y = -1.5, label = "Continuous induction (CI)", hjust = 0) +
  annotate("text", x = 0, y = -2.7, label = "Continuous repression (CR)", hjust = 0) +
  annotate("text", x = 0, y = -4.8, label = "Transitory induction (TI)", hjust = 0) +
  annotate("text", x = 0, y = -5.7, label = "Transitory repression (TR)", hjust = 0) +
  theme_void()

# Display the figure
grid.arrange(p)

## ----code, echo=TRUE, eval=FALSE----------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("MOSim")

## ----code1, echo=TRUE, eval=FALSE---------------------------------------------
# library(devtools)
# 
# devtools::install_github("ConesaLab/MOSim")

## ----load, echo=FALSE, eval=TRUE, include=TRUE--------------------------------
library(MOSim)

## ----code2, echo=TRUE, eval=TRUE----------------------------------------------
library(MOSim)

omic_list <- c("RNA-seq")

rnaseq_simulation <- mosim(omics = omic_list)

## ----code3, echo=TRUE, eval=TRUE, include=TRUE--------------------------------
rnaseq_simulation <- mosim(omics = c("RNA-seq"),
                           times = 0,
                           numberGroups = 2,
                           numberReps = 4)

## ----code4, echo=TRUE, eval=FALSE, include=TRUE, error=TRUE-------------------
try({
# rnaseq_simulation <- mosim(omics = c("RNA-seq"),
#                            times = 0,
#                            numberGroups = 1,
#                            numberReps = 4)
})

## ----code5, echo=TRUE, eval=FALSE, include=TRUE-------------------------------
# multi_simulation <- mosim(omics = c("RNA-seq", "DNase-seq"),
#                           times = c(0, 5, 10),
#                           numberGroups = 2,
#                           numberReps = 4,
#                           diffGenes = .3)
# 
# dnase_simulation <- mosim(omics = c("DNase-seq"),
#                           times = c(0, 5, 10),
#                           numberGroups = 2,
#                           numberReps = 4,
#                           diffGenes = .3)

## ----code6, echo=TRUE, eval=TRUE,cache=TRUE, tidy=FALSE, results='hide', message=FALSE----
# Take a subset of the included dataset for illustration
# purposes. We could also load it from a csv file or RData,
# as long as we transform it to have 1 column named "Counts"
# and the identifiers as row names.
data("sampleData")

custom_rnaseq <- head(sampleData$SimRNAseq$data, 100)

# In this case, 'custom_rnaseq' is a data frame with
# the structure:
head(custom_rnaseq)
##                    Counts
## ENSMUSG00000000001   6572
## ENSMUSG00000000003      0
## ENSMUSG00000000028   4644
## ENSMUSG00000000031      8
## ENSMUSG00000000037      0
## ENSMUSG00000000049      0


# The helper 'omicData' returns an object with our custom data.
rnaseq_customdata <- omicData("RNA-seq", data = custom_rnaseq)

# We use the associative list of 'omics' parameter to pass
# the RNA-seq object.
rnaseq_simulation <- mosim(omics = list("RNA-seq" = rnaseq_customdata))

## ----code7, echo=TRUE, eval=TRUE, tidy=FALSE, include=TRUE, results='hide', message=FALSE----
# Select a subset of the available data as a custom dataset
data("sampleData")

custom_dnaseseq <- head(sampleData$SimDNaseseq$data, 100)

# Retrieve a subset of the default association list.
dnase_genes <- sampleData$SimDNaseseq$idToGene
dnase_genes <- dnase_genes[dnase_genes$ID %in%
                               rownames(custom_dnaseseq), ]

# In this case, 'custom_dnaseseq' is a data frame with
# the structure:
head(custom_dnaseseq)
##                       Counts
## 1_63176480_63177113      513
## 1_125435495_125436168   1058
## 1_128319376_128319506     37
## 1_139067124_139067654    235
## 1_152305595_152305752    105
## 1_172490322_172490824    290

# The association list 'dnase_genes' is another data frame
# with the structure:
head(dnase_genes)
##                      ID               Gene
## 29195 1_3670777_3670902 ENSMUSG00000051951
## 29196 1_3873195_3873351 ENSMUSG00000089420
## 29197 1_4332428_4332928 ENSMUSG00000025900
## 29198 1_4346315_4346445 ENSMUSG00000025900
## 29199 1_4416827_4416973 ENSMUSG00000025900
## 29200 1_4516660_4516798 ENSMUSG00000096126

dnaseseq_customdata <- omicData("DNase-seq",
                                data = custom_dnaseseq,
                                associationList = dnase_genes)

multi_simulation <- mosim(omics = list(
    "RNA-seq" = rnaseq_customdata,
    "DNase-seq" = dnaseseq_customdata)
    )

## ----code8, echo=TRUE, eval=TRUE, tidy=FALSE, include = TRUE, results='hide', message=FALSE----
# Select a subset of the available data as a custom dataset
data("sampleData")

custom_tf <- head(sampleData$SimRNAseq$TFtoGene, 100)
#      TF             TFgene         LinkedGene
# 1  Aebp2 ENSMUSG00000030232 ENSMUSG00000000711
# 2  Aebp2 ENSMUSG00000030232 ENSMUSG00000001157
# 3  Aebp2 ENSMUSG00000030232 ENSMUSG00000001211
# 4  Aebp2 ENSMUSG00000030232 ENSMUSG00000001227
# 5  Aebp2 ENSMUSG00000030232 ENSMUSG00000001305
# 6  Aebp2 ENSMUSG00000030232 ENSMUSG00000001794

multi_simulation <- mosim(omics = list(
    "RNA-seq" = rnaseq_customdata,
    "DNase-seq" = dnaseseq_customdata),
    # The option is passed directly to mosim function instead of
    # being an element inside "omics" parameter.
    TFtoGene = custom_tf
    )

## ----code9, echo=TRUE, eval=TRUE, tidy=FALSE, results='hide', message=FALSE----
# Select a subset of the available data as a custom dataset
data("sampleData")

custom_cpgs <- head(sampleData$SimMethylseq$idToGene, 100)

# The ID column will be splitted using the "_" char
# assuming <chr>_<start>_<end>.
#
# These positions will be considered as CpG sites
# and used to generate CpG islands and other elements.
#
# Please refer to MOSim paper for more information.
#
#                    ID               Gene
# 1  11_3101154_3101154 ENSMUSG00000082286
# 2  11_3101170_3101170 ENSMUSG00000082286
# 3  11_3101229_3101229 ENSMUSG00000082286
# 4  11_3101287_3101287 ENSMUSG00000082286
# 5  11_3101329_3101329 ENSMUSG00000082286
# 6  11_3101404_3101404 ENSMUSG00000082286

## ----code10, echo=TRUE, eval=FALSE, tidy = FALSE, results='hide', message=FALSE----
# omic_list <- c("RNA-seq")
# 
# rnaseq_options <- omicSim("RNA-seq", totalFeatures = 2500)
# 
# # The return value is an associative list compatible with
# # 'omicsOptions'
# rnaseq_simulation <- mosim(omics = omic_list,
#                            omicsOptions = rnaseq_options)

## ----code11, echo=TRUE, eval=TRUE, tidy = FALSE, results='hide', message=FALSE----
omics_list <- c("RNA-seq", "DNase-seq")

# In R concatenaning two lists creates another one merging
# its elements, we use that for 'omicsOptions' parameter.
omics_options <- c(omicSim("RNA-seq", totalFeatures = 2500, depth = 74),
                   omicSim("DNase-seq",
                           # Limit the number of features to simulate
                           totalFeatures = 1500,
                           # Modify the percentage of regulators with effects.
                           regulatorEffect = list(
                                'activator' = 0.68,
                                'repressor' = 0.3,
                                'NE' = 0.02
                            )))

set.seed(12345)

multi_simulation <- mosim(omics = omics_list,
                          omicsOptions = omics_options)

## ----code12, echo=TRUE, eval=TRUE, tidy = FALSE, results='hide', message=FALSE----
rnaseq_customdata <- omicData("RNA-seq", data = custom_rnaseq)
rnaseq_options <- omicSim("RNA-seq", totalFeatures = 100)

rnaseq_simulation <- mosim(omics = list("RNA-seq" = rnaseq_customdata),
                           omicsOptions = rnaseq_options)

## ----code13, echo=TRUE, eval=TRUE, tidy = FALSE, results='hide', message=FALSE----
# This will be a data frame with RNA-seq settings (DE flag, profiles)
rnaseq_settings <- omicSettings(multi_simulation, "RNA-seq")

# This will be a list containing all the simulated omics (RNA-seq
# and DNase-seq in this case)
all_settings <- omicSettings(multi_simulation)

## ----table1, echo = FALSE, eval = TRUE, warning = FALSE-----------------------
# Create the data frame
df <- data.frame(
  ID = c("ENSMUSG00000017204", "ENSMUSG00000097082", "ENSMUSG00000055493", 
         "ENSMUSG00000017221", "ENSMUSG00000020205", "ENSMUSG00000087802"),
  DE = c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE),
  Group1 = c("transitory.induction", "transitory.induction", "transitory.induction", 
             "transitory.induction", "transitory.induction", "flat"),
  Group2 = c("continuous.repression", "transitory.induction", "continuous.repression", 
             "continuous.induction", "continuous.induction", "flat"),
  Tmax_Group1 = c(2.57, 1.46, 2.37, 2.63, 2.83, NA),
  Tmax_Group2 = c(NA, 2.23, NA, NA, NA, NA)
)

# Generate the table
print(df, row.names = FALSE)

## ----table2, echo = FALSE, eval = TRUE, warning = FALSE-----------------------
df <- data.frame(
  ID = c("10_111588324_111588448", "10_111588324_111588448", 
         "10_11358301_11358431", "10_11358301_11358431", 
         "11_98682094_98682786", "11_98682094_98682786"),
  Gene = c("ENSMUSG00000097082", "ENSMUSG00000020205", 
           "ENSMUSG00000055493", "ENSMUSG00000087802", 
           "ENSMUSG00000017204", "ENSMUSG00000017221"),
  Effect_Group1 = c("activator", "activator", "activator", "NA", "repressor", "repressor"),
  Effect_Group2 = c("activator", "NA", "activator", "NA", "activator", "repressor"),
  Group1 = c("transitory.induction", "transitory.induction", 
             "transitory.induction", "transitory.induction", 
             "transitory.repression", "transitory.repression"),
  Group2 = c("transitory.induction", "transitory.induction", 
             "continuous.repression", "continuous.repression", 
             "continuous.repression", "continuous.repression"),
  Extra = rep("...", 6) # Placeholder for extra columns
)

# Print the table in a readable format
print(df, row.names = FALSE)

## ----code14, echo=TRUE, eval=TRUE, tidy=FALSE, results='hide', message=FALSE----
# This will be a list with 3 keys: settings, association and regulators
dnase_settings <- omicSettings(multi_simulation, "DNase-seq",
                               association = TRUE)

## ----code15, echo=TRUE, eval=TRUE, tidy = FALSE, results='hide', message=FALSE----
# multi_simulation is an object returned by mosim function.

# This will be a data frame with RNA-seq counts
rnaseq_simulated <- omicResults(multi_simulation, "RNA-seq")

#                    Group1.Time0.Rep1 Group1.Time0.Rep2 Group1.Time0.Rep3 ...
# ENSMUSG00000073155              4539              5374              5808 ...
# ENSMUSG00000026251                 0                 0                 0 ...
# ENSMUSG00000040472              2742              2714              2912 ...
# ENSMUSG00000021598              5256              4640              5130 ...
# ENSMUSG00000032348               421               348               492 ...
# ENSMUSG00000097226                16                14                 9 ...
# ENSMUSG00000027857                 0                 0                 0 ...
# ENSMUSG00000032081                 1                 0                 0 ...
# ENSMUSG00000097164               794               822               965 ...
# ENSMUSG00000097871                 0                 0                 0 ...

# This will be a list containing RNA-seq and DNase-seq counts
all_simulated <- omicResults(multi_simulation)

## ----code16, echo=TRUE, eval=TRUE, tidy = FALSE, results = "hide", message=FALSE, warning=FALSE----
# Generate a simulation object
omic_list <- c("RNA-seq")
rnaseq_simulation <- mosim(omics = omic_list)

# This will be a data frame with RNA-seq counts
design_matrix <- experimentalDesign(rnaseq_simulation)
design_matrix

## ----code17, echo=TRUE, eval=FALSE, tidy = FALSE, results = "hide", message=FALSE, warning=FALSE----
# 
# # The methods returns a ggplot plot, if called directly
# # it will be automatically plotted.
# plotProfile(multi_simulation,
#             omics = c("RNA-seq", "DNase-seq"),
#             featureIDS = list(
#                 "RNA-seq" = "ENSMUSG00000024691",
#                 "DNase-seq" = "19_12574278_12574408"
#             ))

## ----code18, echo=TRUE, eval=FALSE, tidy = FALSE, results = "hide", message=FALSE, warning=FALSE----
# library(ggplot2)
# 
# # Store the plot in a variable
# profile_plot <- plotProfile(multi_simulation,
#             omics = c("RNA-seq", "DNase-seq"),
#             featureIDS = list(
#                 "RNA-seq" = "ENSMUSG00000024691",
#                 "DNase-seq" = "19_12574278_12574408"
#             ))
# 
# # Modify the title and print
# profile_plot +
#     ggtitle("My custom title") +
#     theme_bw() +
#     theme(legend.position="top")

## ----code19, echo=TRUE, eval=TRUE, tidy = FALSE, results = "hide", message=FALSE, warning=FALSE----
rnaseq_simulation <- mosim(omics = c("RNA-seq", "ChIP-seq"))
rnaseq_simulated <- omicResults(rnaseq_simulation, c("RNA-seq", "ChIP-seq"))
discrete_ChIP <- discretize(rnaseq_simulated, "ChIP-seq")

