# Code example from 'example_index' vignette. See references/ for full tutorial.

params <-
list(barcode_summary = "/tmp/Rtmp1j0tRC/Rinst1bf64458a327e8/amplican/extdata/results/barcode_reads_filters.csv", 
    config_summary = "/tmp/Rtmp1j0tRC/Rinst1bf64458a327e8/amplican/extdata/results/config_summary.csv", 
    links = "1. [Report by id](./example_id_report.html)\n2. [Report by barcode](./example_barcode_report.html)\n3. [Report by group](./example_group_report.html)\n4. [Report by guide](./example_guide_report.html)\n5. [Report by amplicon](./example_amplicon_report.html)\n")

## ----echo = F, results = 'asis'-----------------------------------------------
if (params$links != "") {
  cat("***\n")
  cat("# Other Reports\n")
  cat("***\n")
  cat(params$links, sep = "")
}

## ----echo = F-----------------------------------------------------------------
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(amplican))
summaryDF <- data.frame(data.table::fread(params$barcode_summary))

total_reads <- sum(summaryDF$read_count)
total_good_reads <- sum(summaryDF$filtered_read_count)
read_q <- c(total_good_reads, total_reads - total_good_reads)
read_q_per <- round(read_q*100/total_reads)
read_q_per[is.na(read_q_per)] <- 0 # For some cases 0/0 happens, yelding NaN
names(read_q_per) <- c(paste0('Good Reads\n', read_q[1], ' (', read_q_per[1], '%)'), 
                       paste0('Bad Quality Reads\n', read_q[2], ' (', read_q_per[2], '%)'))
waffle(read_q_per, legend_pos = 'bottom', 
       title = "Quality of all reads", rows = 10, colors = c('#E69F00', '#000000'))

bad_read_q <- c(sum(summaryDF$bad_base_quality), 
                sum(summaryDF$bad_average_quality), 
                sum(summaryDF$bad_alphabet))
bad_read_q_per <- round(bad_read_q*100/sum(bad_read_q))
bad_read_q_per[is.na(bad_read_q_per)] <- 0
names(bad_read_q_per) <- c(
  paste0('Bad Base Quality\n', bad_read_q[1], ' (', bad_read_q_per[1], '%)'), 
  paste0('Bad Average Read Quality\n', bad_read_q[2], ' (', bad_read_q_per[2], '%)'),
  paste0('Bad Read Alphabet\n', bad_read_q[3], ' (', bad_read_q_per[3], '%)'))
waffle(bad_read_q_per, legend_pos = 'bottom', 
       title = "\n\nBad quality reads", rows = 10, colors = c('#D55e00', '#f0e442', '#009e73'))

## ----echo = F-----------------------------------------------------------------
# Assignment of reads from barcodes into experiments (ID)
total_ureads <- sum(summaryDF$unique_reads)
read_a <- c(sum(summaryDF$assigned_reads), sum(summaryDF$unassigned_reads))
read_a_per <- round(read_a*100/total_ureads)
read_a_per[is.na(read_a_per)] <- 0
names(read_a_per) <- c(paste0('Assigned Reads\n', read_a[1], ' (', read_a_per[1], '%)'), 
                       paste0('Unassigned Reads\n', read_a[2], ' (', read_a_per[2], '%)'))
waffle(read_a_per, legend_pos = 'bottom', 
       title = "Succesfull assignment of unique reads", 
       rows = 10, colors = c('#E69F00', '#000000'))

# Filtered reads
configDF <- data.frame(data.table::fread(params$config_summary))
height <- amplican::plot_height(length(unique(configDF$Barcode)))

F_reads <- c(sum(configDF$Reads_Filtered), sum(configDF$PRIMER_DIMER),
              sum(configDF$Low_Score))
F_reads_per <- round(F_reads*100/sum(configDF$Reads))
F_reads_per[is.na(F_reads_per)] <- 0
names(F_reads_per) <- c(paste0('Good Reads\n', F_reads[1], ' (', F_reads_per[1], '%)'), 
                        paste0('PRIMER DIMERs\n', F_reads[2], ' (', 
                               F_reads_per[2], '%)'),
                        paste0('Low Score\n', F_reads[3], ' (', 
                               F_reads_per[3], '%)'))
waffle(F_reads_per, legend_pos = 'bottom', 
       title = "\n\nFiltered Reads", 
       rows = 10, colors = c('#E69F00', '#000000', '#A9A9A9'))

## ----echo = F-----------------------------------------------------------------
total_reads <- sum(configDF$Reads_Filtered)
total_reads_ctr <- sum(configDF$Reads_Filtered[configDF$Control])
total_reads_tmt <- sum(configDF$Reads_Filtered[!configDF$Control])
reads_edited <- c(sum(configDF$Reads_Edited[!configDF$Control]), # Treatment
                  total_reads_tmt - sum(configDF$Reads_Edited[!configDF$Control]),
                  sum(configDF$Reads_Edited[configDF$Control]), # Control
                  total_reads_ctr - sum(configDF$Reads_Edited[configDF$Control]))
reads_edited_per <- round(reads_edited*100/total_reads)
reads_edited_per[is.na(reads_edited_per)] <- 0
names(reads_edited_per) <- c(
  paste0('Edits in Treatment\n', reads_edited[1], ' (', reads_edited_per[1], '%)'),
  paste0('No Edits in Treatment\n', reads_edited[2], ' (', reads_edited_per[2], '%)'),
  paste0('Edits in Control\n', reads_edited[3], ' (', reads_edited_per[3], '%)'), 
  paste0('No Edits in Control\n', reads_edited[4], ' (', reads_edited_per[4], '%)'))
