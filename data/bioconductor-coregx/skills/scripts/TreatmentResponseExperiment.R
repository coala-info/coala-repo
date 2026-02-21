# Code example from 'TreatmentResponseExperiment' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
library(formatR)
knitr::opts_chunk$set(echo=FALSE)

## ----dependencies, include=FALSE----------------------------------------------
library(CoreGx)
library(data.table)

## ----class_diagram, fig.wide=TRUE, caption='LongTable Class Diagram'----------
knitr::include_graphics('TreatmentResponseExperimentClassDiagram.drawio.png')

## ----tre_structure, fig.wide=TRUE, caption='TreatmentResponseExperiment Structure'----
knitr::include_graphics('TreatmentResponseExperimentStructure.drawio.png')

## ----head_data, echo=TRUE-----------------------------------------------------
filePath <- system.file('extdata', 'merckLongTable.csv', package='CoreGx',
  mustWork=TRUE)
merckDT <- fread(filePath, na.strings=c('NULL'))
colnames(merckDT)

## ----sample_data, fig.width=80------------------------------------------------
knitr::kable(head(merckDT)[, 1:5])

## ----sample_data2, fig.width=80-----------------------------------------------
knitr::kable(head(merckDT)[, 5:ncol(merckDT)])

## ----guess_mapping, echo=TRUE-------------------------------------------------
# Our guesses of how we may identify rows, columns and assays
groups <- list(
  justDrugs=c('drug1id', 'drug2id'),
  drugsAndDoses=c('drug1id', 'drug2id', 'drug1dose', 'drug2dose'),
  justCells=c('cellid'),
  cellsAndBatches=c('cellid', 'batchid'),
  assays1=c('drug1id', 'drug2id', 'cellid'),
  assays2=c('drug1id', 'drug2id', 'drug1dose', 'drug2dose', 'cellid', 'batchid')
)

# Decide if we want to subset out mapped columns after each group
subsets <- c(FALSE, TRUE, FALSE, TRUE, FALSE, TRUE)

# First we put our data in the `TRE`
TREdataMapper <- TREDataMapper(rawdata=merckDT)

# Then we can test our hypotheses, subset=FALSE means we don't remove mapped
#   columns after each group is mapped
guess <- guessMapping(TREdataMapper, groups=groups, subset=subsets)
guess

## ----mappings_to_datamapper, echo=TRUE----------------------------------------
rowDataMap(TREdataMapper) <- guess$drugsAndDose
colDataMap(TREdataMapper) <- guess$cellsAndBatches

## ----split_assays, echo=TRUE--------------------------------------------------
assays <- list(
  sensitivity=list(
    guess$assays2[[1]],
    guess$assays2[[2]][seq_len(4)]
  ),
  profiles=list(
    guess$assays2[[1]],
    guess$assays2[[2]][c(5, 6)]
  )
)
assays

## ----assign_assaymap, echo=TRUE-----------------------------------------------
assayMap(TREdataMapper) <- assays

## ----echo=TRUE----------------------------------------------------------------
tre <- metaConstruct(TREdataMapper)

## ----rownames, echo=TRUE------------------------------------------------------
head(rownames(tre))

## ----colnames, echo=TRUE------------------------------------------------------
head(colnames(tre))

## ----subset_dataframe_character, echo=TRUE------------------------------------
row <- rownames(tre)[1]
columns <- colnames(tre)[1:2]
tre[row, columns]

## ----rowdata_coldata, echo=TRUE-----------------------------------------------
head(rowData(tre), 3)
head(colData(tre), 3)

## ----simple_regex, echo=TRUE--------------------------------------------------
tre['5-FU', ]

## ----column_specific_regex, echo=TRUE-----------------------------------------
all.equal(tre['5-FU:*:*:*', ], tre['^5-FU',  ])

## ----echo=TRUE----------------------------------------------------------------
tre[
    # row query
    .(drug1id == 'Temozolomide' & drug2id %in% c('Lapatinib', 'Bortezomib')),
    .(cellid == 'CAOV3') # column query
]

## ----echo=TRUE----------------------------------------------------------------
subTRE <- tre[
  .(drug1id == 'Temozolomide' & drug2id != 'Lapatinib'),
  .(batchid != 2)
]

## ----echo=TRUE----------------------------------------------------------------
print(paste0('drug2id: ', paste0(unique(rowData(subTRE)$drug2id),
    collapse=', ')))
print(paste0('batchid: ', paste0(unique(colData(subTRE)$batchid),
    collapse=', ')))

## ----echo=TRUE----------------------------------------------------------------
head(rowData(tre), 3)

## ----echo=TRUE----------------------------------------------------------------
head(rowData(tre, key=TRUE), 3)

## ----echo=TRUE----------------------------------------------------------------
head(colData(tre), 3)

## ----echo=TRUE----------------------------------------------------------------
head(colData(tre, key=TRUE), 3)

## ----echo=TRUE----------------------------------------------------------------
assays <- assays(tre)
assays[[1]]

## ----echo=TRUE----------------------------------------------------------------
assays[[2]]

## ----echo=TRUE----------------------------------------------------------------
assays <- assays(tre, withDimnames=TRUE)
colnames(assays[[1]])

## ----echo=TRUE----------------------------------------------------------------
assays <- assays(tre, withDimnames=TRUE, metadata=TRUE)
colnames(assays[[2]])

## ----echo=TRUE----------------------------------------------------------------
assayNames(tre)

## ----echo=TRUE----------------------------------------------------------------
colnames(assay(tre, 'sensitivity'))
assay(tre, 'sensitivity')

## ----echo=TRUE----------------------------------------------------------------
colnames(assay(tre, 'sensitivity', withDimnames=TRUE))
assay(tre, 'sensitivity', withDimnames=TRUE)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

