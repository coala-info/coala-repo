# Code example from 'my-vignette' vignette. See references/ for full tutorial.

## ----init, results='hide', echo=FALSE, warning=FALSE, message=FALSE-----------
library(knitr)
opts_chunk$set(warning=FALSE, message=FALSE)
BiocStyle::markdown()

## ----echo=FALSE, fig.cap="\\label{fig:figs}PanViz methodology. 1) Biochemical reaction network data (capturing multi-omic adjacencies) was queried from the Kyoto Encyclopaedia of Genes and Genomes (KEGG) database. A capture of this data (captured in August 2021) is stored locally in compressed adjacency lists so that no KEGG queries have to be made whilst using the package, in order to improve computation speeds. However, users can choose to update the local database at any point in order to use the most up-to-date KEGG database using the get_kegg_data() function - see Section X. 2) Precise genomic locations for the genes present within the KEGG biochemical reaction networks were queried via the NCBI Gene databse. Similarly, a capture of this data is stored locally, however, this can also be updated along with the KEGG database using the get_kegg_data() function. 3) Genome-wide Association study (GWAS) summary-level data (such as that provided by the GWAS Catalog or GWAS Central databases) is inputted by the user. 4) The precise chromosome locations for the single nucleotide polymorphisms (SNPs) present within the inputted summary-level GWAS data are queried via the NCBI dbSNP databse. 5) Once SNP locations are queried, SNPs can be mapped onto KEGG genes if they fall within a 1Mb range upstream or downstream of a gene location, and thus the SNPs can be integrated into the KEGG biochemical reaction networks, producing an 'integrated multi-omic network' or IMON."----
# Small fig.width
include_graphics("IMON_method.png")

## ----  echo=FALSE, fig.cap="\\label{fig:figs}Mock-up integrated multi-omic network (IMON) schema. Single nucleotide polymorphisms (SNPs) associated with a target phenotype (present within summary-level genome-wide association study data) are mapped to genes if they fall within a 1Mb range upstream or downstream of a gene location. Once SNPs are mapped to genes, they are integrated into the biochemical reaction networks queried from the Kyoto Encyclopaedia of Genes and Genomes (KEGG) database - see figure.1. Here, genes are adjacent to enzymes, which themselves catalyse biochemical reactions. KEGG reactions are further classified by RClass, here denoted as RP or 'reaction pairs', where each RP (and thus reaction) are associated with metabolite substrates and products. Thus, by choosing to construct ego-centred networks (centred around the SNPs present within the IMON) with specified orders greater than or equal to 5, one can adjust the amount of the metabolome represented within the whole IMON. An ego-centred order of 5 here would thus represent the first layer of the metabolome."----
# Small fig.width
include_graphics("IMON_example.png")

## ----install, eval = FALSE----------------------------------------------------
#  ## install from Bioconductor BiocManager
#  pkgs <- c("PanViz")
#  pkgs_required <- pkgs[!pkgs %in% rownames(installed.packages())]
#  BiocManager::install(pkgs_required)

## ----setup, message = FALSE---------------------------------------------------
library(PanViz)
library(igraph)
library(networkD3)

## -----------------------------------------------------------------------------
##importing the estrogen receptor positive breast cancer example SNP vector
data(er_snp_vector)
snps <- er_snp_vector
##creating an IMON using this summary-level GWAS data
IMON <- PanViz::get_IMON(snp_list = snps, ego = 5, save_file = FALSE, progress_bar = FALSE)

## -----------------------------------------------------------------------------
##inspecting IMON:
print(IMON)

## ---- eval = FALSE------------------------------------------------------------
#  ##creating an IMON and exporting as an graphml file within an user chosen directory
#  IMON <- PanViz::get_IMON(snp_list = snps, ego = 5, save_file = TRUE, export_type = "graphml", directory = "choose")

