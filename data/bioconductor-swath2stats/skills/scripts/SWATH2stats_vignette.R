# Code example from 'SWATH2stats_vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'SWATH2stats_vignette.Rnw'

###################################################
### code chunk number 1: SWATH2stats_vignette.Rnw:48-49
###################################################
options(width=70)


###################################################
### code chunk number 2: SWATH2stats_vignette.Rnw:54-57 (eval = FALSE)
###################################################
## if (!require("BiocManager"))
##     install.packages("BiocManager")
## BiocManager::install("SWATH2stats")


###################################################
### code chunk number 3: SWATH2stats_vignette.Rnw:61-62
###################################################
library(SWATH2stats)


###################################################
### code chunk number 4: SWATH2stats_vignette.Rnw:71-76
###################################################
data('OpenSWATH_data', package='SWATH2stats')
data <- OpenSWATH_data

data('Study_design', package='SWATH2stats')
head(Study_design)


###################################################
### code chunk number 5: SWATH2stats_vignette.Rnw:81-92 (eval = FALSE)
###################################################
## # set working directory
## setwd('~/Documents/MyWorkingDirectory/')
## 
## # Define input data file (e.g. OpenSWATH_output_file.txt)
## file.name <- 'OpenSWATH_output_file.txt'
## 
## # File name for annotation file
## annotation.file <- 'Study_design_file.txt'
## 
## # load data
## data <- data.frame(fread(file.name, sep='\t', header=TRUE))


###################################################
### code chunk number 6: SWATH2stats_vignette.Rnw:97-101 (eval = FALSE)
###################################################
## # consult the manual page.
## help(import_data)
## # rename the columns
## data <- import_data(data)


###################################################
### code chunk number 7: SWATH2stats_vignette.Rnw:108-113
###################################################
# reduce number of columns
data <- reduce_OpenSWATH_output(data)

# remove the iRT peptides (or other proteins)
data <- data[grep('iRT', data$ProteinName, invert=TRUE),]


###################################################
### code chunk number 8: SWATH2stats_vignette.Rnw:119-126 (eval = FALSE)
###################################################
## # list number and different Files present
## nlevels(factor(data$filename))
## levels(factor(data$filename))
## 
## # load the study design table from the indicated file
## Study_design <- read.delim2(annotation.file,
##                             dec='.', sep='\t', header=TRUE)


###################################################
### code chunk number 9: SWATH2stats_vignette.Rnw:131-140
###################################################
# annotate data
data.annotated <- sample_annotation(data, Study_design)

head(unique(data$ProteinName))
# OPTIONAL: for human, shorten Protein Name to remove non-unique information
#(sp|Q9GZL7|WDR12_HUMAN --> Q9GZL7)
data$ProteinName <- gsub('sp\\|([[:alnum:]]+)\\|[[:alnum:]]*_HUMAN',
                         '\\1', data$ProteinName)
head(unique(data$ProteinName))


###################################################
### code chunk number 10: SWATH2stats_vignette.Rnw:149-150
###################################################
count_analytes(data.annotated)


###################################################
### code chunk number 11: SWATH2stats_vignette.Rnw:156-163
###################################################
# Plot correlation of intensity
correlation <- plot_correlation_between_samples(data.annotated, column.values = "Intensity")
head(correlation)

# Plot correlation of retention times
correlation <- plot_correlation_between_samples(data.annotated, column.values = "RT")



###################################################
### code chunk number 12: SWATH2stats_vignette.Rnw:169-178
###################################################
# plot variation of transitions for each condition across replicates
variation <- plot_variation(data.annotated)
head(variation[[2]])

# plot variation of summed signal for Peptides for each condition across replicates
variation <- plot_variation(data.annotated,
               Comparison = FullPeptideName + Condition ~ BioReplicate,
               fun.aggregate = sum)



###################################################
### code chunk number 13: SWATH2stats_vignette.Rnw:184-188
###################################################
# plot variation of transitions for each condition within replicates
# compared to total variation
variation <- plot_variation_vs_total(data.annotated)
head(variation[[2]])


