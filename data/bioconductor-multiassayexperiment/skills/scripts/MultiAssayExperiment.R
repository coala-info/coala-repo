# Code example from 'MultiAssayExperiment' vignette. See references/ for full tutorial.

## ----install, eval = FALSE----------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("MultiAssayExperiment")

## ----load_packages, include=TRUE, results="hide", message=FALSE, warning=FALSE----
library(MultiAssayExperiment)
library(GenomicRanges)
library(SummarizedExperiment)
library(RaggedExperiment)

## ----empty_mae_creation-------------------------------------------------------
empty <- MultiAssayExperiment()
empty
slotNames(empty)

## ----include_graphics---------------------------------------------------------
knitr::include_graphics("MultiAssayExperiment.png")

## ----experiment_list_class----------------------------------------------------
class(experiments(empty)) # ExperimentList

## ----patient_data_creation----------------------------------------------------
patient.data <- data.frame(sex=c("M", "F", "M", "F"),
    age=38:41,
    row.names=c("Jack", "Jill", "Bob", "Barbara"))
patient.data

## ----sample_map_dataframe-----------------------------------------------------
is(sampleMap(empty), "DataFrame") # TRUE

## ----simpleMultiAssay_creation------------------------------------------------
exprss1 <- matrix(rnorm(16), ncol = 4,
        dimnames = list(sprintf("ENST00000%i", sample(288754:290000, 4)),
                c("Jack", "Jill", "Bob", "Bobby")))
exprss2 <- matrix(rnorm(12), ncol = 3,
        dimnames = list(sprintf("ENST00000%i", sample(288754:290000, 4)),
                c("Jack", "Jane", "Bob")))
doubleExp <- list("methyl 2k"  = exprss1, "methyl 3k" = exprss2)
simpleMultiAssay <- MultiAssayExperiment(experiments=doubleExp)
simpleMultiAssay

## ----colData_empty------------------------------------------------------------
colData(simpleMultiAssay)

## ----simpleMultiAssay2_creation-----------------------------------------------
simpleMultiAssay2 <- MultiAssayExperiment(experiments=doubleExp,
                                          colData=patient.data)
simpleMultiAssay2
colData(simpleMultiAssay2)

## ----empty_metadata-----------------------------------------------------------
class(metadata(empty)) # NULL (class "ANY")

## ----experiment_list_metadata-------------------------------------------------
metadata(experiments(empty))

## ----make_exprdat, message=FALSE----------------------------------------------
(arraydat <- matrix(seq(101, 108), ncol=4,
    dimnames=list(c("ENST00000294241", "ENST00000355076"),
    c("array1", "array2", "array3", "array4"))))

coldat <- data.frame(slope53=rnorm(4),
    row.names=c("array1", "array2", "array3", "array4"))

exprdat <- SummarizedExperiment(arraydat, colData=coldat)
exprdat

## ----make_exprmap-------------------------------------------------------------
(exprmap <- data.frame(primary=rownames(patient.data)[c(1, 2, 4, 3)],
                       colname=c("array1", "array2", "array3", "array4"),
                       stringsAsFactors = FALSE))

## ----make_methyldat-----------------------------------------------------------
(methyldat <-
   matrix(1:10, ncol=5,
          dimnames=list(c("ENST00000355076", "ENST00000383706"),
                        c("methyl1", "methyl2", "methyl3",
                          "methyl4", "methyl5"))))

## ----make_methylmap-----------------------------------------------------------
(methylmap <- data.frame(primary = c("Jack", "Jack", "Jill", "Barbara", "Bob"),
    colname = c("methyl1", "methyl2", "methyl3", "methyl4", "methyl5"),
    stringsAsFactors = FALSE))

## ----make_microdat------------------------------------------------------------
(microdat <- matrix(201:212, ncol=3,
                    dimnames=list(c("hsa-miR-21", "hsa-miR-191",
                                    "hsa-miR-148a", "hsa-miR148b"),
                                  c("micro1", "micro2", "micro3"))))

## ----make_micromap------------------------------------------------------------
(micromap <- data.frame(primary = c("Jack", "Barbara", "Bob"),
    colname = c("micro1", "micro2", "micro3"), stringsAsFactors = FALSE))

## ----make_rse-----------------------------------------------------------------
nrows <- 5
ncols <- 4
counts <- matrix(runif(nrows * ncols, 1, 1e4), nrows)
rowRanges <- GRanges(rep(c("chr1", "chr2"), c(2, nrows - 2)),
    IRanges(floor(runif(nrows, 1e5, 1e6)), width=100),
    strand=sample(c("+", "-"), nrows, TRUE),
    feature_id=sprintf("ID\\%03d", 1:nrows))
names(rowRanges) <- letters[1:5]
colData <- DataFrame(Treatment=rep(c("ChIP", "Input"), 2),
    row.names= c("mysnparray1", "mysnparray2", "mysnparray3", "mysnparray4"))
rse <- SummarizedExperiment(assays=SimpleList(counts=counts),
    rowRanges=rowRanges, colData=colData)

