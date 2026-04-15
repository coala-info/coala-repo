---
name: bioconductor-reactomegraph4r
description: bioconductor-reactomegraph4r provides an R interface to the Reactome Graph Database for retrieving biological pathways and entities with their network structures. Use when user asks to retrieve hierarchical pathway data, find preceding or following events, identify physical entity roles, or fetch interactors and disease-related objects from Reactome.
homepage: https://bioconductor.org/packages/release/bioc/html/ReactomeGraph4R.html
---

# bioconductor-reactomegraph4r

name: bioconductor-reactomegraph4r
description: Interface for the Reactome Graph Database using Neo4j. Use this skill to retrieve biological pathways, reactions, and entities with their network structures. Ideal for hierarchical data queries, finding preceding/following events, identifying physical entity roles (catalyst, regulator, etc.), and fetching interactors or disease-related objects from Reactome.

# bioconductor-reactomegraph4r

## Overview
`ReactomeGraph4R` is an R interface for the Reactome Graph Database. Unlike `ReactomeContentService4R` (which targets specific bits of information via REST), this package is designed to retrieve data with its **network structure** intact. It interfaces with Neo4j to return data as either "row" (data frames) or "graph" (nodes and relationships) objects.

## Connection and Setup
To use the package, you must connect to a Reactome Neo4j instance (usually local).

```r
library(ReactomeGraph4R)
# Triggers interactive prompts for URL (default http://localhost:7474) and credentials
login()
```

## Basic Queries with `matchObject`
The `matchObject` function is the primary tool for fetching instances. It returns "row" data.

*   **By ID**: Supports Reactome IDs (e.g., "R-HSA-400219") or external IDs (UniProt, etc.).
    ```r
    # External ID requires databaseName or NULL to search all
    matchObject(id = "PER2", databaseName = NULL)
    ```
*   **By Name**: Requires exact `displayName` including brackets.
    ```r
    matchObject(displayName = "SUMO1:TOP1 [nucleoplasm]", species = "C. elegans")
    ```
*   **By Class**: Fetch instances of a specific schema class (e.g., "EntitySet", "Pathway").
    ```r
    matchObject(schemaClass = "EntitySet", species = "human", limit = 5)
    ```
*   **By Property**: Filter by attributes like `isChimeric` or `isInDisease`.
    ```r
    matchObject(property = list(isChimeric = TRUE, isInDisease = TRUE))
    ```

## Specialized Workflows

### Hierarchical Data
Retrieve the full context of an entity or event (Pathway -> Reaction -> PhysicalEntity).
```r
# Returns a list containing events, entities, and their relationships
matchHierarchy(id = "R-HSA-500358", type = "row")
```

### Reaction Context
Find reactions within a pathway or determine the sequence of events.
```r
# Find all reactions in the pathway associated with a specific event
matchReactionsInPathway(event.id = "R-HSA-8983688")

# Find preceding and following events (depth controls how many steps to trace)
matchPrecedingAndFollowingEvents(event.id = "R-HSA-8983688", depth = 1)
```

### Entity Roles and Interactors
Identify what a protein does in a reaction or what it interacts with.
```r
# Roles: returns if the PE is an input, output, regulator, or catalyst
matchPEroles(pe.displayName = "HSBP1 oligomer [cytosol]")

# Interactors: finds interactions via ReferenceEntity relationships
matchInteractors(pe.id = "R-HSA-419535")
```

### Referrals (Child-to-Parent)
Search in reverse (e.g., find which pathways contain a specific regulation or entity).
```r
matchReferrals(id = 6810147, type = "row")
```

## Network Visualization
To visualize results, set `type = "graph"`. This returns a list with `nodes` and `relationships` data frames compatible with visualization packages like `visNetwork` or `networkD3`.

```r
graph_data <- matchHierarchy(id = "R-HSA-500358", type = "graph")
nodes <- graph_data$nodes
edges <- graph_data$relationships

# Use unnestListCol to flatten properties for easier mapping
nodes_clean <- unnestListCol(df = nodes, column = "properties")
```

## Tips
*   **Multiple IDs**: Use `multiObjects(ids)` for batch retrieval.
*   **Attributes**: Use `returnedAttributes` in `matchObject` to limit the columns returned and improve performance.
*   **Schema**: Refer to the Reactome Data Schema (https://reactome.org/content/schema) for valid `schemaClass` names.

## Reference documentation
- [Introduction](./references/Introduction.Rmd)