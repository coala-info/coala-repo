# ReactomeContentService4R: an R Interface for the Reactome Content Service

#### Chi-Lam Poon

#### 05/19/2021

## Overview

[Reactome](https://reactome.org) is a free, open-source, open access, curated and peer-reviewed knowledgebase of biomolecular pathways. Knowledge in Reactome is captured as instances of the **classes** with their associated **attributes**. The Reactome [data model](https://reactome.org/content/schema) is comprised primarily of classes of Pathways, Reactions and PhysicalEntities (e.g. proteins, small molecules) that are organized in a hierarchical manner (Pathways contain Reactions, Reactions contain PhysicalEntities). Classes have attributes that hold properties of the represented class instances, such as names, identifiers, etc.

The `ReactomeContentService4R` package provides an interface to query Reactome data from the [Content Service](https://reactome.org/dev/content-service). This package allows you to query Reactome’s Content Service using many of the same endpoints available on the website, but formats the returned data in R Data Frames. For example, you can query all of the participants/PhysicalEntities in a Reaction by providing its stable identifier (‘R-HSA-123456’) to the `getParticipants("R-HSA-123456", retrieval="PhysicalEntities")` method in the package. This will return an R Data Frame that will hold the same attributes as the Content Service query `curl -X GET "https://reactome.org/ContentService/data/participants/R-HSA-123456" -H "accept: application/json"`.

Similar functionality exists for a number of other Reactome Content Service endpoints, which is outlined further below in this document. You can retrieve specific instances, or all instances within a specific Class (eg: Pathway or Complex); Generate mappings, such as PhysicalEntity-to-Events (ie. Proteins to Reactions) mappings, or non-Reactome identifiers (such as UniProt) to Events/PhysicalEntities (for example, Reactome Proteins containing UniProt identifiers) mappings; Export or view Reactome’s Pathway/Reaction diagrams, and much more!

## Installation

Install from Bioconductor:

```
if (!requireNamespace("BiocManager")) {
install.packages("BiocManager")
}
BiocManager::install("ReactomeContentService4R")
```

```
library(ReactomeContentService4R)
```

```
## Connecting...welcome to Reactome v76!
```

## Instance fetching

### Fetch by Class

To retrieve instances of one Class, you can use `getSchemaClass`. This function would first show how many instances belong to the specified Class in the Reactome Database, and return 1000 instances by default. If you want to retrieve all instances of one Class, specify `all = TRUE`.

Argument `species` could be specified here but only for Event or subclasses with *species* attribute under PhysicalEntity (i.e. Complex, EntitySet, etc). Some attributes are also retrieved and thus they can be used to filter. For example, to fetch all human pathways, and then select those in disease:

```
# Fetch all Human Pathways
pathways <- getSchemaClass(class = "Pathway", species = "human", all = TRUE)
```

```
## Total 2516 entries of Pathway with species Homo sapiens, retrieving 2516 of them...
```

```
##
  |
  |                                                                      |   0%
```

```
head(pathways, 5)
```

```
# Filter Disease Pathways from results
disease.pathways <- pathways[pathways$isInDisease == TRUE, ]
head(disease.pathways, 5)
```

### Fetch by identifier

Now that we have got all those disease pathways, we can look into what disease(s) associated with a pathway of your interest. The `query` function could fetch **all attributes** of an instance with *any* Class by its database id or stable id. It also lists any second level relationships regarding regulations and catalysts. As an example, to retrieve one of the human disease pathway “Activated point mutants of FGFR2” with identifier R-HSA-2033519:

```
# Fetch the Reactome object with all attributes using a given id
hsa.2033519 <- query(id = "R-HSA-2033519")
str(hsa.2033519, max.level = 1)
```

```
## List of 24
##  $ dbId               : int 2033519
##  $ displayName        : chr "Activated point mutants of FGFR2"
##  $ stId               : chr "R-HSA-2033519"
##  $ stIdVersion        : chr "R-HSA-2033519.1"
##  $ created            :List of 5
##  $ modified           :List of 5
##  $ isInDisease        : logi TRUE
##  $ isInferred         : logi FALSE
##  $ name               : chr "Activated point mutants of FGFR2"
##  $ releaseDate        : chr "2012-06-12"
##  $ speciesName        : chr "Homo sapiens"
##  $ authored           :'data.frame': 1 obs. of  5 variables:
##  $ compartment        :'data.frame': 3 obs. of  9 variables:
##  $ disease            :'data.frame': 2 obs. of  10 variables:
##  $ edited             :'data.frame': 1 obs. of  5 variables:
##  $ literatureReference:'data.frame': 17 obs. of  11 variables:
##  $ reviewed           :'data.frame': 1 obs. of  5 variables:
##  $ species            :'data.frame': 1 obs. of  8 variables:
##  $ summation          :'data.frame': 1 obs. of  5 variables:
##  $ hasDiagram         : logi FALSE
##  $ hasEHLD            : logi FALSE
##  $ hasEvent           :'data.frame': 10 obs. of  15 variables:
##  $ schemaClass        : chr "Pathway"
##  $ className          : chr "Pathway"
```

The `schemaClass` of R-HSA-2033519 is *Pathway* since we get this id by `getSchemaClass` for Pathway. Likewise, we can always access what Class an instance belongs to using `query`.

Here we look into the *disease* slot to find disease associated with this Pathway:

```
hsa.2033519[["disease"]]
```

### Search for name

We can see that the pathway “Activated point mutants of FGFR2” is related to two disease: “bone development disease” and “cancer”. If you want to know more about bone development disease, you may try to use the `query` function again with its dbId to obtain more details. However, you would just get a Reactome Disease object that doesn’t include any other biological insights in Reactome. For now, you can use `searchQuery` function which fetches all instances associated with a **term**:

```
# Search for a human disease name
bdd.search <- searchQuery(query = "bone development disease", species = "human")
```

```
## Searching for term 'bone development disease'... species:'Homo sapiens'
```

```
bdd.search[["results"]]
```

```
# the entries dataframe for the first row, with typeName 'Pathway'
(bdd.search[["results"]])[[1]][[1]]
```

The result instances are primarily faceted by types available for this query term. As such, you could know what pathways (the above dataframe), reactions, proteins, etc. are related to the bone development disease in human.

Filters in `searchQuery()` include `species`, `types`, `compartments`, `keywords`; all the items for filtering can be viewed using function `listSearchItems`. For more details, see `?listSearchItems`.

## Participants of Event

**Events** represent biological processes and are further subclassed into **Pathways** and **ReactionLikeEvents** in Reactome. ReactionLikeEvents are single-step molecular transformations. Pathways are ordered groups of ReactionLikeEvents that together carry out a biological process.

**Participants** of a given Event (e.g. reactions of a pathway, participating molecules of a reaction) can be retrieved using function `getParticipants`. Some explanations on the `retrieval` options in this function:

* `AllInstances`: retrieve all PhysicalEntities and collections of ReferenceEntities. For entities in a ReactionLikeEvent, there would be additional columns `type` and `numOfEntries` to indicate what are *inputs, outputs, catalysts, regulators*, and the number of these components
* `EventsInPathways`: retrieve all ReactionLikeEvents and subpathways in a given Pathway
* `PhysicalEntities/ReferenceEntities`: retrieve all contained PhysicalEntities/ReferenceEntities of all PhysicalEntities of a given Event

To be more specific, **PhysicalEntity** instances contain numerous invariant features such as names, molecular structure and links to external databases like UniProt or ChEBI. Thus, Reactome creates instances of the separate **ReferenceEntity** class that support PhysicalEntity instances. All PhysicalEntity instances have a linked ReferenceEntity instance that captures reference features (such as external identifiers) of a molecule.

### Events in Pathways

Since we’ve known several pathways related to the bone development disease from above results, we might further retrieve ReactionLikeEvents and Pathways in the “hasEvent” attribute of Pathway “Signaling by FGFR1 in disease” (stId R-HSA-5655302):

```
# Get sub-Events of an Event
fgfr1.signal.reactions <- getParticipants("R-HSA-5655302", retrieval = "EventsInPathways")
head(fgfr1.signal.reactions, 5)
```

### Instances in Reactions

For a ReactionLikeEvent, say “Activated FGFR1 mutants and fusions phosphorylate PLCG1” with identifier R-HSA-1839098, all relative PhysicalEntities and ReferenceEntities could be retrieved:

```
# Get all Entities of a ReactionLikeEvent
instances.1839098 <- getParticipants("R-HSA-1839098", retrieval = "AllInstances")
instances.1839098
```

It’s always a good option to visualize the instances in a reaction or pathway for better elucidations. Reactome has diagrams for pathways and reactions that provide information about connected events and their locations. The diagram exporter in Content Service allows users to easily export diagrams in bitmap format. More details see `?exportImage`.

```
# Visualize above Reaction
exportImage("R-HSA-1839098", output = "reaction", format = "jpg", quality = 10)
```

![](data:image/jpeg;base64...)

## Mappings

### PhysicalEntity/Event to Events

Given either a PhysicalEntity or an Event, the top-level pathways or lower-level pathways that contain it can be retrieved by function `getPathways`. In this example, we try with the Complex “Unwinding complex at replication fork [nucleoplasm]” with identifier R-HSA-176949.

```
# get lower-level pathways (default)
getPathways("R-HSA-176949")
```

```
# get top-level pathways
getPathways("R-HSA-176949", top.level = TRUE)
```

### Non-Reactome id to Entities

Given an identifier in [non-Reactome resources](https://reactome.org/content/schema/objects/ReferenceDatabase), all relative **ReferenceEntities** could be retrieved by function `map2RefEntities`. Here we focus on gene *TP53*:

```
# Get the Reactome ReferenceEntity of id "TP53"
tp53.re <- map2RefEntities("TP53")
str(tp53.re)
```

```
## List of 18
##  $ dbId               : int 69487
##  $ displayName        : chr "UniProt:P04637 TP53"
##  $ databaseName       : chr "UniProt"
##  $ identifier         : chr "P04637"
##  $ name               :List of 1
##   ..$ : chr "TP53"
##  $ otherIdentifier    :List of 1
##   ..$ : chr [1:284] "0005670112" "11738335_x_at" "11748319_x_at" "11748599_a_at" ...
##  $ url                : chr "http://purl.uniprot.org/uniprot/P04637"
##  $ checksum           : chr "AD5C149FD8106131"
##  $ comment            :List of 1
##   ..$ : chr "FUNCTION Acts as a tumor suppressor in many tumor types; induces growth arrest or apoptosis depending on the ph"| __truncated__
##  $ description        :List of 1
##   ..$ : chr "recommendedName: Cellular tumor antigen p53  alternativeName: Antigen NY-CO-13  alternativeName: Phosphoprotein"| __truncated__
##  $ geneName           :List of 1
##   ..$ : chr [1:2] "TP53" "P53"
##  $ isSequenceChanged  : logi FALSE
##  $ keyword            :List of 1
##   ..$ : chr [1:31] "3D-structure" "Acetylation" "Activator" "Alternative promoter usage" ...
##  $ secondaryIdentifier:List of 1
##   ..$ : chr [1:27] "P53_HUMAN" "Q15086" "Q15087" "Q15088" ...
##  $ sequenceLength     : int 393
##  $ chain              :List of 1
##   ..$ : chr "chain:1-393"
##  $ schemaClass        : chr "ReferenceGeneProduct"
##  $ className          : chr "ReferenceGeneProduct"
```

This object is linked to UniProt with identifier P04637 and name TP53. Once the Reactome `dbId` of a non-Reactome identifier or name is obtained, the **PhysicalEntities** associated with this non-Reactome identifier can be fetched through retrieving all attributes using `query`:

```
# Extract PhysicalEntities of "TP53"
tp53.all.info <- query(tp53.re$dbId)
head(tp53.all.info$physicalEntity, 5)
```

### Non-Reactome id to Events

Furthermore, non-Reactome identifiers could be mapped to Reactome Events with function `map2Events`, therefore we are able to get pathways associated with *TP53*. If you stick to the gene symbol, you should specify `resource = "HGNC"`. Actually this is same as `id = P04637, resource = "UniProt"`. For reactions, specify `mapTo = "reactions"`.

```
# Get Pathways associated with "TP53"
tp53.pathways <- map2Events("TP53", resource = "HGNC", species = "human", mapTo = "pathways")
head(tp53.pathways, 5)
```

### Entity to non-Reactome ids

A recap for all slots of *TP53* Reactome object:

```
str(tp53.all.info, max.level = 1)
```

```
## List of 25
##  $ dbId               : int 69487
##  $ displayName        : chr "UniProt:P04637 TP53"
##  $ modified           :List of 6
##  $ databaseName       : chr "UniProt"
##  $ identifier         : chr "P04637"
##  $ name               : chr "TP53"
##  $ otherIdentifier    : chr [1:284] "0005670112" "11738335_x_at" "11748319_x_at" "11748599_a_at" ...
##  $ url                : chr "http://purl.uniprot.org/uniprot/P04637"
##  $ crossReference     :'data.frame': 267 obs. of  7 variables:
##  $ referenceDatabase  :List of 7
##  $ physicalEntity     :'data.frame': 27 obs. of  15 variables:
##  $ checksum           : chr "AD5C149FD8106131"
##  $ comment            : chr "FUNCTION Acts as a tumor suppressor in many tumor types; induces growth arrest or apoptosis depending on the ph"| __truncated__
##  $ description        : chr "recommendedName: Cellular tumor antigen p53  alternativeName: Antigen NY-CO-13  alternativeName: Phosphoprotein"| __truncated__
##  $ geneName           : chr [1:2] "TP53" "P53"
##  $ isSequenceChanged  : logi FALSE
##  $ keyword            : chr [1:31] "3D-structure" "Acetylation" "Activator" "Alternative promoter usage" ...
##  $ secondaryIdentifier: chr [1:27] "P53_HUMAN" "Q15086" "Q15087" "Q15088" ...
##  $ sequenceLength     : int 393
##  $ species            : int 48887
##  $ chain              : chr "chain:1-393"
##  $ referenceGene      :'data.frame': 11 obs. of  9 variables:
##  $ referenceTranscript:'data.frame': 15 obs. of  9 variables:
##  $ schemaClass        : chr "ReferenceGeneProduct"
##  $ className          : chr "ReferenceGeneProduct"
```

Non-Reactome identifiers associated with a ReferenceEntity or PhysicalEntity can be found in these attributes of an instance:

* `identifier`
* `otherIdentifier`
* `crossReference`
* `geneName`
* `secondaryIdentifier`
* `referenceGene`
* `referenceTranscript`

### Event to non-Reactome ids

Non-Reactome identifiers (`primaryIdentifier`, `secondaryIdentifier`, and `otherIdentifier`) and gene symbols associated with an Event can also be retrieved by function `event2Ids`. Here we try with Reaction “Multiple proteins are localized at replication fork” (stId R-HSA-176942):

```
# Find all non-Reactome ids for this Event
ids <- event2Ids("R-HSA-176942")
str(ids)
```

```
## List of 4
##  $ geneSymbol         : chr [1:30] "CDC45" "CDC45L" "CDC45L2" "UNQ374/PRO710" ...
##  $ primaryIdentifier  :'data.frame': 11 obs. of  2 variables:
##   ..$ dbId       : int [1:11] 86785 176969 356315 67522 99147 94945 94950 94954 94959 94964 ...
##   ..$ displayName: chr [1:11] "UniProt:O75419 CDC45" "UniProt:Q9BRT9 GINS4" "UniProt:Q9BRX5 GINS3" "UniProt:Q14691 GINS1" ...
##  $ secondaryIdentifier: chr [1:53] "CDC45_HUMAN" "B4DDB4" "B4DDU3" "E9PDH7" ...
##  $ otherIdentifier    : chr [1:888] "0000380402" "11719699_a_at" "11745049_a_at" "11751123_a_at" ...
```

## Inferred events

Reactome uses the set of manually curated Human Reactions to computationally infer reactions in fourteen evolutionarily divergent eukaryotic species for which high-quality whole-genome sequence data are available. Therefore a set of high-quality inferred Pathways, Reactions, and PhysicalEntities (proteins) exists in these species. More details about computationally inferred events could be found [here](https://reactome.org/documentation/inferred-events).

We can first look at a human pathway “Stabilization of p53” with identifier R-HSA-69541 and the `orthologousEvent` slot in its Reactome Pathway object.

```
# Look into orthologousEvents of this pathway
stab.p53 <- query("R-HSA-69541")
stab.p53[["orthologousEvent"]]
```

Note that the `isInferred` value of this human instance is `FALSE`, while those of all its orthologous Events in other species are `TRUE`.

```
stab.p53[["isInferred"]]
```

```
## [1] FALSE
```

Conversely, if you have a non-Human Event or PhysicalEntity instance and want to get all its orthologies in other species, you could use function `getOrthology` to fetch the **Human orthologous instance** first, then repeat the steps above:

* `query` the result identifier
* extract those in `orthologousEvent` attribute

```
# Fetch Human orthologous instance
getOrthology("R-SSC-69541", species = "human")
```

```
## Returning inferred instances of 'R-SSC-69541' in species 'Homo sapiens'...
```

```
## $dbId
## [1] 69541
##
## $displayName
## [1] "Stabilization of p53"
##
## $stId
## [1] "R-HSA-69541"
##
## $stIdVersion
## [1] "R-HSA-69541.5"
##
## $isInDisease
## [1] FALSE
##
## $isInferred
## [1] FALSE
##
## $name
## [1] "Stabilization of p53"
##
## $releaseDate
## [1] "2004-07-06"
##
## $speciesName
## [1] "Homo sapiens"
##
## $hasDiagram
## [1] FALSE
##
## $hasEHLD
## [1] FALSE
##
## $schemaClass
## [1] "Pathway"
##
## $className
## [1] "Pathway"
```

## Others

### Diagram exporter

The Reactome [diagram exporter](https://reactome.org/dev/content-service/diagram-exporter) has been mentioned a little bit in ‘Instances in Reactions’ section, here we can reconstruct a few more examples.

What’s more, Reactome offers a pathway [Analysis Service](https://reactome.org/dev/analysis) that supports enrichment and expression analysis. The diagram exporter allows you to overlay the results of the analysis on top of the exported diagrams. To do so, use the token argument to specify the unique token associated with the performed analysis.

The [ReactomeGSA](https://github.com/reactome/ReactomeGSA) package is an R client to the web-based Reactome Analysis Service, so we could perform analysis in R then access the token.

```
# Install GSA packages
# devtools::install_github("reactome/ReactomeGSA")
# devtools::install_github("reactome/ReactomeGSA.data")
library(ReactomeGSA)
library(ReactomeGSA.data)
data("griss_melanoma_proteomics")

# Create an analysis request and set parameters
my_request <- ReactomeAnalysisRequest(method = "Camera")
my_request <- set_parameters(request = my_request, max_missing_values = 0.5)
my_request <- add_dataset(request = my_request,
expression_values = griss_melanoma_proteomics,
name = "Proteomics",
type = "proteomics_int",
comparison_factor = "condition",
comparison_group_1 = "MOCK",
comparison_group_2 = "MCM",
additional_factors = c("cell.type", "patient.id"))

# Run analysis
result <- perform_reactome_analysis(request = my_request, compress = F)

# Retrieve the fold-change data for the proteomics dataset
proteomics_fc <- get_result(result, type = "fold_changes", name = "Proteomics")

# Merge the pathway level data for all result sets
combined_pathways <- pathways(result)

# Get the analysis token
token <- gsub(".*=", "", result@reactome_links[[1]][["url"]])
# select the id of the pathway with highest foldchange
id <- rownames(combined_pathways[1,])
```

We could now directly get the diagram in R:

```
exportImage(id = id, output = "diagram", format = "png", token = token, quality = 8)
```

![](data:image/png;base64...)

The output image can also saved into a file, details see `?exportImage`.

Further, **fireworks** - the overview of genome-wide, hierarchical visualization of all Reactome pathways - can be exported:

```
# Fireworks of Human Pathways
exportImage(species = "9606", output = "fireworks", format = "jpg",
token = token, fireworksCoverage = TRUE, quality = 7)
```

![](data:image/jpeg;base64...)

Full event hierarchy for any given main species in Reactome could be retrieved by function `getEventsHierarchy`, usage sees `?getEventsHierarchy`.

### Event file exporter

Reacome is also able to export Events in [SBGN](https://sbgn.github.io/) or [SBML](http://co.mbine.org/standards/sbml) format besides the pathway diagrams. `exportEventFile` could retrieve the content in specified format and save into a file. More details see `?exportEventFile`.

```
file <- exportEventFile("R-HSA-432047", format = "sbgn", writeToFile = FALSE)
```

### Species in Reactome

The list of all species in Reactome Database could be retrieved by function `getSpecies`. Moreover, you can specify `main = TRUE` to obtain the list of **main species**, those have either manually curated or computationally inferred pathways.

```
# List main species
getSpecies(main = TRUE)
```

### Person in Reactome

The function `getPerson` will return information of a person in Reactome. All attributes in a Person object see [here](https://reactome.org/content/schema/Person). For instance, to find information about Justin Cook:

```
getPerson(name = "Justin Cook")
```

```
## Matching "Justin Cook" with names in current data...
```

```
## $dbId
## [1] 9617639
##
## $displayName
## [1] "Cook, J"
##
## $firstname
## [1] "Justin"
##
## $initial
## [1] "J"
##
## $project
## [1] "Reactome"
##
## $surname
## [1] "Cook"
##
## $affiliation
##      dbId                           displayName           address
## 1 1169271 Ontario Institute for Cancer Research Toronto ON Canada
##                                          name schemaClass   className
## 1 Ontario Institute for Cancer Research, OICR Affiliation Affiliation
##
## $schemaClass
## [1] "Person"
##
## $className
## [1] "Person"
```

## Session info

```
sessionInfo()
```

```
## R version 4.1.0 (2021-05-18)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.2 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.13-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.13-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ReactomeContentService4R_1.0.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.6        knitr_1.33        magrittr_2.0.1    doParallel_1.0.16
##  [5] R6_2.5.0          jpeg_0.1-8.1      rlang_0.4.11      foreach_1.5.1
##  [9] highr_0.9         stringr_1.4.0     httr_1.4.2        tools_4.1.0
## [13] parallel_4.1.0    data.table_1.14.0 xfun_0.23         png_0.1-7
## [17] jquerylib_0.1.4   htmltools_0.5.1.1 iterators_1.0.13  yaml_2.2.1
## [21] digest_0.6.27     vctrs_0.3.8       sass_0.4.0        codetools_0.2-18
## [25] curl_4.3.1        evaluate_0.14     rmarkdown_2.8     stringi_1.6.2
## [29] compiler_4.1.0    bslib_0.2.5.1     magick_2.7.2      jsonlite_1.7.2
```