## ----make_rangemap------------------------------------------------------------
(rangemap <-
    data.frame(primary = c("Jack", "Jill", "Bob", "Barbara"),
    colname = c("mysnparray1", "mysnparray2", "mysnparray3", "mysnparray4"),
        stringsAsFactors = FALSE))

## ----create_listmap-----------------------------------------------------------
listmap <- list(exprmap, methylmap, micromap, rangemap)
names(listmap) <- c("Affy", "Methyl 450k", "Mirna", "CNV gistic")
listmap

## ----listToMap_example--------------------------------------------------------
dfmap <- listToMap(listmap)
dfmap

## ----mapToList_example, eval=FALSE--------------------------------------------
# mapToList(dfmap, "assay")

## ----objlist_creation---------------------------------------------------------
objlist <- list("Affy" = exprdat, "Methyl 450k" = methyldat,
    "Mirna" = microdat, "CNV gistic" = rse)

## ----multi_assay_creation-----------------------------------------------------
myMultiAssay <- MultiAssayExperiment(objlist, patient.data, dfmap)
myMultiAssay

## ----multi_assay_extractors---------------------------------------------------
experiments(myMultiAssay)
colData(myMultiAssay)
sampleMap(myMultiAssay)
metadata(myMultiAssay)

## ----prepMultiAssay_example---------------------------------------------------
objlist3 <- objlist
(names(objlist3) <- NULL)

try(prepMultiAssay(objlist3, patient.data, dfmap)$experiments,
    outFile = stdout())

## ----prepMultiAssay_case_example----------------------------------------------
names(objlist3) <- toupper(names(objlist))
names(objlist3)
unique(dfmap[, "assay"])
prepMultiAssay(objlist3, patient.data, dfmap)$experiments

## ----sampleMap_example--------------------------------------------------------
exampleMap <- sampleMap(simpleMultiAssay2)
sapply(doubleExp, colnames)
exampleMap
prepMultiAssay(doubleExp, patient.data, exampleMap)$metadata$drops

## ----add_row_to_sampleMap-----------------------------------------------------
exMap <- rbind(dfmap,
    DataFrame(assay = "New methyl", primary = "Joe",
        colname = "Joe"))
invisible(prepMultiAssay(objlist, patient.data, exMap))

## ----prepMultiAssay_to_MAE----------------------------------------------------
prepped <- prepMultiAssay(objlist, patient.data, exMap)
preppedMulti <- MultiAssayExperiment(prepped$experiments, prepped$colData,
    prepped$sampleMap, prepped$metadata)
preppedMulti

## ----prepMultiAssay_do_call---------------------------------------------------
do.call(MultiAssayExperiment, prepped)

## ----make_grl_example---------------------------------------------------------
grlls <- list(chr = rep("chr1", nrows), start = seq(11, 15),
    end = seq(12, 16), strand = c("+", "-", "+", "*", "*"),
    score = seq(1, 5), specimen = c("a", "a", "b", "b", "c"),
    gene_symbols = paste0("GENE", letters[seq_len(nrows)]))

grldf <- as.data.frame(grlls, stringsAsFactors = FALSE)

GRL <- makeGRangesListFromDataFrame(grldf, split.field = "specimen",
    names.field = "gene_symbols")

## ----as_ragged_experiment-----------------------------------------------------
RaggedExperiment(GRL)

## ----make_sedf_example--------------------------------------------------------
sels <- list(chr = rep("chr2", nrows), start = seq(11, 15),
    end = seq(12, 16), strand = c("+", "-", "+", "*", "*"),
    expr0 = seq(3, 7), expr1 = seq(8, 12), expr2 = seq(12, 16))
sedf <- as.data.frame(sels,
    row.names = paste0("GENE", letters[rev(seq_len(nrows))]),
    stringsAsFactors = FALSE)
sedf
makeSummarizedExperimentFromDataFrame(sedf)

## ----pseudo_subset, eval=FALSE------------------------------------------------
# myMultiAssay[rows, columns, assays]

## ----subset_by_rownames-------------------------------------------------------
myMultiAssay["ENST00000355076", , ]

## ----subset_by_rows_columns_assays--------------------------------------------
myMultiAssay["ENST00000355076", 1:2, c("Affy", "Methyl 450k")]

## ----subset_by_columns--------------------------------------------------------
myMultiAssay[, "Jack", ]
myMultiAssay[, 1, ]
myMultiAssay[, c(TRUE, FALSE, FALSE, FALSE), ]

## ----subset_by_assays---------------------------------------------------------
myMultiAssay[, , "Mirna"]
myMultiAssay[, , 3]
myMultiAssay[, , c(FALSE, FALSE, TRUE, FALSE, FALSE)]

## ----subset_by_drop-----------------------------------------------------------
myMultiAssay["ENST00000355076", , , drop=FALSE]

## ----subset_by_drop_true------------------------------------------------------
myMultiAssay["ENST00000355076", , , drop=TRUE]

## ----colata_example-----------------------------------------------------------
colData(myMultiAssay)

