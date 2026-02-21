# Code example from 'vignettes' vignette. See references/ for full tutorial.

## ----include = TRUE, echo = FALSE, message = FALSE, warning = FALSE-----------
library(OMICsPCAdata)
library(kableExtra)
library(rmarkdown)
library(knitr)
library(MultiAssayExperiment)

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
collapse = TRUE,
comment = "#",
eval = TRUE
)


## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.pos = 'H')

## ----echo = FALSE-------------------------------------------------------------
datalist <- data(package = "OMICsPCAdata")
datanames <- datalist$results[,3]
data(list = datanames)
assays <- assays(multi_assay)

## ----echo =FALSE--------------------------------------------------------------
data_summary = data.frame(
Name = c(
"CAGE" ,"H2az" ,"H3k9ac",
"H3k4me1"),

Type_of_Assay = c(
"Expression of Transcription Start Sites(TSS)",
"location of Histone modification peaks",
"location of Histone modification peaks",
"location of Histone modification peaks"
),

No_of_Cell_lines =c(
ncol(assays$CAGE),
ncol(assays$H2az),
ncol(assays$H3k9ac),
ncol(assays$H3k4me1)
),

Name_of_Cell_lines = c(
paste(names(assays$CAGE), collapse = " ,"),
paste(names(assays$H2az), collapse = " ,"),
paste(names(assays$H3k9ac), collapse = " ,"),
paste(names(assays$H3k4me1), collapse = " ,")
),

Type_of_data = c(
"Cap Analysis\nof\nGene Expression",
"ChIP-seq",
"ChIP-seq",
"ChIP-seq"
)
)
names(data_summary) <- c("Assay", "Assay\nType", "Number of\nCell lines",
"Name of\ncell lines", "Experiment")

## ----eval = TRUE, echo=FALSE, results='asis'----------------------------------
#for html
knitr::kable(data_summary, caption = "Summary of data sets", align = 'c') %>% 
kable_styling("bordered",full_width = FALSE, position = "center") %>%
column_spec(1, bold = FALSE, border_right = FALSE,
border_left = FALSE, width = "5em") %>%
column_spec(2, bold = FALSE, border_right = FALSE,
border_left = FALSE, width = "5em") %>%
column_spec(3, border_right = FALSE, width = "4em") %>%
column_spec(4, border_right = FALSE, width = "23em") %>%
column_spec(5, border_right = FALSE, width = "5em")

## -----------------------------------------------------------------------------
# The CAGE data set contains normalized CAGE data of 28770 GENCODE
#TSS groups in from 31 cell lines

dim(assays$CAGE)

# Let's look at the first five rows and columns of this dataset
head(assays$CAGE[1:5,1:5])

