# Code example from 'example_guide_report' vignette. See references/ for full tutorial.

params <-
list(alignments = "/tmp/Rtmp1j0tRC/Rinst1bf64458a327e8/amplican/extdata/results/alignments/events_filtered_shifted_normalized.csv", 
    config_summary = "/tmp/Rtmp1j0tRC/Rinst1bf64458a327e8/amplican/extdata/results/config_summary.csv")

## ----load data, message=F, warning=FALSE, include=FALSE-----------------------
library(amplican)
library(ggplot2)
alignments <- data.table::fread(params$alignments)
data.table::setDF(alignments)
config <- data.frame(data.table::fread(params$config_summary))
height <- plot_height(length(unique(config$guideRNA)))

## ----plot_total_reads, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----
ggplot(data = config, aes(x = as.factor(guideRNA), y = log10(Reads + 1), order = guideRNA, fill = guideRNA)) +
  geom_boxplot() +
  ylab('Number of reads + 1, log10 scaled')  +
  xlab('guideRNA') + 
  theme(legend.position = 'none',
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14, face = 'bold')) +
  coord_flip()

## ----plot_F_per, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----
config$F_percentage <- (config$PRIMER_DIMER + config$Low_Score) * 100/config$Reads
config$F_percentage[is.nan(config$F_percentage)] <- 0

ggplot(data = config, aes(x = as.factor(guideRNA), y = F_percentage, order = guideRNA, fill = guideRNA)) +
  geom_boxplot() +
  xlab('guideRNA') + 
  ylab('Percentage of filtered reads')  +
  theme(axis.text = element_text(size=12),
        axis.title = element_text(size=14, face = 'bold'),
        legend.position = 'none') +
  ylim(0, 100) + 
  coord_flip()

## ----plot mut percentage, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----
config$edit_percentage <- config$Reads_Edited * 100/config$Reads_Filtered
config$edit_percentage[is.nan(config$edit_percentage)] <- 0  

ggplot(data = config, aes(x = as.factor(guideRNA), y = edit_percentage, order = guideRNA, fill = guideRNA)) +
  geom_boxplot() +
  xlab('guideRNA') + 
  ylab('Percentage of reads (not filtered) that have edits')  +
  theme(axis.text = element_text(size=12),
        axis.title = element_text(size=14, face = 'bold'),
        legend.position = 'None') +
  ylim(0,100) + 
  coord_flip()

## ----plot_frameshift_per, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----
config$frameshift_percentage <- config$Reads_Frameshifted * 100/config$Reads_Filtered
config$frameshift_percentage[is.nan(config$frameshift_percentage)] <- 0  

ggplot(data = config, aes(x = as.factor(guideRNA), y = frameshift_percentage, order = guideRNA, fill = guideRNA)) +
  geom_boxplot() +
  xlab('guideRNA') + 
  ylab('Percentage of reads (not filtered) that have frameshift')  +
  theme(axis.text = element_text(size=12),
        axis.title = element_text(size=14,face = 'bold'),
        legend.position = 'None') +
  ylim(0, 100) + 
  coord_flip()

## ----plot read heterogeneity, echo=FALSE, fig.height=height + 1, fig.width=14, message=F, warning=FALSE----
plot_heterogeneity(alignments, config, level = 'guideRNA')

## ----del-AGGTGGTCAGGGAACTGG, echo = F, results = "asis",  message=F, warning=F----
amplican::metaplot_deletions(alignments, config, "guideRNA", "AGGTGGTCAGGGAACTGG")

## ----ins-AGGTGGTCAGGGAACTGG, echo = F, results = "asis",  message=F, warning=F----
amplican::metaplot_insertions(alignments, config, "guideRNA", "AGGTGGTCAGGGAACTGG")

## ----mis-AGGTGGTCAGGGAACTGG, echo = F, results = "asis",  message=F, warning=F----
amplican::metaplot_mismatches(alignments, config, "guideRNA", "AGGTGGTCAGGGAACTGG")

## ----del-TGACCCTCTGCCAACACAAGGGG, echo = F, results = "asis",  message=F, warning=F----
amplican::metaplot_deletions(alignments, config, "guideRNA", "TGACCCTCTGCCAACACAAGGGG")

## ----ins-TGACCCTCTGCCAACACAAGGGG, echo = F, results = "asis",  message=F, warning=F----
amplican::metaplot_insertions(alignments, config, "guideRNA", "TGACCCTCTGCCAACACAAGGGG")

## ----mis-TGACCCTCTGCCAACACAAGGGG, echo = F, results = "asis",  message=F, warning=F----
amplican::metaplot_mismatches(alignments, config, "guideRNA", "TGACCCTCTGCCAACACAAGGGG")

## ----del-GTCCCTGCAACATTAAAGGCCGG, echo = F, results = "asis",  message=F, warning=F----
amplican::metaplot_deletions(alignments, config, "guideRNA", "GTCCCTGCAACATTAAAGGCCGG")

## ----ins-GTCCCTGCAACATTAAAGGCCGG, echo = F, results = "asis",  message=F, warning=F----
amplican::metaplot_insertions(alignments, config, "guideRNA", "GTCCCTGCAACATTAAAGGCCGG")

## ----mis-GTCCCTGCAACATTAAAGGCCGG, echo = F, results = "asis",  message=F, warning=F----
amplican::metaplot_mismatches(alignments, config, "guideRNA", "GTCCCTGCAACATTAAAGGCCGG")

## ----plot_alignments, results='asis', echo=F, message=F, warning=F------------
alignments <- alignments[alignments$consensus & alignments$overlaps, ]
alignments$strand <- "+" # strand does not matter after consensus filtering
src = sapply(unique(config$guideRNA), function(i) {
  knitr::knit_expand(text = c(
    "## Guide {{i}}  \n", 
    "### Deletions  \n", 
    paste('```{r del-{{i}}, echo = F, results = "asis", ',
          'message=F, warning=F}', collapse = ''), 
    'amplican::metaplot_deletions(alignments, config, "guideRNA", "{{i}}")', 
    '```\n',
    "### Insertions", 
    paste('```{r ins-{{i}}, echo = F, results = "asis", ',
          'message=F, warning=F}', collapse = ''), 
    'amplican::metaplot_insertions(alignments, config, "guideRNA", "{{i}}")',
    '```\n', 
    "### Mismatches", 
    paste('```{r mis-{{i}}, echo = F, results = "asis", ',
          'message=F, warning=F}', collapse = ''), 
    'amplican::metaplot_mismatches(alignments, config, "guideRNA", "{{i}}")',
    '```\n'))
})
# knit the source
res = knitr::knit_child(text = src, quiet = TRUE)
cat(res, sep = '\n')

