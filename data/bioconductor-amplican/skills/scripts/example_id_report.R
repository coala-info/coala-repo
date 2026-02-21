# Code example from 'example_id_report' vignette. See references/ for full tutorial.

params <-
list(alignments = "/tmp/Rtmp1j0tRC/Rinst1bf64458a327e8/amplican/extdata/results/alignments/events_filtered_shifted_normalized.csv", 
    config_summary = "/tmp/Rtmp1j0tRC/Rinst1bf64458a327e8/amplican/extdata/results/config_summary.csv", 
    cut_buffer = 5L, xlab_spacing = 4L)

## ----load data, message=F, warning=FALSE, include=FALSE-----------------------
library(amplican)
library(ggplot2)
alignments <- data.table::fread(params$alignments)
data.table::setDF(alignments)
config <- data.frame(data.table::fread(params$config_summary))
height <- plot_height(length(unique(config$ID)))

## ----plot_total_reads, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----
ggplot(data = config, aes(x = as.factor(ID), y = log10(Reads + 1), order = ID)) +
  geom_bar(stat='identity') +
  ylab('Number of reads + 1, log10 scaled')  +
  xlab('ID') +
  theme(legend.position = 'none',
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14, face = 'bold')) +
  coord_flip() +
  geom_text(aes(x = as.factor(ID), y = log10(Reads + 1), label = Reads), hjust = -1)

## ----plot_F_per, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----
config$PRIMER_DIMER <- config$PRIMER_DIMER * 100/config$Reads
config$PRIMER_DIMER[is.nan(config$PRIMER_DIMER)] <- 0  
config$Low_Score <- config$Low_Score * 100/config$Reads
config$Low_Score[is.nan(config$Low_Score)] <- 0  

config_melt <- data.table::melt(data.table::as.data.table(config), id.vars = "ID", 
                                measure.vars = c("PRIMER_DIMER", "Low_Score"))
ggplot(data = config_melt, 
       aes(x = as.factor(ID), y = value, fill = variable, order = ID)) +
  geom_bar(stat='identity') +
  ylab('Percentage of filtered reads')  +
  xlab('ID') +
  theme(legend.position = 'top',
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14, face = 'bold')) +
  coord_flip() +
  labs(fill = "")

## ----plot mut percentage, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----
config$edit_percentage <- config$Reads_Edited * 100/config$Reads_Filtered
config$edit_percentage[is.nan(config$edit_percentage)] <- 0  

ggplot(data = config, aes(x = as.factor(ID), y = edit_percentage, order = ID)) +
  geom_bar(stat='identity') +
  ylab('Percentage of reads (not filtered) that have edits')  +
  xlab('ID') +
  theme(legend.position = 'none',
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14, face = 'bold')) +
  coord_flip() +
  geom_text(aes(x = as.factor(ID), y = edit_percentage, label = Reads_Edited), hjust = -1)

## ----plot_frameshift_per, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----
config$frameshift_percentage <- config$Reads_Frameshifted * 100/config$Reads_Filtered
config$frameshift_percentage[is.nan(config$frameshift_percentage)] <- 0  

ggplot(data = config, aes(x = as.factor(ID), y = frameshift_percentage, order = ID)) +
  geom_bar(stat='identity') +
  ylab('Percentage of reads (not filtered) that have frameshift')  +
  xlab('ID') +
  theme(legend.position = 'none',
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14, face = 'bold')) +
  coord_flip() +
  geom_text(aes(x = as.factor(ID), y = frameshift_percentage, label = Reads_Frameshifted), hjust = -1)

## ----plot read domination, echo=FALSE, fig.height=height + 1, fig.width=14, message=F, warning=FALSE----
plot_heterogeneity(alignments, config)

## ----del-ID_1, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_deletions(alignments, config, "ID_1",  params$cut_buffer, params$xlab_spacing)

## ----ins-ID_1, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_insertions(alignments, config, "ID_1",  params$cut_buffer, params$xlab_spacing)

## ----mis-ID_1, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_mismatches(alignments, config, "ID_1",  params$cut_buffer, params$xlab_spacing)