waffle(reads_edited_per, legend_pos = 'bottom', 
       title = "Reads with indels", 
       rows = 10, colors = c('#E69F00', '#000000', '#A9A9A9', '#F0E442'))

frameshift <- c(sum(configDF$Reads_Frameshifted[!configDF$Control]), # Treatment
                total_reads_tmt - sum(configDF$Reads_Frameshifted[!configDF$Control]),
                sum(configDF$Reads_Frameshifted[configDF$Control]), # Control
                total_reads_ctr - sum(configDF$Reads_Frameshifted[configDF$Control]))
frameshift_per <- round(frameshift*100/total_reads)
frameshift_per[is.na(frameshift_per)] <- 0
names(frameshift_per) <- c(
  paste0('Frameshift in Treatment\n', frameshift[1], ' (', frameshift_per[1], '%)'),
  paste0('No Frameshift in Treatment\n', frameshift[2], ' (', frameshift_per[2], '%)'),
  paste0('Frameshift in Control\n', frameshift[3], ' (', frameshift_per[3], '%)'), 
  paste0('No Frameshift in Control\n', frameshift[4], ' (', frameshift_per[4], '%)'))
waffle(frameshift_per, legend_pos = 'bottom', 
       title = "\n\nReads with frameshift", 
       rows = 10, colors = c('#E69F00', '#000000', '#A9A9A9', '#F0E442'))


## ----fig.width=8, fig.height = height + 1, echo = F---------------------------
library(ggthemes)
summaryDF_per <- summaryDF
filters <- c('bad_base_quality', 'bad_average_quality', 'bad_alphabet')
summaryDF_per[, filters] <- 
  round(summaryDF_per[, filters]*100/rowSums(summaryDF_per[, filters]))
summaryDF_per[, c('assigned_reads', 'unassigned_reads')] <-
   round(summaryDF_per[, c('assigned_reads', 'unassigned_reads')]*100/
           summaryDF_per$unique_reads)
summaryDF_per$bad_read_count <- summaryDF_per$read_count - summaryDF_per$filtered_read_count 
summaryDF_per[, c('filtered_read_count', 'bad_read_count')] <- 
  round(
    summaryDF_per[, c('filtered_read_count','bad_read_count')]*100/summaryDF_per$read_count)
summaryDF_per[is.na(summaryDF_per)] <- 0
summaryDF_per <- data.table::as.data.table(summaryDF_per)

quality_melt <- data.table::melt(summaryDF_per, id.vars = c('Barcode'), 
                     measure.vars = c('filtered_read_count', 'bad_read_count'))
quality_det_melt <-  data.table::melt(summaryDF_per,
                     id.vars = c('Barcode'),
                     measure.vars = c('bad_base_quality',
                                      'bad_average_quality',
                                      'bad_alphabet'))
assignment_melt <-  data.table::melt(summaryDF_per,
                        id.vars = c('Barcode'),
                        measure.vars = c('assigned_reads', 'unassigned_reads'))

ggplot(data = quality_melt,
       aes(x = as.factor(Barcode),
           y = value,
           fill = factor(variable, labels = c('Good Reads', 'Bad Quality Reads')))) +
  geom_bar(position ='stack', stat ='identity') +
  ylab('% of reads in barcode') +
  xlab('Barcode') +
  ggtitle('Quality filtering of reads in barcodes') +
  theme(legend.position = 'top',
        legend.direction = 'horizontal',
        legend.title = element_blank()) +
  coord_flip() +
  scale_fill_manual(values = c('#E69F00', '#000000'))


## ----fig.width=8, fig.height=height + 1, echo = F-----------------------------
ggplot(data = quality_det_melt,
       aes(x = as.factor(Barcode),
           y = value,
           fill = factor(variable, labels = c('Bad Read Base Quality', 
                                              'Bad Average Read Quality', 
                                              'Bad Read Alphabet')))) +
  geom_bar(position='stack', stat='identity') +
  ylab('% of low quality reads in barcode') +
  xlab('Barcode') +
  ggtitle('\n\nDistribution of low quality reads in barcodes') +
  theme(legend.position = 'top',
        legend.direction = 'horizontal',
        legend.title = element_blank()) +
  coord_flip() + 
  scale_color_colorblind()+
  scale_fill_manual(values = c('#D55e00', '#f0e442', '#009e73'))

## ----fig.width=8, fig.height=height + 1, echo = F-----------------------------
ggplot(data = assignment_melt,
       aes(x = as.factor(Barcode),
           y = value,
           fill = factor(variable, labels = c('Assigned Reads', 'Unassigned Reads')))) +
  geom_bar(position='stack', stat='identity') +
  ylab('% of unique reads in barcode') +
  xlab('Barcode') +
  ggtitle('\n\nAssignment of reads in barcodes') +
  theme(legend.position = 'top',
        legend.direction = 'horizontal',
        legend.title = element_blank()) +
  coord_flip() +
  scale_fill_manual(values = c('#E69F00', '#000000'))

## ----echo = F-----------------------------------------------------------------
library(knitr)
names(summaryDF) <- c("Barcodes", "Experiment Count", "Read Count",
                      "Bad base quality", "Bad average quality", "Bad alphabet",
                      "Good Reads", "Unique Reads", "Unassigned Reads",
                      "Assigned Reads")
kable(summaryDF)

