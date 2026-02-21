Package ‘metavizr’

April 12, 2018

Type Package

Version 1.2.1
Maintainer Hector Corrada Bravo <hcorrada@gmail.com>

License MIT + ﬁle LICENSE

Title R Interface to the metaviz web app for interactive metagenomics

data analysis and visualization

Description This package provides Websocket communication to the

metaviz web app (http://metaviz.cbcb.umd.edu) for interactive
visualization of metagenomics data. Objects in R/bioc
interactive sessions can be displayed in plots and data can be
explored using a facetzoom visualization. Fundamental
Bioconductor data structures are supported (e.g., MRexperiment
objects), while providing an easy mechanism to support other
data structures. Visualizations (using d3.js) can be easily
added to the web app as well.

VignetteBuilder knitr

Depends R (>= 3.3), metagenomeSeq (>= 1.17.1), methods, data.table,

Biobase, digest

Imports epivizr, epivizrData, epivizrServer, epivizrStandalone, vegan,

GenomeInfoDb, phyloseq, httr

Suggests knitr, BiocStyle, matrixStats, msd16s (>= 0.109.1), etec16s,

testthat, gss

Collate 'metavizControl.R' 'startMetaviz.R' 'utils.R'

'EpivizMetagenomicsData-class.R' 'register-methods.R'
'validateMRExperiment.R' 'MetavizApp-class.R'
'MetavizGraph-class.R'

biocViews Visualization, Infrastructure, GUI, Metagenomics

RoxygenNote 6.0.1

NeedsCompilation no

Author Hector Corrada Bravo [cre, aut],

Florin Chelaru [aut],
Justin Wagner [aut],
Jayaram Kancherla [aut],
Joseph Paulson [aut]

1

2

R topics documented:

buildMetavizGraph

.

.

.

.

.

.
.
.
.

.
.
.
.

.
.
.
.

2
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
buildMetavizGraph .
3
EpivizMetagenomicsData-class . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
generateSelection .
.
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
MetavizApp-class .
.
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
metavizControl
6
MetavizGraph-class .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
7
register,MRexperiment-method . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
register,phyloseq-method .
8
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
replaceNAFeatures .
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
setMetavizStandalone .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
startMetaviz .
9
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
.
startMetavizStandalone .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
.
.
validateObject .

.
.
.
.
.
.

.

.

.

.

.

.

.

.

Index

12

buildMetavizGraph

Build a MetavizTree object from another object

Description

Build a MetavizTree object from another object

Usage

buildMetavizGraph(object, ...)

## S4 method for signature 'MRexperiment'
buildMetavizGraph(object, feature_order, ...)

Arguments

object

...

The object from which taxonomy data is extracted

Additional arguments

feature_order Ordering of leaves (features) in taxonomy tree

Value

a MetavizGraph object

Methods (by class)

• MRexperiment: Build graph from a MRexperiment-class object

EpivizMetagenomicsData-class

3

EpivizMetagenomicsData-class

Data container for MRexperiment objects

Description

Used to serve metagenomic data (used in e.g., icicle plots and heatmaps). Wraps MRexperiment-class
objects.

Methods

df_to_tree(root, df) Helper function to recursively build nested response for getHierarchy

root Root of subtree
df data.frame containing children to process

getAlphaDiversity(measurements = NULL) Compute alpha diversity using vegan for the given

samples

measurements Samples to compute alpha diversity
start Start of feature range to query
end End of feature range to query

getCombined(measurements = NULL, seqName, start = 1, end = 1000, order = NULL, nodeSelection = NULL, selectedLevels = NULL)

Return the counts aggregated to selected nodes for the given samples

measurements Samples to get counts for
seqName name of datasource
start Start of feature range to query
end End of feature range to query
order Ordering of nodes
nodeSelection Node-id and selectionType pairs
selectedLevels Current aggregation level

get_default_chart_type() Get name of default chart type for this data type
getHierarchy(nodeId = NULL) Retrieve feature hierarchy information for subtree with speciﬁed

root

nodeId Feature identiﬁer with level info

get_measurements() Get description of measurements served by this object
getPCA(measurements = NULL) Compute PCA over all features for given samples

measurements Samples to compute PCA over
start Start of feature range to query
end End of feature range to query

getRows(measurements = NULL, start = 1, end = 1000, selectedLevels = 3, selections = NULL)

Return the sample annotation and features within the speciﬁed range and level for a given sam-
ple and features

measurements Samples to retrieve for
start Start of feature range to query
end End of feature range to query
selections Node-id and selectionType pairs

4

generateSelection

selectedLevels Current aggregation level

getValues(measurements = NULL, start = 1, end = 1000, selectedLevels = 3, selections = NULL, row_order = NULL)

Return the counts for a sample within the speciﬁed range

measurements Samples to get counts for
start Start of feature range to query
end End of feature range to query
selections Node-id and selectionType pairs
selectedLevels Current aggregation level

propagateHierarchyChanges(selection = NULL, order = NULL, selectedLevels = NULL, request_with_labels = FALSE)

Update internal state for hierarchy

selection Node-id and selectionType pairs
order Ordering of features
selectedLevels Current aggregation level
request_with_labels For handling requests using fData entries from MRexperiment
row_to_dict(row) Helper function to format each node entry for getHierarchy response

row Information for current node.

searchTaxonomy(query = NULL, max_results = 15) Return list of features matching a text-

based query

query String of feature for which to search
max_results Maximum results to return

toNEO4JDbHTTP(batch_url, neo4juser, neo4jpass, datasource, description = NULL) Write

an ‘EpivizMetagenomicsData‘ object to a Neo4j graph database
@param batch_url (character) Neo4j database url and port for processing batch http requests
@param neo4juser (character) Neo4j database user name @param neo4jpass (character) Neo4j
database password @param datasource (character) Name of Neo4j datasource node for this
‘EpivizMetagenomicsData‘ object
@examples library(metagenomeSeq) data("mouseData") mobj <- metavizr:::EpivizMetagenomicsData$new(object=mouseData)
mobj$toNEO4JDbHTTP(batch_url = "http://localhost:7474/db/data/batch", neo4juser = "neo4juser",
neo4jpass = "neo4jpass", datasource = "mouse_data")

update(new_object, send_request = TRUE) Update underlying data object with new object

Examples

library(metagenomeSeq)
data(mouseData)
obj <- metavizr:::EpivizMetagenomicsData$new(mouseData, feature_order = colnames(fData(mouseData)))

generateSelection

Method to select and set aggregation type to nodes in FacetZoom

Description

Method to select and set aggregation type to nodes in FacetZoom

MetavizApp-class

Usage

5

generateSelection(feature_names, aggregation_level, selection_type,

feature_order = NULL)

Arguments

feature_names
aggregation_level

Selected Features

Level in the hierarchy

selection_type Expanded, aggregated, or removed
feature_order Order of features at that level

Value

A selection object for a metavizControl object to accept

Examples

generateSelection("Bacteroidales", 1L, 2L)

MetavizApp-class

Class managing connection to metaviz application.

Description

Class managing connection to metaviz application.

metavizControl

metavizr settings

Description

Default settings for the various plotting functions in metavizr.

Usage

metavizControl(aggregateAtDepth = 3, aggregateFun = function(x) colSums(x),

valuesAnnotationFuns = NULL, maxDepth = 4, maxHistory = 3,
maxValue = NULL, minValue = NULL, title = "", n = 10000,
rankFun = stats::sd, norm = TRUE, log = FALSE,
featureSelection = NULL)

6

Arguments

aggregateAtDepth

MetavizGraph-class

Level of the tree to aggregate counts at by default.

aggregateFun

Function to aggregate counts by at the aggregateAtDepth level.

valuesAnnotationFuns

Function for error bars.

maxDepth

maxHistory

maxValue

minValue

title

n

rankFun

norm

log

Level of the tree to display by default in icicle view.

Value for caching.

Maximum value to display.

Minimum value to display.

title.

Number of OTUs to include in ranking.

Ranking function - single vector function.

Normalize MRexperiment object.

Log tranformation of MRexperiment object.

featureSelection

List of features to set as nodeSelections

Value

List of setting parameters.

Examples

settings = metavizControl()

MetavizGraph-class

Graph implementation to query hierarchical feature data

Description

Used to manage aggregation and range queries from the Metaviz app UI.

register,MRexperiment-method

7

register,MRexperiment-method

Generic method to register data to the epiviz data server

Description

Generic method to register data to the epiviz data server

Usage

## S4 method for signature 'MRexperiment'
register(object, columns = NULL, ...)

Arguments

object

columns

...

Value

The object to register to data server

Name of columns containing data to register

Additonal arguments passed to object constructors

An EpivizMetagenomicsData-class object

register,phyloseq-method

Generic method to register data to the epiviz data server

Description

Generic method to register data to the epiviz data server

Usage

## S4 method for signature 'phyloseq'
register(object, columns = NULL, ...)

Arguments

object

columns

...

Value

The object to register to data server

Name of columns containing data to register

Additonal arguments passed to object constructors

An phyloseq-class object

8

setMetavizStandalone

Method
Not_Annotated_hierarchy-level

replace NA

to

or

null

feature

labels with

replaceNAFeatures

Description

Method to replace NA or null feature labels with Not_Annotated_hierarchy-level

Usage

replaceNAFeatures(replacing_na_obj_fData, feature_order)

Arguments

replacing_na_obj_fData

fData from MRexperiment object to replace NA or null

feature_order Order of features

Value

hierarchy with NA or null feature labels replaced

setMetavizStandalone

set metaviz app standalone settings

Description

set metaviz app standalone settings

Usage

setMetavizStandalone(url = "https://github.com/epiviz/epiviz.git",

branch = "metaviz-4.1", local_path = NULL, non_interactive = FALSE)

Arguments

url

branch

local_path

non_interactive

(character) github url to use. defaults to ("https://github.com/epiviz/epiviz.
git").

(character) branch on the github repository. defaults to (master).

(character) if you already have a local instance of metaviz and would like to run
standalone use this.

(logical) don’t download repo, used for testing purposes.

Value

path to the metaviz app git repository

startMetaviz

Examples

# see package vignette for example usage
# setMetavizStandalone()

9

startMetaviz

Start metaviz app and create MetavizApp object to manage connec-
tion.

Description

Start metaviz app and create MetavizApp object to manage connection.

Usage

startMetaviz(host = "http://metaviz.cbcb.umd.edu",

register_function = .register_all_metaviz_things, ...)

Arguments

host

(character) host address to launch.

register_function

(function) function used to register actions and charts on the metaviz app.

...

additional parameters passed to startEpiviz.

Value

An object of class MetavizApp

See Also

MetavizApp

Examples

# see package vignette for example usage
app <- startMetaviz(non_interactive=TRUE, open_browser=FALSE)
app$stop_app()

10

validateObject

startMetavizStandalone

Start metaviz app in standalone (locally) and create MetavizApp ob-
ject to manage connection.

Description

Start metaviz app in standalone (locally) and create MetavizApp object to manage connection.

Usage

startMetavizStandalone(register_function = .register_all_metaviz_things,

use_viewer_option = FALSE, ...)

Arguments

register_function

use_viewer_option

(function) function used to register actions and charts on the metaviz app.

(function) run application in viewer deﬁned by getOption("viewer"). This
allows standalone app to run in Rstudio’s viewer (FALSE by default)
additional parameters passed to startStandalone.

...

Value

An object of class MetavizApp

Examples

# see package vignette for example usage
app <- startMetavizStandalone(non_interactive=TRUE)
app$stop_app()

validateObject

validate MRexperiment-class object

Description

validate MRexperiment-class object

Usage

validateObject(object)

Arguments

object

an object of class MRexperiment-class

validateObject

Value

TRUE or FALSE

Examples

library(metagenomeSeq)
data(mouseData)
validateObject(mouseData)

11

Index

buildMetavizGraph, 2
buildMetavizGraph,MRexperiment-method
(buildMetavizGraph), 2

EpivizMetagenomicsData

(EpivizMetagenomicsData-class),
3

EpivizMetagenomicsData-class, 3

generateSelection, 4

MetavizApp, 9, 10
MetavizApp (MetavizApp-class), 5
MetavizApp-class, 5
metavizControl, 5
MetavizGraph, 2
MetavizGraph (MetavizGraph-class), 6
MetavizGraph-class, 6
MRexperiment-class, 10

register,MRexperiment-method, 7
register,phyloseq-method, 7
replaceNAFeatures, 8

setMetavizStandalone, 8
startEpiviz, 9
startMetaviz, 9
startMetavizStandalone, 10
startStandalone, 10

validateObject, 10

12