## ----var-ID_1, echo = F, message=F, results = "asis",  message=F, warning=F----
p <- amplican::plot_variants(alignments_cons, config, "ID_1",   params$cut_buffer)

## ----del-ID_2, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_deletions(alignments, config, "ID_2",  params$cut_buffer, params$xlab_spacing)

## ----ins-ID_2, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_insertions(alignments, config, "ID_2",  params$cut_buffer, params$xlab_spacing)

## ----mis-ID_2, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_mismatches(alignments, config, "ID_2",  params$cut_buffer, params$xlab_spacing)

## ----var-ID_2, echo = F, message=F, results = "asis",  message=F, warning=F----
p <- amplican::plot_variants(alignments_cons, config, "ID_2",   params$cut_buffer)

## ----del-ID_3, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_deletions(alignments, config, "ID_3",  params$cut_buffer, params$xlab_spacing)

## ----ins-ID_3, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_insertions(alignments, config, "ID_3",  params$cut_buffer, params$xlab_spacing)

## ----mis-ID_3, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_mismatches(alignments, config, "ID_3",  params$cut_buffer, params$xlab_spacing)

## ----var-ID_3, echo = F, message=F, results = "asis",  message=F, warning=F----
p <- amplican::plot_variants(alignments_cons, config, "ID_3",   params$cut_buffer)

## ----del-ID_4, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_deletions(alignments, config, "ID_4",  params$cut_buffer, params$xlab_spacing)

## ----ins-ID_4, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_insertions(alignments, config, "ID_4",  params$cut_buffer, params$xlab_spacing)

## ----mis-ID_4, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_mismatches(alignments, config, "ID_4",  params$cut_buffer, params$xlab_spacing)

## ----var-ID_4, echo = F, message=F, results = "asis",  message=F, warning=F----
p <- amplican::plot_variants(alignments_cons, config, "ID_4",   params$cut_buffer)

## ----del-ID_5, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_deletions(alignments, config, "ID_5",  params$cut_buffer, params$xlab_spacing)

## ----ins-ID_5, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_insertions(alignments, config, "ID_5",  params$cut_buffer, params$xlab_spacing)

## ----mis-ID_5, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_mismatches(alignments, config, "ID_5",  params$cut_buffer, params$xlab_spacing)

## ----var-ID_5, echo = F, message=F, results = "asis",  message=F, warning=F----
p <- amplican::plot_variants(alignments_cons, config, "ID_5",   params$cut_buffer)

## ----plot_alignments, results='asis', echo=F, message=F, warning=F------------
alignments_cons <- alignments[alignments$consensus & alignments$overlaps, ]
src = sapply(config$ID, function(i) {
  knitr::knit_expand(text = c(
    "## {{i}}  \n", 
    "### Deletions  \n", 
    paste('```{r del-{{i}}, echo = F, results = "asis", ',
          'fig.width=25, message=F, warning=F}', collapse = ''), 
    paste('p <- amplican::plot_deletions(alignments, config, "{{i}}",',
          ' params$cut_buffer, params$xlab_spacing)', collapse = ''), 
    '```\n',
    "### Insertions  \n", 
    paste('```{r ins-{{i}}, echo = F, results = "asis", ',
          'fig.width=25, message=F, warning=F}', collapse = ''), 
    paste('p <- amplican::plot_insertions(alignments, config, "{{i}}",',
          ' params$cut_buffer, params$xlab_spacing)', collapse = ''), 
    '```\n', 
    "### Mismatches  \n", 
    paste('```{r mis-{{i}}, echo = F, results = "asis", ',
          'fig.width=25, message=F, warning=F}', collapse = ''), 
    paste('p <- amplican::plot_mismatches(alignments, config, "{{i}}",',
          ' params$cut_buffer, params$xlab_spacing)', collapse = ''), 
    '```\n', 
    "### Variants  \n", 
    paste('```{r var-{{i}}, echo = F, message=F, results = "asis", ',
          'message=F, warning=F}', collapse = ''),
    paste('p <- amplican::plot_variants(alignments_cons, config, "{{i}}", ',
          ' params$cut_buffer)', collapse = ''),
    '```\n'))
})
# knit the source
res = knitr::knit_child(text = src, quiet = TRUE)
cat(res, sep = '\n')

