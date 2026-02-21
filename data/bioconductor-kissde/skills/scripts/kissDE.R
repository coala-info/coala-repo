# Code example from 'kissDE' vignette. See references/ for full tutorial.

### R code from vignette source 'kissDE.rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: options
###################################################
options(digits=3, width=80, prompt=" ", continue=" ")


###################################################
### code chunk number 3: installBC (eval = FALSE)
###################################################
## install.packages("BiocManager")


###################################################
### code chunk number 4: install (eval = FALSE)
###################################################
## BiocManager::install("kissDE")


###################################################
### code chunk number 5: library
###################################################
library(kissDE)


###################################################
### code chunk number 6: quick_start (eval = FALSE)
###################################################
## counts <- kissplice2counts("output_kissplice.fa")
## conditions <- c(rep("condition_1", 2), rep("condition_2", 2))
## qualityControl(counts, conditions)
## results <- diffExpressedVariants(counts, conditions)
## writeOutputKissDE(results, output = "kissDE_output.tab")


###################################################
### code chunk number 7: conditionVector_howto
###################################################
myConditions <- c(rep("condition_1", 2), rep("condition_2", 2))


###################################################
### code chunk number 8: conditionVectorRemove_howto (eval = FALSE)
###################################################
## myConditionsRm <- c(rep("condition_1", 2), rep("*", 2), rep("condition_3", 2))


###################################################
### code chunk number 9: tablecounts_howto
###################################################
fpath1 <- system.file("extdata", "table_counts_alt_splicing.txt", 
    package="kissDE")
tableCounts <- read.table(fpath1, head = TRUE)


###################################################
### code chunk number 10: tablecounts_head
###################################################
head(tableCounts)


###################################################
### code chunk number 11: kissplice_format
###################################################
headfasta <- system.file("extdata", 
    "head_output_kissplice_alt_splicing_fasta.txt", package = "kissDE")
writeLines(readLines(headfasta))


###################################################
### code chunk number 12: kissplice2counts_howto
###################################################
fpath2 <- system.file("extdata", "output_kissplice_alt_splicing.fa", 
    package="kissDE")
myCounts <- kissplice2counts(fpath2, pairedEnd = TRUE)


###################################################
### code chunk number 13: kissplice2counts_head
###################################################
names(myCounts)
head(myCounts$countsEvents)


###################################################
### code chunk number 14: kissplice2counts_k2rg_howto
###################################################
fpath3 <- system.file("extdata", "output_k2rg_alt_splicing.txt", 
    package="kissDE")
myCounts_k2rg <- kissplice2counts(fpath3, 
    pairedEnd = TRUE, k2rg = TRUE)
names(myCounts_k2rg)
head(myCounts_k2rg$countsEvents)


###################################################
### code chunk number 15: kissplice2counts_k2rg_ESonly_howto
###################################################
myCounts_k2rg_ES <- kissplice2counts(fpath3, pairedEnd = TRUE, 
    k2rg = TRUE, keep = c("ES"), 
    remove = c("MULTI", "altA", "altD", "altAD", "MULTI_altA",
    "MULTI_altD", "MULTI_altAD"))


###################################################
### code chunk number 16: qualityControl_howto
###################################################
qualityControl(myCounts, myConditions)


###################################################
### code chunk number 17: returnPCAdata_howto (eval = FALSE)
###################################################
## PCAdata <- qualityControl(myCounts, myConditions, returnPCAdata = TRUE)


###################################################
### code chunk number 18: diffExpressedVariants_howto
###################################################
myResults <- diffExpressedVariants(countsData = myCounts,
    conditions = myConditions)


###################################################
### code chunk number 19: myResults_description
###################################################
names(myResults)


###################################################
### code chunk number 20: hist_pvalue_before_correction (eval = FALSE)
###################################################
## hist(myResults$uncorrectedPVal, main="Histogram of p-values", 
##     xlab = "p-values", breaks = 50)


###################################################
### code chunk number 21: finaltable_description
###################################################
# print(headhead(myResults$finalTable, n = 3), row.names = FALSE)
print(str(myResults))


###################################################
### code chunk number 22: finaltable_write (eval = FALSE)
###################################################
## writeOutputKissDE(myResults, output = "kissDE_results_table.tab")


###################################################
### code chunk number 23: finaltable_thresholds_write (eval = FALSE)
###################################################
## writeOutputKissDE(myResults, output = "kissDE_results_table_filtered.tab", 
##     adjPvalMax = 0.05, dPSImin = 0.10)


###################################################
### code chunk number 24: krg_output_write (eval = FALSE)
###################################################
## writeOutputKissDE(myResults_K2RG, output = "kissDE_K2RG_results_table.tab", 
##     adjPvalMax = 0.05, dPSImin = 0.10)


###################################################
### code chunk number 25: fPSItable_description
###################################################
# head(myResults$`f/psiTable`, n = 3)


