Package ‘NCIgraphData’

February 26, 2026

Title Data for the NCIgraph software package

Version 1.46.0

Created 2011-04-01

Author Laurent Jacob

Maintainer Laurent Jacob <laurent.jacob@gmail.com>

Description Provides pathways from the NCI Pathways Database as R graph objects

License GPL-3

LazyData yes

Depends R (>= 2.10.0)

Suggests Rgraphviz

biocViews NCI

git_url https://git.bioconductor.org/packages/NCIgraphData

git_branch RELEASE_3_22

git_last_commit d0095e6

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1
2

3

Raw NCI networks from Nature curated pathways and BioCarta im-
ported as graphNEL objects

NCI.cyList
.
reactome.cyList .

.

.

Index

NCI.cyList

Description

A list of graphNEL objects read from Cytoscape using the CytoscapeRPC Cytoscape plugin in
combination with the RCytoscape bioconductor package. This list contains 460 of the NCI-Nature
curated and BioCarta imported pathways of the NCI PID.

1

reactome.cyList

2

Usage

NCI.cyList

Format

A list of 460 graphNEL objects.

Author(s)

Laurent Jacob

Examples

data("NCI-cyList")
length(NCI.cyList)

library(Rgraphviz)
plot(NCI.cyList[[1]])

reactome.cyList

Raw NCI networks from reactome as graphNEL objects

Description

A list of graphNEL objects read from Cytoscape using the CytoscapeRPC Cytoscape plugin in
combination with the RCytoscape bioconductor package. This list contains 487 of the Reactome
pathways of the NCI PID.

Usage

reactome.cyList

Format

A list of 460 graphNEL objects.

Author(s)

Laurent Jacob

Examples

data("reactome-cyList")
length(reactome.cyList)

library(Rgraphviz)
plot(reactome.cyList[[1]])

Index

∗ datasets

NCI.cyList, 1
reactome.cyList, 2

NCI.cyList, 1

reactome.cyList, 2

3

