# Code example from 'proteasy' vignette. See references/ for full tutorial.

## ----biocstyle, echo = FALSE, results = "asis", message = FALSE---------------
library(BiocStyle)
BiocStyle::markdown()


## ----installPackage, eval = FALSE---------------------------------------------
#  
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  
#  BiocManager::install("proteasy")
#  

## ----loadPackage, eval = TRUE-------------------------------------------------

library("proteasy")


## ----SearchSubstrate, eval = TRUE---------------------------------------------

# Returns vector of reviewed proteases that cleave P01042
searchSubstrate(protein = "P01042", summarize = TRUE)

# Returns data.table with details on cleaving events
searchSubstrate(protein = "P01042", summarize = FALSE) |>
    head()

# The function also accepts multiple proteins as input. Let's inspect
# the last rows in the returned data.table.
searchSubstrate(protein = c("P01042", "P02461"), summarize = FALSE) |>
    tail()

# With summarize = FALSE we get both reviewed and unreviewed proteases.


## ----SearchProtease, eval = TRUE----------------------------------------------

# Returns vector of substrates that MMP-12 cleave
searchProtease(protein = "P39900", summarize = TRUE)

# Returns data.table with details on cleaving events that involve MMP-12
searchProtease(protein = "P39900", summarize = FALSE) |> head()


## ----FindProtease, eval = TRUE------------------------------------------------

# Create a vector of Uniprot IDs and corresponding peptide sequences

protein <- c("P02671", "P02671", "P68871",
             "P01011", "P68133", "P02461",
             "P0DJI8", "P0DJI8", "P0DJI8")
peptide <- c("FEEVSGNVSPGTR", "FVSETESR", "LLVVYPW",
             "ITLLSAL", "DSYVGDEAQS", "AGGFAPYYG",
             "FFSFLGEAFDGAR", "EANYIGSDKY", "GGVWAAEAISDAR")

# If we do not specify start position (start_pos) and end position
# (end_pos), the function will automatically assign these values by
# matching the provided peptide sequence against the full-length
# protein sequence.

res <- findProtease(protein = protein,
                    peptide = peptide,
                    organism = "Homo sapiens")

# The resulting S4 object can be inspected in three ways;
# (to save space we show only the first six rows)

# 1. Display sequence data for the provided input:

substrates(res) |> head()

# 2. Show which known proteases may have cleaved this protein:

proteases(res) |> head()

# 3. Display details of associated proteolytic events:

cleavages(res) |> head()

# We can find out what proportion of matching cleaving events by reviewed
# proteases occur at N- versus C-terminus

cl <- cleavages(res)[`Protease status` == "reviewed"]

cl$`Cleaved terminus` |> table() |> prop.table() |> round(digits = 2)

# And inspect the distribution of cleaved amino acids

cl$`Cleaved residue` |> table() |> barplot(cex.names = 2)


# Find which protease is involved in the greatest number of cleaving events

cl[!duplicated(Peptide), .(count = .N), by = `Protease (Uniprot)`]

# If start- and end-positions are specified, the function will not attempt
# to automatically look up sequence data for the specified protein/peptide.

cl_by_pos <- findProtease(
    protein = "P02671",
    peptide = "FEEVSGNVSPGTR",
    start_pos = 413,
    end_pos = 425
)

# However, this means sequence details for substrates is not available.

substrates(cl_by_pos)




## ----Browse protease, eval = FALSE--------------------------------------------
#  
#  browseProtease("P07339", keytype = "UniprotID") # (opens web browser)
#  

## ----network, eval = TRUE, message = FALSE, fig.height = 12, fig.width = 12, crop = FALSE----
library(igraph)
library(data.table)
# Make a vector of substrates we want to investigate
proteins <- c('P01011','P02671')
# Look up known proteases which cleave these substrates, and associated data
# annotated to the cleaving events
res <- searchSubstrate(protein = proteins, summarize = FALSE)
# Filter to keep proteases with Uniprot status "reviewed"
res <- res[`Protease status` == "reviewed"]
# To create a network, we only need two columns of interactors
# i.e. the proteases with cleaving action on the substrates
res <- res[, c("Protease (Uniprot)", "Substrate (Uniprot)", "Cleavage type")]
# Construct the DAG
g <- igraph::graph_from_data_frame(res,
                                   directed = TRUE,
                                   vertices = unique(
                                       c(res$`Protease (Uniprot)`,
                                         res$`Substrate (Uniprot)`)))