###################################################
### code chunk number 26: fPSItable_write (eval = FALSE)
###################################################
## writeOutputKissDE(myResults, output = "result_PSI.tab", writePSI = TRUE)


###################################################
### code chunk number 27: AS_data
###################################################
fileInAS <- system.file("extdata", "output_k2rg_alt_splicing.txt",
    package = "kissDE")
exampleK2RG <- read.table(fileInAS)
names(exampleK2RG) <- c("Gene_Id","Gene_name",
    "Chromosome_and_genomic_position","Strand","Event_type",
    "Variable_part_length","Frameshift_?","CDS_?","Gene_biotype",
    "number_of_known_splice_sites/number_of_SNPs")
print(head(exampleK2RG[,c(1:10)], 3), row.names = FALSE)


###################################################
### code chunk number 28: AS_counts
###################################################
fileInAS <- system.file("extdata", "output_k2rg_alt_splicing.txt",
    package = "kissDE")
myCounts_AS <- kissplice2counts(fileInAS, pairedEnd = TRUE, k2rg = TRUE, 
    counts = 2, exonicReads = FALSE)
head(myCounts_AS$countsEvents)


###################################################
### code chunk number 29: AS_condition
###################################################
myConditions_AS <- c(rep("SKNSH",2), rep("SKNSH-RA",2))


###################################################
### code chunk number 30: qualityControl_AS
###################################################
qualityControl(myCounts_AS, myConditions_AS)


###################################################
### code chunk number 31: AS_test
###################################################
myResult_AS <- diffExpressedVariants(myCounts_AS, myConditions_AS)
# head(myResult_AS$finalTable, n = 3)
str(myResult_AS)


###################################################
### code chunk number 32: AS_export (eval = FALSE)
###################################################
## writeOutputKissDE(myResults_AS, output = "results_table.tab")
## writeOutputKissDE(myResults_AS, output = "psi_table.tab", writePSI = TRUE)


###################################################
### code chunk number 33: snv_export_result (eval = FALSE)
###################################################
## exploreResults(rdsFile = "results_table.tab.rds")


###################################################
### code chunk number 34: snv_export_result (eval = FALSE)
###################################################
## fileInAS <- system.file("extdata", "output_k2rg_alt_splicing.txt",
##     package = "kissDE")
## myConditions_AS <- c(rep("SKNSH",2), rep("SKNSH-RA",2))
## kissDE(fileName = fileInAS, conditions = myConditions_AS, 
##        output = "results_table.tab", counts = 2, pairedEnd = TRUE, k2rg = TRUE,
##        exonicReads = FALSE, writePSI = TRUE, doQualityControl = TRUE,
##        resultsInShiny = TRUE)


###################################################
### code chunk number 35: snv_kissplice_data
###################################################
headfasta <- system.file("extdata", "head_output_kissplice_SNV_fasta.txt", 
    package="kissDE")
writeLines(readLines(headfasta))


###################################################
### code chunk number 36: snv_counts
###################################################
fileInSNV <- system.file("extdata", "output_kissplice_SNV.fa", 
    package = "kissDE")
myCounts_SNV <- kissplice2counts(fileInSNV, counts = 0, pairedEnd = TRUE)
head(myCounts_SNV$countsEvents)


###################################################
### code chunk number 37: snv_condition
###################################################
myConditions_SNV <- c(rep("TSC",2), rep("CEU",2))


###################################################
### code chunk number 38: qualityControl_SNV
###################################################
qualityControl(myCounts_SNV, myConditions_SNV)


###################################################
### code chunk number 39: snv_test
###################################################
myResult_SNV <- diffExpressedVariants(myCounts_SNV, myConditions_SNV)
# head(myResult_SNV$finalTable, n = 3)
str(myResult_SNV)


###################################################
### code chunk number 40: snv_export_result (eval = FALSE)
###################################################
## writeOutputKissDE(myResults_SNV, output = "final_table_significants.tab", 
##     adjPvalMax = 0.05)


###################################################
### code chunk number 41: snv_export_result (eval = FALSE)
###################################################
## exploreResults(rdsFile = "final_table_significants.tab.rds")


###################################################
### code chunk number 42: snv_export_result (eval = FALSE)
###################################################
## fileInSNV <- system.file("extdata", "output_kissplice_SNV.fa", 
##     package = "kissDE")
## myConditions_SNV <- c(rep("TSC",2), rep("CEU",2))
## kissDE(fileName = fileInSNV, conditions = myConditions_SNV, 
##        output = "results_table.tab", counts = 2, pairedEnd = TRUE, k2rg = TRUE,
##        exonicReads = FALSE, writePSI = TRUE, doQualityControl = TRUE,
##        resultsInShiny = TRUE)


###################################################
### code chunk number 43: sessioninfo
###################################################
sessionInfo()


