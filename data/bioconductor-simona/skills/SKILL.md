---
name: bioconductor-simona
description: The simona package provides a comprehensive framework for managing, analyzing, and visualizing biological ontologies represented as directed acyclic graphs. Use when user asks to import ontology files, calculate semantic similarity between terms, determine information content, or perform DAG traversal and sub-DAG extraction.
homepage: https://bioconductor.org/packages/release/bioc/html/simona.html
---


# bioconductor-simona

## Overview
The `simona` package provides a comprehensive framework for managing and analyzing biological ontologies represented as Directed Acyclic Graphs (DAGs). It is particularly powerful for Gene Ontology (GO) analysis, offering over 70 methods for semantic similarity and information content (IC) calculations. It supports importing various formats (OBO, OWL, TTL) and provides efficient tools for DAG traversal, sub-DAG extraction, and visualization.

## Core Workflows

### 1. Constructing and Importing Ontologies
You can create a DAG from scratch, from Bioconductor's GO.db, or from external files.

```r
library(simona)

# From parent-child pairs
parents  <- c("a", "a", "b", "b", "c", "d")
children <- c("b", "c", "c", "d", "e", "f")
dag <- create_ontology_DAG(parents, children)

# From Gene Ontology (requires GO.db)
dag_go <- create_ontology_DAG_from_GO_db(namespace = "BP")

# Adding Gene Annotations (requires org.Hs.eg.db)
dag_go_anno <- create_ontology_DAG_from_GO_db(namespace = "BP", org_db = "org.Hs.eg.db")

# Importing external files
dag_obo <- import_obo("path/to/file.obo")
# import_ontology() uses ROBOT (requires Java) for OWL/JSON/TTL
```

### 2. DAG Traversal and Manipulation
Query the structure of the ontology.

```r
# Basic properties
dag_root(dag)
dag_leaves(dag)
dag_n_terms(dag)

# Relationships
dag_parents(dag, "c")
dag_children(dag, "b")
dag_ancestors(dag, "e", include_self = TRUE)
dag_offspring(dag, "b", include_self = TRUE)

# Sub-DAGs
sub_dag <- dag["b"] # Sub-DAG rooted at 'b'
sub_dag_filter <- dag_filter(dag, terms = c("a", "b", "c"))
```

### 3. Information Content (IC)
Calculate how specific a term is based on the DAG structure or annotations.

```r
# List all methods
all_term_IC_methods()

# Calculate IC (e.g., using offspring-based or annotation-based methods)
ic_off <- term_IC(dag, method = "IC_offspring")
ic_anno <- term_IC(dag_go_anno, method = "IC_annotation")
```

### 4. Semantic Similarity
Compare terms or groups of terms.

```r
# Term-to-term similarity
# Methods include: Sim_Lin_1998, Sim_Resnik_1999, Sim_Wang_2007, etc.
sim_matrix <- term_sim(dag, terms = c("term1", "term2"), method = "Sim_Lin_1998")

# Group-to-group similarity (e.g., comparing two gene sets)
group1 <- c("GO:0000001", "GO:0000002")
group2 <- c("GO:0000003", "GO:0000004")
g_sim <- group_sim(dag_go, group1, group2, method = "GroupSim_pairwise_BMA")
```

### 5. Visualization and Conversion
```r
# Convert to igraph for custom plotting
g <- dag_as_igraph(dag)

# Simplify DAG to a tree for dendrograms
tree <- dag_treelize(dag)
dend <- dag_as_dendrogram(tree)
plot(dend)
```

## Key Tips
- **Pseudo-roots**: If an ontology has multiple roots, `simona` automatically adds a pseudo-root named `"~all~"`.
- **Transitivity**: When adding annotations, `simona` recursively maps items from child terms to all ancestor terms.
- **Performance**: For large ontologies like GO, `simona` is optimized for speed. Use `term_sim` on a subset of terms rather than the whole DAG if possible.
- **Relation Types**: You can specify relation types (e.g., "is_a", "part_of") during creation or import to weight similarities differently.

## Reference documentation
For detailed method descriptions and advanced workflows, refer to:
- [ontology_DAG: a class for ontology data](./references/v01_dag.Rmd)
- [Gene Ontology](./references/v02_GO.Rmd)
- [Import ontology files](./references/v03_import.Rmd)
- [Information content](./references/v04_information_content.Rmd)
- [Term similarity](./references/v05_term_similarity.Rmd)
- [Group similarity](./references/v06_group_similarity.Rmd)