# Code example from 'philr-intro' vignette. See references/ for full tutorial.

## ----echo=TRUE, message=FALSE-------------------------------------------------
library(philr); packageVersion("philr")
library(ape); packageVersion("ape")
library(ggplot2); packageVersion("ggplot2")

## ----echo=TRUE, message=FALSE-------------------------------------------------
library(mia); packageVersion("mia")
library(dplyr); packageVersion("dplyr")
data(GlobalPatterns, package = "mia")

## ----message=FALSE, warning=FALSE---------------------------------------------
## Select prevalent taxa 
tse <-  GlobalPatterns %>% subsetByPrevalentTaxa(
                               detection = 3,
                               prevalence = 20/100,
                               as_relative = FALSE)

## Pick taxa that have notable abundance variation across sammples
variable.taxa <- apply(assays(tse)$counts, 1, function(x) sd(x)/mean(x) > 3.0)
tse <- tse[variable.taxa,]
# Collapse the tree!
# Otherwise the original tree with all nodes is kept
# (including those that were filtered out from rowData)
tree <- ape::keep.tip(phy = rowTree(tse), tip = rowLinks(tse)$nodeNum)
rowTree(tse) <- tree

## Add a new assay with a pseudocount 
assays(tse)$counts.shifted <- assays(tse)$counts + 1 

## ----echo=FALSE---------------------------------------------------------------
tse

## ----message=FALSE, warning=FALSE---------------------------------------------
library(ape); packageVersion("ape")
is.rooted(tree) # Is the tree Rooted?
is.binary(tree) # All multichotomies resolved?

## ----message=FALSE, warning=FALSE---------------------------------------------
tree <- makeNodeLabel(tree, method="number", prefix='n')

# Add the modified tree back to the (`TreeSE`) data object 
rowTree(tse) <- tree

## -----------------------------------------------------------------------------
# Extract taxonomy table from the TreeSE object
tax <- rowData(tse)[,taxonomyRanks(tse)]

# Get name balances
name.balance(tree, tax, 'n1')

## -----------------------------------------------------------------------------
otu.table <- t(as(assays(tse)$counts.shifted, "matrix"))
tree <- rowTree(tse)
metadata <- colData(tse)
tax <- rowData(tse)[,taxonomyRanks(tse)]

otu.table[1:2,1:2] # OTU Table
tree # Phylogenetic Tree
head(metadata,2) # Metadata
head(tax,2) # taxonomy table

## -----------------------------------------------------------------------------
human.samples <- factor(colData(tse)$SampleType %in% c("Feces", "Mock", "Skin", "Tongue"))

## ----message=FALSE------------------------------------------------------------
gp.philr <- philr(otu.table, tree, 
                  part.weights='enorm.x.gm.counts', 
                  ilr.weights='blw.sqrt')
gp.philr[1:5,1:5]

## ----message=FALSE------------------------------------------------------------
gp.philr <- philr(tse, abund_values = "counts.shifted",
                  part.weights='enorm.x.gm.counts', 
                  ilr.weights='blw.sqrt')

## ----message=FALSE------------------------------------------------------------
pseq <- convertToPhyloseq(tse, assay.type="counts.shifted")
gp.philr <- philr(pseq, 
                  part.weights='enorm.x.gm.counts', 
                  ilr.weights='blw.sqrt')


## -----------------------------------------------------------------------------
# Distances between samples based on philr transformed data
gp.dist <- dist(gp.philr, method="euclidean") 

# Calculate MDS for the distance matrix
d <- as.data.frame(cmdscale(gp.dist))
colnames(d) <- paste0("PC", 1:2)

## -----------------------------------------------------------------------------
# Add some metadata for the visualization 
d$SampleType <- factor(metadata$SampleType)

# Create a plot
ggplot(data = d,
  aes(x=PC1, y=PC2, color=SampleType)) +
  geom_point() +
  labs(title = "Euclidean distances with phILR")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(glmnet); packageVersion('glmnet')
glmmod <- glmnet(gp.philr, human.samples, alpha=1, family="binomial")

## -----------------------------------------------------------------------------
top.coords <- as.matrix(coefficients(glmmod, s=0.2526))
top.coords <- rownames(top.coords)[which(top.coords != 0)]
(top.coords <- top.coords[2:length(top.coords)]) # remove the intercept as a coordinate

## -----------------------------------------------------------------------------
tc.names <- sapply(top.coords, function(x) name.balance(tree, tax, x))
tc.names

## -----------------------------------------------------------------------------
votes <- name.balance(tree, tax, 'n730', return.votes = c('up', 'down'))
votes[[c('up.votes', 'Family')]]   # Numerator at Family Level
votes[[c('down.votes', 'Family')]] # Denominator at Family Level

## ----message=FALSE, warning=FALSE---------------------------------------------
library(ggtree); packageVersion("ggtree")
library(dplyr); packageVersion('dplyr')

## ----message=FALSE, warning=FALSE---------------------------------------------
tc.nn <- name.to.nn(tree, top.coords)
tc.colors <- c('#a6cee3', '#1f78b4', '#b2df8a', '#33a02c', '#fb9a99')
p <- ggtree(tree, layout='fan') +
  geom_balance(node=tc.nn[1], fill=tc.colors[1], alpha=0.6) +
  geom_balance(node=tc.nn[2], fill=tc.colors[2], alpha=0.6) +
  geom_balance(node=tc.nn[3], fill=tc.colors[3], alpha=0.6) +
  geom_balance(node=tc.nn[4], fill=tc.colors[4], alpha=0.6) +
  geom_balance(node=tc.nn[5], fill=tc.colors[5], alpha=0.6)
p <- annotate_balance(tree, 'n16', p=p, labels = c('n16+', 'n16-'),
                 offset.text=0.15, bar=FALSE)
annotate_balance(tree, 'n730', p=p, labels = c('n730+', 'n730-'),
                 offset.text=0.15, bar=FALSE)

## -----------------------------------------------------------------------------
gp.philr.long <- convert_to_long(gp.philr, human.samples) %>%
  filter(coord %in% top.coords)

ggplot(gp.philr.long, aes(x=labels, y=value)) +
  geom_boxplot(fill='lightgrey') +
  facet_grid(.~coord, scales='free_x') +
  labs(x = 'Human', y = 'Balance Value') +
  theme_bw()

## ----message=FALSE, warning=FALSE---------------------------------------------
library(tidyr); packageVersion('tidyr')

gp.philr.long %>%
  dplyr::rename(Human=labels) %>%
  dplyr::filter(coord %in% c('n16', 'n730')) %>%
  tidyr::spread(coord, value) %>%
  ggplot(aes(x=n16, y=n730, color=Human)) +
  geom_point(size=4) +
  labs(x = tc.names['n16'], y = tc.names['n730']) +
  theme_bw()

## ----echo=TRUE, message=FALSE-------------------------------------------------
sessionInfo()