###################################################
### code chunk number 14: SWATH2stats_vignette.Rnw:198-201 (eval = FALSE)
###################################################
## protein_matrix <- write_matrix_proteins(data,
##                       filename = "SWATH2stats_overview_matrix_proteinlevel",
##                       rm.decoy = FALSE)


###################################################
### code chunk number 15: SWATH2stats_vignette.Rnw:208-211 (eval = FALSE)
###################################################
## peptide_matrix <- write_matrix_peptides(data,
##                       filename = "SWATH2stats_overview_matrix_peptidelevel",
##                       rm.decoy = FALSE)


###################################################
### code chunk number 16: SWATH2stats_vignette.Rnw:233-234
###################################################
assess_decoy_rate(data)


###################################################
### code chunk number 17: SWATH2stats_vignette.Rnw:239-247
###################################################
# count decoys and targets on assay, peptide and protein level
# and report FDR at a range of m_score cutoffs
assess_fdr_overall(data, FFT = 0.7, output = "pdf_csv", plot = TRUE,
                   filename='assess_fdr_overall_testrun')

# The results can be reported back to R for further calculations
overall_fdr_table <- assess_fdr_overall(data, FFT = 0.7,
                                        output = "Rconsole")


###################################################
### code chunk number 18: SWATH2stats_vignette.Rnw:252-255
###################################################
# create plots from fdr_table
plot(overall_fdr_table, output = "Rconsole",
               filename = "FDR_report_overall")


###################################################
### code chunk number 19: SWATH2stats_vignette.Rnw:260-268
###################################################
# count decoys and targets on assay, peptide and protein level per run
# and report FDR at a range of m_score cutoffs
assess_fdr_byrun(data, FFT = 0.7, output = "pdf_csv", plot = TRUE,
                 filename='assess_fdr_byrun_testrun')

# The results can be reported back to R for further calculations
byrun_fdr_cube <- assess_fdr_byrun(data, FFT = 0.7,
                                   output = "Rconsole")


###################################################
### code chunk number 20: SWATH2stats_vignette.Rnw:273-276
###################################################
# create plots from fdr_table
plot(byrun_fdr_cube, output = "Rconsole",
              filename = "FDR_report_overall")


###################################################
### code chunk number 21: SWATH2stats_vignette.Rnw:284-287
###################################################
# select and return a useful m_score cutoff in order
# to achieve the desired FDR quality for the entire table
mscore4assayfdr(data, FFT = 0.7, fdr_target=0.01)


###################################################
### code chunk number 22: SWATH2stats_vignette.Rnw:292-295
###################################################
# select and return a useful m_score cutoff
# in order to achieve the desired FDR quality for the entire table
mscore4pepfdr(data, FFT = 0.7, fdr_target=0.02)


###################################################
### code chunk number 23: SWATH2stats_vignette.Rnw:302-305
###################################################
# select and return a useful m_score cutoff in order
# to achieve the desired FDR quality for the entire table
mscore4protfdr(data, FFT = 0.7, fdr_target=0.02)


###################################################
### code chunk number 24: SWATH2stats_vignette.Rnw:317-318
###################################################
data.filtered.mscore <- filter_mscore(data.annotated, 0.01)


###################################################
### code chunk number 25: SWATH2stats_vignette.Rnw:323-325
###################################################
data.filtered.mscore <- filter_mscore_freqobs(data.annotated, 0.01, 0.8,
                                              rm.decoy=FALSE)


###################################################
### code chunk number 26: SWATH2stats_vignette.Rnw:330-331 (eval = FALSE)
###################################################
## data.filtered.mscore <- filter_mscore_condition(data.annotated, 0.01, 3)


###################################################
### code chunk number 27: SWATH2stats_vignette.Rnw:338-341
###################################################
data.filtered.fdr <- filter_mscore_fdr(data, FFT=0.7,
                                   overall_protein_fdr_target = 0.03,
                                   upper_overall_peptide_fdr_limit = 0.05)