# This will allow us to return to a layout we like
# (and where the legend fits nicely)
set.seed(104)
plot(g,
     vertex.label.family = "Helvetica",
     vertex.size = 14,
     vertex.color = ifelse(V(g)$name %in% res$`Protease (Uniprot)`,
                           "#377EB8", "#E41A1C"),
     vertex.label.cex = 1,
     vertex.label.color = "white",
     edge.arrow.size = .6,
     edge.color =  ifelse(E(g)$`Cleavage type` == "physiological",
                          "#01665E", "#8E0152"),
     layout = igraph::layout.davidson.harel)
legend(title = "Nodes", cex = 2, horiz = FALSE,
       title.adj = 0.0, inset = c(0.0, 0.2),
       "bottomleft", bty = "n",
       legend = c("Protease", "Substrate"),
       fill = c("#377EB8", "#E41A1C"), border = NA)
legend(title = "Edges", cex = 2, horiz = FALSE,
       title.adj = 0.0, inset = c(0.0, 0.0),
       "bottomleft", bty = "n",
       legend = c("Physiological", "Non-physiological"),
       fill = c("#01665E", "#8E0152"), border = NA)

## ---- message = FALSE, warning = FALSE, crop = FALSE--------------------------

# Load additional libraries

library(Rcpi)
library(viridis)
suppressPackageStartupMessages(library(ComplexHeatmap))

# Prepare input: protein and associated peptide sequences

protein <- c('P01011','P01011','P01034','P01034',
             'P01042','P02671','P02671','P68871',
             'P68871','P01042')

peptide <- c('LVETRTIVRFNRPFLMIIVPTDTQNIFFMSKVTNPK','ITLLSAL',
             'KAFCSFQIY','AFCSFQIY','DIPTNSPELEETLTHTITKL','FEEVSGNVSPGTR',
             'FVSETESR','LLVVYPW','VDEVGGEALGR','KIYPTVNCQPLGMISLM')

# Find cleaving data associated with above substrates

res <- findProtease(protein = protein,
                    peptide = peptide,
                    organism = "Homo sapiens")

# Get substrate info

ss <- substrates(res)

# Show only unique sequences

ss_uniq <- ss[!duplicated(`Substrate sequence`)]

# Calculate protein (substrate) sequence similarity

psimmat = Rcpi::calcParProtSeqSim(ss_uniq$`Substrate sequence`,
                                  type = 'global',
                                  submat = 'BLOSUM62')

rownames(psimmat) <- colnames(psimmat) <- ss_uniq$`Substrate (Uniprot)`

# Plot as a heatmap

ComplexHeatmap::Heatmap(psimmat, col = viridis::mako(100))

# We can do the same thing for peptide sequences,
# and annotate each row (cleaved peptide) with
# information about cleaved residue and termini

# Get cleavage details

cl <- cleavages(res)

# Calculate peptide sequence similarity

pep_psimmat = Rcpi::calcParProtSeqSim(cl$Peptide, type = 'global',
                                      submat = 'BLOSUM62')

# Right side annotation: cleaved residue

rsd <- cl$`Cleaved residue`
cols <- c("#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072")
names(cols) <- unique(rsd)
ha1 <- ComplexHeatmap::columnAnnotation(`cleaved residue` = rsd,
                         col = list(`cleaved residue` = cols))

# Right side annotation: Terminus

tn <- cl$`Cleaved terminus`
cols <- c("#B3E2CD", "#FDCDAC")
names(cols) <- unique(tn)
ha2 <- ComplexHeatmap::columnAnnotation(terminus = tn,
                     col = list(terminus = cols))

rownames(pep_psimmat) <- cl$`Substrate (Uniprot)`

# Plot as a heatmap

ComplexHeatmap::Heatmap(
    pep_psimmat,
    name = "sequence\nsimilarity",
    col = viridis::mako(100),
    show_column_names = FALSE,
    row_names_gp = grid::gpar(fontsize = 6.5),
    top_annotation = c(ha1, ha2)
)


## ----sessioninfo, echo = FALSE------------------------------------------------
sessionInfo()