## ----subset_by_coldata--------------------------------------------------------
myMultiAssay[, 1:2]

## ----subset_by_coldata_logical------------------------------------------------
malesMultiAssay <- myMultiAssay[, myMultiAssay$sex == "M"]
colData(malesMultiAssay)

## ----subset_by_coldata_list---------------------------------------------------
allsamples <- colnames(myMultiAssay)
allsamples

## ----subset_by_coldata_list_remove--------------------------------------------
allsamples[["Methyl 450k"]] <- allsamples[["Methyl 450k"]][-3:-5]
myMultiAssay[, as.list(allsamples), ]
subsetByColumn(myMultiAssay,  as.list(allsamples))  #equivalent

## ----subset_by_assays_char----------------------------------------------------
myMultiAssay[, , c("Affy", "CNV gistic")]

## ----subset_by_assays_logical-------------------------------------------------
is.cnv <- grepl("CNV", names(experiments(myMultiAssay)))
is.cnv
myMultiAssay[, , is.cnv]  #logical subsetting
myMultiAssay[, , which(is.cnv)] #integer subsetting

## ----subset_by_row_list-------------------------------------------------------
myMultiAssay[list(Mirna = 1:2), , ]
## equivalently
subsetByRow(myMultiAssay, list(Mirna = 1:2))

## ----subset_by_row_id---------------------------------------------------------
featSub0 <- subsetByRow(myMultiAssay, "ENST00000355076")
featSub1 <- myMultiAssay["ENST00000355076", , drop = FALSE] #equivalent
all.equal(featSub0, featSub1)
class(featSub1)
class(experiments(featSub1))
experiments(featSub1)

## ----subset_by_row_id2--------------------------------------------------------
featSubsetted <-
  subsetByRow(myMultiAssay, c("ENST00000355076", "ENST00000294241"))
assay(myMultiAssay, 1L)
assay(featSubsetted, 1L)

## ----subset_by_granges--------------------------------------------------------
gr <- GRanges(seqnames = c("chr1", "chr1", "chr2"), strand = c("-", "+", "+"),
              ranges = IRanges(start = c(230602, 443625, 934533),
                               end = c(330701, 443724, 934632)))

## ----subset_by_granges2-------------------------------------------------------
subsetted <- subsetByRow(myMultiAssay, gr, maxgap = 2L, type = "within")
experiments(subsetted)
rowRanges(subsetted[[4]])

## ----double_bracket_subset----------------------------------------------------
names(myMultiAssay)
myMultiAssay[[1]]
myMultiAssay[["Affy"]]

## ----complete_cases_example---------------------------------------------------
colData(myMultiAssay)

## ----complete.cases_all-------------------------------------------------------
complete.cases(myMultiAssay)

## ----complete.cases_affy_methyl-----------------------------------------------
complete.cases(myMultiAssay[, , 1:2])

## ----complete_cases_subset----------------------------------------------------
myMultiAssay[, complete.cases(myMultiAssay), ]

## ----replicated_example-------------------------------------------------------
replicated(myMultiAssay)

## ----intersectRows_example----------------------------------------------------
(ensmblMatches <- intersectRows(myMultiAssay[, , 1:2]))
rownames(ensmblMatches)

## ----intersectColumns_example-------------------------------------------------
intersectColumns(myMultiAssay)

## ----mergeReplicates_example--------------------------------------------------
mergeReplicates(intersectColumns(myMultiAssay))

## ----c_example----------------------------------------------------------------
c(myMultiAssay, ExpScores = matrix(1:8, ncol = 4,
dim = list(c("ENSMBL0001", "ENSMBL0002"), paste0("pt", 1:4))),
mapFrom = 1L)

## ----getWithColData_example---------------------------------------------------
(affex <- getWithColData(myMultiAssay, 1L))
colData(affex)
class(affex)

## ----longForm_example---------------------------------------------------------
longForm(myMultiAssay[, , 1:2])

## ----longForm_colDataCols_example---------------------------------------------
longForm(myMultiAssay[, , 1:2], colDataCols="age")

## ----wideFormat_example-------------------------------------------------------
maemerge <- mergeReplicates(intersectColumns(myMultiAssay))
wideFormat(maemerge, colDataCols="sex")[, 1:5]

## ----assay_example------------------------------------------------------------
assay(myMultiAssay)

## ----assays_example-----------------------------------------------------------
assays(myMultiAssay)

## ----curatedTCGAData_install, eval = FALSE------------------------------------
# BiocManager::install("curatedTCGAData")

## ----rownames_colnames_example------------------------------------------------
rownames(myMultiAssay)
colnames(myMultiAssay)

## ----mae_api_err, error = TRUE------------------------------------------------
try({
objlist2 <- objlist
objlist2[[2]] <- as.vector(objlist2[[2]])

tryCatch(
    MultiAssayExperiment(objlist2, patient.data, dfmap),
    error = function(e) {
        conditionMessage(e)
    }
)
})

## ----methods_multiassay-------------------------------------------------------
methods(class="MultiAssayExperiment")

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

