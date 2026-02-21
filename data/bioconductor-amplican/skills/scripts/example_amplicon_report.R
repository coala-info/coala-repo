# Code example from 'example_amplicon_report' vignette. See references/ for full tutorial.

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
config$AmpliconUpper <- toupper(config$Amplicon)
uniqueAmlicons <- unique(config$AmpliconUpper)
labels <- sapply(uniqueAmlicons, function(x) {
  toString(config$ID[config$AmpliconUpper == x])
})
height <- amplican::plot_height(length(uniqueAmlicons))

## ----amplicon groups, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----
library(knitr)
ampliconDF <- data.frame(group = 1:length(uniqueAmlicons), IDs = unname(labels))
kable(ampliconDF)
ampliconDF$Amplicon <- uniqueAmlicons #for sorting
config$group <- match(config$AmpliconUpper, ampliconDF$Amplicon)

## ----plot_total_reads, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----
ampliconTable <- aggregate(cbind(Reads, Reads_Filtered, PRIMER_DIMER, Low_Score,
                                 Reads_Edited, Reads_Frameshifted) ~ group, 
                           data = config, sum)

ggplot(data = ampliconTable, aes(x = as.factor(group), y = log10(Reads + 1)), order = group) +
  geom_bar(stat = 'identity') +
  ylab('Number of reads + 1, log10 scaled')  +
  xlab('Amplicon Group') +
  theme(legend.position = 'none',
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14, face = 'bold')) +
  coord_flip() +
  geom_text(aes(x = as.factor(group), y = log10(Reads + 1), label = Reads), hjust = -1)

## ----plot_F_per, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----

ampliconTable$F_percentage <- 
  (ampliconTable$PRIMER_DIMER + ampliconTable$Low_Score) * 100/ampliconTable$Reads
ampliconTable$F_percentage[is.nan(ampliconTable$PD_percentage)] <- 0 

ggplot(data = ampliconTable, aes(x = as.factor(group), y = F_percentage, order = group)) +
  geom_bar(stat='identity') +
  ylab('Percentage of filtered reads')  +
  xlab('Amplicon Group') +
  theme(axis.text = element_text(size=12),
        axis.title = element_text(size=14, face = 'bold')) +
  ylim(0, 100) +
  coord_flip() +
  geom_text(aes(x = as.factor(group), y = F_percentage, 
                label = PRIMER_DIMER), hjust = -1)

## ----plot_indel_rate, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----
ampliconTable$edit_percentage <- 
  ampliconTable$Reads_Edited * 100/ampliconTable$Reads_Filtered
ampliconTable$edit_percentage[is.nan(ampliconTable$edit_percentage)] <- 0  

ggplot(data = ampliconTable, aes(x = as.factor(group), 
                                 y = edit_percentage, order = group)) +
  geom_bar(stat = 'identity') +
  ylab('Percentage of reads (not filtered) that have edits')  +
  xlab('Amplicon Group') +
  theme(axis.text = element_text(size=12),
        axis.title = element_text(size=14, face = 'bold')) +
  ylim(0,100) +
  coord_flip() +
  geom_text(aes(x = as.factor(group), y = edit_percentage, 
                label = Reads_Edited), hjust = -1)

## ----plot_frameshift_per, echo=FALSE, fig.height=height, fig.width=14, message=F, warning=FALSE----
ampliconTable$frameshift_percentage <- 
  ampliconTable$Reads_Frameshifted * 100/ampliconTable$Reads_Filtered
ampliconTable$frameshift_percentage[is.nan(ampliconTable$frameshift_percentage)] <- 0 

ggplot(data = ampliconTable, aes(x = as.factor(group), 
                                 y = frameshift_percentage, order = group)) +
  geom_bar(position = 'stack', stat = 'identity') +
  ylab('Percentage of reads (not filtered) that have frameshift')  +
  xlab('Amplicon Group') +
  theme(axis.text = element_text(size=12),
        axis.title = element_text(size=14,face = 'bold')) +
  ylim(0, 100) +
  coord_flip() +
  geom_text(aes(x = as.factor(group), y = frameshift_percentage, 
                label = Reads_Frameshifted), hjust = -1)

## ----plot read heterogeneity, echo=FALSE, fig.height=height + 1, fig.width=14, message=F, warning=FALSE----
plot_heterogeneity(alignments, config, level = 'group')

## ----del-1, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_deletions(alignments, config, c('ID_1','ID_3'),  params$cut_buffer, params$xlab_spacing)

## ----ins-1, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_insertions(alignments, config, c('ID_1','ID_3'),  params$cut_buffer, params$xlab_spacing)

## ----mis-1, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_mismatches(alignments, config, c('ID_1','ID_3'),  params$cut_buffer, params$xlab_spacing)

## ----cuts-1, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
amplican::plot_cuts(alignments, config, c('ID_1','ID_3'),  params$cut_buffer, params$xlab_spacing)

