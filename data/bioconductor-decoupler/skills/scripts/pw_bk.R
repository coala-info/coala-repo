# Code example from 'pw_bk' vignette. See references/ for full tutorial.

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
    select(ID, t) %>% 
    filter(!is.na(t)) %>% 
    column_to_rownames(var = "ID") %>%
    as.matrix()
head(deg)

## ----"progeny", message=FALSE-----------------------------------------------------------------------------------------
net <- get_progeny(organism = 'human', top = 500)
net

## ----"sample_mlm", message=FALSE--------------------------------------------------------------------------------------
# Run mlm
sample_acts <- run_mlm(mat=counts, net=net, .source='source', .target='target',
                  .mor='weight', minsize = 5)
sample_acts

## ----"heatmap"--------------------------------------------------------------------------------------------------------
# Transform to wide matrix
sample_acts_mat <- sample_acts %>%
  pivot_wider(id_cols = 'condition', names_from = 'source',
              values_from = 'score') %>%
  column_to_rownames('condition') %>%
  as.matrix()

# Scale per feature
sample_acts_mat <- scale(sample_acts_mat)

# Choose color palette
palette_length = 100
my_color = colorRampPalette(c("Darkblue", "white","red"))(palette_length)

my_breaks <- c(seq(-3, 0, length.out=ceiling(palette_length/2) + 1),
               seq(0.05, 3, length.out=floor(palette_length/2)))

# Plot
pheatmap(sample_acts_mat, border_color = NA, color=my_color, breaks = my_breaks) 

## ----"contrast_mlm", message=FALSE------------------------------------------------------------------------------------
# Run mlm
contrast_acts <- run_mlm(mat=deg, net=net, .source='source', .target='target',
                  .mor='weight', minsize = 5)
contrast_acts

## ----"barplot"--------------------------------------------------------------------------------------------------------
# Plot
ggplot(contrast_acts, aes(x = reorder(source, score), y = score)) + 
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
    xlab("Pathways")

## ----"targets"--------------------------------------------------------------------------------------------------------
pathway <- 'MAPK'

df <- net %>%
  filter(source == pathway) %>%
  arrange(target) %>%
  mutate(ID = target, color = "3") %>%
  column_to_rownames('target')
inter <- sort(intersect(rownames(deg),rownames(df)))
df <- df[inter, ]
df['t_value'] <- deg[inter, ]
df <- df %>%
  mutate(color = if_else(weight > 0 & t_value > 0, '1', color)) %>%
  mutate(color = if_else(weight > 0 & t_value < 0, '2', color)) %>%
  mutate(color = if_else(weight < 0 & t_value > 0, '2', color)) %>%
  mutate(color = if_else(weight < 0 & t_value < 0, '1', color))

ggplot(df, aes(x = weight, y = t_value, color = color)) + geom_point() +
  scale_colour_manual(values = c("red","royalblue3","grey")) +
  geom_label_repel(aes(label = ID)) + 
  theme_minimal() +
  theme(legend.position = "none") +
  geom_vline(xintercept = 0, linetype = 'dotted') +
  geom_hline(yintercept = 0, linetype = 'dotted') +
  ggtitle(pathway)



## ----session_info, echo=FALSE-----------------------------------------------------------------------------------------
options(width = 120)
sessioninfo::session_info()

