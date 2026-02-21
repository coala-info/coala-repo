# Code example from 'example_barcode_report' vignette. See references/ for full tutorial.

params <-
list(alignments = "/tmp/Rtmp1j0tRC/Rinst1bf64458a327e8/amplican/extdata/results/alignments/events_filtered_shifted_normalized.csv", 
    config_summary = "/tmp/Rtmp1j0tRC/Rinst1bf64458a327e8/amplican/extdata/results/config_summary.csv", 
    unassigned_folder = "/tmp/Rtmp1j0tRC/Rinst1bf64458a327e8/amplican/extdata/results/alignments/unassigned_reads.csv", 
    top = 5L)

## ----load data, message=F, warning=FALSE, include=FALSE-----------------------
library(amplican)
library(ggplot2)
alignments <- data.table::fread(params$alignments)
data.table::setDF(alignments)
config <- data.frame(data.table::fread(params$config_summary))
height <- amplican::plot_height(length(unique(config$Barcode)))

## ----group ids, echo=FALSE, message=F, warning=FALSE--------------------------
library(knitr)
groupDF <- data.frame(group = unique(config$Barcode),
                      IDs = sapply(unique(config$Barcode),
                                   function(x) toString(config$ID[config$Barcode == x])))
kable(groupDF, row.names = FALSE)

## ----plot_total_reads, echo=FALSE, fig.height=height + height/4, fig.width=14, message=F, warning=FALSE----
p <- ggplot(data = config, 
            aes(x = as.factor(Barcode), y = log10(Reads + 1), 
                order = Barcode, fill = ID)) +
  geom_bar(position='stack', stat='identity') +
  ylab('Number of reads + 1, log10 scaled')  +
  xlab('Barcode')
if (length(groupDF$group) > 20) {
  p <- p + theme(legend.position = 'none',
                 legend.direction = 'horizontal',
                 axis.text = element_text(size = 12),
                 axis.title = element_text(size = 14, face = 'bold'))
} else {
  p <- p + theme(legend.position = 'top',
                 legend.direction = 'horizontal',
                 axis.text = element_text(size = 12),
                 axis.title = element_text(size = 14, face = 'bold'),
                 legend.title = element_blank())
}
p + coord_flip()

## ----plot_filter_per, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----
barcodeTable <- aggregate(cbind(Reads, Reads_Filtered, PRIMER_DIMER, 
                                Low_Score, Reads_Edited, Reads_Frameshifted) ~ Barcode, 
                          data = config, sum)
barcodeTable$F_percentage <- 
  (barcodeTable$PRIMER_DIMER + barcodeTable$Low_Score) * 100/barcodeTable$Reads
barcodeTable$F_percentage[is.nan(barcodeTable$F_percentage)] <- 0  

ggplot(data = barcodeTable, aes(x = as.factor(Barcode), y = F_percentage, 
                                order = Barcode, fill = Barcode)) +
  geom_bar(stat='identity') +
  ylab('Percentage of filtered reads')  +
  xlab('Barcode') +
  theme(axis.text = element_text(size=12),
        axis.title = element_text(size=14, face = 'bold'),
        legend.position = 'none') +
  ylim(0, 100) +
  coord_flip()

## ----plot mut percentage, echo=FALSE, fig.height=height,fig.width=14, message=F, warning=FALSE----
barcodeTable$edit_percentage <- 
  barcodeTable$Reads_Edited * 100/barcodeTable$Reads_Filtered
barcodeTable$edit_percentage[is.nan(barcodeTable$edit_percentage)] <- 0  

ggplot(data = barcodeTable, aes(x = as.factor(Barcode), y = edit_percentage, order = Barcode)) +
  geom_bar(stat = 'identity') +
  ylab('Percentage of reads (not filtered) that have edits')  +
  theme(axis.text = element_text(size=12),
        axis.title = element_text(size=14, face = 'bold')) +
  ylim(0,100) +
  xlab('Barcode') +
  coord_flip() +
  geom_text(aes(x = as.factor(Barcode), 
                y = edit_percentage, label = Reads_Edited), hjust = -1)

## ----plot_frameshift_per, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----
barcodeTable$frameshift_percentage <- 
  barcodeTable$Reads_Frameshifted * 100/barcodeTable$Reads_Filtered
barcodeTable$frameshift_percentage[is.nan(barcodeTable$frameshift_percentage)] <- 0  

ggplot(data = barcodeTable, aes(x = as.factor(Barcode), 
                                y = frameshift_percentage, order = Barcode)) +
  geom_bar(position = 'stack', stat = 'identity') +
  ylab('Percentage of reads (not filtered) that have frameshift')  +
  xlab('Barcode') +
  theme(axis.text = element_text(size=12),
        axis.title = element_text(size=14,face = 'bold')) +
  ylim(0, 100) +
  coord_flip() +
  geom_text(aes(x = as.factor(Barcode), 
                y = frameshift_percentage, label = Reads_Frameshifted), hjust = -1)

## ----plot read heterogeneity, echo=FALSE, fig.height=height + 1, fig.width=14, message=F, warning=FALSE----
plot_heterogeneity(alignments, config, level = 'Barcode')

## ----plot read unassigned reads, results = "asis", echo=FALSE, message=F, warning=FALSE, comment = ''----
if (file.exists(params$unassigned_folder) && 
    !any(is.na(config$Forward_Reads_File)) && !any(is.na(config$Reverse_Reads_File))) {
  unassigned_reads <- data.table::fread(params$unassigned_folder)
  data.table::setDF(unassigned_reads)
  
  cat("# Top unassigned reads  \n\n***  \n\n")
  for (b in unique(unassigned_reads$Barcode)) {
    cat("## ", b, "  \n\n", sep = "")
    b_unassiged <- unassigned_reads[unassigned_reads$Barcode == b, ]
    b_unassiged <- b_unassiged[order(b_unassiged$BarcodeFrequency, decreasing = TRUE), ]
    if (dim(b_unassiged)[1] == 0) {
      cat(knitr::asis_output("No unassigned reads in this barcode. That\'s great!  \n\n"))
    } else {
      topN <- if (dim(b_unassiged)[1] < params$top) dim(b_unassiged)[1] else params$top
      cat('\n')
      print(knitr::kable(data.frame(Forward = paste0('P', 1:topN),
                                    Reverse = paste0('S', 1:topN),
                                    Counts = b_unassiged[1:topN, 'Total'],
                                    Frequency = b_unassiged[1:topN, 'BarcodeFrequency'])))
      cat("\n")
      cat("<PRE>", paste(amplican_print_reads(b_unassiged[1:topN, 'Forward'],
                                              b_unassiged[1:topN, 'Reverse']),
                         collapse = "\n"), "</PRE>")
      cat("\n\n")
    }
  }
}

