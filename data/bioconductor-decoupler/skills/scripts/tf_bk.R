# Code example from 'tf_bk' vignette. See references/ for full tutorial.

## ----setup, include=FALSE---------------------------------------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----"load packages", message = FALSE---------------------------------------------------------------------------------
## We load the required packages
library(decoupleR)
library(dplyr)
library(tibble)
library(tidyr)
library(ggplot2)
library(pheatmap)
library(ggrepel)

## ----"load data"------------------------------------------------------------------------------------------------------
inputs_dir <- system.file("extdata", package = "decoupleR")
data <- readRDS(file.path(inputs_dir, "bk_data.rds"))

## ----"counts"---------------------------------------------------------------------------------------------------------
# Remove NAs and set row names
counts <- data$counts %>%
  dplyr::mutate_if(~ any(is.na(.x)), ~ if_else(is.na(.x),0,.x)) %>% 
  column_to_rownames(var = "gene") %>% 
  as.matrix()
head(counts)

## ----"design"---------------------------------------------------------------------------------------------------------
design <- data$design
design

## ----"deg"------------------------------------------------------------------------------------------------------------
# Extract t-values per gene
deg <- data$limma_ttop %>%
    select(ID, logFC, t, P.Value) %>% 
    filter(!is.na(t)) %>% 
    column_to_rownames(var = "ID") %>%
    as.matrix()
head(deg)

## ----"collectri"------------------------------------------------------------------------------------------------------
net <- get_collectri(organism='human', split_complexes=FALSE)
net

## ----"sample_ulm", message=FALSE--------------------------------------------------------------------------------------
# Run ulm
sample_acts <- run_ulm(mat=counts, net=net, .source='source', .target='target',
                  .mor='mor', minsize = 5)
sample_acts

## ----"heatmap"--------------------------------------------------------------------------------------------------------
n_tfs <- 25

# Transform to wide matrix
sample_acts_mat <- sample_acts %>%
  pivot_wider(id_cols = 'condition', names_from = 'source',
              values_from = 'score') %>%
  column_to_rownames('condition') %>%
  as.matrix()

# Get top tfs with more variable means across clusters
tfs <- sample_acts %>%
  group_by(source) %>%
  summarise(std = sd(score)) %>%
  arrange(-abs(std)) %>%
  head(n_tfs) %>%
  pull(source)
sample_acts_mat <- sample_acts_mat[,tfs]

# Scale per sample
sample_acts_mat <- scale(sample_acts_mat)

# Choose color palette
palette_length = 100
my_color = colorRampPalette(c("Darkblue", "white","red"))(palette_length)

my_breaks <- c(seq(-3, 0, length.out=ceiling(palette_length/2) + 1),
               seq(0.05, 3, length.out=floor(palette_length/2)))

# Plot
pheatmap(sample_acts_mat, border_color = NA, color=my_color, breaks = my_breaks) 

## ----"contrast_ulm", message=FALSE------------------------------------------------------------------------------------
# Run ulm
contrast_acts <- run_ulm(mat=deg[, 't', drop=FALSE], net=net, .source='source', .target='target',
                  .mor='mor', minsize = 5)
contrast_acts

## ----"barplot"--------------------------------------------------------------------------------------------------------

# Filter top TFs in both signs
f_contrast_acts <- contrast_acts %>%
  mutate(rnk = NA)
msk <- f_contrast_acts$score > 0
f_contrast_acts[msk, 'rnk'] <- rank(-f_contrast_acts[msk, 'score'])
f_contrast_acts[!msk, 'rnk'] <- rank(-abs(f_contrast_acts[!msk, 'score']))
tfs <- f_contrast_acts %>%
  arrange(rnk) %>%
  head(n_tfs) %>%
  pull(source)
f_contrast_acts <- f_contrast_acts %>%
  filter(source %in% tfs)

# Plot
ggplot(f_contrast_acts, aes(x = reorder(source, score), y = score)) + 
    geom_bar(aes(fill = score), stat = "identity") +
    scale_fill_gradient2(low = "darkblue", high = "indianred", 
        mid = "whitesmoke", midpoint = 0) + 
    theme_minimal() +
    theme(axis.title = element_text(face = "bold", size = 12),
        axis.text.x = 
            element_text(angle = 45, hjust = 1, size =10, face= "bold"),
        axis.text.y = element_text(size =10, face= "bold"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
    xlab("TFs")

## ----"targets", warning=F---------------------------------------------------------------------------------------------
tf <- 'SP1'

df <- net %>%
  filter(source == tf) %>%
  arrange(target) %>%
  mutate(ID = target, color = "3") %>%
  column_to_rownames('target')

inter <- sort(intersect(rownames(deg),rownames(df)))
df <- df[inter, ]
df[,c('logfc', 't_value', 'p_value')] <- deg[inter, ]
df <- df %>%
  mutate(color = if_else(mor > 0 & t_value > 0, '1', color)) %>%
  mutate(color = if_else(mor > 0 & t_value < 0, '2', color)) %>%
  mutate(color = if_else(mor < 0 & t_value > 0, '2', color)) %>%
  mutate(color = if_else(mor < 0 & t_value < 0, '1', color))

ggplot(df, aes(x = logfc, y = -log10(p_value), color = color, size=abs(mor))) +
  geom_point() +
  scale_colour_manual(values = c("red","royalblue3","grey")) +
  geom_label_repel(aes(label = ID, size=1)) + 
  theme_minimal() +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 'dotted') +
  geom_hline(yintercept = 0, linetype = 'dotted') +
  ggtitle(tf)

## ----session_info, echo=FALSE-----------------------------------------------------------------------------------------
options(width = 120)
sessioninfo::session_info()