## ----var-1, echo = F, message=F, results = "asis",  message=F, warning=F------
p <- amplican::plot_variants(alignments, config, c('ID_1','ID_3'),   params$cut_buffer)

## ----del-2, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_deletions(alignments, config, c('ID_2'),  params$cut_buffer, params$xlab_spacing)

## ----ins-2, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_insertions(alignments, config, c('ID_2'),  params$cut_buffer, params$xlab_spacing)

## ----mis-2, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_mismatches(alignments, config, c('ID_2'),  params$cut_buffer, params$xlab_spacing)

## ----cuts-2, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
amplican::plot_cuts(alignments, config, c('ID_2'),  params$cut_buffer, params$xlab_spacing)

## ----var-2, echo = F, message=F, results = "asis",  message=F, warning=F------
p <- amplican::plot_variants(alignments, config, c('ID_2'),   params$cut_buffer)

## ----del-3, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_deletions(alignments, config, c('ID_4'),  params$cut_buffer, params$xlab_spacing)

## ----ins-3, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_insertions(alignments, config, c('ID_4'),  params$cut_buffer, params$xlab_spacing)

## ----mis-3, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_mismatches(alignments, config, c('ID_4'),  params$cut_buffer, params$xlab_spacing)

## ----cuts-3, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
amplican::plot_cuts(alignments, config, c('ID_4'),  params$cut_buffer, params$xlab_spacing)

## ----var-3, echo = F, message=F, results = "asis",  message=F, warning=F------
p <- amplican::plot_variants(alignments, config, c('ID_4'),   params$cut_buffer)

## ----del-4, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_deletions(alignments, config, c('ID_5'),  params$cut_buffer, params$xlab_spacing)

## ----ins-4, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_insertions(alignments, config, c('ID_5'),  params$cut_buffer, params$xlab_spacing)

## ----mis-4, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
p <- amplican::plot_mismatches(alignments, config, c('ID_5'),  params$cut_buffer, params$xlab_spacing)

## ----cuts-4, echo = F, results = "asis",  fig.width=25, message=F, warning=F----
amplican::plot_cuts(alignments, config, c('ID_5'),  params$cut_buffer, params$xlab_spacing)

## ----var-4, echo = F, message=F, results = "asis",  message=F, warning=F------
p <- amplican::plot_variants(alignments, config, c('ID_5'),   params$cut_buffer)

## ----plot_alignments, results='asis', echo=F, message=F, warning=F------------
alignments <- alignments[alignments$consensus & alignments$overlaps, ]
alignments$strand <- "+" # strand does not matter after consensus filtering
src = sapply(seq_along(uniqueAmlicons), function(i) {
  ID = config$ID[config$AmpliconUpper == uniqueAmlicons[i]]
  ID = paste0("c('", paste0(ID, collapse = "','"), "')", collapse = "")
  knitr::knit_expand(text = c(
    "## Group {{i}}  \n", 
    "### Deletions  \n", 
    paste('```{r del-{{i}}, echo = F, results = "asis", ',
          'fig.width=25, message=F, warning=F}', collapse = ''), 
    paste('p <- amplican::plot_deletions(alignments, config, {{ID}},',
          ' params$cut_buffer, params$xlab_spacing)', collapse = ''), 
    '```\n',
    "### Insertions  \n", 
    paste('```{r ins-{{i}}, echo = F, results = "asis", ',
          'fig.width=25, message=F, warning=F}', collapse = ''), 
    paste('p <- amplican::plot_insertions(alignments, config, {{ID}},',
          ' params$cut_buffer, params$xlab_spacing)', collapse = ''), 
    '```\n', 
    "### Mismatches  \n", 
    paste('```{r mis-{{i}}, echo = F, results = "asis", ',
          'fig.width=25, message=F, warning=F}', collapse = ''), 
    paste('p <- amplican::plot_mismatches(alignments, config, {{ID}},',
          ' params$cut_buffer, params$xlab_spacing)', collapse = ''), 
    '```\n', 
    "### Cuts  \n", 
    paste('```{r cuts-{{i}}, echo = F, results = "asis", ',
          'fig.width=25, message=F, warning=F}', collapse = ''), 
    paste('amplican::plot_cuts(alignments, config, {{ID}},',
          ' params$cut_buffer, params$xlab_spacing)', collapse = ''), 
    '```\n',
    "### Variants  \n", 
    paste('```{r var-{{i}}, echo = F, message=F, results = "asis", ',
          'message=F, warning=F}', collapse = ''),
    paste('p <- amplican::plot_variants(alignments, config, {{ID}}, ',
          ' params$cut_buffer)', collapse = ''),
    '```\n'))
})
# knit the source
res = knitr::knit_child(text = src, quiet = TRUE)
cat(res, sep = '\n')