###################################################
### code chunk number 28: SWATH2stats_vignette.Rnw:347-349
###################################################
data <- filter_proteotypic_peptides(data.filtered.mscore)
data.all <- filter_all_peptides(data.filtered.mscore)


###################################################
### code chunk number 29: SWATH2stats_vignette.Rnw:355-356
###################################################
data.filtered.max <- filter_on_max_peptides(data.filtered.mscore, 5)


###################################################
### code chunk number 30: SWATH2stats_vignette.Rnw:361-362
###################################################
data.filtered.max.min <- filter_on_min_peptides(data.filtered.max, 2)


###################################################
### code chunk number 31: SWATH2stats_vignette.Rnw:374-376
###################################################
data.transition <- disaggregate(data)
head(data.transition)


###################################################
### code chunk number 32: SWATH2stats_vignette.Rnw:379-381 (eval = FALSE)
###################################################
## write.csv(data.transition, file='transition_level_output.csv',
##           row.names=FALSE, quote=FALSE)


###################################################
### code chunk number 33: SWATH2stats_vignette.Rnw:387-388
###################################################
data.python <- convert4pythonscript(data)


###################################################
### code chunk number 34: SWATH2stats_vignette.Rnw:391-392 (eval = FALSE)
###################################################
## write.table(data.python, file="input.tsv", sep="\t", row.names=FALSE, quote=FALSE)


###################################################
### code chunk number 35: SWATH2stats_vignette.Rnw:400-402 (eval = FALSE)
###################################################
## data.transition <- data.frame(fread('output.csv',
##                                     sep=',', header=TRUE))


###################################################
### code chunk number 36: SWATH2stats_vignette.Rnw:409-413 (eval = FALSE)
###################################################
## MSstats.input <- convert4MSstats(data.transition)
## 
## library(MSstats)
## quantData <- dataProcess(MSstats.input)


###################################################
### code chunk number 37: SWATH2stats_vignette.Rnw:420-432 (eval = FALSE)
###################################################
## aLFQ.input <- convert4aLFQ(data.transition)
## 
## library(aLFQ)
## prots <- ProteinInference(aLFQ.input, peptide_method = 'top',
##                           peptide_topx = 3,
##                           peptide_strictness = 'loose',
##                           peptide_summary = 'mean',
##                           transition_topx = 3,
##                           transition_strictness = 'loose',
##                           transition_summary = 'sum',
##                           fasta = NA, model = NA,
##                           combine_precursors = FALSE)


###################################################
### code chunk number 38: SWATH2stats_vignette.Rnw:437-439
###################################################
mapDIA.input <- convert4mapDIA(data.transition, RT =TRUE)
head(mapDIA.input)


###################################################
### code chunk number 39: SWATH2stats_vignette.Rnw:442-444 (eval = FALSE)
###################################################
## write.table(mapDIA.input, file='mapDIA.txt', quote=FALSE,
##           row.names=FALSE, sep='\t')


###################################################
### code chunk number 40: SWATH2stats_vignette.Rnw:449-451
###################################################
PECA.input <- convert4PECA(data)
head(PECA.input)


###################################################
### code chunk number 41: SWATH2stats_vignette.Rnw:456-462 (eval = FALSE)
###################################################
## library(PECA)
## group1 <- c("Hela_Control_1", "Hela_Control_2", "Hela_Control_3")
## group2 <- c("Hela_Treatment_1", "Hela_Treatment_2", "Hela_Treatment_3")
## 
## # PECA_df
## results <- PECA_df(PECA.input, group1, group2, id="ProteinName", test = "rots")


###################################################
### code chunk number 42: SWATH2stats_vignette.Rnw:468-475 (eval = FALSE)
###################################################
## data.annotated.full <- sample_annotation(OpenSWATH_data, Study_design)
## data.annotated.full <- filter_mscore(data.annotated.full,
##                                      mscore4assayfdr(data.annotated.full, 0.01))
## data.annotated.full$decoy <- 0 ### imsbInfer needs the decoy column
## 
## library(imsbInfer)
## specLib <- loadTransitonsMSExperiment(data.annotated.full)


