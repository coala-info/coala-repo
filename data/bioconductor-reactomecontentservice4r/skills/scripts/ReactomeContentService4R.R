# Code example from 'ReactomeContentService4R' vignette. See references/ for full tutorial.

## ----load---------------------------------------------------------------------
library(ReactomeContentService4R)

## ----class-species, warnings=FALSE, rownames.print=FALSE----------------------
# Fetch all Human Pathways
pathways <- getSchemaClass(class = "Pathway", species = "human", all = TRUE)
head(pathways, 5)

# Filter Disease Pathways from results
disease.pathways <- pathways[pathways$isInDisease == TRUE, ]
head(disease.pathways, 5)

## ----queryID------------------------------------------------------------------
# Fetch the Reactome object with all attributes using a given id
hsa.2033519 <- query(id = "R-HSA-2033519")
str(hsa.2033519, max.level = 1)

## ----diseaseSlot, rownames.print=FALSE----------------------------------------
hsa.2033519[["disease"]]

## ----searchQuery, rownames.print=FALSE----------------------------------------
# Search for a human disease name
bdd.search <- searchQuery(query = "bone development disease", species = "human")
bdd.search[["results"]]
# the entries dataframe for the first row, with typeName 'Pathway'
(bdd.search[["results"]])[[1]][[1]]

## ----rles, rownames.print=FALSE-----------------------------------------------
# Get sub-Events of an Event
fgfr1.signal.reactions <- getParticipants("R-HSA-5655302", retrieval = "EventsInPathways")
head(fgfr1.signal.reactions, 5)

## ----allInstances, rownames.print=FALSE---------------------------------------
# Get all Entities of a ReactionLikeEvent
instances.1839098 <- getParticipants("R-HSA-1839098", retrieval = "AllInstances")
instances.1839098

## ----image, eval=FALSE--------------------------------------------------------
#  # Visualize above Reaction
#  exportImage("R-HSA-1839098", output = "reaction", format = "jpg", quality = 10)

## ---- echo=FALSE--------------------------------------------------------------
# to prevent weird warnings in the windows check
knitr::include_graphics('img/R-HSA-1839098.jpg')

## ----getPathways, rownames.print=FALSE----------------------------------------
# get lower-level pathways (default)
getPathways("R-HSA-176949")

# get top-level pathways
getPathways("R-HSA-176949", top.level = TRUE)

## ----ref-all------------------------------------------------------------------
# Get the Reactome ReferenceEntity of id "TP53"
tp53.re <- map2RefEntities("TP53")
str(tp53.re)

## ----ref-pe, rownames.print=FALSE---------------------------------------------
# Extract PhysicalEntities of "TP53"
tp53.all.info <- query(tp53.re$dbId)
head(tp53.all.info$physicalEntity, 5)

## ----map2Events, rownames.print=FALSE-----------------------------------------
# Get Pathways associated with "TP53"
tp53.pathways <- map2Events("TP53", resource = "HGNC", species = "human", mapTo = "pathways")
head(tp53.pathways, 5)

## -----------------------------------------------------------------------------
str(tp53.all.info, max.level = 1)

## ----event2Ids----------------------------------------------------------------
# Find all non-Reactome ids for this Event
ids <- event2Ids("R-HSA-176942")
str(ids)

## ---- rownames.print=FALSE----------------------------------------------------
# Look into orthologousEvents of this pathway
stab.p53 <- query("R-HSA-69541")
stab.p53[["orthologousEvent"]]

## -----------------------------------------------------------------------------
stab.p53[["isInferred"]]

## ----getOrthology-------------------------------------------------------------
# Fetch Human orthologous instance
getOrthology("R-SSC-69541", species = "human")

## ----ReactomeGSA, eval=FALSE--------------------------------------------------
#  # Install GSA packages
#  # devtools::install_github("reactome/ReactomeGSA")
#  # devtools::install_github("reactome/ReactomeGSA.data")
#  library(ReactomeGSA)
#  library(ReactomeGSA.data)
#  data("griss_melanoma_proteomics")
#  
#  # Create an analysis request and set parameters
#  my_request <- ReactomeAnalysisRequest(method = "Camera")
#  my_request <- set_parameters(request = my_request, max_missing_values = 0.5)
#  my_request <- add_dataset(request = my_request,
#                            expression_values = griss_melanoma_proteomics,
#                            name = "Proteomics",
#                            type = "proteomics_int",
#                            comparison_factor = "condition",
#                            comparison_group_1 = "MOCK",
#                            comparison_group_2 = "MCM",
#                            additional_factors = c("cell.type", "patient.id"))
#  
#  # Run analysis
#  result <- perform_reactome_analysis(request = my_request, compress = F)
#  
#  # Retrieve the fold-change data for the proteomics dataset
#  proteomics_fc <- get_result(result, type = "fold_changes", name = "Proteomics")
#  
#  # Merge the pathway level data for all result sets
#  combined_pathways <- pathways(result)
#  
#  # Get the analysis token
#  token <- gsub(".*=", "", result@reactome_links[[1]][["url"]])
#  # select the id of the pathway with highest foldchange
#  id <- rownames(combined_pathways[1,])

## ----diagram, eval=FALSE------------------------------------------------------
#  exportImage(id = id, output = "diagram", format = "png", token = token, quality = 8)

## ---- echo=FALSE--------------------------------------------------------------
# to prevent weird warnings in the windows check
knitr::include_graphics('img/R-HSA-163200.png')

## ----fireworks, eval=FALSE----------------------------------------------------
#  # Fireworks of Human Pathways
#  exportImage(species = "9606", output = "fireworks", format = "jpg",
#              token = token, fireworksCoverage = TRUE, quality = 7)

## ---- echo=FALSE--------------------------------------------------------------
# to prevent weird warnings in the windows check
knitr::include_graphics('img/covered-fireworks.jpg')

## ----getSpecies, rownames.print=FALSE-----------------------------------------
# List main species
getSpecies(main = TRUE)

## ----person-------------------------------------------------------------------
getPerson(name = "Justin Cook")

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