## -----------------------------------------------------------------------------
##getting tsv file directory path from package data directory - this will be replaced with the users own tsv file path
path <- system.file("extdata", "gwas-association-downloaded_2021-09-13-EFO_1000649.tsv", package="PanViz")
##parsing tsv file into dataframe object
snp_df <- PanViz::GWAS_data_reader(file = path, snp_col = "SNPS", study_col = "STUDY", trait_col = "DISEASE/TRAIT")
head(snp_df)

## -----------------------------------------------------------------------------
##creating IMON using the first 5 studies reported and creating a grouping variable based on studies
snp_df <- dplyr::filter(snp_df, studies %in% unique(snp_df$studies)[1:5])
IMON <- PanViz::get_grouped_IMON(dataframe = snp_df, groupby = "studies", ego = 5, save_file = FALSE, progress_bar = FALSE)

## ---- eval = FALSE------------------------------------------------------------
#  ##getting tsv file directory path from package data directory - this will be replaced with the users own tsv file path
#  path <- system.file("extdata", "GWASCentralMart_ERplusBC.tsv", package="PanViz")
#  ##parsing tsv file into dataframe object
#  snp_df <- PanViz::GWAS_data_reader(file = path, snp_col = "Source Marker Accession", study_col = "Study Name", trait_col = "Annotation Name")

## ---- fig.width=20, fig.height=25---------------------------------------------
##creating an IMON again using the first 5 studies reported within the downloaded tsv file, grouping by studies and colouring the nodes/edges of the graph based on these groups:
IMON <- PanViz::get_grouped_IMON(dataframe = snp_df, groupby = "studies", ego = 5, save_file = FALSE, colour_groups = TRUE, progress_bar = FALSE)
##creating custom igraph tree layout plotting from SNP downards to metabolite:
myformat <- function(IMON) {
  layout.reingold.tilford(IMON, root = V(IMON)[grepl("SNP", V(IMON)$type)], flip.y = TRUE, circular = FALSE)
}
##setting format for igraph object:
format <- myformat(IMON)
##plotting the IMON using the custom tree algorithm:
plot(IMON,
     vertex.label = V(IMON)$ID,
     vertex.shape = "square",
     vertex.label.color = "black",
     vertex.label.cex = 1.5,
     vertex.size = 5,
     edge.arrow.size=.5,
     vertex.color= adjustcolor(V(IMON)$color, alpha = 0.5),
     edge.color = adjustcolor(E(IMON)$color, alpha = 0.5),
     edge.width = 2,
     layout = format,
     vertex.frame.width = 0.001,
     #asp = 0.35,
     margin = -0.1
)
##getting the unique group names and their respective colours from the IMON (and using them to create a legend)
unique_group_names <- unique(V(IMON)$group)[!is.na(unique(V(IMON)$group))]
unique_group_cols <- unique(V(IMON)[which(V(IMON)$group %in% unique_group_names)]$color)
groupings <- factor(unique_group_names)
legdata <- legend("topleft", "legend", trace=TRUE,plot=FALSE)
legend(bty = "n", x=legdata$rect$left,y=legdata$rect$top,
       legend=levels(groupings),
       fill=unique_group_cols, border=NA, cex = 1.8)

## -----------------------------------------------------------------------------
library(networkD3)
##convert the igraph object to a networkd3 object and group by the vertex colours:
IMON_D3 <- networkD3::igraph_to_networkD3(IMON, group =  V(IMON)$color)

# Create force directed network plot
networkD3::forceNetwork(Links = IMON_D3$links, Nodes = IMON_D3$nodes,
             Source = 'source', Target = 'target',
             NodeID = 'name', Group = 'group', zoom = TRUE,
             bounded = TRUE, opacity = 1, opacityNoHover = 1)

## ---- eval=FALSE--------------------------------------------------------------
#  ##saving IMON in grapml format to a selected directory
#  PanViz::get_IMON(snp_list = snps, ego = 5, save_file = TRUE, export_type = "graphml", directory = "choose")

## -----------------------------------------------------------------------------
utils::sessionInfo()

